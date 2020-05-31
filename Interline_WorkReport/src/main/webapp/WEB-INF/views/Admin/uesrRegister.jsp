<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RegisterUser</title>
</head>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<script>
 $(function(){
	 $('#startDate').val(new Date().toISOString().substring(0, 10))	;	
	 
	$("#insert_User_btn").click(function(){
		var user_num = $("#userNum").val();
		var user_mail = $("#userMail").val();
		var user_pw = $("#password").val();
		var user_name = $("#userName").val();

 		if(user_num !="" && user_mail != ""&& user_pw != ""&& user_name != ""){

 			$.ajax({
				type:"post",
				url:"check_multiple",
				data:{userNum:user_num,userMail:user_mail},
				dataType:"text",
				success:function(result){

					if(result == "存在する社員番号です。"){
						alert(result);
						$("#userNum").focus();
						
					}else if(result == "存在するメースです。"){
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
			alert("メールを入力してください。");
			$("#userMail").focus();
		}else if(user_pw == ""){
			alert("パスワードを入力してください。");
			$("#password").focus();
		}else if(user_name == ""){
			alert("社員名を入力してください。");
			$("#userName").focus();
		}
		return false;
	});
	
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
margin: 30px auto;
width: fit-content;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

#tr_btn{
height: 50px;
}

</style>
<body>
<h1>社員登録</h1>

<div id = "registerUser_contents">
<form action="../admin/userRegister" method="post" id="userRegister_Form">
<table>
<tr>
<td>社員番号</td>
<td><input type="number" id="userNum" name="userNum"></td>
</tr>
<tr>
<td>社員メール</td>
<td><input type="text" id="userMail" name="userMail"></td>
</tr>
<tr>
<td>パスワード</td>
<td><input type="password" id="password" name="password"></td>
</tr>
<tr>
<td>社員名</td>
<td><input type="text" id="userName" name="userName"></td>
</tr>
<tr>
<td>職級</td>
<td><input type="text" id="position" name="position"></td>
</tr>
<tr>
<td>チーム名</td>
<td><input type="text" id="team" name="team"></td>
</tr>
<tr>
<td>入社日</td>
<td><input type="date" id="startDate" name="startDate"></td>
</tr>
<tr>
<td>権限</td>
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

