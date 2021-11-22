package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.BoardVoteMember;

public interface BoardVoteMemberRepository extends JpaRepository<BoardVoteMember, Integer>{
	
	@Transactional
	@Query(value = "SELECT * FROM BoardVoteMember "
			+ "WHERE vote_seq = :#{#boareVoteMember.vote_seq} "
			+ "AND member_seq = :#{#boareVoteMember.member_seq} ", 
			nativeQuery = true)
	public BoardVoteMember getBoardVoteMemberOne(@Param("boareVoteMember") BoardVoteMember boareVoteMember);
}
