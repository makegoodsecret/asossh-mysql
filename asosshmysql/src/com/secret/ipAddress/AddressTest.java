package com.secret.ipAddress;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;




public class AddressTest {
	public AddressTest(){
		myaddress();
	}
	public void   myaddress(){
		//IPSeeker ip=new IPSeeker("QQWry.Dat","D:\\address");
		ServletContext context = ServletActionContext.getServletContext();
		String datFile = context.getRealPath("\\ipAddress");  //得到服务器端的地址
		//System.out.println("datFile="+datFile); //D:\Program FilesMyEclipse10\apache-tomcat-6.0.36\webapps\ASOSSH\ipAddress
		IPSeeker ipFile=new IPSeeker("QQWry.Dat",datFile); 
		//获得地区
		String   ipstr=getIpAddr(ServletActionContext.getRequest());  //得到外网的ip
		String address = ipFile.getIPLocation(ipstr).getCountry();
		//获得类型
		String type = ipFile.getIPLocation(ipstr).getArea();
	/*	System.out.println("address=="+address);
		System.out.println("type=="+type);*/
	}
	//获取外网的ip
	private static String getIpAddr(HttpServletRequest request) {     
		      String ip = request.getHeader("x-forwarded-for");     
		      if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
		         ip = request.getHeader("Proxy-Client-IP");     
		     }     
		      if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
		         ip = request.getHeader("WL-Proxy-Client-IP");     
		      }     
		     if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {     
		          ip = request.getRemoteAddr();     
		     }     
		     return ip;     
		}   
}
