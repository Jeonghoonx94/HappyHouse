package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController{

    @Autowired
    private MemberService memberService;

    @GetMapping(value = "/list")
	public String searchAll(@RequestParam Map<String, String> map, Model model) {
		try {
			List<MemberDto> userlist = memberService.searchAll(map);
		    model.addAttribute("userlist", userlist);
		    return "member/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
    @PostMapping(value = "/join")
	public String insertMember(MemberDto member) {
	    try {
			memberService.insertMember(member);
		    return "index";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@GetMapping(value = "/join")
	public String insertMember() {
	    return "member/join";
	}
	
	@GetMapping(value = "/info")
	public String searchMember(@RequestParam String userid, Model model) {
	    try {
			model.addAttribute("member", memberService.searchMember(userid));
		    return "member/info";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@PostMapping(value = "/update")
	public String updateMember(MemberDto member, Model model) {
	    try {
		    memberService.updateMember(member);
			model.addAttribute("member", memberService.searchMember(member.getUserid()));
		    return "member/info";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
	
	@GetMapping(value = "/remove")
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