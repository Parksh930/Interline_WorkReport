<%@page import="project.interline.report.util.getProperties"%>
<%@page import="java.util.Properties"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% getProperties properties= new getProperties(); %>
<!DOCTYPE html>
<html style="height: 100%">
<head>
<script>
	function pagechange() {
		location.href = "reportList";
	}
</script>

<meta charset="utf8" http-equiv="X-UA-Compatible" content="IE=edge"/>
<script src="../resources/js/updateReport.js"></script>
<script src="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/jquery-2.0.3.min.js"></script>
<link rel="stylesheet" href="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/jquery-ui.css" type="text/css"/>
<script src="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/ui.dynatree.css" type="text/css"/>
<script type="text/javascript" src="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/jquery.dynatree.js" charset="utf-8"></script>
<script type="text/javascript" src="http://<%out.print(properties.getIP());%>/oz80/ozhviewer/OZJSViewer.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="http://192.168.0.103:8888/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script> -->
<script src="../resources/js/workingChart.js" type="text/javascript"></script> 

<title>AllReadReport</title>
</head>
<body style="width: 98%; height: 98%">
	<div id="OZViewer" style="width: 98%; height: 98%"></div>
	<script> 
		var holiday;
		holiday = $('#year').html();
		//var holiday={"holiday":[[],[1,13],[11,23],[20],[29],[3,4,5],[],[20],[10],[21,22],[getSecondMondayOnOCT(holiday)],[3,23],[]]}; 
		//getSecondMondayOnOCT(2020);
		//alternativeHoliday(holiday);
		
		function SetOZParamters_OZViewer() {
			var oz;
			oz = document.getElementById("OZViewer");
			oz.sendToActionScript("connection.servlet",
					"http://<%out.print(properties.getIP());%>/oz80/server");
			oz.sendToActionScript("connection.reportname",
					"OSA/workReportOption.ozr");
			oz.sendToActionScript("connection.pcount","1");
			oz.sendToActionScript("connection.args1","holiday="+JSON.stringify(holiday));
			oz.sendToActionScript("global.language", "ja");
			oz.sendToActionScript("odi.odinames", "workTest");
			//oz.sendToActionScript("odi.workTest.pcount", "1");
			//oz.sendToActionScript("odi.workTest.args1", array);
			return true;
		}
		start_ozjs("OZViewer", "http://<%out.print(properties.getIP());%>/oz80/ozhviewer/");


		function OZUserEvent_OZViewer(param1, param2, param3) {

			var data = JSON.parse(OZViewer
					.GetInformation("INPUT_JSON_CURRENT_PAGE"));
			console.log(data);

			if (param3 == "Approval") {
				if (data.state == 1) {
					//	var data = JSON.parse(OZViewer.GetInformation("INPUT_JSON_ALL"));
					var sConfirm = confirm("提出された勤務表を承認されますか？");
					if (sConfirm == true) {
						changeAllStateUp(data.reportNum, data.state);
					}
				}

				else if (data.state == 3) {
					var sConfirm = confirm("勤務表の修正許可要請を承認されますか？");
					if (sConfirm == true) {
						changeAllStateUp(data.reportNum, data.state);
					}
				} else if (data.state == 4) {
					var sConfirm = confirm("勤務表の修正許可要請を承認されますか？");
					if (sConfirm == true) {
						changeAllStateUp(data.reportNum, data.state);
					}
				}

			} else if (param3 == "Cancel") {
				if (data.state == 1) {
					var sConfirm = confirm("提出された勤務表を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}
				} else if (data.state == 2) {
					var sConfirm = confirm("すでに承認された勤務表を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}
				} else if (data.state == 3) {
					var sConfirm = confirm("勤務表の修正許可要請を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}
				} else if (data.state == 4) {
					var sConfirm = confirm("勤務表の修正許可要請を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}
				} else if (data.state == 5) {
					var sConfirm = confirm("すでに修正許可された勤務表の修正許可を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}

				} else if (data.state == 6) {
					var sConfirm = confirm("すでに修正許可された勤務表の修正許可を取消されますか？");
					if (sConfirm == true) {
						changeAllStateDown(data.reportNum, data.state);
					}
				}

			}

		}
	</script>


</body>
</html>

