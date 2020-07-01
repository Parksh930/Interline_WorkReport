<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page import="project.interline.report.util.getProperties"%>
<%@page import="java.util.Properties"%>
<% getProperties properties= new getProperties(); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="<c:url value = '../resources/js/jquery-3.4.1.min.js'/>"></script>
</head>
<link href='../resources/css/Font-Style.css' rel='stylesheet'>
<style>
body{
	text-align: center;
}
#resultTable{
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;
}
#resultTable td{
	border: 1px solid;
}
#resultTable table{
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;
}
#resultTable table td{
	border-style: none;
}
.filterTable{
	border-collapse: collapse;
	margin-left: auto;
	margin-right: auto;
	text-align: right;
}

*[id*='_Filter']{
	border: 0;
}
div[id*="_Asc"]{
margin: 0px 0px -5px 0px;
cursor: pointer;
}
div[id*="_Desc"]{
margin: -5px 0px 0px 0px;
cursor: pointer;
}
</style>
<script>
	$(document).ready(function(){
		 isMobile(); 
		 setOption();
		$('input[name="report_userTeam"]').click(getFilter);
		$('input[name="report_userTeam2"]').click(getFilter);
		$('#report_userNum_btn').click(getFilter);
		$('#report_userName_btn').click(getFilter);
		$("#reportDays_Filter").change(getFilter);
		$("#aaa").html("");
		function isMobile() {
		    var filter = "win16|win32|win64|mac|macintel";
		    if( navigator.platform  ){
		      if( filter.indexOf(navigator.platform.toLowerCase())<0 ){
				
		      }else{
		    	$("body").addClass("pc_body");
		    	$("#title").addClass("pc_font_title");
		    	$(".btn").addClass("pc_font_button2");
		    	//$("#messageBox").addClass("pc_font_content1");
		      }
		    }
		    
		  }
		
		  //select박스의 option을 채워줌
		function setOption(){
			var date = new Date();
			var now_year = date.getFullYear();
			var now_month = date.getMonth();
			for (i=0 ; i<3 ; i++){
				$('#fromYear').html($('#fromYear').html()+"<option value='"+(now_year-i)+"'>"+(now_year-i)+"</option>");
				$('#toYear').html($('#toYear').html()+"<option value='"+(now_year-i)+"'>"+(now_year-i)+"</option>");
				$("#fromMonth option:eq("+now_month+")").attr('selected','selected')
				$("#toMonth option:eq("+now_month+")").attr('selected','selected')
			}	
		}

		
	});

	//아이템리스트를 저장할 글로벌 변수
	var globalList=null;


	function scroll(){
		 if($('#list_Box',parent.document)[0] != null){
	         $('#list_Box',parent.document).css('height',$("body")[0].scrollHeight+50+'px');
	      }
		}
	
	function getFilter(){
		var checkBox=$('input[name="report_userTeam"]');
		var checkBoxEtc=$('input[name="report_userTeam2"]');
		var teamArray=new Array();
		var etcArray=new Array();
		var userNum=$('#report_userNum').val();
		var userName=$('#report_userName').val();
		var fromYearMonth= $("#fromYear option:selected").val()+"-"+ $("#fromMonth option:selected").val();
		var toYearMonth= $("#toYear option:selected").val()+"-"+ $("#toMonth option:selected").val();
		//선택된 체크박스의 팀명들을 배열로
		for(i=0;i<checkBox.length;i++) {
		    if (checkBox[i].checked == true){
		    	teamArray.push(checkBox[i].value);
		    }
		}
		//소노타를 위한 배열. 체크되어있으면 만듬.
		if (checkBoxEtc[0].checked == true){
			for(i=0;i<checkBox.length;i++){
				etcArray.push(checkBox[i].value);
			}
		}
		//userNum이 없을경우를 위한
		if(userNum==""){userNum="%";}
		//userName이 없을경우를 위한
		if(userName==""){userName="%";}

		
		//입력된 값으로 json을 만들고 이걸이제 ajax로 보낼꺼다.
		var jsonArray={"teamArray":teamArray.join(","),"etcArray":etcArray.join(","),"userNum":userNum,"userName":userName,"fromYearMonth":fromYearMonth,"toYearMonth":toYearMonth}

		//제이슨 결과 확인
		console.log(JSON.stringify(jsonArray));

		$.ajax({
			type:"get",
			url:"aggregationFilter",
			data:jsonArray,
			dataType:"json",
			success:function(list){
				console.log("GetList:::"+JSON.stringify(list));
				//전역변수에 list세팅
				globalList=list;
				//가지고왔으면 뿌려주는 함수실행
				setResult(list);
				//
				//objectoToJson(list);
			},
			error: function(e){
				console.log(JSON.stringify(e));
			}
		});		
		
	}

