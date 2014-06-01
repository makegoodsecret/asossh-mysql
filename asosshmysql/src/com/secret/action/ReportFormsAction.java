package com.secret.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;

import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.secret.chart.ExcelDataMethod;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.pojo.SortPojo;
import com.secret.service.GoodsOrderService;
import com.secret.service.HotelService;
import com.secret.service.MealService;
import com.secret.service.SortService;
//餐厅的报表管理
public class ReportFormsAction extends  ActionSupport {
	private HotelService   hotelService  ;
	private SortService  sortService;
	private HotelPojo   hotelPojo ;
	private SortPojo    sortPojo ;
	private MealPojo    mealPojo;
	private GoodsOrderPojo  goodsOrderPojo ;
	private GoodsInfoPojo   goodsInfoPojo;
	private List<HotelPojo> hotelList ;
    private List<SortPojo> sortList ;
    private GoodsOrderService goodsOrderService ;
    /**
     * 导出Excel
     * */
    private String   filePath  ;	//从下载展示页面展现出的项目下文件保存的路径及下载路径
	private String 	 filename;      //定义从下传文件时保存的文件名
	private String   contentType;	//定义要下载的文件类型
	private InputStream inputStream ;//定义流
	
	/**
	 * 从数据库中导出一周的销量Excel
	 * @throws IOException 
	 * @throws WriteException 
	 * @throws RowsExceededException 
	 */
	public String exportweekExcel() {
		try {
		contentType ="/xls";
		String wherejpql    ;
		if (null != goodsInfoPojo) {
			  wherejpql  = " o.goodsInfoPojo.goodsId=? and o.tradeStatus in (?,?,?) and substr(to_char(o.orderTime,'yyyy-mm-dd'),1,10)=?  ";
				filename = new String(hotelPojo.getHotelName().getBytes("ISO-8859-1"),"UTF-8")
				  			+"-"+new String(goodsInfoPojo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8")+"一周销量报表.xls";
			  filePath = "/excel/"+filename;
			  new ExcelDataMethod().excelMethod(goodsInfoPojo.getGoodsId(), wherejpql, 
					  				new String(goodsInfoPojo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8"), 7, goodsOrderService, filePath);
		}else if(null != sortPojo){
			  wherejpql  = " o.goodsInfoPojo.sortPojo.sortId=? and o.tradeStatus in (?,?,?) and substr(to_char(o.orderTime,'yyyy-mm-dd'),1,10)=? ";
			  filename= new String(hotelPojo.getHotelName().getBytes("ISO-8859-1"),"UTF-8")
			  			+"-"+new String(sortPojo.getSortName().getBytes("ISO-8859-1"),"UTF-8")+"一周销量报表.xls";
			  filePath = "/excel/"+filename;
			  new ExcelDataMethod().excelMethod(sortPojo.getSortId(), wherejpql, 
					  	new String(sortPojo.getSortName().getBytes("ISO-8859-1"),"UTF-8"), 7, goodsOrderService, filePath);
		}else if(null != mealPojo){
			  wherejpql  = " o.mealPojo.mealId=? and o.tradeStatus in (?,?,?) and substr(to_char(o.orderTime,'yyyy-mm-dd'),1,10)=?";
			  filename=new String(hotelPojo.getHotelName().getBytes("ISO-8859-1"),"UTF-8")
			  			+"-"+new String(mealPojo.getMealName().getBytes("ISO-8859-1"),"UTF-8")+"一周销量报表.xls";
			  filePath = "/excel/"+filename;
			  new ExcelDataMethod().excelMethod(mealPojo.getMealId(), wherejpql, 
					  new String(mealPojo.getMealName().getBytes("ISO-8859-1"),"UTF-8"), 7, goodsOrderService, filePath);
		}
		} catch (Exception e) {
			e.printStackTrace();
		}
		 return "exportsuccess";
	}
    

	/**
	 * 进入报表管理界面
	 * @return
	 */
	public String  reportLoggers(){
		hotelList = hotelService.findProperty("hotelId", hotelPojo.getHotelId());
		if (hotelList.size()!=0) {
			hotelPojo = hotelList.get(0);
			sortList = sortService.findProperty("hotelPojo.hotelId", hotelPojo.getHotelId());
			return "reportForms";
		}else{
			return "globalrequestIsExist";
		}
	}
	 
	 

	public MealPojo getMealPojo() {
		return mealPojo;
	}


	public void setMealPojo(MealPojo mealPojo) {
		this.mealPojo = mealPojo;
	}


	public GoodsInfoPojo getGoodsInfoPojo() {
		return goodsInfoPojo;
	}


	public void setGoodsInfoPojo(GoodsInfoPojo goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}


	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}


	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}


	public String getFilePath() {
		return filePath;
	}


	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}


	public String getFilename() throws UnsupportedEncodingException {
		return new String(filename.getBytes(),"ISO-8859-1");
	}

	public void setFilename(String filename) throws UnsupportedEncodingException {
		filename = new String(filename.getBytes("ISO-8859-1"),"UTF-8");
		this.filename = filename;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public InputStream getInputStream() {
		return ServletActionContext.getServletContext().getResourceAsStream(filePath);
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public HotelService getHotelService() {
		return hotelService;
	}
	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public List<HotelPojo> getHotelList() {
		return hotelList;
	}
	public void setHotelList(List<HotelPojo> hotelList) {
		this.hotelList = hotelList;
	}
	public SortService getSortService() {
		return sortService;
	}
	public void setSortService(SortService sortService) {
		this.sortService = sortService;
	}
	public List<SortPojo> getSortList() {
		return sortList;
	}
	public void setSortList(List<SortPojo> sortList) {
		this.sortList = sortList;
	}


	public SortPojo getSortPojo() {
		return sortPojo;
	}


	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}


	public GoodsOrderPojo getGoodsOrderPojo() {
		return goodsOrderPojo;
	}


	public void setGoodsOrderPojo(GoodsOrderPojo goodsOrderPojo) {
		this.goodsOrderPojo = goodsOrderPojo;
	}

	
	
	
}
