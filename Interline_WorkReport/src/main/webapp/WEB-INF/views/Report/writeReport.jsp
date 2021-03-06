<%@page import="project.interline.report.util.getProperties"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% getProperties properties= new getProperties(); %>
<!DOCTYPE html>
<html style="height:100%;">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=no"/>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css"/>
<script src="http://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.css"/>
<script src="http://code.jquery.com/mobile/1.4.5/jquery.mobile-1.4.5.min.js"></script>
<link rel="stylesheet" type="text/css" href="http://dev.jtsage.com/cdn/simpledialog/latest/jquery.mobile.simpledialog.min.css"/>
<script type="text/javascript" src="http://dev.jtsage.com/cdn/simpledialog/latest/jquery.mobile.simpledialog2.min.js"></script>

<link rel="stylesheet" href="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/ui.dynatree.css" type="text/css"/>
<script type="text/javascript" src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery.dynatree.js" charset="utf-8"></script>
<script type="text/javascript" src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/OZJSViewer.js" charset="utf-8"></script>
<!-- If you want to run the HTML5SVG viewer please change the OZJSViewer.js to OZJSSVGViewer.js.
<script type="text/javascript" src="http://localhost:8080/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script>
-->
<script src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery.mouseSwipe.js" type="text/javascript"></script>
</head>
<link href="../resources/css/Font-Style.css" rel="stylesheet">
<script type="text/javascript">
	$(document).ready(function(){
		 isMobile(); 
		
		function isMobile() {
		    var filter = "win16|win32|win64|mac|macintel";
		    if( navigator.platform  ){
		      if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
	    		$("#summaryTable").addClass("mobile_body"); 
				$(".summary").addClass("mobile_font_content1"); 
				$(".button").addClass("mobile_button"); 
		      }else{
		    	$("#summaryTable").addClass("mobile_body"); 
				$(".summary").addClass("mobile_font_content1"); 
				$(".button").addClass("mobile_button");
		      }
		    }
		    $('#bt1').on('click',toggleSummary);
		    $('#summary').hide();
		  }
	});
	
//	$(document).ready(
//		function(){ $('#bt1').on('click',toggleSummary); }
//	);
//	$(document).ready(
//		function(){ $('#summary').hide(); }
//	);
</script>
<style>
	#summaryTable{
		font-family: -apple-system-subset,Helvetica,Hiragino Kaku Gothic ProN,sans-serif;
		-webkit-text-size-adjust:300%;
		border-collapse: collapse;
	}
</style>
<body style="height:100%; overscroll-behavior:none;">
<!-- model값을 불러오기위한 input -->
<input id="userNum" type="hidden" value="${userNum}">
<input id="month" type="hidden" value="${month}">
<input id="year" type="hidden" value="${year}">
<input id="userName" type="hidden" value="${sessionScope.user_inform.userName}">
<div id="reportJSON" style="display: none;">${reportJSON}</div>
<!-- /model값을 불러오기위한 input -->
<script src="../resources/js/workingChart.js" type="text/javascript"></script> <!-- 보고서 출력을위한 js -->
<script type="text/javascript">
	//페이지에 들어오기위한 필요 초기값
	session="";
	var reportYear=parseInt($('#year').val());
	var reportMonth=parseInt($('#month').val());
	var reportJSON=$('#reportJSON').html();
	var name=$('#userName').val();
	console.log("name="+name);
	if (reportJSON=="submitted"){
		alert("今月の勤務表はすでに提出しました。修正したかったら修正依頼してください。");
		location.href="userMain";
	}else if (reportJSON != "") {
		reportJSON=JSON.stringify(setCustomContents(JSON.parse(reportJSON)));
	}
	console.log(reportJSON);
	var holiday={"holiday":[[],[1,getSecondMondayOnJAN(reportYear)],[11,23],[],[29],[3,4,5],[],[getThirdMondayOnJLY(reportYear)],[11],[getThirdMondayOnSEP(reportYear)],[getSecondMondayOnOCT(reportYear)],[3,23],[]]}; 
	alternativeHoliday(reportYear);
	console.log(JSON.stringify(holiday));
</script>

