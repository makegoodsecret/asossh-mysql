package com.secret.aop;


import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;

/** 日志切面 */
public class LogAspectJS {
	// 取得日志记录器Logger
	public Logger logger = Logger.getLogger(LogAspectJS.class);
	//此方法将用作前置通知
	public void myBeforeAdvice(JoinPoint joinpoint) {
		String classAndMethod = joinpoint.getTarget().getClass().getName()+"类的"+joinpoint.getSignature().getName();
		logger.info("前置通知:"+classAndMethod+"方法开始执行！");
	}
	//此方法将用作后置通知
	public void myAfterReturningAdvice(JoinPoint joinpoint) {
		String classAndMethod = joinpoint.getTarget().getClass().getName()+"类的"+joinpoint.getSignature().getName();
		logger.info("后置通知:"+classAndMethod+"方法执行正常结束！");
	}
	//此方法将用作异常通知
    public void myAfterThrowingAdvice(JoinPoint joinpoint,Exception e) {
		String classAndMethod = joinpoint.getTarget().getClass().getName()+"类的"+joinpoint.getSignature().getName();
		logger.info("异常通知:"+classAndMethod+"方法抛出异常："+e.getMessage());
	}
    //此方法将用作最终通知
	public void myAfterAdvice(JoinPoint joinpoint) {
		String classAndMethod = joinpoint.getTarget().getClass().getName()+"类的"+joinpoint.getSignature().getName();
		logger.info("最终通知:"+classAndMethod+"方法执行结束！");
	}
	//此方法将用作环绕通知
	public Object myAroundAdvice(ProceedingJoinPoint pjp) throws Throwable {
		long begintime = System.currentTimeMillis();//记下开始时间
		//传递给连接点对象进行接力处理
		Object result=pjp.proceed();
		long endtime = System.currentTimeMillis();//记下结束时间
		String classAndMethod = pjp.getTarget().getClass().getName()+"类的"+pjp.getSignature().getName();
		logger.info("环绕通知:"+classAndMethod+"方法执行结束,耗时"+(endtime-begintime)+"毫秒！");
		return result;
	}
}
