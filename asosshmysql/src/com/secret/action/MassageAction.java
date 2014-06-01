package com.secret.action;


import java.io.IOException;
import java.io.PrintWriter;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.secret.util.ResponseSetCharacterEncoding;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class MassageAction extends ActionSupport {
	private String   elsemessage  ;  //需要提示的信息
    private	String  redirecturl;    //重定项后的路径
    private boolean messagestatu ;  //提示信息是否为错误信息
    
    
    
	//用户没有登录
	public String  userloginmethod() throws Exception{
		this.setElsemessage("对不起你长时间不再线已经为你下线，请你重新登录。");
		this.setRedirecturl("user/userlogin.jsp");
		messagestatu=true;
		return super.execute();
	}
	//session失效
	public String userloginnotsessionmethod() throws Exception{
		 this.setElsemessage("对不起你长时间不再线已经为你下线，请你重新登录。");
		 this.setRedirecturl("user/userlogin.jsp");     //跳回他之前操作的页面
		 messagestatu=true;
		return super.execute();
	}
	//权限不足
	public String userpowermethod() throws Exception{
		this.setElsemessage("对不起你当前的权限不足，不能进行此项操作");
		this.setRedirecturl(ServletActionContext.getRequest().getHeader("Referer"));   //跳回他之前操作的页面
		messagestatu=true;
		return super.execute();
	}
	//用户激活
	public String emailactivaytion() throws Exception{
		 this.setElsemessage("恭喜你，你的账户已经激活。");
		 this.setRedirecturl("user/userlogin.jsp");     //跳回登录页面
		 messagestatu=false;
		return super.execute();
	}
	//用户激活失败
	public String emailactivaytionerror() throws Exception{
		this.setElsemessage("对不起，邮箱激活失败");
		this.setRedirecturl("index.jsp");     //跳回首页
		messagestatu=true;
		return super.execute();
	}
	
	//请求的资源不存在
	public String requestIsExist() throws Exception{
		this.setElsemessage("对不起，你请求的资源不存在");
		this.setRedirecturl("index.jsp");     //跳回首页
		messagestatu=true;
		return super.execute();
	}
	public String getElsemessage() {
		return elsemessage;
	}
	public void setElsemessage(String elsemessage) {
		this.elsemessage = elsemessage;
	}
	public String getRedirecturl() {
		return redirecturl;
	}
	public void setRedirecturl(String redirecturl) {
		this.redirecturl = redirecturl;
	}
	public boolean isMessagestatu() {
		return messagestatu;
	}
	public void setMessagestatu(boolean messagestatu) {
		this.messagestatu = messagestatu;
	}
	
}
