package com.secret.config;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

import org.apache.struts2.ServletActionContext;


/**
 * 使用单例模式初始化参数--饿汉模式
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class SingletonConfig {
 
	private   static SingletonConfig singletonConfig = new SingletonConfig();
	
	private Properties  eamilInfoPropertes;
	private Properties   alipayinfoProperties;
	 private SingletonConfig(){
		 configinfo(); //初始化网站参数
	 }
	 public static SingletonConfig getSingletonConfig(){
		 return singletonConfig;
	 }
	
	 private void configinfo(){
		 configemail();//初始化发件人配置文件
		 configaliApiInfo(); //支付宝接口
	 }
	  private void configaliApiInfo() {
		  try {
			  alipayinfoProperties= new Properties();
			  alipayinfoProperties.load(getProerties("assets/alipayAPIInfo.properties"));	
			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	 private InputStream getProerties(String file){
		 InputStream inputStream = null;
		 try {
			  inputStream = new FileInputStream(new File(ServletActionContext.getServletContext().getRealPath(file)));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		   return inputStream;
	 }
	  
	 
	private void configemail(){
		  try {
			  eamilInfoPropertes= new Properties();
			  eamilInfoPropertes.load(getProerties("assets/mailInfo.properties"));	
			} catch (IOException e) {
				e.printStackTrace();
			}
	  }
	  /** 读取发件人 */
	public Properties getEamilInfoPropertes() {
		return eamilInfoPropertes;
	}
	/**读取支付宝*/
	public Properties getAlipayinfoProperties() {
		return alipayinfoProperties;
	}
	
	 
}
