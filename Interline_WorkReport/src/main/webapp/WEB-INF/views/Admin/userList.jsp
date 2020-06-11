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
	var user_team=[];
	var user_sort;
	var user_table_title;
	var status = "all";
	var team_others;
	var user_Measure = ["userNum","ascending"];

	first_userList();
	
	$('input[name="user_team"]').click(user_Team_Filter);
	$("input[name='user_status']").click(user_Status_Filter);
	$("#Userlist_sort").change(user_List_Sort);

	
	function user_List_Sort(){
		var con = user_table_title;

		if($(this)[0].id == "Userlist_sort"){
			user_Measure = ($(this).val()).split('_');
		}

		
		if(user_Measure[0] == "userNum" && user_Measure[1] == "ascending"){
			user_sort.sort(function(a,b){
				return a[user_Measure[0]] - b[user_Measure[0]];
			});
		}else if(user_Measure[0] == "userNum" && user_Measure[1] == "descending"){
			user_sort.sort(function(a,b){
				return b[user_Measure[0]] - a[user_Measure[0]];
			});
		}

		
		if(user_Measure[0] != "userNum" && user_Measure[1] == "ascending"){
			user_sort.sort(function(a,b){
				return a[user_Measure[0]] < b[user_Measure[0]] ? -1 : a[user_Measure[0]] > b[user_Measure[0]] ? 1 : 0;
			});
		}else if(user_Measure[0] != "userNum" && user_Measure[1] == "descending"){
			user_sort.sort(function(a, b) {
				return a[user_Measure[0]] > b[user_Measure[0]] ? -1 : a[user_Measure[0]] < b[user_Measure[0]] ? 1 : 0;
			});
		}
		

		if(user_Measure[0].indexOf("Date") > -1 && user_Measure[1] == "ascending"){
			user_sort.sort(function(a,b){

				var dateA = new Date(a[user_Measure[0]]).getTime();
				var dateB = new Date(b[user_Measure[0]]).getTime();

				return dateA > dateB ? 1 : -1;
			});
		}else if(user_Measure[0].indexOf("Date") > -1  && user_Measure[1] == "descending"){
			user_sort.sort(function(a,b){

				var dateA = new Date(a[user_Measure[0]]).getTime();
				var dateB = new Date(b[user_Measure[0]]).getTime();
				
				return dateA < dateB ? 1 : -1;
			});
		}
		
		user_sort.forEach(function(item){
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
					console.log(item.lastreportDate);
					con +='<td class="Userlist_lastreportDate">'+item.lastreportDate.substring(0,4)+"年"+item.lastreportDate.substring(5,7)+"月"+'</td>';
				}else {
					con +='<td class="Userlist_lastreportDate"></td>'
				}

				con +='<td class="Userlist_retirement">'+item.retirement+'</td>';
				con +='<td class="Userlist_updateBtn"><a class="Update_Btn" href="userUpdate?Num='+item.userNum+'">修正</a></td>';
			});
			
		con += "</table>";
		$("#user_List").html(con);

		if($('#list_Box',parent.document)[0] != null){
			$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+50+'px');
		}
	}

	function first_userList(){

		user_table_title= '<table id = "user_list_table"><tr><th class="Userlist_userNum">社員番号</th>';
		user_table_title	+='<th class="Userlist_userMail">社員メール</th><th class="Userlist_userName">社員名</th>';
		user_table_title	+='<th class="Userlist_team">チーム名</th><th class="Userlist_position">職級</th>';
		user_table_title	+='<th class="Userlist_startDate">入社日</th><th class="Userlist_lastupdateDate">最新更新日</th>';
		user_table_title	+='<th class="Userlist_finalreportDate">最終提出分</th><th class="Userlist_retirement">退職区分</th>';
		user_table_title	+='<th class="Userlist_updateBtn"></th></tr>';

		var con = user_table_title;

			$.ajax({
			type:"post",
			url:"userList",
			async:false,
			traditional: true,
			dataType:"json",
			success:function(list){
				
				user_sort = list;
			}	
		});

		user_List_Sort();
	}

	function user_Team_Filter(){
		user_team = [];

		$('input[name="user_team"]').each(function(){
			if($(this)[0].value != "その他"){
				user_team.push($(this).val());
			}
		});
		
		if($('#team_others').prop("checked")){
			team_others = "not";
			$('input[name="user_team"]').each(function(){
				if($(this).prop("checked") && $(this)[0].value != "その他"){
					user_team.splice(user_team.indexOf($(this).val()),1);
				}
			});
		}
		else{
			team_others = null;
			$('input[name="user_team"]').each(function(){
				if($(this).prop("checked") == false && $(this)[0].value != "その他"){
					user_team.splice(user_team.indexOf($(this).val()),1);
				}
			});
		}

		user_reslut_Filter();
	}

	function user_Status_Filter(){
		status = $(this).val();

		user_reslut_Filter();
	}

	function user_reslut_Filter(){
		
		if(user_team == "" || user_team == null){
			user_team.push("team_all");
		}else if(user_team.indexOf("team_all") > -1 && user_team.length >= 2){
			user_team.splice(user_team.indexOf("team_all"),1);
		}

		$.ajax({
		type:"get",
		url:"user_Filter",
		data:{team:user_team,status:status,team_others:team_others},
		async:false,
		traditional: true,
		dataType:"json",
		success:function(list){
				user_sort = list;
			}	
		});
		user_List_Sort();
	}
});

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

