<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>Login</title>
</head>

<script src="<c:url value = 'resources/js/jquery-2.0.3.min.js'/>"></script>
<link href="resources/css/Font-Style.css" rel="stylesheet">

<script>
$(document).ready(function(){
	 isMobile(); 
	 $('#pc_btn_login').click(input_Check);
	 $('#mobile_btn_login').click(input_Check);
	 

	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";

		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
				$("#mobile_login_div").show();
			}else{
				$("body").attr('class','pc_body');
/* 				$("span").addClass('pc_font_title');
				$("label[for^='pc_']").addClass('pc_font_content1');
				$("input[id^='pc_']").addClass('pc_font_content1');
				$("button[id^='pc_']").addClass('pc_font_button1'); */
				$("#pc_login_div").show();
			}
		}
	}

	function input_Check(){
		var device = ($(this)[0].id).split("_")[0];
		var id=$("#"+device+"_login_id").val();
		var pw=$("#"+device+"_login_pw").val();

		if(id !="" && pw != ""){
			$.ajax({
				type:"post",
				url:"login",
				traditional: true,
				data:{login_id:id,login_pw:pw},
				dataType:"json",
				success:function(result){
					
					if(result.error!=null){
						alert(result.error);
					}else if(result.error==null){
						location.href=result.url;
					}
				}	
			});
			$("#"+device+"_login_id").val("");
			$("#"+device+"_login_pw").val("");
		}
		
		if(id == ""){
			alert("メールアドレスを入力してください。");
			$("#"+device+"_login_id").focus();
		}else if(pw == ""){
			alert("パスワードを入力してください。");
			$("#"+device+"_login_pw").focus();
		}
		return false;
	}
});

</script>

<style>

#pc_login_div{
margin: 200px auto;
width: fit-content;
text-align:center;
display:none;
}

#mobile_login_div{
margin: 200px auto;
width: fit-content;
text-align:center;
display:none;
}

tr{
height: 35px;
}

input[type=text],input[type=password]{
border: solid 2px rgb(127,127,127);
width:230px;
}

button{
	border: solid 2px rgb(0, 112, 192);
	border-radius: 9px;
	padding: 2px 5px;
	background-color: rgb(0, 112, 192);
	color: white;
	cursor: pointer;
	font-size:16px;
}

.login_text{
color:rgb(0,51,102);
}

.title_text{
color:rgb(31,73,125);
}

.login_th_title{
padding: 0px 0px 10px 0px;
}

.login_td_id,.login_td_pw{
padding:0px 25px 0px 0px;
}

.login_td_Submit{
padding: 15px 0px 0px 0px;
}

#mobile_login_div input[type=text],#mobile_login_div input[type=password]{
width:600px;
}

.pc_login_label,.mobile_login_label{
text-align: left;
}
	
</style>
<body>

<div id="pc_login_div" style="display:none;">
<img src="<c:url value = 'resources/image/interline_login.png'/>" id="login_logo">
<table>
<tr>
<th colspan="2" class="login_th_title pc_font_title">
<span class="title_text">勤務票報告 システム</span></th>
</tr>
<tr>
<td class="login_td_id pc_login_label pc_font_content1"><label for="pc_login_id">メールアドレス</label></td>
<td class="login_td_id"><input type="text" id="pc_login_id" name="login_id"></td>
</tr>
<tr>
<td class="login_td_pw pc_login_label pc_font_content1"><label for="pc_login_pw">パスワード</label></td>
<td class="login_td_pw"><input type="password" id="pc_login_pw" name="login_pw"></td>
</tr>
<tr>
<td colspan="2" class="login_td_Submit"><button id="pc_btn_login">ログイン</button></td>
</tr>

</table>
</div>


<div id="mobile_login_div">
<img src="<c:url value = 'resources/image/interline_login.png'/>" id="login_logo">
<table>
<tr>
<th colspan="2" class="login_th_title">
<span class="title_text mobile_font_title">勤務票報告 システム</span></th>
</tr>
<tr>
<td class="login_td_id mobile_login_label mobile_font_content1"><label for="mobile_login_id">メールアドレス</label></td>
</tr>
<tr>
<td class="login_td_id mobile_font_content1"><input type="text" id="mobile_login_id" name="login_id" class="mobile_font_content1"></td>
</tr>
<tr></tr>
<tr>
<td class="login_td_pw mobile_login_label mobile_font_content1" ><label for="mobile_login_pw">パスワード</label></td>
</tr>
<tr>
<td class="login_td_pw mobile_font_content1"><input type="password" id="mobile_login_pw" name="login_pw" class="mobile_font_content1"></td>
</tr>
<tr>
<td class="login_td_Submit"><button id="mobile_btn_login" class="mobile_button">ログイン</button></td>
</tr>
</table>
</div>

</body>
</html>
