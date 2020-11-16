package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@RestController
@RequestMapping("/")
public class MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@ExceptionHandler
	public ModelAndView handler(Exception e) {
		ModelAndView mav = new ModelAndView("Error");
		mav.addObject("msg", e.getMessage());
		e.printStackTrace();
		return mav;
	}

	@GetMapping(value = "/listMember", headers = { "Content-type=application/json" })
	public List<MemberDto> searchAll(@RequestParam Map<String, String> map) {
		return memberService.searchAll(map);
	}
	
	@PostMapping(value = "/mvJoin", headers = { "Content-type=application/json" })
	public List<MemberDto> insertMember(MemberDto memberDto) {
		memberService.insertMember(memberDto);
		return memberService.searchAll(null);
	}

	@GetMapping(value = "/infoMember/{userid}", headers = { "Content-type=application/json" })
	public MemberDto searchMember(@PathVariable("userid") String id) {
		return memberService.searchMember(id);
	}

	@GetMapping(value = "/forgotpwd", headers = { "Content-type=application/json" })
	public String forgotpwd(@RequestParam Map<String, String> map) {
		return memberService.forgotpwd(map);
	}

	@PutMapping(value = "/updateMember", headers = { "Content-type=application/json" })
	public MemberDto updateMember(@RequestParam MemberDto MemberDto) {
		memberService.updateMember(MemberDto);
		return memberService.searchMember(MemberDto.getUserid());
	}

	@DeleteMapping(value = "/removeMember/{userid}", headers = { "Content-type=application/json" })
	public List<MemberDto> removeMember(@PathVariable("userid") String id) {
		memberService.removeMember(id);
		return memberService.searchAll(null);
	}

	
}
