package com.secret.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.secret.page.base.PageView;
import com.secret.pojo.AdsPojo;
import com.secret.service.AdsService;
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
public class AdsAction  extends BaseAction {
	private AdsService  adsService ;
	private AdsPojo adsPojo  ;
	private List<AdsPojo> adsList ;			// 使用与分页显示
	private PageView<AdsPojo> pageView   ;
	private HttpServletResponse response =  ResponseSetCharacterEncoding.getInstance();
	
	//长传广告的图片
	public void   saveadsimage(){
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
	// 修改广告的图片
	public void updataadsimage(){
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
	//保存广告
	public String save(){
		adsPojo.setAdsImage(super.saveimage());
		adsPojo.setAdsTime(new Timestamp(new Date().getTime()));
		adsService.save(adsPojo);
		show();
		return "success";
	}
	//显示上传广告
	public String upads(){
		return "upads";
	}
	//显示广告
	public String show(){
		 pageView=new PageView<AdsPojo>(5, 0);
		 pageView.setQueryResult(adsService.getScrollData(pageView.getFirstResult(), 5));
		return "success";
	}
	//分页
	public String paging(){
		 pageView=new PageView<AdsPojo>(5, super.getPage());
		 pageView.setQueryResult(adsService.getScrollData(pageView.getFirstResult(), 5));
		return "success";
	}
	//进入广告修改界面
	public String updateads(){
		adsPojo=adsService.findProperty("adsId", adsPojo.getAdsId()).get(0);
		return "updateads";
	}
	//修改广告
	public String isupdate(){
		AdsPojo adsPojo2 = adsService.findProperty("adsId", adsPojo.getAdsId()).get(0);
		adsPojo2.setAdsDis(adsPojo.getAdsDis());
		adsPojo2.setAdsStatu(adsPojo.getAdsStatu());
		adsService.update(adsPojo2);
		adsPojo=adsPojo2;
		show();
		return "success";
	}
	//更改发布状态
	public String updateIssuse(){
		List<AdsPojo> list =adsService.findProperty("adsId", adsPojo.getAdsId());
		AdsPojo adsPojo  =  list.get(0);
		if(list.get(0).getAdsStatu().equals("0")){
			//改为发布
			adsPojo.setAdsStatu("1");
		}else{
			//改为下线
			adsPojo.setAdsStatu("0");
		}
		adsService.update(adsPojo);
		show();
		return "success";
	}
	//进入发布广告界面
	public String showadmIssueAds(){
		adsList =adsService.findAll();
		return "admIssueAds";
	}
	//更改广告的发布状况
	public String updatestatu(){
		List<AdsPojo> list =adsService.findProperty("adsId", adsPojo.getAdsId());
		AdsPojo adsPojo  =  list.get(0);
		if(list.get(0).getAdsStatu().equals("0")){
			//改为发布
			adsPojo.setAdsStatu("1");
		}else{
			//改为下线
			adsPojo.setAdsStatu("0");
		}
		boolean update = adsService.update(adsPojo);
		return showadmIssueAds();
	}
	
	public AdsService getAdsService() {
		return adsService;
	}
	public void setAdsService(AdsService adsService) {
		this.adsService = adsService;
	}
	public AdsPojo getAdsPojo() {
		return adsPojo;
	}
	public void setAdsPojo(AdsPojo adsPojo) {
		this.adsPojo = adsPojo;
	}
	public List<AdsPojo> getAdsList() {
		return adsList;
	}
	public void setAdsList(List<AdsPojo> adsList) {
		this.adsList = adsList;
	}
	public PageView<AdsPojo> getPageView() {
		return pageView;
	}
	public void setPageView(PageView<AdsPojo> pageView) {
		this.pageView = pageView;
	}
	 
	
	
	
}
