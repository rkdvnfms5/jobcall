package com.poozim.jobcall.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.poozim.jobcall.model.ActionLog;
import com.poozim.jobcall.model.Notification;

public interface NotificationRepository extends JpaRepository<Notification, Integer>, NotificationRepositoryCustom{

}
