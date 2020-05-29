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

<meta charset="utf8" http-equiv="X-UA-Compatible" content="IE=edge"/>
<script src="http://192.168.1.34:8888/oz80/ozhviewer/jquery-2.0.3.min.js"></script>
<link rel="stylesheet" href="http://192.168.1.34:8888/oz80/ozhviewer/jquery-ui.css" type="text/css"/>
<script src="http://192.168.1.34:8888/oz80/ozhviewer/jquery-ui.min.js"></script>
<link rel="stylesheet" href="http://192.168.1.34:8888/oz80/ozhviewer/ui.dynatree.css" type="text/css"/>
<script type="text/javascript" src="http://192.168.1.34:8888/oz80/ozhviewer/jquery.dynatree.js" charset="utf-8"></script>
<script type="text/javascript" src="http://192.168.1.34:8888/oz80/ozhviewer/OZJSViewer.js" charset="utf-8"></script>
<!-- <script type="text/javascript" src="http://192.168.0.103:8888/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script> -->


<title>ReadReport</title>
</head>
<body style="width: 98%; height: 98%">
	<div id="OZViewer" style="width: 98%; height: 98%"></div>
	<script> 

	var array = "array="+"${vo.reprotNum}";
	var dayOfTheWeekValue ="";
	var dayOfTheWeek = "dayOfTheWeek="+dayOfTheWeekValue;

		$(function() {
		var year = ${vo.Year};
		var month = ${vo.month};
		var day = "01";
		var fullDate = "'"+year+"-"+month+"-"+day+"'"; 	
		var weekDay = new Date(fullDate);
		dayOfTheWeekValue = weekDay;

		alert(weekDay);

			});

		function SetOZParamters_OZViewer() {
			var oz;
			oz = document.getElementById("OZViewer");
			oz.sendToActionScript("connection.servlet",
					"http://192.168.1.34:8888/oz80/server");
			oz.sendToActionScript("connection.reportname",
					"OSA/workReport.ozr");
			oz.sendToActionScript("global.language", "ja");
			oz.sendToActionScript("odi.odinames", "workTest");
			oz.sendToActionScript("odi.interlineTest.pcount", "2");
			oz.sendToActionScript("odi.interlineTest.args1", array);
			oz.sendToActionScript("odi.interlineTest.args2", dayOfTheWeek);
			return true;
		}
		start_ozjs("OZViewer", "http://192.168.1.34:8888/oz80/ozhviewer/");
	</script>


</body>
</html>

