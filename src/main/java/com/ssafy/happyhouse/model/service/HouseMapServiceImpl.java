package com.ssafy.happyhouse.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.apache.ibatis.session.SqlSession;
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
	private SqlSession sqlSession;

	@Override
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return sqlSession.getMapper(HouseMapDao.class).getSido();
	}

	@Override
	public List<SidoGugunCodeDto> getGugunInSido(String sido) throws Exception {
		return sqlSession.getMapper(HouseMapDao.class).getGugunInSido(sido);
	}

	@Override
	public List<HouseInfoDto> getDongInGugun(String gugun) throws Exception {
		return sqlSession.getMapper(HouseMapDao.class).getDongInGugun(gugun);
	}

	@Override
	public List<HouseInfoDto> getAptInDong(String dong, String type) throws Exception {
		return sqlSession.getMapper(HouseMapDao.class).getAptInDong(dong, type);
	}

}
