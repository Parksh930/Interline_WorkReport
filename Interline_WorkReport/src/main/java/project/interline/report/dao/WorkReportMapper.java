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

<<<<<<< HEAD
=======
	ArrayList<ReportListVO> getReportList();
>>>>>>> de9339f0d806eaf6cb0340ef3d07141f87cf3b68

}
