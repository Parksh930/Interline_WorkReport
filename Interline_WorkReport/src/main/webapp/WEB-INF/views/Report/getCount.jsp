<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CountList</title>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="../resources/js/updateReport.js"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<script>
$(function(){
	var report_table_title;
	var count_sort;
	var countTable;
	var count_Measure = ["","ascending"];
	
	countList();
	isMobile(); 
	

	$(document).on('click','.Countlist_sort',Count_List_Sort);
	$('#selectOne').click(Count_reslut_Filter);
	$("#searchItem").change(Count_reslut_Filter);
	
		
	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";

		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
			}else{
				$("body").attr('class','pc_body');
		    }
		}
	}
	
	function Count_List_Sort(){
		var con = countTable;

		if($(this)[0].className == "Countlist_sort"){
			count_Measure = ($(this)[0].id).split('_');
		}

		
		if(count_Measure[0] == "userNum" && count_Measure[1] == "ascending"){
			count_sort.sort(function(a,b){
				return a[count_Measure[0]] - b[count_Measure[0]];
			});
		}else if(count_Measure[0] == "userNum" && count_Measure[1] == "descending"){
			count_sort.sort(function(a,b){
				return b[count_Measure[0]] - a[count_Measure[0]];
			});
		}


		if(count_Measure[0] != "userNum" && count_Measure[1] == "ascending"){
			count_sort.sort(function(a,b){
				return a[count_Measure[0]] < b[count_Measure[0]] ? -1 : a[count_Measure[0]] > b[count_Measure[0]] ? 1 : 0;
			});
		}else if(count_Measure[0] != "userNum" && count_Measure[1] == "descending"){
			count_sort.sort(function(a,b) {
				return a[count_Measure[0]] > b[count_Measure[0]] ? -1 : a[count_Measure[0]] < b[count_Measure[0]] ? 1 : 0;
			});
		}

		
		count_sort.forEach(function(item){

				con +='<tr><td class="Countlist_CountNum">'+item.userNum+'</td>';
				con +='<td class="Countlist_CountName">'+item.userName+'</td>';
				con +='<td class="Countlist_position">'+item.salesDay+'</td>';
				con +='<td class="Countlist_startDate">'+item.workingDay+'</td>';
				con +='<td class="Countlist_startDate">'+item.holidayWorkingDay+'</td>';
				con +='<td class="Countlist_startDate">'+item.absentDay+'</td>';
				con +='<td class="Countlist_sumWorkingTime">'+item.sumWorkingTime+'</td>';
				con +='<td class="Countlist_readReportBtn"><button id="ReadReport_Btn" class="Read_Btn" onclick="getReadReportCount('+item.reportNum+')">閲覧</button></td>';
				con +='<td class="Countlist_readReportBtn"><button id="ReadReport_Btn" class="Read_Btn" onclick="countDetail('+item.reportNum+')">詳細</button></td>';
				});
			
		con += "</table>";
		$("#Count_List").html(con);

		if($('#list_Box',parent.document)[0] != null){
			$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+100+'px');
		}
     //   if(count_sort==""||count_sort==null){
	//		$(".Countlist_readReportBtn").css("width","276.4px")
    //     }

	}


	function countList(){

		countTable	= '<table id = "count_list_table"><tr>';
		countTable	+='<th class="Countlist_userNum"><table class="thTable"><tr><td rowspan="2">社員番号</td><td id="userNum_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="userNum_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_userName"><table class="thTable"><tr><td rowspan="2">社員名</td><td id="userName_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="userName_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_salesDay"><table class="thTable"><tr><td rowspan="2">営業日</td><td id="salesDay_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="salesDay_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_workingDay"><table class="thTable"><tr><td rowspan="2">勤務日</td><td id="workingDay_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="workingDay_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_holidayWorkingDay"><table class="thTable"><tr><td rowspan="2">休日勤務日</td><td id="holidayWorkingDay_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="holidayWorkingDay_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_absentDay"><table class="thTable"><tr><td rowspan="2">欠勤日</td><td id="absentDay_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="absentDay_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<th class="Countlist_sumWorkingTime"><table class="thTable"><tr><td rowspan="2">勤務時間合計</td><td id="sumWorkingTime_ascending" class="Countlist_sort"><div>▲</div></td></tr><tr><td id="sumWorkingTime_descending" class="Countlist_sort"><div>▼</div></td></tr></table></th>';
		countTable	+='<td class="Countlist_readReportBtn">閲覧</td>';
		countTable	+='<td class="Countlist_readReportBtn">詳細</td></tr>';

		var con = countTable;

		$.ajax({
			type:"post",
			url:"countList",
			async:false,
			traditional: true,
			dataType:"json",
			success:function(list){
				count_sort = list;
			}	
		});

		Count_List_Sort();
	}

	
	function Count_reslut_Filter(){

	$('#Count_List2').empty(); 
	$('#Count_List3').empty(); 

	
		
	var searchItem = $("#searchItem").val()
	var month = searchItem;
	var thisDate = new Date();
	var thisYear = thisDate.getFullYear();
	var year = thisYear;
	var searchKeyword1 = $("#searchKeyword1").val();
	var searchKeyword2 = $("#searchKeyword2").val();
	
 	if(searchItem=="ALL"&&searchKeyword2==""){
		countList();
	} 
	else{ 
	
	$.ajax({
	type:"POST",
	url:"Count_Filter",
	data:{"year":year,"month":month,"searchItem":searchItem,'searchKeyword1':searchKeyword1,'searchKeyword2':searchKeyword2},
	async:false,
	traditional: true,
	dataType:"json",
	success:function(list){
		$("#searchKeyword2").empty();
		count_sort = list;
		}	
	});
	Count_List_Sort();
	} 
	}


});


