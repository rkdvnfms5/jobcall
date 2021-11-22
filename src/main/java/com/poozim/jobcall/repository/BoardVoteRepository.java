package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.BoardVote;

public interface BoardVoteRepository extends JpaRepository<BoardVote, Integer>{

}
