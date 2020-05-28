package project.interline.report.dao;

import project.interline.report.vo.UserVO;

public interface UserMapper {

	UserVO getUser(String login_id);
	
}
