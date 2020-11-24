package com.ssafy.happyhouse.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PostDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping(value = "/list")
	public String noticeList(@RequestParam Map<String, Object> map, Model model){
		try {
			String pageStr = (String) map.get("page");
			String pageSizeStr = (String) map.get("pageSize");
			int page = pageStr == null ? 1 : ("".equals(pageStr) ? 1 : Integer.parseInt(pageStr));
			int pageSize = pageSizeStr == null ? 7 : ("".equals(pageSizeStr) ? 7 : Integer.parseInt(pageSizeStr));

			// Pagination
			map.put("page", page); // 현재 페이지
			map.put("pageSize", pageSize); // 한 페이지에 나타낼 게시글 수
			int totalNoticeCount = noticeService.totalCount(map); // 전체 게시글 수 : 검색 결과 포함
			int totalPage = totalNoticeCount / pageSize; // 총 페이지 수
			if (totalNoticeCount % pageSize != 0) {
				totalPage++;
			}
			int startNo = (page - 1) * pageSize; // 해당 페이지의 가장 위에 보여줄 게시글 번호
			map.put("startNo", startNo);

			List<NoticeDto> noticeList = noticeService.noticeList(map);

			model.addAttribute("noticelist", noticeList);
			model.addAttribute("pageSize", pageSize);
			model.addAttribute("page", page);
			model.addAttribute("totalPage", totalPage);

			return "notice/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
   
	@GetMapping(value = "/detail")
	public String detailNotice(@RequestParam("no") int no, Model model) {
		try {
			model.addAttribute("notice", noticeService.detailNotice(no));
			return "notice/detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@PostMapping(value = "/write")
	public String writeNotice(NoticeDto notice, Model model) {
		try {
			noticeService.writeNotice(notice);
//			model.addAttribute("noticelist", noticeService.noticeList(null));
			return "redirect:/notice/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@PostMapping(value = "/update")
	public String updateNotice(NoticeDto notice, Model model) {
		try {
			noticeService.updateNotice(notice);
			model.addAttribute("notice", noticeService.detailNotice(notice.getNo()));
			return "notice/detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@GetMapping(value = "/delete")
	public String deleteNotice(@RequestParam int no) {
		try {
			noticeService.deleteNotice(no);
			return "redirect:/";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
}
