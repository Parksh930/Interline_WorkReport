package project.interline.report.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WorkReportDAO {
	
	@Autowired
	SqlSession session;
}
