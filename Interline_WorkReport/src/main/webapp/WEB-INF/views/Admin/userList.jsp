<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<script>
$(function(){
	var list_sort;

	first_list();
	/* $("#Userlist_sort").change(List_Sort); */
	$("input[name='report_status']").click(status_Filter);
});

function List_Sort(){
	var list = list_sort;
	console.log(list);
	measure = $(this).val();
	
	$.ajax({
		type:"post",
		url:"userList_Sort",
		data:{List:list, Measure:measure},
		traditional: true,
		dataType:"json",
		success:function(result){
			console.log(result);
		}	
	});
}

function first_list(){

	var con = '<tr><table id = "list_table"><th class="Userlist_userNum">社員番号</th>';
		con	+='<th class="Userlist_userMail">社員メール</th><th class="Userlist_userName">社員名</th>';
		con	+='<th class="Userlist_team">チーム名</th><th class="Userlist_position">職級</th>';
		con	+='<th class="Userlist_startDate">入社日</th><th class="Userlist_lastupdateDate">最新更新日</th>';
		con	+='<th class="Userlist_finalreportDate">最終提出分</th><th class="Userlist_retirement">退職区分</th></tr>';

		$.ajax({
		type:"post",
		url:"userList",
		async:false,
		traditional: true,
		dataType:"json",
		success:function(list){

			list.forEach(function(item){
				con +='<tr><td class="Userlist_userNum">'+item.userNum+'</td>';
				con +='<td class="Userlist_userMail">'+item.userMail+'</td>';
				con +='<td class="Userlist_userName">'+item.userName+'</td>';
				con +='<td class="Userlist_team">'+item.team+'</td>';
				con +='<td class="Userlist_position">'+item.position+'</td>';
				con +='<td class="Userlist_startDate">'+item.startDate+'</td>';

				if(item.lastupdateDate != null){
					con +='<td class="Userlist_lastupdateDate">'+item.lastupdateDate+'</td>';
				}else {
					con +='<td class="Userlist_lastupdateDate"></td>'
					}
				if(item.lastreportDate != null){
					con +='<td class="Userlist_lastreportDate">'+item.lastreportDate+'</td>';
				}else {
					con +='<td class="Userlist_lastreportDate"></td>'
					}

				con +='<td class="Userlist_retirement">'+item.retirement+'</td>';
				con +='<td class="Userlist_updateBtn"><a class="Update_Btn" href="userUpdate?Num='+item.userNum+'">修正</a></td>';
			});
			
			con += "</table>";
			$("#user_List").html(con);
			list_sort = list;
		}	
	});
}

function status_Filter(){
	var status = $(this).val();

	var con = '<tr><table id = "list_table"><th class="Userlist_userNum">社員番号</th>';
		con	+='<th class="Userlist_userMail">社員メール</th><th class="Userlist_userName">社員名</th>';
		con	+='<th class="Userlist_team">チーム名</th><th class="Userlist_position">職級</th>';
		con	+='<th class="Userlist_startDate">入社日</th><th class="Userlist_lastupdateDate">最新更新日</th>';
		con	+='<th class="Userlist_finalreportDate">最終提出分</th><th class="Userlist_retirement">退職区分</th></tr>';

		$.ajax({
		type:"get",
		url:"statusFilter",
		data:{status:status},
		async:false,
		traditional: true,
		dataType:"json",
		success:function(list){

			list.forEach(function(item){
				con +='<tr><td class="Userlist_userNum">'+item.userNum+'</td>';
				con +='<td class="Userlist_userMail">'+item.userMail+'</td>';
				con +='<td class="Userlist_userName">'+item.userName+'</td>';
				con +='<td class="Userlist_team">'+item.team+'</td>';
				con +='<td class="Userlist_position">'+item.position+'</td>';
				con +='<td class="Userlist_startDate">'+item.startDate+'</td>';

				if(item.lastupdateDate != null){
					con +='<td class="Userlist_lastupdateDate">'+item.lastupdateDate+'</td>';
				}else {
					con +='<td class="Userlist_lastupdateDate"></td>'
					}
				if(item.lastreportDate != null){
					con +='<td class="Userlist_lastreportDate">'+item.lastreportDate+'</td>';
				}else {
					con +='<td class="Userlist_lastreportDate"></td>'
					}

				con +='<td class="Userlist_retirement">'+item.retirement+'</td>';
				con +='<td class="Userlist_updateBtn"><a class="Update_Btn" href="userUpdate?Num='+item.userNum+'">修正</a></td>';
			});
			
			con += "</table>";
			$("#user_List").html(con);
			list_sort = list;
		}	
	});

		console.log(list_sort);
}
</script>
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
margin: 50px auto 0px;
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
<div id = "user_filter">

<input type="radio" id="all" name="report_status" value="all" checked="checked"><label for="all">全員</label>
<input type="radio" id="submitted" name="report_status" value="submitted"><label for="submitted">提出済み</label>
<input type="radio" id="writing" name="report_status" value="writing"><label for="writing">未提出</label>
</div>
<div id="list_sort">
<select id ="Userlist_sort" name="Userlist_sort">
<option value="userNum_ascending">社員番号の昇順</option>
<option value="userNum_descending">社員番号の降順</option>
<option value="userMail_ascending">社員メールの昇順</option>
<option value="userMail_descending">社員メールの降順</option>
<option value="userName_ascending">社員名の昇順</option>
<option value="userName_descending">社員名の降順</option>
<option value="userTeam_ascending">チーム名の昇順</option>
<option value="userTeam_descending">チーム名の降順</option>
<option value="userPosition_ascending">職級の昇順</option>
<option value="userPosition_descending">職級の降順</option>
<option value="userStartDate_ascending">入社日の昇順</option>
<option value="userStartDate_descending">入社日の降順</option>
<option value="userLastupdateDate_ascending">最新更新日の昇順</option>
<option value="userLastupdateDate_descending">最新更新日の降順</option>
<option value="userFinalreportDate_ascending">最終提出分の昇順</option>
<option value="userFinalreportDate_descending">最終提出分の降順</option>
<option value="userRetirement_ascending">退職区分の昇順</option>
<option value="userRetirement_descending">退職区分の降順</option>
</select>
</div>
<div id ="user_List">
<table id = "list_table">
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
<td class="Userlist_lastreportDate">${user_List.lastreportDate}</td>
<td class="Userlist_retirement">${user_List.retirement}</td>
<td class="Userlist_updateBtn"><a class="Update_Btn" href="userUpdate?Num=${user_List.userNum}">修正</a></td>
</tr>
</c:forEach>
</table>
</div>
<div id="Register_Btn">
<p class="Admin_userRegister"><a class="Register_Btn" href="userRegister">社員登録</a></p>
</div>
</body>
</html>