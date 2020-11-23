package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.StoreDto;

@Mapper
public interface StoreDao {

	List<StoreDto> getStoresInDong(String dong) throws Exception;
}
