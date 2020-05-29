package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	
}
