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
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.CommentDto;
import com.ssafy.happyhouse.model.MemberDto;
import com.ssafy.happyhouse.model.PostDto;
import com.ssafy.happyhouse.model.service.CommentService;
import com.ssafy.happyhouse.model.service.MemberService;
import com.ssafy.happyhouse.model.service.PostService;

@Controller
//@RequestMapping("/")
public class PostController {

	@Autowired
	PostService postService;
	@Autowired
	MemberService memberService;
	@Autowired
	CommentService commentService;

	@GetMapping("/post/list")
	public String postMain(Model model, @RequestParam(value = "page", defaultValue = "1") int page, // defaultValue :
																									// 파라미터 값이 없을 때
																									// default 값
			@RequestParam(value = "pageSize", defaultValue = "7") int pageSize) {
		pageSize=5;
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

	@PostMapping("/post/list")
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

	@GetMapping("/post/view")
	public String postView(Model model, @RequestParam("postId") int postId, HttpSession session) {

		try {
			PostDto post = postService.findByPostId(postId);
			// 조회수
			post.setCount(post.getCount() + 1);
			postService.updatePost(post);
			String loginId = ((MemberDto) session.getAttribute("userlogin")).getUserid();
			if(loginId == null) {
				model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
				return "error/error";
			}
			MemberDto member = memberService.searchMember(loginId);
			model.addAttribute("posts", post);
			// 댓글
			List<CommentDto> list = commentService.findAllComment(postId);
			model.addAttribute("list", list);
			if (post.getUserid().equals(member.getUserid())
//				|| "admin".equals(member.getUserid())	// 관리자인 경우
			) {
				return "post/postView";
			} else {
				return "post/postOnlyView";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			model.addAttribute("msg", e.getMessage());
			return "error/error";
		}
	}

	@GetMapping("/post/write")
	public String postWrite(Model model, HttpSession session) {
		try {
			String loginId = ((MemberDto) session.getAttribute("userlogin")).getUserid();
			if(loginId == null) {
				model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
				return "error/error";
			}
			MemberDto member = memberService.searchMember(loginId);
			model.addAttribute("member", member);

			return "post/writePost";
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "error/error";
		}
	}

	@PostMapping("/post/write")
	public String postWrite(@RequestParam("title") String title, @RequestParam("content") String content,
			@RequestParam("nickname") String nickname, HttpSession session) {
		String loginId = ((MemberDto) session.getAttribute("userlogin")).getUserid();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		PostDto post = new PostDto(loginId, title, content, nickname, 1, sdf.format(new Date()),
				sdf.format(new Date()));
		postService.insertPost(post);
		return "redirect:/post/list";
	}

	@GetMapping("/post/update")
	public String postUpdateRedirect(Model model, @RequestParam("postId") int postId) {
		PostDto post = postService.findByPostId(postId);
		model.addAttribute("posts", post);
		return "post/postUpdate";
	}

	@PostMapping("/post/update")
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

	@GetMapping("/post/delete")
	public String postDelete(@RequestParam("postId") int postId) {
		postService.deletePost(postId);
		return "redirect:/postComment/deleteAll?postId=" + postId;
	}

	@GetMapping("/postComment/deleteAll")
	public String postCommentDeleteAll(@RequestParam("postId") int postId) {
		commentService.postCommentAllDelete(postId);
		return "redirect:/post/list";
	}

//	@GetMapping("notice")
//	public String notice() {
//		return "notice/notice";
//	}
}
