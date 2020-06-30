package project.interline.report.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import oz.scheduler.SchedulerException;
import project.interline.report.dao.AdminDAO;
import project.interline.report.util.ExportReport;
import project.interline.report.util.getProperties;
import project.interline.report.vo.Aggregation;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkTimeVO;

@Controller
public class AdminController {
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	SimpleDateFormat old_pattern = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	SimpleDateFormat new_pattern = new SimpleDateFormat("yyyy.MM.dd");
	
	@Autowired
	AdminDAO dao;
	
	@RequestMapping(value="/admin/adminMain", method=RequestMethod.GET)
	public String adminMain() {
		
		return "Admin/adminMain";
	}
	
	@RequestMapping(value="/admin/userList", method=RequestMethod.GET)
	public String userListForm(){
		
		return "Admin/userList";
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/userList", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public ArrayList<UserVO> userList() throws ParseException {

		ArrayList<UserVO> list = dao.getUserlist();
		logger.debug("list:{}", list);
		
		for(int n=0; n<list.size();n++) {
			Date Start_Date = old_pattern.parse(list.get(n).getStartDate());
			list.get(n).setStartDate(new_pattern.format(Start_Date ));
			
			if(list.get(n).getLastreportDate() != null) {
				Date report_Date = old_pattern.parse(list.get(n).getLastreportDate());
				list.get(n).setLastreportDate(new_pattern.format(report_Date ));
			}
			
			if(list.get(n).getLastupdateDate() != null) {
				Date report_update_Date = old_pattern.parse(list.get(n).getLastupdateDate());
				list.get(n).setLastupdateDate(new_pattern.format(report_update_Date ));
			}
		}
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/user_Filter", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ArrayList<UserVO> userFilter(String[] team,String status, String team_others) throws ParseException {
		logger.debug("status:{}, team:{}",status,team);
		ArrayList<UserVO> list = dao.userFilter(team,status,team_others);
		
		for(int n=0; n<list.size();n++) {
			Date Start_Date = old_pattern.parse(list.get(n).getStartDate());
			list.get(n).setStartDate(new_pattern.format(Start_Date ));
			
			if(list.get(n).getLastreportDate() != null) {
				Date report_Date = old_pattern.parse(list.get(n).getLastreportDate());
				list.get(n).setLastreportDate(new_pattern.format(report_Date ));
			}
			
			if(list.get(n).getLastupdateDate() != null) {
				Date report_update_Date = old_pattern.parse(list.get(n).getLastupdateDate());
				list.get(n).setLastupdateDate(new_pattern.format(report_update_Date ));
			}
		}
		
		
		return list;
	}
	
