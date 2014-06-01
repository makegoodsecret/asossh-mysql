package com.secret.chart;

import java.awt.Font;
import java.sql.Timestamp;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.logging.Logger;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.general.DefaultPieDataset;

import com.secret.pojo.GoodsOrderPojo;
import com.secret.service.GoodsOrderService;
import com.secret.util.FinalStatus;
public class PieMethod {
	private Logger  logger = Logger.getLogger(PieMethod.class.getName());
	private static final Font font  = new Font("simsun",Font.ITALIC,18);
	 
	/**
	 * 返回美食的一周的销量饼状图
	 * @return
	 */
	 public JFreeChart   getGoodsPieChart(int goodsId,String goodsName ,int datesize, GoodsOrderService goodsOrderService){
		 DefaultPieDataset  dataset =  getWeekGoodsOrderdataset(  goodsId,  datesize,   goodsOrderService);
		 JFreeChart chart = ChartFactory.createPieChart("闻道食府网",
				 						dataset, 
				 							true,//是否有标题
				 							false,//是否有悬浮提示
				 							false//是否有连接
				 							);
		 chart.setTitle(new TextTitle(goodsName+"一周销量饼状图",font)); //内部图片标题
		 LegendTitle legend = chart.getLegend();
		 legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
		 PiePlot plot  = (PiePlot) chart.getPlot();
		 plot.setBackgroundAlpha(0.9f);
		 plot.setLabelFont(font);
		return chart;
	 }
	 /**
	  * 返回美食一个星期中的销量
	  * @param args
	  */
	 private  DefaultPieDataset  getWeekGoodsOrderdataset(int goodsId,int datesize, GoodsOrderService goodsOrderService){
			DefaultPieDataset dataset = new DefaultPieDataset();
			 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
			 List<Object> goodsSales = goodsOrderService.getGoodsSales(goodsId, 7);
			 int sun =0;
			 for (Object object : goodsSales) {
					sun += ((Long) ((Object[]) object)[0]).intValue();
				}
			 if (sun == 0) {
				 dataset.setValue("最近一周没有一次购买", 1.00);
			} else{
				for (int i = 0; i < datesize; i++) {
					int year = d.get(Calendar.YEAR);				//当前的年数
					int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
					int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
					String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
					for (Object object : goodsSales) {
						Object[] arryobj = (Object[]) object ;
						Timestamp timestamp = (Timestamp) arryobj[1];
						if (today == timestamp.getDate() ) {
							int intValue = ((Long) ((Object[]) object)[0]).intValue();
							dataset.setValue(weekstr+" "+month+"/"+today, (double)intValue/sun);
						}
					}
					d.add(Calendar.DAY_OF_MONTH, -1);
				}
			}
		 return dataset;
	 }
	 
	 /**
		 * 返回套餐的一周的销量饼状图
		 * @return
		 */
		 public JFreeChart   getMealPieChart(int mealId,String mealName ,int datesize, GoodsOrderService goodsOrderService){
			 DefaultPieDataset  dataset =  getWeekMealOrderdataset(  mealId,  datesize,   goodsOrderService);
			 JFreeChart chart = ChartFactory.createPieChart("闻道食府网",
						dataset, 
							true,//是否有标题
							false,//是否有悬浮提示
							false//是否有连接
							);
							chart.setTitle(new TextTitle(mealName+"一周销量饼状图",font)); //内部图片标题
							LegendTitle legend = chart.getLegend();
							legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
							PiePlot plot  = (PiePlot) chart.getPlot();
							plot.setBackgroundAlpha(0.9f);
							plot.setLabelFont(font);
			return chart;
		 }
		 /**
		  * 返回套餐一个星期中的销量
		  * @param args
		  */
		 private  DefaultPieDataset  getWeekMealOrderdataset(int mealId,int datesize, GoodsOrderService goodsOrderService){
				DefaultPieDataset dataset = new DefaultPieDataset();
				 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
				 List<Object> goodsSales = goodsOrderService.getMealdsSales(mealId, 7);
				 int sun =0;
				 for (Object object : goodsSales) {
						sun += ((Long) ((Object[]) object)[0]).intValue();
					}
				 if (sun == 0) {
					 dataset.setValue("最近一周没有一次购买", 1.00);
				} else{
					for (int i = 0; i < datesize; i++) {
						int year = d.get(Calendar.YEAR);				//当前的年数
						int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
						int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
						String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
						for (Object object : goodsSales) {
							Object[] arryobj = (Object[]) object ;
							Timestamp timestamp = (Timestamp) arryobj[1];
							if (today == timestamp.getDate() ) {
								int intValue = ((Long) ((Object[]) object)[0]).intValue();
								dataset.setValue(weekstr+" "+month+"/"+today, (double)intValue/sun);
							}
						}
						d.add(Calendar.DAY_OF_MONTH, -1);
					}
				}
			 return dataset;
		 }
		 /**
			 * 返回系列的一周的销量饼状图
			 * @return
			 */
			 public JFreeChart   getSortPieChart(int sortId,String sortName ,int datesize, GoodsOrderService goodsOrderService){
				 DefaultPieDataset  dataset =  getWeekSortOrderdataset(  sortId,  datesize,   goodsOrderService);
				 JFreeChart chart = ChartFactory.createPieChart("闻道食府网",
	 						dataset, 
	 							true,//是否有标题
	 							false,//是否有悬浮提示
	 							false//是否有连接
	 							);
								chart.setTitle(new TextTitle(sortName+"一周销量饼状图",font)); //内部图片标题
								LegendTitle legend = chart.getLegend();
								legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
								PiePlot plot  = (PiePlot) chart.getPlot();
								plot.setBackgroundAlpha(0.9f);
								plot.setLabelFont(font);
				return chart;
			 }
			 /**
			  * 返回系列一个星期中的销量
			  * @param args
			  */
			 private  DefaultPieDataset  getWeekSortOrderdataset(int sortId,int datesize, GoodsOrderService goodsOrderService){
					DefaultPieDataset dataset = new DefaultPieDataset();
					 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
					 List<Object> goodsSales = goodsOrderService.getSortSales(sortId, 7);
					 int sun =0;
					 for (Object object : goodsSales) {
							sun += ((Long) ((Object[]) object)[0]).intValue();
						}
					 if (sun == 0) {
						 dataset.setValue("最近一周没有一次购买", 1.00);
					} else{
						for (int i = 0; i < datesize; i++) {
							int year = d.get(Calendar.YEAR);				//当前的年数
							int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
							int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
							String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
							for (Object object : goodsSales) {
								Object[] arryobj = (Object[]) object ;
								Timestamp timestamp = (Timestamp) arryobj[1];
								if (today == timestamp.getDate() ) {
									int intValue = ((Long) ((Object[]) object)[0]).intValue();
									dataset.setValue(weekstr+" "+month+"/"+today, (double)intValue/sun);
								}
							}
							d.add(Calendar.DAY_OF_MONTH, -1);
						}
					}
				 return dataset;
			 }
}
