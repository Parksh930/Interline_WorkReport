<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myreportList</title>
</head>
<script>


function formSubmit(page){
	var pp = document.getElementById('page');
	
	pp.value=page;
							
	document.location.href = "myreportList?page=" + pp.value;
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
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
}

.ReviseRequest_Btn{
border: solid 2px rgb(0, 112, 192);
border-radius: 9px;
padding: 2px 5px;
background-color: rgb(0, 112, 192);
color: white;
cursor: pointer;
}

a{
text-decoration: none;
}
</style>


<body>
<h1>過去の勤務票閲覧</h1>

<div id="report_List">
<table>

<tr>
<th class="Reportlist_Days">提出日</th>
</tr>

<c:forEach var = "work_report" items="${report_my}">
<tr>
<td class="Reportlist_Days"><fmt:formatDate pattern="yyyy.MM.dd" value="${work_report.updateDate}"/></td>
<td class="Reportlist_reportNum"><a class="Read_Btn" href="myReport?reportNum=${work_report.reportNum}">閲覧</a></td>
<td class="Reportlist_reportNum"><a class="Read_Btn" href="myReport?reportNum=${work_report.reportNum}">修正依頼</a></td>
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

</body>
</html>