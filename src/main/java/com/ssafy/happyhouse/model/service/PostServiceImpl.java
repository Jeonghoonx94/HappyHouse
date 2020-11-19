package com.ssafy.happyhouse.model.service;

import java.util.List;

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
	public int postAllCount() {
		return sqlSession.getMapper(PostDao.class).postAllCount();
	}

	@Override
	public List<PostDto> postFindAll(int page, int pageSize) {
		return sqlSession.getMapper(PostDao.class).postFindAll(page, pageSize);
	}

	@Override
	public PostDto findByPostId(int postNo) {
		return sqlSession.getMapper(PostDao.class).findByPostId(postNo);
	}

	@Override
	public void updatePost(PostDto post) {
		sqlSession.getMapper(PostDao.class).updatePost(post);
	}

	@Override
	public List<PostDto> postFindByTitle(String search, int currentPage, int pageSize) {
		return sqlSession.getMapper(PostDao.class).postFindByTitle(search, currentPage, pageSize);
	}

	@Override
	public List<PostDto> postFindByNickName(String search, int currentPage, int pageSize) {
		return sqlSession.getMapper(PostDao.class).postFindByNickName(search, currentPage, pageSize);
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
