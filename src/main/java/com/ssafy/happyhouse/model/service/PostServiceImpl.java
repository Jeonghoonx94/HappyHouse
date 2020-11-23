package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.PostDto;
import com.ssafy.happyhouse.model.dao.PostDao;

@Service
public class PostServiceImpl implements PostService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getPostCount(Map<String, Object> map) {
		return sqlSession.getMapper(PostDao.class).getPostCount(map);
	}

	@Override
	public List<PostDto> findAllPost(Map<String, Object> map) {
		return sqlSession.getMapper(PostDao.class).findAllPost(map);
	}

	@Override
	public PostDto findByPostNo(int postNo) {
		return sqlSession.getMapper(PostDao.class).findByPostNo(postNo);
	}

	@Override
	public void updatePost(PostDto post) {
		sqlSession.getMapper(PostDao.class).updatePost(post);
	}

	@Override
	public void insertPost(PostDto post) {
		sqlSession.getMapper(PostDao.class).insertPost(post);
	}

	@Override
	public void deletePost(int postNo) {
		sqlSession.getMapper(PostDao.class).deletePost(postNo);
	}
}
