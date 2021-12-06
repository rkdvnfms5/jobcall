package com.poozim.jobcall.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.multipart.MultipartFile;

import com.poozim.jobcall.mapper.WorkMapper;
import com.poozim.jobcall.model.ActionLog;
import com.poozim.jobcall.model.BoardVote;
import com.poozim.jobcall.model.BoardVoteMember;
import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.CommentFile;
import com.poozim.jobcall.model.GroupInviteLog;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkBoardFile;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupFile;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.repository.ActionLogRepository;
import com.poozim.jobcall.repository.BoardVoteMemberRepository;
import com.poozim.jobcall.repository.BoardVoteRepository;
import com.poozim.jobcall.repository.CommentFileRepository;
import com.poozim.jobcall.repository.CommentRepository;
import com.poozim.jobcall.repository.GroupInviteLogRepository;
import com.poozim.jobcall.repository.MemberRepository;
import com.poozim.jobcall.repository.WorkBoardFileRepository;
import com.poozim.jobcall.repository.WorkBoardRepository;
import com.poozim.jobcall.repository.WorkCategoryGroupRepository;
import com.poozim.jobcall.repository.WorkCategoryRepository;
import com.poozim.jobcall.repository.WorkGroupMemberRepository;
import com.poozim.jobcall.repository.WorkGroupRepository;
import com.poozim.jobcall.repository.WorkRepository;
import com.poozim.jobcall.util.MailUtil;
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
	
	@Autowired
	private ActionLogRepository actionLogRepository;
	
	@Autowired
	private BoardVoteRepository boardVoteRepository;
	
	@Autowired
	private BoardVoteMemberRepository boardVoteMemberRepository;
	
	@Autowired
	private GroupInviteLogRepository groupInviteLogRepository;
	
	//Mybatis Mappers
	@Autowired
	private WorkMapper workMapper;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
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
	
	public int getWorkBoardCount(WorkBoard workBoard){
		return workMapper.getWorkBoardCount(workBoard);
	}
	
	public WorkBoard getWorkBoardOne(int seq) {
		return workBoardRepository.findById(seq).get();
	}
	
	public WorkBoard getWorkBoardOneMapper(WorkBoard workBoard) {
		return workMapper.getWorkBoardOne(workBoard);
	}
	
	@Transactional
	public int insertWorkBoard(WorkBoard workBoard, HttpServletRequest request, HttpServletResponse response) {
		workBoard = workBoardRepository.save(workBoard);

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
		
		//add vote
		if(workBoard.getType().equals("vote")) {
			for(int i=0; i<workBoard.getVoteList().size(); i++) {
				BoardVote boardVote = new BoardVote();
				boardVote.setBoard_seq(workBoard.getSeq());
				boardVote.setName(workBoard.getVoteList().get(i));
				boardVote.setRegdate(workBoard.getRegdate());
				boardVoteRepository.save(boardVote);
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
		
		//if Request Board is updated status, then add Comment
		if(workBoard.getNoticeyn().equals("Y") && workBoard.getType().equals("request")) {
			Comment comment = new Comment();
			comment.setNoticeyn("Y");
			comment.setBoard_seq(workBoard.getSeq());
			comment.setMember_seq(workBoard.getMember_seq());
			comment.setMember_id(workBoard.getMember_id());
			comment.setMember_name(workBoard.getMember_name());
			
			switch (workBoard.getStatus()) {
			case "request":
				comment.setContent("상태를 요청으로 변경했습니다");
				break;
			case "process":
				comment.setContent("상태를 진행중으로 변경했습니다");
				break;
			default:
				comment.setContent("상태를 완료로 변경했습니다");
				break;
			}
			
			comment.setRegdate(workBoard.getModdate());
			comment.setRegister(workBoard.getModifier());
			commentRepository.save(comment);
		}
		
		//if Vote Board is updated status, then add Comment
		if(workBoard.getNoticeyn().equals("Y") && workBoard.getType().equals("vote")) {
			Comment comment = new Comment();
			comment.setNoticeyn("Y");
			comment.setBoard_seq(workBoard.getSeq());
			comment.setMember_seq(workBoard.getMember_seq());
			comment.setMember_id(workBoard.getMember_id());
			comment.setMember_name(workBoard.getMember_name());
			comment.setContent("투표를 마감했습니다. 자세한 투표 결과는 본문을 참고해주세요.");
			
			comment.setRegdate(workBoard.getModdate());
			comment.setRegister(workBoard.getModifier());
			commentRepository.save(comment);
		}
		
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
						commentFile.setSrc(OciUtil.getObjectSrc(sessionWork.getPreauth_code(), bucketName, objectName));
						commentFile.setSize(StringUtil.getSizeStr(file.getSize()));
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
	
	public Comment getCommentOneMapper(Comment comment) {
		return workMapper.getCommentOne(comment);
	}
	
	public List<Comment> getCommentList(Comment comment) {
		return workMapper.getCommentList(comment);
	}
	
	//like, dislike
	public ActionLog getActionLogOne(int actionLog_seq) {
		return actionLogRepository.findById(actionLog_seq).get();
	}
	public int insertActionLog(ActionLog actionLog) {
		actionLogRepository.save(actionLog);
		return 1;
	}
	
	public int updateActionLog(ActionLog actionLog) {
		actionLogRepository.save(actionLog);
		return 1;
	}
	
	public int deleteActionLog(ActionLog actionLog) {
		actionLogRepository.delete(actionLog);
		return 1;
	}
	
	//vote
	public BoardVoteMember getVoteMemberOne(BoardVoteMember boardVoteMember) {
		return boardVoteMemberRepository.getBoardVoteMemberOne(boardVoteMember);
	}
	
	public int insertVoteMember(BoardVoteMember boardVoteMember) {
		boardVoteMemberRepository.save(boardVoteMember);
		return 1;
	}
	
	public int deleteVoteMember(BoardVoteMember boardVoteMember) {
		boardVoteMemberRepository.delete(boardVoteMember);
		return 1;
	}
	
	public List<Map<String,Object>> getGroupFileList(WorkGroupFile wgf){
		return workMapper.getGroupFileList(wgf);
	}
	
	@Transactional
	public int inviteGroupMembers(List<Integer> memberSeqList, WorkGroup workGroup, HttpServletRequest request) {
		String regdate = TimeUtil.getDateTime();
		if(memberSeqList != null && !memberSeqList.isEmpty()) {
			for(int i=0; i<memberSeqList.size(); i++) {
				Member member = memberRepository.findById(memberSeqList.get(i)).get();
				GroupInviteLog log = new GroupInviteLog();
				log.setGroup_seq(workGroup.getSeq());
				log.setMember_seq(memberSeqList.get(i));
				log.setRegdate(regdate);
				String code = bcryEncoder.encode(memberSeqList.get(i) + regdate).replaceAll("\\/", "");
				log.setCode(code);
				groupInviteLogRepository.save(log);
				
				//send mail
				String title = "잡콜센터 그룹 : " + workGroup.getName() + "로 초대합니다.";
				String from = "rkdvnfms5@naver.com";
				String text = "URL : " + request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/work/group/" + workGroup.getSeq() + "/attend/" + code;
				String to = member.getEmail();
				String cc = "";
				MailUtil.mailSend(title, from, text, to, cc);
			}
		}
		return 1;
	}
	
	public GroupInviteLog getGroupInviteLog(int seq) {
		
		return groupInviteLogRepository.findById(seq).get();
	}
	
	public int updateGroupInviteLog(GroupInviteLog gil) {
		groupInviteLogRepository.save(gil);
		return 1;
	}
	
	public int deleteGroupInviteLog(GroupInviteLog gil) {
		groupInviteLogRepository.deleteById(gil.getSeq());
		return 1;
	}
}
