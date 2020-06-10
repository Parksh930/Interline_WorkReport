
/* input: (JSON)
 * return: [JSON,JSON]
 * eform에서 일률적으로 들어오는 1차원 제이슨 배열의 자료를 
 * report테이블과 report_main테이블의 형식으로 변환해 준다.
 * */
/*function makeJsonForUpdate(oriJson){
	var reportJson={
			"ReportNum":"",  
			  "UserNum":"",  
			  "UserName"  :"",
			  "Year"  :"",
			  "Month"  :"",
			  "UpdateDate"  :"", 
			  "State" :"", 
			  "SalesDay"  :"",
			  "WorkingDay"  :"",
			  "HolidayWorkingDay"  :"",
			  "AbsentDay"  :"",
			  "attendHour1"  :"",
			  "attendMinute1"  :"",
			  "offHour1"  :"",
			  "offMinute1"  :"",
			  "restHour1"  :"",
			  "restMinute1"  :"",
			  "netWorkingTime1"  :"",
			  "workContent1"  :"",
			  "attendHour2"  :"",
			  "attendMinute2"  :"",
			  "offHour2"  :"",
			  "offMinute2"  :"",
			  "restHour2"  :"",
			  "restMinute2"  :"",
			  "netWorkingTime2"  :"",
			  "workContent2"  :"",
			  "attendHour3"  :"",
			  "attendMinute3"  :"",
			  "offHour3"  :"",
			  "offMinute3"  :"",
			  "restHour3"  :"",
			  "restMinute3"  :"",
			  "netWorkingTime3"  :"",
			  "workContent3"  :"",
			  "attendHour4"  :"",
			  "attendMinute4"  :"",
			  "offHour4"  :"",
			  "offMinute4"  :"",
			  "restHour4"  :"",
			  "restMinute4"  :"",
			  "netWorkingTime4"  :"",
			  "workContent4"  :"",
			  "attendHour5"  :"",
			  "attendMinute5"  :"",
			  "offHour5"  :"",
			  "offMinute5"  :"",
			  "restHour5"  :"",
			  "restMinute5"  :"",
			  "netWorkingTime5"  :"",
			  "workContent5"  :"",
			  "attendHour6"  :"",
			  "attendMinute6"  :"",
			  "offHour6"  :"",
			  "offMinute6"  :"",
			  "restHour6"  :"",
			  "restMinute6"  :"",
			  "netWorkingTime6"  :"",
			  "workContent6"  :"",
			  "attendHour7"  :"",
			  "attendMinute7"  :"",
			  "offHour7"  :"",
			  "offMinute7"  :"",
			  "restHour7"  :"",
			  "restMinute7"  :"",
			  "netWorkingTime7"  :"",
			  "workContent7"  :"",
			  "attendHour8"  :"",
			  "attendMinute8"  :"",
			  "offHour8"  :"",
			  "offMinute8"  :"",
			  "restHour8"  :"",
			  "restMinute8"  :"",
			  "netWorkingTime8"  :"",
			  "workContent8"  :"",
			  "attendHour9"  :"",
			  "attendMinute9"  :"",
			  "offHour9"  :"",
			  "offMinute9"  :"",
			  "restHour9"  :"",
			  "restMinute9"  :"",
			  "netWorkingTime9"  :"",
			  "workContent9"  :"",
			  "attendHour10"  :"",
			  "attendMinute10"  :"",
			  "offHour10"  :"",
			  "offMinute10"  :"",
			  "restHour10"  :"",
			  "restMinute10"  :"",
			  "netWorkingTime10"  :"",
			  "workContent10"  :"",
			  "attendHour11"  :"",
			  "attendMinute11"  :"",
			  "offHour11"  :"",
			  "offMinute11"  :"",
			  "restHour11"  :"",
			  "restMinute11"  :"",
			  "netWorkingTime11"  :"",
			  "workContent11"  :"",
			  "attendHour12"  :"",
			  "attendMinute12"  :"",
			  "offHour12"  :"",
			  "offMinute12"  :"",
			  "restHour12"  :"",
			  "restMinute12"  :"",
			  "netWorkingTime12"  :"",
			  "workContent12"  :"",
			  "attendHour13"  :"",
			  "attendMinute13"  :"",
			  "offHour13"  :"",
			  "offMinute13"  :"",
			  "restHour13"  :"",
			  "restMinute13"  :"",
			  "netWorkingTime13"  :"",
			  "workContent13"  :"",
			  "attendHour14"  :"",
			  "attendMinute14"  :"",
			  "offHour14"  :"",
			  "offMinute14"  :"",
			  "restHour14"  :"",
			  "restMinute14"  :"",
			  "netWorkingTime14"  :"",
			  "workContent14"  :"",
			  "attendHour15"  :"",
			  "attendMinute15"  :"",
			  "offHour15"  :"",
			  "offMinute15"  :"",
			  "restHour15"  :"",
			  "restMinute15"  :"",
			  "netWorkingTime15"  :"",
			  "workContent15"  :"",
			  "attendHour16"  :"",
			  "attendMinute16"  :"",
			  "offHour16"  :"",
			  "offMinute16"  :"",
			  "restHour16"  :"",
			  "restMinute16"  :"",
			  "netWorkingTime16"  :"",
			  "workContent16"  :"",
			  "attendHour17"  :"",
			  "attendMinute17"  :"",
			  "offHour17"  :"",
			  "offMinute17"  :"",
			  "restHour17"  :"",
			  "restMinute17"  :"",
			  "netWorkingTime17"  :"",
			  "workContent17"  :"",
			  "attendHour18"  :"",
			  "attendMinute18"  :"",
			  "offHour18"  :"",
			  "offMinute18"  :"",
			  "restHour18"  :"",
			  "restMinute18"  :"",
			  "netWorkingTime18"  :"",
			  "workContent18"  :"",
			  "attendHour19"  :"",
			  "attendMinute19"  :"",
			  "offHour19"  :"",
			  "offMinute19"  :"",
			  "restHour19"  :"",
			  "restMinute19"  :"",
			  "netWorkingTime19"  :"",
			  "workContent19"  :"",
			  "attendHour20"  :"",
			  "attendMinute20"  :"",
			  "offHour20"  :"",
			  "offMinute20"  :"",
			  "restHour20"  :"",
			  "restMinute20"  :"",
			  "netWorkingTime20"  :"",
			  "workContent20"  :"",
			  "attendHour21"  :"",
			  "attendMinute21"  :"",
			  "offHour21"  :"",
			  "offMinute21"  :"",
			  "restHour21"  :"",
			  "restMinute21"  :"",
			  "netWorkingTime21"  :"",
			  "workContent21"  :"",
			  "attendHour22"  :"",
			  "attendMinute22"  :"",
			  "offHour22"  :"",
			  "offMinute22"  :"",
			  "restHour22"  :"",
			  "restMinute22"  :"",
			  "netWorkingTime22"  :"",
			  "workContent22"  :"",
			  "attendHour23"  :"",
			  "attendMinute23"  :"",
			  "offHour23"  :"",
			  "offMinute23"  :"",
			  "restHour23"  :"",
			  "restMinute23"  :"",
			  "netWorkingTime23"  :"",
			  "workContent23"  :"",
			  "attendHour24"  :"",
			  "attendMinute24"  :"",
			  "offHour24"  :"",
			  "offMinute24"  :"",
			  "restHour24"  :"",
			  "restMinute24"  :"",
			  "netWorkingTime24"  :"",
			  "workContent24"  :"",
			  "attendHour25"  :"",
			  "attendMinute25"  :"",
			  "offHour25"  :"",
			  "offMinute25"  :"",
			  "restHour25"  :"",
			  "restMinute25"  :"",
			  "netWorkingTime25"  :"",
			  "workContent25"  :"",
			  "attendHour26"  :"",
			  "attendMinute26"  :"",
			  "offHour26"  :"",
			  "offMinute26"  :"",
			  "restHour26"  :"",
			  "restMinute26"  :"",
			  "netWorkingTime26"  :"",
			  "workContent26"  :"",
			  "attendHour27"  :"",
			  "attendMinute27"  :"",
			  "offHour27"  :"",
			  "offMinute27"  :"",
			  "restHour27"  :"",
			  "restMinute27"  :"",
			  "netWorkingTime27"  :"",
			  "workContent27"  :"",
			  "attendHour28"  :"",
			  "attendMinute28"  :"",
			  "offHour28"  :"",
			  "offMinute28"  :"",
			  "restHour28"  :"",
			  "restMinute28"  :"",
			  "netWorkingTime28"  :"",
			  "workContent28"  :"",
			  "attendHour29"  :"",
			  "attendMinute29"  :"",
			  "offHour29"  :"",
			  "offMinute29"  :"",
			  "restHour29"  :"",
			  "restMinute29"  :"",
			  "netWorkingTime29"  :"",
			  "workContent29"  :"",
			  "attendHour30"  :"",
			  "attendMinute30"  :"",
			  "offHour30"  :"",
			  "offMinute30"  :"",
			  "restHour30"  :"",
			  "restMinute30"  :"",
			  "netWorkingTime30"  :"",
			  "workContent30"  :"",
			  "attendHour31"  :"",
			  "attendMinute31"  :"",
			  "offHour31"  :"",
			  "offMinute31"  :"",
			  "restHour31"  :"",
			  "restMinute31"  :"",
			  "netWorkingTime31"  :"",
			  "workContent31"  :"",
			  "sumWorkingTime"  :""

		}


	reportJson.ReportNum=oriJson.ReportNum;  
	reportJson.UserNum =oriJson.UserNum;  
	reportJson.UserName=oriJson.UserName;
	reportJson.Year=oriJson.Year;
	reportJson.Month=oriJson.Month;
	reportJson.UpdateDate=oriJson.UpdateDate; 
	reportJson.State=oriJson.State; 
	reportJson.SalesDay=oriJson.SalesDay;
	reportJson.WorkingDay=oriJson.WorkingDay;
	reportJson.HolidayWorkingDay=oriJson.HolidayWorkingDay;
	reportJson.AbsentDay=oriJson.AbsentDay;
	reportJson.attendHour1=oriJson.attendHour1;
	reportJson.attendMinute1=oriJson.attendMinute1;
	reportJson.offHour1=oriJson.offHour1;
	reportJson.offMinute1=oriJson.offMinute1;
	reportJson.restHour1=oriJson.restHour1;
	reportJson.restMinute1=oriJson.restMinute1;
	reportJson.netWorkingTime1=oriJson.netWorkingTime1;
	reportJson.workContent1=oriJson.workContent1;
	reportJson.attendHour2=oriJson.attendHour2;
	reportJson.attendMinute2=oriJson.attendMinute2;
	reportJson.offHour2=oriJson.offHour2;
	reportJson.offMinute2=oriJson.offMinute2;
	reportJson.restHour2=oriJson.restHour2;
	reportJson.restMinute2=oriJson.restMinute2;
	reportJson.netWorkingTime2=oriJson.netWorkingTime2;
	reportJson.workContent2=oriJson.workContent2;
	reportJson.attendHour3=oriJson.attendHour3;
	reportJson.attendMinute3=oriJson.attendMinute3;
	reportJson.offHour3=oriJson.offHour3;
	reportJson.offMinute3=oriJson.offMinute3;
	reportJson.restHour3=oriJson.restHour3;
	reportJson.restMinute3=oriJson.restMinute3;
	reportJson.netWorkingTime3=oriJson.netWorkingTime3;
	reportJson.workContent3=oriJson.workContent3;
	reportJson.attendHour4=oriJson.attendHour4;
	reportJson.attendMinute4=oriJson.attendMinute4;
	reportJson.offHour4=oriJson.offHour4;
	reportJson.offMinute4=oriJson.offMinute4;
	reportJson.restHour4=oriJson.restHour4;
	reportJson.restMinute4=oriJson.restMinute4;
	reportJson.netWorkingTime4=oriJson.netWorkingTime4;
	reportJson.workContent4=oriJson.workContent4;
	reportJson.attendHour5=oriJson.attendHour5;
	reportJson.attendMinute5=oriJson.attendMinute5;
	reportJson.offHour5=oriJson.offHour5;
	reportJson.offMinute5=oriJson.offMinute5;
	reportJson.restHour5=oriJson.restHour5;
	reportJson.restMinute5=oriJson.restMinute5;
	reportJson.netWorkingTime5=oriJson.netWorkingTime5;
	reportJson.workContent5=oriJson.workContent5;
	reportJson.attendHour6=oriJson.attendHour6;
	reportJson.attendMinute6=oriJson.attendMinute6;
	reportJson.offHour6=oriJson.offHour6;
	reportJson.offMinute6=oriJson.offMinute6;
	reportJson.restHour6=oriJson.restHour6;
	reportJson.restMinute6=oriJson.restMinute6;
	reportJson.netWorkingTime6=oriJson.netWorkingTime6;
	reportJson.workContent6=oriJson.workContent6;
	reportJson.attendHour7=oriJson.attendHour7;
	reportJson.attendMinute7=oriJson.attendMinute7;
	reportJson.offHour7=oriJson.offHour7;
	reportJson.offMinute7=oriJson.offMinute7;
	reportJson.restHour7=oriJson.restHour7;
	reportJson.restMinute7=oriJson.restMinute7;
	reportJson.netWorkingTime7=oriJson.netWorkingTime7;
	reportJson.workContent7=oriJson.workContent7;
	reportJson.attendHour8=oriJson.attendHour8;
	reportJson.attendMinute8=oriJson.attendMinute8;
	reportJson.offHour8=oriJson.offHour8;
	reportJson.offMinute8=oriJson.offMinute8;
	reportJson.restHour8=oriJson.restHour8;
	reportJson.restMinute8=oriJson.restMinute8;
	reportJson.netWorkingTime8=oriJson.netWorkingTime8;
	reportJson.workContent8=oriJson.workContent8;
	reportJson.attendHour9=oriJson.attendHour9;
	reportJson.attendMinute9=oriJson.attendMinute9;
	reportJson.offHour9=oriJson.offHour9;
	reportJson.offMinute9=oriJson.offMinute9;
	reportJson.restHour9=oriJson.restHour9;
	reportJson.restMinute9=oriJson.restMinute9;
	reportJson.netWorkingTime9=oriJson.netWorkingTime9;
	reportJson.workContent9=oriJson.workContent9;
	reportJson.attendHour10=oriJson.attendHour10;
	reportJson.attendMinute10=oriJson.attendMinute10;
	reportJson.offHour10=oriJson.offHour10;
	reportJson.offMinute10=oriJson.offMinute10;
	reportJson.restHour10=oriJson.restHour10;
	reportJson.restMinute10=oriJson.restMinute10;
	reportJson.netWorkingTime10=oriJson.netWorkingTime10;
	reportJson.workContent10=oriJson.workContent10;
	reportJson.attendHour11=oriJson.attendHour11;
	reportJson.attendMinute11=oriJson.attendMinute11;
	reportJson.offHour11=oriJson.offHour11;
	reportJson.offMinute11=oriJson.offMinute11;
	reportJson.restHour11=oriJson.restHour11;
	reportJson.restMinute11=oriJson.restMinute11;
	reportJson.netWorkingTime11=oriJson.netWorkingTime11;
	reportJson.workContent11=oriJson.workContent11;
	reportJson.attendHour12=oriJson.attendHour12;
	reportJson.attendMinute12=oriJson.attendMinute12;
	reportJson.offHour12=oriJson.offHour12;
	reportJson.offMinute12=oriJson.offMinute12;
	reportJson.restHour12=oriJson.restHour12;
	reportJson.restMinute12=oriJson.restMinute12;
	reportJson.netWorkingTime12=oriJson.netWorkingTime12;
	reportJson.workContent12=oriJson.workContent12;
	reportJson.attendHour13=oriJson.attendHour13;
	reportJson.attendMinute13=oriJson.attendMinute13;
	reportJson.offHour13=oriJson.offHour13;
	reportJson.offMinute13=oriJson.offMinute13;
	reportJson.restHour13=oriJson.restHour13;
	reportJson.restMinute13=oriJson.restMinute13;
	reportJson.netWorkingTime13=oriJson.netWorkingTime13;
	reportJson.workContent13=oriJson.workContent13;
	reportJson.attendHour14=oriJson.attendHour14;
	reportJson.attendMinute14=oriJson.attendMinute14;
	reportJson.offHour14=oriJson.offHour14;
	reportJson.offMinute14=oriJson.offMinute14;
	reportJson.restHour14=oriJson.restHour14;
	reportJson.restMinute14=oriJson.restMinute14;
	reportJson.netWorkingTime14=oriJson.netWorkingTime14;
	reportJson.workContent14=oriJson.workContent14;
	reportJson.attendHour15=oriJson.attendHour15;
	reportJson.attendMinute15=oriJson.attendMinute15;
	reportJson.offHour15=oriJson.offHour15;
	reportJson.offMinute15=oriJson.offMinute15;
	reportJson.restHour15=oriJson.restHour15;
	reportJson.restMinute15=oriJson.restMinute15;
	reportJson.netWorkingTime15=oriJson.netWorkingTime15;
	reportJson.workContent15=oriJson.workContent15;
	reportJson.attendHour16=oriJson.attendHour16;
	reportJson.attendMinute16=oriJson.attendMinute16;
	reportJson.offHour16=oriJson.offHour16;
	reportJson.offMinute16=oriJson.offMinute16;
	reportJson.restHour16=oriJson.restHour16;
	reportJson.restMinute16=oriJson.restMinute16;
	reportJson.netWorkingTime16=oriJson.netWorkingTime16;
	reportJson.workContent16=oriJson.workContent16;
	reportJson.attendHour17=oriJson.attendHour17;
	reportJson.attendMinute17=oriJson.attendMinute17;
	reportJson.offHour17=oriJson.offHour17;
	reportJson.offMinute17=oriJson.offMinute17;
	reportJson.restHour17=oriJson.restHour17;
	reportJson.restMinute17=oriJson.restMinute17;
	reportJson.netWorkingTime17=oriJson.netWorkingTime17;
	reportJson.workContent17=oriJson.workContent17;
	reportJson.attendHour18=oriJson.attendHour18;
	reportJson.attendMinute18=oriJson.attendMinute18;
	reportJson.offHour18=oriJson.offHour18;
	reportJson.offMinute18=oriJson.offMinute18;
	reportJson.restHour18=oriJson.restHour18;
	reportJson.restMinute18=oriJson.restMinute18;
	reportJson.netWorkingTime18=oriJson.netWorkingTime18;
	reportJson.workContent18=oriJson.workContent18;
	reportJson.attendHour19=oriJson.attendHour19;
	reportJson.attendMinute19=oriJson.attendMinute19;
	reportJson.offHour19=oriJson.offHour19;
	reportJson.offMinute19=oriJson.offMinute19;
	reportJson.restHour19=oriJson.restHour19;
	reportJson.restMinute19=oriJson.restMinute19;
	reportJson.netWorkingTime19=oriJson.netWorkingTime19;
	reportJson.workContent19=oriJson.workContent19;
	reportJson.attendHour20=oriJson.attendHour20;
	reportJson.attendMinute20=oriJson.attendMinute20;
	reportJson.offHour20=oriJson.offHour20;
	reportJson.offMinute20=oriJson.offMinute20;
	reportJson.restHour20=oriJson.restHour20;
	reportJson.restMinute20=oriJson.restMinute20;
	reportJson.netWorkingTime20=oriJson.netWorkingTime20;
	reportJson.workContent20=oriJson.workContent20;
	reportJson.attendHour21=oriJson.attendHour21;
	reportJson.attendMinute21=oriJson.attendMinute21;
	reportJson.offHour21=oriJson.offHour21;
	reportJson.offMinute21=oriJson.offMinute21;
	reportJson.restHour21=oriJson.restHour21;
	reportJson.restMinute21=oriJson.restMinute21;
	reportJson.netWorkingTime21=oriJson.netWorkingTime21;
	reportJson.workContent21=oriJson.workContent21;
	reportJson.attendHour22=oriJson.attendHour22;
	reportJson.attendMinute22=oriJson.attendMinute22;
	reportJson.offHour22=oriJson.offHour22;
	reportJson.offMinute22=oriJson.offMinute22;
	reportJson.restHour22=oriJson.restHour22;
	reportJson.restMinute22=oriJson.restMinute22;
	reportJson.netWorkingTime22=oriJson.netWorkingTime22;
	reportJson.workContent22=oriJson.workContent22;
	reportJson.attendHour23=oriJson.attendHour23;
	reportJson.attendMinute23=oriJson.attendMinute23;
	reportJson.offHour23=oriJson.offHour23;
	reportJson.offMinute23=oriJson.offMinute23;
	reportJson.restHour23=oriJson.restHour23;
	reportJson.restMinute23=oriJson.restMinute23;
	reportJson.netWorkingTime23=oriJson.netWorkingTime23;
	reportJson.workContent23=oriJson.workContent23;
	reportJson.attendHour24=oriJson.attendHour24;
	reportJson.attendMinute24=oriJson.attendMinute24;
	reportJson.offHour24=oriJson.offHour24;
	reportJson.offMinute24=oriJson.offMinute24;
	reportJson.restHour24=oriJson.restHour24;
	reportJson.restMinute24=oriJson.restMinute24;
	reportJson.netWorkingTime24=oriJson.netWorkingTime24;
	reportJson.workContent24=oriJson.workContent24;
	reportJson.attendHour25=oriJson.attendHour25;
	reportJson.attendMinute25=oriJson.attendMinute25;
	reportJson.offHour25=oriJson.offHour25;
	reportJson.offMinute25=oriJson.offMinute25;
	reportJson.restHour25=oriJson.restHour25;
	reportJson.restMinute25=oriJson.restMinute25;
	reportJson.netWorkingTime25=oriJson.netWorkingTime25;
	reportJson.workContent25=oriJson.workContent25;
	reportJson.attendHour26=oriJson.attendHour26;
	reportJson.attendMinute26=oriJson.attendMinute26;
	reportJson.offHour26=oriJson.offHour26;
	reportJson.offMinute26=oriJson.offMinute26;
	reportJson.restHour26=oriJson.restHour26;
	reportJson.restMinute26=oriJson.restMinute26;
	reportJson.netWorkingTime26=oriJson.netWorkingTime26;
	reportJson.workContent26=oriJson.workContent26;
	reportJson.attendHour27=oriJson.attendHour27;
	reportJson.attendMinute27=oriJson.attendMinute27;
	reportJson.offHour27=oriJson.offHour27;
	reportJson.offMinute27=oriJson.offMinute27;
	reportJson.restHour27=oriJson.restHour27;
	reportJson.restMinute27=oriJson.restMinute27;
	reportJson.netWorkingTime27=oriJson.netWorkingTime27;
	reportJson.workContent27=oriJson.workContent27;
	reportJson.attendHour28=oriJson.attendHour28;
	reportJson.attendMinute28=oriJson.attendMinute28;
	reportJson.offHour28=oriJson.offHour28;
	reportJson.offMinute28=oriJson.offMinute28;
	reportJson.restHour28=oriJson.restHour28;
	reportJson.restMinute28=oriJson.restMinute28;
	reportJson.netWorkingTime28=oriJson.netWorkingTime28;
	reportJson.workContent28=oriJson.workContent28;
	reportJson.attendHour29=oriJson.attendHour29;
	reportJson.attendMinute29=oriJson.attendMinute29;
	reportJson.offHour29=oriJson.offHour29;
	reportJson.offMinute29=oriJson.offMinute29;
	reportJson.restHour29=oriJson.restHour29;
	reportJson.restMinute29=oriJson.restMinute29;
	reportJson.netWorkingTime29=oriJson.netWorkingTime29;
	reportJson.workContent29=oriJson.workContent29;
	reportJson.attendHour30=oriJson.attendHour30;
	reportJson.attendMinute30=oriJson.attendMinute30;
	reportJson.offHour30=oriJson.offHour30;
	reportJson.offMinute30=oriJson.offMinute30;
	reportJson.restHour30=oriJson.restHour30;
	reportJson.restMinute30=oriJson.restMinute30;
	reportJson.netWorkingTime30=oriJson.netWorkingTime30;
	reportJson.workContent30=oriJson.workContent30;
	reportJson.attendHour31=oriJson.attendHour31;
	reportJson.attendMinute31=oriJson.attendMinute31;
	reportJson.offHour31=oriJson.offHour31;
	reportJson.offMinute31=oriJson.offMinute31;
	reportJson.restHour31=oriJson.restHour31;
	reportJson.restMinute31=oriJson.restMinute31;
	reportJson.netWorkingTime31=oriJson.netWorkingTime31;
	reportJson.workContent31=oriJson.workContent31;
	reportJson.sumWorkingTime=oriJson.sumWorkingTime;



	return reportJson;
}*/



