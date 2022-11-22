package com.mineck.blog.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.mineck.blog.model.Board;
import com.mineck.blog.model.User;

public interface BoardRepository extends JpaRepository<Board, Integer>{
	
}
