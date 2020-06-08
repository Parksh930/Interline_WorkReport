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
	public String writeReport(Model model,int month,int year,int userNum) { //int month,int year,int userNum을 POST로 받아와야한다. 메서드도 POST로 나중에 고칠것
		logger.debug("writeReport");
		model.addAttribute("userNum", userNum);
		
		//저번달 작성분 확인
		HashMap<String, Integer> map= new HashMap<String, Integer>();
		if (month==1) {
			map.put("userNum", userNum);
			map.put("year", year-1);
			map.put("month", 12);//자바스크립트에서 그냥오면 month는 0으로 시작하므로 주의!
		}else {
			map.put("userNum", userNum);
			map.put("year", year);
			map.put("month", month-1);//자바스크립트에서 그냥오면 month는 0으로 시작하므로 주의!
		}
		
		ArrayList<WorkReportVO> lastMonthReport = new ArrayList(); 
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
	public int saveReport(Model model, WorkReportVO workReportVO) {
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
			if (state != 0) {
				System.out.println("aleady submitted");
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
		
//		JSONObject jsonReport= new JSONObject(updateJsonReport);
//		JSONObject jsonContents= new JSONObject(updateJsonContents);
	
		/*
		 * WorkReportVO vo = new WorkReportVO();
		 * vo.setReportNum(Integer.parseInt(jsonReport.getString("ReportNum")));
		 * vo.setUserNum(Integer.parseInt(jsonReport.getString("UserNum"))); //
		 * setReportNum 을 setUser_Num 으로 고침 ohsaeam
		 * vo.setYear(Integer.parseInt(jsonReport.getString("Year")));
		 * vo.setMonth(Integer.parseInt(jsonReport.getString("Month")));
		 * vo.setUserName(jsonReport.getString("UserName"));
		 */
		
		//vo.setAttendHour1(attendHour1);
		
//		System.out.println("jsonReport는? "+jsonReport);
//		System.out.println("jsonContents는? "+jsonContents);
//		System.out.println("set 해서 어떤 VO가 됐나? "+vo);
	
		
		int result = dao.updateReport(workReportVO);
		System.out.println("어드민 업데이트result: "+result); // 0 이 성공

		
		
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
	
	@RequestMapping(value="/admin/submitApproval", method = {RequestMethod.GET,RequestMethod.POST})
	public String submitApproval(WorkReportVO vo,Model model) {
		
		int stateNum = 2;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("submitApproval 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/submitCancel", method = {RequestMethod.GET,RequestMethod.POST})
	public String submitCancel(WorkReportVO vo,Model model) {
		
		int stateNum = 0;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("submitCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/approvaledCancel", method = {RequestMethod.GET,RequestMethod.POST})
	public String approvaledCancel(WorkReportVO vo,Model model) {
		
		int stateNum = 1;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("approvalCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/updateApproval", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApproval1(WorkReportVO vo,Model model) {
		
		int stateNum = 5;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApproval 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/updateApprova2l", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApproval2(WorkReportVO vo,Model model) {
		
		int stateNum = 6;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApproval 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	
	@RequestMapping(value="/admin/updateApprovalCancel1",method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApprovalCancel1(WorkReportVO vo,Model model) {
		
		int stateNum = 1;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApprovalCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/updateApprovalCancel2",method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApprovalCancel2(WorkReportVO vo,Model model) {
		
		int stateNum = 2;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApprovalCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/updateApprovaledCancel1", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApprovaledCancel1(WorkReportVO vo,Model model) {
		
		int stateNum = 3;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApprovaledCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}
	
	@RequestMapping(value="/admin/updateApprovaledCancel2", method = {RequestMethod.GET,RequestMethod.POST})
	public String updateApprovaledCancel2(WorkReportVO vo,Model model) {
		
		int stateNum = 4;
		vo.setState(stateNum);
		
		System.out.println("vo   :" + vo );
		
		int result = dao.updateState(vo);
		
		logger.debug("getVO:{}",result);
		
		System.out.println("updateApprovaledCancel 결과   " + result);
		
		return "redirect:/admin/reportList";
	}

}
