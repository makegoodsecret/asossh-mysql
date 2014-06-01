package com.secret.chart;

import java.awt.Font;
import java.sql.Timestamp;
import java.text.DateFormatSymbols;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Logger;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.title.LegendTitle;
import org.jfree.chart.title.TextTitle;
import org.jfree.data.category.DefaultCategoryDataset;

import com.secret.service.GoodsOrderService;
public class HistogramMethod {
	private Logger  logger = Logger.getLogger(HistogramMethod.class.getName());
	private static final Font font  = new Font("simsun",Font.ITALIC,18);
	 
	/**
	 * 返回美食的最近一周的销量柱状图
	 * @return
	 */
	 public JFreeChart   getGoodsHistogramChart(int goodsId,String goodsName ,int datesize, GoodsOrderService goodsOrderService){
		 DefaultCategoryDataset dataset = getWeekGoodsOrderdataset(  goodsId,   datesize,  goodsOrderService);
			 JFreeChart chart = ChartFactory.createBarChart3D("闻道食府网", 
									  goodsName+"最近一周的销量柱状图", "销量(份)", dataset, 
									  	PlotOrientation.VERTICAL,true,false,false);
		 chart.setTitle(new TextTitle(goodsName+"最近一周的销量柱状图",new Font("simsun",Font.ITALIC,22))); //内部图片标题
		 LegendTitle legend = chart.getLegend();
		 legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
		 chart.getCategoryPlot().getDomainAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,15)); //x
		 chart.getCategoryPlot().getDomainAxis().setLabelFont(font);     
		 chart.getCategoryPlot().getRangeAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,18)); //y
		 chart.getCategoryPlot().getRangeAxis().setLabelFont(font);
		return chart;
	 }
	 /**
	  * 返回美食一个星期中的销量
	  * @param args
	  */
	 private  DefaultCategoryDataset  getWeekGoodsOrderdataset(int selectId,int datesize, GoodsOrderService goodsOrderService){
		 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
		 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
		 List<Object> goodsSales = goodsOrderService.getGoodsSales(selectId, 7);
		 boolean isone  ;
		 for (int i = 0; i < datesize; i++) {
			 int year = d.get(Calendar.YEAR);				//当前的年数
			 int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
			 int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
			 String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
			 isone = true;
			 for (Object object : goodsSales) {
				Object[] arryobj = (Object[]) object ;
				Timestamp timestamp = (Timestamp) arryobj[1];
				 if (today == timestamp.getDate() ) {
					 dataset.setValue(((Long) arryobj[0]).intValue(),month+"/"+today, weekstr);
					 isone = false;
				 }
			}
			 if (isone) {
				 dataset.setValue(0,month+"/"+today, weekstr);
			}
			 d.add(Calendar.DAY_OF_MONTH, -1);
		}
		 return dataset;
	 }
	 
	 /**
		 * 返回套餐的最近一周的销量柱状图
		 * @return
		 */
		 public JFreeChart   getMealHistogramChart(int mealId,String mealName ,int datesize, GoodsOrderService goodsOrderService){
			 DefaultCategoryDataset dataset = getWeekMealOrderdataset(  mealId,   datesize,  goodsOrderService);
				 JFreeChart chart = ChartFactory.createBarChart3D("闻道食府网", 
						 					mealName+"最近一周的销量柱状图", "销量(份)", dataset, 
										  	PlotOrientation.VERTICAL,true,false,false);
			 chart.setTitle(new TextTitle(mealName+"最近一周的销量柱状图",new Font("simsun",Font.ITALIC,22))); //内部图片标题
			 LegendTitle legend = chart.getLegend();
			 legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
			 chart.getCategoryPlot().getDomainAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,15)); //x
			 chart.getCategoryPlot().getDomainAxis().setLabelFont(font);     
			 chart.getCategoryPlot().getRangeAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,18)); //y
			 chart.getCategoryPlot().getRangeAxis().setLabelFont(font);
			return chart;
		 }
		 /**
		  * 返回套餐一个星期中的销量
		  * @param args
		  */
		 private  DefaultCategoryDataset  getWeekMealOrderdataset(int mealId,int datesize, GoodsOrderService goodsOrderService){
			 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
			 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
			 List<Object> goodsSales = goodsOrderService.getMealdsSales(mealId, 7);
			 boolean isone  ;
			 for (int i = 0; i < datesize; i++) {
				 int year = d.get(Calendar.YEAR);				//当前的年数
				 int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
				 int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
				 String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
				 isone = true;
				 for (Object object : goodsSales) {
					Object[] arryobj = (Object[]) object ;
					Timestamp timestamp = (Timestamp) arryobj[1];
					 if (today == timestamp.getDate() ) {
						 dataset.setValue(((Long) arryobj[0]).intValue(),month+"/"+today, weekstr);
						 isone = false;
					 }
				}
				 if (isone) {
					 dataset.setValue(0,month+"/"+today, weekstr);
				}
				 d.add(Calendar.DAY_OF_MONTH, -1);
			}
			 return dataset;
		 }
		 /**
			 * 返回系列的最近一周的销量柱状图
			 * @return
			 */
			 public JFreeChart   getSortHistogramChart(int sortId,String sortName ,int datesize, GoodsOrderService goodsOrderService){
				 DefaultCategoryDataset dataset = getWeekSortOrderdataset(  sortId,   datesize,  goodsOrderService);
					 JFreeChart chart = ChartFactory.createBarChart3D("闻道食府网", 
							 					sortName+"最近一周的销量柱状图", "销量(份)", dataset, 
											  	PlotOrientation.VERTICAL,true,false,false);
				 chart.setTitle(new TextTitle(sortName+"最近一周的销量柱状图",new Font("simsun",Font.ITALIC,22))); //内部图片标题
				 LegendTitle legend = chart.getLegend();
				 legend.setItemFont(font); //对中文支持的不是很好，所以需要重新设置
				 chart.getCategoryPlot().getDomainAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,15)); //x
				 chart.getCategoryPlot().getDomainAxis().setLabelFont(font);     
				 chart.getCategoryPlot().getRangeAxis().setTickLabelFont(new Font("simsun",Font.ITALIC,18)); //y
				 chart.getCategoryPlot().getRangeAxis().setLabelFont(font);
				return chart;
			 }
			 /**
			  * 返回系列一个星期中的销量
			  * @param args
			  */
			 private  DefaultCategoryDataset  getWeekSortOrderdataset(int sortId,int datesize, GoodsOrderService goodsOrderService){
				 DefaultCategoryDataset dataset = new DefaultCategoryDataset();
				 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
				 List<Object> goodsSales = goodsOrderService.getSortSales(sortId, 7);
				 boolean isone  ;
				 for (int i = 0; i < datesize; i++) {
					 int year = d.get(Calendar.YEAR);				//当前的年数
					 int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
					 int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
					 String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
					 isone = true;
					 for (Object object : goodsSales) {
						Object[] arryobj = (Object[]) object ;
						Timestamp timestamp = (Timestamp) arryobj[1];
						 if (today == timestamp.getDate() ) {
							 dataset.setValue(((Long) arryobj[0]).intValue(),month+"/"+today, weekstr);
							 isone = false;
						 }
					}
					 if (isone) {
						 dataset.setValue(0,month+"/"+today, weekstr);
					}
					 d.add(Calendar.DAY_OF_MONTH, -1);
				}
				 return dataset;
			 }
}
