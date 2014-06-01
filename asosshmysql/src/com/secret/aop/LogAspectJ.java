package com.secret.aop;

import java.util.logging.Logger;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;

/**
 * 日志切面
 * @author makegoodsecret
 *
 */
@Aspect
public class LogAspectJ {
	private Logger  logger   = Logger.getLogger(LogAspectJ.class.getName());
	/**
	 * 定义一个切点为anyMethod()
	 * execution(* com.secret.action.*.*(..))
	 * 正则表达式的意思是匹配com.secret.action包下的所有类的所有方法，不管方法的类型、参数与返回值类型
	 */
	@Pointcut("execution(* com.secret.action.*.*(..))")
	private void anyMethod(){};
	
	@Before("anyMethod()")
	public void myBeforeAction(JoinPoint  joinPoint ){
		String  actioninfo= joinPoint.getTarget().getClass().getName() +"类的"+joinPoint.getSignature().getName() +"方法";
		logger.info("前置通知"+actioninfo);
	}

	@AfterReturning("anyMethod()")
	public void myAfterReturning(JoinPoint  joinPoint ){
		String  actioninfo= joinPoint.getTarget().getClass().getName() +"类的"+joinPoint.getSignature().getName() +"方法";
		logger.info("后置通知"+actioninfo);//程序出异常就不会执行
	}
	
	@AfterThrowing(pointcut = "anyMethod()" ,throwing="e")
	public void myAfterThrowing(JoinPoint  joinPoint ,Exception  e ){
		String  actioninfo= joinPoint.getTarget().getClass().getName() +"类的"+joinPoint.getSignature().getName() +"方法";
		logger.info("异常通知"+actioninfo+"发生了"+e.getMessage()+"异常");
	}
	
	@After("anyMethod()")
	public void myAfter(JoinPoint  joinPoint ){
		String  actioninfo= joinPoint.getTarget().getClass().getName() +"类的"+joinPoint.getSignature().getName() +"方法";
		logger.info("最终通知"+actioninfo); //程序运行异常但还是会执行
	}
	
	@Around("anyMethod()")
	public Object myAround(ProceedingJoinPoint  pdjt ) throws Throwable{
		long strTime = System.currentTimeMillis();
		Object proceed = pdjt.proceed();//传递给连接点对象进行接力处理
		System.out.println("传递给连接点对象进行接力处理"+proceed);
		long endTime = System.currentTimeMillis();
		String  actioninfo= pdjt.getTarget().getClass().getName() +"类的"+pdjt.getSignature().getName() +"方法";
		logger.info("环绕通知"+actioninfo+"共花费了时间"+(endTime-strTime));
		return proceed;
	}
}
