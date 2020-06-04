package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.interline.report.vo.UserVO;

@Repository
public class AdminDAO {
	
	@Autowired
	SqlSession session;

	public ArrayList<UserVO> getUserlist() {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		ArrayList<UserVO> userList = mapper.getUserlist();
		
		return userList;
	}

	public UserVO getUser_update(int num) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		UserVO vo = mapper.getUser_update(num);
		return vo;
	}

	public int userRegister(UserVO userRegister_Form) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		int result = mapper.userRegister(userRegister_Form);
		
		return result;
	}

	public int userUpdate(UserVO userUpdate_Form) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		int result = mapper.userUpdate(userUpdate_Form);
		
		return result;
	}

	public int userDelete(int userNum) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		int result = mapper.userDelete(userNum);
		
		return result;
	}

	public UserVO check_Multiple(String check_point, Object check_content) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("check_point", check_point);
		map.put("check_content", check_content);
		
		UserVO vo = mapper.check_Multiple(map);
		
		return vo;
	}

	public ArrayList<UserVO> userFilter(String[] team, String status, String others) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		
		HashMap<String, Object> map = new HashMap<>();
		
		map.put("team_others",others);
		map.put("team",team);
		map.put("status", status);
		ArrayList<UserVO> list = mapper.userFilter(map);
		
		return list;
	}
}
