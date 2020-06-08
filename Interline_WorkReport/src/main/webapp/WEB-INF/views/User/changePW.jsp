<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pw change</title>
</head>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<script>
 $(function(){
	$("#udbtn").click(function(){
		var user_pw = $("#Password").val();

						if( user_pw != ""){
							$("#profileUpdate").submit();
							alert("修正完了");
						} 

		
		 if(user_pw == ""){
			alert("PWを入力してください。");
			$("#Password").focus();
		}
		return false;
	});
	
});



 
</script>
<style type="text/css">

body{
text-align:center;
}

#profileUd{
margin: 100px auto;
width: fit-content;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

.udbtn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
}

</style>
<body>
<h1>パスワード変更</h1>

<div id = "profileUd" style="font-size: 30px;">
<form action="../user/changePW" method="post" id="profileUpdate">
<table>
<tr></tr>

<tr>
	<td>PW</td>
	<td><input type="password" id="Password" class="passwordButton" name="Password" style="font-size: 30px;"></td>
</tr>
<tr><td></td></tr>
<tr>
	<td colspan="2"  id="ubtn"><button id ="udbtn" class="udbtn" style="font-size: 30px;">確認</button>
	<div align="right">
	
	<input type = "hidden" name="page" id="page" value="1"/>
	</div>
	</td>
</tr>

</table>
</form>
</div>
</body>
</html>

