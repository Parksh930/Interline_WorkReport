package project.interline.report.dao;

import java.util.ArrayList;

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
}
