package com.poozim.jobcall.service;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.CommentFileRepository;
import com.poozim.jobcall.repository.CommentRepository;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkBoardFileRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkCategoryGroupRepository;
import com.poozim.jobcall.repository.WorkCategoryRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.poozim.jobcall.util.OciUtil;
import com.poozim.jobcall.util.RedisUtil;
import com.poozim.jobcall.util.SessionUtil;
import com.poozim.jobcall.util.StringUtil;
import com.poozim.jobcall.util.TimeUtil;

@Service
public class WorkService {

	//JPA Repositories
	@Autowired
	private WorkRepository workRepository;
	
	@Autowired
	private WorkGroupRepository workGroupRepository;
	
	@Autowired
	private WorkGroupMemberRepository workGroupMemberRepository;
	
	@Autowired
	private WorkCategoryRepository workCategoryRepository;
	
	@Autowired
	private WorkCategoryGroupRepository WorkCategoryGroupRepository;
	
	@Autowired
	private WorkBoardRepository workBoardRepository;
	
	@Autowired
	private WorkBoardFileRepository workBoardFileRepository;
	
	@Autowired
	private MemberRepository memberRepository;
	
	@Autowired
	private CommentRepository commentRepository;
	
	@Autowired
	private CommentFileRepository commentFileRepository;
	
	//Mybatis Mappers
	@Autowired
	private WorkMapper workMapper;
	
	
	public Work getWorkOne(int seq) {
		return workRepository.findById(seq).get();
	}
	
	public Work getWorkByCode(String code) {
		return workRepository.getWorkOneByCode(code);
	}
	
	//WorkGroup CRUD and Logics
	public List<WorkGroup> getWorkGroupList(WorkGroup workGroup) {
		return workMapper.getWorkGroupList(workGroup);
	}
	
	public WorkGroup getWorkGroupOne(int seq) {
		return workGroupRepository.findById(seq).get();
	}
	
	@Transactional
	public int insertWorkGroup(WorkGroup workGroup) {
		//그룹 추가
		workGroup = workGroupRepository.save(workGroup);
		
		WorkGroupMember workGroupMember = new WorkGroupMember();
		workGroupMember.setGroup_seq(workGroup.getSeq());
		workGroupMember.setRegdate(workGroup.getRegdate());
		//접근권한이 공개면
		if(workGroup.getAccess().equals("public")) {
			//그룹 만든 멤버 그룹에 참여
			workGroupMember.setMember_seq(workGroup.getMember_seq());
			
			workGroupMemberRepository.save(workGroupMember);
		}
		//접근권한이 비공개면
		else if(workGroup.getAccess().equals("private")) {
			//전체 멤버 그룹에 참여
			Member member = new Member();
			member.setWork_seq(workGroup.getWork_seq());
			workGroupMember.setMemberSeqList(memberRepository.getWorkMemberSeqList(member));
			
			workMapper.insertWorkGroupMemberList(workGroupMember);
		}
		
		//디폴트 카테고리에 그룹 추가
		WorkCategory defaultCategory = workCategoryRepository.getDefaultCategory(workGroup.getWork_seq());
		WorkCategoryGroup wcg = new WorkCategoryGroup();
		wcg.setGroup_seq(workGroup.getSeq());
		wcg.setCategory_seq(defaultCategory.getSeq());
		wcg.setMember_seq(workGroup.getMember_seq());
		WorkCategoryGroupRepository.save(wcg);
		
		return 1;
	}
	
	public int updateWorkGroup(WorkGroup workGroup) {
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroupRepository.saveAndFlush(workGroup);
		return 1;
	}
	
	@Transactional
	public int deleteWorkGroup(WorkGroup workGroup) {
		int memberCnt = workGroupRepository.getWorkGroupMemberCnt(workGroup);
		if(memberCnt > 1) {
			return 0;
		} 
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroupRepository.delete(workGroup);
		return 1;
	}
	
	public int disableWorkGroup(WorkGroup workGroup) {
		if(workGroup.getSeq() == 0) {
			return 0;
		}
		workGroup.setUseyn("N");
		workGroupRepository.save(workGroup);
		return 1;
	}
	
	public WorkGroupMember getWorkGroupMemberOne(int groupseq, int memberseq) {
		return workGroupRepository.getWorkGroupMemberOne(groupseq, memberseq);
	}
	
	public int getWorkGroupMemberCnt(WorkGroup workGroup) {
		return workGroupRepository.getWorkGroupMemberCnt(workGroup);
	}
	
	//WorkCategory CRUD and Logics
	public List<WorkCategory> getWorkCategoryList(WorkCategory workCategory){
		return workMapper.getWorkCategoryList(workCategory);
	}
	
	public WorkCategory getWorkCategoryOne(int seq) {
		return workCategoryRepository.findById(seq).get();
	}
	
	public int insertWorkCategory(WorkCategory workCategory) {
		workCategory.setDefaultyn("N");
		workCategoryRepository.save(workCategory);
		return 1;
	}
	
