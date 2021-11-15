package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.QComment;
import com.poozim.jobcall.model.QCommentFile;
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
		
		return (int) queryFactory.delete(workBoardFile).where(workBoardFile.board_seq.eq(workBoard.getSeq())).execute();
	}

	@Override
	public List<Comment> getCommentList(WorkBoard workBoard) {
		QComment comment = QComment.comment;
		return queryFactory.selectFrom(comment).where(comment.board_seq.eq(workBoard.getSeq())).fetch();
	}

	@Override
	public int deleteComments(WorkBoard workBoard) {
		QComment comment = QComment.comment;
		return (int) queryFactory.delete(comment).where(comment.board_seq.eq(workBoard.getSeq())).execute();
	}

	@Override
	public List<CommentFile> getCommentFileList(Comment comment) {
		QCommentFile commentFile = QCommentFile.commentFile;
		return queryFactory.selectFrom(commentFile).where(commentFile.comment_seq.eq(comment.getSeq())).fetch();
	}

	@Override
	public int deleteCommentFiles(Comment comment) {
		QCommentFile commentFile = QCommentFile.commentFile;
		return (int) queryFactory.delete(commentFile).where(commentFile.comment_seq.eq(comment.getSeq())).execute();
	}

}
