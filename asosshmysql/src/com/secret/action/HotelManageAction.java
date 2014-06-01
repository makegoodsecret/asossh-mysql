package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;

import org.apache.struts2.ServletActionContext;

import com.secret.ipAddress.ArrayProvinceCity;
import com.secret.page.base.PageView;
import com.secret.pojo.GoodsAssessPojo;
import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.pojo.SortPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsAssessService;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsInfoService;
import com.secret.service.HotelService;
import com.secret.service.MealService;
import com.secret.service.SortService;
import com.secret.service.UserService;
import com.secret.util.FinalStatus;
import com.secret.util.GpsHotelInfo;
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
public class HotelManageAction extends BaseAction {
	private HotelService hotelService;
	private HotelPojo hotelPojo;

	private HttpSession session;
	private HttpServletResponse response =  ResponseSetCharacterEncoding.getInstance();
	private String mags; // 操作提示信息
	private List<HotelPojo> hotelList;
	private MealService mealService;
	private MealPojo mealPojo;
	private List<MealPojo> meallist;
	private GoodsInfoService goodsInfoService;
	private List<GoodsInfoPojo> goodsInfolist;
	private List<GoodsInfoPojo> goodsInforight; // 右侧列表
	private GoodsInfoPojo goodsInfoPojo;

	private SortService  sortService  ;
	private  List<SortPojo> sortList ;
	
	private GoodsCartService goodsCartService; // 开启顾客的购物车
	private List<GoodsCartPojo> goodsCartPojosList;
	private int[] leftRoles;
	private int[] rightRoles;
	
	private  String  mealorgoodsname ;
	private GoodsAssessService   goodsAssessService   ;   //用户评价
	private List<GoodsAssessPojo>  goodsAssessList ;
	private GoodsAssessPojo   goodsAssessPojo  ;
	private UserService   userService ;
	private UserPojo  userPojo   ;
	private int goodormeal; // 判断是否是套餐还是美食
	// 分页
	private int maxResultPage=5; // 设置，每页显示的最大显示数
	private PageView<HotelPojo> pageView; // 分页处理后的数据

