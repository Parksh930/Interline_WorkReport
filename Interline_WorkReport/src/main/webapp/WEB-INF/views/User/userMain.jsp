<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script src="<c:url value = '../resources/js/jquery-ui.min.js'/>"></script>
	<link href="../resources/css/Font-Style.css" rel="stylesheet">
	<script type="text/javascript">
	$(document).ready(function(){
		 isMobile(); 
		function isMobile() {
		    var filter = "win16|win32|win64|mac|macintel";
		    if( navigator.platform  ){
		      if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
			      console.log("asdasd");
			      $("body").addClass('mobile_body');
		    	  $("#button1").addClass('mobile_img_size');
		    	  $("#menu_Btn1").addClass('mobile_button');
		    	  $("#menu_Btn2").addClass('mobile_button');
		    	  $("#menu_Btn3").addClass('mobile_button');
		    	  $("#menu_Btn4").addClass('mobile_button');
		      }else{
		    	  $("body").addClass('mobile_body');
		    	  $("#title").addClass('mobile_font_title');
		      }
		    }
		  }
		
	});
	$(document).ready(function(){
		$('#button1').on('click',toggleMenu);
		$('#cover').on('click',uncover);
		});
	function toggleMenu(){	
	    $('#menuBar').show("slide", "right", 500);	
	    $('#button1').css("display","none");
	    $('#cover').css("z-index","999");
	    $('#cover').css("background-color","rgb(225,225,225,0.5)");
	    //console.log($('#menuBar').css('display'));
	}
	function uncover(){
		$('#cover').css("z-index","-1");
	    $('#menuBar').hide("slide", "right", 500);	
		$('#button1').css("display","block");
	}
	function moveTo(url){
		uncover();
		document.getElementById("list_Box").src = url;
	}
	function writeReport(){
		var today1 = new Date();   
		var year = today1.getFullYear(); // 년도
		var month = today1.getMonth() + 1;  // 월		
		$('#year').val(year);
		$('#month').val(month);
		document.getElementById("form1").submit();
	}	
	</script>
	<style>
	#menuBar {
	    display:none;
	    width: 50%;
	    height:100%;
	    text-align: center;
	    background-color: rgb(255,255,255);
	}
	.logout{
		border: solid 2px rgb(0, 112, 192);
		border-radius: 9px;
		padding: 2px 5px;
		background-color: rgb(0, 112, 192);
		color: white;
		width: 80%;
		height: 5%;
		margin:0 auto;
		font-size: 40px;
		text-align: center;
		overflow:hidden;
		display: table;
	}
	#list_Box{
		width: 100%;
		height: 100%;
		z-index: 1;
	}
	a:link { color: #FFFFFF; }
	a:visited { color: #FFFFFF; }
	</style>
<body>


<div id="bodyDiv" style="width:100%;height:100%;overflow:hidden;">
	<img id="button1" src="../resources/image/menuButton.png" style="position: absolute;left: 0;top: 0; z-index: 1000;">
	<div id="menuBar" style="z-index: 1000; position: absolute; top:0; left:0;">
		<img src="../resources/image/interline.jpg" style="width: 100%;">
		<table style="width: 100%; border-bottom: thin; border-bottom-style: solid; border-bottom-color: rgb(200,200,200);">
			<tr>
				<td colspan="2" style="font-size: 5px;"><br></br></td>
			</tr>
			<tr>
				<td id="name" style="font-size: 40px;">
					${sessionScope.user_inform.userName}さん
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-size: 10px;"><br></br></td>
			</tr>
		</table>
		<div id="menu_Btn1" class="menu_Btn" onclick="writeReport()" >今月の勤務表作成</div>
		<div id="menu_Btn2" class="menu_Btn" onclick="moveTo('../user/myReportList')">過去の勤務表閲覧</div>
		<div id="menu_Btn3" class="menu_Btn" onclick="moveTo('../user/profile')">パスワード変更</div>
		<div id="menu_Btn4" class="menu_Btn" onclick="moveTo('../logout')">ログアウト</div>
	</div>
	
	<div id="_iframe" style="position:absolute; top:0; left:0; text-align: left; z-index: 1; background-color: rgb(255,255,255); width: 100%; height: 100%;">
		<iframe name="list_Box" id="list_Box" src="../user/myReportList" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=yes vspace=0 ></iframe>
	</div>
	
	<div id="cover" class="cover" style="z-index: -1; width: 100%; height: 100%; background-color: rgb(255,255,255); position: absolute; top:0; left:0;"></div>
</div>
<form id="form1" action="../user/writeReport" method="post">
	<input id="userNum" type="hidden" name="userNum" value="${sessionScope.user_inform.userNum}">
	<input id="month" type="hidden" name="month" value="">
	<input id="year" type="hidden" name="year" value="">
</form>
<script type="text/javascript">
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			//alert('mobile 접속'); 
		} else { 
			//console.log("pc접속")
			//$('#bodyDiv').css('width', '40%');
			//$('#_iframe').css('width', '40%');
			//$('#menuBar').css('width', '30%');
			//$('.menu_Btn').css('font-size', '20px');
			//$('.logout').css('font-size', '20px');
			//$('#name').css('font-size', '20px');
			//$('#button1').css('height', 'auto');
			//$('#button1').css('max-width', '3%');
		} 
	}
	
</script>	
</body>
	
</html>