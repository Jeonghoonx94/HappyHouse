package com.ssafy.happyhouse.model.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import com.ssafy.happyhouse.model.NoticeDto;
import com.ssafy.happyhouse.model.PageBean;

@Mapper
public interface NoticeDao {
	
	public void writeNotice(NoticeDto notice) throws Exception;
	public NoticeDto detailNotice(int no) throws Exception;
	public List<NoticeDto> noticeList(Map<String, String> map) throws Exception;
	public int totalCount(PageBean bean) throws Exception;
	public void deleteNotice(int no) throws Exception;
	public void updateNotice(NoticeDto  notice) throws Exception;
}
