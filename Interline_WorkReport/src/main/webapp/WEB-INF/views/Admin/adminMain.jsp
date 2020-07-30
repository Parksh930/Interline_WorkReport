<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Page</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<script>
$(function(){
	isMobile(); 
		
	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";
		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
		    }else{
		    	$("body").attr('class','pc_body');
		    	$("a").addClass('pc_font_button1');
		    }
		}
	}
	
	$('#list_Box').css('min-height',window.innerHeight-100+'px');
	$('#list_Box').attr("src","../admin/reportList");
	
	$('#list_Box').load(function(){
		var box_pathname = $(this)[0].contentWindow.location.pathname;
		
		if(box_pathname.indexOf("login") > -1){
			location.href = "../login";
		}
		
		if($(this).contents().find('#OZViewer').html()==null){
         	$(this).css('height',($(this).contents().find('body')[0].scrollHeight)+50+'px');
		}else{
			$(this).css('height',window.innerHeight-40+'px');
		}
		
		if(box_pathname.indexOf("statistics") > -1){
			$('#list_Box').css('width','1300px');
		}else{
			$('#list_Box').css('width','1100px');
		}
	});
});
</script>	

<style>

#_iframe{
margin:20px 0px 0px 0px;
}



</style>
</head>
<body>

<div id="menuBar" style="position: absolute; left: 0px; z-index: 1000; text-align: center; width:20%;">
<img id="" src="../resources/image/interline2.png" width="70%" height="70%"><h1>管理者</h1><br></br>
<p><button class="menuPc_font_button1" type="button" onclick="list_Box.location.href='reportList'">勤務票リスト</button></p>
<p><button class="menuPc_font_button1" type="button" onclick="list_Box.location.href='userList'">社員リスト</button></p>
<p><button class="menuPc_font_button1" type="button" onclick="location.href='../logout'">ログアウト</button></p>
<p><button class="menuPc_font_button1" type="button" onclick="list_Box.location.href='kimDaeun'">김대은집계</button></p>
<p><button class="menuPc_font_button1" type="button" onclick="list_Box.location.href='getCount'">ohsaeam</button></p>		
<p><button class="menuPc_font_button1" type="button" onclick="list_Box.location.href='statistics'">1年間の集計</button></p>		
</div>
<div id="_iframe" style="position:absolute; left:20%;  text-align: left;">
<iframe name="list_Box" id="list_Box" src="" frameborder=0 framespacing=0 marginheight=0 marginwidth=0 scrolling=no vspace=0></iframe>
</div>
</body>
</html>