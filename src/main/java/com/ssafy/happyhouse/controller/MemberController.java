package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

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
@RequestMapping("/member")
public class MemberController{

    @Autowired
    private MemberService memberService;

    @GetMapping(value = "/list")
	public String searchAll(@RequestParam Map<String, Object> map, Model model) {
		try {
			String pageStr = (String) map.get("page");
			String pageSizeStr = (String) map.get("pageSize");
			int page = pageStr == null ? 1 : ("".equals(pageStr) ? 1 : Integer.parseInt(pageStr));
			int pageSize = pageSizeStr == null ? 7 : ("".equals(pageSizeStr) ? 7 : Integer.parseInt(pageSizeStr));

			// Pagination
			map.put("page", page); // 현재 페이지
			map.put("pageSize", pageSize); // 한 페이지에 나타낼 게시글 수
			int totalCount = memberService.totalCount(map); // 전체 게시글 수 : 검색 결과 포함
			int totalPage = totalCount / pageSize; // 총 페이지 수
			if (totalCount % pageSize != 0) {
				totalPage++;
			}
			int startNo = (page - 1) * pageSize; // 해당 페이지의 가장 위에 보여줄 게시글 번호
			map.put("startNo", startNo);

			String word = (String) map.get("word");
			if (word != null && !"".equals(word)) { // 검색했다면
				model.addAttribute("key", map.get("key"));
				model.addAttribute("word", map.get("word"));
			}

			
			List<MemberDto> userlist = memberService.searchAll(map);
			
			model.addAttribute("userlist", userlist);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("page", page);
			model.addAttribute("totalPage", totalPage);
		    
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