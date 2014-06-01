package com.secret.dao.base;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.List;

import com.secret.page.base.QueryResult;
import com.secret.pojo.GoodsAssessPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public interface BaseDao<T> {
	public boolean merge(Object entity);
	public boolean saveorupdate(Object entity);
	/**
	 * 保存实体对象
	 * 例如，当使用保存一个用户或着保存一件商品
	 * */
	public boolean save( Object  entity  );
	
	/**
	 * 根据属性删除对象
	 * 
	 * @param propertyName
	 *            属性（对应Bean）
	 * @param value
	 *            属性
	 * @return 根据属性查找对象
	 */
	public boolean deleteProperty(Object   entity);
	/**
	 * 传入实体类的对象数组，删除对象数组中指定的一个或多个对象
	 * entityids对象id数组
	 * */
	public boolean delete(Serializable... entityids);
	
	public boolean deleteAll(Collection<Object>  eCollection);
	
	public boolean deleteDes();
	/**
	  * 更新实体
	 * 
	 * @param entity
	 *            
	 * */
	public boolean update( Object  entity  );
	/**
	 * 根据实体查找对象
	 * 
	 * @param entiey
	 *            实体（T类型）
	 * @return 根据属性查找对象
	 */
	public List<T> findByEntity(Object entiey);
	/**
	 * 根据属性精确查找对象
	 * 
	 * @param propertyName
	 *            属性（对应Bean）
	 * @param value
	 *            属性
	 * @return 根据属性查找对象
	 */
	public List<T>  findProperty(String    propertyName   , Object    value) ;
	/**
	 * 模糊查询
	 * @param propertyName
	 * @param value
	 * @return
	 */
	public List<T>  findVageu(String    propertyName   , Object    value) ;
	public List<T>  findDoubleVageu(String    propertyName   , Object    value,
									String    propertyNames   , Object    values) ;
	/**
	 * 排序查询
	 * @param propertyName  
	 * @param ascordesc   asc 升序排序
	 * @return
	 */
	public List<T>  findascordescProperty(String propertyName , String ascordesc);
	
	/**
	 * 根据两个属性精确查询
	 * @param propertyName
	 * @param value
	 * @param propertyNames
	 * @param values
	 * @return
	 */
	public List<T>  findDoubleProperty(String    propertyName   , Object    value ,String 
										propertyNames   , Object    values) ;
	/**
	 * 获取实体
	 * 
	 * @param <T>
	 * @param entityClass
	 *            实体类
	 * @param entityId
	 *            实体id
	 * @return
	 */
	
	public T find(Serializable entityId);
	
	/**
	 * 查询全部
	 */
	public List<T> findAll();
	/**
	  * 按照某几列的准确值，对查询结果进行排序，可以是某几列的排序
	  * @param wherejpql  语句
	  * @param queryParams 参数数组值
	  * @param orderby  排序规则
	  * @return
	  * 使用
	  * String wherejpql="o.hotelPojo=?";
		Object[] queryParams={hotelPojo};
		LinkedHashMap<String, String> orderby = new LinkedHashMap<String, String>();
		orderby.put("assTime", "asc");
		List<GoodsAssessPojo> escData = goodsAssessService.findESCData(wherejpql, queryParams, orderby);
	  */
	List<T> findESCData(String wherejpql , Object[] queryParams, LinkedHashMap<String, String> orderby);
	/**
	 * 获取分页数据
	 * 
	 * @param firstindex
	 *            开始索引
	 * @param maxresult
	 *            每页显示记录数
	 * @param wherejpql
	 *            where语句
	 * @param queryParams
	 *            查询参数
	 * @param orderby
	 *            排序序列
	 * @return 分页数据
	 */
	
	public QueryResult<T> getScrollData(
										final int firstindex,
										final int maxresult, final String wherejpql, 
										final Object[] queryParams,
										final LinkedHashMap<String, String> orderby);

	/**
	 * 获取分页数据
	 * 
	 * @param firstindex
	 *            开始索引
	 * @param maxresult
	 *            每页显示记录数
	 * @param wherejpql
	 *            where语句
	 * @param queryParams
	 *            查询参数
	 * @return 分页数据
	 */
	public QueryResult<T> getScrollData(
										final int firstindex, 
										final int maxresult, 
										final String wherejpql, 
										final Object[] queryParams);

	/**
	 * 获取分页数据
	 * 
	 * @param firstindex
	 *            开始索引
	 * @param maxresult
	 *            每页显示记录数
	 * @param orderby
	 *            排序序列
	 * @return 分页数据
	 */
	public QueryResult<T> getScrollData(
										final int firstindex, 
										final int maxresult, 
										final LinkedHashMap<String, String> orderby);

	/**
	 * 获取分页数据
	 * 
	 * @param firstindex
	 *            开始索引
	 * @param maxresult
	 *            每页显示记录数
	 * @return 分页数据
	 */
	public QueryResult<T> getScrollData(final int firstindex,final int maxresult);

	/**
	 * 获取所有对象
	 * 
	 * @return 所有对象
	 */
	public QueryResult<T> getScrollData();
}


