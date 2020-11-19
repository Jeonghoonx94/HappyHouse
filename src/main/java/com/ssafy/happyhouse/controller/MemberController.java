package com.ssafy.happyhouse.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/")
public class MemberController{

    @Autowired
    private MemberService memberService;

    @ExceptionHandler
    public ModelAndView handler(Exception e) {
        ModelAndView mav = new ModelAndView("error/error");
        mav.addObject("msg", e.getMessage());
        e.printStackTrace();
        return mav;
    }

	@RequestMapping(value = "/listMember", method = RequestMethod.GET)
	public String searchAll(@RequestParam Map<String, String> map, Model model) {
		List<MemberDto> userlist = memberService.searchAll(map);
	    model.addAttribute("userlist", userlist);
	    return "/listMember";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String insertMember(MemberDto memberDto) {
	    memberService.insertMember(memberDto);
	    return "index";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String insertMember() {
	    return "/join";
	}
	
	@RequestMapping(value = "/infoMember", method = RequestMethod.GET)
	public String searchMember(@RequestParam String userid, Model model) {
	    model.addAttribute("member", memberService.searchMember(userid));
	    return "/infoMember";
	}
	
	@RequestMapping(value = "/findpwd", method = RequestMethod.POST)
	public String forgotpwd(@RequestParam Map<String, String> map, Model model) {
		String getpwd = memberService.getPwd(map);
		if(getpwd != null) {
	    model.addAttribute("msg", "비밀번호는 " + getpwd + " 입니다.");
		} else {
		    model.addAttribute("msg", "입력하신 아이디와 이메일 정보가 다릅니다.");
		}
	    return "modal/findPassword";
	}
	
	@RequestMapping(value = "/updateMember", method = RequestMethod.POST)
	public String updateMember(MemberDto memberDto, Model model) {
	    memberService.updateMember(memberDto);
	    model.addAttribute("member", memberService.searchMember(memberDto.getUserid()));
	    return "/infoMember";
	}
	
	@RequestMapping(value = "/removeMember", method = RequestMethod.GET)
	public String removeMember(@RequestParam String userid, HttpSession session) {
	    memberService.removeMember(userid);
	    session.invalidate();
	    return "redirect:/";
	}
}