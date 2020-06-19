function sayHello(){
	_MessageBox("Hello");
}


//출퇴휴시간,내용을 조정시 시간을 계산하여 근무시간산출
var calculateWorkingTime=function(index){
	var timeDiff=parseInt(GetInputComponent("offHour"+index).GetValue())-parseInt(GetInputComponent("attendHour"+index).GetValue());
	var minuteDiff=parseInt(GetInputComponent("offMinute"+index).GetValue())-parseInt(GetInputComponent("attendMinute"+index).GetValue());
	if(minuteDiff<0){
		minuteDiff=60+minuteDiff;
		timeDiff--;
	}

	timeDiff=timeDiff-parseInt(GetInputComponent("restHour"+index).GetValue());
	minuteDiff=minuteDiff-parseInt(GetInputComponent("restMinute"+index).GetValue());
	if(minuteDiff<0){
		minuteDiff=60+minuteDiff;
		timeDiff--;
	}
	if(minuteDiff==0)minuteDiff="00";
	GetInputComponent("netWorkingTimeHour"+index).SetText(timeDiff);
	GetInputComponent("netWorkingTimeMinute"+index).SetText(minuteDiff);
}


//출퇴휴시간,내용을 조정시 배경색 및 글자색 조정. 근무시간이 0이되면  off   근무시간이0&&휴일이면 off+글자도안보이게
var changeBackgroundColor=function(index){
	var bgComponent = GetInputComponent("bg"+index);
	var onoffComponent = GetInputComponent("onoff"+index);
	var hourComponent = GetInputComponent("netWorkingTimeHour"+index);
	var dotComponent = GetInputComponent("netWorkingTimeDot"+index);
	var minuteComponent = GetInputComponent("netWorkingTimeMinute"+index);

	hourComponent.SetTextColor("0,0,0");
	dotComponent.SetTextColor("0,0,0");
	minuteComponent.SetTextColor("0,0,0");

	var text=onoffComponent.GetText();
	if(text=="1"){
		if( hourComponent.GetText()=="0" && minuteComponent.GetText()=="00" ){
			hourComponent.SetTextColor("225,225,225");
			dotComponent.SetTextColor("225,225,225");
			minuteComponent.SetTextColor("225,225,225");
			onoffComponent.SetValue("0");
			bgComponent.SetBackgroundColor("225,225,225");
		}
	}
	if(text=="0"){
		hourComponent.SetTextColor("0,0,0");
		dotComponent.SetTextColor("0,0,0");
		minuteComponent.SetTextColor("0,0,0");
		bgComponent.SetBackgroundColor("255,255,255");
		onoffComponent.SetValue("1");
	}
}

//영업일 카운트
var countSalesDayOZR=function(){
	var row = GetDataSetValue("OZFormParam.row");
	var cnt=0;
	var salesDayArray=new Array();
	for(var i=1 ; i<=row ; i++){
		if( GetInputComponent("dateCondition"+i).GetSelectedItemText()!="休日"){ 
			salesDayArray.push(i);
			cnt++;
		}	
	}
	GetInputComponent("salesDay").SetText(cnt);
	GetInputComponent("salesDayArray").SetText(salesDayArray);
}