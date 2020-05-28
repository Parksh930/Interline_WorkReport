package project.interline.report.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project.interline.report.dao.AdminDAO;
import project.interline.report.dao.WorkReportDAO;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkReportVO;

@Controller
public class WorkReportController {
	private static final Logger logger = LoggerFactory.getLogger(WorkReportController.class);
	
	@Autowired
	WorkReportDAO dao;
	
	
	//
	@RequestMapping(value = "/user/writeReport", method = RequestMethod.GET)
	public String writeReport(Model model) {
		logger.debug("writeReport");
		return "Report/writeReport";
	}
	
	
	//
	@ResponseBody
	@RequestMapping(value = "/user/saveReport", method = RequestMethod.POST)
	public int tempSaveReport(Model model, WorkReportVO workReportVO) {
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
			int state = dao.checkState(reportNum.get(0));
			System.out.println("state="+state);
			if (state != 0) {
				return 3; //이미 제출된 상태라 변경 불가.
			}
			workReportVO.setReportNum(reportNum.get(0));
			result=dao.updateReport(workReportVO);
			return result;
		}
		
		
		
		result=dao.insertReport(workReportVO);
		System.out.println(result);
		
		return result;
	}
	
	//submit
	@ResponseBody
	@RequestMapping(value = "/user/submitReport", method = RequestMethod.POST)
	public int submitReport(Model model, UserVO uservo) {
		logger.debug(uservo.toString());
		return 1;
	}
}
