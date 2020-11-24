package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.PollutionDto;
import com.ssafy.happyhouse.model.dao.PollutionDao;

@Service
public class PollutionServiceImpl implements PollutionService {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<PollutionDto> getPollutionsInDong(String dong) throws Exception {
		return sqlSession.getMapper(PollutionDao.class).getPollutionsInDong(dong);
	}

}
