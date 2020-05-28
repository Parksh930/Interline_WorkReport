package project.interline.report.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import project.interline.report.dao.AdminDAO;
import project.interline.report.vo.UserVO;

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	AdminDAO dao;
	
	@RequestMapping(value="/admin/adminMain", method=RequestMethod.GET)
	public String adminMain() {
		
		return "Admin/adminMain";
	}
	
	@RequestMapping(value="/admin/userList", method=RequestMethod.GET)
	public String userList(Model model) {
		ArrayList<UserVO> userList=dao.getUserlist();
		
		model.addAttribute("user_all",userList);
		
		return "Admin/userList";
	}
	
	@RequestMapping(value="/admin/userRegister", method=RequestMethod.GET)
	public String userRegisterForm() {
		
		return "Admin/uesrRegister";
	}
	
	@RequestMapping(value="/admin/userRegister", method=RequestMethod.POST)
	public String userRegister(UserVO userRegister_Form) {
		logger.debug("userRegister:{}",userRegister_Form);
		
		int result = dao.userRegister(userRegister_Form);
		
		if(result == 1) {
			logger.debug("登録成功！");
		}else {
			logger.debug("登録失敗！");
		}
		return "redirect:/admin/userList";
	}
	
	@RequestMapping(value="/admin/userUpdate", method=RequestMethod.GET)
	public String userUpdateForm(int Num, Model model) {
		UserVO getUser = dao.getUser_update(Num);
		
		logger.debug("user:{}",getUser);
		
		model.addAttribute("user",getUser);
		return "Admin/userUpdate";
	}
}
