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
		
		 if(user_pw == ""){
			alert("PWを入力してください。");
			$("#Password").focus();
		}
			
		 if(user_pw.length < 6 || user_pw.length > 10){
			  alert("6~10文字で入力ください。");
		return false;
		 }

		 else {
				$("#profileUpdate").submit();
				alert("パスワード変更できました。");
			}

	});
	
});


 
 
</script>
<style type="text/css">

body{
text-align:center;
font-family: -apple-system-subset,Helvetica,Hiragino Kaku Gothic ProN,sans-serif;
}


#title{
font-size: 18px;
font-family: inherit;
font-weight : 700;
}


input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}


td{
	margin: auto;
	font-size: 60px;
	font-family: inherit;
	height: 80px;
}


.udbtn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
font-size: 14px;
font-family: inherit;
text-align: center;
}


</style>
<body>

<div id="title">パスワード変更</div>

<div id = "profileUd" style="text-align: center;">
<form action="../user/changePW" method="post" id="profileUpdate">
<br></br>
<br></br>

<table style="margin: auto; width: 50%;">



<div class="body">パスワード <div class="body">
<input class="form-control" id="Password" type="password" name="password" style="font-size:16px; font-family: inherit;"> </div> </div> 
<div class="signInMark form-group">パスワード確認 <div class="signInLeft">
<input class="form-control" id="passwordCheck" type="password" name="passwordcheck" style="font-size:16px; font-family: inherit;"> </div> </div> 


	<tr>
		<td colspan="2"  id="ubtn"><button id ="udbtn" class="udbtn" onclick="location='../user/myReportList'">確認</button>
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













