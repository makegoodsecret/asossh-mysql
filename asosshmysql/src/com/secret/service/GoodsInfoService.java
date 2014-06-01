package com.secret.service;




import java.util.LinkedHashMap;
import java.util.List;

import com.secret.dao.base.BaseDao;
import com.secret.pojo.GoodsInfoPojo;

public interface GoodsInfoService extends BaseDao<GoodsInfoPojo> {
	//首页显示几条
	List<GoodsInfoPojo>  selectHomeGoods(LinkedHashMap<String, String> orderby ,int size);
}
