<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<script>

</script>	

<style>
#list_Box{
height:600px;
width:1000px;
}
a[class*="_Btn"]{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
text-decoration: none;
width: 80%;
height: 10%;
}
div[class*="_Btn"]{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
width: 70%;
height: 15%;
margin:0 auto;
font-size: 23px;
}
</style>
</head>
<body>


<div class="menuBar" style="position: absolute; left: 0px; z-index: 1000; width:20%; text-align: center;">
	<img id="" src="/report/resources/image/interline2.png" width="100%" height="100%" ><span style="font-size: 30px; font-weight: bolder;">管理者</span><br></br><br></br>

	<div class="menu_Btn"><a class="_Btn" href="../admin/reportList" target="list_Box">勤務表リスト</a></div><br></br>
	<div class="menu_Btn"><a class="menu_Btn" href="../admin/userList" target="list_Box">社員リスト</a></div><br></br>
	<div class="menu_Btn"><a class="menu_Btn" href="../logout">ログアウト</a></div>

</div>
<div id="_iframe" style="position:absolute; left:20%;  text-align: left;">
	<iframe name="list_Box" id="list_Box" src="../admin/reportList" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
</div>


</body>
</html>