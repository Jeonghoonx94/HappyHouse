package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.dao.NoticeDao;
import com.ssafy.happyhouse.model.dao.PostDao;

@Service
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeNotice(NoticeDto notice) throws Exception{
		sqlSession.getMapper(NoticeDao.class).writeNotice(notice);
	}

	@Override
	public List<NoticeDto> noticeList(Map<String, Object> map) throws Exception {
		return sqlSession.getMapper(NoticeDao.class).noticeList(map);
	}

	@Override
	public NoticeDto detailNotice(int no) throws Exception{
		return sqlSession.getMapper(NoticeDao.class).detailNotice(no);
	}

	@Override
	public void deleteNotice(int no) throws Exception {
		sqlSession.getMapper(NoticeDao.class).deleteNotice(no);
	}

	@Override
	public void updateNotice(NoticeDto notice) throws Exception {
		sqlSession.getMapper(NoticeDao.class).updateNotice(notice);
	}

	@Override
	public int totalCount(Map<String, Object> map) throws Exception {
		return sqlSession.getMapper(NoticeDao.class).totalCount(map);
	}

}