function getReadReportCount(reportNum){
	
	location.href = "../admin/getReadReportCount?reportNum="+reportNum;
}

function countDetail(reportNum){
	var month;
	var year;
	var conText="";
	$('#Count_List3').empty(); 
	
	$.ajax({
		type:"post",
		url:"countDetail",
		data:{"reportNum":reportNum},
		dataType:"json",
		success:function(item){

			var getSum = item.sumWorkingTime;
 			var getWorkingDay = item.workingDay;
			var getSum2 = getSum.split(":");
			var getSum3 = parseInt((getSum2[0]*60))+parseInt(getSum2[1]);
			var getSum4 = ((getSum3/60)/getWorkingDay).toFixed(1);
			var getSum5 = getSum4.split(".");
			var averageWorkingValue1 = getSum5[0]+getSum5[1];
			var averageWorkingTime = getSum5[0]+"時間"+getSum5[1]+"分"; 
			

			conText +=  item.userName+"社員の"+item.month+"月の総勤務時間は「"+getSum2[0]+"時間"+getSum2[1]+"分」です。<br>";
			conText +=	item.userName+"社員の"+item.month+"月一日平均勤務時間は「"+averageWorkingTime+"」です。";

			month=item.month;
			year = item.year;
			$('#Count_List3').append(conText); 
			countOption(month,year);

			if($('#list_Box',parent.document)[0] != null){
				$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+50+'px');
			}
		}	
	});
	
}

function countOption(month,year){

	$('#Count_List2').empty(); 
	
	var conText="";
	var text;
	var text0;
	var text1;
	var text2=0;
	var text3=0;
	var text4;
	var text5;
	var text6;
	var text7;
	var text8;
	var text9;
	var monthValue=0;
	var monthValue = parseInt(month);
	var yearValue=0;
	var yearValue = parseInt(year);
	var date = getDateNum2(yearValue,monthValue);
	var dateNum = date-1; 
	
	$.ajax({
		type:"post",
		url:"countOption",
		//async:false,
		//traditional: true,
		data:{"month":monthValue},
		dataType:"json",
		success:function(list){
			console.log(list);
			var length = list.length;
			list.forEach(function(item){

				text = item.sumWorkingTime.split(":");
				text0 = parseInt(text[0]);
				text1 = parseInt(text[1]);
				text2 += text0;
				text3 += text1;
				text4 = Math.round(text2/length);
				text5 = Math.round(text3/length);
				text6 = text5.toString();
				text7 = Math.round(text4/dateNum);
				text8 = Math.round(text5/dateNum);
				text9 = text8.toString();

				
				if(text6.length==1){
				conText =item.month+'月の全社員の平均総勤務時間は「'+text4+"時間0"+text5+'分」です。<br>';
				}
				else{
				conText =item.month+'月の全社員の平均総勤務時間は「'+text4+"時間"+text5+'分」です。<br>';
				}
				
				if(text9.length==1){
				conText +=item.month+'月の全社員の一日平均総勤務時間は「'+text7+"時間0"+text8+'分」です。';
				}
				else{
				conText +=item.month+'月の全社員の一日平均総勤務時間は「'+text7+"時間"+text8+'分」です。';
				}
				});

			
				$('#Count_List2').append(conText); 


				if($('#list_Box',parent.document)[0] != null){
					$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+100+'px');
				}
				
		}
	});
}



