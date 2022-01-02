package com.poozim.jobcall.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkChatLog;
import com.poozim.jobcall.model.WorkChatMember;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupFile;
import com.poozim.jobcall.model.WorkGroupMember;

public interface WorkMapper {
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup);
	
	public List<WorkBoard> getWorkBoardList(WorkBoard workBoard);
	
	public int getWorkBoardCount(WorkBoard workBoard);
	
	public WorkBoard getWorkBoardOne(WorkBoard workBoard);
	
	public List<WorkBoardFile> getWorkBoardFileList (int board_seq);
	
	public List<WorkCategory> getWorkCategoryList(WorkCategory workCategory);
	
	public int moveWorkGroupList(WorkCategoryGroup workCategoryGroup);
	
	public int insertWorkGroupMemberList(WorkGroupMember workGroupMember);
	
	public String getCreatedWorkCode(String title);
	
	public Comment getCommentOne(Comment comment);
	
	public List<Comment> getCommentList(Comment comment);
	
	public List<Map<String, Object>> getGroupFileList(WorkGroupFile wgf);
	
	public List<WorkChatMember> getWorkChatMemberListMapper(WorkChatMember wcm);
	
	public List<WorkChatLog> getWorkChatLogListMapper(WorkChatLog wcl);
	
	public WorkChatLog getWorkChatLogOneMapper(WorkChatLog wcl);
}
