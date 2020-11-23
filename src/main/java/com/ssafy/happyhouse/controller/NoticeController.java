package com.ssafy.happyhouse.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@GetMapping(value = "/list")
	public String noticeList(@RequestParam Map<String, String> map, Model model){
		try {
			model.addAttribute("noticelist", noticeService.noticeList(map));
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
			model.addAttribute("noticelist", noticeService.noticeList(null));
			return "notice/list";
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
