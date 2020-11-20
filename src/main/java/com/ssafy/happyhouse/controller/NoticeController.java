package com.ssafy.happyhouse.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	public String detailNotice(@PathVariable int no) {
		try {
			noticeService.detailNotice(no);
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

	@GetMapping(value = "/update")
	public String updateNotice(NoticeDto notice) {
		try {
			noticeService.updateNotice(notice);
			return "notice/detail";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@GetMapping(value = "/delete")
	public String deleteNotice(@PathVariable int no) {
		try {
			noticeService.deleteNotice(no);
			return "notice/list";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
}
