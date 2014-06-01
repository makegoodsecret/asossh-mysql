package com.secret.action;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.Action;
import com.secret.page.base.PageView;
import com.secret.pojo.GoodsImagePojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.SortPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsImageService;
import com.secret.service.GoodsInfoService;
import com.secret.service.HotelService;
import com.secret.service.SortService;
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
public class GoodsAction extends BaseAction  {
	private GoodsInfoService goodsInfoService;
	private GoodsInfoPojo  goodsPojo ;
	private SortService   sortService;
	private SortPojo    sortPojo;
	private HotelService    hotelService;
	private HotelPojo  hotelPojo;
	private GoodsImageService goodsImageService;
	private GoodsImagePojo   goodsImagePojo;
	private ServletRequest  request;
	private HttpServletResponse response =   ResponseSetCharacterEncoding.getInstance();
	private HttpSession  session;
	
	//条件查询
	
	//分页
	private int maxResultPage ;    				//设置，每页显示的最大显示数
	private PageView<GoodsInfoPojo>  pageView;	//分页处理后的数据
	//封装输出结果的二进制流
	private  InputStream  inputStream  ;
	
	
	//分页查询出全部
	//首次进入商品管理页(区分管理员与普通饭店管理员)
	public String  showGoods(){
		this.setMaxResultPage(5);			//设置默认页数
		getMaxandPage(5 ,0);
		return "showGoods";
	}
	//根据id删除
	public String deleteId(){
		boolean delete = goodsInfoService.delete(2);
		
		return  "deleteId";
	}
	//保存美食的图片
		public void   savegoodsimage(){
			String image = super.saveimage();
			try {
				PrintWriter out = response.getWriter();
				out.print(image);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 修改美食的图片
		public void updatagoodsimage(){
			String image = super.updateimage();
			try {
				PrintWriter out = response.getWriter();
				out.print(image);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	
	
	//保存物品
	public String save(){
			session=ServletActionContext.getRequest().getSession();
			goodsImagePojo.setGimageTime(new Timestamp(new Date().getTime()));
			//保存饭店信息
			hotelPojo = hotelService.findProperty("hotelName", hotelPojo.getHotelName()).get(0);
			goodsPojo.setHotelPojo(hotelPojo);
			//保存商品类别
			List<SortPojo> sortlist=sortService.findDoubleProperty("sortName", sortPojo.getSortName(), "hotelPojo.hotelName", hotelPojo.getHotelName());
			goodsPojo.setSortPojo(sortlist.get(0));
			goodsPojo.setGoodsTime(new Timestamp(new Date().getTime()));
			//创建者的id,管理员创建为0
			 UserPojo userpojo = (UserPojo) session.getAttribute("user");
			 goodsPojo.setUserId(userpojo.getUserId());
			 goodsImagePojo.setGoodsInfoPojo(goodsPojo);
			 goodsPojo.setGoodsImagePojo(goodsImagePojo);
			 goodsInfoService.merge(goodsPojo);
			 showGoods();
		 
		return "showGoods";
	}
	//进入修改美食
	public String showupdategoods(){
		  goodsPojo = (GoodsInfoPojo) goodsInfoService.findProperty("goodsId",goodsPojo.getGoodsId()).get(0);
	 return "showupdategoods";
	}
	//修改美食
		public String updatagoods(){
					GoodsInfoPojo goods = (GoodsInfoPojo) goodsInfoService.findProperty("goodsId",goodsPojo.getGoodsId()).get(0);
					goods.setGoodsName(goodsPojo.getGoodsName());
					goods.setGoodsDis(goodsPojo.getGoodsDis());
					goods.setGoodsPrice(goodsPojo.getGoodsPrice());
					goods.setGoodsTime(new Timestamp(new Date().getTime()));
					goodsInfoService.update(goods);
					getMaxandPage(5,0);
					goodsPojo.setGoodsName("");
			return "showGoods";
			 
		}
	//查询与分页
		public String goodsPaging(){
			this.getMaxPage(this.getMaxResultPage(),super.getPage());
			return  "showGoods";
		}
		//分页模糊查询
		private void getMaxPage(int page ,int getPage) {
			session=ServletActionContext.getRequest().getSession();
			UserPojo userPojo = (UserPojo) session.getAttribute("user");
			String  hql ;
			Object [] obj;
			if(userPojo.getPower().equals("1")){
				//管理员进入
				   hql  =" o.goodsName=? or o.goodsDis=? ";
				  List<SortPojo> sortNamelist ;
					if (goodsPojo.getSortPojo().getSortName().equals("按套餐查询")) {
						hql  =" o.goodsName like ? and o.goodsDis like ? ";
						obj  = new Object []{"%"+goodsPojo.getGoodsName()+"%","%"+goodsPojo.getGoodsName()+"%"};
					}else{
						List<Object> asList = new ArrayList<Object>();
						if (goodsPojo.getGoodsName().equals("")) {//没有美食查询
							sortNamelist = sortService.findProperty("sortName", goodsPojo.getSortPojo().getSortName());
							hql=" o.sortPojo= ? ";
							asList.add(sortNamelist.get(0));
							if (sortNamelist.size()!=0){//套餐在不同饭店的多条记录
								for (int i=1; i<sortNamelist.size();i++) {
									hql+=" or o.sortPojo= ? ";
									asList.add(sortNamelist.get(i));
								}
							}
						}else{
							hql="o.goodsName like ?  and o.sortPojo.sortName =?";
							asList.add("%"+goodsPojo.getGoodsName()+"%");
							asList.add(goodsPojo.getSortPojo().getSortName());
						}
						obj  =asList.toArray();
					}  
				pageView=new PageView<GoodsInfoPojo>(page, getPage);
				pageView.setQueryResult(goodsInfoService.getScrollData(pageView.getFirstResult(), page, hql, obj));
			}else if(userPojo.getEmailstatu().equals("2")){
				//普通饭店管理员登录
				//分类
				hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
				List<SortPojo> sortNamelist = sortService.findDoubleProperty("hotelPojo", hotelPojo,"sortName", goodsPojo.getSortPojo().getSortName());
				if (goodsPojo.getSortPojo().getSortName().equals("按套餐查询")) {
					hql  ="o.hotelPojo.hotelId= ? and o.goodsName like ? and o.goodsDis like ? ";
					obj  = new Object []{hotelPojo.getHotelId(),"%"+goodsPojo.getGoodsName()+"%","%"+goodsPojo.getGoodsName()+"%"};
				}else{
					if (sortNamelist.size()!=0) sortPojo=sortNamelist.get(0);
					hql  ="o.hotelPojo.hotelId= ? and o.goodsName like ? and o.goodsDis like ?  and o.sortPojo= ?";
					obj  = new Object []{hotelPojo.getHotelId(),"%"+goodsPojo.getGoodsName()+"%","%"+goodsPojo.getGoodsName()+"%",sortPojo};
				}
				pageView = new PageView<GoodsInfoPojo>(page, getPage);
				pageView.setQueryResult(goodsInfoService.getScrollData(pageView.getFirstResult(), page, hql, obj));
			}
	}
		//封装分页的最大显示数与 记住第几页
		public void getMaxandPage(int page ,int getPage){
			session=ServletActionContext.getRequest().getSession();
			UserPojo userPojo = (UserPojo) session.getAttribute("user");
			if(userPojo.getPower().equals("1")){
				//管理员进入
				pageView = new PageView<GoodsInfoPojo>(page,getPage);
				pageView.setQueryResult(goodsInfoService.getScrollData(pageView.getFirstResult(), page));
			}else if(userPojo.getEmailstatu().equals("2")){
				//普通饭店管理员登录
				//首先查询出该员工所在的饭店
				String  hql  ="o.hotelPojo.hotelId=?";
				Object [] obj  = {hotelPojo.getHotelId()};
				pageView=new PageView<GoodsInfoPojo>(page, getPage);
				pageView.setQueryResult(goodsInfoService.getScrollData(pageView.getFirstResult(), page, hql, obj));
			}
		}
	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}
	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}
	public GoodsInfoPojo getGoodsPojo() {
		return goodsPojo;
	}
	public void setGoodsPojo(GoodsInfoPojo goodsPojo) {
		this.goodsPojo = goodsPojo;
	}
	public SortService getSortService() {
		return sortService;
	}


	public void setSortService(SortService sortService) {
		this.sortService = sortService;
	}
	public int getMaxResultPage() {
		maxResultPage = maxResultPage <=0 ? 5 :maxResultPage ;
		return maxResultPage;
	}


	public void setMaxResultPage(int maxResultPage) {
		maxResultPage = maxResultPage <=0 ? 5 :maxResultPage ;
		this.maxResultPage = maxResultPage;
	}

	public GoodsImageService getGoodsImageService() {
		return goodsImageService;
	}

	public void setGoodsImageService(GoodsImageService goodsImageService) {
		this.goodsImageService = goodsImageService;
	}

	public GoodsImagePojo getGoodsImagePojo() {
		return goodsImagePojo;
	}

	public void setGoodsImagePojo(GoodsImagePojo goodsImagePojo) {
		this.goodsImagePojo = goodsImagePojo;
	}

	
	public PageView<GoodsInfoPojo> getPageView() {
		return pageView;
	}


	public void setPageView(PageView<GoodsInfoPojo> pageView) {
		this.pageView = pageView;
	}


	public InputStream getInputStream() {
		return inputStream;
	}

	public void setInputStream(InputStream inputStream) {
		this.inputStream = inputStream;
	}

	public SortPojo getSortPojo() {
		return sortPojo;
	}

	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
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

	public ServletRequest getRequest() {
		return request;
	}

	public void setRequest(ServletRequest request) {
		this.request = request;
	}


	public HttpSession getSession() {
		return session;
	}


	public void setSession(HttpSession session) {
		this.session = session;
	}

	
	
	
	
}