	private int  buttonId=-1;
	private String hotelmealorgoodsnameseek;
	@SuppressWarnings("rawtypes")
	private Map<String, List>  mapGoodsMealHotel;
	//查询饭店美食或套餐
	@SuppressWarnings("rawtypes")
	public String selectgoodsormeals(){
		mapGoodsMealHotel= new LinkedHashMap<String, List>();
		if (!"".equals(hotelmealorgoodsnameseek)) {
			//查询套餐
			List<MealPojo> mealfindVageu = mealService.findVageu("mealName", hotelmealorgoodsnameseek);
			//查询美食
			String goodsInfowherejpql="o.goodsName like ? or o.goodsDis like ? ";
			Object[] queryParams={"%"+hotelmealorgoodsnameseek+"%","%"+hotelmealorgoodsnameseek+"%"};
			LinkedHashMap<String, String> goodsInfoorderby=new LinkedHashMap<String, String>();
			goodsInfoorderby.put("goodsTime", "asc");
			List<GoodsInfoPojo> goodsInfofindVageu=goodsInfoService.findESCData(goodsInfowherejpql, queryParams, goodsInfoorderby);
			//查询饭店
			String wherejpql="o.hotelName like ? or o.hotelAds like ? ";
			LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
			orderby.put("hotelTime", "asc");
			List<HotelPojo> hotelfindVageu=hotelService.findESCData(wherejpql, queryParams, orderby);
			if (hotelfindVageu.size()!=0) {
				mapGoodsMealHotel.put("hotel", hotelfindVageu);
			}
			if (mealfindVageu.size()!=0) {
				mapGoodsMealHotel.put("meal", mealfindVageu);
			}
			if (goodsInfofindVageu.size()!=0) {
				mapGoodsMealHotel.put("goods", goodsInfofindVageu);
			}
		}
		
		mealorgoodsname=StaticAction.inhotelseek;   //进入饭店的查找
		 hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		 sortList = sortService.findProperty("hotelPojo", hotelPojo);
		//卖家收到的评价
		String goodsAssesswherejpql=" o.hotelPojo=?";
		Object[] goodsAssessqueryParams={hotelPojo};
		LinkedHashMap<String, String> goodsAssessorderby = new LinkedHashMap<String, String>();
		goodsAssessorderby.put("assTime", "desc");
		goodsAssessList = goodsAssessService.findESCData(goodsAssesswherejpql, goodsAssessqueryParams, goodsAssessorderby);
		showCart();
		return "mainhotel";
	}
	//保存饭店有关的商标logo与证书
	public void   savehotelimage(){
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
	// 修改饭店的商标与证书
	public void updatahotelimage(){
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
	//进入饭店上传界面
	public String showhotelsave(){
		return "addhotel";
	}
	//保存饭店
	public String   savehotel(){
			session  = ServletActionContext.getRequest().getSession();
			/*饭店的等级*/
			hotelPojo.setHotelLevel(0.50);
			/*饭店的访问次数及人气*/
			hotelPojo.setHotelGrade(0);
			/*创建者的id,管理员创建为0*/
			UserPojo userpojo = (UserPojo) session.getAttribute("user");
			/*饭店创建的时间*/
			hotelPojo.setHotelTime(new Timestamp(new Date().getTime()));
		if (userpojo.getPower().equals("1")) {
				//管理员
				UserPojo hoteluserPojo = userService.findProperty("username", userPojo.getUsername()).get(0);
				if (!hoteluserPojo.getPayname().equals(userPojo.getPayname())) {
					hoteluserPojo.setPayname(userPojo.getPayname());
					userService.merge(hoteluserPojo);
				}
				hotelPojo.setUserPojo(hoteluserPojo);
				if(hotelService.save(hotelPojo)){
					showhotel();
					return "showhotel";
				}else {
					return "hotelsave";
				}
				
			}else{
				hotelPojo.setUserPojo(userpojo);//创建者为普通员工 
				if (userpojo.getPayname()==null||!userpojo.getPayname().equals(userPojo.getPayname())) {
					userpojo.setPayname(userPojo.getPayname());
					userService.merge(userpojo);
				}
				if(hotelService.save(hotelPojo)){
					hotelPojo= hotelService.findProperty("hotelName", hotelPojo.getHotelName()).get(0);
					mainhotel();
					return "mainhotel";
				}else {
					return "hotelsave";
				}
			}
	}
	// 修改饭店信息
		public String updatehotel() {
			UserPojo userPojo2 = userService.findProperty("username", userPojo.getUsername()).get(0);
			UserPojo userpojos = (UserPojo) ServletActionContext.getRequest().getSession().getAttribute("user");
			HotelPojo hotelPojo2 = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
			hotelPojo.setHotelLevel(hotelPojo2.getHotelLevel());
			hotelPojo.setHotelGrade(hotelPojo2.getHotelGrade());
			hotelPojo.setHotelTime(new Timestamp(new Date().getTime()));
			hotelPojo.setUserPojo(userPojo2);
			hotelService.update(hotelPojo);
			if (userpojos.getPower().equals("1")) {  //管理员
				return showhotel();  //进入饭店的管理
			}else{
				return mainhotel();  //进入该饭店
			}
		}
	// 进入饭店
	public String mainhotel() {
		 hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		 sortList = sortService.findProperty("hotelPojo", hotelPojo);
		 new StaticAction();
		mealorgoodsname =StaticAction.inhotelmain;		//进入饭店主页的操作状态
		//卖家收到的评价
		String wherejpql=" o.hotelPojo=?";
		Object[] queryParams={hotelPojo};
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("assTime", "desc");
		goodsAssessList = goodsAssessService.findESCData(wherejpql, queryParams, orderby);
		showCart();
		return "mainhotel";
	}
	
	//用户参看饭店中的分类按钮
	public String useroptionhotel(){
		 hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		 sortList = sortService.findProperty("hotelPojo", hotelPojo);
		//处理中文乱码
		 try {
			String string = new String(ServletActionContext.getRequest().getParameter("mealorgoodsname").getBytes("ISO8859-1"),"UTF-8");
			setMealorgoodsname(string);		
		 } catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		//判断是否是查看套餐
		 goodsAssessList= new ArrayList<GoodsAssessPojo>();
		 if (this.getMealorgoodsname().equals(StaticAction.inhotelmeal)) {
			 //查询出对套餐的评价
			 Set<MealPojo> mealset = hotelPojo.getMealPojo();
			 List<MealPojo>  mealList = new ArrayList<MealPojo>();
			 mealList.addAll(mealset);//将set全部添加在list后面
			 for (MealPojo mealPojo : mealList) {
				 goodsAssessList.addAll(goodsAssessService.findProperty("mealPojo", mealPojo));
			}
		}else{
			Set<GoodsInfoPojo> goodsInfoSet = hotelPojo.getGoodsInfoPojo();
			 List<GoodsInfoPojo>  goodsInfoList = new ArrayList<GoodsInfoPojo>();
			 goodsInfoList.addAll(goodsInfoSet);
			 for (GoodsInfoPojo goodsInfoPojo : goodsInfoList) {
				 goodsAssessList.addAll(goodsAssessService.findProperty("goodsInfoPojo", goodsInfoPojo));
			}
		}
		 showCart();
		return "mainhotel";
	}
	
	//显示用户查看某个美食
	public String userShowgoods(){
		 goodsInfoPojo=goodsInfoService.findProperty("goodsId", goodsInfoPojo.getGoodsId()).get(0);
		 hotelPojo = goodsInfoPojo.getHotelPojo();
		 sortList = sortService.findProperty("hotelPojo", hotelPojo);
		 //查询出用户的评价
		 goodsAssessList = goodsAssessService.findProperty("goodsInfoPojo", goodsInfoPojo);
		 new StaticAction();
		 mealorgoodsname =StaticAction.inhotelgoods;		//进入饭店主页的操作状态
		 showCart();
		return "mainhotel";
	}
	// 显示购物车
	public void showCart() {
		HttpSession session = ServletActionContext.getRequest().getSession();
		UserPojo userPojo = (UserPojo) session.getAttribute("user");
		if (userPojo != null && userPojo.getUserId() > 0) {
			goodsCartPojosList = goodsCartService.findProperty(
					"userPojo.userId", userPojo.getUserId());
		}

	}

	// 进入饭店并参看具体的美食或是套餐
	public String showgoodsormealhotel() {
		if (goodormeal == FinalStatus.ISMEAL) { // 是套餐
			mealPojo = mealService.findProperty("mealId", mealPojo.getMealId())
					.get(0);
		}
		if (goodormeal == FinalStatus.ISGOODS) { // 是美食
			goodsInfoPojo = goodsInfoService.findProperty("goodsId",
					goodsInfoPojo.getGoodsId()).get(0);
		}
		mainhotel();
		return "showgoodsormealhotel";
	}

	// 饭店管理
	public String showhotel() {
		this.setMaxResultPage(5); // 设置默认分页
		this.getMaxandPage(this.getMaxResultPage(), 1);
		return "showhotel";
	}

	// 查看修改饭店修改页面
	public String showhotelupdate() {
			hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
			return "hotelupdate";
	}

	

	// 自定义最大显示页数并回到第一页
	public String showMaxResult() {
		getMaxandPage(this.getMaxResultPage(), 1);
		return "showhotel";
	}

	// 点击上下页按钮
	public String seekpageing() {
		if (null==hotelPojo) {
			hotelPojo= new HotelPojo();
			hotelPojo.setHotelName("");
		}
		String  hql ;
		Object [] obj;
		hql="o.hotelName like ? or o.hotelAds like ? or o.hotelProvince like ? or o.hotelCity like ? or o.hotelCounty like ? or o.hotelOtherAddress like ?";
		obj=new Object[]{"%"+hotelPojo.getHotelName()+"%","%"+hotelPojo.getHotelName()+"%","%"+hotelPojo.getHotelName()+"%","%"+hotelPojo.getHotelName()+"%","%"+hotelPojo.getHotelName()+"%","%"+hotelPojo.getHotelName()+"%"};
		pageView=new PageView<HotelPojo>(this.getMaxResultPage(),super.getPage());
		pageView.setQueryResult(hotelService.getScrollData(pageView.getFirstResult(), pageView.getMaxResult(), hql, obj));
		return "showhotel";
	}

	// 封装分页的最大显示数
	public void getMaxPage(int page) {
		pageView = new PageView<HotelPojo>(page, super.getPage());
		pageView.setQueryResult(hotelService.getScrollData(pageView.getFirstResult(), page));
	}

	// 封装分页的最大显示数与 记住第几页
	public void getMaxandPage(int page, int getPage) {
		pageView = new PageView<HotelPojo>(page, getPage);
		pageView.setQueryResult(hotelService.getScrollData(
				pageView.getFirstResult(), page));
	}

	// 进入套餐
	public String mealShow() {
		hotelPojo = hotelService.findProperty("hotelId", hotelPojo.getHotelId()).get(0);
		goodsInfolist = goodsInfoService.findProperty("hotelPojo", hotelPojo);
		for (GoodsInfoPojo goodsInfo : goodsInfolist) {
			goodsInfo.setGoodsName(goodsInfo.getGoodsName() + " 价格:￥"
					+ goodsInfo.getGoodsPrice());
		}
		return "mealShow";
	}

	// 保存套餐
	public String mealSave() {
		Timestamp timestamp = new Timestamp(new Date().getTime());
		MealPojo meal = new MealPojo();
		meal.setMealTime(timestamp);
		meal.setMealStatu(mealPojo.getMealStatu());
		meal.setMealPrice(mealPojo.getMealPrice());
		meal.setMealName(mealPojo.getMealName());
		// 保存饭店的
		HotelPojo hotelinfo = hotelService.findProperty("hotelId",
				hotelPojo.getHotelId()).get(0);
		meal.setHotelPojo(hotelinfo);
		// 多对多保存美食信息
		Set<GoodsInfoPojo> set = new HashSet<GoodsInfoPojo>();
		for (int i = 0; i < rightRoles.length; i++) {
			GoodsInfoPojo infoPojo = goodsInfoService.findProperty("goodsId",
					rightRoles[i]).get(0);
			set.add(infoPojo);
		}
		meal.setGoodsInfoPojo(set);
		mealService.merge(meal);
		mainhotel();
		return "mainhotel";
	}

	// 进入修改套餐页面
	public String mealShowUpdate() {
		hotelPojo=hotelService.findProperty("hotelId",hotelPojo.getHotelId()).get(0);
		goodsInfolist = goodsInfoService.findProperty("hotelPojo",hotelPojo);
		meallist = mealService.findProperty("mealId", mealPojo.getMealId());
		return "mealupdate";
	}

	// 修改套餐
	public String mealUpdate() {

		this.mainhotel();
		return "mainhotel";
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

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public List<GoodsInfoPojo> getGoodsInforight() {
		return goodsInforight;
	}

	public void setGoodsInforight(List<GoodsInfoPojo> goodsInforight) {
		this.goodsInforight = goodsInforight;
	}

	public List<MealPojo> getMeallist() {
		return meallist;
	}

	public void setMeallist(List<MealPojo> meallist) {
		this.meallist = meallist;
	}

	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}

	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}

	public List<GoodsInfoPojo> getGoodsInfolist() {
		return goodsInfolist;
	}

	public void setGoodsInfolist(List<GoodsInfoPojo> goodsInfolist) {
		this.goodsInfolist = goodsInfolist;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public String getMags() {
		return mags;
	}

	public void setMags(String mags) {
		this.mags = mags;
	}

	public List<HotelPojo> getHotelList() {
		return hotelList;
	}

	public void setHotelList(List<HotelPojo> hotelList) {
		this.hotelList = hotelList;
	}

	public int getMaxResultPage() {
		return maxResultPage;
	}

	public void setMaxResultPage(int maxResultPage) {
		this.maxResultPage = maxResultPage;
	}

	public PageView<HotelPojo> getPageView() {
		return pageView;
	}

	public void setPageView(PageView<HotelPojo> pageView) {
		this.pageView = pageView;
	}

	public MealService getMealService() {
		return mealService;
	}

	public void setMealService(MealService mealService) {
		this.mealService = mealService;
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

	public int[] getLeftRoles() {
		return leftRoles;
	}

	public void setLeftRoles(int[] leftRoles) {
		this.leftRoles = leftRoles;
	}

	public int[] getRightRoles() {
		return rightRoles;
	}

	public void setRightRoles(int[] rightRoles) {
		this.rightRoles = rightRoles;
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

	public void setGoodsCartPojosList(List<GoodsCartPojo> goodsCartPojosList) {
		this.goodsCartPojosList = goodsCartPojosList;
	}

	public int getGoodormeal() {
		return goodormeal;
	}

	public void setGoodormeal(int goodormeal) {
		this.goodormeal = goodormeal;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public UserPojo getUserPojo() {
		return userPojo;
	}
	public void setUserPojo(UserPojo userPojo) {
		this.userPojo = userPojo;
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
	public String getMealorgoodsname() {
		return mealorgoodsname;
	}
	public void setMealorgoodsname(String mealorgoodsname) {
		this.mealorgoodsname = mealorgoodsname;
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
	public List<GoodsAssessPojo> getGoodsAssessList() {
		return goodsAssessList;
	}
	public void setGoodsAssessList(List<GoodsAssessPojo> goodsAssessList) {
		this.goodsAssessList = goodsAssessList;
	}
	public int getButtonId() {
		return buttonId;
	}
	public void setButtonId(int buttonId) {
		this.buttonId = buttonId;
	}
	public Map<String, List> getMapGoodsMealHotel() {
		return mapGoodsMealHotel;
	}
	public void setMapGoodsMealHotel(Map<String, List> mapGoodsMealHotel) {
		this.mapGoodsMealHotel = mapGoodsMealHotel;
	}
	public String getHotelmealorgoodsnameseek() {
		return hotelmealorgoodsnameseek;
	}
	public void setHotelmealorgoodsnameseek(String hotelmealorgoodsnameseek) {
		this.hotelmealorgoodsnameseek = hotelmealorgoodsnameseek;
	}
	 
 
}
