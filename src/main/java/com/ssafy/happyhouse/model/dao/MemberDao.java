package com.ssafy.happyhouse.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.MemberDto;

@Mapper
public interface MemberDao {
	public MemberDto login(Map<String, String> map) throws Exception;
	
	public void insertMember(MemberDto member) throws Exception;
	public MemberDto getMember(String userid) throws Exception;
	public List<MemberDto> searchAll(Map<String, Object> map) throws Exception;
	public int totalCount(Map<String, Object> map) throws Exception;
	public void removeMember(String userid) throws Exception;
	public void updateMember(MemberDto member) throws Exception;
	public String getPwd(Map<String, String> map) throws Exception;
}
