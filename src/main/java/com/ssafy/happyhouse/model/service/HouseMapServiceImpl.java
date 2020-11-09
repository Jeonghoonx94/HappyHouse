package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.dao.HouseMapDao;

@Service
public class HouseMapServiceImpl implements HouseMapService {
	
//	private static HouseMapService houseMapService;
//	
//	private HouseMapServiceImpl() {}
//	
//	public static HouseMapService getHouseMapService() {
//		if(houseMapService == null)
//			houseMapService = new HouseMapServiceImpl();
//		return houseMapService;
//	}
	@Autowired
	private HouseMapDao dao;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return dao.getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return dao.getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return dao.getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong, String type) throws Exception {
		return dao.getAptInDong(dong, type);
	}

}
