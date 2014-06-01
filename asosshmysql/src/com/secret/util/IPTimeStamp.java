package com.secret.util;
import java.text.SimpleDateFormat;
import java.util.*;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class IPTimeStamp {
	
	public IPTimeStamp() {

	}
	public String ipTimeStack(String ip) {
		Date date = new Date() ;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmSSsss") ;
		
		String ipts = "" ;
		String[] ips = ip.split("\\.") ;
		for(int i = 0 ; i < ips.length ; i++){
			ipts =  ipts + addZero(ips[i]);
		}
		ipts = ipts + sdf.format(date) ;
		Random rand = new Random() ;
		
		ipts = ipts + addZero(rand.nextInt(1000)+"") ;
		
		return ipts ;
	}
	public String addZero(String str){
		for(int i = str.length() ; i < 3 ; i++){
			str = "0" + str ;
		} 
		return str ;
	}
	public static void main(String strs[]) {
		IPTimeStamp ipt = new IPTimeStamp() ;
		System.out.println(ipt.ipTimeStack("127.0.0.1")+"***"+ipt.ipTimeStack("127.0.0.1").length()) ;
	}
}
