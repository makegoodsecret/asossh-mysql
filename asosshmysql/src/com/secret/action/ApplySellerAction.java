package com.secret.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.page.base.PageView;
import com.secret.pojo.ApplySellerPojo;
import com.secret.pojo.UserPojo;
import com.secret.service.ApplySellerService;
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
public class ApplySellerAction extends BaseAction {
		
	private ApplySellerService   applySellerService;
	private ApplySellerPojo    applySellerPojo ;
	private List<ApplySellerPojo> applySellerList;
	private PageView<ApplySellerPojo>  pageView ;
	private HttpServletResponse response =   ResponseSetCharacterEncoding.getInstance();
	//保存申请饭店有关的商标logo与证书
		public void   saveapplySellerimage(){
			String image = super.saveimage();
			try {
				PrintWriter out = response.getWriter();
				out.print(image);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 修改饭店的商标与证书
		public void updataapplySellerimage(){
			String image = super.updateimage();
			try {
				PrintWriter out = response.getWriter();
				out.print(image);
				out.flush();
				out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	
	//保存申请
	public String saveapplySeller(){
		applySellerPojo.setApplysellerStatus("0");
		applySellerPojo.setApplysellerTime(new Timestamp(new Date().getTime()));
		applySellerPojo.setUserPojo((UserPojo)ServletActionContext.getRequest().getSession().getAttribute("user"));
		applySellerService.merge(applySellerPojo);
		return "success";
	}
	//处理申请
	public String updateapplystatus(){
		sendapplySeller(); //处理申请
		
		return pageing();
	}
	
	private synchronized void sendapplySeller() {
		ApplySellerPojo applySellerPojo2 = applySellerService.findProperty("applysellerId", applySellerPojo.getApplysellerId()).get(0);
		applySellerPojo2.setApplysellerStatus(applySellerPojo.getApplysellerStatus());
		applySellerService.update(applySellerPojo2);
		UserPojo userPojo = applySellerPojo2.getUserPojo();
		String mail=userPojo.getEmail();
		HttpServletRequest request = ServletActionContext.getRequest();
		String path = request.getContextPath();
		String basePath=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
		StringBuffer  stringBuffer ;
		if (applySellerPojo.getApplysellerStatus().equals("y")) { //审核通过发邮件激活
			stringBuffer  = new StringBuffer();
			stringBuffer.append("<html><body ><div class='classmain'><div>闻到食府网卖家处理页面</div><div style='font-size: 20px;'>");
			stringBuffer.append("<label >你的卖家申请</label>已经通过，请点击<a href='"+basePath+"asossh/userinfo!EMailhotel.action?userPojo.userId="+userPojo.getUserId()+"'>激活</a><br>");
			stringBuffer.append("如果没有反应请复制链接<a href='"+basePath+"asossh/userinfo!EMailhotel.action?userPojo.userId="+userPojo.getUserId()+"' >"+basePath+"asossh/userinfo!EMailhotel.action?userPojo.userId="+userPojo.getUserId()+"</a></div></div></body></html>");
			String path2 = ServletActionContext.getServletContext().getRealPath("photo");
			new sendMail().emailshipment(mail,"闻到食府网申请卖家处理", stringBuffer.toString(),path2,applySellerPojo2.getApplysellerCertificate()); 
		}else{ //审核未通过发邮件说明
			stringBuffer  = new StringBuffer();
			stringBuffer.append("<html><body   ><div class='classmain'><div>闻到食府网卖家处理页面</div><div style='font-size: 20px;'>");
			stringBuffer.append("<label >你的卖家未通过申请</label>");
			stringBuffer.append("</div></body></html>");
			String path2 = ServletActionContext.getServletContext().getRealPath("photo");
			new sendMail().emailshipment(mail,"闻到食府网申请卖家处理", stringBuffer.toString(),path2,applySellerPojo.getApplysellerCertificate()); 
		}
		
	}
	//管理员查询出 
	public String showapply(){
		pageView= new PageView<ApplySellerPojo>(5, 0);
		LinkedHashMap<String, String> apply = new LinkedHashMap<String, String>();
		apply.put("applysellerStatus", "asc");
		apply.put("applysellerTime", "desc");
		pageView.setQueryResult(applySellerService.getScrollData(pageView.getFirstResult(), 5,apply));
		super.setPage(0);
		return "showapply";
	}
	//点击页码
	public String pageing() {
		pageView= new PageView<ApplySellerPojo>(5, super.getPage());
		LinkedHashMap<String, String> apply = new LinkedHashMap<String, String>();
		apply.put("applysellerStatus", "asc");
		apply.put("applysellerTime", "desc");
		pageView.setQueryResult(applySellerService.getScrollData(pageView.getFirstResult(), 5,apply));
		return "showapply";
	}
	public ApplySellerService getApplySellerService() {
		return applySellerService;
	}
	public void setApplySellerService(ApplySellerService applySellerService) {
		this.applySellerService = applySellerService;
	}
	public ApplySellerPojo getApplySellerPojo() {
		return applySellerPojo;
	}
	public void setApplySellerPojo(ApplySellerPojo applySellerPojo) {
		this.applySellerPojo = applySellerPojo;
	}
	public List<ApplySellerPojo> getApplySellerList() {
		return applySellerList;
	}
	public void setApplySellerList(List<ApplySellerPojo> applySellerList) {
		this.applySellerList = applySellerList;
	}
	public PageView<ApplySellerPojo> getPageView() {
		return pageView;
	}
	public void setPageView(PageView<ApplySellerPojo> pageView) {
		this.pageView = pageView;
	}
	
	
	
}
