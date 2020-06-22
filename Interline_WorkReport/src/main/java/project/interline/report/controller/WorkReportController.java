package project.interline.report.controller;


import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import project.interline.report.dao.WorkReportDAO;
import project.interline.report.vo.ReportListVO;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkReportVO;

@Controller
public class WorkReportController {
	private static final Logger logger = LoggerFactory.getLogger(WorkReportController.class);
	
	@Autowired
	WorkReportDAO dao;
	
	
	//
	@RequestMapping(value = "/user/writeReport", method = RequestMethod.POST)
	public String writeReport(Model model, int month, int year, int userNum) { //int month,int year,int userNum을 POST로 받아와야한다. 메서드도 POST로 나중에 고칠것
		logger.debug("writeReport");
		HashMap<String, Integer> map= new HashMap<String, Integer>();
		
		ArrayList<WorkReportVO> newEmployeeThisMonthReport = new ArrayList(); 
		model.addAttribute("userNum", userNum);
		
		int checkNewEmployee = dao.checkNewEmployee(userNum);
		System.out.println("checkNewEmployee:"+checkNewEmployee);
		if(checkNewEmployee==0 ||checkNewEmployee==1) {
			//신입사원입니다.
			System.out.println("신입사원입니다.");
			if (checkNewEmployee==0) {
				model.addAttribute("month", month);
				model.addAttribute("year", year);
				return "Report/writeReport";
			} 
			if (checkNewEmployee==1) {
				map.put("userNum", userNum);
				map.put("year", year);
				map.put("month", month);
				newEmployeeThisMonthReport=dao.checkState2(map);
				if (newEmployeeThisMonthReport.size()==1) {
					System.out.println("신입사원 이번달 작성중인게 있음.");
					model.addAttribute("month", month);
					model.addAttribute("year", year);
					ObjectMapper newobjectMapper= new ObjectMapper();
					String newreportJSON="";
					try {
						newreportJSON = newobjectMapper.writeValueAsString(newEmployeeThisMonthReport.get(0));
					} catch (JsonProcessingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println("신입사원 이번달 작성중인게 있음.로딩"+newreportJSON);
					if (newEmployeeThisMonthReport.get(0).getState()!=0) { //이번달 쓰던게 있고 제출이상의 상태면 로딩불가
						model.addAttribute("reportJSON", "submitted");
						return "Report/writeReport";
					}
					model.addAttribute("reportJSON", newreportJSON);
					
					
					return "Report/writeReport";
				}
			}
			
		}
		
		//저번달 작성분 확인
		ArrayList<WorkReportVO> lastMonthReport = new ArrayList(); 
		if (month==1) {
			map.put("userNum", userNum);
			map.put("year", year-1);
			map.put("month", 12);//자바스크립트에서 그냥오면 month는 0으로 시작하므로 주의!
		}else {
			map.put("userNum", userNum);
			map.put("year", year);
			map.put("month", month-1);//자바스크립트에서 그냥오면 month는 0으로 시작하므로 주의!
		}
		
		
		lastMonthReport=dao.checkState2(map);
		switch (lastMonthReport.size()) {
		case 0://전달게 아예 존제하지 않음. 전달걸 모델에담아 보낸다.
			System.out.println("저번달 근무표내용이 없어 저번달의 새로운 근무표를 로딩합니다.");
			model.addAttribute("month", map.get("month"));
			model.addAttribute("year", map.get("year"));
			break;
		case 1://전달게 존재함.
			//state를 확인하여 0이면 전달거+저장내용 모델에담아 보냄.
			//0이 아니면 이번달걸 모델에담아 보냄.
			if (lastMonthReport.get(0).getState()==0) {
				model.addAttribute("month", map.get("month"));
				model.addAttribute("year", map.get("year"));
				//저장내용 JSON스트링파이
				ObjectMapper objectMapper= new ObjectMapper();
				String reportJSON="";
				try {
					reportJSON = objectMapper.writeValueAsString(lastMonthReport.get(0));
				} catch (JsonProcessingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("저번달 저장분이 제출이안되어 저번달껄 로딩합니다."+reportJSON);
				model.addAttribute("reportJSON", reportJSON);
			}else {//전달게 존재하나 이미 제출 상태임. 따라서 이번달껄 등록해야함. 
				System.out.println("지난달 제출분 확인 완료.");
				model.addAttribute("month", month);
				model.addAttribute("year", year);
				ArrayList<WorkReportVO> thisMonthReport = new ArrayList(); 
				map.put("userNum", userNum);
				map.put("year", year);
				map.put("month", month);
				thisMonthReport=dao.checkState2(map);
				if (thisMonthReport.size()==1 && thisMonthReport.get(0).getState()==0) { //이번달 쓰던게 있고 보존상태면 이번달 저장분을 로딩
					//저장내용 JSON스트링파이
					ObjectMapper objectMapper= new ObjectMapper();
					String reportJSON="";
					try {
						reportJSON = objectMapper.writeValueAsString(thisMonthReport.get(0));
					} catch (JsonProcessingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println("이번달 저장분이있어 로딩합니다."+reportJSON);
					model.addAttribute("reportJSON", reportJSON);
				}else if (thisMonthReport.size()==1 && thisMonthReport.get(0).getState()!=0) { //이번달 쓰던게 있고 제출이상의 상태면 로딩불가
					model.addAttribute("reportJSON", "submitted");
					System.out.println("이번달 근무표는 이미 제출 완료되었습니다.");
				}else {                                                            //이번달 쓰던게 없으면 이번달걸 새로 작성
					System.out.println("이번달 저장분이없어 새로 로딩합니다.");					
				}
			}
			break;
		default:
			break;
		}
		
		//response.addHeader("Access-Control-Allow-Origin", "*");
		//response.setHeader("Access-Control-Allow-Origin", "*");
		return "Report/writeReport";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/user/saveReport", method = RequestMethod.POST)
	public int saveReport(Model model, WorkReportVO workReportVO ) {
		logger.debug(workReportVO.toString());
		int result=0;
		HashMap<String, Object> map= new HashMap<String, Object>();
		map.put("userNum", workReportVO.getUserNum());
		map.put("year", workReportVO.getYear());
		map.put("month", workReportVO.getMonth());
		
		ArrayList<Integer> reportNum = new ArrayList(); 
		reportNum=dao.isItNew(map);
		if (reportNum.size()!=0) {
			System.out.println("reportNum="+reportNum.get(0));
			int state = dao.checkState(reportNum.get(0));
			System.out.println("state="+state);
			if (state != 0 && state != 5 && state != 6) {
				System.out.println("aleady submitted:state("+state+")");
				return 3; //aleady submitted!
			}
			workReportVO.setReportNum(reportNum.get(0));
			result=dao.updateReport(workReportVO); //성공시0
			
			if (workReportVO.getState()==1) { 
				dao.lastUpdateDate(workReportVO.getUserNum());
			}
			
			return result;
		}
		
		
		
		result=dao.insertReport(workReportVO); //성공시1
		if (workReportVO.getState()==1) {
			//유저의 최종 보고일 업데이트 해주기
		}
		System.out.println(result);
		
		return result;
	}
	
	@RequestMapping(value="/admin/reportList", method = RequestMethod.GET)
	public String reportListForm(Model model) {

		return "Report/workReportList";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/reportList", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ArrayList<ReportListVO> reportList(){
		
		ArrayList<ReportListVO> reportList = dao.getReportList();
		
		System.out.println("reportList 의 결과값 !!!  "+reportList);
		
		logger.debug("reportList:{}",reportList);

		return reportList;
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/report_Filter", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ArrayList<ReportListVO> reportFilter(String[] team, String team_others
												,String report_userNum,String report_userName
												,String report_FromReportDays,String report_ToReportDays){
		logger.debug("from:{}, to:{}",report_FromReportDays,report_ToReportDays);
		
		ArrayList<ReportListVO> list = dao.reportFilter(team,team_others,report_userNum,report_userName,report_FromReportDays,report_ToReportDays);
		return list;
	}
	
	@RequestMapping(value="/admin/getReadReport", method = RequestMethod.GET)
	public String workReadReport(WorkReportVO vo,Model model) {
		WorkReportVO getReadVO = dao.getWorkReportVO(vo);
		logger.debug("getVO:{}",getReadVO);
		model.addAttribute("vo",getReadVO);
		return "Report/readWorkReport";
	}
	
	@RequestMapping(value="/admin/getReadReport2", method = RequestMethod.GET)
	public String workReadReport(Model model, String arrNumber) {
		model.addAttribute("arrNumber",arrNumber);
		return "Report/readWorkReport2";
	}
	

	@RequestMapping(value="/admin/getAllReport", method = RequestMethod.GET)
	public String getAllReport(WorkReportVO vo,Model model) {
		WorkReportVO getReadVO = dao.getWorkReportVO(vo);
		model.addAttribute("vo",getReadVO);
		return "Report/readWorkReport3";
	}
	
	
	@RequestMapping(value="/admin/getUpdateReport", method = RequestMethod.GET)
	public String getUpdateReport(WorkReportVO vo,Model model) {
		WorkReportVO getReadVO = dao.getWorkReportVO(vo);
		model.addAttribute("vo",getReadVO);
		return "Report/updateWorkReport";
	}
	
	
	
	@RequestMapping(value="/admin/deleteReport", method = RequestMethod.GET)
	public String deleteReport(WorkReportVO vo,Model model) {
		int result = dao.deleteReport(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("삭제결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	
	
	@RequestMapping(value = "/admin/adminUpdateReport", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public String submitReport(
			Model model, /* String updateJsonReport, */
			 HttpSession session,WorkReportVO workReportVO) {
		
		System.out.println("어드민으로 왔습니까? VO : "+workReportVO);
		
		
		int result = dao.updateReport2(workReportVO);
		
		System.out.println("어드민 업데이트result: "+result); // 0 이 성공
		System.out.println("update after  VO : "+workReportVO);
		
		
		return "success";
	}
	
	
	@RequestMapping(value="/user/myReport", method = RequestMethod.GET)
	public String myReport(Model model, HttpSession session ,int reportNum) {
		
		UserVO userVO=(UserVO)session.getAttribute("user_inform");
		WorkReportVO workReport=new WorkReportVO();
		workReport.setUserNum(userVO.getUserNum());
		workReport.setReportNum(reportNum);
		
		workReport=dao.getMyReport(workReport);
		
		//저장내용 JSON스트링파이
		ObjectMapper objectMapper= new ObjectMapper();
		String reportJSON="";
		if (workReport.getUserName()==null||workReport.getUserName().equals("")) {
			model.addAttribute("reportJSON", "none");
			return "Report/readMyReport";
		}
		try {
			reportJSON = objectMapper.writeValueAsString(workReport);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("reportJSON", reportJSON);
		
		return "Report/readMyReport";
	}
	
	@RequestMapping(value = "/user/correctMyReport", method = RequestMethod.GET)
	public String correctMyReport(Model model,HttpSession session , int reportNum) {
		logger.debug("correctMyReport");
		UserVO userVO=(UserVO)session.getAttribute("user_inform");
		WorkReportVO workReport=new WorkReportVO();
		workReport.setUserNum(userVO.getUserNum());
		workReport.setReportNum(reportNum);
		workReport=dao.getMyReport(workReport);
		System.out.println("userNum="+workReport.getUserNum());
		//저장내용 JSON스트링파이
		ObjectMapper objectMapper= new ObjectMapper();
		String reportJSON="";
		if (workReport.getUserName()==null||workReport.getUserName().equals("")) {
			model.addAttribute("reportJSON", "none");
			return "Report/readMyReport";
		}
		try {
			reportJSON = objectMapper.writeValueAsString(workReport);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("reportJSON", reportJSON);
		model.addAttribute("month", workReport.getMonth());
		model.addAttribute("year", workReport.getYear());
		model.addAttribute("userNum", workReport.getUserNum());
		
		
		return "Report/correctMyReport";
	}
	

	@RequestMapping(value="/admin/stateUp", method = {RequestMethod.GET,RequestMethod.POST})
	public String stateUp(WorkReportVO vo,Model model) {
		int result = dao.updateState(vo);
		logger.debug("getVO:{}",result);
		System.out.println("stateUp 결과   " + result);
		return "redirect:/admin/reportList";

	}
	
	
	@RequestMapping(value="/admin/reportSelectApproval", method = RequestMethod.GET)
	public String reportSelectApproval(Model model, String arrNumber) {
		System.out.println("번호 잘 찾아왔나?  "  +  arrNumber);
		System.out.println(" arrNumber  java  data 타입은 ?    "+arrNumber.getClass().getName());
		String[] arr =  arrNumber.split(",");
		System.out.println("arr  java   data  타입은 ?    "+arr.getClass().getName());
		WorkReportVO vo = new WorkReportVO();
		String num;
		int intNum;
		for(int i=0; i<=arr.length-1; i++) {
			num = arr[i];
			System.out.println(" selectReport  num  : "  +  num);
			intNum = Integer.parseInt(num);
			vo = dao.selectReport(intNum);
			System.out.println(" 검색 되었나? selectReport  vo  : "  +  vo);
			int result = dao.updateState(vo);
			System.out.println("수정되었나?  result "  +  result);
		}
	//	int result = dao.reportSelectApproval(arr);  // forEach 용 하지만 나중에...
		return "redirect:/admin/reportList";
	}
	
	
	@RequestMapping(value="/admin/reportSelectDelete", method = RequestMethod.GET)
	public String reportSelectDelete(Model model, String arrNumber) {

		System.out.println("번호 잘 찾아왔나?  "  +  arrNumber);
		
		int result = dao.reportSelectDelete(arrNumber);
		
		System.out.println("reportSelectDelete 의 결과값    " + result);
		
		return "redirect:/admin/reportList";
	}
	
	
	
	
}
