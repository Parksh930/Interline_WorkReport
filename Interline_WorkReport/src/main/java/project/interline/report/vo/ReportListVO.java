package project.interline.report.vo;

public class ReportListVO {
	private int reportNum;
	private int userNum;
	private String userMail;
	private String userName;
	private String team;
	private int year;
	private int month;
	private String updateDate;
	
	public ReportListVO() {
		super();
	}

	public ReportListVO(int reportNum, int userNum, String userMail, String userName, String team, int year, int month,
			String updateDate) {
		super();
		this.reportNum = reportNum;
		this.userNum = userNum;
		this.userMail = userMail;
		this.userName = userName;
		this.team = team;
		this.year = year;
		this.month = month;
		this.updateDate = updateDate;
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public int getUserNum() {
		return userNum;
	}

	public void setUserNum(int userNum) {
		this.userNum = userNum;
	}

	public String getUserMail() {
		return userMail;
	}

	public void setUserMail(String userMail) {
		this.userMail = userMail;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getMonth() {
		return month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public String getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(String updateDate) {
		this.updateDate = updateDate;
	}

	@Override
	public String toString() {
		return "ReportListVO [reportNum=" + reportNum + ", userNum=" + userNum + ", userMail=" + userMail
				+ ", userName=" + userName + ", team=" + team + ", year=" + year + ", month=" + month + ", updateDate="
				+ updateDate + "]";
	}
}