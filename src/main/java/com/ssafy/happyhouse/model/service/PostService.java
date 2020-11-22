package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.PostDto;

public interface PostService {

    int postAllCount(Map<String, Object> map);
    List<PostDto> postFindAll(Map<String, Object> map);
    PostDto findByPostId(int postNo);
    void updatePost(PostDto post);
    List<PostDto> postFindByTitle(String search, int currentPage, int pageSize);
    List<PostDto> postFindByUserName(String search, int currentPage, int pageSize);
    void insertPost(PostDto post);
    void deletePost(int postNo);
}