	public int updateWorkCategory(WorkCategory workCategory) {
		if(workCategory.getSeq() == 0) {
			return 0;
		}
		workCategoryRepository.save(workCategory);
		return 1;
	}
	
	@Transactional
	public int deleteWorkCategory(WorkCategory workCategory) {
		if(workCategory.getSeq() == 0) {
			return 0;
		}
		if(workCategory.getDefaultyn() != null && workCategory.getDefaultyn().equals("Y")) {
			return 0;
		}
		//포함되어있던 그룹들 가져와서 디폴트 카테고리에 넣기
		WorkCategory defaultCategory = workCategoryRepository.getDefaultCategory(workCategory.getWork_seq());
		int res = workCategoryRepository.updateCategoryGroupCategoryseq(workCategory.getSeq(), defaultCategory.getSeq());
		workCategoryRepository.delete(workCategory);
		return res;
	}
	
	public int moveWorkGroupList(WorkCategoryGroup workCategoryGroup) {
		return workMapper.moveWorkGroupList(workCategoryGroup);
	}
	
	//WorkBoard CRUD and Logics
	public List<WorkBoard> getWorkBoardList(WorkBoard workBoard){
		return workMapper.getWorkBoardList(workBoard);
	}
	
	public WorkBoard getWorkBoardOne(int seq) {
		return workBoardRepository.findById(seq).get();
	}
	
