package project.interline.report.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import project.interline.report.vo.UserVO;
import project.interline.report.vo.ReportListVO;

public interface UserMapper {

	UserVO getUser_login(String login_id);
	int updateMp(UserVO user);
	int getTotal(int user_num);
	ArrayList<ReportListVO> getMy_List(RowBounds rbs,int user_num);
	ReportListVO readReportList(ReportListVO report);
	int getAll(int user_num);
	int changePW(UserVO userVO);
	

}
