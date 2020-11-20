package com.ssafy.happyhouse.model;

public class PostDto {
	int postNo;
	String userid;
	String title;
	String content;
	int count;
	String UpdateTime;
	String createDateTime;
	String username;

	public PostDto(String userid, String title, String content, String username, int count, String UpdateTime,
			String createDateTime) {
		this.userid = userid;
		this.title = title;
		this.content = content;
		this.username = username;
		this.count = count;
		this.UpdateTime = UpdateTime;
		this.createDateTime = createDateTime;
	}

	public String getUpdateTime() {
		return UpdateTime;
	}

	public void setUpdateTime(String updateTime) {
		UpdateTime = updateTime;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public String getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(String createDateTime) {
		this.createDateTime = createDateTime;
	}

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

}
