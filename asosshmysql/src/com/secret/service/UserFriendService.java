package com.secret.service;

import java.util.List;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.UserFriendPojo;

public interface UserFriendService extends BaseDao<UserFriendPojo> {

	List<UserFriendPojo>  getwebsocketchat(int userId, int userFriendId);
}
