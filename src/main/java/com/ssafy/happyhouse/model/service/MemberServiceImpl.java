package com.ssafy.happyhouse.model.service;

import com.ssafy.happyhouse.model.dao.MemberDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.MemberDto;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public MemberDto login(Map<String, String> map) throws Exception{
		if (map.get("userid") == null || map.get("userpwd") == null) return null;
		return sqlSession.getMapper(MemberDao.class).login(map);
	}
	
	@Override
	public void insertMember(MemberDto member){
		sqlSession.getMapper(MemberDao.class).insertMember(member);
	}

	@Override
	public List<MemberDto> searchAll(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).searchAll(map);
	}

	@Override
	public MemberDto searchMember(String userid){
		return sqlSession.getMapper(MemberDao.class).getMember(userid);
	}

	@Override
	public void removeMember(String userid) {
		sqlSession.getMapper(MemberDao.class).removeMember(userid);
	}

	@Override
	public void updateMember(MemberDto member) {
		sqlSession.getMapper(MemberDao.class).updateMember(member);
	}

	@Override
	public String getPwd(Map<String, String> map) {
		return sqlSession.getMapper(MemberDao.class).getPwd(map);
	}
}
