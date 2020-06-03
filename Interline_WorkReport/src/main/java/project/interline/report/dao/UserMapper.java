package project.interline.report.dao;

import project.interline.report.vo.UserVO;

public interface UserMapper {

	UserVO getUser_login(String login_id);
	int updateMp(UserVO user);
	
}
