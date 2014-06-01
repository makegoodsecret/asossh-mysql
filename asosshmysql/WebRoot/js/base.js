function topage(page)
{
	var form = document.forms[0];
	form.page.value = page;
	form.submit();
}
 function maxResult(maxResult)
{  alert(maxResult);
//	var form = document.forms[0];
	form.maxResult.value = maxResult;
	form.submit();
}