package com.poozim.jobcall.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poozim.jobcall.model.Notification;
import com.poozim.jobcall.repository.NotificationRepository;

@Service
public class NotificationService {

	@Autowired
	private NotificationRepository notificationRepository;
	
	@Transient
	public List<Notification> getNotificationList(Notification notification){
		List<Notification> list = notificationRepository.getNotificationList(notification);
		
		List<Integer> seqList = new ArrayList<Integer>();
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getConfirmyn().equals("N")) {
				seqList.add(list.get(i).getSeq());
			}
		}
		notification.setSeqList(seqList);
		updateNotificationList(notification);
		return list;
	}
	
	@Transient
	public int updateNotificationList(Notification notification) {
		int res = notificationRepository.confirmNotification(notification);
		return res;
	}
	
	public int getNotificationCount(Notification notification) {
		return notificationRepository.getNotificationCount(notification);
	}
}
