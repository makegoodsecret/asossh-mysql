package com.secret.action;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.dbcp.BasicDataSource;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.ApplicationContext;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.context.support.XmlWebApplicationContext;

import com.secret.listener.SessionIsUserLogin;
import com.secret.listener.SessionListener;
import com.secret.pojo.UserPojo;
import com.secret.service.CallMeSocketService;
import com.secret.service.FriendGroupService;
import com.secret.service.UserHeadService;
import com.secret.service.UserService;
import com.secret.service.impl.CallMeSocketServiceImpl;
import com.secret.socketcallme.CallMeEchoServlet;
import com.secret.socketcallme.CallMeMessageInbound;
import com.secret.util.MD5Code;
import com.secret.util.ResponseSetCharacterEncoding;
import com.secret.util.sendMail;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class UserloginAction extends BaseAction   {
	private UserService  userService;
	private UserPojo userPojo ;
	private  HttpSession   session  =ServletActionContext.getRequest().getSession();
	private HttpServletResponse response = ResponseSetCharacterEncoding.getInstance();	
	private  HttpServletRequest  request = ServletActionContext.getRequest();;
	private UserHeadService  userHeadService;	 
	
	private FriendGroupService friendGroupService ;      
	private String    code  ;
	private String   treatytext;
	private String useremail ;
	
	private CallMeSocketService callMeSocketService ;
	 
	
	private BasicDataSource  dataSource ;
	
	
	 public BasicDataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(BasicDataSource dataSource) {
		this.dataSource = dataSource;
	}

		/**
	 	 * Ajax用户登录
	 	 */
	public void   userAjaxlogin(){
		try {
			PrintWriter out  = response.getWriter();
				MD5Code  md  = new MD5Code();
				userPojo.setPassword(md.getMD5ofStr(userPojo.getPassword()));
				List<UserPojo> list=userService.findDoubleProperty("username", userPojo.getUsername(),"password", userPojo.getPassword());
				Map<String,Object> map  = new HashMap<String, Object>();
				if(list.size()==1){
					userPojo=list.get(0);
					userPojo.setNumber(list.get(0).getNumber()+1);
					boolean update = userService.update(userPojo);
					if (update) {
						/**用户是否已经登录*/
						SessionIsUserLogin.isUserLoginExist(session,userPojo);
						map.put("username", userPojo.getUsername() );
						map.put("emailstatu", userPojo.getEmailstatu() );
						map.put("email", userPojo.getEmail() );
						map.put("power", userPojo.getPower() );
						map.put("isloginstatu", "true");
						/**向好友推送上线*/
						callMeSocketService.sendUserFriendMeUp(userPojo.getUserId());
					}else{
						map.put("isloginstatu", "false");
					}
				}else{
					map.put("isloginstatu", "false");
				}
				JSONObject jsonObject  = JSONObject.fromObject(map);
				out.print(jsonObject.toString());
				out.flush();
				out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	private String loginname;
	private String name;
	
	public String getLoginname() {
		return loginname;
	}

	public void setLoginname(String loginname) {
		this.loginname = loginname;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String userexists(){
		System.out.println("username=");
		return "success";
	}
		/**
		 * 用户登录
		 */
		public void   userexist(){
			//测试数据库
			//String driverClassName = dataSource.getDriverClassName();
			//System.out.println("driverClassName="+driverClassName);
			try {
				PrintWriter out  = response.getWriter();
					MD5Code  md  = new MD5Code();
					userPojo.setPassword(md.getMD5ofStr(userPojo.getPassword()));
					List<UserPojo> list=userService.findDoubleProperty("username", userPojo.getUsername(),"password", userPojo.getPassword());
					if(list.size()==1){
						/**
						 * 修改用户的登录次数
						 */
						list.get(0).setNumber(list.get(0).getNumber()+1);
						boolean update = userService.update(list.get(0));
						if (update) {
							/**用户是否已经登录*/
							SessionIsUserLogin.isUserLoginExist(session,list.get(0));
							out.print("true");
							/**向好友推送上线*/
							callMeSocketService.sendUserFriendMeUp(list.get(0).getUserId());
						}else{
							out.print("false");
						}
					}else{
						out.print("false");
					}
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		/**
		 *  管理员登录
		 */
		public void   adminuserexist(){
			try {
				PrintWriter out  = response.getWriter();
				userPojo.setPassword(new MD5Code().getMD5ofStr(userPojo.getPassword()));
				List<UserPojo> list=userService.findDoubleProperty("username", userPojo.getUsername(),"password", userPojo.getPassword());
				if(list.size()==1){
					/**用户是否已经登录*/
					SessionIsUserLogin.isUserLoginExist(session,list.get(0));
					out.print("true");
					/**向好友推送上线*/
					callMeSocketService.sendUserFriendMeUp(list.get(0).getUserId());
				}else{
					out.print("false");
					}
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		/**
		 * 用户注销登陆
		 * @return
		 */
		public String  outlogin(){
			Map<HttpSession, Integer> attributeMap = SessionListener.getAttributeMap();
			if (attributeMap.containsKey(session)) {
				Integer integer = attributeMap.get(session);
				Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
				if (userIdSocketMap.containsKey(integer)) {
					CallMeMessageInbound  callMeMessageInbound = userIdSocketMap.get(integer);
					  try {
						  if ( CallMeEchoServlet.getSocketList().contains(callMeMessageInbound)) {
							  /**好友离线推送*/
							  callMeSocketService.userFriendOutloginSend(callMeMessageInbound);
						  }
						  } catch (IOException e) {
					  }
				}
				attributeMap.put(session, null);//移除之前登录的用户
			}
			session.removeAttribute("user");
			return "userlogin";
		}
		/**
		 * 管理员注销登陆
		 * @return
		 */
		public String  adminoutlogin(){
			Map<HttpSession, Integer> attributeMap = SessionListener.getAttributeMap();
			if (attributeMap.containsKey(session)) {
				Integer integer = attributeMap.get(session);
				Map<Integer, CallMeMessageInbound> userIdSocketMap = CallMeEchoServlet.getUserIdSocketMap();
				if (userIdSocketMap.containsKey(integer)) {
					CallMeMessageInbound  callMeMessageInbound = userIdSocketMap.get(integer);
					  try {
						  if ( CallMeEchoServlet.getSocketList().contains(callMeMessageInbound)) {
							  /**好友离线推送*/
							  callMeSocketService.userFriendOutloginSend(callMeMessageInbound);
						  }
						  } catch (IOException e) {
					  }
				}
				attributeMap.put(session, null);//移除之前登录的用户
			}
			session.removeAttribute("user");
					return "adminoutlogin";
				}
		/**
		 * 验证用户名是否已经存在
		 */
		public void checkgister(){
			
			try {
				PrintWriter  out  = response.getWriter();
				List<UserPojo> list =userService.findProperty("username", userPojo.getUsername());
				if(list.size()==0){
					out.print(true);
				}else{
					out.print(false);
				}
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		/**
		 * 用户注册时的协议
		 * @return
		 */
		public String gettreaty(){
			//读取协议文件
			ServletContext appliction  = ServletActionContext.getServletContext();
			File file  = new File(appliction.getRealPath("user/treaty.txt"));
			FileReader  reader;
			try {
				reader= new FileReader(file);
				char[] cbuf= new char[(int)file.length()];
				reader.read(cbuf);
				reader.close();
				String[] str  = new String(cbuf).split("&&");   //结束标记
				treatytext=str[0];
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "treaty";
		}
		/**
		 * 验证邮箱是否注册
		 */
		public void useremail(){
			try {
				PrintWriter  out  = response.getWriter();
				List<UserPojo> userpojoemail = userService.findProperty("email", useremail);
				if(userpojoemail.size()==0){
					out.print(true);
				}else{
					out.print(false);
				}
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		/**
		 * 验证码
		 */
		public void code(){
			try {
				PrintWriter  out  = response.getWriter();
				String  rand = (String) session.getAttribute("rand");
				if(code.equals(rand)){
					out.print(true);
				}else{
					out.print(false);
				}
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		/**
		 * 通过邮件发激活链接
		 * @param id
		 */
		public String getemail(){
				userPojo= userService.findProperty("userId", userPojo.getUserId()).get(0);
				String path = request.getContextPath();
				String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
				String url=basePath+"/asossh/userlogin!EMailActivaytion.action?userPojo.userId="+userPojo.getUserId();
				StringBuffer stringBuffer  = new StringBuffer();
				stringBuffer.append("<html><body ><div class='classmain'><div>闻到食府网用户激活页面</div><div style='font-size: 20px;'>");
				stringBuffer.append("<label >"+userPojo.getUsername()+"你好，欢迎你成为闻到食府网的一员，现需你激活你的帐号</label>，请点击<a href='"+url+"'>激活</a><br>");
				stringBuffer.append("如果没有反应请复制链接<a href='"+url+"' >"+url+"</a></div></div></body></html>");
				String path2 = ServletActionContext.getServletContext().getRealPath("image/tiger");
				new sendMail().emailshipment(userPojo.getEmail(), "闻到食府网用户激活邮箱",stringBuffer.toString(),path2,userPojo.getUserHeadPojo().getHeadImage()); 
			return "userlogin";
			}
		
		/**
		 * 邮箱激活用户
		 * @return
		 */
		public String  EMailActivaytion(){
			UserPojo user=(UserPojo)session.getAttribute("user");
			if (user!=null) {
				session.removeAttribute("user");   //注销该用户 
			}
			List<UserPojo> list=userService.findProperty("userId", userPojo.getUserId());
			list.get(0).setEmailstatu("1");
			if(userService.update(list.get(0))){
				return "globalemailactivaytionsuccess";
			}
			return  "globalemailactivaytionerror";
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
		public String getCode() {
			return code;
		}
		public void setCode(String code) {
			this.code = code;
		}
		public String getTreatytext() {
			return treatytext;
		}
		public void setTreatytext(String treatytext) {
			this.treatytext = treatytext;
		}
		public String getUseremail() {
			return useremail;
		}
		public void setUseremail(String useremail) {
			this.useremail = useremail;
		}

		public FriendGroupService getFriendGroupService() {
			return friendGroupService;
		}

		public void setFriendGroupService(FriendGroupService friendGroupService) {
			this.friendGroupService = friendGroupService;
		}

		public void setCallMeSocketService(CallMeSocketService callMeSocketService) {
			this.callMeSocketService = callMeSocketService;
		}

		public CallMeSocketService getCallMeSocketService() {
			return callMeSocketService;
		}
		
		
}
