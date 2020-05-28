package project.interline.report.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import project.interline.report.dao.AdminDAO;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkReportVO;

@Controller
public class WorkReportController {
	private static final Logger logger = LoggerFactory.getLogger(WorkReportController.class);
	
	@Autowired
	AdminDAO dao;
	
	
	//
	@RequestMapping(value = "/user/writeReport", method = RequestMethod.GET)
	public String writeReport(Model model) {
		logger.debug("writeReport");
		return "Report/writeReport";
	}
	
	
	//
	@ResponseBody
	@RequestMapping(value = "/user/tempSaveReport", method = RequestMethod.POST)
	public int tempSaveReport(Model model, WorkReportVO workReportVO) {
		logger.debug(workReportVO.toString());
		
		return 0;
	}
	
	//submit
	@ResponseBody
	@RequestMapping(value = "/user/submitReport", method = RequestMethod.POST)
	public int submitReport(Model model, UserVO uservo) {
		logger.debug(uservo.toString());
		return 0;
	}
}
