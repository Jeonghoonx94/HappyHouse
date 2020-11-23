package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.LocationDto;

public interface LocationService {

	public void addLocation(LocationDto location) throws Exception;
	public List<LocationDto> locationList() throws Exception;
	public int totalCount(Map<String, String> map) throws Exception;
	public void deleteLocation(int no) throws Exception;
}
