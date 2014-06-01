package com.secret.chart;

import java.io.File;
import java.io.IOException;
import java.text.DateFormatSymbols;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;

import com.secret.pojo.GoodsOrderPojo;
import com.secret.service.GoodsOrderService;
import com.secret.util.FinalStatus;

public class ExcelDataMethod {
	public  void excelMethod(int dataId, String wherejpql , String  name ,int datesize,
										GoodsOrderService goodsOrderService,String savepath) throws IOException, RowsExceededException, WriteException{
		 GregorianCalendar  d  = new GregorianCalendar(); //创建一个日历的对象
		 File saveExacelfile  =  new File(ServletActionContext.getServletContext().getRealPath(savepath));
		 if (saveExacelfile.exists()) {
			 saveExacelfile.delete();    //判断之前的Excel是否存在存在删除
		}
			WritableWorkbook wwb = Workbook.createWorkbook(saveExacelfile);
			WritableSheet     ws = wwb.createSheet(name+"一周销量", 0);//创建一个工作簿
			//第一行
			ws.mergeCells(0, 0, 10, 0); //合并
			WritableCellFormat  wcfAlign = new WritableCellFormat();
			wcfAlign.setAlignment(Alignment.CENTRE);
			wcfAlign.setVerticalAlignment(VerticalAlignment.CENTRE);
			ws.addCell(new Label(0,0,name+"一周销量",wcfAlign));
			Label   label  =  null;
			int  j =1;
			label  = new Label( 0,j,"交易号");
			ws.addCell(label);
			label  = new Label( 1,j,"支付宝交易号");
			ws.addCell(label);
			label  = new Label( 2,j,"美食名称");
			ws.addCell(label);
			label  = new Label( 3,j,"套餐名称");
			ws.addCell(label);
			label  = new Label( 4,j,"单价");
			ws.addCell(label);
			label  = new Label( 5,j,"交易数量");
			ws.addCell(label);
			label  = new Label( 6,j,"交易状态");
			ws.addCell(label);
			label  = new Label( 7,j,"交易时间");
			ws.addCell(label);
			label  = new Label( 8,j,"交易人");
			ws.addCell(label);
			label  = new Label( 9,j,"交易备注");
			ws.addCell(label);
			List<GoodsOrderPojo> list = null ;
		 for (int i = 0; i < datesize; i++) {
			 int year = d.get(Calendar.YEAR);				//当前的年数
			 int month  = d.get(Calendar.MONTH)+1 ; 		//当前的月数
			 int today  = d.get(Calendar.DAY_OF_MONTH) ;    //当前的天数
			 String weekstr = new DateFormatSymbols().getShortWeekdays()[d.get(Calendar.DAY_OF_WEEK)]; //当前的星期几
			 Object[] queryParams = {dataId, FinalStatus.WAIT_BUYER_CONFIRM_GOODS,FinalStatus.TRADE_FINISHED,FinalStatus.USER_ASSESS_SUCCESS , new SimpleDateFormat("yyyy-MM-dd").format(d.getTime()) };
			   list = goodsOrderService.findESCData(wherejpql, queryParams, null);
			   if (list.size()!=0) {
				   //为每隔一行加上日期
				   WritableFont   wf =new  WritableFont(WritableFont.TIMES, 10, WritableFont.NO_BOLD,true,
						   UnderlineStyle.NO_UNDERLINE,Colour.RED);
				   WritableCellFormat   wcf =  new WritableCellFormat(wf);
				   ws.mergeCells(0, 0, 10, 0); //合并
				   wcfAlign = new WritableCellFormat();
				   wcfAlign.setAlignment(Alignment.CENTRE);
				   wcfAlign.setVerticalAlignment(VerticalAlignment.CENTRE);
				   j++;
				   label  = new Label( 0,j,year+"年"+month+"月"+today+"日"+"   "+weekstr,wcf);
				   ws.addCell(label);
			}
			   
			 for (GoodsOrderPojo goodsOrderPojo : list) {
				j++;
				label  = new Label( 0,j, goodsOrderPojo.getOrderNumber());
				ws.addCell(label);
				label  = new Label( 1,j,goodsOrderPojo.getAlipayTradeNo());
				ws.addCell(label);
				if (null == goodsOrderPojo.getGoodsInfoPojo()) {
					label  = new Label( 2,j,"");
					ws.addCell(label);
					label  = new Label( 3,j,goodsOrderPojo.getMealPojo().getMealName());
					ws.addCell(label);
					label  = new Label( 4,j,goodsOrderPojo.getMealPojo().getMealPrice().toString());
				}else{
					label  = new Label( 2,j,goodsOrderPojo.getGoodsInfoPojo().getGoodsName());
					ws.addCell(label);
					label  = new Label( 3,j,"");
					ws.addCell(label);
					label  = new Label( 4,j,goodsOrderPojo.getGoodsInfoPojo().getGoodsPrice().toString());
				}
				ws.addCell(label);
				label  = new Label( 5,j,goodsOrderPojo.getOrderNumber());
				ws.addCell(label);
				label  = new Label( 6,j,goodsOrderPojo.getTradeStatus());
				ws.addCell(label);
				label  = new Label( 7,j,goodsOrderPojo.getOrderTime().toString());
				ws.addCell(label);
				label  = new Label( 8,j,goodsOrderPojo.getUserPojo().getUsername());
				ws.addCell(label);
				label  = new Label( 9,j,goodsOrderPojo.getOrderAds());
				ws.addCell(label);
				}
			d.add(Calendar.DAY_OF_MONTH, -1);
		}
			wwb.write();
			wwb.close();
	}
}
