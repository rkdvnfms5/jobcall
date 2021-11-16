package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.WorkBoard;

public interface CommentRepositoryCustom {
	public List<Comment> getCommentList(WorkBoard workBoard);
	public int deleteComments(WorkBoard workBoard);
	
	public List<CommentFile> getCommentFileList(Comment comment);
	public int deleteCommentFiles(Comment comment);
}
