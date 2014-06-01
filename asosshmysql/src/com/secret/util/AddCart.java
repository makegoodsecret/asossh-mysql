package com.secret.util;

import com.secret.pojo.GoodsCartPojo;
import com.secret.pojo.GoodsInfoPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class AddCart {
	private double sumprice;    				 //总价
	/**
	 * 拼接新增的美食
	 * @param goodsCartPojo
	 * @param addcountnowid
	 * @return
	 */
	public String addgoodscart(GoodsCartPojo  goodsCartPojo,int addcountnowid){
		GoodsInfoPojo goodsInfoPojo = goodsCartPojo.getGoodsInfoPojo(); 			//得到美食
		sumprice+=goodsInfoPojo.getGoodsPrice()*goodsCartPojo.getGoodsNumber(); //统计总价(在拼接出购物车的尾部时有用)
		
		StringBuffer  stringBuffer  = new StringBuffer();
		stringBuffer.append("<li id='mycartli"+addcountnowid+"'>");
		stringBuffer.append("<div style=' height: 100%;'><div style='float: left;'><a href='asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId="+goodsInfoPojo.getGoodsId()+"'"); 
		stringBuffer.append("title='"+goodsInfoPojo.getGoodsDis()+"' target='_blank' class='pic'><img src='photo/"+goodsInfoPojo.getGoodsImagePojo().getGimageImage()+"'");
		stringBuffer.append("alt='"+goodsInfoPojo.getGoodsDis()+"' width='80px' height='60px' /></a></div><div style='float: left; '><div>");
		stringBuffer.append("<label style='margin-left: 10px;  font-size: 15px;'>菜名:</label>");
		stringBuffer.append("<a style='color: #000000; font-size: 15px;'  href='asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId="+goodsInfoPojo.getGoodsId()+"' title='"+goodsInfoPojo.getGoodsDis()+"' target='_blank' >"); 
		stringBuffer.append(""+goodsInfoPojo.getGoodsName()+"</a><button type='button' class='mycatbuttontwo' ");
		stringBuffer.append("onclick='daleteCart("+goodsCartPojo.getCartId()+","+addcountnowid+");'>删除</button></div><div><label style='margin-left: 10px;  font-size: 15px;'>单价:</label>");
		stringBuffer.append("<font style='font-size: 14px; color: #222222'>&yen;</font>"+goodsInfoPojo.getGoodsPrice()+"</div><div>");
		stringBuffer.append("<button type='button' class='mycatbutton' onclick='stickCut("+goodsCartPojo.getCartId()+","+addcountnowid+")'>-</button><input type='text' size='5' id='number"+addcountnowid+"'");
		stringBuffer.append("value='"+goodsCartPojo.getGoodsNumber()+"' onkeyup='stickupdate("+goodsCartPojo.getCartId()+","+addcountnowid+")'><button type='button'class='mycatbutton' onclick='stickAdd("+goodsCartPojo.getCartId()+","+addcountnowid+")'>+</button>份");
		stringBuffer.append("</div></div><div style='clear: both; '>");
		stringBuffer.append("<button type='button' class='mycatbutton' id='orderAdsbutton"+addcountnowid+"' onclick='orderAds("+goodsCartPojo.getCartId()+","+addcountnowid+");'>添加留言</button>");
		stringBuffer.append("<input type='text' size='15' id='orderAds"+addcountnowid+"'><b id='orderAdsmgs"+addcountnowid+"' ></b> </div>");
		stringBuffer.append("<input type='hidden' id='mealcartid"+addcountnowid+"' value='"+goodsCartPojo.getCartId()+"'><input type='hidden' id='cartId"+goodsCartPojo.getCartId()+"' value='"+addcountnowid+"'>");
		stringBuffer.append("<input type='hidden' value='"+goodsInfoPojo.getGoodsPrice()+"' id='mealPrice"+addcountnowid+"'>");
		stringBuffer.append("<input type='hidden' value='"+goodsInfoPojo.getGoodsPrice()*goodsCartPojo.getGoodsNumber()+"' id='tinysun"+addcountnowid+"'></div></li>");
		return stringBuffer.toString();
	}
	/**
	 * 拼接新增的套餐
	 * @param goodsCartPojo
	 * @param addcountnowid
	 * @return
	 */
	public String addmealcart(GoodsCartPojo  goodsCartPojo,int addcountnowid){
	StringBuffer goodsName  =new StringBuffer();//套餐中美食的名字以及连接
	for (GoodsInfoPojo  goodsInfoPojo: goodsCartPojo.getMealPojo().getGoodsInfoPojo()) {
		goodsName.append("<a style='color: #000000; font-size: 15px;'  href='asossh/hotel!userShowgoods.action?goodsInfoPojo.goodsId="+goodsInfoPojo.getGoodsId()+"' title='"+goodsInfoPojo.getGoodsDis()+"' target='_blank' > "+goodsInfoPojo.getGoodsName()+"</a>&nbsp;");
	}
	String  MealName=goodsCartPojo.getMealPojo().getMealName();
	double MealPrice=goodsCartPojo.getMealPojo().getMealPrice();
	int    GoodsNumber=goodsCartPojo.getGoodsNumber();
	sumprice+=MealPrice*GoodsNumber;      //统计总价(在拼接出购物车的尾部时有用)
	
	StringBuffer  stringBuffer  = new StringBuffer();
	stringBuffer.append("<li id='mycartli"+addcountnowid+"'>");
	stringBuffer.append("<div style='font-size: 15px;'><input type='hidden' id='mealcartid"+addcountnowid+"' value='"+goodsCartPojo.getCartId()+"'>");
	stringBuffer.append("套餐名："+MealName+"<button type='button' class='mycatbuttontwo' onclick='daleteCart("+goodsCartPojo.getCartId()+","+addcountnowid+");'>删除</button>");
	stringBuffer.append("<div>"+goodsName+"</div>");
	stringBuffer.append("<div>单价:&yen;&nbsp;"+MealPrice+"<input type='hidden' id='cartId"+goodsCartPojo.getCartId()+"' value='"+addcountnowid+"'>");
	stringBuffer.append("<input type='hidden' value='"+MealPrice+"' id='mealPrice"+addcountnowid+"'>");
	stringBuffer.append("<input type='hidden' value='"+MealPrice*GoodsNumber+"' id='tinysun"+addcountnowid+"'>");
	stringBuffer.append("<div ><button type='button' class='mycatbutton' onclick='stickCut("+goodsCartPojo.getCartId()+","+addcountnowid+")' >-</button>");
	stringBuffer.append("<input type='text' size='5' id='number"+addcountnowid+"' value='"+GoodsNumber+"' onkeyup='stickupdate("+goodsCartPojo.getCartId()+","+addcountnowid+")'>");
	stringBuffer.append("<button type='button'class='mycatbutton' onclick='stickAdd("+goodsCartPojo.getCartId()+","+addcountnowid+")'>+</button>份");
	stringBuffer.append("</div><button type='button' class='mycatbutton' id='orderAdsbutton"+addcountnowid+"' onclick='orderAds("+goodsCartPojo.getCartId()+","+addcountnowid+")'>添加留言</button>");
	stringBuffer.append("<input type='text' size='15' id='orderAds"+addcountnowid+"'><b id='orderAdsmgs"+addcountnowid+"' ></b></div></li>");
	return stringBuffer.toString();
	}
	/**
	 * 拼接出购物车的尾部(显示总价)
	 */
	public String addshowmycart(int addcount ,double sumprice){
		StringBuffer  stringBuffer  = new StringBuffer();
		stringBuffer.append("<div id='mycartaddfoot'   ><input type='hidden' value='"+addcount+"' id='addcountid'><input type='hidden' id='prices' value='"+sumprice+"' >");
		stringBuffer.append("<input type='hidden' value='0' id='hiddencutcountid'>");
			stringBuffer.append("<label style='font-size: 18px; '>需支付:<font style='font-size: 20px; '>&yen;</font> <font id='sum'>"+sumprice+"</font>");
			stringBuffer.append("(总计:<font id='suncount'>"+addcount+"</font>份)</label><div align='center'><button type='button' id='subbutton' ");
			stringBuffer.append("onclick='javascript:window.location.href=asossh/cart!mycart.action'style=' width: 120px; height: 30px; border: 1px solid #aa7654; border-radius:10px 10px 10px 10px; text-align: center; font-family:仿宋; background: #82ce18; font-size: 20px; font-weight: bold;'"); 
			stringBuffer.append(">我的订单</button><button type='button' class='mycatbutton' onclick='handertrundledown();'style=' width: 80px; height: 30px; margin-left:20px;border: 1px solid #aa7654; border-radius:10px 10px 10px 10px; text-align: center; font-family:仿宋; background: #82ce18; font-size: 20px; font-weight: bold;'>其他 </button></div></div>");
		return stringBuffer.toString();
	}
	public double getSumprice() {
		return sumprice;
	}
	public void setSumprice(double sumprice) {
		this.sumprice = sumprice;
	}
	public String addCartIsemp() {
		return "<div id='isemptyldiv' style='width: 200px; height: 30px; font-family: 宋体; font-size: 20px;'>你的菜单空空如也……</div>";
	}
	
}
