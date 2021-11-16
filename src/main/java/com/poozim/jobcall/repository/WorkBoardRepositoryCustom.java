package com.poozim.jobcall.repository;

import java.util.List;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;

public interface WorkBoardRepositoryCustom {

	public List<WorkBoardFile> getWorkBoardFileList(WorkBoard workBoard);
	public int deleteWorkBoardFiles(WorkBoard workBoard);
	
}
