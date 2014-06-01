package com.secret.interceptor;

 

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.util.ValueStack;
import com.secret.pojo.UserPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class LoginedCheckInterceptor extends  AbstractInterceptor {
	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
	/*	ValueStack stack = invocation.getStack();
		Object findValue = stack.findValue("ognl");
		*/
		//获取请求的URL
		String  url  =ServletActionContext.getRequest().getRequestURI().toString();
		 UserPojo  userPojo  =null; 
		 int index  =0 ;
		  //验证session是否过期
		 if (!ServletActionContext.getRequest().isRequestedSessionIdValid()) {
			//session过期,转向session过期提示页,最终跳转至登录页面
				return "globaluserloginnotsession";
		}else{
			//对登录与注销请求直接放行，不予拦截
			if (url.indexOf("outlogin.action")!=-1) {
			  return invocation.invoke();
			}else{
				 userPojo =(UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user");
				 if (userPojo==null) {
					//尚未登录，跳转至登录界面
					return "globaluserlogin";
				}else{
					//功能模块与权限位映射，部分可能与前台请求重名的请求加命名空间以示区别(本网站的主要权限在于网站管理员与饭店的管理员)
					 if(url.indexOf("/goods!")!=-1){ //上传菜谱与管理
						index=1;
					}else if(url.indexOf("/hotel!")!=-1){ //饭店管理
						index=1;
					}else if(url.indexOf("/admSort!")!=-1){ //种类管理
						index=1;
					}else if(url.indexOf("/ads!")!=-1){ //广告管理
						index=1;
					}else if(url.indexOf("/seller!")!=-1){ //卖家模块
						index=1;
					}else if(url.indexOf("/hotelmanage!")!=-1){ //饭店管理
						index=1;
					} else if(url.indexOf("/reportForms!")!=-1||url.indexOf("/exampleAction!")!=-1){ //饭店管理
						index=1;
					} 
					//取出当前用户操作权限操作
					 String prower = userPojo.getPower().trim();
					 String emailstatu = userPojo.getEmailstatu();
					if (index>0) {  //需要区分是普通用户还是管理员（包括网站管理员与饭店管理员）
						if (prower.equals("1")||(prower.equals("0")&&(Integer.parseInt(emailstatu)>=2))) {
							return invocation.invoke();
						}else{
							//权限不足
							return "globaluserloginnotpower";
						}
					}else{
					/*	String invoke = invocation.invoke();//拦截器不能自定义result
						String invokeActionOnly = invocation.invokeActionOnly();//拦截器能自定义result
						*/
						//其他不需要权限验证的请求直接放行
						return invocation.invoke();
					}
				}
			}
		}
		 
	}

	@Override
	public void init() {
		 
		super.init();
	}

	@Override
	public void destroy() {
	 
		super.destroy();
	}
 
 

}
