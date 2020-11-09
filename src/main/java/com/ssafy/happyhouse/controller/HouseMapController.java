package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
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
	public List<SidoGugunCodeDto> getGugun(@RequestBody String sido) throws Exception {
		return houseMapService.getGugunInSido(sido);
	}
	
	@GetMapping(value = "/dong", headers = { "Content-type=application/json" })
	public List<HouseInfoDto> getDong(@RequestBody String gugun) throws Exception {
		return houseMapService.getDongInGugun(gugun);
	}
	
	@GetMapping(value = "/apt", headers = { "Content-type=application/json" })
	public List<HouseInfoDto> getApt(@RequestBody Map<String, String> map) throws Exception {
		return houseMapService.getAptInDong(map);
	}

}