package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.interline.report.vo.Aggregation;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkTimeVO;

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

	public ArrayList<Aggregation> getAggregation(int year, int month) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		HashMap<String, Object> map = new HashMap<>();
		map.put("year", year);
		map.put("month", month);
		ArrayList<Aggregation> list = mapper.getAggregation(map);
		return list;
	}

	public ArrayList<Aggregation> getAggregation2(String teamArray, String etcArray, String userNum, String userName, String fromYearMonth, String toYearMonth) {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		HashMap<String, Object> map = new HashMap<>();
		System.out.println("다오다");
		System.out.println("팀어레이:"+teamArray);
		if(teamArray != "") {
			System.out.println("팀어레이에 들어왔다.");
			String[] teamArrayArray=teamArray.split(",");
			ArrayList<String> teamArrayList = new ArrayList<String>();
			for(int i =0 ; i<teamArrayArray.length; i++) {
				teamArrayList.add(teamArrayArray[i]);
			}
			System.out.println(teamArrayList.toString());
			map.put("teamArray",teamArrayList );	
		}
		if(etcArray != "") {
			String[] etcArrayArray=etcArray.split(",");
			ArrayList<String> etcArrayList = new ArrayList<String>();
			for(int i =0 ; i<etcArrayArray.length; i++) {
				etcArrayList.add(etcArrayArray[i]);
			}
			System.out.println(etcArrayList.toString());
			map.put("etcArray",etcArrayList );			
		}
		map.put("userNum", userNum);
		map.put("userName", userName);
		map.put("fromYearMonth", fromYearMonth);
		map.put("toYearMonth", toYearMonth);
		ArrayList<Aggregation> list = mapper.getAggregation2(map);
		return list;
	}
	
    public ArrayList<WorkTimeVO> getWorktimeList(int year) {
        AdminMapper mapper = session.getMapper(AdminMapper.class);
        ArrayList<WorkTimeVO> list = mapper.getWorktimeList(year);
        
        return list;
    }

	public HashMap<String, Integer> getYearTerm() {
		AdminMapper mapper = session.getMapper(AdminMapper.class);
		HashMap<String, Integer> year_term = mapper.getYearTerm();
		return year_term;
	}
}
