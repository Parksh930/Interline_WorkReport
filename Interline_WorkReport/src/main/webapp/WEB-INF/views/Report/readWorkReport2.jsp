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
		window.history.back();
	}
</script>

<meta charset="utf8" http-equiv="X-UA-Compatible" content="IE=edge" />
<script src="../resources/js/updateReport.js"></script>
<script
	src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery-2.0.3.min.js"></script>
<link rel="stylesheet"
	href="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery-ui.css"
	type="text/css" />
<script src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery-ui.min.js"></script>
<link rel="stylesheet"
	href="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/ui.dynatree.css"
	type="text/css" />
<script type="text/javascript"
	src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/jquery.dynatree.js"
	charset="utf-8"></script>
<script type="text/javascript"
	src="http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/OZJSViewer.js"
	charset="utf-8"></script>
<!-- <script type="text/javascript" src="http://192.168.0.103:8888/ozrviewer/OZJSSVGViewer.js" charset="utf-8"></script> -->
<script src="../resources/js/workingChart.js"
	type="text/javascript"></script>

<title>SelectReadReport</title>
</head>
<body style="width: 98%; height: 98%">
	<div id="OZViewer" style="width: 98%; height: 98%"></div>
	<div id="array" style="display: none;">${arrNumber}</div>
	<script>

		var arrayValue;
		arrayValue = $('#array').html();
		var array = "array=" + arrayValue;


		function SetOZParamters_OZViewer() {
			//console.log(array);
			var oz;
			oz = document.getElementById("OZViewer");
			oz.sendToActionScript("connection.servlet",
					"http://<%out.print(properties.getOzIP());%>/oz80/server");
			oz.sendToActionScript("connection.reportname",
					"OSA/workReportOption.ozr");
			oz.sendToActionScript("global.language", "ja");
			oz.sendToActionScript("odi.odinames", "workTest");
			oz.sendToActionScript("odi.workTest.pcount", "1");
			oz.sendToActionScript("odi.workTest.args1", array);
			return true;
		}
		start_ozjs("OZViewer", "http://<%out.print(properties.getOzIP());%>/oz80/ozhviewer/");


		
	</script>


</body>
</html>

