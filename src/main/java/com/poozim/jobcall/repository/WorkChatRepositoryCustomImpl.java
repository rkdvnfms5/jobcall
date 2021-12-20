package com.poozim.jobcall.repository;

import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.poozim.jobcall.model.QWorkChat;
import com.poozim.jobcall.model.QWorkChatLog;
import com.poozim.jobcall.model.QWorkChatMember;
import com.poozim.jobcall.model.WorkChat;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;
import com.querydsl.core.BooleanBuilder;
import com.querydsl.core.dml.UpdateClause;
import com.querydsl.core.types.ExpressionUtils;
import com.querydsl.core.types.Projections;
import com.querydsl.core.types.dsl.CaseBuilder;
import com.querydsl.core.types.dsl.Expressions;
import com.querydsl.jpa.JPAExpressions;
import com.querydsl.jpa.impl.JPAQuery;
import com.querydsl.jpa.impl.JPAQueryFactory;
import com.querydsl.jpa.impl.JPAUpdateClause;

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
			if(myChatSeqList == null || myChatSeqList.isEmpty()) {
				return null;
			}
			JPAQuery<Integer> workChat_seq = queryFactory.select(wcm.chat_seq)
					.from(wcm)
					.where(wcm.chat_seq.in(myChatSeqList), 
							wcm.member_seq.eq(param.getTarget_member_seq()));
			if(workChat_seq == null) {
				return null;
			}
			if(workChat_seq.fetchOne() == null) {
				return null;
			}
			int chat_seq = workChat_seq.fetchOne();
					
			builder.and(workChat.seq.eq(chat_seq));
		}
		
		
		return queryFactory.selectFrom(workChat).where(builder).fetchOne();
	}

	@Override
	public List<WorkChatLog> getWorkChatLogList(WorkChatLog param) {
		QWorkChatLog wcl = QWorkChatLog.workChatLog;
		QWorkChatLog wcl2 = QWorkChatLog.workChatLog;
		return queryFactory.from(wcl).select(Projections.bean(WorkChatLog.class, 
				ExpressionUtils.as(
				new CaseBuilder()
				.when(wcl.seq.eq(JPAExpressions.select(wcl2.seq.min()).from(wcl2).where(wcl2.regdate.gt(
						Expressions.stringTemplate("DATE_FORMAT({0}, {1})", wcl.regdate, "%Y-%m-%d")
						)))).then("Y")
				.otherwise("N")
				,"firstyn"),
				wcl.seq, wcl.chat_seq, wcl.member_seq, wcl.message, wcl.src, wcl.file_name, wcl.object_name, wcl.confirmyn, wcl.regdate)
				)
				.where(wcl.chat_seq.eq(param.getChat_seq()))
				.orderBy(wcl.regdate.desc(), wcl.seq.desc())
				.offset(param.getOffset())
				.limit(param.getLimit()).fetch();
	}

	@Override
	public List<WorkChatMember> getWorkChatMemberList(WorkChatMember param) {
		QWorkChatMember wcm = QWorkChatMember.workChatMember;
		QWorkChatLog wcl = QWorkChatLog.workChatLog;
		
		BooleanBuilder builder = new BooleanBuilder();
		if(param.getSeq() > 0) {
			builder.and(wcm.seq.eq(param.getSeq()));
		}
		if(param.getMember_seq() > 0) {
			builder.and(wcm.member_seq.eq(param.getMember_seq()));
		}
		if(param.getWork_seq() > 0) {
			builder.and(wcm.work_seq.eq(param.getWork_seq()));
		}
		if(param.getChat_seq() > 0) {
			builder.and(wcm.chat_seq.eq(param.getChat_seq()));
		}
		
		return queryFactory.select(Projections.bean(WorkChatMember.class, 
				ExpressionUtils.as(JPAExpressions.select(wcl.message)
				.from(wcl)
				.where(wcl.chat_seq.eq(wcm.chat_seq))
				.orderBy(wcl.regdate.desc())
				,"last_msg"),
				wcm.seq, wcm.chat_seq, wcm.work_seq, wcm.title, wcm.member_seq, wcm.target_seq, wcm.target_profile, wcm.regdate)
				)
				.from(wcm)
				.where(builder).fetch();
	}

	@Override
	public int updateWorkChatMember(WorkChatMember param) {
		QWorkChatMember wcm = QWorkChatMember.workChatMember;
		BooleanBuilder builder = new BooleanBuilder();
		
		if(param.getSeq() > 0) {
			builder.and(wcm.seq.eq(param.getSeq()));
		}
		if(param.getTarget_seq() > 0) {
			builder.and(wcm.target_seq.eq(param.getTarget_seq()));
		}
		return (int) queryFactory.update(wcm).set(wcm.target_profile, param.getTarget_profile()).where(builder).execute();
	}

	@Override
	@Transactional
	public int updateWorkChatLog(WorkChatLog param) {
		QWorkChatLog wcl = QWorkChatLog.workChatLog;
		
		if(param.getChat_seq() == 0) {
			return 0;
		}
		
		BooleanBuilder builder = new BooleanBuilder();
		if(param.getSeq() > 0) {
			builder.and(wcl.seq.eq(param.getSeq()));
		}
		if(param.getMember_seq() > 0) {
			//지가 보낸게 아닌 것만
			builder.and(wcl.member_seq.ne(param.getMember_seq()));
		}
		builder.and(wcl.chat_seq.eq(param.getChat_seq()));
		builder.and(wcl.confirmyn.eq("N"));
		int res = (int)queryFactory.update(wcl).set(wcl.confirmyn, "Y").where(builder).execute();
		return res;
	}
	
	
	
}
