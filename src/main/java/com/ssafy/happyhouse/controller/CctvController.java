package com.ssafy.happyhouse.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.CctvDto;
import com.ssafy.happyhouse.model.service.CctvService;

@CrossOrigin(origins = { "*" }, maxAge = 6000)
@RestController
@RequestMapping("/cctv")
public class CctvController {
	
	@Autowired
	CctvService cctvService;

	@GetMapping(value="/list", headers = { "Content-type=application/json" })
	public List<CctvDto> list() {
		return cctvService.list();
	}
	
	@GetMapping(value="/search", headers = { "Content-type=application/json" })
	public List<CctvDto> search(@RequestParam String dong) {
		return cctvService.search(dong);
	}
}
