package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.MemberDto;

public interface MemberService {
	public MemberDto login(Map<String, String> map) throws Exception;
	
	public void insertMember(MemberDto member);
	public MemberDto searchMember(String userid) ;
	public List<MemberDto> searchAll(Map<String, String> map) ;
	public void removeMember(String userid);
	public void updateMember(MemberDto member);
	public String getPwd(Map<String, String> map);
}
