package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkGroup;

public interface WorkGroupRepository extends JpaRepository<WorkGroup, Integer>, WorkGroupRepositoryCustom{
	@Transactional
	@Query(value = "SELECT wg FROM WorkGroup wg WHERE work_seq = :#{#workGroup.work_seq}")
	public Work getWorGroupList(@Param("workGroup") WorkGroup workGroup);
}
