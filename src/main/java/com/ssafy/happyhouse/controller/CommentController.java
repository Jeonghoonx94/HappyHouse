package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.service.CommentService;
import com.ssafy.happyhouse.model.service.MemberService;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	CommentService commentService;
	@Autowired
	MemberService memberService;

	@RequestMapping(value = "/view", method = RequestMethod.POST)
	public String insertAndAllCommentView(Model model, @RequestParam("postId") int postId,
			@RequestParam("content") String content, HttpSession session) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String loginId = (String) session.getAttribute("userId");
			MemberDto member;
			member = memberService.searchMember(loginId);
			CommentDto comment = new CommentDto(postId, member.getUserid(), content, sdf.format(new Date()),
					sdf.format(new Date()));
			commentService.insertComment(comment);
			List<CommentDto> list = commentService.findAllComment(postId);
			model.addAttribute("postId", postId);
			model.addAttribute("list", list);
			return "comment/commentView";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error/error";
		}
	}

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String commentAllList(Model model, @RequestParam("postId") int postId) {
		List<CommentDto> list = commentService.findAllComment(postId);
		model.addAttribute("postId", postId);
		model.addAttribute("list", list);
		return "comment/commentView";
	}

	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String commentDelete(@RequestParam("commentId") int commentId) {
		CommentDto comment = commentService.findOneComment(commentId);
		commentService.deleteComment(commentId);
		return "redirect:/comment/list?postId=" + comment.getPostNo();
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String commentUpdate(Model model, @RequestParam("commentId") int commentId) {
		CommentDto comment = commentService.findOneComment(commentId);
		model.addAttribute("comment", comment);
		return "comment/commentUpdate";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String commentUpdate(@RequestParam("content") String content, @RequestParam("postId") int postId,
			@RequestParam("commentId") int commentId) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		commentService.updateComment(content, sdf.format(new Date()), commentId);
		return "redirect:/comment/list?postId=" + postId;
	}
}
