package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.ActionLog;

public interface ActionLogRepository extends JpaRepository<ActionLog, Integer>{

}
