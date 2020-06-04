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
	margin: 20px auto;
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

input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
}

#reportDays_Filter{
	border: 0;
}

</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script>
$(function(){
	var report_table_title;
	var report_sort;
	var team_others;
	var report_userTeam=[];
	var report_Measure = ["updateDate","descending"];
	var from_ReportDays_value;
	var to_ReportDays_value;

	first_reportList();
	$("#Reportlist_sort").change(report_List_Sort);
	$('input[name="report_userTeam"]').click(report_Team_Filter);
	$('#report_userNum_btn').click(report_Text_Filter);
	$('#report_userName_btn').click(report_Text_Filter);
	$("#reportDays_Filter").change(report_Days_Filter);

	
	function first_reportList(){
		report_table_title  = '<table><tr><th class="Reportlist_checkBox"><input type="checkbox" id="allCheck" onclick="Acheck()"></th>';
		report_table_title	+='<th class="Reportlist_userNum">社員番号</th><th class="Reportlist_userMail">社員メール</th>';
		report_table_title	+='<th class="Reportlist_userName">社員名</th><th class="Reportlist_team">チーム名</th>';
		report_table_title	+='<th class="Reportlist_reportDays">年月分</th><th class="Reportlist_updateDate">最終保存日時</th></tr>';

		var report_com = report_table_title;

		$.ajax({
			type:"post",
			url:"reportList",
			async:false,
			traditional: true,
			dataType:"json",
			success:function(list){

				list.forEach(function(report){
					report_com += '<tr><td><input type="checkbox" name="selectValue" class="check"value="${report_List.reportNum}"></td>';
					report_com += '<td class="Reportlist_userNum">'+report.userNum+'</td>';
					report_com += '<td class="Reportlist_userMail">'+report.userMail+'</td>';
					report_com += '<td class="Reportlist_userName">'+report.userName+'</td>';
					report_com += '<td class="Reportlist_team">'+report.team+'</td>';
					report_com += '<td class="Reportlist_reportDays">'+report.year+'年'+report.month+'月</td>';
					report_com += '<td class="Reportlist_updateDate">'+report.updateDate+'</td>';
					report_com += '<td class="Reportlist_reportBtn"><button class="Read_Btn" onclick="getReadReport('+report.reportNum+')">閲覧</button>';
					report_com += '<td class="Reportlist_reportBtn"><button class="Read_Btn" onclick="getUpdateReport('+report.reportNum+')">修正</button>';
				report_com +='<td class="Reportlist_reportBtn"><button class="Read_Btn"onclick="DeleteReport('+report.reportNum+')">削除</button></tr>';
				});
				
				report_com += "</table>";
				 $("#report_List").html(report_com); 
				 report_sort = list;
			}	
		});

		var date = new Date();
		var now_year = date.getFullYear();

		$("#from_ReportDays").prepend("<option value='"+now_year+"-01'>下限なし</option>");
		$("#to_ReportDays").prepend("<option value='"+now_year+"-12'>上限なし</option>");
		
		for(var n = 1; n<=12 ; n++){
			if(n<10){
				$("#from_ReportDays").append("<option value='"+now_year+"-0"+n+"'>"+now_year+"年"+n+"月</option>");
				$("#to_ReportDays").append("<option value='"+now_year+"-0"+n+"'>"+now_year+"年"+n+"月</option>");
			}else{
				$("#from_ReportDays").append("<option value='"+now_year+"-"+n+"'>"+now_year+"年"+n+"月</option>");
				$("#to_ReportDays").append("<option value='"+now_year+"-"+n+"'>"+now_year+"年"+n+"月</option>");
			}
		}

		from_ReportDays_value = $("#from_ReportDays option:selected").val();
		to_ReportDays_value= $("#to_ReportDays option:selected").val();
	}
	function report_Team_Filter(){
		report_userTeam = [];

		$('input[name="report_userTeam"]').each(function(){
			if($(this)[0].value != "その他"){
				report_userTeam.push($(this).val());
			}
		});
		
		if($('#team_others').prop("checked")){
			team_others = "not";
			$('input[name="report_userTeam"]').each(function(){
				if($(this).prop("checked") && $(this)[0].value != "その他"){
					report_userTeam.splice(report_userTeam.indexOf($(this).val()),1);
				}
			});
		}
		else{
			team_others = null;
			$('input[name="report_userTeam"]').each(function(){
				if($(this).prop("checked") == false && $(this)[0].value != "その他"){
					report_userTeam.splice(report_userTeam.indexOf($(this).val()),1);
				}
			});
		}

		report_result_Filter();
	}

	function report_Text_Filter(){
		if($(this)[0].id == "report_userNum_btn"){
			var report_userNum = $("#report_userNum").val();
			report_result_Filter("report_userNum",report_userNum);
		}
		else if($(this)[0].id == "report_userName_btn"){
			var report_userName = $("#report_userName").val();
			report_result_Filter("report_userName",report_userName);
		};

		$("#report_userNum").val("");
		$("#report_userName").val("");
	}

	function report_Days_Filter(){
		from_ReportDays_value = $("#from_ReportDays option:selected").val();
		to_ReportDays_value= $("#to_ReportDays option:selected").val();
		
		report_result_Filter();
	}

	function report_result_Filter(Filter,val){
		var report_userNum;
		var report_userName;
		if(Filter == "report_userNum"){
			report_userNum = val;
		}else if(Filter == "report_userName"){
			report_userName = val;
		}
		
		if(report_userTeam == "" || report_userTeam == null){
			report_userTeam.push("report_teamAll");
		}else if(report_userTeam.indexOf("report_teamAll") > -1 && report_userTeam.length >= 2){
			report_userTeam.splice(report_userTeam.indexOf("report_teamAll"),1);
		}

		$.ajax({
			type:"get",
			url:"report_Filter",
			data:{team:report_userTeam,team_others:team_others
				,report_userNum:report_userNum,report_userName:report_userName
				,report_FromReportDays:from_ReportDays_value,report_ToReportDays:to_ReportDays_value},
			async:false,
			traditional: true,
			dataType:"json",
			success:function(list){
				report_sort=list;
			}
		});
		report_List_Sort();
	}

	function report_List_Sort(){
		var report_com = report_table_title;

		if($(this)[0].id == "Reportlist_sort"){
			report_Measure = ($(this).val()).split('_');
		}

		if(report_Measure[0] == "reportDays" && report_Measure[1] == "ascending"){
			report_sort.sort(function(a,b){
				var ab = a["year"] - b["year"];
				if (ab == 0){
					return  a["month"] - b["month"];
				}
				return ab});
		}else if (report_Measure[0] == "reportDays" && report_Measure[1] == "descending"){
			report_sort.sort(function(a,b){
				var ba = b["year"] - a["year"];
				if (ba == 0){
					return  b["month"] - a["month"];
				}
				return ba});
		}

		if(report_Measure[0] == "userNum" && report_Measure[1] == "ascending"){
			report_sort.sort(function(a,b){return a[report_Measure[0]] - b[report_Measure[0]]});
		}else if(report_Measure[0] == "userNum" && report_Measure[1] == "descending"){
			report_sort.sort(function(a,b){return b[report_Measure[0]] - a[report_Measure[0]]});
		}

		if(report_Measure[0] != "userNum" && report_Measure[0] != "reportDays" && report_Measure[1] == "ascending"){
			report_sort.sort(function(a,b){return a[report_Measure[0]] < b[report_Measure[0]] ? -1 : a[report_Measure[0]] > b[report_Measure[0]] ? 1 : 0;});
		}else if(report_Measure[0] != "userNum" && report_Measure[0] != "reportDays" && report_Measure[1] == "descending"){
			report_sort.sort(function(a, b) {return a[report_Measure[0]] > b[report_Measure[0]] ? -1 : a[report_Measure[0]] < b[report_Measure[0]] ? 1 : 0;});
		} 


		report_sort.forEach(function(report){
			report_com += '<tr><td><input type="checkbox" name="selectValue" class="check"value="${report_List.reportNum}"></td>';
			report_com += '<td class="Reportlist_userNum">'+report.userNum+'</td>';
			report_com += '<td class="Reportlist_userMail">'+report.userMail+'</td>';
			report_com += '<td class="Reportlist_userName">'+report.userName+'</td>';
			report_com += '<td class="Reportlist_team">'+report.team+'</td>';
			report_com += '<td class="Reportlist_reportDays">'+report.year+'年'+report.month+'月</td>';
			report_com += '<td class="Reportlist_updateDate">'+report.updateDate+'</td>';
			report_com += '<td class="Reportlist_reportBtn"><button class="Read_Btn" onclick="getReadReport('+report.reportNum+')">閲覧</button>';
			report_com += '<td class="Reportlist_reportBtn"><button class="Read_Btn" onclick="getUpdateReport('+report.reportNum+')">修正</button>';
		report_com +='<td class="Reportlist_reportBtn"><button class="Read_Btn"onclick="DeleteReport('+report.reportNum+')">削除</button></tr>';
		});
		
		report_com += "</table>";
		 $("#report_List").html(report_com); 
	}
});






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
				
	

  function selectRead(reportNum){
  
    //var arrNumber = new Array();

   	//var arrNumber = [];
   	var arrNumber="";
    var chk_obj = document.getElementsByName("selectValue");
  	var chk_leng = chk_obj.length;

	if(!$(".check").is(':checked')){
		alert("閲覧する勤務表を選択してください。");
		return false;
		}
	
  	for(i=0;i<chk_leng;i++){
  		//if(chk_obj[i].checked==true){
  			//arrNumber.push(chk_obj[i].value);
  		if(chk_obj[i].checked==true){	
  	  		arrNumber += chk_obj[i].value+",";
		  	  	}
  	  	}
  	 
  		//str = str.substr(0, str.length -1)
  		//list = list.slice(0, -1);
  	
  		var arr = arrNumber.substr(0, arrNumber.length -1);
  		
  		//var jsonData={"array":arrNumber};
  		//var jsonData2 = JSON.stringify(jsonData);
  	   	location.href = "../admin/getReadReport2?arrNumber="+arr;
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
	<div id="report_list_filter">
	<label for="user_num">社員番号</label><input type="number" name = "report_userNum" id = "report_userNum">
	<button id="report_userNum_btn">検索</button>
	<br>
	<label for="user_name">社員名</label><input type="text" name="report_userName" id = "report_userName">
	<button id="report_userName_btn">検索</button>
	<br>
	<input type="checkbox" id ="team_tokyo" name ="report_userTeam" value="東京"><label for="team_tokyo">東京</label>
	<input type="checkbox" id ="team_yokohama" name ="report_userTeam" value="横浜"><label for="team_yokohama">横浜</label>
	<input type="checkbox" id ="team_saitama" name ="report_userTeam" value="埼玉"><label for="team_saitama">埼玉</label>
	<input type="checkbox" id ="team_others" name ="report_userTeam" value="その他"><label for="team_others">その他</label>
	<br>
	<fieldset id = "reportDays_Filter">
	勤務票の期間
	<select id ="from_ReportDays" name="from_ReportDays">
	</select>
	~
	<select id ="to_ReportDays" name="to_ReportDays">
	</select>
	</fieldset>
	</div>
	<div id="report_list_sort">
		<select id ="Reportlist_sort" name="Userlist_sort">
			<option value="userNum_ascending">社員番号の昇順</option>
			<option value="userNum_descending">社員番号の降順</option>
			<option value="userMail_ascending">社員メールの昇順</option>
			<option value="userMail_descending">社員メールの降順</option>
			<option value="userName_ascending">社員名の昇順</option>
			<option value="userName_descending">社員名の降順</option>
			<option value="team_ascending">チーム名の昇順</option>
			<option value="team_descending">チーム名の降順</option>
			<option value="reportDays_ascending">年月分の昇順</option>
			<option value="reportDays_descending">年月分の降順</option>
			<option value="updateDate_ascending">最終保存日時の昇順</option>
			<option value="updateDate_descending">最終保存日時の降順</option>
		</select>
	</div>
	<div id="report_List"></div>

	<div>
		<button class="Read_Btn" onclick="getAllReport()">全体閲覧</button>
		<button class="Read_Btn" onclick="selectRead()">選択閲覧</button>
	</div>
</body>
</html>