package com.secret.service;

import java.util.List;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.OrderAddressPojo;

public interface OrderAddressService extends BaseDao<OrderAddressPojo> {
	 //自定义查询出用户的收件人地址，并对其默认地址进行排序
	List<OrderAddressPojo> addressDesc(String    propertyName   , Object    value ,String asc_desc);
}
