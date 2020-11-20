package com.ssafy.happyhouse.model.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.ssafy.happyhouse.model.PostDto;

@Mapper
public interface PostDao {

    int postAllCount();
    List<PostDto> postFindAll(int page, int pageSize);
    PostDto findByPostId(int postNo);
    void updatePost(PostDto post);
    List<PostDto> postFindByTitle(String search, int currentPage, int pageSize);
    List<PostDto> postFindByUserName(String search, int currentPage, int pageSize);
    void insertPost(PostDto post);
    void deletePost(int postNo);
}
