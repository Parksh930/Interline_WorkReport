package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project.interline.report.vo.ReportListVO;
import project.interline.report.vo.UserVO;
import project.interline.report.vo.WorkReportVO;

@Repository
public class WorkReportDAO {
	
	@Autowired
	SqlSession session;

	public int insertReport(WorkReportVO workReportVO) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		
		int result = mapper.insertReport(workReportVO);
		return result;
	}

	public ArrayList<Integer> isItNew(HashMap<String, Object> map) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		
		ArrayList<Integer> result = mapper.isItNew(map);
		
		return result;
	}

	public int updateReport(WorkReportVO workReportVO) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		int result = mapper.updateReport(workReportVO);
		return 0;
	}

	public int checkState(Integer reportNum) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		int result= mapper.checkState(reportNum);
		return result;
	}


	public ArrayList<ReportListVO> getReportList() {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		ArrayList<ReportListVO> list = mapper.getReportList();
		return list;
	}


	public WorkReportVO getWorkReportVO(WorkReportVO vo) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.getWorkReportVO(vo);
	}

	public int deleteReport(WorkReportVO vo) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.deleteReport(vo);
	}



	public ArrayList<WorkReportVO> checkState2(HashMap<String, Integer> map) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		ArrayList<WorkReportVO> result = mapper.checkState2(map);
		return result;
	}

	public int lastUpdateDate(int userNum) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		int result = 0;
		result=	mapper.lastUpdateDate(userNum);
		return result;
	}

	public ArrayList<ReportListVO> reportFilter(String[] team, String team_others
												,String userNum,String userName
												,String From_ReportDays,String To_ReportDays) {
		
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("From_ReportDays",From_ReportDays);
		map.put("To_ReportDays",To_ReportDays);
		map.put("userNum", userNum);
		map.put("userName", userName);
		map.put("team", team);
		map.put("team_others", team_others);
		ArrayList<ReportListVO> list = mapper.reportFilter(map);
		
		return list;
	}

	public WorkReportVO getMyReport(WorkReportVO workReport) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.getMyReport(workReport);
	}

	public int updateState(WorkReportVO vo) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		int stateNum;
		if(vo.getState()==1) {
			stateNum = 2;
			vo.setState(stateNum);
		}
		else if(vo.getState()==3) {
			stateNum = 5;
			vo.setState(stateNum);
		}
		else if(vo.getState()==4) {
			stateNum = 6;
			vo.setState(stateNum);
		}
		return mapper.updateState(vo);
	}

	public int checkNewEmployee(int userNum) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.checkNewEmployee(userNum);
	}

	public int updateReport2(WorkReportVO workReportVO) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		int result = mapper.updateReport2(workReportVO);
		return 0;
	}

	public int reportSelectDelete(String arrNumber) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.reportSelectDelete(arrNumber);
	}

	public int reportSelectApproval(String[] arr) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.reportSelectApproval(arr);
	}

	public WorkReportVO selectReport(int intNum) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.selectReport(intNum);
	}

	public ArrayList<WorkReportVO> getCountList() {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.getCountList();
	}


	public ArrayList<WorkReportVO> searchList(String year, String month, String searchKeyword1, String searchKeyword2) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("year",year);
		map.put("month",month);
		map.put("searchKeyword1",searchKeyword1);
		map.put("searchKeyword2",searchKeyword2);
		return mapper.searchList(map);
	}

	public WorkReportVO countDetail(WorkReportVO vo) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.countDetail(vo);
	}

	public ArrayList<WorkReportVO> countOption(WorkReportVO vo) {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.countOption(vo);
	}

	public ArrayList<WorkReportVO> countOption2() {
		WorkReportMapper mapper = session.getMapper(WorkReportMapper.class);
		return mapper.countOption2();
	}


}