//해당 달의 일수 구하는 합수
//parameter: 년(int 4) ,월(int 1||2)
//return: 해당월의 일수(int)
function getDatesNum(year,month){  
	var start = new Date(year+"-"+month+"-01");  
	if(month==12){
		var end = new Date((Number(start.getFullYear())+1)+"-01-01");
	}else{
		var end = new Date(start.getFullYear()+"-"+(month+1)+"-01");
	}

	var dates = (end.getTime() - start.getTime())/1000/60/60/24;  
	return dates;

}		


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



function changeSelectStateUp(reportNum,state){
	console.log(reportNum);


	$.ajax(
			{
				url: "selectReadStateUp",
				type: 'POST',
				data: {"reportNum":reportNum,"state":state},
				success: function(data){
					alert("承認を正常的に処理しました。");
					if(confirm("提出ボタンの変更はリロードしてから変わります。今すぐリロードされますか？")){
						location.reload(true);	
					}

					/*						if(confirm("承認を正常的に処理しました。提出ボタンの変更はリロードしてから変わります。今すぐリロードされますか？")){
								location.reload(true);	
							}
					 */					
				},
				error: function(e){
					alert('承認ができませんでした。もう一度お試し下さい。');
				}
			}		
	);
}

function changeSelectStateDown(reportNum,state){
	console.log(reportNum);

	$.ajax(
			{
				url: "selectReadStateDown",
				type: 'POST',
				data: {"reportNum":reportNum,"state":state},
				success: function(data){

					alert("取消が正常的に処理されました。");

					if(data==0){
						location.href = "reportList";
					}
					else{
						if(confirm("提出ボタンの変更はリロードしてから変わります。今すぐリロードされますか？")){
							location.reload(true);	
						}
					}
				},
				error: function(e){
					alert('取消ができませんでした。もう一度お試し下さい。');
				}
			}		
	);
}


