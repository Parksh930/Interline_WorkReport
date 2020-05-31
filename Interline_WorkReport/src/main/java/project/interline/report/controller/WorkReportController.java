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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
				return 2; //由ы룷�듃媛� 2媛쒖씠�긽 諛쒓껄�맖.
			}
			int state = dao.checkState(reportNum.get(0));
			System.out.println("state="+state);
			if (state != 0) {
				return 3; //�씠誘� �젣異쒕맂 �긽�깭�씪 蹂�寃� 遺덇�.
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
	
	@RequestMapping(value="/admin/reportList", method = RequestMethod.GET)
	public String reportList(Model model) {
		ArrayList<ReportListVO> reportList = dao.getReportList();
		
		logger.debug("reportList:{}",reportList);
		
		model.addAttribute("report_all",reportList);
		return "Report/workReportList";
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
		System.out.println("배열  " + arrNumber);
		model.addAttribute("arrNumber",arrNumber);
		return "Report/readWorkReport2";
	}
	

	@RequestMapping(value="/admin/getAllReport", method = RequestMethod.GET)
	public String getAllReport(WorkReportVO vo,Model model) {
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
	
	
}
