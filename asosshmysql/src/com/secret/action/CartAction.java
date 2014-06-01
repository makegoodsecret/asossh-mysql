package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.pojo.OrderAddressPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsInfoService;
import com.secret.service.MealService;
import com.secret.service.OrderAddressService;
import com.secret.service.UserService;
import com.secret.util.AddCart;
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
public class CartAction {
	private  GoodsCartService  goodsCartService;	
	private  MealService   mealService;
	private GoodsInfoService goodsInfoService;
	private GoodsCartPojo  goodsCartPojo;
	private List<GoodsCartPojo>  goodsCartPojosList;
	private OrderAddressService  orderAddressService   ;
	private UserService   userService ;
	private int goodormeal  ;			//判断是否套餐，0为套餐
	private int goodormealId;			//id
	private int number ;				//更改的数量
	private int status  ;				//什么操作
	private int addcountnowid;			//追加后在购物车的序号
	
	private Map<HotelPojo, List<GoodsCartPojo> >   goodsCartPojosMap;
	private List<OrderAddressPojo>    orderAddressList;
	private PrintWriter  out ;			//
	private HttpServletResponse response =  ResponseSetCharacterEncoding.getInstance(); 
	 
	/**
	 * ajax查询并拼接个购物车
	 * @return
	 */
	public void ajaxaddcart(){
		try {
			out = response.getWriter();
			UserPojo userPojo=(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			goodsCartPojosList = goodsCartService.findProperty("userPojo.userId", userPojo.getUserId());
			StringBuffer  stringBuffer  = new StringBuffer();
			AddCart addCart = new AddCart();
			if (goodsCartPojosList.size()!=0) {
				for(int i=0;i<goodsCartPojosList.size();i++){
					 goodsCartPojo = goodsCartPojosList.get(i);
					 if (goodsCartPojo.getGoodsInfoPojo()!=null) {//购物车中的美食
						 stringBuffer.append(addCart.addgoodscart(goodsCartPojo, i));
					}else{//购物车中的套餐
						stringBuffer.append(addCart.addmealcart(goodsCartPojo, i));
					}
				}
			}else{
				stringBuffer.append(addCart.addCartIsemp()); //购物车为空
			}
			Map<String,String> map = new HashMap<String, String>();
			map.put("buyListli", stringBuffer.toString());
			map.put("ismycartfoot", addCart.addshowmycart(goodsCartPojosList.size(), addCart.getSumprice()));
			JSONObject jsonObject  =JSONObject.fromObject(map);
			out.println(jsonObject.toString());
			out.flush();
			out.close();
		  } catch (IOException e) {
			  e.printStackTrace();
		  }
	}
	
	/**
	 * 查询出我的购物车
	 * @return
	 */
	public String mycart(){
		HttpSession session = ServletActionContext.getRequest().getSession();
		UserPojo  userPojo=(UserPojo)session.getAttribute("user");
		if (userPojo!=null&&userPojo.getUserId()>0) {
			goodsCartPojosList=goodsCartService.findProperty("userPojo.userId", userPojo.getUserId());
			//处理按照饭店将购物车重新排列
			hotelsort(goodsCartPojosList);
		}		
		return  "addCart";
	}
	/**
	 * 提交购物车，
	 * @return
	 */
	public  String  postMyCart(){
		HttpServletRequest request = ServletActionContext.getRequest();
	String[]   checkboxcartId =	request.getParameterValues("checkboxcartId");
	goodsCartPojosList= new ArrayList<GoodsCartPojo>();
	for (String cartId : checkboxcartId) {
		goodsCartPojosList.add(goodsCartService.findProperty("cartId", Integer.parseInt(cartId)).get(0));
	}
	UserPojo	userPojo=(UserPojo) request.getSession().getAttribute("user");
	orderAddressList=  orderAddressService.addressDesc("userPojo", userService.findProperty("userId", userPojo.getUserId()).get(0), "desc");
	goodsCartPojosMap= new HashMap<HotelPojo, List<GoodsCartPojo>>();
	hotelsort(goodsCartPojosList);//处理按照饭店将购物车重新排列
		return  "addMyAddress";
	}
	private  synchronized void hotelsort(List<GoodsCartPojo> goodsCartPojosList ) {
		Map<String, HotelPojo>  map = new LinkedHashMap<String, HotelPojo>();
		goodsCartPojosMap= new LinkedHashMap<HotelPojo, List<GoodsCartPojo>>();
		for (GoodsCartPojo goodsCartPojo : goodsCartPojosList) {
			if (goodsCartPojo.getGoodsInfoPojo()!=null) {
				map.put(goodsCartPojo.getGoodsInfoPojo().getHotelPojo().getHotelName(), goodsCartPojo.getGoodsInfoPojo().getHotelPojo());
			}else{
				map.put(goodsCartPojo.getMealPojo().getHotelPojo().getHotelName(),goodsCartPojo.getMealPojo().getHotelPojo());
			}
		}
		List<GoodsCartPojo>  list;
		for (String keyhotelName : map.keySet()) {
				list= new ArrayList<GoodsCartPojo>();
			for (GoodsCartPojo goodsCartPojos : goodsCartPojosList) {
				//添加美食
				if (goodsCartPojos.getGoodsInfoPojo()!=null) {
					if ( keyhotelName .equals(goodsCartPojos.getGoodsInfoPojo().getHotelPojo().getHotelName())) {
						list.add(goodsCartPojos);	
					}
				}else{
					//添加套餐
					if (keyhotelName.equals(goodsCartPojos.getMealPojo().getHotelPojo().getHotelName())) {
						list.add(goodsCartPojos);
					}
				}
			}
				goodsCartPojosMap.put(map.get(keyhotelName), list);
		}
		
	}
	/**
	 * 处理菜单的CRUD
	 * @return
	 */
	public String stickCRUD(){
		try {
			out  = response.getWriter();
			UserPojo userPojo = (UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			goodsCartPojo.setUserPojo(userPojo);
		//处理处理菜单的CRUD
		switch (status) {
		case 1:			//修改数量
			goodsCartPojo=goodsCartService.findProperty("cartId", goodsCartPojo.getCartId()).get(0);
			goodsCartPojo.setGoodsNumber(number);
			boolean update = goodsCartService.update(goodsCartPojo);
			out.println(update);
			break;
		case 2:			//删除
			goodsCartPojo=goodsCartService.findProperty("cartId", goodsCartPojo.getCartId()).get(0);
			boolean delete = goodsCartService.deleteProperty(goodsCartPojo);
			out.println(delete);
			break;
		case 3:			//添加、修改评价
			GoodsCartPojo goodsCartPojo2 = goodsCartService.findProperty("cartId", goodsCartPojo.getCartId()).get(0);
			goodsCartPojo2.setOrderAds(goodsCartPojo.getOrderAds());
			boolean addAds = goodsCartService.update(goodsCartPojo2);
			out.println(addAds);
			break;
		default: 
			break;
		}
		out.flush();
		out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "addCart";
	}
	
	/**
	 * 添加购物车
	 */
	@SuppressWarnings("unchecked")
	public void addcart(){
			try {
				out  = response.getWriter();
			UserPojo   userPojo= (UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			goodsCartPojo = new GoodsCartPojo();
			goodsCartPojo.setUserPojo(userPojo);
			@SuppressWarnings("rawtypes")
			Map   map  = new HashMap();
			//判断是否是套餐&&判断是否已经添加--添加修改数量
			List<GoodsCartPojo> goodsCartDouble = null;
			if (goodormeal==FinalStatus.ISMEAL) {	//是套餐
				goodsCartDouble = goodsCartService.findDoubleProperty("userPojo.userId", userPojo.getUserId(), "mealPojo.mealId", goodormealId);
				if (goodsCartDouble.size()!=0) {
					//存在
					goodsCartDouble.get(0).setGoodsNumber(goodsCartDouble.get(0).getGoodsNumber()+1);	//修改数量
					boolean update = goodsCartService.update(goodsCartDouble.get(0));
					if (update) {
						map.put("bool", false);
						map.put("cartId", goodsCartDouble.get(0).getCartId());
						JSONObject  json  =JSONObject.fromObject(map);
						out.print(json.toString());
					}
				}else{	//新增加
					goodsCartPojo.setGoodsNumber(1);	
					MealPojo mealPojo =mealService.findProperty("mealId", goodormealId).get(0);
					goodsCartPojo.setMealPojo(mealPojo);
					boolean save = goodsCartService.merge(goodsCartPojo);
					if (save) {
						goodsCartPojo=goodsCartService.findProperty("mealPojo.mealId", goodormealId).get(0);
						map.put("bool", true);
						map.put("str", new AddCart().addmealcart(goodsCartPojo, addcountnowid));
						JSONObject  json  =JSONObject.fromObject(map);
						out.print(json.toString());
					}
				}
			}else if(goodormeal==FinalStatus.ISGOODS){					//是普通的菜
				goodsCartDouble = goodsCartService.findDoubleProperty("userPojo.userId", userPojo.getUserId(), "goodsInfoPojo.goodsId", goodormealId);
				if (goodsCartDouble.size()!=0) {
					//存在
					goodsCartDouble.get(0).setGoodsNumber(goodsCartDouble.get(0).getGoodsNumber()+1);	//修改数量
					boolean update = goodsCartService.update(goodsCartDouble.get(0));
					if (update) {
						map.put("bool", false);
						map.put("cartId", goodsCartDouble.get(0).getCartId());
						JSONObject  json  =JSONObject.fromObject(map);
						out.print(json.toString());
					}
				}else{//新增加
					goodsCartPojo.setGoodsNumber(1);	//每次加一 
					GoodsInfoPojo goodsInfoPojo= goodsInfoService.findProperty("goodsId", goodormealId).get(0);
					goodsCartPojo.setGoodsInfoPojo(goodsInfoPojo);
					boolean save = goodsCartService.merge(goodsCartPojo);
					if (save) {
						GoodsCartPojo cartPojo = goodsCartService.findProperty("goodsInfoPojo.goodsId", goodormealId).get(0);
						map.put("bool", true);
						map.put("str", new AddCart().addgoodscart(cartPojo, addcountnowid));
						JSONObject  json  =JSONObject.fromObject(map);
						out.print(json.toString());
					}
				}
			}
			out.flush();
			out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
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

	public int getGoodormealId() {
		return goodormealId;
	}

	public void setGoodormealId(int goodormealId) {
		this.goodormealId = goodormealId;
	}

	public MealService getMealService() {
		return mealService;
	}

	public void setMealService(MealService mealService) {
		this.mealService = mealService;
	}

	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}

	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}

	public GoodsCartPojo getGoodsCartPojo() {
		return goodsCartPojo;
	}

 
	public void setGoodsCartPojo(GoodsCartPojo goodsCartPojo) {
		this.goodsCartPojo = goodsCartPojo;
	}

	public int getNumber() {
		return number;
	}

	public void setNumber(int number) {
		this.number = number;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getAddcountnowid() {
		return addcountnowid;
	}

	public void setAddcountnowid(int addcountnowid) {
		this.addcountnowid = addcountnowid;
	}
	public Map<HotelPojo, List<GoodsCartPojo>> getGoodsCartPojosMap() {
		return goodsCartPojosMap;
	}
	public void setGoodsCartPojosMap(
			Map<HotelPojo, List<GoodsCartPojo>> goodsCartPojosMap) {
		this.goodsCartPojosMap = goodsCartPojosMap;
	}
	public OrderAddressService getOrderAddressService() {
		return orderAddressService;
	}
	public void setOrderAddressService(OrderAddressService orderAddressService) {
		this.orderAddressService = orderAddressService;
	}
	public List<OrderAddressPojo> getOrderAddressList() {
		return orderAddressList;
	}
	public void setOrderAddressList(List<OrderAddressPojo> orderAddressList) {
		this.orderAddressList = orderAddressList;
	}
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	
	
}
