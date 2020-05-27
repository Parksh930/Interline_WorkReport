//일본 공휴일배열을 리턴하는 함수
//parameter: 없음
//return: 함수 실행 시점 년도의 공휴일배열    예)
	//10월의 둘째주 월요일 계산
	function getSecondMondayOnOCT(year){	
		var today = new Date(year+'-10-01').getDay();
		if(1-today<0){ return(16-today); }else{ return(9-today); }
	}
	
	
	//대체공휴일 추가
	function alternativeHoliday(year){
		for(var i=0 ; i < holiday.holiday.length ; i++){ 
					for(var j=0 ; j < holiday.holiday[i].length ; j++){
				theDate = holiday.holiday[i][j];
				theDay=new Date(year+"-"+i+"-"+theDate);
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
		var start = new Date(year+"-"+month+"-01");  
		if(month==12){
			var end = new Date((Number(start.getFullYear())+1)+"-01-01");
		}else{
			var end = new Date(start.getFullYear()+"-"+(month+1)+"-01");
		}
		
		var dates = (end.getTime() - start.getTime())/1000/60/60/24;  
		return dates;
	}		


//해당 월의 dayDelay를 구하는 함수      ****** (해당일+dayDelay)%7을하면 그날의 요일이나옴.
//parameter: 년(int 4) ,월(int 1||2)
//return: 1일 일요일인 달과, 해당 달의 1일의 요일차(int)
//일요일:0, 월요일:1, 화요일:2, ... 토요일:6 임. 
	function getDayDelay(year,month){
		var firstOfThisMonth = new Date(year+"-"+month+"-01");
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
			if( jsonData["content"+i] != "-" ){
				if( jsonData["day"+i]=="土" || jsonData["day"+i]=="日" || holiday.holiday[thisMonth].includes(parseInt(jsonData["date"+i])) ){
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
		var salesDayArray=jsonData.salesDayArray.split(",");
		for( var i=0 ; i < salesDayArray.length ; i++ ){
			if (jsonData["content"+salesDayArray[i]]=="-"){
				cnt++
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
			if ( jsonData["content"+i] != "-" ){
				var time = jsonData["netWorkingTime"+i].split(':');
				hour=hour+parseInt(time[0]);
				minute=minute+parseInt(time[1]);
			}
		}
		hour=hour+(minute/60);
		minute=minute%60;
		return hour+":"+minute;
	}

	
	
//Submit함수
//paremeter: OZ로부터 추출한 데이터(JSON),url(string),type(int)
//return:
// type에는 0:save ,  1:submit
//콘트롤러 logger에 보면 한글도 잘나옴.  근데 버튼2를 보면 한글이 깨져서 응답된다. 근데 ajax에서 text로 받으면 깨짐. 컨트롤러에서 리턴할때 utf-8로 인코딩 되지 않은 상태기때문에 success함수의 매개변수가 받을때 utf-8의 상태가 아닌 문자열이 된다.
//따라서, 컨트롤러에서 다시 UTF-8로 지정해줘야함. 리퀘스트매핑 변수에  produces="appliction/json;charset=UTF-8" 를 추가해준다. 반대로 json으로 받을때는 produces="appliction/json;charset=UTF-8"가 충돌한다(?)
	function submitReport(jsonData,address,type){
		if (type==1) confirm("提出すると修正できません。よろしいでしょうか。");
		var text=["保存","提出"];
		$.ajax(
				{
					url: address,
					type: 'post',
					data: jsonData,
					success: function(){
							alert(text[type]+'成功');
							location.href="../";
						},
					error: function(e){
							console.log(JSON.stringify(e));
							alert(text[type]+'失敗');
						}
				}		
			);
	}
	