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

}
