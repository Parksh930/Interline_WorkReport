/* input (Date)
 * reutrn (String)
 * 날자를 입력받아 "YYYY-MM-DD"의 형식으로 출력
 */
function generateSingleDate(date){
	year=date.getFullYear();
	month=date.getMonth()+1;
	dates=date.getDate();
	return year+"-"+month+"-"+dates;
 }


//input Type (Date,Date)
//return Type (String)
//이번주의 월요일, 금요일 날짜를 받으면 'YYYY-MM-DD~YYYY-MM-DD'의 형식으로  반환한다. 
function generateDate(mon,fri){
	var period="";
	year1=mon.getFullYear();
	month1=mon.getMonth()+1;
	date1=mon.getDate();
	if(month1<10){	month1="0"+month1;	}
	if(date1<10){	date1="0"+date1;	}

	year2=fri.getFullYear();
	month2=fri.getMonth()+1;
	date2=fri.getDate();
	if(month2<10){	month2="0"+month2;	}
	if(date2<10){	date2="0"+date2;	}
	return year1+"-"+month1+"-"+date1+"~"+year2+"-"+month2+"-"+date2;
}


/* input: (JSON)
 * return: [JSON,JSON]
 * eform에서 일률적으로 들어오는 1차원 제이슨 배열의 자료를 
 * report테이블과 report_main테이블의 형식으로 변환해 준다.
 * */
function makeJsonForSubmit(oriJson){
	var reportJson={
			"User_Num":"",
			"location":"",
			"StartWeek":"",
			"EndWeek":"",
			"WeeklyRemarks":"",
			"SendDays":""
		}
	
	var contentsJson={
		"mon":{
				"Report_Num":"",
				"StartWork":"",
				"EndWork":"",
				"ReportContents":"",
				"DailyRemarks":""
				},
		"tue":{
				"Report_Num":"",
				"StartWork":"",
				"EndWork":"",
				"ReportContents":"",
				"DailyRemarks":""
				},
		"wed":{
				"Report_Num":"",
				"StartWork":"",
				"EndWork":"",
				"ReportContents":"",
				"DailyRemarks":""
				},
		"thu":{
				"Report_Num":"",
				"StartWork":"",
				"EndWork":"",
				"ReportContents":"",
				"DailyRemarks":""
				},
		"fri":{
				"Report_Num":"",
				"StartWork":"",
				"EndWork":"",
				"ReportContents":"",
				"DailyRemarks":""
				}
	}
	
	var today = new Date();
	var day = today.getDay();
	
	reportJson.User_Num=oriJson.userNum;
	reportJson.location=oriJson.location;
	
	var week=oriJson.week.split("~");
	reportJson.StartWeek=week[0];
	reportJson.EndWeek=week[1];
	
	reportJson.WeeklyRemarks=oriJson.weeklyRemarks;
	reportJson.SendDays=day;
	

	
	//여기까지 report
	
	
	var mondayDate=new Date(reportJson.StartWeek);
	var monday=generateSingleDate(mondayDate);  
	contentsJson.mon.StartWork=monday+" "+oriJson.startTimeMon+":"+oriJson.startMinMon;
	contentsJson.mon.EndWork=monday+" "+oriJson.endTimeMon+":"+oriJson.endMinMon;
	contentsJson.mon.ReportContents=oriJson.reportContentsMon;
	contentsJson.mon.DailyRemarks=oriJson.dailyRemarksMon;
	
	var tuesday = generateSingleDate(new Date(mondayDate.setDate(mondayDate.getDate()+1)));
	contentsJson.tue.StartWork = tuesday+" "+oriJson.startTimeTue+":"+oriJson.startMinTue;
	contentsJson.tue.EndWork = tuesday+" "+oriJson.endTimeTue+":"+oriJson.endMinTue;
	contentsJson.tue.ReportContents = oriJson.reportContentsTue;
	contentsJson.tue.DailyRemarks = oriJson.dailyRemarksTue;
	
	var wednesday = generateSingleDate(new Date(mondayDate.setDate(mondayDate.getDate()+1)));
	contentsJson.wed.StartWork = wednesday+" "+oriJson.startTimeWed+":"+oriJson.startMinWed;
	contentsJson.wed.EndWork = wednesday+" "+oriJson.endTimeWed+":"+oriJson.endMinWed;
	contentsJson.wed.ReportContents = oriJson.reportContentsWed;
	contentsJson.wed.DailyRemarks = oriJson.dailyRemarksWed;
	
	var thursday = generateSingleDate(new Date(mondayDate.setDate(mondayDate.getDate()+1)));
	contentsJson.thu.StartWork = thursday+" "+oriJson.startTimeThu+":"+oriJson.startMinThu;
	contentsJson.thu.EndWork = tuesday+" "+oriJson.endTimeThu+":"+oriJson.endMinThu;
	contentsJson.thu.ReportContents = oriJson.reportContentsThu;
	contentsJson.thu.DailyRemarks = oriJson.dailyRemarksThu;
	
	var friday = reportJson.StartWeek;
	contentsJson.fri.StartWork = friday+" "+oriJson.startTimeFri+":"+oriJson.startMinFri;
	contentsJson.fri.EndWork = friday+" "+oriJson.endTimeFri+":"+oriJson.endMinFri;
	contentsJson.fri.ReportContents = oriJson.reportContentsFri;
	contentsJson.fri.DailyRemarks = oriJson.dailyRemarksFri;
	
	return [reportJson,contentsJson];
}

