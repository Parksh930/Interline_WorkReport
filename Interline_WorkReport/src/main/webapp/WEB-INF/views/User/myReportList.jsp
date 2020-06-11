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




function confirmChange() {
    if (confirm("修正依頼をしますか。\n修正依頼をした後に管理部に連絡して下さい。") == true) {
    
        return true;
    } else {
        return false;
    }
}

	

</script>

<style>
body{
text-align:center;
}

#report_List{
margin: 50px auto;
width: fit-content;
}

#navigator{
text-align: center;
margin: 20px 0px 0px 0px;
}

table {
  border-collapse: collapse;
}

tr{
height: 45px;
}

th,td{
border: 1px solid black;
}


.Reportlist_Days{
width: 150px;
}

.Reportlist_reportNum{
border-style: none;
width:50px;
}

.Read_Btn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 5px 5px 5px 5px;
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
width: 150%;
height: 30%;
display:block;
}

a{
text-decoration: none;
}
</style>

<!-- ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] -->
<!-- {'0':'aa','1':'bb'} -->
<body>
<script>
	console.log("ttttt");
</script>

<h1>過去の勤務票閲覧</h1>

<div id="report_List">
<table>
	<tr>
	<td class="Reportlist_Days">提出日</td>
	<td class="Reportlist_Days">状態</td>
	</tr>
	<c:set var="stateVal" value="${ ['保存','提出','承認','修正依頼','修正依頼','修正許可','修正許可'] }"/>
	<c:forEach var = "work_report" items="${report_my}" varStatus="status">
	<tr>
	<td id="yearMonth${status.count}" class="Reportlist_Days">${work_report.year}年${work_report.month}</td>
	<td id="state${status.count}" class="Reportlist_Days">${stateVal[work_report.state]}</td>
	<td class="Reportlist_reportNum">
		<a id="readReport${status.count}" class="Read_Btn" href="myReport?reportNum=${work_report.reportNum}" target="_blank">閲覧</a>
	</td>
	<td class="Reportlist_reportNum" > <a class="rr_Btn"  onclick="return confirmChange()">修正依頼</a>
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
		if($('#state'+i).html()=="修正許可"){
			reportNum=$('#readReport'+i).attr('href').split("=")[1];
			$('#state'+i).html("<a class='Read_Btn' href='correctMyReport?reportNum="+reportNum+"' target='_blank'>修正許可</a>")
		}
	}
</script>

</body>
</html>