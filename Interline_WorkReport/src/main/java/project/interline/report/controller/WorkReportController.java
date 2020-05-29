package project.interline.report.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import project.interline.report.dao.AdminDAO;
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
	@RequestMapping(value = "/user/writeReport", method = RequestMethod.GET)
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
				if (thisMonthReport.size()==1) { //이번달 쓰던게 있으면
					//저장내용 JSON스트링파이
					ObjectMapper objectMapper= new ObjectMapper();
					String reportJSON="";
					try {
						reportJSON = objectMapper.writeValueAsString(lastMonthReport.get(0));
					} catch (JsonProcessingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					System.out.println("이번달 저장분이있어 로딩합니다."+reportJSON);
					model.addAttribute("reportJSON", reportJSON);
				}else { //이번달 쓰던게 없으면
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
			if (reportNum.size()>1) {
				return 2; //리포트가 2개이상 발견됨.
			}
			System.out.println("reportNum="+reportNum.get(0));
			int state = dao.checkState(reportNum.get(0));
			System.out.println("state="+state);
			if (state != 0) {
				return 3; //이미 제출된 상태라 변경 불가.
			}
			workReportVO.setReportNum(reportNum.get(0));
			result=dao.updateReport(workReportVO); //성공시0
			
			if (workReportVO.getState()==1) {
				//유저의 최종 보고일 업데이트 해주기
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
	public String reportList(Model model) {
		ArrayList<ReportListVO> reportList = dao.getReportList();
		
		logger.debug("reportList:{}",reportList);
		
		model.addAttribute("report_all",reportList);
		return "Report/workReportList";
	}

}
