package com.ssafy.happyhouse.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/")
public class NoticeController {
	
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String notice() {
	    return "/notice";
	}
	
}
