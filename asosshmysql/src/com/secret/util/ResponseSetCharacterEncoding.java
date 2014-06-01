package com.secret.util;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class ResponseSetCharacterEncoding {
	
	private static HttpServletResponse  response  ;
	private static ResponseSetCharacterEncoding characterEncoding =null;
	private ResponseSetCharacterEncoding() {
		response = ServletActionContext.getResponse();
		response.setContentType("text/html;charset=utf-8");				//处理json的乱码问题
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");			//禁止缓存
		response.setDateHeader("Expires", 0);
	}
	
	public static  HttpServletResponse  getInstance(){
		if (characterEncoding == null) {
				new ResponseSetCharacterEncoding();
		}
		return response;
	}
	
	
	
}
