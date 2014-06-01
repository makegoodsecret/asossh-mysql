package com.secret.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.secret.pojo.GoodsOrderPojo;
/**
 * 
 * @author 徐凯
 * @email  makegoodsecret@sina.com
 * @effect 毕业设计
 * @copyright 网站设计归徐凯个人所有，仅供学习参考，如有商业使用请联系本人，盗版必究
 * @QQ       1171669635	
 */
public class DataUtil {
	public static Map<String, Map<String, List<GoodsOrderPojo>>> createordermap(List<GoodsOrderPojo> goodsOrderList){
		Map<String, Map<String, List<GoodsOrderPojo>>>   goodsOrdermap = new HashMap<String, Map<String,List<GoodsOrderPojo>>>();
		  Set<String>   settradeStatus= new HashSet<String>(); //得到订单的状态
		  Set<String>   setorderNumber= new HashSet<String>(); //得到相同订单号下的产品
	  
		  for (GoodsOrderPojo goodsOrderPojo : goodsOrderList) {
			  settradeStatus.add(goodsOrderPojo.getTradeStatus());
			  setorderNumber.add(goodsOrderPojo.getOrderNumber());
		}
		  
		  Map<String,List<GoodsOrderPojo>> map  ;
		  List<GoodsOrderPojo>   orderllist ; 
		  	map= new LinkedHashMap<String, List<GoodsOrderPojo>>();
		  //同一订单号下
		  	
			for (String strorderNumber : setorderNumber) {
				orderllist= new ArrayList<GoodsOrderPojo>();
				for (GoodsOrderPojo goodsOrderPojo : goodsOrderList) {
					if (goodsOrderPojo.getOrderNumber().equals(strorderNumber)) { 		
						orderllist.add(goodsOrderPojo);
					}
				}
				map.put(strorderNumber, orderllist);
			}
			//同一状态
			 Map<String,List<GoodsOrderPojo>> mapmap  ;
			 for (String strtradeStatus : settradeStatus) {
				 mapmap= new LinkedHashMap<String, List<GoodsOrderPojo>>();
				 for (String strorderNumber : setorderNumber) {
					 List<GoodsOrderPojo> list = map.get(strorderNumber);
					  if (list.get(0).getTradeStatus().equals(strtradeStatus)) { // 同一个订单下的状态相同
						  mapmap.put(strorderNumber, list); 
					}
					 
				 }
				 goodsOrdermap.put(strtradeStatus, mapmap);
			  }
		  
		  return goodsOrdermap;
	}
}
