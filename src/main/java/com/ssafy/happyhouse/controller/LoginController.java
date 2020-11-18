package com.ssafy.happyhouse.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
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
public class LoginController {
	
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
					session.setAttribute("userlogin", memberDto);				
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

}
