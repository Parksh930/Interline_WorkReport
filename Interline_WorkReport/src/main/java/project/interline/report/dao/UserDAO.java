package project.interline.report.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import project.interline.report.vo.UserVO;

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

}
