package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsAssessPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsAssessService;
import com.secret.service.GoodsInfoService;
import com.secret.service.GoodsOrderService;
import com.secret.service.HotelService;
import com.secret.service.MealService;
import com.secret.util.FinalStatus;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class GoodsAssessAction extends BaseAction {
	private GoodsAssessService   goodsAssessService ;
	private  GoodsAssessPojo   goodsAssessPojo ;
	private GoodsInfoService  goodsInfoService  ;
	private MealService    mealService ;
	private GoodsOrderService  goodsOrderService ;
	private GoodsOrderPojo  goodsOrderPojo;
	private List<GoodsOrderPojo> goodsOrderlist;
	private HotelService   hotelService ;
	private HttpServletResponse response =   ResponseSetCharacterEncoding.getInstance();
	
	public void savegoodsAssess(){
		try {
			UserPojo userPojo=(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			goodsAssessPojo.setUserPojo(userPojo);
			goodsAssessPojo.setAssTime(new Timestamp(new Date().getTime()));
			goodsAssessPojo.setAssIp(ServletActionContext.getRequest().getLocalAddr());
			goodsOrderlist = goodsOrderService.findProperty("alipayTradeNo", goodsOrderPojo.getAlipayTradeNo());
			for (GoodsOrderPojo goodsOrderPojo : goodsOrderlist) {
				goodsAssessPojo.setGoodsOrderPojo(goodsOrderPojo);
				if (goodsOrderPojo.getGoodsInfoPojo()!=null) {
					goodsAssessPojo.setGoodsInfoPojo(goodsOrderPojo.getGoodsInfoPojo());
					goodsAssessPojo.setHotelPojo(goodsOrderPojo.getHotelPojo());
					goodsAssessService.merge(goodsAssessPojo);
				}else{
					goodsAssessPojo.setMealPojo(goodsOrderPojo.getMealPojo());
					goodsAssessPojo.setHotelPojo(goodsOrderPojo.getHotelPojo());
					goodsAssessService.merge(goodsAssessPojo);
				}
				goodsOrderPojo.setTradeStatus(FinalStatus.USER_ASSESS_SUCCESS);  //修改为用户成功评价
				goodsOrderService.merge(goodsOrderPojo);
			}
			 //更改饭店的等级
			List<GoodsAssessPojo> goodsAssessfindAll = goodsAssessService.findProperty("hotelPojo", goodsAssessPojo.getHotelPojo());
			int sumLevel =0;
			double hotelLevel = 0;
			if (goodsAssessfindAll.size()==0) {
				hotelLevel=1.0D;
			}else{
				for (GoodsAssessPojo goodsAssessPojo : goodsAssessfindAll) {
					sumLevel+=goodsAssessPojo.getAssStars();
				}
				hotelLevel =sumLevel/5*goodsAssessfindAll.size(); 
			}
			 hotelLevel= Double.parseDouble(String.format("%10.2f%n", hotelLevel));  //保留两位小数
			 HotelPojo hotelPojo = hotelService.findProperty("hotelId", goodsAssessPojo.getHotelPojo().getHotelId()).get(0);
			 hotelPojo.setHotelLevel(hotelLevel);
			 boolean update = hotelService.update(hotelPojo);  
			PrintWriter  out  = response.getWriter();
			if (update) {
				out.print(1);
			}else{
				out.print(0);
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//进入评价页面
	public String  userasess(){
		   goodsOrderlist = goodsOrderService.findProperty("alipayTradeNo", goodsOrderPojo.getAlipayTradeNo());
		
		 
		 return "userasess";
	}
	//进入显示评价列表页面包含未评价的
	public String  showuserasess(){
		
		return "showuserasess";
	}
	public GoodsAssessService getGoodsAssessService() {
		return goodsAssessService;
	}
	public void setGoodsAssessService(GoodsAssessService goodsAssessService) {
		this.goodsAssessService = goodsAssessService;
	}
	public GoodsAssessPojo getGoodsAssessPojo() {
		return goodsAssessPojo;
	}
	public void setGoodsAssessPojo(GoodsAssessPojo goodsAssessPojo) {
		this.goodsAssessPojo = goodsAssessPojo;
	}
	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}
	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}
	public MealService getMealService() {
		return mealService;
	}
	public void setMealService(MealService mealService) {
		this.mealService = mealService;
	}


	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}


	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}


	public GoodsOrderPojo getGoodsOrderPojo() {
		return goodsOrderPojo;
	}


	public void setGoodsOrderPojo(GoodsOrderPojo goodsOrderPojo) {
		this.goodsOrderPojo = goodsOrderPojo;
	}
	public List<GoodsOrderPojo> getGoodsOrderlist() {
		return goodsOrderlist;
	}
	public void setGoodsOrderlist(List<GoodsOrderPojo> goodsOrderlist) {
		this.goodsOrderlist = goodsOrderlist;
	}
	public HotelService getHotelService() {
		return hotelService;
	}
	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}
	
	
	
	
}
