package com.secret.service.impl;




import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.service.GoodsInfoService;

@SuppressWarnings("unchecked")
public class GoodsInfoServiceImpl extends BaseDaoImpl<GoodsInfoPojo> implements GoodsInfoService {
	@Override
	public List<GoodsInfoPojo> selectHomeGoods(
			LinkedHashMap<String, String> orderby, int size) {
		 String hql  = "from  GoodsInfoPojo o "+super.buildOrderby(orderby);
		 Query query = super.getSession().createQuery(hql);
		 query.setFirstResult(0);
		 query.setMaxResults(size);
		List<GoodsInfoPojo> list = query.list();
		return list;
	}

	 
}
