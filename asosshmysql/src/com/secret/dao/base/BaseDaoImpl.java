package com.secret.dao.base;

import java.io.Serializable;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Order;
import org.springframework.orm.hibernate3.HibernateCallback;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.secret.page.base.QueryResult;
import com.secret.pojo.GoodsAssessPojo;
import com.secret.util.GenericsUtils;

/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */

@SuppressWarnings("unchecked")
public class BaseDaoImpl<T> extends  HibernateDaoSupport   implements   BaseDao<T> {
	protected Class<T> entityClass = GenericsUtils.getSuperClassGenricType(this.getClass());
	
	protected String entityClassName = getEntityName(this.entityClass); 

	protected static <E> String getEntityName(Class<E> clazz) {
		String entityname = clazz.getSimpleName();
		return entityname;
	}

	@Override
	public boolean merge(Object entity) {
		  super.getHibernateTemplate().merge(entity);
		return true;
	}

	@Override
	public boolean saveorupdate(Object entity) {
		super.getHibernateTemplate().saveOrUpdate(entity);
		return true;
	}

	public boolean delete(Serializable... entityids) {
		for (Object id : entityids) {
			super.getHibernateTemplate().delete(find((Serializable) id));
		}
		return true;
	}
	
	@Override
	public boolean deleteAll(Collection<Object> eCollection) {
		super.getHibernateTemplate().deleteAll(eCollection);
		return true;
	}

	
	public T find(Serializable entityId) {
		if (null != entityId)
			return (T) super.getHibernateTemplate().get(entityClass, entityId);
		return null;
	}
	public boolean save(Object entity) {
		super.getHibernateTemplate().save(entity);
		return true;
	}
	
	//根据对象查询
	public List<T> findByEntity(Object entiey) {
		return super.getHibernateTemplate().findByExample(entiey);
	}
	
	//根据属性查询
	public List<T> findProperty(String propertyName, Object value) {
		String   hql  =  "from "+entityClassName+" o where o."+propertyName+"= ?";
		return super.getHibernateTemplate().find(hql, value);
	}
	//查询全部
	public List<T> findAll() {
		String hql  = "from "+entityClassName ;
		return super.getHibernateTemplate().find(hql);
	}
	//模糊查询
	@Override
	public List<T> findVageu(String propertyName, Object value) {
		String   hql ="from "+entityClassName+" o where o."+propertyName+" like ?";
		return super.getHibernateTemplate().find(hql, "%"+value+"%");
	}
	//模糊查询
	@Override
	public List<T> findDoubleVageu(String propertyName, Object value,String propertyNames, Object values) {
		String   hql ="from "+entityClassName+" o where o."+propertyName+" like ? and o."+propertyNames+" like ?";
		return super.getHibernateTemplate().find(hql,new  Object[]{"%"+value+"%","%"+values+"%"});
	}
	//排序
	@Override
	public List<T> findascordescProperty(String propertyName, String ascordesc) {
		    String  hql ="from "+entityClassName+" o order by o."+propertyName+" "+ascordesc;
		return super.getHibernateTemplate().find(hql);
	}
	
	//根据两个属性精确查询
	@Override
	public List<T> findDoubleProperty(String propertyName, Object value,
			String propertyNames, Object values) {
		String hql  = "from "+entityClassName+" o where o."+propertyName+"= ?"+" and o."+propertyNames+"= ?";
		return super.getHibernateTemplate().find(hql, new Object[]{value,values});
	}
	//按照添加排序
	@Override
	public List<T> findESCData(String wherejpql,Object[] queryParams, LinkedHashMap<String, String> orderby) {
		String hql  ="from "+entityClassName+" o " +(wherejpql ==null||"".equals(wherejpql.trim())?"":" where "+wherejpql) +buildOrderby(orderby);
		Session session = super.getSessionFactory().openSession();
		Transaction tx = session.beginTransaction();
		 Query query = session.createQuery(hql);
		 for (int i = 0; i < queryParams.length; i++) {
			query.setParameter(i, queryParams[i]);
		}
		 List<T> list = query.list();
		 tx.commit();
		 if (session!=null) {
			session.close();
		}
		return list;
	}
	
	public boolean update(Object entity) {
			super.getHibernateTemplate().update(entity);
		return true;
	}

	public boolean deleteProperty(Object entity) {
		super.getHibernateTemplate().delete(entity);
		return true;
	}
	public QueryResult<T> getScrollData(final int firstindex, final int maxresult,
										final String wherejpql, final Object[] queryParams,
										final LinkedHashMap<String, String> orderby){
		//查询结果集，包括数据和总数
		final QueryResult<T> queryResult = new QueryResult<T>();
		super.getHibernateTemplate().execute(new HibernateCallback() {
			public T doInHibernate(Session session) throws HibernateException, SQLException {
				String hql ="from " + entityClassName + " o "+ 
				(wherejpql == null || "".equals(wherejpql.trim()) ? "" : " where " + wherejpql)+ buildOrderby(orderby);
				Query query = session.createQuery(hql);
				setQueryParams(query, queryParams);								// 通配符赋值
				queryResult.setTotalRecord(query.list().size());				//查询得出的总数
				if (firstindex != -1 && maxresult != -1){
					query.setFirstResult(firstindex).setMaxResults(maxresult);	// hibernate 分页
					queryResult.setResultList(query.list());					//最后的分页数据
				}
				return null;
			}
		});
		return queryResult;
	}

	protected static void setQueryParams(Query query, Object[] queryParams) {
		if (queryParams != null && queryParams.length > 0) {
			for (int i = 0; i < queryParams.length; i++) {
				query.setParameter(i, queryParams[i]);
			}
		}
	}

	protected static String buildOrderby(LinkedHashMap<String, String> orderby) {
		StringBuffer orderbyql = new StringBuffer("");
		if (orderby != null && orderby.size() > 0) {
			orderbyql.append(" order by ");
			for (String key : orderby.keySet()) {
				orderbyql.append("o.")
						 .append(key)
						 .append(" ")
						 .append(orderby.get(key))
						 .append(",");
			}
			orderbyql.deleteCharAt(orderbyql.length() - 1); //删除最后一个','deleteCharAt用来删除指定位置的字符
		}
		return orderbyql.toString();
	}
	
	public QueryResult<T> getScrollData(int firstindex, int maxresult,String wherejpql, Object[] queryParams) {
		return getScrollData(firstindex, maxresult, wherejpql, queryParams, null);
	}
	
	public QueryResult<T> getScrollData(final int firstindex, final int maxresult, final LinkedHashMap<String, String> orderby){
		return getScrollData(firstindex, maxresult, null, null, orderby);
	}

	public QueryResult<T> getScrollData(final int firstindex, final int maxresult){
		return getScrollData(firstindex, maxresult, null, null, null);
	}
	public QueryResult<T> getScrollData()
	{
		return getScrollData(-1, -1, null, null, null);
	}

	@Override
	public boolean deleteDes() {
		 throw  new RuntimeException("测试删除异常");
	}





	


}
