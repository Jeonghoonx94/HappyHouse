package com.ssafy.happyhouse.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.PostDto;

@Mapper
public interface PostDao {

    int getPostCount(Map<String, Object> map);
    List<PostDto> findAllPost(Map<String, Object> map);
    PostDto findByPostNo(int postNo);
    void updatePost(PostDto post);
    void insertPost(PostDto post);
    void deletePost(int postNo);
}
