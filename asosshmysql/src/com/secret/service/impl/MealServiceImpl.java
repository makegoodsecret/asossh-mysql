package com.secret.service.impl;

import com.secret.dao.base.BaseDaoImpl;
import com.secret.pojo.MealPojo;
import com.secret.service.MealService;

public class MealServiceImpl extends BaseDaoImpl<MealPojo>   implements  MealService {

	@Override
	public boolean merge(MealPojo mealPojo) {
		super.getHibernateTemplate().merge(mealPojo);
		return true;
	}

	 

}
