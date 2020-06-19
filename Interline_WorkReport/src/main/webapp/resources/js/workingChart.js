//일본 공휴일배열을 리턴하는 함수
//parameter: 없음
//return: 함수 실행 시점 년도의 공휴일배열    예)
	//10월의 둘째주 월요일 계산
	function getThirdMondayOnJLY(year){	
		var today = new Date(year+'/07/01').getDay();
		console.log("year:"+year);
		console.log("1일의 요일:"+today);
		if(1-today<0){ return(23-today); }else{ return(16-today); }
	}

	function getSecondMondayOnOCT(year){	
		var today = new Date(year+'/10/01').getDay();
		if(1-today<0){ return(16-today); }else{ return(9-today); }
	}
	
	function getThirdMondayOnSEP(year){	
		var today = new Date(year+'/09/01').getDay();
		console.log("year:"+year);
		console.log("1일의 요일:"+today);
		if(1-today<0){ return(23-today); }else{ return(16-today); }
	}
	
	
	//대체공휴일 추가
	function alternativeHoliday(year){
		for(var i=0 ; i < holiday.holiday.length ; i++){ 
					for(var j=0 ; j < holiday.holiday[i].length ; j++){
				theDate = holiday.holiday[i][j];
				theDay=new Date(year+"/"+i+"/"+theDate);
				console.log(theDay);
				if(theDay.getDay()==0){
					while(holiday.holiday[i].includes(++theDate)==true){	}
					holiday.holiday[i].push(theDate);
				}
			}
		}		
	}
	
	
//해당 달의 일수 구하는 합수
//parameter: 년(int 4) ,월(int 1||2)
//return: 해당월의 일수(int)
	function getDates(year,month){  
		var start = new Date(year+"/"+month+"/01"); 
		if(month==12){
			var end = new Date((Number(start.getFullYear())+1)+"/01/01");
		}else{
			var end = new Date(start.getFullYear()+"/"+(month+1)+"/01");
		}
		
		var dates = (end.getTime() - start.getTime())/1000/60/60/24;  
		return dates;
	}		


//해당 월의 dayDelay를 구하는 함수      ****** (해당일+dayDelay)%7을하면 그날의 요일이나옴.
//parameter: 년(int 4) ,월(int 1||2)
//return: 1일 일요일인 기준으로, 해당 달의 1일의 요일차(int)
//일요일:0, 월요일:1, 화요일:2, ... 토요일:6 임. 
	function getDayDelay(year,month){
		var firstOfThisMonth = new Date(year+"/"+month+"/01");
		console.log("firstOfThisMonth:"+firstOfThisMonth.getDay());
		return (firstOfThisMonth.getDay()-1);
	}
	
	
	
//근무일count
//parameter: workingChart.ozr 로부터 GetInputJason으로 얻어온 제이슨데이터 (JSON)  
//return: [평일 근무일(int), 휴일 근무일(int)]
	function countWorkingDay(jsonData){
		var numberOfDate=parseInt(jsonData.numberOfDate);
		var countNormalWork=0;
		var countHolidayWork=0;
		var thisMonth=parseInt(jsonData.month);
		for ( var i=1 ; i<=numberOfDate ; i++){
			if( jsonData["onoff"+i] == "1" && jsonData["dateCondition"+i]!="無休" ){
				if( jsonData["dateCondition"+i]=="休日" ){
					countHolidayWork++
				}else{
					countNormalWork++					
				}
			}
		}
		return [countNormalWork,countHolidayWork];
	}

//결근count
//parameter: workingChart.ozr 로부터 GetInputJason으로 얻어온 제이슨데이터 (JSON)
//return: int
	function absent(jsonData){
		var cnt=0;
		//var salesDayArray=jsonData.salesDayArray.split(",");
		//for( var i=0 ; i < salesDayArray.length ; i++ ){
		for (var i=1 ; i<=parseInt(jsonData.numberOfDate) ; i++){
			if (jsonData["dateCondition"+i]=="無休" || jsonData["onoff"+i] == "0" && jsonData["dateCondition"+i]=="平日" ){
				cnt++;
			}
		}
		return cnt;
	}
	
	
