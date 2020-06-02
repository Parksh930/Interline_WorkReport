<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

<link rel="stylesheet" href="http://192.168.1.124:8888/oz80/ozhviewer/ui.dynatree.css" type="text/css"/>
<script type="text/javascript" src="http://192.168.1.124:8888/oz80/ozhviewer/jquery.dynatree.js" charset="utf-8"></script>
<script type="text/javascript" src="http://192.168.1.124:8888/oz80/ozhviewer/OZJSViewer.js" charset="utf-8"></script>
<!-- If you want to run the HTML5SVG viewer please change the OZJSViewer.js to OZJSSVGViewer.js.
<script type="text/javascript" src="http://192.168.1.124:8080/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script>
-->
<script src="http://192.168.1.124:8888/oz80/ozhviewer/jquery.mouseSwipe.js" type="text/javascript"></script>

<script type="text/javascript">
	$(document).ready(
		function(){ $('#bt1').on('click',toggleSummary); }
	);
	$(document).ready(
		function(){ $('#summary').hide(); }
	);
</script>

</head>
<body style="height:100%; overscroll-behavior:none;">
<!-- model값을 불러오기위한 input -->
<input id="userNum" type="hidden" value="${userNum}">
<input id="month" type="hidden" value="${month}">
<input id="year" type="hidden" value="${year}">
<div id="reportJSON" style="display: none;">${reportJSON}</div>
<!-- /model값을 불러오기위한 input -->
<script src="/report/resources/js/workingChart.js" type="text/javascript"></script> <!-- 보고서 출력을위한 js -->
<script type="text/javascript">
	//페이지에 들어오기위한 필요 초기값
	session="";
	var reportYear=parseInt($('#year').val());
	var reportMonth=parseInt($('#month').val());
	var reportJSON=$('#reportJSON').html();
	if (reportJSON=="submitted"){
		alert("今月の勤務表はすでに提出しました。修正したかったら修正要請してください。");
		//location.href="../";
	}
	console.log(reportJSON);
	var holiday={"holiday":[[],[1,13],[11,23],[20],[29],[3,4,5],[],[20],[10],[21,22],[getSecondMondayOnOCT(reportYear)],[3,23],[]]}; 
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
		chartData.userName="aaa";

		submitReport(chartData,"saveReport",type);
	}
	
</script>	
	


<div id="OZViewer" style="width:100%;height:100%;overflow:hidden"></div>
<script type="text/javascript" >
	function SetOZParamters_OZViewer(){
		
		console.log(reportYear);
		console.log(reportMonth);
		
		var oz;
		oz = document.getElementById("OZViewer");
		oz.sendToActionScript("connection.servlet","http://192.168.1.124:8888/oz80/server");
		oz.sendToActionScript("viewer.showpagemargin","false");
		oz.sendToActionScript("eform.functionbutton_display_type","alwayshide");
		oz.sendToActionScript("connection.reportname","phonetest.ozr");
		oz.sendToActionScript("connection.clientcachetype","none");
		oz.sendToActionScript("connection.inputjson", reportJSON);
		
		oz.sendToActionScript("connection.pcount","5");
		oz.sendToActionScript("connection.args1","year="+reportYear);	
		oz.sendToActionScript("connection.args2","month="+reportMonth);	
		oz.sendToActionScript("connection.args3","row="+getDates(reportYear,reportMonth));	
		oz.sendToActionScript("connection.args4","daDelay="+getDayDelay(reportYear,reportMonth)); 
		oz.sendToActionScript("connection.args5","holiday="+JSON.stringify(holiday));
		return true;
	}
	start_ozjs("OZViewer","http://192.168.1.124:8888/oz80/ozhviewer/", true);
	
	
	$('#bt1').css('bottom', '0');		//제어창 팝업 하단 고정
	
	//모바일 피씨 접속 구분후 피씨면 뷰어창 넓이 줄이기
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			//alert('mobile 접속'); 
		} else { 
			$('#OZViewer').css('width', '30%');
		} 
	}
</script>

<div style="text-align:left; position:absolute; bottom:-2px;">
	<div><img id="bt1" src="/report/resources/image/popupButton.PNG" style="display: block;"></div>
	<div id="summary" style="text-align:left; background-color:rgb(217,217,217,0.8); border-radius: 3px;">
		<div style="background-color:rgb(217,217,217,0.8); display: block;">
			<table>
				<tr>
					<td style="text-align: right; font-size: 15px;">営業日 : </td><td id="salesDay" style=" font-size: 15px;"></td>
					<td rowspan="5">
						<input type="button" value="取り消し" onclick="location.href='../'">
						<input type="button" value="保存" onclick="saveReport(0)">
						<input type="button" value="提出" onclick="saveReport(1)">
					</td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 15px;">平日勤務 : </td><td id="workingDay" style=" font-size: 15px;"></td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 15px;">休日勤務 : </td><td id="holidayWorkingDay" style=" font-size: 15px;"></td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 15px;">欠勤 : </td><td id="absent" style=" font-size: 15px;"></td>
				</tr>
				<tr>
					<td style="text-align: right; font-size: 15px;">勤務時間 : </td><td id="sumWorkingTime" style=" font-size: 15px;"></td>
				</tr>
			</table>
		</div>
	</div>	
</div>


</body>
</html>