package com.poozim.jobcall.mapper;

import java.util.List;

import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;

public interface WorkMapper {
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup);
	
	public List<WorkBoard> getWorkBoardList(WorkBoard workBoard);
	
	public List<WorkBoardFile> getWorkBoardFileList (int board_seq);
	
	public List<WorkCategory> getWorkCategoryList(WorkCategory workCategory);
	
	public int moveWorkGroupList(WorkCategoryGroup workCategoryGroup);
}
