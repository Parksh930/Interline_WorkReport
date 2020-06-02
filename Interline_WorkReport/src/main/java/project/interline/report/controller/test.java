package project.interline.report.controller;


import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;


import project.interline.report.dao.UserDAO;
import project.interline.report.vo.UserVO;

@Controller
public class test {
	private static final Logger logger = LoggerFactory.getLogger(test.class);
	
	@Autowired
	UserDAO dao;
	
	@RequestMapping(value="/user/userMain", method=RequestMethod.GET)
	public String userMain(HttpSession session) {
		
		return "User/userMain";
	}
}
