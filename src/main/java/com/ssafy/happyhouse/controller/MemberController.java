package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
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

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@RequestParam Map<String, String> map, Model model, HttpSession session, HttpServletResponse response) {
		try {
			MemberDto memberDto = memberService.login(map);
			if(memberDto != null) {
				session.setAttribute("userinfo", memberDto);				
			} else {
				model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
			return "error/error";
		}
		return "index";
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping(value = "/listMember", headers = { "Content-type=application/json" })
	public List<MemberDto> listMember(@RequestParam Map<String, String> map) {
		String key  = map.get("key"); 
		String word = map.get("word"); 
		String pageNo = map.get("pageNo"); 
		PageBean bean = new PageBean(key, word, pageNo);
		
		return memberService.searchAll(bean);
	}

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String login() {
		return "/join";
	}
	
	@PostMapping(value = "/mvJoin", headers = { "Content-type=application/json" })
	public List<MemberDto> insertMember(MemberDto memberDto) {
		memberService.insertMember(memberDto);
		return memberService.searchAllList();
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
		return memberService.searchAllList();
	}

	
}
