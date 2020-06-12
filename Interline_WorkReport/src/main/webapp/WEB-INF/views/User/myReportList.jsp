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
<script>


function formSubmit(page){
	var pp = document.getElementById('page');
	
	pp.value=page;
							
	document.location.href = "myreportList?page=" + pp.value;
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
text-align:center;
}


#report_List{
	text-align: center;
	margin: auto;
}
#navigator{
text-align: center;
margin: 20px 0px 0px 0px;
}

table {
  border-collapse: collapse;
  text-align: center;
	margin: auto;
}

tr{
height: 45px;
}

th,td{
border: 1px solid black;
text-align: center;
margin: auto;
font-size: 60px;

height: 80px;
}

td.Reportlist_Days{
}
td.Reportlist_state{
}
td.Reportlist_reportNum{
border-style: none;
}
td.Reportlist_request{
border-style: none;
}


.Read_Btn{
border: solid 2px rgb(0, 112, 192);
border-radius:9px; 
padding: 5px 5px 5px 5px;
margin:2px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
text-decoration: none;

}

.state_Btn{
border: solid 2px rgb(0, 112, 192);
border-radius:9px; 
padding: 5px 5px 5px 5px;
margin:2px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
text-decoration: none;

}


.rr_Btn{
border: solid 2px rgb(0, 112, 192);
border-radius:9px; 
padding: 5px 5px 5px 5px;
margin:2px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
text-decoration: none;

}

a{
text-decoration: none;
font-size: 60px;
}
</style>

<!-- ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] -->
<!-- {'0':'aa','1':'bb'} -->
<body>
<img src="/report/resources/image/interline1.png" style="width: 50%;">

<br></br>
<div id="title" style="font-size: 90px; text-align: center;">過去の勤務票閲覧</div>
<br></br>


<div id="report_List">
<table>
	<tr>
		<td class="Reportlist_Days">提出日</td>
		<td class="Reportlist_state">状態</td>
	</tr>
	<c:set var="stateVal" value="${ ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] }"/>
	<c:forEach var = "work_report" items="${report_my}" varStatus="status">
		<tr>
			<td id="yearMonth${status.count}" class="Reportlist_Days">&nbsp;${work_report.year}-${work_report.month}&nbsp;</td>
			<td id="state${status.count}" class="Reportlist_Days">${stateVal[work_report.state]}</td>
			<td class="Reportlist_reportNum">
				<a id="readReport${status.count}" class="Read_Btn" href="myReport?reportNum=${work_report.reportNum}" target="_blank">閲覧</a>
			</td>
			<td id="request${status.count}" class="Reportlist_request" > 
				<a class="rr_Btn"  onclick="return confirmChange(${work_report.reportNum},${work_report.state})">修正依頼</a>
			</td>
		</tr>
	</c:forEach>
</table>
</div>


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
</script>
<script type="text/javascript">
	var filter = "win16|win32|win64|mac|macintel"; 
	if ( navigator.platform ) { 
		if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) { 
			//alert('mobile 접속'); 
		} else { 
			console.log("pc접속")
			$('#title').css('font-size', '60px');
			$('td').css('font-size', '20px');
			$('td').css('height', '35px');
			$('a').css('font-size', '20px');
			
		} 
	}	
</script>


</body>
</html>