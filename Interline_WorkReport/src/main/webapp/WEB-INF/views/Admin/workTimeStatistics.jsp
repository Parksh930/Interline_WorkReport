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
	getTimeList();

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

	function getTimeList(){
		Statistics_table_title	= '<table id = "worktime_list_table"><tr>';
		Statistics_table_title	+='<th class="usernum">社員番号</th>';
		Statistics_table_title	+='<th class="jan_workingTime">1月</th>';
		Statistics_table_title	+='<th class="feb_workingTime">2月</th>';
		Statistics_table_title	+='<th class="mar_workingTime">3月</th>';
		Statistics_table_title	+='<th class="apr_workingTime">4月</th>';
		Statistics_table_title	+='<th class="may_workingTime">5月</th>';
		Statistics_table_title	+='<th class="jun_workingTime">6月</th>';
		Statistics_table_title	+='<th class="jul_workingTime">7月</th>';
		Statistics_table_title	+='<th class="aug_workingTime">8月</th>';
		Statistics_table_title	+='<th class="sep_workingTime">9月</th>';
		Statistics_table_title	+='<th class="oct_workingTime">10月</th>';
		Statistics_table_title	+='<th class="nov_workingTime">11月</th>';
		Statistics_table_title	+='<th class="dec_workingTime">12月</th>';
		Statistics_table_title	+='<th class="user_sumTime">総計</th>';
		Statistics_table_title	+='<th class="user_avgTime">平均</th>';		

		var list = Statistics_table_title;
		
		$.ajax({
			type:"POST",
			url:"statistics",
			traditional: true,
			dataType:"json",
			success:function(result){
				
				(result.list).forEach(function(month){
					
					list +='<tr><td>'+month.usernum+'</td>';
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
					list +='<td>'+month.yearsumtime+'</td>';
					list +='<td>'+month.yearaveragetime+'</td><tr>';
					
				});
				
				list +="<tr><th>総計</th>";
				list += month_result(result.month_sumTime);				
				list +="<tr><th>平均</th>";
				list += month_result(result.month_avgTime);
				list += "</table>";
				$("#workTimeStatistics").html(list);

				isMobile();

				if($('#list_Box',parent.document)[0] != null){
					$('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+50+'px');
				}	
			}
		});
	}

	function month_result(month_resultTime){
		var content="";
		
		for(var n =0; n<month_resultTime.length; n++){
			content +="<td>"+month_resultTime[n]+"</td>";
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
margin:100px 0px 0px 0px;
}
</style>
</head>
<body>
<h1>1年間の集計</h1>
<div id = "workTimeStatistics">

</div>
</body>
</html>