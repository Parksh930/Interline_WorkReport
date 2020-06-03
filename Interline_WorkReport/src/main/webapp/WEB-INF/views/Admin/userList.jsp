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
	var team=[];
	var list_sort;
	var table_title;
	var status = "all";
	var others;

	first_list();
	$('input[name="user_team"]').click(team_Filter);
	$("input[name='user_status']").click(status_Filter);
	$("#Userlist_sort").change(List_Sort);

	
	function List_Sort(){
		var con = table_title;
		var measure = ($(this).val()).split('_');

		if(measure[0] == "userNum" && measure[1] == "ascending"){
			list_sort.sort(function(a,b){return a[measure[0]] - b[measure[0]]});
		}else if(measure[0] == "userNum" && measure[1] == "descending"){
			list_sort.sort(function(a,b){return b[measure[0]] - a[measure[0]]});
		}

		if(measure[0] != "userNum" && measure[1] == "ascending"){
			list_sort.sort(function(a,b){return a[measure[0]] < b[measure[0]] ? -1 : a[measure[0]] > b[measure[0]] ? 1 : 0})
		}else if(measure[0] != "userNum" && measure[1] == "descending"){
			list_sort.sort(function(a, b) {return a[measure[0]] > b[measure[0]] ? -1 : a[measure[0]] < b[measure[0]] ? 1 : 0;});
		} 
		
		list_sort.forEach(function(item){
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
	}

	function first_list(){

		table_title= '<tr><table id = "list_table"><th class="Userlist_userNum">社員番号</th>';
		table_title	+='<th class="Userlist_userMail">社員メール</th><th class="Userlist_userName">社員名</th>';
		table_title	+='<th class="Userlist_team">チーム名</th><th class="Userlist_position">職級</th>';
		table_title	+='<th class="Userlist_startDate">入社日</th><th class="Userlist_lastupdateDate">最新更新日</th>';
		table_title	+='<th class="Userlist_finalreportDate">最終提出分</th><th class="Userlist_retirement">退職区分</th></tr>';

		var con = table_title;

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

	function team_Filter(){
		team = [];
		
		if($('#team_others').prop("checked")){
			others = "not";
			$('input[name="user_team"]').each(function(){				
				if($(this).prop("checked") && $(this)[0].value != "その他"){
						team.splice(team.indexOf($(this).val()),1);
				}else if($(this)[0].value != "その他"){
					team.push($(this).val());
				}
			});
		}
		else{
			others = null;

			$('input[name="user_team"]').each(function(){
	
				if($(this).prop("checked")){
					team.push($(this).val());
				}else if(team.indexOf($(this).val())>0){
					
					team.splice(team.indexOf($(this).val()),1);
				}
			});
		}

		reslut_Filter();
	}

	function status_Filter(){
		status = $(this).val();

		reslut_Filter();
	}

	function reslut_Filter(){
		var con = table_title;
		
		if(team == "" || team == null){
			team.push("team_all");
		}else if(team.indexOf("team_all") > -1 && team.length >= 2){
			team.splice(team.indexOf("team_all"),1);
		}
		
		$.ajax({
		type:"get",
		url:"user_Filter",
		data:{team:team,status:status,others:others},
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
<input type="checkbox" id ="team_tokyo" name ="user_team" value="東京"><label for="team_tokyo">東京</label>
<input type="checkbox" id ="team_yokohama" name ="user_team" value="横浜"><label for="team_yokohama">横浜</label>
<input type="checkbox" id ="team_saitama" name ="user_team" value="埼玉"><label for="team_saitama">埼玉</label>
<input type="checkbox" id ="team_others" name ="user_team" value="その他"><label for="team_others">その他</label>
<br>
<input type="radio" id="status_all" name="user_status" value="status_all" checked="checked"><label for="status_all">全員</label>
<input type="radio" id="status_submitted" name="user_status" value="status_submitted"><label for="status_submitted">提出済み</label>
<input type="radio" id="status_writing" name="user_status" value="status_writing"><label for="status_writing">未提出</label>
</div>
<div id="list_sort">
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