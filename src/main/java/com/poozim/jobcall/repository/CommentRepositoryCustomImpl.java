package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.QComment;
import com.poozim.jobcall.model.QCommentFile;
import com.poozim.jobcall.model.WorkBoard;
import com.querydsl.jpa.impl.JPAQueryFactory;

public class CommentRepositoryCustomImpl implements CommentRepositoryCustom {

	private JPAQueryFactory queryFactory;
	
	public CommentRepositoryCustomImpl(JPAQueryFactory queryFactory) {
		this.queryFactory = queryFactory;
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
		List<CommentFile> result;
		if(comment.getCommentFileSeqList() != null && !comment.getCommentFileSeqList().isEmpty()) {
			result = queryFactory.selectFrom(commentFile).where(commentFile.seq.in(comment.getCommentFileSeqList())).fetch();
		} else {
			result = queryFactory.selectFrom(commentFile).where(commentFile.comment_seq.eq(comment.getSeq())).fetch();
		}
		return result;
	}

	@Override
	public int deleteCommentFiles(Comment comment) {
		QCommentFile commentFile = QCommentFile.commentFile;
		return (int) queryFactory.delete(commentFile).where(commentFile.comment_seq.eq(comment.getSeq())).execute();
	}

}
