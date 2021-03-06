<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>admin_updateUser</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<script>
$(function(){

	isMobile();
	$("#insert_User_btn").click(user_update);
	$("#delete_User_btn").click(user_delete);
	option_selected();
	

	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";

		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
			}else{
				$("body").attr('class','pc_body');
				$("input").addClass('pc_font_content1');
				$("select").addClass('pc_font_content1');
				$("option").addClass('pc_font_content1');
				$("td").addClass('pc_font_content1');
		    }
		}
	}
});

function option_selected(){
	
	$("#retirement option[value="+"${user.retirement}"+"]").prop('selected','selected');
	$("#authority option[value="+"${user.authority}"+"]").prop('selected','selected');
	
}

function user_update(){
	
	if(confirm("修正しましか？")){
		return true;
	}else{
		return false;
	}
}

function user_delete(){
	
	var num = $("#userNum").val();

	if(confirm("削除しましか？")){
		location.replace("../admin/userDelete?userNum="+num);
	}
	return false;
}
</script>
<style type="text/css">
body{
text-align:center;
}

a{
text-decoration: none;
}

#tr_btn{
height: 50px;
}

#registerUser_contents{
margin: 70px auto;
width: fit-content;
}

#UserNum, #UserId{
border: none;
cursor: context-menu;
}

#UserNum:focus, #UserId:focus,#insert_User_btn:focus,#delete_User_btn:focus { 
outline:none; 
}

.admin_update_btn{
text-align: right;
}

#insert_User_btn,#delete_User_btn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 0px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
font-size:16px
}

#insert_User_btn{
margin:0px 0px 0px 135px;
}

#delete_User_btn{
margin:0px 0px 0px 25px;
}

input[type="number"],input[type="text"],input[type="password"]{
height: 18px;
width:175px;
}

input:read-only{
height: 22px;
border:0px;
}

#tr_btn{
height: 55px;
}

td{
height: 28px;
}

select{
height: 24px;
width: 70px;
}
</style>
</head>
<body>
<h1>社員情報修正</h1>

<div id = "registerUser_contents">
<form action="../admin/userUpdate" method="post" id="userUpdate_Form">
<table>
<tr>
<td>社員番号</td>
<td><input type="number" id="userNum" name="userNum" value="${user.userNum}" readonly></td>
</tr>
<tr>
<td>社員メール</td>
<td><input type="text" id="userMail" name="userMail" value="${user.userMail}" readonly></td>
</tr>
<tr>
<td>パスワード</td>
<td><input type="password" id="password" name="password"></td>
</tr>
<tr>
<td>社員名</td>
<td><input type="text" id="userName" name="userName" value="${user.userName}" readonly></td>
</tr>
<tr>
<td>職級</td>
<td><input type="text" id="position" name="position" value="${user.position}"></td>
</tr>
<tr>
<td>チーム名</td>
<td><input type="text" id="team" name="team" value="${user.team}"></td>
</tr>
<tr>
<td>入社日</td>
<td><input type="text" id="startDate" name="startDate" value="${user.startDate}" readonly></td>
</tr>
<tr>
<td>退職区分</td>
<td style="text-align: left;"><select name="retirement" id="retirement">
	<option value="在職" selected="selected">在職</option>
	<option value="退職" >退職</option>
</select></td>
</tr>
<tr>
<td>権限</td>
<td style="text-align: left;"><select name="authority" id="authority">
	<option value="a">管理者</option>
	<option value="u" selected="selected">社員</option>
</select></td>
</tr>
<tr id="tr_btn"><td colspan="2">
<button id="insert_User_btn">修正</button>
<button id="delete_User_btn">削除</button>
</td></tr>
</table>
</form>
</div>
</body>
</html>