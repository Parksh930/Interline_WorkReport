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
public class UserController {
	
private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	

	@Autowired
	UserDAO dao;

	
	@RequestMapping(value="/user/profile", method=RequestMethod.GET)

	public String updatemyPage(HttpSession session){

		return "User/changePW";
	}
	
	
}
