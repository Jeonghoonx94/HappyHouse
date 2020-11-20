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

import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PostDto;
import com.ssafy.happyhouse.model.service.CommentService;
import com.ssafy.happyhouse.model.service.MemberService;
import com.ssafy.happyhouse.model.service.PostService;

@Controller
@RequestMapping("/post")
public class PostController {

	@Autowired
	PostService postService;
	@Autowired
	MemberService memberService;
	@Autowired
	CommentService commentService;

	@GetMapping("/list")
	public String postMain(Model model, @RequestParam(value = "page", defaultValue = "1") int page, // defaultValue :
																									// 파라미터 값이 없을 때
																									// default 값
			@RequestParam(value = "pageSize", defaultValue = "7") int pageSize) {

		// 페이지네이션 포함
		int totalPostCount = postService.postAllCount(); // 전체 게시글 수
		int totalCount = totalPostCount / pageSize + 1; // 총 페이지 수
		page = (page - 1) * pageSize;
		List<PostDto> postList = postService.postFindAll(page, pageSize);

		model.addAttribute("posts", postList);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("page", page);
		model.addAttribute("totalPage", totalCount);
		return "post/postMain";
	}

	@PostMapping("/list")
	public String postMain(Model model, @RequestParam("select") String select, @RequestParam("search") String search) {

		model.addAttribute("select", select);

		if (select.equals("title")) {
			List<PostDto> posts = postService.postFindByTitle(search, 0, 7);
			model.addAttribute("posts", posts);
			return "post/postMainTitle";
		}

		List<PostDto> posts = postService.postFindByUserName(search, 0, 7);
		model.addAttribute("posts", posts);
		return "post/postMainUserName";
	}

	@GetMapping("/view")
	public String postView(Model model, @RequestParam("postId") int postId, HttpSession session) {

		PostDto post = postService.findByPostId(postId);
		post.setCount(post.getCount() + 1);
		postService.updatePost(post);
		String loginId = (String) session.getAttribute("userId");
		MemberDto member = memberService.searchMember(loginId);
		model.addAttribute("posts", post);
		if (post.getUserid() == member.getUserid()
//				|| member.getUserid() == "admin"	// 관리자인 경우
				) {
			return "post/postView";
		}
		return "post/postOnlyView";
	}

	@GetMapping("/write")
	public String postWrite(Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("userId");
		MemberDto member = memberService.searchMember(loginId);
		model.addAttribute("member", member);

		return "post/writePost";
	}

	@PostMapping("/write")
	public String postWrite(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("nickname") String nickname, @RequestParam("memberId") String memberId) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		PostDto post = new PostDto(memberId, title, content, nickname, 1, sdf.format(new Date()),
				sdf.format(new Date()));
		postService.insertPost(post);
		return "redirect:/post/list";
	}

	@GetMapping("/update")
	public String postUpdateRedirect(Model model, @RequestParam("postId") int postId) {
		PostDto post = postService.findByPostId(postId);
		model.addAttribute("posts", post);
		return "post/postUpdate";
	}

	@PostMapping("/update")
	public String postUpdate(@RequestParam("postId") int postId, @RequestParam("title") String title,
			@RequestParam("content") String content) {
		PostDto post = postService.findByPostId(postId);
		post.setTitle(title);
		post.setContent(content);
		post.setCount(post.getCount());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		post.setUpdateTime(sdf.format(new Date()));
		postService.updatePost(post);

		return "redirect:/post/list";
	}

	@GetMapping("/delete")
	public String postDelete(@RequestParam("postId") int postId) {
		postService.deletePost(postId);
		return "redirect:/postComment/deleteAll?postId=" + postId;
	}

	@GetMapping("postComment/deleteAll")
	public String postCommentDeleteAll(@RequestParam("postId") int postId) {
		commentService.postCommentAllDelete(postId);
		return "redirect:/post/list";
	}

	@GetMapping("notice")
	public String notice() {
		return "notice/notice";
	}
}
