package project.interline.report.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import project.interline.report.dao.UserDAO;
import project.interline.report.util.PageNavigator;
import project.interline.report.vo.ReportListVO;
import project.interline.report.vo.UserVO;


@Controller
public class UserController {
	
private static final Logger logger = LoggerFactory.getLogger(UserController.class);

private static final int countPerPage=10;		
private static final int pagePerGroup=10;	

	@Autowired
	UserDAO dao;
	
	@RequestMapping(value="/user/userMain", method=RequestMethod.GET)
	public String userMain(HttpSession session) {
		
		return "User/userMain";
	}
	
	
	@RequestMapping(value="/user/profile", method=RequestMethod.GET)
	public String updatemyPage(HttpSession session){

		return "User/changePW";
	}
	
	
	@RequestMapping(value="/user/myReportList", method=RequestMethod.GET)
	public String myreportList(Model model, @RequestParam(value="page", defaultValue="1") int page, HttpSession session) {
		logger.debug("pageNum:{}", page);
		UserVO vo=(UserVO)session.getAttribute("user_inform");
		if(vo == null) {
			return "login";
		}
		int user_num = vo.getUserNum();
		int total = dao.getTotal(user_num);
		
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, page, total);
		
		
		
		ArrayList<ReportListVO> my_list = dao.getMy_List(navi.getStartRecord(), navi.getCountPerPage(),user_num);
		System.out.println("여기까지1111111111111111111111111111111111111111111111111");
		model.addAttribute("pn", navi);
		model.addAttribute("report_my",my_list);
		System.out.println("여기까지222222222222222222222222222222222222222222222222");
		
		
		return "User/myreportList";
	}
	
	
	//유진씨 수정할거있음 하세요. 비번 변경받아주는 곳입니다.
	@RequestMapping(value="/user/changePW", method=RequestMethod.POST)
	public String changePW(Model model, HttpSession session ,String password){
		UserVO userVO=(UserVO)session.getAttribute("user_inform");
		userVO.setPassword(password);
		dao.changePW(userVO);
		return "User/changePW";
	}
	
}
