package com.poozim.jobcall.repository;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.Notification;
import com.poozim.jobcall.model.QNotification;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class NotificationRepositoryCustomImpl implements NotificationRepositoryCustom {

private JPAQueryFactory queryFactory;
	
	public NotificationRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
	}
	
	@Override
	public List<Notification> getNotificationList(Notification param) {
		QNotification notification = QNotification.notification;
		BooleanBuilder builder = new BooleanBuilder();
		
		if(param.getMember_seq() > 0){
            builder.and(notification.member_seq.eq(param.getMember_seq()));
        }
		
		if(param.getConfirmyn() != null && !param.getConfirmyn().equals("")) {
			builder.and(notification.confirmyn.eq(param.getConfirmyn()));
		}
		
		
		return queryFactory.selectFrom(notification)
				.where(builder)
				.orderBy(notification.regdate.desc())
				.limit(param.getLimit())
				.offset(param.getOffset()).fetch();
	}

	@Override
	@Transactional
	public int confirmNotification(Notification param) {
		QNotification notification = QNotification.notification;
		BooleanBuilder builder = new BooleanBuilder();
		
		if(param.getSeq() > 0) {
			builder.and(notification.seq.eq(param.getSeq()));
		}
		
		if(param.getMember_seq() > 0){
            builder.and(notification.member_seq.eq(param.getMember_seq()));
        }
		
		if(param.getSeqList() != null && !param.getSeqList().isEmpty()) {
			builder.and(notification.seq.in(param.getSeqList()));
		}
		
		builder.and(notification.confirmyn.eq("N"));
		
		return (int)queryFactory.update(notification).set(notification.confirmyn, "Y").where(builder).execute();
	}
	
	
}
