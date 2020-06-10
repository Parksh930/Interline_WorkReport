<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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


<title>Insert title here</title>
</head>
<body style="height:100%; overscroll-behavior:none;">
<div id="reportJSON" style="display: none;">${reportJSON}</div>

<script src="/report/resources/js/workingChart.js" type="text/javascript"></script> <!-- 보고서 출력을위한 js -->
<script type="text/javascript">
	//페이지에 들어오기위한 필요 초기값
	session="";
	var reportJSON=$('#reportJSON').html();
	if (reportJSON=="none"){
		alert("該当の月の報告書がありません。管理者にお問い合わせてください。");
		location.href="userMain";
	}
	var report=JSON.parse(reportJSON);
	var reportYear=report.year;
	var reportMonth=report.month;
	var name=report.userName;
	console.log("name="+name);
	console.log(reportJSON);
	var holiday={"holiday":[[],[1,13],[11,23],[20],[29],[3,4,5],[],[20],[10],[21,22],[getSecondMondayOnOCT(reportYear)],[3,23],[]]}; 
	alternativeHoliday(reportYear);
	console.log(JSON.stringify(holiday));
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
		oz.sendToActionScript("connection.reportname","readMyReport.ozr");
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
		
</script>



</body>
</html>