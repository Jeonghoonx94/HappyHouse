package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.NoticeDto;

public interface NoticeService {

	public void writeNotice(NoticeDto notice) throws Exception;
	public NoticeDto detailNotice(int no) throws Exception;
	public List<NoticeDto> noticeList(Map<String, String> map) throws Exception;
	public void deleteNotice(int no) throws Exception;
	public void updateNotice(NoticeDto notice) throws Exception;
}
