package com.secret.chart;

import java.sql.Timestamp;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.logging.Logger;

import org.apache.commons.lang.math.RandomUtils;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.axis.ValueAxis;
import org.jfree.chart.plot.XYPlot;
import org.jfree.chart.renderer.xy.StandardXYItemRenderer;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;

import com.secret.pojo.GoodsOrderPojo;
import com.secret.service.GoodsOrderService;
import com.secret.util.FinalStatus;
public class LineGraphMethod {
	private Logger  logger = Logger.getLogger(LineGraphMethod.class.getName());
	private JFreeChart chart;
	/**
	 * 返回美食的一周的销量折线图
	 * @return
	 */
	 public JFreeChart   getGoodsLineGraphChart(int goodsId,String goodsName ,int datesize, GoodsOrderService goodsOrderService){
		 XYSeries dataSeries = new XYSeries(new Integer(1));  
		 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
		 List<Object> goodsSales = goodsOrderService.getGoodsSales(goodsId, 7);
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
					 dataSeries.add(today, ((Long) arryobj[0]).intValue());
					 isone = false;
				 }
			}
			 if (isone) {
				 dataSeries.add(today, 0);
			}
			 d.add(Calendar.DAY_OF_MONTH, -1);
		}
		    XYSeriesCollection xyDataset = new XYSeriesCollection(dataSeries);
		    ValueAxis xAxis = new NumberAxis("x/日");
		    ValueAxis yAxis = new NumberAxis("Y/份数");
		    chart = new JFreeChart( goodsName+"一周销量折线图", 
		    					JFreeChart.DEFAULT_TITLE_FONT,
			    				new XYPlot( xyDataset, xAxis, yAxis, 
			    							new StandardXYItemRenderer(StandardXYItemRenderer.LINES)
			    							),
			    				false
			    			);
		    chart.setBackgroundPaint(java.awt.Color.white);
		return chart;
	 }
	 
	 /**
		 * 返回套餐的一周的销量折线图
		 * @return
		 */
		 public JFreeChart   getMealLineGraphChart(int mealId,String mealName ,int datesize, GoodsOrderService goodsOrderService){
			 XYSeries dataSeries = new XYSeries(new Integer(1)); // pass a key for this serie
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
						 dataSeries.add(today, ((Long) arryobj[0]).intValue());
						 isone = false;
					 }
				}
				 if (isone) {
					 dataSeries.add(today, 0);
				}
				 d.add(Calendar.DAY_OF_MONTH, -1);
			}
			    XYSeriesCollection xyDataset = new XYSeriesCollection(dataSeries);
			    ValueAxis xAxis = new NumberAxis("x/日");
			    ValueAxis yAxis = new NumberAxis("Y/份数");
			    chart =
				    new JFreeChart(mealName+"一周销量折线图", 
				    				JFreeChart.DEFAULT_TITLE_FONT,
				    				new XYPlot( xyDataset, xAxis, yAxis, 
				    							new StandardXYItemRenderer(StandardXYItemRenderer.LINES)
				    							),
				    				false
				    			);
			    chart.setBackgroundPaint(java.awt.Color.white);
			return chart;
		 }
		 
		 /**
			 * 返回系列的一周的销量折线图
			 * @return
			 */
			 public JFreeChart   getSortLineGraphChart(int sortId,String sortName ,int datesize, GoodsOrderService goodsOrderService){
				 XYSeries dataSeries = new XYSeries(new Integer(1)); // pass a key for this serie
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
							 dataSeries.add(today, ((Long) arryobj[0]).intValue());
							 isone = false;
						 }
					}
					 if (isone) {
						 dataSeries.add(today, 0);
					}
					 d.add(Calendar.DAY_OF_MONTH, -1);
				}
				    XYSeriesCollection xyDataset = new XYSeriesCollection(dataSeries);
		
				    ValueAxis xAxis = new NumberAxis("x/日");
				    ValueAxis yAxis = new NumberAxis("Y/份数");
				    chart =
					    new JFreeChart( sortName+"一周销量折线图", 
					    				JFreeChart.DEFAULT_TITLE_FONT,
					    				new XYPlot( xyDataset, xAxis, yAxis, 
					    							new StandardXYItemRenderer(StandardXYItemRenderer.LINES)
					    							),
					    				false
					    			);
				    chart.setBackgroundPaint(java.awt.Color.white);
				return chart;
			 }
			 
}
