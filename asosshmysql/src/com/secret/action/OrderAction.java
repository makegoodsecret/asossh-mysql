package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.GoodsOrderPojo;
import com.secret.pojo.OrderAddressPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsOrderService;
import com.secret.service.OrderAddressService;
import com.secret.util.FinalStatus;
import com.secret.util.IPTimeStamp;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class OrderAction  {
	private Logger logger = Logger.getLogger(OrderAction.class.getName());
	private GoodsOrderService  goodsOrderService;
	private GoodsOrderPojo     goodsOrderPojo;
	
	private OrderAddressService  orderAddressService;
	private OrderAddressPojo     orderAddressPojo;
	
	private GoodsCartService  goodsCartService ;
	private Map<String,List<GoodsOrderPojo>>  goodsOrderPojomap;
	private HttpServletResponse response =   ResponseSetCharacterEncoding.getInstance();
	//保存订单
	public String   saveorder(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String[] values = request.getParameterValues("orderAds");
		String[] cartIdStr = request.getParameterValues("submitcartId");
		String userAddressId = request.getParameter("userAddressId");
		UserPojo userPojo = (UserPojo)request.getSession().getAttribute("user");
		Map<String, String>  map = new HashMap<String, String>();  //同一家饭店，同一个用户同一时间提交的订单只有相同的
		for (int i =0 ; i<cartIdStr.length;i++) {
			int cartId = Integer.parseInt(cartIdStr[i]);
			GoodsCartPojo cartPojo = goodsCartService.findProperty("cartId", cartId).get(0);
			 if (cartPojo.getGoodsInfoPojo()!=null) {
				map.put(cartPojo.getGoodsInfoPojo().getHotelPojo().getHotelName(), getIpOrderIdnumber(map.size()+1)); 
			 }else{
				map.put(cartPojo.getMealPojo().getHotelPojo().getHotelName(), getIpOrderIdnumber(map.size()+1));
			}
			
		}
		for (int i =0 ; i<cartIdStr.length;i++) {
			goodsOrderPojo = new GoodsOrderPojo();
			int cartId = Integer.parseInt(cartIdStr[i]);
			GoodsCartPojo cartPojo = goodsCartService.findProperty("cartId", cartId).get(0);
			 if (cartPojo.getGoodsInfoPojo()!=null) {
				 goodsOrderPojo.setGoodsInfoPojo(cartPojo.getGoodsInfoPojo());
				 goodsOrderPojo.setHotelPojo(cartPojo.getGoodsInfoPojo().getHotelPojo());
				 goodsOrderPojo.setOrderNumber(map.get(cartPojo.getGoodsInfoPojo().getHotelPojo().getHotelName()));
			 }else{
				 goodsOrderPojo.setMealPojo(cartPojo.getMealPojo());
				 goodsOrderPojo.setHotelPojo(cartPojo.getMealPojo().getHotelPojo());
				 goodsOrderPojo.setOrderNumber(map.get(cartPojo.getMealPojo().getHotelPojo().getHotelName()));
			} 
				 orderAddressPojo = orderAddressService.findProperty("orderAddressId", Integer.parseInt(userAddressId)).get(0);
				 goodsOrderPojo.setGoodsNumber(cartPojo.getGoodsNumber());
				 goodsOrderPojo.setGoodsormealAds(cartPojo.getOrderAds());
				 goodsOrderPojo.setOrderAddress(orderAddressPojo);
				 goodsOrderPojo.setOrderTime(new Timestamp(new Date().getTime()));
				 goodsOrderPojo.setUserPojo(userPojo);
				 goodsOrderPojo.setOrderAds(values[i]);
				 goodsOrderPojo.setTradeStatus("none");  //支付状态 
			     boolean merge = goodsOrderService.merge(goodsOrderPojo);
			     if (merge) {
			    	 goodsCartService.delete(cartId);//删除购物车
				}
		}
		return showorder();
	}
	//参看订单去支付界面
	public String showorder(){
		goodsOrderPojomap= new HashMap<String, List<GoodsOrderPojo>>();
		UserPojo userPojo = (UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
		List<GoodsOrderPojo> goodsOrderlist = goodsOrderService.findProperty("userPojo", userPojo);
		List<String>  list = new ArrayList<String>();
		 for (GoodsOrderPojo goodsOrderPojo : goodsOrderlist) {
			 list.add(goodsOrderPojo.getOrderNumber());
		}
		 List<GoodsOrderPojo> goodsOrderPojolist;
		 for (String ordernumber : list) {
			 goodsOrderPojolist=new ArrayList<GoodsOrderPojo>();
			for (GoodsOrderPojo goodsOrderPojo : goodsOrderlist) {
				if (goodsOrderPojo.getOrderNumber().equals(ordernumber)) {
					goodsOrderPojolist.add(goodsOrderPojo);
				}
			}
			goodsOrderPojomap.put(ordernumber, goodsOrderPojolist);
		}
		 
		 
		return "alipay";
	}
	private String getIpOrderIdnumber(int addid) {
		 List<GoodsOrderPojo> goodsOrderPojofindAll = goodsOrderService.findAll();
		 String orderNumber = "wd";
		 int size = goodsOrderPojofindAll.size();
		 if (size!=0) {
			 orderNumber+= goodsOrderPojofindAll.get(size-1).getOrderId()+1;	//订单序号
		}else{
			orderNumber+=addid;
		}
		 String ip = ServletActionContext.getRequest().getLocalAddr();
		String ipTimeStack = new  IPTimeStamp().ipTimeStack(ip );
		orderNumber+= ipTimeStack;
		return orderNumber;
	}
	//更改默认收货地址
	public  void setaddress(){
		 List<OrderAddressPojo> listisorderaddressstatus = orderAddressService.findProperty("orderAddressStatus",FinalStatus.ISORDERADDRESSSTATUS);
		if (listisorderaddressstatus.size()>0) {	//如果有
			listisorderaddressstatus.get(0).setOrderAddressStatus(FinalStatus.NOTORDERADDRESSSTATUS);
			orderAddressService.update(listisorderaddressstatus.get(0));
		}
		
		OrderAddressPojo orderAddressPojos = orderAddressService.findProperty("orderAddressId", orderAddressPojo.getOrderAddressId()).get(0);
		orderAddressPojos.setOrderAddressStatus(FinalStatus.ISORDERADDRESSSTATUS);
		boolean update = orderAddressService.update(orderAddressPojos);
		try {
			PrintWriter out = response.getWriter();
			out.print(update);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	 
	//添加收件人地址
	public void  saveaddress(){
		UserPojo userPojo  = (UserPojo) ServletActionContext.getRequest().getSession().getAttribute("user");
		try {
			if (orderAddressPojo.getOrderAddressStatus().equals(FinalStatus.ISORDERADDRESSSTATUS)) {
				//更改数据库中的默认地址
				List<OrderAddressPojo> listisorderaddressstatus = orderAddressService.findProperty("orderAddressStatus",FinalStatus.ISORDERADDRESSSTATUS);
				if (listisorderaddressstatus.size()>0) {	//如果有
					listisorderaddressstatus.get(0).setOrderAddressStatus(FinalStatus.NOTORDERADDRESSSTATUS);
					orderAddressService.update(listisorderaddressstatus.get(0));
				}
			}
			orderAddressPojo.setUserPojo(userPojo);
			boolean save = orderAddressService.save(orderAddressPojo);
			PrintWriter out = response.getWriter();
			if (save) {
				out.print(orderAddressPojo.getOrderAddressId());
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	//修改地址
	public void updateaddress(){
		try {
			if (orderAddressPojo.getOrderAddressStatus().equals(FinalStatus.ISORDERADDRESSSTATUS)) {
				//更改数据库中的默认地址
				OrderAddressPojo isorderaddress = orderAddressService.findProperty("orderAddressStatus",FinalStatus.ISORDERADDRESSSTATUS).get(0);
				isorderaddress.setOrderAddressStatus(FinalStatus.NOTORDERADDRESSSTATUS);
				orderAddressService.update(isorderaddress);
			}
			OrderAddressPojo orderAddressPojos = orderAddressService.findProperty("orderAddressId", orderAddressPojo.getOrderAddressId()).get(0);
			orderAddressPojo.setUserPojo(orderAddressPojos.getUserPojo());
			orderAddressPojos=orderAddressPojo;
			boolean save = orderAddressService.update(orderAddressPojos);
			PrintWriter out = response.getWriter();
			out.print(save);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		}
	public String addOrder(){
		
		return "addOrder";
	}


	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}


	 

	public GoodsCartService getGoodsCartService() {
		return goodsCartService;
	}
	public void setGoodsCartService(GoodsCartService goodsCartService) {
		this.goodsCartService = goodsCartService;
	}
	public OrderAddressService getOrderAddressService() {
		return orderAddressService;
	}

	public void setOrderAddressService(OrderAddressService orderAddressService) {
		this.orderAddressService = orderAddressService;
	}

	public OrderAddressPojo getOrderAddressPojo() {
		return orderAddressPojo;
	}

	public void setOrderAddressPojo(OrderAddressPojo orderAddressPojo) {
		this.orderAddressPojo = orderAddressPojo;
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
	public Map<String, List<GoodsOrderPojo>> getGoodsOrderPojomap() {
		return goodsOrderPojomap;
	}
	public void setGoodsOrderPojomap(
			Map<String, List<GoodsOrderPojo>> goodsOrderPojomap) {
		this.goodsOrderPojomap = goodsOrderPojomap;
	}
	 
	
}