	@Transactional
	public int insertWorkBoard(WorkBoard workBoard, HttpServletRequest request, HttpServletResponse response) {
		workBoardRepository.save(workBoard);

		if(workBoard.getAttachFileList() != null && !workBoard.getAttachFileList().isEmpty()) {
			for(int i=0; i<workBoard.getAttachFileList().size(); i++) {
				MultipartFile file = workBoard.getAttachFileList().get(i);
				String str = file.getOriginalFilename();
				String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
				Work sessionWork = SessionUtil.getWorkInfo(request, response);
				try {
					String bucketName = sessionWork.getBucket_name();//버킷 네임 해야함
					
					if(OciUtil.createObject(bucketName, file, objectName) > 0) {
						WorkBoardFile workBoardFile = new WorkBoardFile();
						workBoardFile.setBoard_seq(workBoard.getSeq());
						workBoardFile.setName(file.getOriginalFilename());
						workBoardFile.setObject_name(objectName);
						workBoardFile.setSrc(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
						workBoardFile.setSize(StringUtil.getSizeStr(file.getSize()));
						workBoardFile.setRegdate(workBoard.getRegdate());
						workBoardFileRepository.save(workBoardFile);
					}
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		return 1;
	}
	
	@Transactional
	public int deleteWorkBoard(WorkBoard workBoard, HttpServletRequest request, HttpServletResponse response) {
		//delete WorkBoardFiles
		Work sessionWork = SessionUtil.getWorkInfo(request, response);
		
		List<WorkBoardFile> workBoardFileList = workBoardRepository.getWorkBoardFileList(workBoard);
		
		if(workBoardFileList != null && !workBoardFileList.isEmpty()) {
			workBoardRepository.deleteWorkBoardFiles(workBoard);
			
			for(int i=0; i<workBoardFileList.size(); i++) {
				OciUtil.deleteObject(sessionWork.getBucket_name(), workBoardFileList.get(i).getObject_name());
			}
		}
		
		//delete WorkComemnts
		List<Comment> commentList = commentRepository.getCommentList(workBoard);
		if(commentList != null && !commentList.isEmpty()) {
			for(int i=0; i<commentList.size(); i++) {
				List<CommentFile> commentFileList = commentRepository.getCommentFileList(commentList.get(i));
				if(commentFileList != null && !commentFileList.isEmpty()) {
					for(int j=0; j<commentFileList.size(); j++) {
						OciUtil.deleteObject(sessionWork.getBucket_name(), commentFileList.get(j).getObject_name());
					}
					commentRepository.deleteCommentFiles(commentList.get(i));
				}
			}
			commentRepository.deleteComments(workBoard);
		}
		
		workBoardRepository.delete(workBoard);
		
		return 1;
	}
	
	@Transactional
	public int updateWorkBoard(WorkBoard workBoard, HttpServletRequest request, HttpServletResponse response) {
		Work sessionWork = SessionUtil.getWorkInfo(request, response);
		//delete BoardFiles
		if(workBoard.getBoardFileSeqList() != null && !workBoard.getBoardFileSeqList().isEmpty()) {
			List<WorkBoardFile> workBoardFileList = workBoardRepository.getWorkBoardFileList(workBoard);
			for(int i=0; i<workBoardFileList.size(); i++) {
				OciUtil.deleteObject(sessionWork.getBucket_name(), workBoardFileList.get(i).getObject_name());
			}
			workBoardRepository.deleteWorkBoardFiles(workBoard);
		}
		
		//add BoardFiles
		if(workBoard.getAttachFileList() != null && !workBoard.getAttachFileList().isEmpty() && workBoard.getAttachFileList().size() > 0) {
			for(int i=0; i<workBoard.getAttachFileList().size(); i++) {
				MultipartFile file = workBoard.getAttachFileList().get(i);
				String str = file.getOriginalFilename();
				String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
				try {
					String bucketName = sessionWork.getBucket_name();//버킷 네임 해야함
					
					if(OciUtil.createObject(bucketName, file, objectName) > 0) {
						WorkBoardFile workBoardFile = new WorkBoardFile();
						workBoardFile.setBoard_seq(workBoard.getSeq());
						workBoardFile.setName(file.getOriginalFilename());
						workBoardFile.setObject_name(objectName);
						workBoardFile.setSrc(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
						workBoardFile.setSize(StringUtil.getSizeStr(file.getSize()));
						workBoardFile.setRegdate(TimeUtil.getDateTime());
						workBoardFileRepository.save(workBoardFile);
					}
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		//update Board
		workBoardRepository.save(workBoard);
		
		return 1;
	}
	
	@Transactional
	public int insertComment(Comment comment, HttpServletRequest request, HttpServletResponse response) {
		commentRepository.save(comment);
		
		if(comment.getAttachFileList() != null && !comment.getAttachFileList().isEmpty()) {
			for(int i=0; i<comment.getAttachFileList().size(); i++) {
				MultipartFile file = comment.getAttachFileList().get(i);
				String str = file.getOriginalFilename();
				String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
				Work sessionWork = SessionUtil.getWorkInfo(request, response);
				try {
					String bucketName = sessionWork.getBucket_name();//버킷 네임 해야함
					
					if(OciUtil.createObject(bucketName, file, objectName) > 0) {
						CommentFile commentFile = new CommentFile();
						commentFile.setComment_seq(comment.getSeq());
						commentFile.setName(file.getOriginalFilename());
						commentFile.setObject_name(objectName);
						commentFile.setSrc(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
						commentFile.setSize(StringUtil.getSizeStr(file.getSize()));
						commentFile.setRegdate(comment.getRegdate());
						commentFileRepository.save(commentFile);
					}
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		
		return 1;
	}
	
	@Transactional
	public int updateComment(Comment comment, HttpServletRequest request, HttpServletResponse response) {
		Work sessionWork = SessionUtil.getWorkInfo(request, response);
		//delete CommentFiles
		if(comment.getCommentFileSeqList() != null && !comment.getCommentFileSeqList().isEmpty()) {
			List<CommentFile> commentFileList = commentRepository.getCommentFileList(comment);
			for(int i=0; i<commentFileList.size(); i++) {
				OciUtil.deleteObject(sessionWork.getBucket_name(), commentFileList.get(i).getObject_name());
			}
			commentRepository.deleteCommentFiles(comment);
		}
		
		//add CommentFiles
		if(comment.getAttachFileList() != null && !comment.getAttachFileList().isEmpty() && comment.getAttachFileList().size() > 0) {
			for(int i=0; i<comment.getAttachFileList().size(); i++) {
				MultipartFile file = comment.getAttachFileList().get(i);
				String str = file.getOriginalFilename();
				String objectName =  str.substring(0, str.lastIndexOf(".")) + "_" + TimeUtil.getDateTimeString() + str.substring(str.lastIndexOf("."));
				try {
					String bucketName = sessionWork.getBucket_name();//버킷 네임 해야함
					
					if(OciUtil.createObject(bucketName, file, objectName) > 0) {
						CommentFile commentFile = new CommentFile();
						commentFile.setComment_seq(comment.getSeq());
						commentFile.setName(file.getOriginalFilename());
						commentFile.setObject_name(objectName);
						commentFile.setSize(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
						commentFile.setSrc(StringUtil.getSizeStr(file.getSize()));
						commentFile.setRegdate(TimeUtil.getDateTime());
						commentFileRepository.save(commentFile);
					}
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		
		//update Comment
		commentRepository.save(comment);
		return 1;
	}
	
	@Transactional
	public int deleteComment(Comment comment, HttpServletRequest request, HttpServletResponse response) {
		Work sessionWork = SessionUtil.getWorkInfo(request, response);
		
		//delete CommentFiles
		List<CommentFile> commentFileList = commentRepository.getCommentFileList(comment);
		if(commentFileList != null && !commentFileList.isEmpty()) {
			for(int i=0; i<commentFileList.size(); i++) {
				OciUtil.deleteObject(sessionWork.getBucket_name(), commentFileList.get(i).getObject_name());
			}
			commentRepository.deleteCommentFiles(comment);
		}
		
		//delete Comment
		commentRepository.delete(comment);
		
		return 1;
	}
	
	public Comment getCommentOne(int seq) {
		return commentRepository.findById(seq).get();
	}
}
