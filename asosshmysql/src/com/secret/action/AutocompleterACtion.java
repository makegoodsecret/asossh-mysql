package com.secret.action;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.pojo.HotelPojo;
import com.secret.pojo.SortPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.HotelService;
import com.secret.service.SortService;
import com.secret.service.UserService;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class AutocompleterACtion {
	private SortService  sortService  ;
	private SortPojo sortPojo  ;
	private HotelService  hotelService;
	private UserService   userService;
	private HotelPojo hotelPojo;
	private String sortName  ;			//智能填充物品的种类
	private String hotelName  ;        //智能填充饭店的种类
	private String userName ;			// 智能填充饭店的管理人员
	private HttpServletResponse  response ;
	private HttpServletRequest   request ;
	private PrintWriter  out  ;
	private void init(){
		try {
		//属性的初始化与乱码的处理
		request = ServletActionContext.getRequest();
		response= ServletActionContext.getResponse();
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=utf-8");				//处理json的乱码问题
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Cache-Control", "no-cache");			//禁止缓存
		response.setDateHeader("Expires", 0);
		out=response.getWriter();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	//填充物品的种类
	public void  Goodssortfill(){
				init();
			if(this.getSortName()==null){
				sortName="";
			}
			List<SortPojo> list;
			HotelPojo strsession =(HotelPojo) ServletActionContext.getRequest().getSession().getAttribute("hotelPojosession");
			if (strsession!=null) {
				HotelPojo hotelPojo2 = hotelService.findProperty("hotelId", strsession.getHotelId()).get(0);
				 list  = sortService.findProperty("hotelPojo",hotelPojo2);
			}else{
				list  = sortService.findAll();  //查找出所有的品牌
			}
			/**String 与StringBuffer的区别就是
			 * String一旦创建就不能被修改，而 StringBuffer可以修改
			 * */
			StringBuffer buffer  = new  StringBuffer();		
			for(int i=0;i<list.size();i++){
				if(list.get(i).getSortName().startsWith(sortName)){//判断是否存在包含输入的字符串
					if(buffer.length()!=0){
						buffer.append(",");
					}
					buffer.append("['"+list.get(i).getSortName()+"']");
				}
			}
			out.print("["+buffer+"]");
			out.flush();
			out.close();
	}
	//饭店填充
	public void  hotelfill(){
		init();
		if (this.getHotelName()==null) {
				hotelName="";
			}
			List<HotelPojo> hotellist = hotelService.findAll();
			
			StringBuffer buffers  = new StringBuffer();
			for (int i = 0; i <hotellist.size(); i++) {
				if (hotellist.get(i).getHotelName().startsWith(hotelName)) {
					if (buffers.length()!=0) {
						buffers.append(",");
					}
					buffers.append("['"+hotellist.get(i).getHotelName()+"']");
				}
			}
			out.print("["+buffers+"]");
			out.flush();
			out.close();
	}
	//根据饭店管理员查询出所有的饭店
	public void hotelUserName(){
		init();
		if (this.getHotelName()==null) {
				hotelName="";
			}
			UserPojo userPojo = (UserPojo) ServletActionContext.getRequest().getSession().getAttribute("user");
			List<HotelPojo> hotellist = hotelService.findProperty("userPojo", userPojo);  //根据饭店的管理员查询出所有管理的饭店
			StringBuffer buffers  = new StringBuffer();
			for (int i = 0; i <hotellist.size(); i++) {
				if (hotellist.get(i).getHotelName().startsWith(hotelName)) {
					if (buffers.length()!=0) {
						buffers.append(",");
					}
					buffers.append("['"+hotellist.get(i).getHotelName()+"']");
				}
			}
			out.print("["+buffers+"]");
			out.flush();
			out.close();
	}
	//人员填充
	public void hoteluser(){
		init();
		if (this.getUserName()==null) {
			userName="";
		}
		List<UserPojo> userList = userService.findAll();
		StringBuffer  buffer  = new StringBuffer();
		for (int i = 0; i < userList.size(); i++) {
			if (userList.get(i).getUsername().startsWith(userName)&&userList.get(i).getPower().equals("0")) {  //不填充管理员
				if (buffer.length()!=0) {
					buffer.append(",");
				}
				buffer.append("['"+userList.get(i).getUsername()+"']");
			}
		}
		out.print("["+buffer+"]");
		out.flush();
		out.close();
		
	}
	
	
	public UserService getUserService() {
		return userService;
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public SortService getSortService() {
		return sortService;
	}
	public void setSortService(SortService sortService) {
		this.sortService = sortService;
	}
	public SortPojo getSortPojo() {
		return sortPojo;
	}
	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}
	public String getSortName() {
		return sortName;
	}
	public void setSortName(String sortName) {
		this.sortName = sortName;
	}
	public HttpServletResponse getResponse() {
		return response;
	}
	public void setResponse(HttpServletResponse response) {
		this.response = response;
	}
	public HttpServletRequest getRequest() {
		return request;
	}
	public void setRequest(HttpServletRequest request) {
		this.request = request;
	}
	public PrintWriter getOut() {
		return out;
	}
	public void setOut(PrintWriter out) {
		this.out = out;
	}
	public String getHotelName() {
		return hotelName;
	}
	public void setHotelName(String hotelName) {
		this.hotelName = hotelName;
	}
	public HotelService getHotelService() {
		return hotelService;
	}
	public void setHotelService(HotelService hotelService) {
		this.hotelService = hotelService;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
}
