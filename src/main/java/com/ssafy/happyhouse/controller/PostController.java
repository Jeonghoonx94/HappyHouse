package com.ssafy.happyhouse.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.ssafy.happyhouse.model.CommentDto;
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
	public String postMain(Model model, @RequestParam Map<String, Object> map) {

		String pageStr = (String) map.get("page");
		String pageSizeStr = (String) map.get("pageSize");
		int page = pageStr == null ? 1 : ("".equals(pageStr) ? 1 : Integer.parseInt(pageStr));
		int pageSize = pageSizeStr == null ? 5 : ("".equals(pageSizeStr) ? 5 : Integer.parseInt(pageSizeStr));

		// Pagination
		map.put("page", page); // 현재 페이지
		map.put("pageSize", pageSize); // 한 페이지에 나타낼 게시글 수
		int totalPostCount = postService.getPostCount(map); // 전체 게시글 수 : 검색 결과 포함
		int totalPage = totalPostCount / pageSize; // 총 페이지 수
		if (totalPostCount % pageSize != 0) {
			totalPage++;
		}
		int startPostNo = (page - 1) * pageSize; // 해당 페이지의 가장 위에 보여줄 게시글 번호
		map.put("startPostNo", startPostNo);

		List<PostDto> postList = postService.findAllPost(map);

		String search = (String) map.get("search");
		if (search != null && !"".equals(search)) { // 검색했다면
			model.addAttribute("select", map.get("select"));
			model.addAttribute("search", map.get("search"));
		}

		model.addAttribute("posts", postList);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("page", page);
		model.addAttribute("totalPage", totalPage);
		return "post/postMain";
	}

	@GetMapping("/view")
	public String viewPost(Model model, @RequestParam int postNo, HttpSession session) {

		try {
			PostDto post = postService.findByPostNo(postNo);
			// 조회수
			post.setCount(post.getCount() + 1);
			
			MemberDto member = (MemberDto)session.getAttribute("userlogin");
			
			if(member == null || !post.getUserid().equals(member.getUserid())) { 
				postService.updatePost(post);
			}

			model.addAttribute("post", post);

			// 댓글
			List<CommentDto> comments = commentService.findAllComment(postNo);
			model.addAttribute("comments", comments);

			return "post/postView";
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	@GetMapping("/write")
	public String moveWritePost(Model model, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		try {
			model.addAttribute("member", member);
			return "post/writePost";
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	@PostMapping("/write")
	public String writePost(@RequestParam String title, @RequestParam String content, HttpSession session, Model model) {
		System.out.println();
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		PostDto post = new PostDto(member.getUserid(), title, content, member.getUsername(), 1, sdf.format(new Date()),
				sdf.format(new Date()));
		try {
			postService.insertPost(post);
			return "redirect:/post/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	@GetMapping("/update")
	public String moveUpdatePost(Model model, @RequestParam int postNo, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		
		PostDto post = postService.findByPostNo(postNo);
		model.addAttribute("post", post);
		return "post/postUpdate";
	}

	@PostMapping("/update")
	public String updatePost(@RequestParam int postNo, @RequestParam String title, @RequestParam String content,
			Model model, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		PostDto post = postService.findByPostNo(postNo);
		post.setTitle(title);
		post.setContent(content);
		post.setCount(post.getCount());
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		post.setUpdateTime(sdf.format(new Date()));
		try {
			postService.updatePost(post);
			return "redirect:/post/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	@GetMapping("/delete")
	public String postDelete(@RequestParam int postNo, Model model, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		try {
			// 게시글 지우기
			postService.deletePost(postNo);
			// 게시글에 해당하는 댓글 지우기
			commentService.postCommentAllDelete(postNo);
			return "redirect:/post/list";
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

	// 글 보는 중에 삭제
	@GetMapping("/deleteComment")
	public String deleteComment(@RequestParam int commentNo, Model model, HttpSession session) {
		MemberDto member = (MemberDto) session.getAttribute("userlogin");
		if (member == null) {
			model.addAttribute("msg", "로그인이 필요한 서비스입니다.");
			return "index";
		}
		CommentDto comment = commentService.findOneComment(commentNo);
		try {
			commentService.deleteComment(commentNo);
			return "redirect:/post/view?postNo=" + comment.getPostNo();
		} catch (Exception e) {
			model.addAttribute("msg", e.getLocalizedMessage());
			return "error/error";
		}
	}

//	@GetMapping("notice")
//	public String notice() {
//		return "notice/notice";
//	}
}