<script type="text/javascript">  
	//팝업창 제어
	function toggleSummary(){
			//여기에 계산 결과
			var chartData=JSON.parse(OZViewer.GetInformation("INPUT_JSON_ALL"));
			var workingDay=countWorkingDay(chartData);
			chartData.salesDayArray.split(",");//
			$('#salesDay').html(chartData.salesDay);
			$('#workingDay').html(workingDay[0]);
			$('#holidayWorkingDay').html(workingDay[1]);
			$('#absent').html(absent(chartData));
			$('#sumWorkingTime').html(sumWorkingTime(chartData));
			
			$('#summary').slideToggle();
		}
	
	//각각의 입력내용이 바뀔때마다 적용. OZ의 killfocus속성에서 이함수를 호출한다.
	function OZUserEvent_OZViewer(param1, param2, param3) {
		console.log("trigger");
		var chartData=JSON.parse(OZViewer.GetInformation("INPUT_JSON_ALL"));
		var workingDay=countWorkingDay(chartData);
		chartData.salesDayArray.split(",");//
		$('#salesDay').html(chartData.salesDay);
		$('#workingDay').html(workingDay[0]);
		$('#holidayWorkingDay').html(workingDay[1]);
		$('#absent').html(absent(chartData));
		$('#sumWorkingTime').html(sumWorkingTime(chartData));
	}

	function saveReport(type){
		var chartData=JSON.parse(OZViewer.GetInformation("INPUT_JSON_ALL"));
		chartData.workingDay = $('#workingDay').html();
		chartData.holidayWorkingDay = $('#holidayWorkingDay').html();
		chartData.absentDay = $('#absent').html();
		chartData.sumWorkingTime = $('#sumWorkingTime').html();
		chartData.state=type;
		chartData.userNum=parseInt($('#userNum').val());
		chartData.userName=name;

		submitReport(chartData,"saveReport",type);
	}
	function redirect(){
		location.href='userMain';
	}
	
</script>	
	


<div id="OZViewer" style="width:100%;height:100%;overflow:hidden"></div>
<script type="text/javascript" >
	function SetOZParamters_OZViewer(){
		
		console.log(reportYear);
		console.log(reportMonth);

		console.log("getDates:"+getDates(reportYear,reportMonth));
		console.log("getDayDelay:"+getDayDelay(reportYear,reportMonth));
		
		var oz;
		oz = document.getElementById("OZViewer");
		oz.sendToActionScript("connection.servlet","http://<%out.print(properties.getOzIP());%>/oz80/server");
		oz.sendToActionScript("eform.dialog_autoclose_at_itemclick","true");
		oz.sendToActionScript("viewer.showpagemargin","false");
		oz.sendToActionScript("viewer.external_functions_path","http://<%out.print(properties.getWebIP());%>/<%out.print(properties.getProjectRoot());%>/resources/js/writeReportForOZR.js");
		oz.sendToActionScript("eform.dialog_autoclose_at_itemclick","true");
		oz.sendToActionScript("eform.functionbutton_display_type","alwayshide");
		oz.sendToActionScript("connection.reportname","phonetest.ozr");
		oz.sendToActionScript("connection.clientcachetype","none");
		oz.sendToActionScript("connection.inputjson", reportJSON);
		
		oz.sendToActionScript("connection.pcount","5");
		oz.sendToActionScript("connection.args1","year="+reportYear);	
		oz.sendToActionScript("connection.args2","month="+reportMonth);	
		oz.sendToActionScript("connection.args3","row="+getDates(reportYear,reportMonth));	
		oz.sendToActionScript("connection.args4","dayDelay="+getDayDelay(reportYear,reportMonth)); 
		oz.sendToActionScript("connection.args5","holiday="+JSON.stringify(holiday));
		return true;
	}
	start_ozjs("OZViewer","http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/", true);
	
	
	$('#bt1').css('bottom', '-2px');		//제어창 팝업 하단 고정
</script>

<div style="position: absolute; bottom: -2px; left: 0;">
	<img id="bt1" src="../resources/image/popupButton.PNG" style="display: block; left: 20%;">
	<div id="summary" style="text-align:left; background-color:rgb(217,217,217,0.8); border-radius: 3px; ">
		<div style="background-color:rgb(217,217,217,0.8); display: block;">
			<table id="summaryTable">
				<tr>
					<td class="summary" style="text-align: right;">営業日 : </td><td id="salesDay" class="summary"></td>
					<td rowspan="5">
						<div class="button" onclick="redirect()">取り消し</div>
						<div class="button" onclick="saveReport(0)">保存</div>
						<div class="button" onclick="saveReport(1)">提出</div>
					</td>
				</tr>
				<tr>
					<td class="summary" style="text-align: right">平日勤務 : </td><td id="workingDay" class="summary"></td>
				</tr>
				<tr>
					<td class="summary" style="text-align: right;">休日勤務 : </td><td id="holidayWorkingDay" class="summary"></td>
				</tr>
				<tr>
					<td class="summary" style="text-align: right;">欠勤 : </td><td id="absent" class="summary"></td>
				</tr>
				<tr>
					<td class="summary" style="text-align: right;">勤務時間 : </td><td id="sumWorkingTime" class="summary"></td>
				</tr>
			</table>
		</div>
	</div>	
</div>


</body>
</html>