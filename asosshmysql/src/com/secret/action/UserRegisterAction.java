package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.FriendGroupPojo;
import com.secret.pojo.UserHeadPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.FriendGroupService;
import com.secret.service.UserHeadService;
import com.secret.service.UserService;
import com.secret.util.MD5Code;
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
public class UserRegisterAction extends BaseAction   {
	private UserService  userService;
	private UserPojo userPojo ;
	private  HttpSession   session  =ServletActionContext.getRequest().getSession();
	private HttpServletResponse response = ResponseSetCharacterEncoding.getInstance();	
	private UserHeadService  userHeadService;	 
	
	private FriendGroupService friendGroupService ;      
		/**
		 * 保存用户
		 */
		public void  save(){
			//对密码进行MD5加密
			MD5Code   md  = new MD5Code();
			userPojo.setPassword(md.getMD5ofStr(userPojo.getPassword()));
			userPojo.setEmailstatu("0");
			userPojo.setLevel(0);		//用户等级
			userPojo.setNumber(0);      //访问次数
			userPojo.setIntegral(0);
			userPojo.setTime(new Timestamp(new Date().getTime()));
			userPojo.setPower("0");
			userPojo.setUserLoginCity("zh"); //用户的登录城市
			UserHeadPojo userheandPojo  = new UserHeadPojo();
			userheandPojo.setHeadTime(new Timestamp(new Date().getTime()));
			//随机生成一个已有的头像
			int  headimage=(int) (Math.random()*11);
			String tigerimage= "tiger_"+headimage+".png";
			userheandPojo.setHeadImage(tigerimage);
			userheandPojo.setUserpojo(userPojo);
			boolean save = userHeadService.save(userheandPojo);
			//查处用户名的id用于发激活的邮件
			try {
				PrintWriter out = response.getWriter();
			  if (save) {
				  List<UserPojo>  list  =userService.findByEntity(userPojo); 
				  FriendGroupPojo groupPojo = new FriendGroupPojo();
				  groupPojo.setUserPojo(list.get(0));
				  groupPojo.setFriendGroupName("普通好友");
				  boolean saveorupdate = friendGroupService.saveorupdate(groupPojo);
				  if (saveorupdate) {
					  out.print(list.get(0).getUserId());
				}else{
					  out.print(0);
				}
			 }else{
				  out.print(0);
			}
			  out.flush();
			  out.close();
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			 
		}
		
		
		public UserService getUserService() {
			return userService;
		}
		public void setUserService(UserService userService) {
			this.userService = userService;
		}
		
		
		public UserPojo getUserPojo() {
			return userPojo;
		}
		public void setUserPojo(UserPojo userPojo) {
			this.userPojo = userPojo;
		}
		public HttpSession getSession() {
			return session;
		}
		public void setSession(HttpSession session) {
			this.session = session;
		}
		 
		public UserHeadService getUserHeadService() {
			return userHeadService;
		}
		public void setUserHeadService(UserHeadService userHeadService) {
			this.userHeadService = userHeadService;
		}
	 
		public FriendGroupService getFriendGroupService() {
			return friendGroupService;
		}

		public void setFriendGroupService(FriendGroupService friendGroupService) {
			this.friendGroupService = friendGroupService;
		}
		
		
}
