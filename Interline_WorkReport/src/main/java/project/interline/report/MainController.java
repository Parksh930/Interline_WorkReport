package project.interline.report;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import project.interline.report.dao.UserDAO;
import project.interline.report.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class MainController {
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	@Autowired
	UserDAO dao;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String loginForm() {
		
		return "login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(String login_id, String login_pw, String mobileCheck
					, HttpSession session,RedirectAttributes redirect) {
		
		logger.debug("login id:{}, pw:{}", login_id,login_pw);
		
		UserVO user = dao.getUser_login(login_id);
		
		
		if(user != null && user.getPassword().equals(login_pw)){
			session.setAttribute("login_id", user.getUserMail());
			session.setAttribute("user_inform", user);
			session.setAttribute("mobileCheck", mobileCheck);
			
			if(user.getAuthority().equals("a")) {
				return"redirect:/admin/adminMain";		
			}else if(user.getAuthority().equals("u")) {
				return "redirect:/user/userMain";	//userMainPage의 jsp등록
			}
		}
		
		if(user == null) {
			redirect.addFlashAttribute("error","存在しないメールアドレスです。");
		}else if(!user.getPassword().equals(login_pw)){
			redirect.addFlashAttribute("error","パスワードが一致しません。");
		}
		return "redirect:/";
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		logger.debug("logout");
		session.removeAttribute("login_id");
		session.invalidate();
		
		return "redirect:/";
	}
}
