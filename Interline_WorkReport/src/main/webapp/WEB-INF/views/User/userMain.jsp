<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script src='../resources/js/jquery-2.0.3.min.js'></script>
	<script src='../resources/js/jquery-ui.min.js'></script>
	<style>
	#menuBar {
	    display:none;
	    width: 60%;
	    height:100%;
	    text-align: center;
	    background-color: rgb(255,255,255);
	}
	div[class*="_Btn"]{
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
	a[class*="_Btn"]{
		cursor: pointer;
		text-decoration: none;
		width: 80%;
		display: table-cell;
		vertical-align: middle;
		font-weight: bold;
	}
	#list_Box{
		width: 100%;
		height: 100%;
		z-index: 1;
	}
	a:link { color: #FFFFFF; }
	a:visited { color: #FFFFFF; }
	</style>

</head>
	<script type="text/javascript">
	$(document).ready(
		function(){ $('#button1').on('click',toggleMenu); }
	);
	$(document).ready(
			function(){ $('#cover').on('click',uncover); }
		);
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
	function writeReport(){
		let today = new Date();   
		let year = today.getFullYear(); // 년도
		let month = today.getMonth() + 1;  // 월		
		$('#year').val(year);
		$('#month').val(month);
		document.getElementById("form1").submit();
	}	
	
	</script>
<body>


<div id="bodyDiv" style="width:100%;height:100%;overflow:hidden;">
	<img id="button1" src="/report/resources/image/menuButton.png" style="position: absolute;left: 0;top: 0; z-index: 1000;">
	<div id="menuBar" style="width: 70%; z-index: 1000; position: absolute; top:0; left:0; z-index: 1000;">
		<img src="/report/resources/image/interline.jpg" style="width: 100%;">
		<table style="width: 100%; border-bottom: thin; border-bottom-style: solid; border-bottom-color: rgb(200,200,200);">
			<tr>
				<td colspan="2" style="font-size: 5px;"><br></br></td>
			</tr>
			<tr>
				<td id="name" style="font-size: 40px;">
					${sessionScope.user_inform.userName}さん
				</td>
				<td>
					<div class="logout"><a class="menu_Btn" href="로드할 페이지 주소를 넣어줘요." target="list_Box">ログアウト</a></div>
				</td>
			</tr>
			<tr>
				<td colspan="2" style="font-size: 10px;"><br></br></td>
			</tr>
		</table>
		<br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="javascript:void(0);" onclick="writeReport()" target="list_Box">今月の勤務表作成</a></div><br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="../user/myReportList" onclick="uncover()" target="list_Box">過去の勤務表閲覧</a></div><br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="../user/profile" onclick="uncover()" target="list_Box">パスワード変更</a></div>
	</div>
	
	<div id="_iframe" style="position:absolute; top:0; left:0; text-align: left; z-index: 1; background-color: rgb(255,255,255); width: 100%; height: 100%;">
		<iframe name="list_Box" id="list_Box" src="../user/profile" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0 ></iframe>
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
			console.log("pc접속")
			$('#bodyDiv').css('width', '40%');
			$('#_iframe').css('width', '40%');
			$('#menuBar').css('width', '30%');
			$('.menu_Btn').css('font-size', '20px');
			$('.logout').css('font-size', '20px');
			$('#name').css('font-size', '20px');
			$('#button1').css('width', '7%')
		} 
	}
	
</script>	
</body>
	
</html>