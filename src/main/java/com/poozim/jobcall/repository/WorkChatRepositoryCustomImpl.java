package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.QWorkChat;
import com.poozim.jobcall.model.QWorkChatMember;
import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatMember;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class WorkChatRepositoryCustomImpl implements WorkChatRepositoryCustom {

	private JPAQueryFactory queryFactory;
	
	public WorkChatRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
	}

	@Override
	public List<WorkChat> getWorkChatList(int member_seq) {
		QWorkChat workChat = QWorkChat.workChat;
		
		QWorkChatMember wcm = QWorkChatMember.workChatMember;
		List<Integer> chatSeqList = queryFactory.select(wcm.chat_seq).from(wcm).where(wcm.member_seq.eq(member_seq)).fetch();
		
		return queryFactory.selectFrom(workChat).where(workChat.seq.in(chatSeqList)).fetch();
	}

	@Override
	public WorkChat getWorkChatOne(WorkChat param) {
		QWorkChat workChat = QWorkChat.workChat;
		QWorkChatMember wcm = QWorkChatMember.workChatMember;
		BooleanBuilder builder = new BooleanBuilder();
		
		if(param.getSeq() > 0) {
			builder.and(workChat.seq.eq(param.getSeq()));
		}
		
		if(param.getMember_seq() > 0 && param.getTarget_member_seq() > 0) {
			List<Integer> myChatSeqList = 
					queryFactory.select(wcm.chat_seq).from(wcm).where(wcm.member_seq.eq(param.getMember_seq())).fetch();
			
			int workChat_seq = queryFactory.select(wcm.chat_seq).from(wcm).where(wcm.chat_seq.in(myChatSeqList), wcm.member_seq.eq(param.getTarget_member_seq())).fetchOne();
			builder.and(workChat.seq.eq(workChat_seq));
		}
		
		
		return queryFactory.selectFrom(workChat).where(builder).fetchOne();
	}
	
	
}
