package com.secret.quartzjob;

import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;


public class QuartEmailJobs extends QuartzJobBean  {
	private QuartEmailService emailService;
	private QuartBackService  quartBackService;
	@Override
	protected void executeInternal(JobExecutionContext context)
			throws JobExecutionException {
		//emailService.QuartEmail();		//发邮件
		quartBackService.backImage();		//复制图片
	}
	public void setEmailService(QuartEmailService emailService) {
		this.emailService = emailService;
	}
	public QuartEmailService getEmailService() {
		return emailService;
	}
	public void setQuartBackService(QuartBackService quartBackService) {
		this.quartBackService = quartBackService;
	}
	
	
}
