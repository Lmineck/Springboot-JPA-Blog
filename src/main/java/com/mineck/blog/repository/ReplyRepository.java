package com.mineck.blog.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mineck.blog.model.Reply;

public interface ReplyRepository extends JpaRepository<Reply, Integer>{
	
}
