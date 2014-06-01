<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<style type="text/css">
	#pageA{
		background-color: #eee;
		font-family: 仿宋;
		font-size: 20px;
	}
	#pageA:ACTIVE {
		color:yellow;
	}
	#pageA:HOVER {
		color:red;
		background-color: #bbb;
	}
	#pageA:LINK{
		background-color: #CEFE48;
		color: #333;
	}
	#pageAS{
		background-color: #eee;
		font-family: 仿宋;
		font-size: 20px;
	}
</style>
			<div style="margin-top: 10px; margin-bottom:10px; text-align: center;">
			<s:if test="#request.pageView.currentPage > 1">
				<a  id="pageA" href="javascript:topage(1)"  style="padding: 8px 8px;">首页</a>
				<a  id="pageA"  href="javascript:topage('<s:property value="#request.pageView.currentPage - 1"/>')" style="padding: 8px 8px;">
				上一页</a>
			</s:if>
			<s:else>
				<a  id="pageAS" href="javascript:void(0)"  style="padding: 8px 8px;">首页 </a> 
				<a  id="pageAS" href="javascript:void(0)"  style="padding: 8px 8px; margin-left: 10px;">上一页</a> 
			</s:else>
			<s:iterator begin="#request.pageView.pageIndex.startIndex" end="#request.pageView.pageIndex.endIndex" var="wp">
				<s:if test="#request.pageView.currentPage== #wp">
						 <a  id="pageAS" href="javascript:void(0)"  style="padding: 8px 8px; "><s:property value="#wp" /></a>
				</s:if>
				<s:else>
					<a  id="pageA"  href="javascript:topage('<s:property value="#wp"/>')" style="padding: 8px 8px;"><s:property value="#wp" /></a>
				</s:else>
			</s:iterator>
			<s:if test="#request.pageView.currentPage < #request.pageView.totalPage">
				<a  id="pageA"  href="javascript:topage('<s:property value="#request.pageView.currentPage + 1"/>')" style="padding: 8px 8px;">
				下一页</a>
				<a  id="pageA"  href="javascript:topage('<s:property value="#request.pageView.totalPage"/>')" style="padding: 8px 8px;">
				末页 </a>
			</s:if>
			<s:else>
				<a  id="pageAS" href="javascript:void(0)"  style="padding: 8px 8px;">下一页</a> 
				<a  id="pageAS" href="javascript:void(0)"  style="padding: 8px 8px;">末页</a> 
			</s:else>
</div>