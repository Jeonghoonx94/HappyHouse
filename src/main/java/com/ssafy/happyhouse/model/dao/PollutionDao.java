package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.PollutionDto;

@Mapper
public interface PollutionDao {

	List<PollutionDto> getPollutionsInDong(String dong) throws Exception;
}
