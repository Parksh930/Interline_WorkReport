package project.interline.report;

import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
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
	public String main(HttpSession session) {
		session.removeAttribute("login_id");
		session.invalidate();
		
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String loginForm(HttpSession session) {
		session.removeAttribute("login_id");
		session.invalidate();
		
		return "login";
	}
	
	@ResponseBody
	@RequestMapping(value="/login", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public HashMap<String, String> login(String login_id, String login_pw, HttpSession session) {
		
		logger.debug("login id:{}, pw:{}", login_id,login_pw);
		
		UserVO user = dao.getUser_login(login_id);
		HashMap<String,String> result = new HashMap<>();
		
		if(user != null && user.getPassword().equals(login_pw)){
			session.setAttribute("login_id", user.getUserMail());
			session.setAttribute("user_inform", user);
			
			if(user.getAuthority().equals("a")) {
				result.put("url", "admin/adminMain");		
			}else if(user.getAuthority().equals("u")) {
				result.put("url", "user/userMain");//userMainPage�쓽 jsp�벑濡�
			}
		}
		
		if(user == null) {
			result.put("error","存在しないメールアドレスです。");
		}else if(!user.getPassword().equals(login_pw)){
			result.put("error","パスワードが一致しません。");
		}
		return result;
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout(HttpSession session) {
		logger.debug("logout");
		session.removeAttribute("login_id");
		session.invalidate();
		return "redirect:/";
	}
}
