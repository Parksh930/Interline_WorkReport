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


#title{
font-size: 90px;
}

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

td{
	margin: auto;
	font-size: 60px;
	height: 80px;
}


.udbtn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
font-size: 70px;
}

</style>
<body>
<img src="../resources/image/interline1.png" style="width: 50%;">
<div id="title">パスワード変更</div>

<div id = "profileUd" style="text-align: center;">
<form action="../user/changePW" method="post" id="profileUpdate">
<br></br>
<br></br>

<table style="margin: auto; width: 50%;">
	<tr>
		<td class="td1" style="text-align:right;">&nbsp;PW&nbsp;</td>
		<td class="td2" ><input type="password" id="Password" class="passwordButton" name="password" style="font-size: 60px; margin: 2px;padding:2px; width:300px;"></td>
	</tr>
	<tr><td></td></tr>
	<tr>
		<td colspan="2"  id="ubtn"><button id ="udbtn" class="udbtn">確認</button>
		<div align="right">
		
		<input type = "hidden" name="page" id="page" value="1"/>
		</div>
		</td>
	</tr>
</table>
</form>
</div>

<script type="text/javascript">
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			//alert('mobile 접속'); 
		} else { 
			console.log("pc접속")
			$('#title').css('font-size', '60px');
			$('td').css('font-size', '20px');
			$('td').css('height', '35px');
			$('input').css('font-size', '20px');
			$('button').css('font-size', '20px');
			
		} 
	}	
</script>


</body>
</html>

