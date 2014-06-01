function formsubmit(href){
	var hrefaction = href.split("?");
	var formaction = hrefaction[0];
	var parameters = hrefaction[1].split("&");
	var $body      = $("#asosshgetpost");
	var bid        = parseInt(Math.random()*99999999);
	$body.prepend("<div id='divgetpost' style=' '></div>");
	var $divgetpost= $("#divgetpost");
	$divgetpost.prepend("<form action='"+formaction+"' id='getpostform"+bid+"' name='getpostform"+bid+"' method='post'>");
	$.each(parameters,function(i,parametervalue){
		var parametervalues= parametervalue.split("=");
		$("#getpostform"+bid).append("<input type='text'  name='"+parametervalues[0]+"' value='"+parametervalues[1]+"'>");
	});
	$divgetpost.append("</form>");
	$("#getpostform"+bid).action=href.split("?")[0];
	$("#getpostform"+bid).submit();
}

function getpostfunction(h){
	/*网站提交方式由get方式全部转换成post*/	
		var $this =  $(h);
	 	formsubmit($this.data("href"));//提交为post 
	}  