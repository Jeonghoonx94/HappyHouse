package com.ssafy.happyhouse.model.service;

import com.ssafy.happyhouse.model.dao.MemberDao;
import com.ssafy.happyhouse.util.DBUtil;
import com.ssafy.happyhouse.util.PageUtility;
import com.ssafy.happyhouse.model.PageBean;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private MemberDao memberDao;

	@Override
	public MemberDto login(Map<String, String> map) throws Exception{
		if (map.get("userid") == null || map.get("userpwd") == null) return null;
		return memberDao.login(map);
	}
	
	@Override
	public void insertMember(MemberDto member){
		memberDao.insertMember(member);
	}

	@Override
	public List<MemberDto> searchAll(PageBean bean) {
		return memberDao.searchAll(bean);
	}
	
	@Override
	public MemberDto searchMember(String userid){
		return memberDao.getMember(userid);
	}

	@Override
	public void removeMember(String userid) {
		memberDao.removeMember(userid);
	}

	@Override
	public void updateMember(MemberDto member) {
		memberDao.updateMember(member);
	}

	@Override
	public String forgotpwd(Map<String, String> map) {
		return memberDao.getForgotpwd(map);
	}
}
