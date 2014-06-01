package com.secret.action;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.AdsPojo;
import com.secret.pojo.GoodsAssessPojo;
import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsImagePojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.RecommendPojo;
import com.secret.pojo.SortPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.AdsService;
import com.secret.service.GoodsAssessService;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsInfoService;
import com.secret.service.HotelService;
import com.secret.service.RecommendService;
import com.secret.service.SortService;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class IndexAction extends BaseAction {
	//配置事务
	private AdsService  adsService;						//开启广告事务
	private  RecommendService recommendService  ;		//开启每日推荐的事务
	private  SortService sortService   ;				//开启美食种类的事务
	private  GoodsCartService  goodsCartService;		//开启顾客的购物车
	private  HotelService    hotelService  ;			//开启饭店的事务
	private  GoodsInfoService   goodsInfoService ;
	private GoodsAssessService  goodsAssessService  ;
	//创建实体类
	private AdsPojo adsPojo  ;
	private GoodsImagePojo  goodsImagePojo ;
	private RecommendPojo   recommendPojo  ;
	private SortPojo sortPojo  ;
	
	//创建结果集
	private List<AdsPojo>  adsList ;
	private List<RecommendPojo>  recommendList ;
	private List<SortPojo>		sortPojoList   ;
	private List<GoodsCartPojo>  goodsCartPojosList;
	private List<GoodsInfoPojo>  goodsInfoPojoList;
	private List<GoodsAssessPojo> goodsAssessList ;
	
	//获取当前用户的位置
	private double userlat   ;   //获取用户的纬度
	private double userlon ;     //获取用户的经度
	
	private Map<List<HotelPojo>, List<Double>> distancemap; //  通过gps得到饭店的信息
	
	//进入首页启动事务
	public String showIndex(){
		this.showAds();				//显示广告
		this.showRecommend(); 		//显示每日推荐
		this.showSort() ;			//美食种类的事务
		this.showGoods();			//显示美食的事务
		this.showCart();			//显示我的购物车
		this.latelytrade();         //显示最近的购物记录
		this.gpshotelmsg() ;        //通过GPS得到饭店的信息
		return  "success";
	}
	//通过GPS得到饭店的信息
	private void gpshotelmsg() {
		distancemap = hotelService.distancesize(userlat, userlon,10);
	}

	//广告的具体事务
	private  void showAds(){
		adsList = adsService.findAll();
	}
	
	//每日推荐的事务
	private void showRecommend(){
		recommendList=recommendService.findAll();
	}
	
	//美食种类的事务
	private void showSort(){
		sortPojoList=sortService.findAll();
	}
	 
	//美食显示的事务
	private void showGoods(){
	 	LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
	 	orderby.put("goodsTime", "desc");
	 	goodsInfoPojoList=goodsInfoService.selectHomeGoods(orderby, 10);
	}
	 
	//显示购物车
	private void showCart(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		UserPojo  userPojo=(UserPojo)session.getAttribute("user");
		if (userPojo!=null&&userPojo.getUserId()>0) {
			goodsCartPojosList=goodsCartService.findProperty("userPojo.userId", userPojo.getUserId());
		}
	}
	//最近交易
	private void latelytrade(){
		 goodsAssessList = goodsAssessService.findascordescProperty("assTime", "desc");
	}
	
	public HotelService getHotelService() {
		return hotelService;
	}

	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}

	public AdsService getAdsService() {
		return adsService;
	}
	public void setAdsService(AdsService adsService) {
		this.adsService = adsService;
	}
	 
	public RecommendService getRecommendService() {
		return recommendService;
	}
	public void setRecommendService(RecommendService recommendService) {
		this.recommendService = recommendService;
	}
	public SortService getSortService() {
		return sortService;
	}
	public void setSortService(SortService sortService) {
		this.sortService = sortService;
	}
	public AdsPojo getAdsPojo() {
		return adsPojo;
	}
	public void setAdsPojo(AdsPojo adsPojo) {
		this.adsPojo = adsPojo;
	}
	public GoodsImagePojo getGoodsImagePojo() {
		return goodsImagePojo;
	}
	public void setGoodsImagePojo(GoodsImagePojo goodsImagePojo) {
		this.goodsImagePojo = goodsImagePojo;
	}
	public RecommendPojo getRecommendPojo() {
		return recommendPojo;
	}
	public void setRecommendPojo(RecommendPojo recommendPojo) {
		this.recommendPojo = recommendPojo;
	}
	
 
	public GoodsAssessService getGoodsAssessService() {
		return goodsAssessService;
	}

	public void setGoodsAssessService(GoodsAssessService goodsAssessService) {
		this.goodsAssessService = goodsAssessService;
	}

	public List<GoodsAssessPojo> getGoodsAssessList() {
		return goodsAssessList;
	}

	public void setGoodsAssessList(List<GoodsAssessPojo> goodsAssessList) {
		this.goodsAssessList = goodsAssessList;
	}

	public SortPojo getSortPojo() {
		return sortPojo;
	}
	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}
	public List<AdsPojo> getAdsList() {
		return adsList;
	}
	public void setAdsList(List<AdsPojo> adsList) {
		this.adsList = adsList;
	}
	 
	public List<RecommendPojo> getRecommendList() {
		return recommendList;
	}
	public void setRecommendList(List<RecommendPojo> recommendList) {
		this.recommendList = recommendList;
	}
	public List<SortPojo> getSortPojoList() {
		return sortPojoList;
	}
	public void setSortPojoList(List<SortPojo> sortPojoList) {
		this.sortPojoList = sortPojoList;
	}
 
	public GoodsCartService getGoodsCartService() {
		return goodsCartService;
	}

	public void setGoodsCartService(GoodsCartService goodsCartService) {
		this.goodsCartService = goodsCartService;
	}

	public List<GoodsCartPojo> getGoodsCartPojosList() {
		return goodsCartPojosList;
	}

	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}

	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}

	public List<GoodsInfoPojo> getGoodsInfoPojoList() {
		return goodsInfoPojoList;
	}

	public void setGoodsInfoPojoList(List<GoodsInfoPojo> goodsInfoPojoList) {
		this.goodsInfoPojoList = goodsInfoPojoList;
	}

	public void setGoodsCartPojosList(List<GoodsCartPojo> goodsCartPojosList) {
		this.goodsCartPojosList = goodsCartPojosList;
	}

	public double getUserlat() {
		return userlat;
	}
	public void setUserlat(double userlat) {
		this.userlat = userlat;
	}
	public double getUserlon() {
		return userlon;
	}
	public void setUserlon(double userlon) {
		this.userlon = userlon;
	}
	public Map<List<HotelPojo>, List<Double>> getDistancemap() {
		return distancemap;
	}
	public void setDistancemap(Map<List<HotelPojo>, List<Double>> distancemap) {
		this.distancemap = distancemap;
	}
	
	
	
	
	
}
