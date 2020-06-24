<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userList</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
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
	$(document).on('click','.Userlist_sort',user_List_Sort);
	
	function user_List_Sort(){
		var con = user_table_title;

		if($(this)[0].className == "Userlist_sort"){
			user_Measure = ($(this)[0].id).split('_');
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

				return dateA > dateB ? 1 : dateA < dateB ? -1 : 0;
			});
		}else if(user_Measure[0].indexOf("Date") > -1  && user_Measure[1] == "descending"){
			user_sort.sort(function(a,b){

				var dateA = new Date(a[user_Measure[0]]).getTime();
				var dateB = new Date(b[user_Measure[0]]).getTime();
				
				return dateA < dateB ? 1 : dateA > dateB ? -1 : 0;
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

		user_table_title	= '<table id = "user_list_table"><tr>';
		user_table_title	+='<th class="Userlist_userNum"><table class="thTable"><tr><td rowspan="2">社員番号</td><td id="userNum_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="userNum_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_userMail"><table class="thTable"><tr><td rowspan="2">社員メール</td><td id="userMail_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="userMail_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_userName"><table class="thTable"><tr><td rowspan="2">社員名</td><td id="userName_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="userName_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_team"><table class="thTable"><tr><td rowspan="2">チーム名</td><td id="team_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="team_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_position"><table class="thTable"><tr><td rowspan="2">職級</td><td id="position_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="position_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_startDate"><table class="thTable"><tr><td rowspan="2">入社日</td><td id="startDate_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="startDate_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_lastupdateDate"><table class="thTable"><tr><td rowspan="2">最新<br>更新日</td><td id="lastupdateDate_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="lastupdateDate_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_finalreportDate"><table class="thTable"><tr><td rowspan="2">最終<br>提出分</td><td id="finalreportDate_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="finalreportDate_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<th class="Userlist_retirement"><table class="thTable"><tr><td rowspan="2">退職区分</td><td id="retirement_ascending" class="Userlist_sort"><div>▲</div></td></tr><tr><td id="retirement_descending" class="Userlist_sort"><div>▼</div></td></tr></table></th>';
		user_table_title	+='<td class="Userlist_updateBtn"></td></tr>';

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

th,td{
border: 1px solid black;
}

.thTable{
border-style:none;
border-bottom:none;
margin-left: auto;
margin-right: auto;
}

.thTable td{
border:none;
}

td[id*="_ascending"] div{
margin:0px 0px -5px 0px;
}

td[id*="_descending"] div{
margin:-5px 0px 0px 0px;
}

.Userlist_sort:hover{
cursor:pointer;
font-weight:900;
}

#user_List{
margin: 20px auto;
width: fit-content;
}

.Userlist_updateBtn{
border-style: none;
width:50px;
height: 45px;
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
<div id ="user_List">
</div>
<div id="Register_Btn">
<p class="Admin_userRegister"><a class="Register_Btn" href="userRegister">社員登録</a></p>
</div>
</body>
</html>