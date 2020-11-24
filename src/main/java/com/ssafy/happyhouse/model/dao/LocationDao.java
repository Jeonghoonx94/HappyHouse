package com.ssafy.happyhouse.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.LocationDto;
import com.ssafy.happyhouse.model.PageBean;

@Mapper
public interface LocationDao {
	
	public void addLocation(LocationDto location) throws Exception;
	public List<LocationDto> locationList(String userid) throws Exception;
	public int totalCount(Map<String, String> map) throws Exception;
	public void deleteLocation(int no) throws Exception;
}
