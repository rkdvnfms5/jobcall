package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Notification;

public interface NotificationRepositoryCustom {
	public List<Notification> getNotificationList(Notification param);
	public int confirmNotification(Notification param);
}
