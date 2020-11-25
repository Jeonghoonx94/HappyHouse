package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.CctvDto;

public interface CctvService {
	List<CctvDto> list();
	List<CctvDto> search(String name);
}