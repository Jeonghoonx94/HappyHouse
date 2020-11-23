package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.CommentService;
import com.ssafy.happyhouse.model.service.MemberService;
import com.ssafy.happyhouse.model.service.PostService;

@Controller
@RequestMapping("/comment")
public class CommentController {
	@Autowired
	PostService postService;
	@Autowired
	CommentService commentService;
	@Autowired
	MemberService memberService;

	@PostMapping("/write")
	public String insertComment(Model model, @RequestParam int postNo, @RequestParam String content,
			HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CommentDto comment = new CommentDto(postNo, member.getUserid(), content, sdf.format(new Date()),
				sdf.format(new Date()));
		try {
			commentService.insertComment(comment);
			List<CommentDto> comments = commentService.findAllComment(postNo);
			model.addAttribute("post", postService.findByPostNo(postNo));
			model.addAttribute("comments", comments);
			return "redirect:/post/view?postNo="+postNo;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error/error";
		}
	}

	@GetMapping("/list")
	public String commentAllList(Model model, @RequestParam int postNo) {
		List<CommentDto> comments = commentService.findAllComment(postNo);
		model.addAttribute("postNo", postNo);
		model.addAttribute("comments", comments);
		return "comment/viewComment";
	}

	@GetMapping("/delete")
	public String deleteComment(@RequestParam int commentNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		CommentDto comment = commentService.findOneComment(commentNo);
		try {
			commentService.deleteComment(commentNo);
			return "redirect:/comment/list?postNo=" + comment.getPostNo();
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	@GetMapping("/update")
	public String updateComment(Model model, @RequestParam int commentNo, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		CommentDto comment = commentService.findOneComment(commentNo);
		model.addAttribute("comment", comment);
		return "comment/updateComment";
	}

	@PostMapping("/update")
	public String updateComment(@RequestParam String content, @RequestParam int postNo, @RequestParam int commentNo,
			HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			commentService.updateComment(content, sdf.format(new Date()), commentNo);
			return "redirect:/comment/list?postNo=" + postNo;
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}
}