//뿌려주는 함수
function setResult(list){
	var saveTr=$('#saveTr').html();
	var topTds=$('#topTr').html();
	var bottomTds=$('#bottomTr').html();
	var html="";
	html+="<tr id='saveTr'>";
	html+=saveTr;
	html+="</tr>";
	html+="<tr id='topTr'>";
	html+=topTds;
	html+="</tr>";
	for (var i =0 ; i < list.length ; i++){
		html+="<tr class='list'>";
		html+="<td id='state"+(i+1)+"'><input id='select"+(i+1)+"' type='checkbox' name='selectedRow' value='"+(i+1)+"'></td>";
		html+="<td>"+list[i].userNum+"</td>";
		html+="<td>"+list[i].userName+"</td>";
		html+="<td>"+list[i].position+"</td>";
		html+="<td>"+list[i].team+"</td>";
		html+="<td>"+list[i].yearMonth+"</td>";
		html+="<td>"+list[i].absent+"</td>";
		html+="<td>"+list[i].vacation+"</td>";
		html+="<td>"+list[i].holidayWorkingDay+"</td>";
		html+="<td>"+list[i].sumWorkingTime+"</td>";
		html+="<td class='meanWorkingTime"+(i+1)+"'>"+list[i].meanWorkingTime+"</td>";
		html+="</tr>";
	}
	html+="<tr id='bottomTr'>";
	html+=bottomTds;
	html+="</tr>";
	
	$('#resultTable').html(html);

	//전체평균을 구하여 넣어주는 함수실행
	setTotalMean();
	scroll();
}
//전체평균을 구하여 넣어주는 함수
function setTotalMean(){
	var eachWorkingTime = $('td[class*="meanWorkingTime"]');
	console.log();
	var totalMinute=0;
	var totalReport=eachWorkingTime.length;
	console.log(totalReport);
	for(var i=0 ; i<totalReport ; i++ ){
		var time=$('.meanWorkingTime'+(i+1)).html();
		var hour=parseInt(time.split(":")[0]);
		var minute=parseInt(time.split(":")[1]);
		totalMinute+=hour*60+minute;
	}
	var meanMinute=parseInt(totalMinute/totalReport);
	$('#totalMeanTime').html(parseInt(meanMinute/60) +":"+meanMinute%60);
}

//리스트로 온 vo객체를 제이슨으로 만들어주는함수
function objectoToJson(list){
	var JSONdata=new Object();
	for(var i = 0 ; i<list.length ; i++){
		var keyValue = Object.keys(list[i]);
		for(var j = 0 ; j<keyValue.length ; j++){
			console.log(list[i][keyValue[j]+""]);
			JSONdata[keyValue[j]+(i+1)]=list[i][keyValue[j]+""];
		}
	}
	console.log("만들어주는곳에서 스트링파이한거::::"+JSON.stringify(JSONdata));	
	return[JSON.stringify(JSONdata),list.length];
}

