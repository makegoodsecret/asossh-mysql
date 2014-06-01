package com.secret.service;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.MealPojo;

public interface MealService extends BaseDao<MealPojo> {
	//多对多关联时出现问题需要a different object with the same identifier value was already associated with the session:
	public boolean merge(MealPojo mealPojo);
}
