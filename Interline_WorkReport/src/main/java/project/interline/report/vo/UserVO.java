package project.interline.report.vo;

public class UserVO {
	private int userNum;
	private String userMail;
	private String userName;
	private String password;
	private String team;
	private String position;
	private String startDate;
	private String lastupdateDate;
	private String finalreportDate;
	private String retirement;
	private String authority;
	
	public UserVO() {
		super();
	}

	public UserVO(int userNum, String userMail, String userName, String password, String team, String position,
			String startDate, String lastupdateDate, String finalreportDate, String retirement, String authority) {
		super();
		this.userNum = userNum;
		this.userMail = userMail;
		this.userName = userName;
		this.password = password;
		this.team = team;
		this.position = position;
		this.startDate = startDate;
		this.lastupdateDate = lastupdateDate;
		this.finalreportDate = finalreportDate;
		this.retirement = retirement;
		this.authority = authority;
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getTeam() {
		return team;
	}

	public void setTeam(String team) {
		this.team = team;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getLastupdateDate() {
		return lastupdateDate;
	}

	public void setLastupdateDate(String lastupdateDate) {
		this.lastupdateDate = lastupdateDate;
	}

	public String getFinalreportDate() {
		return finalreportDate;
	}

	public void setFinalreportDate(String finalreportDate) {
		this.finalreportDate = finalreportDate;
	}

	public String getRetirement() {
		return retirement;
	}

	public void setRetirement(String retirement) {
		this.retirement = retirement;
	}

	public String getAuthority() {
		return authority;
	}

	public void setAuthority(String authority) {
		this.authority = authority;
	}

	@Override
	public String toString() {
		return "UserVO [userNum=" + userNum + ", userMail=" + userMail + ", userName=" + userName + ", password="
				+ password + ", team=" + team + ", position=" + position + ", startDate=" + startDate
				+ ", lastupdateDate=" + lastupdateDate + ", finalreportDate=" + finalreportDate + ", retirement="
				+ retirement + ", authority=" + authority + "]";
	}

}
