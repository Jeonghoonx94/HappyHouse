package com.ssafy.happyhouse.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.PostDto;

@Mapper
public interface PostDao {

    int postAllCount(Map<String, Object> map);
    List<PostDto> postFindAll(Map<String, Object> map);
    PostDto findByPostId(int postNo);
    void updatePost(PostDto post);
    List<PostDto> postFindByTitle(String search, int currentPage, int pageSize);
    List<PostDto> postFindByUserName(String search, int currentPage, int pageSize);
    void insertPost(PostDto post);
    void deletePost(int postNo);
}
