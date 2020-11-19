package com.ssafy.happyhouse.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.service.NoticeService;

@Controller
@RequestMapping("/")
public class NoticeController {

	@Autowired
	private NoticeService noticeService;

	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public String noticeList(@RequestParam Map<String, String> map, Model model){
		try {
			model.addAttribute("noticelist", noticeService.noticeList(map));
			return "/notice";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
   
	@RequestMapping(value = "/detailNotice", method = RequestMethod.GET)
	public String detailBoard(@PathVariable int no) {
		try {
			noticeService.detailNotice(no);
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@RequestMapping(value = "/writeNotice", method = RequestMethod.POST)
	public String writeBoard(@RequestBody NoticeDto notice) {
		try {
			noticeService.writeNotice(notice);
			return "/notice";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@RequestMapping(value = "/updateNotice", method = RequestMethod.GET)
	public String updateBoard(@RequestBody NoticeDto notice) {
		try {
			noticeService.updateNotice(notice);
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}

	@RequestMapping(value = "/deleteNotice", method = RequestMethod.GET)
	public String deleteBoard(@PathVariable int no) {
		try {
			noticeService.deleteNotice(no);
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "error/error";
		}
	}
}
