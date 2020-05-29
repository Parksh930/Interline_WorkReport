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
</style>
</head>
<body>
<a href="../admin/reportList" target="list_Box">勤務表リスト</a>
<a href="../admin/userList" target="list_Box">社員リスト</a>
<a href="../logout">ログアウト</a>
<div id="_iframe">
<iframe name="list_Box" id="list_Box" src="../admin/reportList"></iframe>
</div>
</body>
</html>