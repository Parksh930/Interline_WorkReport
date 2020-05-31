<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ReportList</title>
</head>
<style>
body {
	text-align: center;
}

#report_List {
	margin: 50px auto;
	width: fit-content;
}

#navigator {
	text-align: center;
	margin: 20px 0px 0px 0px;
}

table {
	border-collapse: collapse;
}

tr {
	height: 45px;
}

th, td {
	border: 1px solid black;
}

.Reportlist_userNum, .Reportlist_userMail, .Reportlist_userName,
	.Reportlist_team {
	width: 100px;
}

.Reportlist_reportDays, .Reportlist_updateDate {
	width: 150px;
}

.Reportlist_reportBtn {
	border-style: none;
	width: 50px;
}

.Read_Btn {
	border: solid 2px rgb(0, 112, 192);
	border-radius: 9px;
	padding: 2px 5px;
	background-color: rgb(0, 112, 192);
	color: white;
	cursor: pointer;
}

a {
	text-decoration: none;
}

.Main_logOut {
	margin: 0px 0px 0px 20px;
}
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>






  function getReadReport(reportNum) {
     location.href = "../admin/getReadReport?reportNum="+reportNum;
      };
  function getUpdateReport(reportNum) {
   	  location.href = "../admin/getUpdateReport?reportNum="+reportNum;
      };
  function DeleteReport(reportNum) {
      if(confirm("削除されますか？")){
    	  location.href = "../admin/deleteReport?reportNum="+reportNum;
      }
	　};
  function getAllReport() { 
	location.href = "../admin/getAllReport";
	};
				
	

  function selectRead(){
  
    //var arrNumber = new Array();

    var arrNumber = [];
    var chk_obj = document.getElementsByName("selectValue");
  	var chk_leng = chk_obj.length;

	if(!$(".check").is(':checked')){
		alert("閲覧する勤務表を選択してください。");
		return false;
		}

  	for(i=0;i<chk_leng;i++){
  		if(chk_obj[i].checked==true){
  			arrNumber.push(chk_obj[i].value);
  		}
  	}
  			alert(arrNumber);
  		location.href = "../admin/getReadReport2?arrNumber="+arrNumber;
  
  };

/*   $(function(){
	$("#allCheck").click(function(){
		if($("#allCheck").is(":checked")){ 
			$(".check").attr("checked","checked")  
			}
		else{
			$(".check").removeAttr("checked")
			}
	});

  }); */

  function Acheck(){
      if($("#allCheck").is(':checked')){
        $("input[name=selectValue]").prop("checked", true);
      }else{
        $("input[name=selectValue]").prop("checked", false);
      }
	}


</script>

<body>
	<h1>報告書リスト</h1>
	<div id="report_List">
		<table>
			<tr>
				<th class="Reportlist_checkBox"><input type="checkbox"
					id="allCheck" onclick="Acheck()"></th>
				<th class="Reportlist_userNum">社員番号</th>
				<th class="Reportlist_userMail">社員メール</th>
				<th class="Reportlist_userName">社員名</th>
				<th class="Reportlist_team">チーム名</th>
				<th class="Reportlist_reportDays">年月分</th>
				<th class="Reportlist_updateDate">最終保存日時</th>
			</tr>
			<c:forEach var="report_List" items="${report_all}">


				<tr>
					<td><input type="checkbox" name="selectValue" class="check"
						value="${report_List.reportNum}"></td>
					<td class="Reportlist_userNum">${report_List.userNum}</td>
					<td class="Reportlist_userMail">${report_List.userMail}</td>
					<td class="Reportlist_userName">${report_List.userName}</td>
					<td class="Reportlist_team">${report_List.team}</td>
					<td class="Reportlist_reportDays">${report_List.year}年${report_List.month}月</td>
					<td class="Reportlist_updateDate">${report_List.updateDate}</td>
					<td class="Reportlist_reportBtn"><button class="Read_Btn"
							onclick="getReadReport(${report_List.reportNum})">閲覧</button>
					<td class="Reportlist_reportBtn"><button class="Read_Btn"
							onclick="getUpdateReport(${report_List.reportNum})">修正</button>
					<td class="Reportlist_reportBtn"><button class="Read_Btn"
							onclick="DeleteReport(${report_List.reportNum})">削除</button>
				</tr>
			</c:forEach>
		</table>
	</div>

	<div>
		<button class="Read_Btn" onclick="getAllReport()">全体閲覧</button>
		<button class="Read_Btn" onclick="selectRead()">選択閲覧</button>
	</div>
</body>
</html>