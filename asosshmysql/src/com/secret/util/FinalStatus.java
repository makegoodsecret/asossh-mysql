package com.secret.util;

/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class FinalStatus {
	public static final   int  ISMEAL  = 0 ;		//是套餐
	public static final   int  ISGOODS = 1 ;        //是美食
	 
	public static final   String  ISORDERADDRESSSTATUS="1" ; //是默认的收货地址
	public static final   String  NOTORDERADDRESSSTATUS="0"; //不是默认的收货地址
	
	//支付宝操作状态
	public static final   String    WAIT_BUYER_PAY ="WAIT_BUYER_PAY"; 						//交易创建,没有付款
	public static final   String    WAIT_SELLER_SEND_GOODS ="WAIT_SELLER_SEND_GOODS"; 		//付款成功，但卖家没有发货
	public static final   String    WAIT_BUYER_CONFIRM_GOODS ="WAIT_BUYER_CONFIRM_GOODS";   //卖家已经发了货，但买家还没有做确认收货
	public static final   String    TRADE_FINISHED="TRADE_FINISHED";    					//交易成功，未评价
	public static final   String    TRADE_SUCCESS ="TRADE_SUCCESS"; 						//支付成功
	public static final   String    TRADE_CLOSED ="TRADE_CLOSED";  							 //交易关闭
	public static final  String    SUCCESS ="SUCCESS";										//未知的true的操作
	public static final  String    USER_ASSESS_SUCCESS ="USER_ASSESS_SUCCESS";			    //用户已经评价
	
	//用户好友的状态
	public static final String  FRIENDSATUTSDELETE   ="0";    //用户删除了该好友
	public static final String  FRIENDSATUTSCOMMON   ="1";   //普通好友的关系
	public static final String  FRIENDSATUTSCRONY    ="2";   //密友
	public static final String  FRIENDSATUTSBLACKLIST="3";   //黑名单好友
	public static final String  FRIENDSATUTSSTANGER  ="4";   //陌生人
	
}
