package com.secret.action;

import java.io.UnsupportedEncodingException;

import org.jfree.chart.JFreeChart;

import com.opensymphony.xwork2.ActionSupport;
import com.secret.chart.HistogramMethod;
import com.secret.chart.LineGraphMethod;
import com.secret.chart.PieMethod;
import com.secret.pojo.GoodsInfoPojo;
import com.secret.pojo.HotelPojo;
import com.secret.pojo.MealPojo;
import com.secret.pojo.SortPojo;
import com.secret.service.GoodsOrderService;
/**
 * 
 * @author makegoodsecret
 *报表之图表
 */
@SuppressWarnings("serial")
public class ChartAction extends ActionSupport{
	
	private GoodsOrderService  goodsOrderService;
	private GoodsInfoPojo  goodsInfoPojo;
	private SortPojo      sortPojo ;
	private HotelPojo  hotelPojo;
	private JFreeChart chart;
	private MealPojo  mealPojo;
	
	
	/**
	 * 美食饼图
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String goodsPie() throws UnsupportedEncodingException{
		chart = new PieMethod().getGoodsPieChart(
				 goodsInfoPojo.getGoodsId(),
				 new String(goodsInfoPojo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 套餐饼图
	 * @return
	 */
	public String mealPie() throws UnsupportedEncodingException {
		chart = new PieMethod().getMealPieChart(
				mealPojo.getMealId(),
				new String(mealPojo.getMealName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);		
		return SUCCESS;
	}
	/**
	 * 系列饼图
	 */
	public String sortPie() throws UnsupportedEncodingException{
		
		chart = new PieMethod().getSortPieChart(
				sortPojo.getSortId(),
				new String(sortPojo.getSortName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}	
	/**
	 * 美食柱状图
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String goodsHistogram() throws UnsupportedEncodingException{
		chart = new HistogramMethod().getGoodsHistogramChart(
									 goodsInfoPojo.getGoodsId(),
									 new String(goodsInfoPojo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8"),
									 7, //一周的销量
									 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 套餐柱状图
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String mealHistogram() throws UnsupportedEncodingException{
		chart = new HistogramMethod().getMealHistogramChart(
				mealPojo.getMealId(),
				new String(mealPojo.getMealName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 系列柱状图
	 */
	public String sortHistogram() throws UnsupportedEncodingException{
		chart = new HistogramMethod().getSortHistogramChart(
				sortPojo.getSortId(),
				new String(sortPojo.getSortName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 美食折线图
	 * @return
	 */
	public String goodsLineGraph() throws UnsupportedEncodingException{
		chart = new LineGraphMethod().getGoodsLineGraphChart(
				 goodsInfoPojo.getGoodsId(),
				 new String(goodsInfoPojo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 套餐折线图
	 * @return
	 */
	public String mealLineGraph() throws UnsupportedEncodingException{
		chart = new LineGraphMethod().getMealLineGraphChart(
				mealPojo.getMealId(),
				new String(mealPojo.getMealName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	/**
	 * 系列折线图
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public  String sortLineGraph() throws UnsupportedEncodingException{
		chart = new LineGraphMethod().getSortLineGraphChart(
				sortPojo.getSortId(),
				new String(sortPojo.getSortName().getBytes("ISO-8859-1"),"UTF-8"),
				 7, //一周的销量
				 goodsOrderService);
		return SUCCESS;
	}
	
	public SortPojo getSortPojo() throws UnsupportedEncodingException {
		return sortPojo;
	}
	public void setSortPojo(SortPojo sortPojo) {
		this.sortPojo = sortPojo;
	}
	public HotelPojo getHotelPojo() {
		return hotelPojo;
	}
	public void setHotelPojo(HotelPojo hotelPojo) {
		this.hotelPojo = hotelPojo;
	}
	public JFreeChart getChart() {
		return chart;
	}
	public GoodsOrderService getGoodsOrderService() {
		return goodsOrderService;
	}
	public void setGoodsOrderService(GoodsOrderService goodsOrderService) {
		this.goodsOrderService = goodsOrderService;
	}
	public GoodsInfoPojo getGoodsInfoPojo() {
		return goodsInfoPojo;
	}
	public void setGoodsInfoPojo(GoodsInfoPojo goodsInfoPojo) {
		this.goodsInfoPojo = goodsInfoPojo;
	}
	public void setChart(JFreeChart chart) {
		this.chart = chart;
	}
	public MealPojo getMealPojo() {
		return mealPojo;
	}
	public void setMealPojo(MealPojo mealPojo) {
		this.mealPojo = mealPojo;
	}
	
	
}
