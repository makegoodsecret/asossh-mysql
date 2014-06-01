package com.secret.action;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsAssessPojo;
import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.UserColPojo;
import com.secret.pojo.UserHeadPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsAssessService;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsOrderService;
import com.secret.service.UserColService;
import com.secret.service.UserHeadService;
import com.secret.service.UserService;
import com.secret.util.DataUtil;
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
public class UserAction extends BaseAction {
	private UserService userService;	
	private UserHeadService  userHeadService;
	private UserPojo  userPojo  ;
	private UserHeadPojo  userHeadPojo;
	private HttpServletRequest request  ;
	private HttpSession   session ;
	private HttpServletResponse response = ResponseSetCharacterEncoding.getInstance();
	
	private int  updatetype;    //判断更改类型
	
	private GoodsCartService  goodsCartService;		//购物车
	private GoodsOrderService  goodsOrderService;   //订单
	private GoodsAssessService goodsAssessService;	//评价
	private UserColService  userColService;			//收藏
	private List<GoodsAssessPojo>  goodsAssessList;
	private List<GoodsOrderPojo>   goodsOrderList;
	private List<GoodsCartPojo>    goodsCartList;
	private List<UserColPojo>      userColList;
	private Map<String, Map<String, List<GoodsOrderPojo>>> goodsOrderMap;
	private Map<String ,Integer>  hotelMap;
	
	@Override
	public String execute() throws Exception {
		return userHome();
	}
	
