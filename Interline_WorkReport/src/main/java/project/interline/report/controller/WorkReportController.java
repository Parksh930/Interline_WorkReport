package project.interline.report.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.interline.report.dao.AdminDAO;

@Controller
public class WorkReportController {
	private static final Logger logger = LoggerFactory.getLogger(WorkReportController.class);
	
	@Autowired
	AdminDAO dao;
	
	
	//
	@RequestMapping(value = "/user/writeReport", method = RequestMethod.GET)
	public String writeReport(Model model) {
		logger.debug("here");
		return "writeReport";
	}
}