//저장을 눌렀을 경우
function exportReport(format){
	var getSeletedItemList=getSelectedItems(globalList);
	if(getSeletedItemList.length==0){
		alert("何も選択しなかったです。");
		return
	}
	var dataSet=objectoToJson(getSeletedItemList);
	console.log("json:::"+dataSet[0]);
	console.log("row:::"+dataSet[1]);
	console.log("format:::"+format);
	$('#wrapper').css('z-index',2);
	$('#wrapper').css('visibility','visible');
	$('body').css('cursor','progress');
	
	$.ajax({
		type:"get",
		url:"exportAggregation",
		data:{"jsonData":dataSet[0],"row":dataSet[1],"format":format},
		dataType:"text",
		success:function(s){
			console.log("ajax성공");
			$('#wrapper').css('z-index',-1);
			$('#wrapper').css('visibility','hidden');
			$('body').css('cursor','pointer');
			if(s=="saveError"){
				alert("エラー：スケジューラーサーバーが稼動中ではありません。");
				return;
			}
			location.href="http://<%out.print(properties.getOzIP());%>/ozsch80/Repository/"+format+"/reportExport."+format;
		},
		error: function(e){
			console.log(JSON.stringify(e));
		}
	});	
}

//글로벌리스트로부터 선택된 아이템만 추출해서 새 list만들기
function getSelectedItems(list){
	var checkBox=$('input[name="selectedRow"]');
	var selectedIndexArray=new Array();
	for(var i=0 ; i<checkBox.length ; i++) {
	    if (checkBox[i].checked == true){
	    	selectedIndexArray.push(parseInt(checkBox[i].value));
	    }
	}
	console.log("전체 어레이::");
	console.log(list);
	console.log("선택된인덱스::");
	console.log(selectedIndexArray);
	var newList=new Array();
	for(var i=0 ; i<selectedIndexArray.length ; i++){
		newList.push(list[selectedIndexArray[i]-1]);
	}
	console.log("선택된어레이");
	console.log(newList)
	return newList;
}

function selectAll(){
	var checkBoxSelectAll=$('input[name="selectAll"]');
	var checkBoxItems=$('input[name="selectedRow"]');
	if (checkBoxSelectAll[0].checked == true){
		checkBoxItems.prop('checked', true) ;
	}else{
		checkBoxItems.prop('checked', false) ;
	}
}

function sorting(type,colName){
	if (type=="asc"){
		globalList.sort(function(a,b){
				return a[colName].toLowerCase() < b[colName].toLowerCase()? -1 : a[colName].toLowerCase() > b[colName].toLowerCase()? 1 : 0;
				});
	}else{	
		globalList.sort(function(a,b){
			return a[colName].toLowerCase() < b[colName].toLowerCase()? 1 : a[colName].toLowerCase() > b[colName].toLowerCase()? -1 : 0;
			});
	}

	//가지고왔으면 뿌려주는 함수실행
	setResult(globalList);
}
</script>

