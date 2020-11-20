package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.dao.CommentDao;

@Service
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertComment(CommentDto comment) {
		sqlSession.getMapper(CommentDao.class).insertComment(comment);
	}

	@Override
	public List<CommentDto> findAllComment(int postNo) {
		return sqlSession.getMapper(CommentDao.class).findAllComment(postNo);
	}

	@Override
	public void postCommentAllDelete(int postNo) {
		sqlSession.getMapper(CommentDao.class).postCommentAllDelete(postNo);
	}

	@Override
	public void deleteComment(int commentNo) {
		sqlSession.getMapper(CommentDao.class).deleteComment(commentNo);
	}

	@Override
	public CommentDto findOneComment(int commentNo) {
		return sqlSession.getMapper(CommentDao.class).findOneComment(commentNo);
	}

	@Override
	public void updateComment(String content, String updateTime, int commentNo) {
		sqlSession.getMapper(CommentDao.class).updateComment(content, updateTime, commentNo);
	}
}
