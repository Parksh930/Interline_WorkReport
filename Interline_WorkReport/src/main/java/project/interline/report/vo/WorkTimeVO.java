package project.interline.report.vo;

public class WorkTimeVO {
	private String userNum;
	private String January;
	private String Feburary;
	private String March;
	private String April;
	private String May;
	private String June;
	private String July;
	private String August;
	private String September;
	private String October;
	private String November;
	private String December;
	private String yearsumtime;
	private String yearaveragetime;
	
	public WorkTimeVO() {
		super();
	}

	public WorkTimeVO(String userNum, String january, String feburary, String march, String april, String may,
			String june, String july, String august, String september, String october, String november, String december,
			String yearsumtime, String yearaveragetime) {
		super();
		this.userNum = userNum;
		January = january;
		Feburary = feburary;
		March = march;
		April = april;
		May = may;
		June = june;
		July = july;
		August = august;
		September = september;
		October = october;
		November = november;
		December = december;
		this.yearsumtime = yearsumtime;
		this.yearaveragetime = yearaveragetime;
	}

	public String getUserNum() {
		return userNum;
	}

	public void setUserNum(String userNum) {
		this.userNum = userNum;
	}

	public String getJanuary() {
		return January;
	}

	public void setJanuary(String january) {
		January = january;
	}

	public String getFeburary() {
		return Feburary;
	}

	public void setFeburary(String feburary) {
		Feburary = feburary;
	}

	public String getMarch() {
		return March;
	}

	public void setMarch(String march) {
		March = march;
	}

	public String getApril() {
		return April;
	}

	public void setApril(String april) {
		April = april;
	}

	public String getMay() {
		return May;
	}

	public void setMay(String may) {
		May = may;
	}

	public String getJune() {
		return June;
	}

	public void setJune(String june) {
		June = june;
	}

	public String getJuly() {
		return July;
	}

	public void setJuly(String july) {
		July = july;
	}

	public String getAugust() {
		return August;
	}

	public void setAugust(String august) {
		August = august;
	}

	public String getSeptember() {
		return September;
	}

	public void setSeptember(String september) {
		September = september;
	}

	public String getOctober() {
		return October;
	}

	public void setOctober(String october) {
		October = october;
	}

	public String getNovember() {
		return November;
	}

	public void setNovember(String november) {
		November = november;
	}

	public String getDecember() {
		return December;
	}

	public void setDecember(String december) {
		December = december;
	}

	public String getYearsumtime() {
		return yearsumtime;
	}

	public void setYearsumtime(String yearsumtime) {
		this.yearsumtime = yearsumtime;
	}

	public String getYearaveragetime() {
		return yearaveragetime;
	}

	public void setYearaveragetime(String yearaveragetime) {
		this.yearaveragetime = yearaveragetime;
	}

	@Override
	public String toString() {
		return "WorkTimeVO [userNum=" + userNum + ", January=" + January + ", Feburary=" + Feburary + ", March=" + March
				+ ", April=" + April + ", May=" + May + ", June=" + June + ", July=" + July + ", August=" + August
				+ ", September=" + September + ", October=" + October + ", November=" + November + ", December="
				+ December + ", yearsumtime=" + yearsumtime + ", yearaveragetime=" + yearaveragetime + "]";
	}
	
    public int month_sumWorkingTime(int sum_time,String month_time) {
    	
		String[] workingTime = month_time.split(":");
		sum_time = sum_time+(Integer.parseInt(workingTime[0])*60)+Integer.parseInt(workingTime[1]);
		
		return sum_time;
    }
}
