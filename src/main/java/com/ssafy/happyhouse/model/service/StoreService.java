package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.StoreDto;

public interface StoreService {

	List<StoreDto> getStoresInDong(String dong) throws Exception;
}
