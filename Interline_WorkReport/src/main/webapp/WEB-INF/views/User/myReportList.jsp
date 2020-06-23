<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myreportList</title>

</head>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<link href="../resources/css/Font-Style.css" rel="stylesheet">
<script>
$(document).ready(function(){
	 isMobile(); 
	
	function isMobile() {
	    var filter = "win16|win32|win64|mac|macintel";
	    if( navigator.platform  ){
	      if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
	    	  $("body").addClass('mobile_body');
	    	  $("#title").addClass('mobile_font_title');
	    	  $("#listTable").addClass('mobile_font_content2');
	    	  $("[id^=stateDiv]").addClass('mobile_button');
	    	  $("[id^=fakeStateDiv]").addClass('mobile_button_fake');
	      }else{
	    	  $("body").addClass('mobile_body');
	    	  $("#title").addClass('mobile_font_title');
	      }
	    }
	  }
});

function formSubmit(page){
	var pp = document.getElementById('page');
	
	pp.value=page;
							
	document.location.href = "myreportList?page=" + pp.value;
}

function loadCorrectPage(reportNum){
	parent.location.href="correctMyReport?reportNum="+reportNum;
}


function confirmChange(reportNum,originalState) {
	console.log(window.location.href);
    if (confirm("修正依頼をしますか。\n修正依頼をした後に管理部に連絡して下さい。")) {
    	$.ajax(
				{
					url: 'confirmChange',
					type: 'POST',
					data: {"reportNum":reportNum,"originalState":originalState},
					success: function(s){
							console.log('수정의뢰 완료');
							location.reload();
						},
					error: function(e){
							console.log(JSON.stringify(e));
							alert('失敗 管理者にお問い合わせてください');
						}
				}		
			);
    }
}

	

</script>

<style>
body{
	text-align: center;
}
a{
	text-decoration: none;
}
.list_table{
	border-collapse: collapse;
	text-align: center;
	margin-left: auto; 
	margin-right: auto;
}
.list_table td{
	border: 1px solid;
	border-collapse: collapse;
}
</style>

<!-- ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] -->
<!-- {'0':'aa','1':'bb'} -->

<body>

<br></br>
<div id="title">過去の勤務票閲覧</div>
<br></br>


<table id="listTable" class="list_table">
	<tr>
		<td class="Reportlist_state" width="250">提出日</td>
		<td class="Reportlist_state" width="250">状態</td>
	</tr>
	<c:set var="stateVal" value="${ ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] }"/>
	<c:forEach var = "work_report" items="${report_my}" varStatus="status">
		<tr>
			<td id="submitDate${status.count}" class="Reportlist_Days">
				<a id="readReport${status.count}" href="myReport?reportNum=${work_report.reportNum}" target="_blank">
					<fmt:parseDate value="${work_report.updateDate}" var="noticePostDate" pattern="yyyy-MM-dd HH:mm:ss"/>
					<fmt:formatDate value="${noticePostDate}" pattern="yyyy.MM.dd"/>
				</a>
			</td>
			<td id="state${status.count}" class="Reportlist_Days">${work_report.state}</td>
			<!-- <td id="state${status.count}" class="Reportlist_Days">${stateVal[work_report.state]}</td> -->
		</tr>
	</c:forEach>
</table>


<div id = "navigator">
<a href="javascript:formSubmit(${pn.currentPage - pn.pagePerGroup})">◁◁</a>&nbsp;
<a href="javascript:formSubmit(${pn.currentPage-1})">◀</a> &nbsp;&nbsp;

<c:forEach var="counter" begin="${pn.startPageGroup}" end="${pn.endPageGroup}">
<c:if test="${counter == pn.currentPage}"><b></c:if>
<a href="javascript:formSubmit(${counter})">${counter}</a>&nbsp;
<c:if test="${counter == pn.currentPage}"></b></c:if>
</c:forEach>
&nbsp;&nbsp;
<a href="javascript:formSubmit(${pn.currentPage + 1})">▶</a> &nbsp;&nbsp;
<a href="javascript:formSubmit(	${pn.currentPage + pn.pagePerGroup})">▷▷</a>
</div>

<script>
	for(var i=1 ; i<=10 ; i++){
		var reportNum=$('#readReport'+i).attr('href').split("=")[1];
		var stateHtml=$('#state'+i).html();
		//var stateArray=['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'];
		switch (stateHtml){
		case "0":
			$('#state'+i).html("<div id='stateDiv"+i+"' width='250px'  onclick='loadCorrectPage("+reportNum+")'>保存</div>");
			break;
		case "1":
			$('#state'+i).html("<div id='fakeStateDiv"+i+"' width='250px' onclick='confirmChange("+reportNum+","+stateHtml+")'>提出</div>");
			break;
		case "2":
			$('#state'+i).html("<div id='fakeStateDiv"+i+"' width='250px' onclick='confirmChange("+reportNum+","+stateHtml+")'>提出</div>");
			break;
		case "3":
			$('#state'+i).html("<div id='fakeStateDiv"+i+"' width='250px'>修正依頼</div>");
			break;
		case "4":
			$('#state'+i).html("<div id='fakeStateDiv"+i+"' width='250px'>修正依頼</div>");
			break;
		case "5":
			$('#state'+i).html("<div id='stateDiv"+i+"' width='250px'  onclick='loadCorrectPage("+reportNum+")'>修正許可</div>");
			break;
		case "6":
			$('#state'+i).html("<div id='stateDiv"+i+"' width='250px'  onclick='loadCorrectPage("+reportNum+")'>修正許可</div>");
			break;
		default:
			console.log("default");
			break;
		}
	}

/*
	for(var i=1 ; i<=10; i++){
		var reportNum="0";
		var stateHtml=$('#state'+i).html();
		if(stateHtml=="修正許可"){
			reportNum=$('#readReport'+i).attr('href').split("=")[1];
			$('#state'+i).html("<a class='state_Btn' href='correctMyReport?reportNum="+reportNum+"' target='_parent'>修正許可</a>");
			$('#request'+i).html("");
		}
		if(stateHtml=="保存"|| stateHtml=="修正依頼"){
			$('#request'+i).html("");
		}
	}
	*/
</script>
<script type="text/javascript">
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			//alert('mobile 접속'); 
		} else { 
		//	console.log("pc접속")
		//	$('#title').css('font-size', '60px');
		//	$('td').css('font-size', '20px');
		//	$('td').css('height', '35px');
		//	$('a').css('font-size', '20px');
		//	$('.Reportlist_Days').width("90");
		//	$('.Reportlist_state').width("90");
		} 
	}	
</script>


</body>
</html>