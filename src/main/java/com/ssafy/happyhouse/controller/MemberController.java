package com.ssafy.happyhouse.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PageBean;
import com.ssafy.happyhouse.model.service.MemberService;
import com.ssafy.happyhouse.model.service.MemberServiceImpl;

@RestController
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

	@PostMapping(value = "/login.member")
	public ModelAndView login(@RequestParam Map<String, String> map, Model model, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		try {
			MemberDto memberDto = memberService.login(map);
			if(memberDto != null) {
				session.setAttribute("userinfo", memberDto);
				
				Cookie cookie = new Cookie("ssafy_id", memberDto.getUserid());
				cookie.setPath("/");
				if("saveok".equals(map.get("idsave"))) {
					cookie.setMaxAge(60 * 60 * 24 * 365 * 40);//40년간 저장.
				} else {
					cookie.setMaxAge(0);
				}
				response.addCookie(cookie);
				
			} else {
				model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
//			return "error/error";
			return handler(e);
		}
		return new ModelAndView("redirect:/");
	}

	@GetMapping(value = "/logout.member")
	public ModelAndView logout(HttpSession session) {
		session.invalidate();
		return new ModelAndView("redirect:/");
	}

	@GetMapping(value = "/listMember.member", headers = { "Content-type=application/json" })
	public List<MemberDto> listMember(@RequestParam Map<String, String> map) {
		String key  = map.get("key"); 
		String word = map.get("word"); 
		String pageNo = map.get("pageNo"); 
		PageBean bean = new PageBean(key, word, pageNo);
		
		return memberService.searchAll(bean);
	}

	@GetMapping(value = "/join.member")
	public ModelAndView join() {
		return new ModelAndView("redirect:join");
	}
	
	@PostMapping(value = "/mvJoin.member", headers = { "Content-type=application/json" })
//	public List<MemberDto> insertMember(@RequestBody MemberDto MemberDto) {
	public ModelAndView insertMember(@RequestBody MemberDto MemberDto) {
		memberService.insertMember(MemberDto);
		return new ModelAndView("redirect:index");
//		return memberService.searchAll(new PageBean());
	}

	@GetMapping(value = "/infoMember.member/{userid}", headers = { "Content-type=application/json" })
	public MemberDto searchMember(@PathVariable("userid") String id) {
		return memberService.searchMember(id);
	}

	@GetMapping(value = "/forgotpwd.member", headers = { "Content-type=application/json" })
	public String forgotpwd(@RequestParam Map<String, String> map) {
		return memberService.forgotpwd(map);
	}

	@PutMapping(value = "/updateMember.member", headers = { "Content-type=application/json" })
	public MemberDto updateMember(@RequestParam MemberDto MemberDto) {
		memberService.updateMember(MemberDto);
		return memberService.searchMember(MemberDto.getUserid());
	}

	@DeleteMapping(value = "/removeMember.member/{userid}", headers = { "Content-type=application/json" })
	public List<MemberDto> removeMember(@PathVariable("userid") String id) {
		memberService.removeMember(id);
		return memberService.searchAll(new PageBean());
	}

	
}
