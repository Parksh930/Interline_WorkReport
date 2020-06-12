package project.interline.report.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.interline.report.vo.ReportListVO;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkReportVO;

@Repository
public class UserDAO {
	
	@Autowired
	SqlSession session;

	public UserVO getUser_login(String login_id) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		
		UserVO user = mapper.getUser_login(login_id);
		return user;
	}
	
	public int updateMp(UserVO user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		
		int result = mapper.updateMp(user);
		
		return result;
	}
	
	public int getTotal(int user_num) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		int cnt = mapper.getTotal(user_num);
		return cnt;
	}
	
	public ArrayList<ReportListVO> getMy_List(int st, int ctt, int user_num) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		
		System.out.println("사원번호:"+user_num);
		RowBounds rbs = new RowBounds(st,ctt);
		ArrayList<ReportListVO> my_List = mapper.getMy_List(rbs,user_num);
		return my_List;
	}

	public ReportListVO readReportList(ReportListVO report) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.readReportList(report);
	}

	public int changePW(UserVO userVO) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.changePW(userVO);
	}

	public int confirmChange(WorkReportVO workReport) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		return mapper.confirmChange(workReport);
	}
	
	
}
