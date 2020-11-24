package com.ssafy.happyhouse.controller;

import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/")
public class LoginController {
	
		@Autowired
		private MemberService memberService;
		
		@PostMapping(value = "/login")
		public String login(@RequestParam Map<String, String> map, Model model, HttpSession session, HttpServletResponse response) {
			try {
				MemberDto memberDto = memberService.login(map);
				if(memberDto != null) {
					session.setAttribute("userlogin", memberDto);				
				} else {
					model.addAttribute("msg", "아이디 또는 비밀번호 확인 후 로그인해 주세요.");
				}
				return "index";
			} catch (Exception e) {
				e.printStackTrace();
				model.addAttribute("msg", "로그인 중 문제가 발생했습니다.");
				return "error/error";
			}
		}

		@GetMapping(value = "/logout")
		public String logout(HttpSession session) {
			session.invalidate();
			return "redirect:/";
		}

		@PostMapping(value = "/findpwd")
		public String forgotpwd(@RequestParam Map<String, String> map, Model model) {
			try {
				String getpwd = memberService.getPwd(map);
				if(getpwd != null) {
				    model.addAttribute("msg", "비밀번호는 " + getpwd + " 입니다.");
				} else {
					model.addAttribute("msg", "입력하신 아이디와 이메일 정보가 다릅니다.");
				}
				return "member/findPassword";
			} catch (Exception e) {
				e.printStackTrace();
				return "error/error";
			}
		}
		
		@GetMapping(value = "/loc/list", headers = { "Content-type=application/json" })
		public String location() throws Exception{
			return "location";
		}
		
}
