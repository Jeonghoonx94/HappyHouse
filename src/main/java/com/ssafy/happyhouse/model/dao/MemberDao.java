package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PageBean;

@Mapper
public interface MemberDao {
	public MemberDto login(Map<String, String> map) throws SQLException;
	
	public void insertMember(MemberDto member);
	public MemberDto getMember(String userid);
	public List<MemberDto> searchAll(Map<String, String> map);
	public int totalCount(PageBean bean);
	public void removeMember(String userid);
	public void updateMember(MemberDto member);
	public String getForgotpwd(Map<String, String> map);
}
