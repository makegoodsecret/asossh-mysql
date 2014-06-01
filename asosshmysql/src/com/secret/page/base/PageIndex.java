package com.secret.page.base;
/**
 * 页索引，主要是起始页和终止页
 */
public class PageIndex {
	//开始索引
	private int startIndex ;
	//结束索引
	private int endIndex;
	
	public PageIndex(int startIndex ,int endIndex){
		 this.startIndex =startIndex;
		 this.endIndex = endIndex;
	}
	
	/**
	 * 起始页和终止页
	 * 
	 * @param viewPageCount
	 *            显示多少页
	 * @param currentPage
	 *            当前页
	 * @param totalpage
	 *            总页数
	 * @return PageIndex 起始页和终止页
	 */
	public static PageIndex getPageIndex(int viewPageCount, int currentPage,int totalpage) {
		//viewPageCount 默认为10
		int startpage= currentPage - (viewPageCount % 2  == 0 ? viewPageCount /2 -1 : viewPageCount /2);
		int endpage= 	currentPage  +viewPageCount/2 ;
		if(startpage <1){
			startpage  =1 ;
			if(totalpage >= viewPageCount){//判断最后一页是否大于要显示的总显示数
				endpage  = viewPageCount ; 
			}else{
				endpage = totalpage ;
			}
		}
		if(endpage > totalpage){//判断最后一页是否大于最大总页数
			endpage  = totalpage ;
			if((endpage-viewPageCount)>0){
				startpage   = endpage - viewPageCount +viewPageCount +1;
			}else{
				startpage =1 ;
			}
		}
		return new PageIndex(startpage ,endpage);
	}
	
	
	
	public int getStartIndex() {
		return startIndex;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public int getEndIndex() {
		return endIndex;
	}
	public void setEndIndex(int endIndex) {
		this.endIndex = endIndex;
	}
	
}
