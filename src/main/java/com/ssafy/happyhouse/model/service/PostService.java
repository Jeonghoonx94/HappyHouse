package com.ssafy.happyhouse.model.service;

import java.util.List;
import java.util.Map;

import com.ssafy.happyhouse.model.PostDto;

public interface PostService {

    int getPostCount(Map<String, Object> map);
    List<PostDto> findAllPost(Map<String, Object> map);
    PostDto findByPostNo(int postNo);
    void updatePost(PostDto post);
    void insertPost(PostDto post);
    void deletePost(int postNo);
}