//총 근무시간 count
//parameter:
//return: "시간:분" (string)
	function sumWorkingTime(jsonData){
		var numberOfDate=parseInt(jsonData.numberOfDate);
		var hour=0;
		var minute=0;
		for ( var i=1 ; i<=numberOfDate ; i++){
			hour=hour+parseInt(jsonData["netWorkingTimeHour"+i]);
			minute=minute+parseInt(jsonData["netWorkingTimeMinute"+i]);
		}
		hour=hour+(parseInt(minute/60));
		minute=minute%60;
		return hour+":"+minute;
	}

	
	
//Submit함수
//paremeter: OZ로부터 추출한 데이터(JSON),url(string),type(int)
//return:none
// 저장을 시도하고 임시보존, 제출, 결과, 에러상황등을 화면에 표시해준다.
// type에는 0:보존 ,  1:제출
	function submitReport(jsonData,address,type){
		//없는날짜에 0으로 채워서
		for (var i=parseInt(jsonData.numberOfDate)+1 ; i<=31 ; i++){
			jsonData["attendHour"+i]=0;
			jsonData["attendMinute"+i]=0;
			jsonData["offHour"+i]=0;
			jsonData["offMinute"+i]=0;
			jsonData["restHour"+i]=0;
			jsonData["restMinute"+i]=0;
			jsonData["netWorkingTimeHour"+i]=0;
			jsonData["netWorkingTimeMinute"+i]=0;
			jsonData["workContent"+i]="";
		}
		//제출의 경우엔 일하지않은날(근무시간이0)에는 시간을 모두 0으로.default값을 0으로 바꾸기위함. 보존이 아닌경우는 결근이나 근무내용이없는경우 시간을 전부 0으로
		if(type==0){
			jsonData["attendHour"+i]=parseInt(jsonData["attendHour"+i]);
			jsonData["attendMinute"+i]=parseInt(jsonData["attendMinute"+i]);
			jsonData["offHour"+i]=parseInt(jsonData["offHour"+i]);
			jsonData["offMinute"+i]=parseInt(jsonData["offMinute"+i]);
			jsonData["restHour"+i]=parseInt(jsonData["restHour"+i]);
			jsonData["restMinute"+i]=parseInt(jsonData["restMinute"+i]);
			jsonData["netWorkingTime"+i]=jsonData["netWorkingTimeHour"+i] + ":" + jsonData["netWorkingTimeMinute"+i];
		}
		if(type==1){
			for (var i=1 ; i<=parseInt(jsonData.numberOfDate) ; i++){
				if (jsonData["netWorkingTimeHour"+i] == "0" && jsonData["netWorkingTimeMinute"+i] == "00") {
					jsonData["attendHour"+i]=0;
					jsonData["attendMinute"+i]=0;
					jsonData["offHour"+i]=0;
					jsonData["offMinute"+i]=0;
					jsonData["restHour"+i]=0;
					jsonData["restMinute"+i]=0;
				}
				jsonData["attendHour"+i]=parseInt(jsonData["attendHour"+i]);
				jsonData["attendMinute"+i]=parseInt(jsonData["attendMinute"+i]);
				jsonData["offHour"+i]=parseInt(jsonData["offHour"+i]);
				jsonData["offMinute"+i]=parseInt(jsonData["offMinute"+i]);
				jsonData["restHour"+i]=parseInt(jsonData["restHour"+i]);
				jsonData["restMinute"+i]=parseInt(jsonData["restMinute"+i]);
				jsonData["netWorkingTime"+i]=jsonData["netWorkingTimeHour"+i] + ":" + jsonData["netWorkingTimeMinute"+i];
			}
		}
		console.log(JSON.stringify(jsonData));
		if (type==1) confirm("提出すると修正できません。よろしいでしょうか。");
		
		$.ajax(
				{
					url: address,
					type: 'POST',
					data: JSON.parse(JSON.stringify(jsonData)),
					success: function(s){
							var text=["成功","成功","報告書重複 管理者にお問い合わせてください","提出したのは修正できません。"];
							alert(text[s]);
							location.href="userMain";
						},
					error: function(e){
							console.log(JSON.stringify(e));
							alert('失敗 管理者にお問い合わせてください');
						}
				}		
			);
	}
	
	
	function closePage(){
		self.close();
	}
	