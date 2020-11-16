package com.ssafy.happyhouse.controller;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.HouseInfoDto;
import com.ssafy.happyhouse.model.SidoGugunCodeDto;
import com.ssafy.happyhouse.model.service.HouseMapService;

@RestController
@RequestMapping("/map")
public class HouseMapController {

	@Autowired
	private HouseMapService houseMapService;
	
	@GetMapping(value = "/sido", headers = { "Content-type=application/json" })
	public List<SidoGugunCodeDto> getSido() throws Exception {
		return houseMapService.getSido();
	}
	
	@GetMapping(value = "/gugun", headers = { "Content-type=application/json" })
	public List<SidoGugunCodeDto> getGugun(@RequestParam("sido") String sido) throws Exception {
		return houseMapService.getGugunInSido(sido);
	}
	
	@GetMapping(value = "/dong", headers = { "Content-type=application/json" })
	public List<HouseInfoDto> getDong(@RequestParam("gugun") String gugun) throws Exception {
		return houseMapService.getDongInGugun(gugun);
	}
	
	@GetMapping(value = "/apt", headers = { "Content-type=application/json" })
	public List<HouseInfoDto> getApt(@RequestParam("dong") @Param("dong") String dong, @RequestParam("type") @Param("type") String type) throws Exception {
		return houseMapService.getAptInDong(dong, type);
	}

}