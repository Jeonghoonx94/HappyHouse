package com.ssafy.happyhouse.model.service;

import com.ssafy.happyhouse.model.dao.LocationDao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.LocationDto;

@Service
public class LocationServiceImpl implements LocationService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void addLocation(LocationDto location) throws Exception{
		sqlSession.getMapper(LocationDao.class).addLocation(location);
	}

	@Override
	public List<LocationDto> locationList() throws Exception {
		return sqlSession.getMapper(LocationDao.class).locationList();
	}
	
	@Override
	public int totalCount(Map<String, String> map) throws Exception {
		return sqlSession.getMapper(LocationDao.class).totalCount(map);
	}

	@Override
	public void deleteLocation(int no) throws Exception {
		sqlSession.getMapper(LocationDao.class).deleteLocation(no);
	}

}
