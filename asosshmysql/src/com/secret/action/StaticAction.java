package com.secret.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.secret.ipAddress.ArrayProvinceCity;
import com.secret.ipAddress.GetIpAddr;
import com.secret.ipAddress.IPSeeker;
import com.secret.listener.SessionListener;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.UserPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class StaticAction extends ActionSupport {
	private static final long serialVersionUID = 1L;
	public static String    iptype  =getiptype();
	public static String   province =getprovince()  ;
	public static String   city  = getcity();
	public static String   useripaddress = getuseraddress();
	public static  String[] getaddress(){
		ServletContext context = ServletActionContext.getServletContext();
		String datFile = context.getRealPath("\\ipAddress");  //得到服务器端的地址
		IPSeeker ipFile=new IPSeeker("QQWry.Dat",datFile); 
		String   ipstr= new GetIpAddr().getIp(ServletActionContext.getRequest());  //得到外网的ip
		//ipstr="123.113.80.255";
		String address = ipFile.getIPLocation(ipstr).getCountry();
		String type = ipFile.getIPLocation(ipstr).getArea();
		String []  str = { address,type};
		return  str;
	}
	 
	//静态获取饭店的操作状态
	public static String  inhotelmain ="inhotelmain";   //进入饭店主界面
	public static String  inhotelgoods ="inhotelgoods"; //进入饭店的具体美食界面
	public static String  inhotelmeal  ="inhotelmeal";  //查看饭店的中套餐的界面
	public static String  inhotelseek  ="inhotelseek"; //在饭店中查询
	
	private static String getuseraddress(){
		String[] getaddress = getaddress();
		return  getaddress[0];
	}
	private static String getiptype() {
		String[] type = getaddress();
		return type[1];
	}

	private static String getcity() {
		String   city = "请选择"  ;
		String[] address = getaddress();
		String[] arrayCity = new ArrayProvinceCity().getArrayCity();
		for (String citystr : arrayCity) {
			if (address[0].contains(citystr)) {//当且仅当此字符串包含指定的 char 值序列时，返回 true。
				city=citystr;
			};
		}
		return city ;
	}

	public static String getprovince(){
		String   province = "请选择"  ;
		String[] address = getaddress();
		String[] arrayCity = new ArrayProvinceCity().getArrayProvince();
		for (String provincestr : arrayCity) {
			if (address[0].contains(provincestr)) {//当且仅当此字符串包含指定的 char 值序列时，返回 true。
				province=provincestr;
			};
		}
		return province ;
	}
	public static String useripaddress(String userassessip){
		String datFile = ServletActionContext.getServletContext().getRealPath("\\ipAddress");  //得到服务器端的地址
		IPSeeker ipFile=new IPSeeker("QQWry.Dat",datFile); 
		String address = ipFile.getIPLocation(userassessip).getCountry();
		return address;
	}
	//判断营业时间是否正在营业中
	public static boolean compareDate(Time startAM,Time endAM,Time startPM,Time  endPM ){
		Time time = new Time(new Date().getTime());
		return (comparetimedate(startAM,time)&&comparetimedate(time,endAM))||(comparetimedate(startPM,time)&&comparetimedate(time,endPM));
	}
	private static  boolean comparetimedate(Date time ,Date times){
		SimpleDateFormat f = new SimpleDateFormat("HHmmss"); //格式化为 hhmmss
		int d1Number = Integer.parseInt(f.format(time).toString()); //将第一个时间格式化后转为int
		int d2Number = Integer.parseInt(f.format(times).toString()); //将第二个时间格式化后转为int
		return (d1Number-d2Number)<0?true:false;
	}
	//将饭店的id注入session中
	public static void  sethotelsession(int hotelId,String hotelName){
		HttpSession session = ServletActionContext.getRequest().getSession();
		HotelPojo strsession =(HotelPojo) session.getAttribute("hotelPojosession");
		if (strsession!=null) {
			session.removeAttribute("hotelPojosession");
		}
		HotelPojo  hotelPojo  = new HotelPojo();
		hotelPojo.setHotelId(hotelId);
		hotelPojo.setHotelName(hotelName);
		session.setAttribute("hotelPojosession", hotelPojo);
	}
	//用户访问网站统计量
	public static String getcount(){
				long counts=0L;
				InputStream  is ;
				OutputStream fos ;
				 try {
					   HttpServletRequest requests = ServletActionContext.getRequest();
					   HttpSession session = requests.getSession();
					   Map<HttpSession, Integer> attributeMap = SessionListener.getAttributeMap();
					   if (!attributeMap.containsKey(session)) { //检测session是否存在，如果不存在移除后重新创建
						   session.invalidate();
						   session = ServletActionContext.getRequest().getSession(); //重新创建session
					}else{
					     String   ipstr= new GetIpAddr().getIp(requests);  //得到外网的ip
					     String struserIp = (String) session.getAttribute("userIp");
						 String realPath = ServletActionContext.getServletContext().getRealPath("assets/count.properties");
						 //从服务器上获取虚拟路径
						   is =  new FileInputStream(new File(realPath));
						Properties  prop  = new Properties() ;
						prop.load(is);
						String  count= (String) prop.get("webcount");
						 counts =Long.parseLong(count);
						UserPojo userPojosession = (UserPojo) session.getAttribute("user");
						if(struserIp==null){
							int countint = Integer.parseInt(count);
							if (userPojosession!=null) {
								if (!userPojosession.getPower().equals("1")) {//用户访问就增加一次
									counts =countint+1L;
								}
							}else{
								counts =countint+1L;
							}
							if (is!=null) {
								is.close();
							}
							  fos = new FileOutputStream(new File(realPath));
							   prop.setProperty("webcount", counts+"");
							   prop.store(fos, "徐凯的网站");
							   if (fos!=null) {
								fos.close();
							}
							session.setAttribute("userIp",ipstr ); 
					}
					}
				 } catch (Exception e) {
					e.printStackTrace();
				} 
				 return counts+"";
			}
}
