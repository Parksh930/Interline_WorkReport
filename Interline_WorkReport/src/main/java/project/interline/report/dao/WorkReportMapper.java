package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import project.interline.report.vo.ReportListVO;
import project.interline.report.vo.WorkReportVO;

public interface WorkReportMapper {

	int insertReport(WorkReportVO workReportVO);

	ArrayList<Integer> isItNew(HashMap<String, Object> map);

	int updateReport(WorkReportVO workReportVO);

	int checkState(Integer reportNum);

	ArrayList<ReportListVO> getReportList();

	WorkReportVO getWorkReportVO(WorkReportVO vo);

	int deleteReport(WorkReportVO vo);

	ArrayList<WorkReportVO> checkState2(HashMap<String, Integer> map);

	int lastUpdateDate(int userNum);
	
	ArrayList<ReportListVO> reportFilter(HashMap<String,Object> map);

	WorkReportVO getMyReport(WorkReportVO workReport);

	int updateState(WorkReportVO vo);

	int checkNewEmployee(int userNum);

	int updateReport2(WorkReportVO workReportVO);

	int reportSelectDelete(String arrNumber);

	int reportSelectApproval(String[] arr);

}
