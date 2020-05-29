package project.interline.report.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

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
	public String userList(Model model) throws ParseException {
		ArrayList<UserVO> userList=dao.getUserlist();
		
		SimpleDateFormat old_pattern = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		SimpleDateFormat new_pattern = new SimpleDateFormat("yyyy.MM.dd");
		
		for(int n=0; n<userList.size();n++) {
			Date format_date = old_pattern.parse(userList.get(n).getStartDate());
			userList.get(n).setStartDate(new_pattern.format(format_date));
		}
		
		model.addAttribute("user_all",userList);
		
		return "Admin/userList";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/check_multiple", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String check_Multiple(int userNum, String userMail) {
		logger.debug("userNum:{},userId:{}",userNum,userMail);
		UserVO check_result = null;
		check_result = dao.check_Multiple("check_num",userNum);
		if(check_result != null) {
			
			return "存在する社員番号です。";
		}
		check_result = dao.check_Multiple("check_mail",userMail);
		if(check_result != null) {
			return "存在するIDです。";
		}

		return "成功";
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
			logger.debug("社員情報の登録成功！");
		}else {
			logger.debug("社員情報の登録失敗！");
		}
		return "redirect:/admin/userList";
	}
	
	@RequestMapping(value="/admin/userUpdate", method=RequestMethod.GET)
	public String userUpdateForm(int Num, Model model){
		UserVO getUser = dao.getUser_update(Num);
		logger.debug("user:{}",getUser);
		
		getUser.setStartDate(getUser.getStartDate().substring(0,10));
		
		model.addAttribute("user",getUser);
		return "Admin/userUpdate";
	}
	
	@RequestMapping(value="/admin/userUpdate", method=RequestMethod.POST)
	public String userUpdate(UserVO userUpdate_Form) {
		logger.debug("userUpdate:{}",userUpdate_Form);
		
		int result = dao.userUpdate(userUpdate_Form);
		
		if(result == 1) {
			logger.debug("社員情報の修正成功！");
		}else {
			logger.debug("社員情報の修正失敗！");
		}
		return "redirect:/admin/userList";
	}
	
	@RequestMapping(value="/admin/userDelete", method=RequestMethod.GET)
	public String userDelete(int userNum) {
		logger.debug("userDelete:{}", userNum);
		
		int result = dao.userDelete(userNum);
		
		if(result == 1) {
			logger.debug("社員情報の削除成功！");
		}else {
			logger.debug("社員情報の削除失敗！");
		}
		
		return "redirect:/admin/userList";
	}
}
