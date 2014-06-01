<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib  prefix="s"  uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>用户评价页面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	
	<script type="text/javascript" src="<%=basePath%>ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="<%=basePath%>ckeditor/samples/assets/uilanguages/languages.js"></script>
	<script type="text/javascript">
		function GetContents() {
	var editor = CKEDITOR.instances.editor1;
	alert( editor.getData() );
}
		
	</script>
</head>
<body>
		<p>
			可选择使用的 (<span id="count"> </span> 种语言):<br>
			<script>

				document.write( '<select disabled="disabled" id="languages" onchange="createEditor( this.value );">' );
				for ( var i = 0 ; i < window.CKEDITOR_LANGS.length ; i++ ) {
					document.write(
						'<option value="' + window.CKEDITOR_LANGS[i].code + '">' +
							window.CKEDITOR_LANGS[i].name +
						'</option>' );
				}

				document.write( '</select>' );

			</script>
			<br>
			<span style="color: #888888">
				(如果你的系统不支持所选择的语言,您可能会看到奇怪的字符)
			</span>
		</p>
		<p style="width: 750px; " >
			<textarea cols="30" id="editor1" name="editor1" rows="10" >
			 
			</textarea>
			<script>
				document.getElementById( 'count' ).innerHTML = window.CKEDITOR_LANGS.length;
				var editor;
				function createEditor( languageCode ) {
					if ( editor )
						editor.destroy();
					editor = CKEDITOR.replace( 'editor1', {
						uiColor: '#FFBB1F',
						/* toolbar: [
							[ 'Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink' ],
							[ 'FontSize', 'TextColor', 'BGColor' ]
						], */
						language: languageCode,
						on: {
							instanceReady: function() {
								var languages = document.getElementById( 'languages' );
								languages.value = this.langCode;
								languages.disabled = false;
							}
						}
					});
				}
				createEditor( '' );
			</script>
		</p>
		<input onclick="GetContents();" type="button" value="点点这里看看这是什么">
</body>
</html>
