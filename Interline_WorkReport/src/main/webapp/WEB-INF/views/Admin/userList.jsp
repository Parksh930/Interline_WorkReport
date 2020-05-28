<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList</title>
<style>
body{
text-align:center;
}

a{
text-decoration: none;
}

table {
  border-collapse: collapse;
}

tr{
height: 45px;
}

th,td{
border: 1px solid black;
}

#navigator{
text-align: center;
margin: 20px 0px 0px 0px;
}

#user_List{
margin: 50px auto;
width: fit-content;
}

.Userlist_updateBtn{
border-style: none;
width:50px;
}

a[class*="_Btn"]{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
}

th[class^="Userlist"]{
width: 100px;
}

.Admin_userRegister{
text-align: right;
margin: 10px 60px 0px 0px;
}
</style>
</head>
<body>
<h1>社員リスト</h1>
<div id ="user_List">
<table>
<tr>
<th class="Userlist_userNum">社員番号</th><th class="Userlist_userMail">社員メール</th>
<th class="Userlist_userName">社員名</th><th class="Userlist_team">チーム名</th>
<th class="Userlist_position">職級</th><th class="Userlist_startDate">入社日</th>
<th class="Userlist_lastupdateDate">最新更新日</th><th class="Userlist_finalreportDate">最終提出分</th>
<th class="Userlist_retirement">退職区分</th>
</tr>
<c:forEach var = "user_List" items="${user_all}">
<tr>
<td class="Userlist_userNum">${user_List.userNum}</td>
<td class="Userlist_userMail">${user_List.userMail}</td>
<td class="Userlist_userName">${user_List.userName}</td>
<td class="Userlist_team">${user_List.team}</td>
<td class="Userlist_position">${user_List.position}</td>
<td class="Userlist_startDate">${user_List.startDate}</td>
<td class="Userlist_lastupdateDate">${user_List.lastupdateDate}</td>
<td class="Userlist_finalreportDate">${user_List.finalreportDate}</td>
<td class="Userlist_retirement">${user_List.retirement}</td>
<td class="Userlist_updateBtn"><a class="Update_Btn" href="userUpdate?Num=${user_List.userNum}">修正</a></td>
</tr>
</c:forEach>
</table>
<p class="Admin_userRegister"><a class="Register_Btn" href="userRegister">社員登録</a></p>
</div>
</body>
</html>