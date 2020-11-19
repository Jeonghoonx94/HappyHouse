package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/")
public class MemberController{

    @Autowired
    private MemberService memberService;

	@RequestMapping(value = "/listMember", method = RequestMethod.GET)
	public String searchAll(@RequestParam Map<String, String> map, Model model) {
		try {
			List<MemberDto> userlist = memberService.searchAll(map);
		    model.addAttribute("userlist", userlist);
		    return "/listMember";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String insertMember(MemberDto memberDto) {
	    try {
			memberService.insertMember(memberDto);
		    return "index";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String insertMember() {
	    return "/join";
	}
	
	@RequestMapping(value = "/infoMember", method = RequestMethod.GET)
	public String searchMember(@RequestParam String userid, Model model) {
	    try {
			model.addAttribute("member", memberService.searchMember(userid));
		    return "/infoMember";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public String updateMember(MemberDto memberDto, Model model) {
	    try {
		    memberService.updateMember(memberDto);
			model.addAttribute("member", memberService.searchMember(memberDto.getUserid()));
		    return "/infoMember";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@RequestMapping(value = "/removeMember", method = RequestMethod.GET)
	public String removeMember(@RequestParam String userid, HttpSession session) {
	    try {
			memberService.removeMember(userid);
		    session.invalidate();
		    return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
}