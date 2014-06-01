package com.secret.service.impl;

import java.util.List;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.OrderAddressPojo;
import com.secret.service.OrderAddressService;

public class OrderAddressServiceImpl  extends BaseDaoImpl<OrderAddressPojo> implements OrderAddressService{
 

	@SuppressWarnings("unchecked")
	@Override
	public List<OrderAddressPojo> addressDesc(String propertyName,
			Object value, String asc_desc) {
		 String hql ="from OrderAddressPojo   o where o."+propertyName+"=?   order by   o.orderAddressStatus "+asc_desc;
		return (List<OrderAddressPojo>)super.getHibernateTemplate().find(hql, value);
	}

}