#user_List{
margin: 20px auto;
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

.Userlist_userNum, .Userlist_team,.Userlist_position,.Userlist_retirement
,.Userlist_startDate,.Userlist_finalreportDate,.Userlist_lastupdateDate {
	width: 100px;
}
.Userlist_userMail{
	width: 200px;
}

.Userlist_userName  {
	width: 150px;
}

.Admin_userRegister{
text-align: right;
margin: 10px 60px 0px 0px;
}

fieldset{
	border: 0;
	padding:5px 12px 5px 12px;	
}

#user_list_sort{
text-align: left;
margin:20px 0px 0px 0px;
}

#Userlist_sort{
margin: auto;
height: 24px;
}

#user_status_span{
margin: 0px 0px 0px -86px;
}

.Update_Btn{
font-size: 14px;
}

</style>
</head>
<body>
<h1>社員リスト</h1>
<div id = "user_filter">
<fieldset id = "">
<span id="user_team_span">チーム名：</span>
<input type="checkbox" id ="team_tokyo" name ="user_team" value="東京"><label for="team_tokyo">東京</label>
<input type="checkbox" id ="team_yokohama" name ="user_team" value="横浜"><label for="team_yokohama">横浜</label>
<input type="checkbox" id ="team_saitama" name ="user_team" value="埼玉"><label for="team_saitama">埼玉</label>
<input type="checkbox" id ="team_others" name ="user_team" value="その他"><label for="team_others">その他</label>
</fieldset>
<fieldset id = "">
<span id="user_status_span">前月分の提出状況：</span>
<input type="radio" id="status_all" name="user_status" value="status_all" checked="checked"><label for="status_all">全員</label>
<input type="radio" id="status_submitted" name="user_status" value="status_submitted"><label for="status_submitted">提出済み</label>
<input type="radio" id="status_writing" name="user_status" value="status_writing"><label for="status_writing">未提出</label>
</fieldset>
</div>
<div id="user_list_sort">
<select id ="Userlist_sort" name="Userlist_sort">
<option value="userNum_ascending">社員番号の昇順</option>
<option value="userNum_descending">社員番号の降順</option>
<option value="userMail_ascending">社員メールの昇順</option>
<option value="userMail_descending">社員メールの降順</option>
<option value="userName_ascending">社員名の昇順</option>
<option value="userName_descending">社員名の降順</option>
<option value="team_ascending">チーム名の昇順</option>
<option value="team_descending">チーム名の降順</option>
<option value="position_ascending">職級の昇順</option>
<option value="position_descending">職級の降順</option>
<option value="startDate_ascending">入社日の昇順</option>
<option value="startDate_descending">入社日の降順</option>
<option value="lastupdateDate_ascending">最新更新日の昇順</option>
<option value="lastupdateDate_descending">最新更新日の降順</option>
<option value="lastreportDate_ascending">最終提出分の昇順</option>
<option value="lastreportDate_descending">最終提出分の降順</option>
<option value="retirement_ascending">退職区分の昇順</option>
<option value="retirement_descending">退職区分の降順</option>
</select>
</div>
<div id ="user_List">
</div>
<div id="Register_Btn">
<p class="Admin_userRegister"><a class="Register_Btn" href="userRegister">社員登録</a></p>
</div>
</body>
</html>