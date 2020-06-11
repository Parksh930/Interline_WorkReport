<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html style="height: 100%">
<head>
<script>
	function pagechange() {
		location.href = "reportList";
	}
</script>

<meta charset="utf8" http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="../resources/js/updateReport.js"></script>
<script
	src="http://192.168.1.34:8888/oz80/ozhviewer/jquery-2.0.3.min.js"></script>
<link rel="stylesheet"
	href="http://192.168.1.34:8888/oz80/ozhviewer/jquery-ui.css"
	type="text/css" />
<script src="http://192.168.1.34:8888/oz80/ozhviewer/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="http://192.168.1.34:8888/oz80/ozhviewer/ui.dynatree.css"
	type="text/css" />
<script type="text/javascript"
	src="http://192.168.1.34:8888/oz80/ozhviewer/jquery.dynatree.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://192.168.1.34:8888/oz80/ozhviewer/OZJSViewer.js"
	charset="utf-8"></script>
<!-- <script type="text/javascript" src="http://192.168.0.103:8888/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script> -->
<script src="/report/resources/js/workingChart.js"
	type="text/javascript"></script>

<title>updateReport</title>
</head>
<body style="width: 98%; height: 98%">
	<div id="OZViewer" style="width: 98%; height: 98%"></div>
	<div id="year" style="display: none;">${vo.year}</div>
	<div id="state" style="display: none;">${vo.state}</div>
	<script>
		var holiday;
		holiday = $('#year').html();
		var array = "array=" + "${vo.reportNum}";

		var stateNum;
		stateNum = $('#state').html();

		//var holiday={"holiday":[[],[1,13],[11,23],[20],[29],[3,4,5],[],[20],[10],[21,22],[],[3,23],[]]}; 
		//var holiday={"holiday":[[],[1,13],[11,23],[20],[29],[3,4,5],[],[20],[10],[21,22],[getSecondMondayOnOCT(holiday)],[3,23],[]]};
		//getSecondMondayOnOCT(2020);
		//alternativeHoliday(holiday);

		function SetOZParamters_OZViewer() {
			var oz;
			oz = document.getElementById("OZViewer");
			oz.sendToActionScript("connection.servlet",
					"http://192.168.1.34:8888/oz80/server");
			oz.sendToActionScript("connection.reportname",
					"OSA/workReport2.ozr");
			//oz.sendToActionScript("connection.pcount","1");
			//oz.sendToActionScript("connection.args1","holiday="+JSON.stringify(holiday));
			oz.sendToActionScript("global.language", "ja");
			oz.sendToActionScript("odi.odinames", "workTest");
			oz.sendToActionScript("odi.workTest.pcount", "1");
			oz.sendToActionScript("odi.workTest.args1", array);
			return true;
		}
		start_ozjs("OZViewer", "http://192.168.1.34:8888/oz80/ozhviewer/");

		function OZUserEvent_OZViewer(param1, param2, param3) {
			if (param3 == "update") {
				//var jsonSet=makeJsonForUpdate(JSON.parse(param1));
				//$('#updateJsonReport').val(JSON.stringify(jsonSet));
				//$('#updateJsonContents').val(JSON.stringify(jsonSet[1]));
				var chartData = JSON.parse(OZViewer
						.GetInformation("INPUT_JSON_ALL"));
				console.log(chartData);
				var uConfirm = confirm("修正されますか？");
				if (uConfirm == true) {
					chartData.state = stateNum;
					adminUpdateReport(chartData, "adminUpdateReport");
				}
			}

		}
	</script>

	<!-- 	<form id="updateReport" action="updateReport">
		<input id="updateJsonReport" type="hidden" name="updateJsonReport" value="">
		<input id="updateJsonContents" type="hidden" name="updateJsonContents" value=""> 
	</form>-->
</body>
</html>

