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
		width: 70%;
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
	//$('#OZViewer').css('width', '30%');
	
	
	</script>
<body>


<div id="bodyDiv" style="width:100%;height:100%;overflow:hidden;">
	<img id="button1" src="/report/resources/image/menuButton.png" style="position: absolute;left: 0;top: 0; z-index: 1000;">
	<div id="menuBar" style="width: 70%; z-index: 1000; position: absolute; top:0; left:0; z-index: 1000;">
		<img src="/report/resources/image/interline.jpg" style="width: 100%;">
		<table>
			<tr>
				<td>
					${sessionScope.user_inform.userName}さん
				</td>
				<td>
					<div class="menu_Btn"><a class="menu_Btn" href="로드할 페이지 주소를 넣어줘요." target="list_Box">ログアウト</a></div>
				</td>
			</tr>
		</table>
		<br></br><br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="로드할 페이지 주소를 넣어줘요." target="list_Box">今月の勤務表作成</a></div><br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="로드할 페이지 주소를 넣어줘요." target="list_Box">過去の勤務表閲覧</a></div><br></br>
		<div class="menu_Btn"><a class="menu_Btn" href="로드할 페이지 주소를 넣어줘요.">パスワード変更</a></div>
	</div>
	
	<div id="_iframe" style="position:absolute; top:0; left:0; text-align: left; z-index: 1; background-color: rgb(255,255,255); width: 100%; height: 100%;">
		<iframe name="list_Box" id="list_Box" src="../user/myReportList" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=yes vspace=0 ></iframe>
	</div>
	
	<div id="cover" class="cover" style="z-index: -1; width: 100%; height: 100%; background-color: rgb(255,255,255); position: absolute; top:0; left:0;"></div>
</div>
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
		} 
	}
</script>	
</body>
	
</html>