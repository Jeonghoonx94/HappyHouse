package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.PollutionDto;

public interface PollutionService {

	List<PollutionDto> getPollutionsInDong(String dong) throws Exception;
}
