package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Member;

public interface MemberRepository extends JpaRepository<Member, Integer>, MemberRepositoryCustom{
	@Transactional
	@Query(value = "SELECT m FROM Member m WHERE id LIKE :#{#member.id} AND useyn = 'Y'")
	public Member getMemberById(@Param("member") Member member);
}
