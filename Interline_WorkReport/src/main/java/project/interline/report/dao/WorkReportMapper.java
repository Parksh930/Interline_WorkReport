package project.interline.report.dao;

import java.util.ArrayList;
import java.util.HashMap;

import project.interline.report.vo.WorkReportVO;

public interface WorkReportMapper {

	int insertReport(WorkReportVO workReportVO);

	ArrayList<Integer> isItNew(HashMap<String, Object> map);

	int updateReport(WorkReportVO workReportVO);

	int checkState(Integer reportNum);


}
