<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RegisterUser</title>
</head>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<script>
 $(function(){
	 var date = new Date();
	 var thisYear = date.getFullYear();

	 isMobile(); 
	 $('#startDate').val(date.toISOString().substring(0, 10));
	 $('#startDate').attr("max",thisYear+1+"-12-31");

		
	 $("#insert_User_btn").click(userInform_check);
	 $("#startDate").keydown(function(key){
		 if(key.keyCode==8	|| key.keyCode==46){
			 return false;
		 }
	 });


		
	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";

		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
			}else{
				$("body").attr('class','pc_body');
			}
		}
	}
	 
	function userInform_check(){
		
		var user_num = $("#userNum").val();
		var user_mail = $("#userMail").val();
		var user_pw = $("#password").val();
		var user_name = $("#userName").val();
		var user_startDate = $("#startDate").val();
		
 		if(user_num !="" && user_mail != ""&& user_pw != ""&& user_name != "" && user_startDate != ""){

 			$.ajax({
				type:"post",
				url:"check_multiple",
				data:{userNum:user_num,userMail:user_mail},
				dataType:"text",
				success:function(result){
					
					if(result == "存在する社員番号です。"){
						alert(result);
						$("#userNum").focus();
						
					}else if(result == "存在するメールアドレスです。"){
						alert(result);
						$("#userMail").focus();	
																				
					}else if(confirm("登録しましか？")){
						$('#userRegister_Form').submit();			
					} 
				}
			}); 
		} 

		if(user_num == ""){
			alert("社員番号を入力してください。");
			$("#userNum").focus();
		}else if(user_mail == ""){
			alert("メールアドレスを入力してください。");
			$("#userMail").focus();
		}else if(user_pw == ""){
			alert("パスワードを入力してください。");
			$("#password").focus();
		}else if(user_name == ""){
			alert("社員名を入力してください。");
			$("#userName").focus();
		}else if(user_startDate == ""){
			alert("入社日を入力してください。");
			$("#startDate").focus();
		}
		return false;
	}
	
});
 
</script>
<style type="text/css">

body{
text-align:center;
}

a{
text-decoration: none;
}

#insert_User_btn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
}

.return_Btn{
border: solid 2px rgb(0, 0, 0);
border-radius: 9px;
padding: 2px 5px;
color: black;
cursor: pointer;
}

#registerUser_contents{
margin: 70px auto;
width: fit-content;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

#tr_btn{
height: 55px;
}

td{
height: 28px;
}

#authority{
height: 24px;
width: 70px;
}

input[type="number"],input[type="text"],input[type="password"]{
height: 18px;
}
</style>
<body>
<h1>社員登録</h1>

<div id = "registerUser_contents">
<form action="../admin/userRegister" method="post" id="userRegister_Form">
<table>
<tr>
<td><label for="userNum">社員番号</label></td>
<td><input type="number" id="userNum" name="userNum"></td>
</tr>
<tr>
<td><label for="userMail">社員メール</label></td>
<td><input type="text" id="userMail" name="userMail"></td>
</tr>
<tr>
<td><label for="password">パスワード</label></td>
<td><input type="password" id="password" name="password"></td>
</tr>
<tr>
<td><label for="userName">社員名</label></td>
<td><input type="text" id="userName" name="userName"></td>
</tr>
<tr>
<td><label for="position">職級</label></td>
<td><input type="text" id="position" name="position"></td>
</tr>
<tr>
<td><label for="team">チーム名</label></td>
<td><input type="text" id="team" name="team"></td>
</tr>
<tr>
<td><label for="startDate">入社日</label></td>
<td style="text-align: left;"><input type="date"  id="startDate" name="startDate" onkeypress="return false"></td>
</tr>
<tr>
<td><label for="authority">権限</label></td>
<td style="text-align: left;"><select name="authority" id="authority">
	<option value="a">管理者</option>
	<option value="u" selected="selected">社員</option>
</select></td>
</tr>
<tr>
<td colspan="2" id="tr_btn"><button id="insert_User_btn">社員登録</button>
</td>
</tr>
</table>
</form>
</div>
</body>
</html>

