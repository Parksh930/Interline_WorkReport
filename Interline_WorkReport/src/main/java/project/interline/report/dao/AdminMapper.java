package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import project.interline.report.vo.Aggregation;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkTimeVO;

public interface AdminMapper {

	ArrayList<UserVO> getUserlist();

	UserVO getUser_update(int num);

	int userRegister(UserVO userRegister_Form);

	int userUpdate(UserVO userUpdate_Form);

	int userDelete(int userNum);

	UserVO check_Multiple(HashMap<String, Object> map);

	ArrayList<UserVO> userFilter(HashMap<String, Object> map);

	ArrayList<Aggregation> getAggregation(HashMap<String, Object> map);

	ArrayList<Aggregation> getAggregation2(HashMap<String, Object> map);

	ArrayList<WorkTimeVO> getWorktimeList(int year);

	HashMap<String, Integer> getYearTerm();
}