<body>
	<div id="title">勤務票集計</div>
	<div id="report_list_filter">
		<fieldset id="reportUserNum_Filter">
			<table class="filterTable">
				<tr>
					<td><label for="report_userNum">社員番号：</label><input type="number" name="report_userNum" id="report_userNum"></td>
					<td rowspan='2'><button id="report_userName_btn" class="filter_btn">適用</button></td>					
				</tr>
				<tr>
					<td><label for="report_userName">社員名：</label><input type="text" name="report_userName" id="report_userName"></td>
				</tr>
			</table>
		</fieldset>
		<fieldset id="reportTeam_Filter">
			<span id="team_span">チーム名：</span> 
			<input type="checkbox" id="team_tokyo" name="report_userTeam" value="東京"><label for="team_tokyo">東京</label> 
			<input type="checkbox" id="team_yokohama" name="report_userTeam" value="横浜"><label for="team_yokohama">横浜</label> 
			<input type="checkbox" id="team_saitama" name="report_userTeam" value="埼玉"><label for="team_saitama">埼玉</label> 
			<input type="checkbox" id="team_others" name="report_userTeam2" value="その他"><label for="team_others">その他</label>
		</fieldset>
		<fieldset id="reportDays_Filter">
			<span id="report_reportDays_span">勤務票の期間：</span> 
			<select id="fromYear" name="from_ReportDays">
			</select>年
			<select id="fromMonth" name="from_ReportDays">
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>月
			~ 
			<select id="toYear" name="to_ReportDays">
			</select>年
			<select id="toMonth" name="to_ReportDays">
			<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
				<option value="11">11</option>
				<option value="12">12</option>
			</select>月
		</fieldset>
	</div>
	
	
	
	
	
	<table id="resultTable">
		<tr id='saveTr'><td colspan="11" style="text-align: right; border-style: none;">
			<div style="margin-bottom: 4px;">
			<span id="pdfExportButton" class='btn' onclick="exportReport('pdf')">PDF</span>
			<span id="xlsExportButton" class='btn' onclick="exportReport('xls')">EXCEL</span>
			</div>
		</td></tr>
		<tr id='topTr'>
			<td><input id='allSelect' type='checkbox' name='selectAll' value='on' onchange="selectAll()"></td>
			<td>
				<table>
					<tr>
						<td rowspan="2">사원번호</td><td><div id="number_Asc" onclick="sorting('asc','userNum')">▲</div></td>
					</tr>
					<tr>
						<td><div id="number_Desc" onclick="sorting('desc','userNum')">▼</div></td>
					</tr>
				</table>
			</td>
			<td>
				<table>
					<tr>
						<td rowspan="2">이름</td><td><div id="name_Asc" onclick="sorting('asc','userName')">▲</div></td>
					</tr>
					<tr>
						<td><div id="name_Desc" onclick="sorting('desc','userName')">▼</div></td>
					</tr>
				</table>
			</td>
			<td>
				<table>
					<tr>
						<td rowspan="2">직급</td><td><div id="position_Asc" onclick="sorting('asc','position')">▲</div></td>
					</tr>
					<tr>
						<td><div id="position_Desc" onclick="sorting('desc','position')">▼</div></td>
					</tr>
				</table>
			</td>
			<td>
				<table>
					<tr>
						<td rowspan="2">현장</td><td><div id="team_Asc" onclick="sorting('asc','team')">▲</div></td>
					</tr>
					<tr>
						<td><div id="team_Desc" onclick="sorting('desc','team')">▼</div></td>
					</tr>
				</table>
			</td>
			<td>
				<table>
					<tr>
						<td rowspan="2">년월분</td><td><div id="time_Asc" onclick="sorting('asc','yearMonth')">▲</div></td>
					</tr>
					<tr>
						<td><div id="time_Desc" onclick="sorting('desc','yearMonth')">▼</div></td>
					</tr>
				</table>
			</td>
			<td>결근(지각)</td>
			<td>유휴(무휴)</td>
			<td>휴일출근</td>
			<td>총근무시간</td>
			<td>평균근무시간</td>
		</tr>
	<c:forEach var = "list" items="${arrayList}" varStatus="status">
		<tr class="list">
			<td id="state${status.count}"><input id="select${status.count}" type='checkbox' name="selectedRow" value='${status.count}'></td>
			<td>${list.userNum}</td>
			<td>${list.userName}</td>
			<td>${list.position}</td>
			<td>${list.team}</td>
			<td>${list.yearMonth}</td>
			<td>${list.absent}</td>
			<td>${list.vacation}</td>
			<td>${list.holidayWorkingDay}</td>
			<td>${list.sumWorkingTime}</td>
			<td class="meanWorkingTime${status.count}">${list.meanWorkingTime}</td>
			<!-- <td id="state${status.count}" class="Reportlist_Days">${stateVal[work_report.state]}</td> -->
		</tr>
	</c:forEach>
	<tr id="bottomTr">
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd"></td>
		<td class="bottomTd">전체평균</td>
		<td id='totalMeanTime' class="bottomTd">ㅁㅁㅁ</td>
	</tr>
	</table>
	<div id="JSONString" style="visibility: hidden;">${JSONString}</div>
	<div id="wrapper" style="z-index: -1; display: table; background-color:rgb(225,225,225); position: absolute; left: 0%; top: 0%; visibility: hidden; width: 100%; height: 100%; opacity: 0.5;">
	</div>
<script>
	console.log("JSONString:::"+$('#JSONString').html());
	globalList=JSON.parse($('#JSONString').html());
	setTotalMean();
	scroll();
</script>
</body>
</html>