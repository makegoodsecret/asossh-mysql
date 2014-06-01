package com.secret.service.impl;

import java.util.List;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.UserFriendPojo;
import com.secret.service.UserFriendService;

@SuppressWarnings("unchecked")
public class UserFriendServiceImpl extends BaseDaoImpl<UserFriendPojo> implements UserFriendService {

	@Override
	public List<UserFriendPojo> getwebsocketchat(int userId, int userFriendId) {
		 String hql  ="from "+super.entityClassName +" o where o.userPojo.userId ="+userId+" or o.userPojos.userId ="+userFriendId;
		 
		return super.getHibernateTemplate().find(hql);
	}

	 

}
