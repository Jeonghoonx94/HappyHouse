package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.CommentDto;

@Mapper
public interface CommentDao {
    void insertComment(CommentDto comment);
    List<CommentDto> findAllComment(int postNo);
    void postCommentAllDelete(int postNo);
    void deleteComment(int commentNo);
    CommentDto findOneComment(int commentNo);
    void updateComment(String content, String updateTime, int commentNo);
}
