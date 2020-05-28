package project.interline.report.dao;

import java.util.ArrayList;

import project.interline.report.vo.UserVO;

public interface AdminMapper {

	ArrayList<UserVO> getUserlist();

	UserVO getUser_update(int num);

	int userRegister(UserVO userRegister_Form);
}
