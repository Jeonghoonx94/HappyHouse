package com.ssafy.happyhouse.model;

public class LocationDto {
	private int no;
	private String userid;
	private String dong;
	private String gugunName;
	private String gugun_name;
	
	public LocationDto(String userid, String dong, String gugunName) {
		this.userid = userid;
		this.dong = dong;
		this.gugunName = gugunName;
	}
	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getDong() {
		return dong;
	}
	public void setDong(String dong) {
		this.dong = dong;
	}
	public String getGugunName() {
		return gugunName;
	}
	public void setGugunName(String gugunName) {
		this.gugunName = gugunName;
	}
	
	public String getGugun_name() {
		return gugun_name;
	}

	public void setGugun_name(String gugun_name) {
		this.gugun_name = gugun_name;
	}

	@Override
	public String toString() {
		return "LocationDto [no=" + no + ", userid=" + userid + ", dong=" + dong + ", gugunName=" + gugunName
				+ ", gugun_name=" + gugun_name + "]";
	}

}	