function changeAllStateUp(reportNum,state){
	console.log(reportNum);

	$.ajax(
			{
				url: "allReadStateUp",
				type: 'POST',
				data: {"reportNum":reportNum,"state":state},
				success: function(data){
					alert("承認を正常的に処理しました。");
					if(confirm("提出ボタンの変更はリロードしてから変わります。今すぐリロードされますか？")){
						location.reload(true);	
					}

				},
				error: function(e){
					alert('取消ができませんでした。もう一度お試し下さい。');
				}
			}		
	);
}



function changeAllStateDown(reportNum,state){
	console.log(reportNum);

	$.ajax(
			{
				url: "allReadStateDown",
				type: 'POST',
				data: {"reportNum":reportNum,"state":state},
				success: function(data){
					alert("取消が正常的に処理されました。");

					if(data==0){
						location.href = "reportList";
					}
					else{
						if(confirm("提出ボタンの変更はリロードしてから変わります。今すぐリロードされますか？")){
							location.reload(true);	
						}
					}						
				},
				error: function(e){
					alert('取消ができませんでした。もう一度お試し下さい。');
				}
			}		
	);
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




	//var dates = getDatesNum(jsonData.year,jsonData.month);  // 날짜계산이 잘 적용되지 않아 추후 시도 예정

	/*for (var i=parseInt(dates)+1 ; i<=31 ; i++){
		jsonData["attendHour"+i]=0;
		jsonData["attendMinute"+i]=0;
		jsonData["offHour"+i]=0;
		jsonData["offMinute"+i]=0;
		jsonData["restHour"+i]=0;
		jsonData["restMinute"+i]=0;
		jsonData["netWorkingTime"+i]="0:00";
		jsonData["workContent"+i]="-";
	}*/


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
					alert("修正を完了しました。")
					location.href="getUpdateReport?reportNum="+reportNum;
				},
				error: function(e){
					console.log(JSON.stringify(e));
					alert('修正ができませんでした。もう一度お試して下さい。');
				}
			}		
	);
}


