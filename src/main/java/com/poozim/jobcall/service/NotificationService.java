package com.poozim.jobcall.service;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Transient;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Notification;
import com.poozim.jobcall.repository.NotificationRepository;

@EnableCaching
@Service
public class NotificationService {

	@Autowired
	private NotificationRepository notificationRepository;
	
	@Transactional
	@CacheEvict(value = "notiCount", 
				key = "#notification.member_seq")
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
	
	@Transactional
	public int updateNotificationList(Notification notification) {
		int res = notificationRepository.confirmNotification(notification);
		return res;
	}
	
	@Cacheable(value = "notiCount", 
			   key = "#notification.member_seq", 
			   condition = "#notification.confirmyn == 'N'")
	public int getNotificationCount(Notification notification) {
		return notificationRepository.getNotificationCount(notification);
	}
	
	@CacheEvict(value = "notiCount", 
				key = "#notification.member_seq")
	public int insertNotification(Notification notification) {
		notificationRepository.save(notification);
		return 1;
	}
}
