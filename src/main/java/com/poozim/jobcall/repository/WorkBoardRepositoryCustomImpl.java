package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.QComment;
import com.poozim.jobcall.model.QCommentFile;
import com.poozim.jobcall.model.QWorkBoard;
import com.poozim.jobcall.model.QWorkBoardFile;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class WorkBoardRepositoryCustomImpl implements WorkBoardRepositoryCustom {

private JPAQueryFactory queryFactory;
	
	public WorkBoardRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
	}
	
	@Override
	public List<WorkBoardFile> getWorkBoardFileList(WorkBoard workBoard) {
		QWorkBoardFile workBoardFile = QWorkBoardFile.workBoardFile;
		List<WorkBoardFile> result;
		if(workBoard.getBoardFileSeqList() != null && !workBoard.getBoardFileSeqList().isEmpty()) {
			result = queryFactory.selectFrom(workBoardFile).where(workBoardFile.seq.in(workBoard.getBoardFileSeqList())).fetch();
		}
		else {
			result = queryFactory.selectFrom(workBoardFile).where(workBoardFile.board_seq.eq(workBoard.getSeq())).fetch();
		}
		return result;
	}

	@Override
	public int deleteWorkBoardFiles(WorkBoard workBoard) {
		QWorkBoardFile workBoardFile = QWorkBoardFile.workBoardFile;
		if(workBoard.getBoardFileSeqList() != null && !workBoard.getBoardFileSeqList().isEmpty()) {
			return (int) queryFactory.delete(workBoardFile).where(workBoardFile.seq.in(workBoard.getBoardFileSeqList())).execute();
		} else {
			return (int) queryFactory.delete(workBoardFile).where(workBoardFile.board_seq.eq(workBoard.getSeq())).execute();
		}
	}

	@Override
	public int updateMemberProfile(Member member) {
		QWorkBoard workBoard = QWorkBoard.workBoard;
		return (int) queryFactory.update(workBoard)
				.set(workBoard.member_profile, member.getProfile())
				.set(workBoard.member_name, member.getName())
				.where(workBoard.member_seq.eq(member.getSeq())).execute();
	}

	

}