	//添加好友
	public void adduserfriend(){
		try {
			PrintWriter out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
	}
	
	
	//显示个人主页信息
	public String   userHome(){
			userPojo=(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			goodsCartList=goodsCartService.findProperty("userPojo", userPojo);
			goodsOrderList=goodsOrderService.findProperty("userPojo", userPojo);
			hotelMap= new LinkedHashMap<String, Integer>();
			for (GoodsOrderPojo goodsOrder : goodsOrderList) {
				if (goodsOrder.getTradeStatus().equals(FinalStatus.TRADE_FINISHED)) { //交易成功的饭店
					hotelMap.put(goodsOrder.getHotelPojo().getHotelName(), goodsOrder.getHotelPojo().getHotelId());
				}
			}
			goodsOrderMap=DataUtil.createordermap(goodsOrderList);
			goodsAssessList=goodsAssessService.findProperty("userPojo", userPojo);
			userColList=userColService.findProperty("userPojo", userPojo);
			return  "userHome";
		}
	 
	
	 //根据用户的名字获得该用户的信息
	 public void  getjsonuserinfo(){
		try {
			userPojo = userService.findProperty("username", userPojo.getUsername()).get(0);
			PrintWriter out = response.getWriter();
			Map<String, String>  map  = new HashMap<String, String>();
			map.put("username", userPojo.getUsername());
			map.put("userpower", userPojo.getPower());
			map.put("usersex",	 userPojo.getSex());
			map.put("userheadimage", userPojo.getUserHeadPojo().getHeadImage());
			map.put("useremailsatu", userPojo.getEmailstatu());
			map.put("payname", userPojo.getPayname());
			JSONObject  jsonObject = JSONObject.fromObject(map);
			out.println(jsonObject.toString());
			out.flush();
			out.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		}
	 }
	//修改个人信息
	public void updateUser(){
		UserPojo  userpojos=userService.findProperty("userId", userPojo.getUserId()).get(0);
		userpojos.setDis(userPojo.getDis());
		userpojos.setMood(userPojo.getMood());
		userpojos.setHobby(userPojo.getHobby());
		userpojos.setEmail(userPojo.getEmail());
		userService.update(userpojos);
	}
	//修改个人资料
	public void updateuser(){
		UserPojo  userupdate=userService.findProperty("userId", userPojo.getUserId()).get(0);
		try {
			PrintWriter  out  =response.getWriter();
		switch (updatetype) {
		case 1:
			//更改心情
			userupdate.setMood(userPojo.getMood());
			break;
		case 2:
			//更改个人描述
			userupdate.setDis(userPojo.getDis());
			break;
		case 3:
			//更改爱好  
			userupdate.setHobby(userPojo.getHobby());
			break;
		case 4:
			//更改email
			userupdate.setEmail(userPojo.getEmail());
			break;
		default:
			break;
		}
		userService.update(userupdate);
		out.print(true);
		out.flush();
		out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//修改头像
	public void updateuserimage(){
		UserPojo  userupdate=(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
		UserHeadPojo userhead=userHeadService.findProperty("userpojo", userupdate).get(0);
		userhead.setHeadTime(new Timestamp(new Date().getTime()));
		String headImage = userupdate.getUserHeadPojo().getHeadImage();
		if (headImage.indexOf("tiger")!=0) { //修改头像
			 super.updateimage();   //源地址不变，不会产生垃圾图片
		}else{			//重新上传头像
			userhead.setHeadImage(super.saveimage());
		}
		try {
			boolean update = userHeadService.update(userhead);
			PrintWriter out = response.getWriter();
			if (update) {
				UserHeadPojo headPojo = userHeadService.findProperty("userpojo", userupdate).get(0);
				out.print(headPojo.getHeadImage());
			}else{
				out.print(update);
			}
			
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		 
	}
	
	//激活成为饭店管理员
	public String  EMailhotel(){
		List<UserPojo> list=userService.findProperty("userId", userPojo.getUserId());
		list.get(0).setEmailstatu("2");
		super.setRedirecturl("index.jsp");
		if(userService.update(list.get(0))){
			super.setElsemessage("激活成功");
			super.setMessagestatu(false); 
			 session = ServletActionContext.getRequest().getSession();
			UserPojo   userPojo =(UserPojo)session.getAttribute("user");
			if (userPojo!=null) {
				session.setAttribute("user", list.get(0));  //更新在线用户的信息
			}
		}else{
			super.setElsemessage("没有此项操作，或已经激活");
			super.setMessagestatu(true); 
		}
		return  "massageurl";
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

	public HttpServletResponse getResponse() {
		return response;
	}

	 
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}

 
	public UserHeadService getUserHeadService() {
		return userHeadService;
	}
	public void setUserHeadService(UserHeadService userHeadService) {
		this.userHeadService = userHeadService;
	}
	public UserHeadPojo getUserHeadPojo() {
		return userHeadPojo;
	}
	public void setUserHeadPojo(UserHeadPojo userHeadPojo) {
		this.userHeadPojo = userHeadPojo;
	}
	public int getUpdatetype() {
		return updatetype;
	}
	public void setUpdatetype(int updatetype) {
		this.updatetype = updatetype;
	}
	public GoodsAssessService getGoodsAssessService() {
		return goodsAssessService;
	}
	public void setGoodsAssessService(GoodsAssessService goodsAssessService) {
		this.goodsAssessService = goodsAssessService;
	}
	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}
	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}
	public GoodsCartService getGoodsCartService() {
		return goodsCartService;
	}
	public void setGoodsCartService(GoodsCartService goodsCartService) {
		this.goodsCartService = goodsCartService;
	}
	public UserColService getUserColService() {
		return userColService;
	}
	public void setUserColService(UserColService userColService) {
		this.userColService = userColService;
	}
	public List<GoodsAssessPojo> getGoodsAssessList() {
		return goodsAssessList;
	}
	public void setGoodsAssessList(List<GoodsAssessPojo> goodsAssessList) {
		this.goodsAssessList = goodsAssessList;
	}
	public List<GoodsOrderPojo> getGoodsOrderList() {
		return goodsOrderList;
	}
	public void setGoodsOrderList(List<GoodsOrderPojo> goodsOrderList) {
		this.goodsOrderList = goodsOrderList;
	}
	public List<GoodsCartPojo> getGoodsCartList() {
		return goodsCartList;
	}
	public void setGoodsCartList(List<GoodsCartPojo> goodsCartList) {
		this.goodsCartList = goodsCartList;
	}
	public List<UserColPojo> getUserColList() {
		return userColList;
	}
	public void setUserColList(List<UserColPojo> userColList) {
		this.userColList = userColList;
	}

	public Map<String, Map<String, List<GoodsOrderPojo>>> getGoodsOrderMap() {
		return goodsOrderMap;
	}

	public void setGoodsOrderMap(
			Map<String, Map<String, List<GoodsOrderPojo>>> goodsOrderMap) {
		this.goodsOrderMap = goodsOrderMap;
	}

	public Map<String, Integer> getHotelMap() {
		return hotelMap;
	}

	public void setHotelMap(Map<String, Integer> hotelMap) {
		this.hotelMap = hotelMap;
	}
	 
	
}
