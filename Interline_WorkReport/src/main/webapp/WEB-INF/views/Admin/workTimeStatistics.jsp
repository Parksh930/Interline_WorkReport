<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>workTimeStatistics</title>
<script src="<c:url value = '../resources/js/jquery-2.0.3.min.js'/>"></script>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<script>
$(function(){
	var Statistics_table_title;
	var date = new Date();
	var Statistics_sort;
	var month_sumTime;
	var month_avgTime;
	var Statistics_Measure = ["userNum","ascending"];
	
	first_settings();
	getTimeList();
	$("#searchYear").change(getTimeList);
	$(document).on('click','.Statistics_sort',Statistics_List_Sort);

	function isMobile() {
		var filter = "win16|win32|win64|mac|macintel";

		if( navigator.platform  ){
			if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				$("body").attr('class','mobile_body');
			}else{
				$("body").attr('class','pc_body');
				$("table").addClass("pc_font_content1");
				$("a[class^='Update']").addClass("pc_font_button2");
		    }
		}
	}

	function first_settings(){
		
		Statistics_table_title	= '<table id = "worktime_list_table"><tr>';
		Statistics_table_title	+='<th class="usernum"><table class="thTable"><tr><td rowspan="2">社員番号</td><td id="userNum_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="userNum_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="jan_workingTime"><table class="thTable"><tr><td rowspan="2">1月</td><td id="january_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="january_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="feb_workingTime"><table class="thTable"><tr><td rowspan="2">2月</td><td id="feburary_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="feburary_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="mar_workingTime"><table class="thTable"><tr><td rowspan="2">3月</td><td id="march_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="march_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="apr_workingTime"><table class="thTable"><tr><td rowspan="2">4月</td><td id="april_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="april_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="may_workingTime"><table class="thTable"><tr><td rowspan="2">5月</td><td id="may_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="may_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="jun_workingTime"><table class="thTable"><tr><td rowspan="2">6月</td><td id="june_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="june_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="jul_workingTime"><table class="thTable"><tr><td rowspan="2">7月</td><td id="july_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="july_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="aug_workingTime"><table class="thTable"><tr><td rowspan="2">8月</td><td id="august_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="august_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="sep_workingTime"><table class="thTable"><tr><td rowspan="2">9月</td><td id="september_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="september_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="oct_workingTime"><table class="thTable"><tr><td rowspan="2">10月</td><td id="october_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="october_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="nov_workingTime"><table class="thTable"><tr><td rowspan="2">11月</td><td id="november_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="november_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="dec_workingTime"><table class="thTable"><tr><td rowspan="2">12月</td><td id="december_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="december_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="user_sumTime"><table class="thTable"><tr><td rowspan="2">総計</td><td id="yearsumtime_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="yearsumtime_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';
		Statistics_table_title	+='<th class="user_avgTime"><table class="thTable"><tr><td rowspan="2">平均</td><td id="yearaveragetime_ascending" class="Statistics_sort"><div>▲</div></td></tr><tr><td id="yearaveragetime_descending" class="Statistics_sort"><div>▼</div></td></tr></table></th>';		


		var min_year = ${min_year};
		var max_year = ${max_year};

		for(var n =min_year; n<=max_year; n++){
			$("#searchYear").append("<option value='"+n+"'>"+n+"年</option>");
		}
		$('#searchYear option[value='+date.getFullYear()+']').attr('selected','selected');
	/* 	$("#searchYear").val(date.getFullYear()); */
	}

	function Statistics_List_Sort(){
		if($(this)[0].className == "Statistics_sort"){
			Statistics_Measure = ($(this)[0].id).split('_');
		}

		if(Statistics_Measure[0] == "userNum" && Statistics_Measure[1] == "ascending"){
			Statistics_sort.sort(function(a,b){
				return a[Statistics_Measure[0]] - b[Statistics_Measure[0]];
			});
		}else if(Statistics_Measure[0] == "userNum" && Statistics_Measure[1] == "descending"){
			Statistics_sort.sort(function(a,b){
				return b[Statistics_Measure[0]] - a[Statistics_Measure[0]];
			});
		}

		if(Statistics_Measure[0] != "userNum" && Statistics_Measure[1] == "ascending"){
			Statistics_sort.sort(function(a,b){
				var a_time = a[Statistics_Measure[0]].split(":");
				var b_time = b[Statistics_Measure[0]].split(":");

				if(a_time[0]-b_time[0] != 0){
					return a_time[0]-b_time[0];
				}
				
				return a_time[1]-b_time[1];
			});
		}else if(Statistics_Measure[0] != "userNum" && Statistics_Measure[1] == "descending"){
			Statistics_sort.sort(function(a,b){
				var a_time = a[Statistics_Measure[0]].split(":");
				var b_time = b[Statistics_Measure[0]].split(":");

				if(b_time[0]-a_time[0] != 0){
					return b_time[0]-a_time[0];
				}
				return b_time[1]-a_time[1];
			});
		}
		
		var list = Statistics_table_title;
		
		Statistics_sort.forEach(function(month){
			
			list +='<tr><td>'+month.userNum+'</td>';
			list +='<td>'+month.january+'</td>';
			list +='<td>'+month.feburary+'</td>';
			list +='<td>'+month.march+'</td>';
			list +='<td>'+month.april+'</td>';
			list +='<td>'+month.may+'</td>';
			list +='<td>'+month.june+'</td>';
			list +='<td>'+month.july+'</td>';
			list +='<td>'+month.august+'</td>';
			list +='<td>'+month.september+'</td>';
			list +='<td>'+month.october+'</td>';
			list +='<td>'+month.november+'</td>';
			list +='<td>'+month.december+'</td>';
			list +='<td class="sum_workingTime">'+month.yearsumtime+'</td>';
			list +='<td class="avg_workingTime">'+month.yearaveragetime+'</td><tr>';
			
		});
		
		list +="<tr><th>総計</th>";
		list += month_sumTime;		
		list +="<tr><th>平均</th>";
		list += month_avgTime;
		list += "</table>";
		$("#workTimeStatistics").html(list);

		isMobile();

		if($('#list_Box',parent.document)[0] != null){
			$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+50+'px');
		}	

	}

	
	function getTimeList(){
		var year =  $("#searchYear").val();

		$.ajax({
			type:"POST",
			url:"statistics",
			traditional: true,
			async:false,
			data:{"select_year":year},
			dataType:"json",
			success:function(result){
				Statistics_sort=result.list;
				month_sumTime = month_result(result.month_sumTime,"sum_workingTime");
				month_avgTime = month_result(result.month_avgTime,"avg_workingTime");
			}
		});

		Statistics_List_Sort();
	}

	function month_result(month_resultTime,th_class){
		var content="";
		
		for(var n =0; n<month_resultTime.length; n++){
			content +="<td class='"+th_class+"'>"+month_resultTime[n]+"</td>";
		};
		content += "<tr>";
		return content;
	}

});
</script>
<style>
body{
text-align: center;
}

table {
  border-collapse: collapse;
}

th,td{
border: 1px solid black;
}

.usernum{
width:100px;
}

th[class*="Time"]{
width:80px;
}

#workTimeStatistics{
margin:80px 0px 0px 0px;
}

.sum_workingTime,.avg_workingTime{
font-weight:600;
}

.thTable{
border-style:none;
border-bottom:none;
margin-left: auto;
margin-right: auto;
}

.thTable td{
border:none;
}

td[id*="_ascending"] div{
margin:0px 0px -5px 0px;
}

td[id*="_descending"] div{
margin:-5px 0px 0px 0px;
}

.Statistics_sort:hover{
cursor:pointer;
font-weight:900;
}

select {
	height: 24px;
}

</style>
</head>
<body>
<h1>1年間の集計</h1>
<div><select id = "searchYear" name="searchYear">
</select></div>
<div id = "workTimeStatistics">

</div>
</body>
</html>