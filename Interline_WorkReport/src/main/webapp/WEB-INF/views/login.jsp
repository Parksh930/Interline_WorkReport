<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Login</title>
</head>

<script src="<c:url value = 'resources/js/jquery-2.0.3.min.js'/>"></script>

<script>
<c:if test="${error!=null && error!=''}">alert("${error}");</c:if>

$(document).ready(function(){
	/* isMobile(); */
	
	function isMobile() {
	    var filter = "win16|win32|win64|mac|macintel";
	    if( navigator.platform  ){
	      if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
	    	  $("#login_div").attr('id','phone_login_div');
	      }else{
	    	  $("#login_div").attr('id','pc_login_div');
	      }
	    }
	  }
	
	$("#login_form").submit(function(){
		var id = $("#login_id").val();
		var pw = $("#login_pw").val();

		if(id !="" && pw != ""){
			return true;
		}
		
		if(id == ""){
			alert("メールアドレスを入力してください。");
			$("#login_id").focus();
		}else if(pw == ""){
			alert("パスワードを入力してください。");
			$("#login_pw").focus();
		}
		return false;
	});

});
</script>

<style>
*{
font-size: 20px;
}

#login_div{
margin: 200px auto;
width: fit-content;
}

tr{
height: 35px;
}

input[type=text],input[type=password]{
border: solid 2px rgb(127,127,127);
width:230px;
}

input[type=submit]{
	border: solid 2px rgb(0, 112, 192);
	border-radius: 9px;
	padding: 2px 5px;
	background-color: rgb(0, 112, 192);
	color: white;
	cursor: pointer;
}

.login_text{
color:rgb(0,51,102);
}

.title_text{
color:rgb(31,73,125);
}

.login_th_title{
text-align: left;
padding: 0px 0px 20px 0px;
}

.login_td_id,.login_td_pw{
padding:0px 30px 0px 0px;
}

.login_td_Submit{
padding: 20px 0px 0px 0px;
}

</style>
<body>

<div id="login_div">
<img src="<c:url value = 'resources/image/interline_login.png'/>" id="login_logo">
<table>
<tr>
<th colspan="2" class="login_th_title">
<span class="login_text">ログイン</span>
<span class="title_text">勤務票報告 システム</span></th>
</tr>
<form action="login" method="post" id="login_form">
<tr>
<td class="login_td_id">メールアドレス</td>
<td class="login_td_id"><input type="text" id="login_id" name="login_id"></td>
</tr>
<tr>
<td class="login_td_pw">パスワード</td>
<td class="login_td_pw"><input type="password" id="login_pw" name="login_pw"></td>
</tr>
<tr>
<td colspan="2" class="login_td_Submit"><input type="submit" value="ログイン" id="btn_login"></td>
</tr>
<input id="mobileCheck" type="hidden" name="mobileCheck" value="">
</form>
</table>
</div>
</body>
</html>
