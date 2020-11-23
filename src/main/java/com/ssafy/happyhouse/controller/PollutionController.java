package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.PollutionDto;
import com.ssafy.happyhouse.model.service.PollutionService;

@RestController
@RequestMapping("/pollution")
public class PollutionController {

	@Autowired
	private PollutionService pollutionService;
	
	@GetMapping(value = "/list", headers = { "Content-type=application/json" })
	public List<PollutionDto> getPollutions(@RequestParam String dong) throws Exception {
		return pollutionService.getPollutionsInDong(dong);
	}
}