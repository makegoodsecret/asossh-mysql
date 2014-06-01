package com.secret.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import org.apache.struts2.ServletActionContext;

import com.secret.config.SingletonConfig;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */

public class sendMail {
	 //发送邮件说明
	public   void emailshipment(String mail,String subject,String bodytext,String fileurl,String filname){
		Properties prop = SingletonConfig.getSingletonConfig().getEamilInfoPropertes();
		String  smtpHost = prop.get("smtpHost").toString(); //SMTP服务器名
		String  from = prop.get("mailName").toString(); 	//发信人地址
		String  pwd  = prop.get("pwd").toString();			//密码
		Properties props =  new Properties() ;				//创建Properties对象
		props.put("mail.smtp.host", smtpHost);				//创建邮件服务器
		props.put("mail.smtp.auth", "true");
		String  to   = mail;								//收信人地址
		Properties props1 =  new Properties() ;				//创建Properties对象
		props1.put("mail.smtp.host", smtpHost);				//创建邮件服务器
		props1.put("mail.smtp.auth", "true");
		Session session = Session.getDefaultInstance(props1,null);//取得默认的Session
		session.setDebug(true); //显示实时信息
		MimeMessage message = new MimeMessage(session);			//创建一条信息，并定义发信人地址和收信人地址
		try {
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address = {new InternetAddress(to)};
			message.setRecipients(Message.RecipientType.TO, address);
			message.setSubject(subject);				//设定主题
			message.setSentDate(new Date());			//设定发送时间
			Multipart mul= new MimeMultipart();	//创建一个对象存放多个BodyPart对象
			BodyPart mdp  = new MimeBodyPart(); //新建一个存放信件内容的BodyPart对象
			DataSource  source= new FileDataSource(fileurl+File.separator+filname);
			//DataSource  source= new FileDataSource("D:"+File.separator+"image_1374306849142.png");
			mdp.setDataHandler(new DataHandler(source));
			//mdp.setFileName("image_1374306849142.png");		//保存在邮件中当作附件
			mdp.setFileName(filname);
			mul.addBodyPart(mdp);				//将含有信件内容的BodyPart加入MimeMulitipart对象中
			mdp = new MimeBodyPart() ;
			mdp.setContent(bodytext,"text/html;charset=UTF-8") ;
			mul.addBodyPart(mdp) ;
			message.setContent(mul);
			message.saveChanges();						//保存发送信息
			Transport transport = session.getTransport("smtp"); //协议
			transport.connect(smtpHost, from, pwd);			//
			transport.sendMessage(message, message.getAllRecipients());
			transport.close();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	 
}
