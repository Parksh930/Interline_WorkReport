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
</head>
<body>
<a href="" target="list_Box">勤務表リスト</a>
<a href="../admin/userList" target="list_Box">社員リスト</a>
<a href="../logout">ログアウト</a>
<div id="_iframe">
<iframe width="1000px" height="500px" name="list_Box" id="list_Box" src="../admin/userList"></iframe>
</div>
</body>
</html>