	@ResponseBody
	@RequestMapping(value="/admin/check_multiple", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public String check_Multiple(int userNum, String userMail) {
		logger.debug("userNum:{},userMail:{}",userNum,userMail);
		UserVO check_result = null;
		
		check_result = dao.check_Multiple("check_num",userNum);
		if(check_result != null) {
			return "存在する社員番号です。";
		}
		
		check_result = dao.check_Multiple("check_mail",userMail);
		if(check_result != null) {
			return "存在するメールアドレスです。";
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
	
	
	@RequestMapping(value="/admin/kimDaeun", method=RequestMethod.GET)
	public String kimDauen(Model model, HttpSession session) {
		logger.debug("김대은집계");
		ArrayList<Aggregation> list=null;
		list=dao.getAggregation(2020, 6);
		System.out.println(list);
		model.addAttribute("arrayList",list);
		ObjectMapper newobjectMapper= new ObjectMapper();
		String JSONString="";
		try {
			JSONString = newobjectMapper.writeValueAsString(list);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("JSONString",JSONString);
		return "Admin/kimDaeun";
	}
	@ResponseBody
	@RequestMapping(value="/admin/aggregationFilter", method=RequestMethod.GET)
	public ArrayList<Aggregation> aggregationFilter(HttpSession session, String teamArray, String etcArray, String userNum, String userName, String fromYearMonth, String toYearMonth ) {
		logger.debug("김대은집계");
		//System.out.println("들어온값"+teamArray.toString()+etcArray.toString()+userNum);
		System.out.println("들어온값"+teamArray+etcArray+userNum);
		//System.out.println(teamArray.split(","));
		System.out.println(teamArray.split(",").length);
		ArrayList<Aggregation> list=null;
		list=dao.getAggregation2(teamArray, etcArray, userNum, userName, fromYearMonth, toYearMonth);
		System.out.println(list);
		return list;
	}
	@ResponseBody
	@RequestMapping(value="/admin/exportAggregation", method=RequestMethod.GET)
	public String exportAggregation(String jsonData, int row, String format) {
		System.out.println("jsonData:::"+jsonData);
		System.out.println("row:::"+row);
		getProperties properties= new getProperties();
		String ozId="admin";
		String ozPW="admin1";
		String OZserverURL="http://"+properties.getOzIP()+"/oz80/server";
		String ipScheduler=properties.getOzIP().split(":")[0];
		int portScheduler=9521;
		ExportReport export=new ExportReport(ozId, ozPW, OZserverURL, ipScheduler, portScheduler);
		String nameOzr="workReportAggregationSave.ozr";
		String[] ozrParamValue = {"row="+row};
		String nameOdi =null;
		String[] odiParamValue = null;
		String formatExport = format;
		String fileNameExport="reportExport";
		String result="";
		try {
			result=export.exportMethod(jsonData, nameOzr, ozrParamValue, nameOdi, odiParamValue, formatExport, fileNameExport);
		} catch (SchedulerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result=e.toString();
		}
		return result;
	}
	
    
    @RequestMapping(value="/admin/statistics", method=RequestMethod.GET)
    public String worktimeStatisticsForm() {
        
        return "Admin/workTimeStatistics";
    }
    
    @ResponseBody
    @RequestMapping(value="/admin/statistics", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
    public HashMap<String,Object> WorkTimeStatistics(){
    	
    	HashMap<String, Object> result = new HashMap<String, Object>();
        Calendar cal = Calendar.getInstance();
        int year = cal.get(Calendar.YEAR);
        int[] month_sumTime = {0,0,0,0,0,0,0,0,0,0,0,0,0,0};
        ArrayList<String> month_sumWorkingTime = new ArrayList<>();
        ArrayList<String> month_avgWorkingTime = new ArrayList<>();
        
        ArrayList<WorkTimeVO> list = dao.getWorktimeList(year);
        
        for(WorkTimeVO vo : list) {
        	if(vo.getJanuary()==null){
        		vo.setJanuary("0");
        	}else {
        		month_sumTime[0] = vo.month_sumWorkingTime(month_sumTime[0],vo.getJanuary()); 		
        	}
        	
        	if(vo.getFeburary()==null){
        		vo.setFeburary("0");
        	}else {
        		month_sumTime[1] = vo.month_sumWorkingTime(month_sumTime[1],vo.getFeburary()); 		
        	}
        	
        	if(vo.getMarch()==null){
        		vo.setMarch("0");
        	}else {
        		month_sumTime[2] = vo.month_sumWorkingTime(month_sumTime[2],vo.getMarch()); 		
        	}
        	
        	if(vo.getApril()==null){
        		vo.setApril("0");
        	}else {
        		month_sumTime[3] = vo.month_sumWorkingTime(month_sumTime[3],vo.getApril()); 		
        	}
        	
        	if(vo.getMay()==null){
        		vo.setMay("0");
        	}else {	
        		month_sumTime[4] = vo.month_sumWorkingTime(month_sumTime[4],vo.getMay()); 		
        	}
        	
        	if(vo.getJune()==null){
        		vo.setJune("0");
        	}else {
        		month_sumTime[5] = vo.month_sumWorkingTime(month_sumTime[5],vo.getJune()); 		
        	}
        	
        	if(vo.getJuly()==null){
        		vo.setJuly("0");
        	}else {
        		month_sumTime[6] = vo.month_sumWorkingTime(month_sumTime[6],vo.getJuly()); 		
        	}
        	
        	if(vo.getAugust()==null){
        		vo.setAugust("0");
        	}else {
        		month_sumTime[7] = vo.month_sumWorkingTime(month_sumTime[7],vo.getAugust()); 		
        	}
        	
        	if(vo.getSeptember()==null){
        		vo.setSeptember("0");
        	}else {
        		month_sumTime[8] = vo.month_sumWorkingTime(month_sumTime[8],vo.getSeptember()); 		
        	}
        	
        	if(vo.getOctober()==null){
        		vo.setOctober("0");
        	}else {		
        		month_sumTime[9] = vo.month_sumWorkingTime(month_sumTime[9],vo.getOctober()); 			
        	}
        	
        	if(vo.getNovember()==null){
        		vo.setNovember("0");
        	}else {
        		month_sumTime[10] = vo.month_sumWorkingTime(month_sumTime[10],vo.getNovember()); 			
        	}
        	
        	if(vo.getDecember()==null){
        		vo.setDecember("0");
        	}else {
        		month_sumTime[11] = vo.month_sumWorkingTime(month_sumTime[11],vo.getDecember()); 			
        	}
        	
        	if(vo.getYearsumtime()==null){
        		vo.setYearsumtime("0");
        	}else {
        		month_sumTime[12] = vo.month_sumWorkingTime(month_sumTime[12],vo.getYearsumtime()); 	
        	}
        	
        	if(vo.getYearaveragetime()==null){
        		vo.setYearaveragetime("0");
        	}else {
        		month_sumTime[13] = vo.month_sumWorkingTime(month_sumTime[13],vo.getYearaveragetime()); 	
        	}
        }
        
        for(int n : month_sumTime) {
        	int avg = n/list.size();
        	month_sumWorkingTime.add((n/60)+":"+(n%60));
        	month_avgWorkingTime.add((avg/60)+":"+(avg%60));
        }
        
        result.put("list", list);
        result.put("month_sumTime",month_sumWorkingTime);
        result.put("month_avgTime",month_avgWorkingTime);

        return result;
    }

}
