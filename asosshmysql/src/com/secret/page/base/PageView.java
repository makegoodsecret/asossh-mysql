package com.secret.page.base;

import java.util.List;


/**
 * 分页数据包装，包括分页信息和List数据
 */
public class PageView<T> {
	//分页数据
	private List<T>  records ;
	//页码开始索引和结束索引
	private PageIndex  pageIndex  ;
	//总页数
	private int totalPage = 1; 
	//每页显示记录数
	private int maxResult  = 10;
	//当前页
	private int currentPage   = 1 ;
	//总 记录数
	private int totalRecord   ; 
	//每次显示多少页，必须保证大于3页，保证左右链接都可以使用
	private int viewPageCount  =10  ;
	

	public PageView( int maxResult ,int currentPage){
		this.maxResult =  maxResult ;
		this.currentPage  =  (currentPage <= 0 ?1 :currentPage);
	}
	
	public PageView(int currentPage){
		this.currentPage = (currentPage <= 0 ? 1 :currentPage);
	}
	
	
	/**
	 * 要获取记录的开始索引
	 * @return
	 */
	public int getFirstResult(){
		
		return (this.currentPage-1)*this.maxResult;
	}
	
	public void setQueryResult(QueryResult<T> qr){
		//添加分页得到的数据
		setTotalRecord(qr.getTotalRecord()); //设置显示分页的底
		setRecords(qr.getResultList());      //设置分页数据
		
	}
	
	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;// 总页分数
		this.pageIndex = PageIndex.getPageIndex(viewPageCount, currentPage, totalPage);
	}
	
	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;//总页数
		setTotalPage(this.totalRecord % this.maxResult == 0 ? this.totalRecord / this.maxResult : this.totalRecord / this.maxResult + 1);
	}
	
	public List<T> getRecords() {
		return records;
	}
	public void setRecords(List<T> records) {
		this.records = records;
	}
	public PageIndex getPageIndex() {
		return pageIndex;
	}
	public void setPageIndex(PageIndex pageIndex) {
		this.pageIndex = pageIndex;
	}
	public int getTotalPage() {
		return totalPage;
	}
	
	public int getMaxResult() {
		return maxResult;
	}
	public void setMaxResult(int maxResult) {
		this.maxResult = maxResult;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getTotalRecord() {
		return totalRecord;
	}
	
	public int getViewPageCount() {
		return viewPageCount;
	}
	public void setViewPageCount(int viewPageCount) {
		this.viewPageCount = viewPageCount;
	}
	
}
