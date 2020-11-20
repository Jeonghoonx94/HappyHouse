package com.ssafy.happyhouse.model.service;

import java.util.List;

import com.ssafy.happyhouse.model.CommentDto;

public interface CommentService {
    void insertComment(CommentDto comment);
    List<CommentDto> findAllComment(int postNo);
    void postCommentAllDelete(int postNo);
    void deleteComment(int commentNo);
    CommentDto findOneComment(int commentNo);
    void updateComment(String content, String updateTime, int commentNo);
}