</script>

<style>
body {
	text-align: center;
}

a {
	text-decoration: none;
}

table {
	border-collapse: collapse;
}

th, td {
	border: 1px solid black;
}

.thTable {
	border-style: none;
	border-bottom: none;
	margin-left: auto;
	margin-right: auto;
}

.thTable td {
	border: none;
}

td[id*="_ascending"] div {
	margin: 0px 0px -5px 0px;
}

td[id*="_descending"] div {
	margin: -5px 0px 0px 0px;
}

.Countlist_sort:hover {
	cursor: pointer;
	font-weight: 900;
}

#Count_List {
	margin: 20px auto;
	width: fit-content;
}

.Countlist_updateBtn {
	border-style: none;
	width: 50px;
	height: 45px;
}

a[class*="_Btn"] {
	border: solid 2px rgb(0, 112, 192);
	border-radius: 9px;
	padding: 2px 5px;
	background-color: rgb(0, 112, 192);
	color: white;
	cursor: pointer;
}

.Countlist_CountNum, .Countlist_team, .Countlist_position,
	.Countlist_retirement, .Countlist_startDate, .Countlist_finalreportDate,
	.Countlist_lastupdateDate {
	width: 100px;
}

.Countlist_CountMail {
	width: 200px;
}

.Countlist_CountName {
	width: 150px;
}

.Admin_CountRegister {
	text-align: right;
	margin: 10px 60px 0px 0px;
}

fieldset {
	border: 0;
	padding: 5px 12px 5px 12px;
}

#Count_list_sort {
	text-align: left;
	margin: 20px 0px 0px 0px;
}

#Countlist_sort {
	margin: auto;
	height: 24px;
}

#Count_status_span {
	margin: 0px 0px 0px -86px;
}

.Update_Btn {
	font-size: 14px;
}

.Read_Btn {
	border: solid 2px rgb(0, 112, 192);
	border-radius: 9px;
	padding: 2px 5px;
	background-color: rgb(0, 112, 192);
	color: white;
	cursor: pointer;
}

html { overflow-y:scroll; }

</style>
</head>
<body>
	<h1>集計</h1>

	<div>
		<select data-trigger="" name="searchKeyword1" id="searchKeyword1">
			<option value="userNum"
				<c:if test="${'userNum'==searchKeyword1}">selected</c:if>>社員番号</option>
			<option value="userName"
				<c:if test="${'userName'==searchKeyword1}">selected</c:if>>社員名</option>
		</select>
		<input type="text" name="searchKeyword2" id="searchKeyword2">
		<button id="selectOne">検索</button>
	</div>

	<br>
	<div>
		<select name="searchItem" id="searchItem">
			<option value="ALL"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>全月勤務票</option>
			<option value="1"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>1月勤務票</option>
			<option value="2"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>2月勤務票</option>
			<option value="3"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>3月勤務票</option>
			<option value="4"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>4月勤務票</option>
			<option value="5"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>5月勤務票</option>
			<option value="6"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>6月勤務票</option>
			<option value="7"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>7月勤務票</option>
			<option value="8"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>8月勤務票</option>
			<option value="9"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>9月勤務票</option>
			<option value="10"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>10月勤務票</option>
			<option value="11"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>11月勤務票</option>
			<option value="12"
				<c:if test="${'searchItem'==searchItem}">selected</c:if>>12月勤務票</option>
		</select>
	</div>
	<!-- <div onclick="addSearchMonth()">+</div> -->
<div id="list">

	<div id="Count_List"></div>

	<div id="Count_List2" align="center"></div>
	<div id="Count_List3" align="center"></div>



</div>
</body>
</html>