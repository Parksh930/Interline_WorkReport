
	


function getDateNum2(year,month){  
	var dates;
	if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
		dates = 31;
	}
	else if(month==4||month==6||month==9||month==11){
		dates = 30;
	}
	else if(month==2){
		if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
			dates = 29;
		}
		else{
			dates = 28;
		}
	}

	return dates+1;

}






function adminUpdateReport(jsonData,address){
	for (var i=1 ; i<=31 ; i++){
		if(jsonData["attendHour"+i]==""||["attendHour"+i]==null||["attendHour"+i]==undefined||["attendHour"+i]=='\"\"'){	
			jsonData["attendHour"+i]=0;
		}
		if(jsonData["attendMinute"+i]==""||["attendMinute"+i]==null||["attendMinute"+i]==undefined||["attendMinute"+i]=='\"\"'){
			jsonData["attendMinute"+i]=0;
		}
		if(jsonData["offHour"+i]==""||["offHour"+i]==null||["offHour"+i]==undefined||["offHour"+i]=='\"\"'){
			jsonData["offHour"+i]=0;
		}
		if(jsonData["offMinute"+i]==""||["offMinute"+i]==null||["offMinute"+i]==undefined||["offMinute"+i]=='\"\"'){
			jsonData["offMinute"+i]=0;
		}
		if(jsonData["restHour"+i]==""||["restHour"+i]==null||["restHour"+i]==undefined||["restHour"+i]=='\"\"'){
			jsonData["restHour"+i]=0;
		}
		if(jsonData["restMinute"+i]==""||["restMinute"+i]==null||["restMinute"+i]==undefined||["restMinute"+i]=='\"\"'){
			jsonData["restMinute"+i]=0;
		}
	}




	console.log(jsonData.year);
	console.log(jsonData.month);

	var dates = getDateNum2(jsonData.year,jsonData.month);

	console.log(dates);

	for (var i=dates; i<=31 ; i++){
		jsonData["attendHour"+i]=0;
		jsonData["attendMinute"+i]=0;
		jsonData["offHour"+i]=0;
		jsonData["offMinute"+i]=0;
		jsonData["restHour"+i]=0;
		jsonData["restMinute"+i]=0;
		jsonData["netWorkingTime"+i]="0:00";
		jsonData["workContent"+i]="-";
	}

	console.log(JSON.stringify(jsonData));

	var reportNum = jsonData.reportNum;

	console.log(reportNum);

	$.ajax(
			{
				url: address,
				type: 'POST',
				data: JSON.parse(JSON.stringify(jsonData)),
				success: function(data){
					alert("修正を完了しました。");
					location.href="getUpdateReport?reportNum="+reportNum;
				},
				error: function(e){
					console.log(JSON.stringify(e));
					alert('修正に失敗しました。もう一度お試して下さい。');
				}
			}		
	);
}




