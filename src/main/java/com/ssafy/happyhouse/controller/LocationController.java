package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.LocationDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.LocationService;

@Controller
@RequestMapping("/loc")
public class LocationController {

	@Autowired
	private LocationService locationService;

	@GetMapping(value = "/list")
	public String locationList(Model model){
		try {
			model.addAttribute("locationlist", locationService.locationList());
			return "location";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
   
	@GetMapping(value = "/add")
	public String addLocation(LocationDto location, Model model, HttpSession session) {
		try {
			Map<String, String> map = new HashMap<>();
			map.put("userid", location.getUserid());
			map.put("dong", location.getDong());
			if(locationService.totalCount(map) == 0) {
				locationService.addLocation(location);
			}
			model.addAttribute("locationlist", locationService.locationList());
			return "redirect:/loc/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@GetMapping(value = "/delete")
	public String deleteLocation(@RequestParam int no) {
		try {
			locationService.deleteLocation(no);
			return "redirect:/loc/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
}