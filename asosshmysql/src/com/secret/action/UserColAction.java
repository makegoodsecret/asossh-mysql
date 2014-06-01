package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.UserColPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.GoodsCartService;
import com.secret.service.GoodsInfoService;
import com.secret.service.HotelService;
import com.secret.service.MealService;
import com.secret.service.UserColService;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class UserColAction {
	private  UserColService  userColService ;
	private MealService  mealService ;
	private HotelService  hotelService ;
	private GoodsInfoService goodsInfoService;
	private int goodormeal  ;			//判断是否套餐,0为套餐,1为美食,2为饭店,
	private int goodormealId;			//套餐,美食,饭店的id
	private GoodsCartService   goodsCartService  ;
	private GoodsCartPojo  goodsCartPojo ;
	private HttpServletResponse response = ResponseSetCharacterEncoding.getInstance();
	public void  userColaddordel(){
		try {
			PrintWriter  out  =response.getWriter();
			UserPojo   userPojo= (UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
			Timestamp  timestamp = new Timestamp(new Date().getTime());
			UserColPojo  userColPojo  = new UserColPojo();
			userColPojo.setColTime(timestamp);
			userColPojo.setUserPojo(userPojo);
			List<UserColPojo> doubleUserCol = null;
			switch (goodormeal) {
			case 0:		//套餐
				  doubleUserCol = userColService.findDoubleProperty("mealPojo.mealId", goodormealId, "userPojo.userId", userPojo.getUserId());
				if (doubleUserCol.size()!=0) {	//该套餐存在
					out.println(1);
				}else{
					userColPojo.setMealPojo(mealService.findProperty("mealId", goodormealId).get(0));
					boolean save = userColService.merge(userColPojo);
					if (save) {
						out.println(2);
					}else{
						out.println(0);
					}
				}
				break;
			case 1:		//美食
				doubleUserCol= userColService.findDoubleProperty("goodsInfoPojo.goodsId", goodormealId, "userPojo.userId", userPojo.getUserId());
				if (doubleUserCol.size()!=0) {	//该美食存在
					out.println(1);
				}else{
					userColPojo.setGoodsInfoPojo(goodsInfoService.findProperty("goodsId", goodormealId).get(0));
					boolean save = userColService.merge(userColPojo);
					if (save) {
						out.println(2);
					}else{
						out.println(0);
					}
				}
				break;
			case 2:		//饭店
				doubleUserCol= userColService.findDoubleProperty("hotelPojo.hotelId", goodormealId, "userPojo.userId", userPojo.getUserId());
				if (doubleUserCol.size()!=0) {	//该饭店存在
					out.println(1);
				}else{
					userColPojo.setHotelPojo(hotelService.findProperty("hotelId", goodormealId).get(0));
					boolean save = userColService.merge(userColPojo);
					if (save) {
						out.println(2);
					}else{
						out.println(0);
					}
				}
				break;
			default:
				out.println(0);
				break;
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//购物车移入收藏夹
	public void  userremovecart(){
		try {
			PrintWriter out = response.getWriter();
			GoodsCartPojo cartPojo = goodsCartService.findProperty("cartId", goodsCartPojo.getCartId()).get(0);
			UserColPojo userColPojo= new UserColPojo();
			userColPojo.setColTime(new Timestamp(new Date().getTime()));
			userColPojo.setUserPojo(cartPojo.getUserPojo());
			boolean merge = false ;
			if(cartPojo.getGoodsInfoPojo()!=null){
				List<UserColPojo> goodsInfoPojolist = userColService.findProperty("goodsInfoPojo", cartPojo.getGoodsInfoPojo());
				if (goodsInfoPojolist.size()==0) {
					userColPojo.setGoodsInfoPojo(cartPojo.getGoodsInfoPojo());
					  merge = userColService.merge(userColPojo);
					  if (merge) {
						  	goodsCartService.delete(goodsCartPojo.getCartId());
							out.println(2);
						}else{
							out.println(0);
					}
				}else {
					out.println(1);  //存在
				}
				
			}else  {
				userColPojo.setMealPojo(cartPojo.getMealPojo());
				List<UserColPojo> mealList = userColService.findProperty("mealPojo", cartPojo.getMealPojo());
				if (mealList.size()==0) {
					merge = userColService.merge(userColPojo);
					if (merge) {
						out.println(2);
					}else{
						out.println(0);
					}
				}else {
					out.println(1);
				}
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	//从购物车中删除
	public void  userdeletecart(){
		try {
			PrintWriter out = response.getWriter();
			 boolean delete = goodsCartService.delete(goodsCartPojo.getCartId());
			 if (delete) {
				 out.println(1);
			}else{
				 out.println(0);
			}
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public UserColService getUserColService() {
		return userColService;
	}

	public void setUserColService(UserColService userColService) {
		this.userColService = userColService;
	}

	public void setGoodormeal(int goodormeal) {
		this.goodormeal = goodormeal;
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

	public HotelService getHotelService() {
		return hotelService;
	}

	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}

	public GoodsInfoService getGoodsInfoService() {
		return goodsInfoService;
	}

	public void setGoodsInfoService(GoodsInfoService goodsInfoService) {
		this.goodsInfoService = goodsInfoService;
	}

	public int getGoodormeal() {
		return goodormeal;
	}

	public int getGoodormealId() {
		return goodormealId;
	}

	public GoodsCartService getGoodsCartService() {
		return goodsCartService;
	}

	public void setGoodsCartService(GoodsCartService goodsCartService) {
		this.goodsCartService = goodsCartService;
	}

	public GoodsCartPojo getGoodsCartPojo() {
		return goodsCartPojo;
	}

	public void setGoodsCartPojo(GoodsCartPojo goodsCartPojo) {
		this.goodsCartPojo = goodsCartPojo;
	}

	
	
}
