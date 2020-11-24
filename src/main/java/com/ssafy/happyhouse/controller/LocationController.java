package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.happyhouse.model.LocationDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.LocationService;

@RestController
@RequestMapping("/loc")
public class LocationController {

	@Autowired
	private LocationService locationService;

	@PostMapping(value = "/list", headers = { "Content-type=application/json" })
	public List<LocationDto> locationList(HttpSession session) throws Exception{
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		return locationService.locationList(member.getUserid());
	}
   
	@GetMapping(value = "/add", headers = { "Content-type=application/json" })
	public List<LocationDto> addLocation(LocationDto location, Model model, HttpSession session) throws Exception {
		Map<String, String> map = new HashMap<>();
		map.put("userid", location.getUserid());
		map.put("dong", location.getDong());
		
		if(locationService.totalCount(map) == 0) {
			locationService.addLocation(location);
		}
		return locationService.locationList(map.get("userid"));
	}

	@DeleteMapping(value = "/delete/{no}", headers = { "Content-type=application/json" })
	public List<LocationDto> deleteLocation(@PathVariable int no, HttpSession session) throws Exception{
		locationService.deleteLocation(no);
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		return locationService.locationList(member.getUserid());
	}
}