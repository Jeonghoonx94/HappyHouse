package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {
	public MemberDto login(Map<String, String> map) throws Exception;
	
	public void insertMember(MemberDto member) throws Exception;
	public MemberDto searchMember(String userid) throws Exception;
	public List<MemberDto> searchAll(Map<String, Object> map) throws Exception;
	public int totalCount(Map<String, Object> map) throws Exception;
	public void removeMember(String userid) throws Exception;
	public void updateMember(MemberDto member) throws Exception;
	public String getPwd(Map<String, String> map) throws Exception;
}
