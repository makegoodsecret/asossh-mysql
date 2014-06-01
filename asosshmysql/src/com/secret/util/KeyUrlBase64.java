package com.secret.util;

import org.apache.commons.codec.binary.Base64;

/**
 * 对url通过get提交的方式进行Base64加密
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class KeyUrlBase64 {
	 public static void main(String[] args) {
		KeyUrlBase64 base64 = new KeyUrlBase64();
		String setkey = base64.setkey("徐凯");
		System.out.println("miwen==== "+setkey);
		String getvalue = base64.getvalue(setkey);
		System.out.println(getvalue);
	}
	 
	 /**
	  * 解密
	  * @return
	  */
	public static String getvalue(String value){
		byte[] bytes = value.getBytes();
		byte[] decodeBase64 = Base64.decodeBase64(bytes);
		return  new String(decodeBase64);
	}
	/**
	 * 加密
	 */
	public static String  setkey(String key){
		byte[] bytes = key.getBytes();
		byte[] encodeBase64 = Base64.encodeBase64(bytes);
		return  new String(encodeBase64);
	}
	 
	 
}
