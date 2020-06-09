<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<script>
$(function(){
	
	$('#list_Box').css('min-height',window.innerHeight-100+'px');
	$('#list_Box').attr("src","../admin/reportList");
	
	$('#list_Box').load(function(){
		
		if($(this).contents().find('#OZViewer').html()==null){
         	$(this).css('height',($(this).contents().find('body')[0].scrollHeight)+50+'px');
		}else{
			$(this).css('height',window.innerHeight-40+'px');
		}
	});
});
</script>	

<style>
#list_Box{
width:1100px;
}

a[class*="_Btn"]{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
text-decoration: none;
}

#_iframe{
margin:20px 0px 0px 0px;
}
</style>
</head>
<body>


<div id="menuBar" style="position: absolute; left: 0px; z-index: 1000; text-align: center; width:20%;">
	<img id="" src="/report/resources/image/interline2.png" width="100%" height="100%" ><span style="font-size: 30px; font-weight: bolder;">管理者</span><br></br><br></br>
	<a class="_Btn" href="../admin/reportList" target="list_Box">勤務表リスト</a><br></br><br></br>
	<a class="_Btn" href="../admin/userList" target="list_Box">社員リスト</a><br></br><br></br>
	<a class="_Btn" href="../logout">ログアウト</a>
</div>
<div id="_iframe" style="position:absolute; left:20%;  text-align: left;">
<iframe name="list_Box" id="list_Box" src="" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
</div>


</body>
</html>