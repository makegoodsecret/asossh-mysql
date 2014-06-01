package com.secret.action;


import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
@SuppressWarnings("serial")
public class BaseAction extends ActionSupport {
		//用来接受页面上的参数set  ,get方法
	
	private int  page   ;				//页码
	
	//对上传图片的方法进行封装
	private File images;			//图片
	private String imagesFileName;  //文件名
	private String imagesContentType  ; //文件的类型
	private String imagesPath  ; // 该路径就是项目下保存的文件全路径及Upload/"+imagesFileName;
	private String  realPath  ;  //从服务器上获取项目部署后，所在的绝对路径
	
	//修改图片
	private String imagesname ;   //修改的图片名称
	
	private String   elsemessage  ;  //需要提示的信息
    private	String   redirecturl   ;  //重定项后的路径
    private boolean  messagestatu  ;  //提示信息是否为错误信息
 
    

	
	//保存图片的方法
	public String saveimage(){
		// 获取文件的后缀
		int index  = imagesFileName.lastIndexOf(".");
		String iName  = imagesFileName.substring(index);
		//将文件后缀全部修改为小写
		iName=iName.toLowerCase();
		//保存文件名（加上时间戳避免文件名的重复
		String imagesName  = "image_"+System.currentTimeMillis()+iName;
		imagesPath  ="photo/"+imagesName;
		realPath  = getRealPath(imagesPath);
		try{
			//从服务器上的临时文件的缓存中读取文件
			BufferedInputStream bis= new BufferedInputStream(new FileInputStream(images));
			BufferedOutputStream bos  = new BufferedOutputStream(new FileOutputStream(realPath));
			 IOUtils.copy(bis, bos);
		}catch(Exception e){
			e.printStackTrace();
		}
		return imagesName ; //保存后的图片名称
	}
	
	
	//修改图片的方法
	public String updateimage(){
		//获取文件的后缀
		imagesPath =  "photo/"+this.getImagesname();
		realPath  = getRealPath(imagesPath);
		try{
			//从服务器上的临时文件的缓存中读取文件
			BufferedInputStream bis  = new BufferedInputStream(new FileInputStream(images));
			BufferedOutputStream bos  = new BufferedOutputStream (new FileOutputStream(realPath));
			IOUtils.copy(bis, bos);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	return this.getImagesname();	
	}
	//从服务器上获取项目部署后，所在的绝对的方法
	public String  getRealPath(String path){
		//获取application对象
		ServletContext  application  = ServletActionContext.getServletContext();
		return  application.getRealPath(path);
		
	}
	
	 
	
	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page ;
	}
	public File getImages() {
		return images;
	}
	public void setImages(File images) {
		this.images = images;
	}
	public String getImagesFileName() {
		return imagesFileName;
	}
	public void setImagesFileName(String imagesFileName) {
		this.imagesFileName = imagesFileName;
	}
	public String getImagesContentType() {
		return imagesContentType;
	}
	public void setImagesContentType(String imagesContentType) {
		this.imagesContentType = imagesContentType;
	}
	public String getImagesPath() {
		return imagesPath;
	}
	public void setImagesPath(String imagesPath) {
		this.imagesPath = imagesPath;
	}
	public String getRealPath() {
		return realPath;
	}
	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}
	public String getImagesname() {
		return imagesname;
	}
	public void setImagesname(String imagesname) {
		this.imagesname = imagesname;
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
