package com.poozim.jobcall.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.aop.Timer;
import com.poozim.jobcall.aop.WorkLnbSet;
import com.poozim.jobcall.model.ActionLog;
import com.poozim.jobcall.model.BoardVoteMember;
import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.GroupInviteLog;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Notification;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupFile;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.service.NotificationService;
import com.poozim.jobcall.service.WorkService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.MailUtil;
import com.poozim.jobcall.util.OciUtil;
import com.poozim.jobcall.util.SessionUtil;
import com.poozim.jobcall.util.TimeUtil;

@Controller
@RequestMapping("/work")
public class WorkController {
	
	private final int limit_file = 10;
	private final int limit_board = 10;
	private final int limit_image = 20;
	private final int limit_comment = 5;
	private final int limit_notify = 20;
	
	
	@Autowired
	private WorkService workService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private NotificationService notificationService;
	
	@Autowired
	private View jsonView;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	@RequestMapping(value = "/{seq}/home", method = RequestMethod.GET)
	@WorkLnbSet
	public String home(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("seq") int seq) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "/util/alert";
		}
		
		
		//get Work
		Work work = workService.getWorkOne(seq);
		model.addAttribute("Work", work);
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		
		if(member.getWork_seq() != work.getSeq() || !member.getUseyn().equals("Y")) {
			model.addAttribute("msg", "초대된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		if(work.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 잡콜센터가 존재하지 않습니다.");
			return "/util/alert";
		}
		
		//get Work Boards
		WorkBoard workBoard = new WorkBoard();
		workBoard.setMember_seq(member.getSeq());
		workBoard.setWork_seq(work.getSeq());
		List<WorkBoard> workBoardList = workService.getWorkBoardList(workBoard);
		model.addAttribute("WorkBoardList", workBoardList);
		model.addAttribute("limit", workBoard.getLimit());
		model.addAttribute("offset",workBoard.getOffset());
		
		//get Work Members
		Member workMember = new Member();
		workMember.setWork_seq(work.getSeq());
		List<Member> WorkMemberList = memberService.getMemberList(workMember);
		model.addAttribute("WorkMemberList", WorkMemberList);
		
		return "/work/view";
	}
	
	
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	@WorkLnbSet
	@Timer
	public String categoryPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/work/category";
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.POST)
	public View insetCategory(HttpServletRequest request, HttpServletResponse response, Model model, WorkCategory workCategory) {
		Member member = LoginUtil.getLoginMember(request, response);
		
		workCategory.setWork_seq(member.getWork_seq());
		workCategory.setMember_seq(member.getSeq());
		workCategory.setDefaultyn("N");
		workCategory.setRegdate(TimeUtil.getDateTime());
		workService.insertWorkCategory(workCategory);
		
		return jsonView;
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.PUT)
	public View updateCategory(HttpServletRequest request, HttpServletResponse response, Model model, WorkCategory workCategory) {
		WorkCategory category = workService.getWorkCategoryOne(workCategory.getSeq());
		int res = 0;
		
		if(category.getMember_seq() == LoginUtil.getLoginMember(request, response).getSeq()) {
			category.setTitle(workCategory.getTitle());
			res = workService.updateWorkCategory(category);
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.DELETE)
	public View deleteCategory(HttpServletRequest request, HttpServletResponse response, Model model, WorkCategory workCategory) {
		WorkCategory category = workService.getWorkCategoryOne(workCategory.getSeq());
		int res = 0;
		
		if(category.getMember_seq() == LoginUtil.getLoginMember(request, response).getSeq()) {
			res = workService.deleteWorkCategory(category);
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value="/category_move", method = RequestMethod.POST)
	public View moveGroupCategory(HttpServletRequest request, HttpServletResponse response, Model model, 
			@RequestParam("groupSeqList[]") List<Integer> groupSeqList, @RequestParam("category_seq") int category_seq) {
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkCategoryGroup wcg = new WorkCategoryGroup();
		wcg.setGroupSeqList(groupSeqList);
		wcg.setCategory_seq(category_seq);
		wcg.setMember_seq(member.getSeq());
		
		int res = workService.moveWorkGroupList(wcg);
		
		if(res > 0) {
			//clear cache
			workService.clearGroupListCache(member.getWork_seq(), member.getSeq());
		}
		
		model.addAttribute("res", res);
		
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{groupseq}", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupPage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("groupseq") int groupseq) {
		//get WorkGroup
		WorkGroup workGroup = workService.getWorkGroupOne(groupseq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		if(workGroup == null || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return "/util/alert";
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(groupseq, member.getSeq());
		
		if(wgm == null && workGroup.getAccess().equals("private")) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		//get group member list
		if(wgm != null) {
			List<Member> groupMemberList = memberService.getGroupMemberList(wgm);
			model.addAttribute("GroupMemberList", groupMemberList);
		}
		
		//get Work Boards
		WorkBoard workBoard = new WorkBoard();
		workBoard.setMember_seq(member.getSeq());
		workBoard.setGroup_seq(groupseq);
		List<WorkBoard> workBoardList = workService.getWorkBoardList(workBoard);
		
		model.addAttribute("WorkBoardList", workBoardList);
		
		model.addAttribute("limit", workBoard.getLimit());
		model.addAttribute("offset",workBoard.getOffset());
		model.addAttribute("total", workService.getWorkBoardCount(workBoard));
		
		return "/work/group";
	}
	
	@RequestMapping(value = "/group/{groupseq}", method = RequestMethod.PUT)
	public View updateGroup (HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("groupseq") int groupseq, WorkGroup workGroup){
		int res = 0;
		WorkGroup group = workService.getWorkGroupOne(groupseq);
		
		if(group.getMaster_seq() == LoginUtil.getLoginMember(request, response).getSeq()) {
			group.setAccess(workGroup.getAccess());
			group.setContent(workGroup.getContent());
			res = workService.updateWorkGroup(group);
			
		}
		
		model.addAttribute("res", res);
		model.addAttribute("msg", "그룹 마스터만 가능합니다.");
		return jsonView;
	}
	
	@RequestMapping(value = "/group/new", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupNewPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/work/group_new";
	}
	
	@RequestMapping(value = "/group/{groupseq}/setting", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupSettingPage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("groupseq") int groupseq) {
		WorkGroup workGroup = workService.getWorkGroupOne(groupseq);
		model.addAttribute("WorkGroup", workGroup);
		
		return "/work/group_setting";
	}
	
	@RequestMapping(value = "/group", method = RequestMethod.POST)
	@WorkLnbSet
	public String groupInsert(HttpServletRequest request, HttpServletResponse response, Model model, WorkGroup workGroup) {
		Member member = LoginUtil.getLoginMember(request, response);
		
		workGroup.setMember_seq(member.getSeq());
		workGroup.setWork_seq(member.getWork_seq());
		workGroup.setRegister(member.getId());
		workGroup.setRegdate(TimeUtil.getDateTime());
		workGroup.setUseyn("Y");
		
		int res = workService.insertWorkGroup(workGroup);
		
		if(res > 0) {
			//clear cache
			workService.clearGroupListCache(member.getWork_seq(), member.getSeq());
		}
		
		return "redirect:/work/group/" + workGroup.getSeq();
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public View getBoardList(HttpServletRequest request, HttpServletResponse response, Model model, WorkBoard workBoard) {
		workBoard.setLimit(limit_board);
		List<WorkBoard> workBoardList = workService.getWorkBoardList(workBoard);
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		model.addAttribute("workBoardList", workBoardList);
		return jsonView;
	}
	
	@RequestMapping(value = "/board/{board_seq}", method = RequestMethod.GET)
	public View getBoardOne(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("board_seq") int board_seq,
			WorkBoard workBoard) {
		workBoard.setSeq(board_seq);
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		workBoard = workService.getWorkBoardOneMapper(workBoard);
		
		model.addAttribute("Board", workBoard);
		return jsonView;
	}
	
//	@RequestMapping(value = "/board/{board_seq}", method = RequestMethod.GET)
//	public String getBoardOne(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("board_seq") int board_seq,
//			WorkBoard workBoard) {
//		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
//		workBoard = workService.getWorkBoardOneMapper(workBoard);
//		
//		model.addAttribute("Board", workBoard);
//		model.addAttribute("coverFlag", ServletRequestUtils.getBooleanParameter(request, "coverFlag", true));
//		model.addAttribute("coverClass", ServletRequestUtils.getStringParameter(request, "coverClass", ""));
//		model.addAttribute("search", ServletRequestUtils.getStringParameter(request, "search", ""));
//		return "/work/board";
//	}
	
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public View InsertBoard(HttpServletRequest request, HttpServletResponse response, Model model, WorkBoard workBoard,
			 @RequestParam("attachFiles") List<MultipartFile> attachFiles,
			 @RequestParam(value = "vote", required = false) List<String> voteList) {
		Member member = LoginUtil.getLoginMember(request, response);
		
//		String content = ServletRequestUtils.getStringParameter(request, "content", "");
//		String type = ServletRequestUtils.getStringParameter(request, "type", "");
//		int group_seq = ServletRequestUtils.getIntParameter(request, "group_seq", 0);
		
		String content = "";
		if(workBoard.getContent() != null && !workBoard.getContent().equals("")) {
			content = workBoard.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "\\<br\\>");
		}
		workBoard.setContent(content);
		workBoard.setMember_seq(member.getSeq());
		workBoard.setMember_id(member.getId());
		workBoard.setMember_name(member.getName());
		workBoard.setMember_profile(member.getProfile());
		workBoard.setWork_seq(member.getWork_seq());
		workBoard.setRegister(member.getId());
		workBoard.setRegdate(TimeUtil.getDateTime());
		
		if(attachFiles != null && !attachFiles.isEmpty()) {
			workBoard.setAttachFileList(attachFiles);
		}
		
		if(voteList != null && !voteList.isEmpty()) {
			workBoard.setVoteList(voteList);
		}
		workService.insertWorkBoard(workBoard, request, response);
		
		return jsonView;
	}

	@RequestMapping(value = "/board/{boardseq}", method = RequestMethod.DELETE)
	public View deleteBoard(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("boardseq") int boardseq) {
		int res = 0;
		Member member = LoginUtil.getLoginMember(request, response);
		WorkBoard workBoard = workService.getWorkBoardOne(boardseq);
		
		if(workBoard.getMember_seq() == member.getSeq()) {
			res = workService.deleteWorkBoard(workBoard, request, response);
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/board/{boardseq}", method = RequestMethod.PUT)
	public View updateBoard(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("boardseq") int boardseq,
			 @RequestParam(value = "attachFiles", required = false) List<MultipartFile> attachFiles,  
			 @RequestParam(value = "boardFileSeqList", required = false) List<Integer> boardFileSeqList) {
		int res = 0;
		Member member = LoginUtil.getLoginMember(request, response);
		WorkBoard workBoard = workService.getWorkBoardOne(boardseq);
		
		String content = ServletRequestUtils.getStringParameter(request, "content", "");
		
		//schedule
		String startdate = ServletRequestUtils.getStringParameter(request, "startdate", "");
		String starttime = ServletRequestUtils.getStringParameter(request, "starttime", "");
		String enddate = ServletRequestUtils.getStringParameter(request, "enddate", "");
		String endtime = ServletRequestUtils.getStringParameter(request, "endtime", "");
		String title = ServletRequestUtils.getStringParameter(request, "title", "");
		
		//request
		String status = ServletRequestUtils.getStringParameter(request, "status", "");
		String worker = ServletRequestUtils.getStringParameter(request, "worker", "");
		
		if(workBoard.getMember_seq() == member.getSeq()) {
			if(attachFiles != null && !attachFiles.isEmpty()) {
				workBoard.setAttachFileList(attachFiles);
			}
			if(boardFileSeqList != null && !boardFileSeqList.isEmpty()) {
				workBoard.setBoardFileSeqList(boardFileSeqList);
			}
			if(!content.equals("")) {
				workBoard.setContent(content);
			}
			
			//schedule
			if(!startdate.equals("")) {
				workBoard.setStartdate(startdate);
			}
			workBoard.setStarttime(starttime);
			
			if(!enddate.equals("")) {
				workBoard.setEnddate(enddate);
			}
			workBoard.setEndtime(endtime);
			
			if(!title.equals("")) {
				workBoard.setTitle(title);
			}
			
			//request
			if(!status.equals("")) {
				workBoard.setStatus(status);
				workBoard.setNoticeyn("Y");
			}
			if(!worker.equals("")) {
				workBoard.setWorker(worker);
			}
			
			workBoard.setModdate(TimeUtil.getDateTime());
			workBoard.setModifier(member.getId());
			
			res = workService.updateWorkBoard(workBoard, request, response);
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/comment/{comment_seq}", method = RequestMethod.GET)
	public View getCommentOne(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("comment_seq") int comment_seq,
			Comment comment) {
		comment.setSearch_member_seq(LoginUtil.getLoginMember(request, response).getSeq());
		comment = workService.getCommentOneMapper(comment);
		model.addAttribute("Comment", comment);
		return jsonView;
	}
	
	@RequestMapping(value = "/comment", method = RequestMethod.GET)
	public View getCommentList(HttpServletRequest request, HttpServletResponse response, Model model,
			Comment comment) {
		comment.setLimit(limit_comment);
		comment.setSearch_member_seq(LoginUtil.getLoginMember(request, response).getSeq());
		List<Comment> commentList = workService.getCommentList(comment);
		model.addAttribute("commentList", commentList);
		return jsonView;
	}
	
	@RequestMapping(value = "/comment", method = RequestMethod.POST)
	public View insertComment(HttpServletRequest request, HttpServletResponse response, Model model,
			 @RequestParam("attachFiles") List<MultipartFile> attachFiles) {
		int res = 0;
		
		String content = ServletRequestUtils.getStringParameter(request, "content", "");
		int board_seq = ServletRequestUtils.getIntParameter(request, "board_seq", 0);
		
		if(LoginUtil.getLoginCheck(request, response)) {
			Comment comment = new Comment();
			Member member = LoginUtil.getLoginMember(request, response);
			comment.setRegdate(TimeUtil.getDateTime());
			comment.setRegister(member.getId());
			comment.setMember_seq(member.getSeq());
			comment.setMember_id(member.getId());
			comment.setMember_name(member.getName());
			comment.setMember_profile(member.getProfile());
			comment.setAttachFileList(attachFiles);
			comment.setContent(content);
			comment.setBoard_seq(board_seq);
			res = workService.insertComment(comment, request, response);
		} else {
			model.addAttribute("msg", "로그인이 필요합니다.");
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/comment/{comment_seq}", method = RequestMethod.DELETE)
	public View deleteComment(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("comment_seq") int comment_seq) {
		int res = 0;
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		} 
		
		Member member = LoginUtil.getLoginMember(request, response);
		Comment comment = workService.getCommentOne(comment_seq);
		
		if(comment.getMember_seq() != member.getSeq()) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "작성자가 아닙니다.");
			return jsonView;
		}
		
		res = workService.deleteComment(comment, request, response);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/comment/{comment_seq}", method = RequestMethod.PUT)
	public View updateComment(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("comment_seq") int comment_seq,
			@RequestParam("attachFiles") List<MultipartFile> attachFiles,  @RequestParam("commentFileSeqList") List<Integer> commentFileSeqList) {
		int res = 0;
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		} 
		
		Member member = LoginUtil.getLoginMember(request, response);
		Comment comment = workService.getCommentOne(comment_seq);
		
		if(comment.getMember_seq() != member.getSeq()) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "작성자가 아닙니다.");
			return jsonView;
		}
		
		String content = ServletRequestUtils.getStringParameter(request, "content", "");
		
		comment.setCommentFileSeqList(commentFileSeqList);
		comment.setAttachFileList(attachFiles);
		comment.setContent(content);
		res = workService.updateComment(comment, request, response);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	
	@RequestMapping(value = "/action", method = RequestMethod.POST)
	public View insertActionLog(HttpServletRequest request, HttpServletResponse response, Model model, ActionLog actionLog) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		}
		
		int res = 0;
		Member member = LoginUtil.getLoginMember(request, response);
		
		actionLog.setMember_seq(member.getSeq());
		actionLog.setMember_id(member.getId());
		actionLog.setMember_name(member.getName());
		actionLog.setRegdate(TimeUtil.getDateTime());
		res = workService.insertActionLog(actionLog);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/action/{actionLog_seq}", method = RequestMethod.PUT)
	public View updateActionLog(HttpServletRequest request, HttpServletResponse response, Model model, ActionLog param,
			@PathVariable("actionLog_seq") int actionLog_seq) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		}
		
		int res = 0;
		
		Member member = LoginUtil.getLoginMember(request, response);
		ActionLog actionLog = workService.getActionLogOne(actionLog_seq);
		
		if(member.getSeq() != actionLog.getMember_seq()) {
			model.addAttribute("msg", "본인만 가능합니다.");
			return jsonView;
		}
		
		actionLog.setAction(param.getAction());
		
		res = workService.updateActionLog(actionLog);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/action/{actionLog_seq}", method = RequestMethod.DELETE)
	public View deleteActionLog(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("actionLog_seq") int actionLog_seq ) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		}
		
		int res = 0;
		
		Member member = LoginUtil.getLoginMember(request, response);
		ActionLog actionLog = workService.getActionLogOne(actionLog_seq);
		
		if(member.getSeq() != actionLog.getMember_seq()) {
			model.addAttribute("msg", "본인만 가능합니다.");
			return jsonView;
		}
		
		res = workService.deleteActionLog(actionLog);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/member/invite", method = RequestMethod.GET)
	@WorkLnbSet
	public String memberInvitePage() {
		
		return "/work/member_new";
	}
	
	@RequestMapping(value = "/member/invite", method = RequestMethod.POST)
	public View memberInvite(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		Work work = (Work)session.getAttribute("WorkInfo");
		String email = ServletRequestUtils.getStringParameter(request, "email", "");
		int res = 0;
		
		//메일 중복검사
		Member member = new Member();
		member.setEmail(email);
		member.setWork_seq(work.getSeq());
		System.out.println(memberService.getMemberOneCustom(member));
		if(memberService.getMemberOneCustom(member) != null) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "이미 참여중인 이메일입니다.");
			return jsonView;
		}
		
		//메일 보내기
		String title = "잡콜이야 " + work.getTitle() + " 업무방으로 초대합니다.";
		String from = "rkdvnfms5@naver.com";
		String text = "URL : " + request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/sign/attend/" + work.getSeq();
		text += "\n참여 코드 : " + work.getCode();
		String to = email;
		String cc = "";
		
		res = MailUtil.mailSend(title, from, text, to, cc);
		
		model.addAttribute("res", res);
		
		return jsonView;
	}
	
	@RequestMapping(value = "/vote", method = RequestMethod.POST)
	public View insertVoteMember(HttpServletRequest request, HttpServletResponse response, Model model
			, BoardVoteMember boardVoteMember) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		}
		
		int res = 0;
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkBoard workBoard = workService.getWorkBoardOne(boardVoteMember.getBoard_seq());
		if(workBoard.getStatus().equals("complete")) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "이미 마감된 투표입니다.");
			return jsonView;
		}
		
		boardVoteMember.setMember_seq(member.getSeq());
		boardVoteMember.setMember_id(member.getId());
		boardVoteMember.setMember_name(member.getName());
		boardVoteMember.setRegdate(TimeUtil.getDateTime());
		res = workService.insertVoteMember(boardVoteMember);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/vote/{vote_seq}", method = RequestMethod.DELETE)
	public View deleteVoteMember(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("vote_seq") int vote_seq ) {
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return jsonView;
		}
		
		int res = 0;
		
		Member member = LoginUtil.getLoginMember(request, response);
		BoardVoteMember boardVoteMember = new BoardVoteMember();
		boardVoteMember.setVote_seq(vote_seq);
		boardVoteMember.setMember_seq(member.getSeq());
		boardVoteMember = workService.getVoteMemberOne(boardVoteMember);
		
		if(boardVoteMember == null) {
			model.addAttribute("msg", "투표 정보가 잘못되었습니다.");
			model.addAttribute("res", res);
			return jsonView;
		}
		
		if(member.getSeq() != boardVoteMember.getMember_seq()) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "본인만 가능합니다.");
			return jsonView;
		}
		
		WorkBoard workBoard = workService.getWorkBoardOne(boardVoteMember.getBoard_seq());
		if(workBoard.getStatus().equals("complete")) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "이미 마감된 투표입니다.");
			return jsonView;
		}
		
		res = workService.deleteVoteMember(boardVoteMember);
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/member/modify", method = RequestMethod.GET)
	@WorkLnbSet
	public String memberModifyPage() {
		
		return "/work/member_modify";
	}
	
	@RequestMapping(value = "/members", method = RequestMethod.GET)
	@WorkLnbSet
	public String memberListPage(HttpServletRequest request, HttpServletResponse response, Model model, @ModelAttribute("Member") Member member) {
		int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
		
		//get Work Members
		member.setWork_seq(work_seq);
		List<Member> WorkMemberList = memberService.getMemberList(member);
		model.addAttribute("MemberList", WorkMemberList);
		return "/work/member_list";
	}
	
	@RequestMapping(value = "/groups", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupListPage(HttpServletRequest request, HttpServletResponse response, Model model, 
			@ModelAttribute("Group") WorkGroup workGroup) {
		int work_seq = SessionUtil.getWorkInfo(request, response).getSeq();
		int member_seq = LoginUtil.getLoginMember(request, response).getSeq();
		
		workGroup.setWork_seq(work_seq);
		workGroup.setMember_seq(member_seq);
		List<WorkGroup> workGroupList = workService.getWorkGroupList(workGroup);
		model.addAttribute("WorkGroupList", workGroupList);
		return "/work/group_list";
	}
	
	@RequestMapping(value = "/groups", method = RequestMethod.DELETE)
	public View exitGroup(HttpServletRequest request, HttpServletResponse response, Model model) {
		int group_seq = ServletRequestUtils.getIntParameter(request, "group_seq", 0);
		Member member = LoginUtil.getLoginMember(request, response);
		
		int res = 0;
		
		//get group info, workgroupmember
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		/* 예외 처리들
		 * 그룹 정보가 없는 (존재하지 않는 경우)
		 * 참여중인 그룹이 아닌 경우
		 * 그룹에 혼자인 경우 -> 그룹 삭제
		 * 그룹 마스터인 경우 -> 그룹 마스터 정보 수정
		*/
		
		if(workGroup == null || workGroup.getSeq() == 0) {
			model.addAttribute("msg", "해당 그룹 정보가 없습니다.");
			return jsonView;
		}
		
		if(wgm == null || wgm.getSeq() == 0) {
			model.addAttribute("msg", "해당 그룹에 참여 정보가 없습니다.");
			return jsonView;
		}
		
		if(workGroup.getMaster_seq() == member.getSeq()) {
			//혼자면
			if(workService.getWorkGroupMemberCnt(workGroup) < 2) {
				//그룹 미사용
				workGroup.setUseyn("N");
				workService.updateWorkGroup(workGroup);
			}//아니면
			else {
				//마스터 위임
				int next_master_seq = 0;
				List<WorkGroupMember> wgmList = workService.getWorkGroupMemberList(workGroup);
				
				//위임할 member_seq
				if(wgmList != null && !wgmList.isEmpty()) {
					for(int i=0; i<wgmList.size(); i++) {
						if(wgmList.get(i).getMember_seq() != member.getSeq()) {
							next_master_seq = wgmList.get(i).getMember_seq();
							break;
						}
					}
				}
				
				Member next_master = memberService.getMemberOne(next_master_seq);
				//위임
				workGroup.setMaster_id(next_master.getId());
				workGroup.setMaster_name(next_master.getName());
				workGroup.setMaster_seq(next_master.getSeq());
				workService.updateWorkGroup(workGroup);
			}
			
			res = workService.deleteWorkGroupMember(wgm);
		} 
		else {
			//마스터가 아닌데 혼자인 경우
			workGroup.setUseyn("N");
			workService.updateWorkGroup(workGroup);
			res = workService.deleteWorkGroupMember(wgm);
		}
		
		if(res > 0) {
			//clear cache
			workService.clearGroupListCache(member.getWork_seq(), member.getSeq());
		}
		
		
		model.addAttribute("res", res);
		
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/member", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupMemberPage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		WorkGroupMember wgm = new WorkGroupMember();
		wgm.setGroup_seq(group_seq);
		model.addAttribute("MemberList", memberService.getGroupMemberList(wgm));
		
		return "/work/group_member";
	}
	
	@RequestMapping(value = "/group/{group_seq}/member", method = RequestMethod.DELETE)
	@WorkLnbSet
	public View groupMemberDelete(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		Member member = LoginUtil.getLoginMember(request, response);
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		model.addAttribute("WorkGroup", workGroup);
		
		if(workGroup.getMaster_seq() != member.getSeq()) {
			model.addAttribute("msg", "마스터만 가능합니다.");
			return jsonView;
		}
		
		if(workGroup == null || workGroup.getSeq() == 0 || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return jsonView;
		}
		
		int delete_member_seq = ServletRequestUtils.getIntParameter(request, "delete_seq", 0);
		int res = 0;
		
		if(delete_member_seq > 0) {
			WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, delete_member_seq);
			if(wgm == null) {
				model.addAttribute("msg", "참여한 멤버가 아닙니다.");
				return jsonView;
			}
			res = workService.deleteWorkGroupMember(wgm);
		} else {
			model.addAttribute("msg", "삭제할 회원 번호 정보가 없습니다.");
			return jsonView;
		}
		
		if(res > 0) {
			//clear cache
			workService.clearGroupListCache(member.getWork_seq(), delete_member_seq);
		}
		
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/invite", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupMemberInvitePage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		Member member = LoginUtil.getLoginMember(request, response);
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		
		if(workGroup.getMaster_seq() != member.getSeq()) {
			model.addAttribute("msg", "마스터만 가능합니다.");
			return "/util/alert";
		}
		
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		List<Member> inviteList = memberService.getInviteList(workGroup);
		model.addAttribute("MemberList", inviteList);
		
		List<Member> inviteLogList = memberService.getInviteLogList(workGroup);
		model.addAttribute("InviteLogList", inviteLogList);
		
		return "/work/group_member_invite";
	}
	
	@RequestMapping(value = "/group/{group_seq}/invite", method = RequestMethod.POST)
	public View groupMemberInvite(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq,
			@RequestParam("member_seq[]") List<Integer> memberSeqList) {
		int res = 0;
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		
		if(workGroup == null || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return jsonView;
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		if(wgm == null) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return jsonView;
		}
		
		if(workGroup.getMaster_seq() != member.getSeq()) {
			model.addAttribute("msg", "마스터만 가능합니다.");
			return jsonView;
		}
		
		res = workService.inviteGroupMembers(memberSeqList, workGroup, request, member);
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/invite", method = RequestMethod.PUT)
	public View groupMemberInviteUpdate(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq,
			GroupInviteLog param) {
		int res = 0;
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		
		if(workGroup == null || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return jsonView;
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		if(wgm == null) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return jsonView;
		}
		
		if(workGroup.getMaster_seq() != member.getSeq()) {
			model.addAttribute("msg", "마스터만 가능합니다.");
			return jsonView;
		}
		
		GroupInviteLog gil = workService.getGroupInviteLog(param.getSeq());
		gil.setRegdate(TimeUtil.getDateTime());
		String code = bcryEncoder.encode(gil.getMember_seq() + gil.getRegdate()).replaceAll("\\/", "").replaceAll("\\.", "");
		gil.setCode(code);
		
		res = workService.updateGroupInviteLog(gil);
		
		if(res == 1) {
			//send notification
			Notification noti = new Notification();
			noti.setGroup_seq(workGroup.getSeq());
			if(member.getProfile() != null) {
				noti.setMember_profile(member.getProfile());
			}
			noti.setMember_seq(gil.getMember_seq());
			noti.setContent(member.getId() + "님이 " + workGroup.getName() + " 업무그룹으로 초대합니다.");
			noti.setLink(request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/work/group/" + workGroup.getSeq() + "/attend/" + code);
			noti.setTarget("self");
			noti.setConfirmyn("N");
			noti.setRegdate(gil.getRegdate());
			notificationService.insertNotification(noti);
			
			//send mail
//			String title = "잡콜이야 : " + workGroup.getName() + " 업무그룹으로 초대합니다.";
//			String from = "rkdvnfms5@naver.com";
//			String text = "URL : " + request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/work/group/" + workGroup.getSeq() + "/attend/" + code;
//			String to = memberService.getMemberOne(gil.getMember_seq()).getEmail();
//			String cc = "";
//			res = MailUtil.mailSend(title, from, text, to, cc);
		}
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/invite", method = RequestMethod.DELETE)
	public View groupMemberInviteDelete(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq,
			GroupInviteLog gil) {
		int res = 0;
		res = workService.deleteGroupInviteLog(gil);
		model.addAttribute("res", res);
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/file", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupFilePage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		int limit = ServletRequestUtils.getIntParameter(request, "limit", 10);
		int offset = ServletRequestUtils.getIntParameter(request, "offset", 0);
		model.addAttribute("limit", limit);
		model.addAttribute("offset", offset);
		
		//get file list
		WorkGroupFile wgf = new WorkGroupFile();
		wgf.setGroup_seq(group_seq);
		wgf.setLimit(limit);
		wgf.setOffset(offset);
		List<Map<String, Object>> fileList = workService.getGroupFileList(wgf);
		model.addAttribute("FileList", fileList);
		
		return "/work/group_file";
	}
	
	@RequestMapping(value = "/group/{group_seq}/fileList", method = RequestMethod.GET)
	public View getGroupFile(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		int offset = ServletRequestUtils.getIntParameter(request, "offset", 0);
		String file_type = ServletRequestUtils.getStringParameter(request, "file_type", "");
		
		WorkGroupFile wgf = new WorkGroupFile();
		wgf.setGroup_seq(group_seq);
		wgf.setLimit(limit_file);
		wgf.setOffset(offset);
		if(file_type != null && !file_type.equals("")) {
			wgf.setFile_type(file_type);
		}
		List<Map<String, Object>> fileList = workService.getGroupFileList(wgf);
		model.addAttribute("fileList", fileList);
		
		return jsonView;
	}
	
	@RequestMapping(value = "/group/{group_seq}/{board_seq}", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupPageBoard(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq,
			@PathVariable("board_seq") int board_seq) {
		//get WorkGroup
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		if(workGroup == null || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return "/util/alert";
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		if(wgm == null) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		//get group member list
		List<Member> groupMemberList = memberService.getGroupMemberList(wgm);
		model.addAttribute("GroupMemberList", groupMemberList);
		
		//get Work Boards
		WorkBoard workBoard = new WorkBoard();
		workBoard.setMember_seq(member.getSeq());
		workBoard.setGroup_seq(group_seq);
		workBoard.setSeq(board_seq);
		workBoard = workService.getWorkBoardOneMapper(workBoard);
		List<WorkBoard> workBoardList = new ArrayList<WorkBoard>();
		workBoardList.add(workBoard);
		
		model.addAttribute("WorkBoardList", workBoardList);
		model.addAttribute("BoardOnly","Y");
		
		model.addAttribute("limit", workBoard.getLimit());
		model.addAttribute("offset",workBoard.getOffset());
		model.addAttribute("total", workService.getWorkBoardCount(workBoard));
		
		return "/work/group";
	}
	
	@RequestMapping(value ="/file_down")
	public void fileDownLoad(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String object_name = ServletRequestUtils.getStringParameter(request, "object_name", "");
		Work work = SessionUtil.getWorkInfo(request, response);
		String download_name = object_name;
		String browser = request.getHeader("User-Agent");
		if (browser.contains("MSIE") || browser.contains("Trident") || browser.contains("Chrome")) {
			download_name = URLEncoder.encode(download_name, "UTF-8").replaceAll("\\+", "%20");
		} else {
			download_name = new String(download_name.getBytes("UTF-8"), "iso-8859-1");
		}
		
		response.setContentType("application/octet-stream");	//다운로드 창이 뜬다
		response.setHeader("Content-Disposition", "attachment; filename=\"" + download_name + "\"");	//다운받는 파일명 지정한다
		
		OutputStream os = response.getOutputStream();
		InputStream fis = OciUtil.getDownloadInputStream(work.getBucket_name(), object_name);
		
		int n = 0;
		byte[] b = new byte[8192];
		while ((n = fis.read(b)) != -1) {
			os.write(b, 0, n);
		}
		fis.close();
		os.close();
		
	}
	
	@RequestMapping(value = "/group/{group_seq}/schedule", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupSchedulePage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		LocalDate now = LocalDate.now();
		int year = ServletRequestUtils.getIntParameter(request, "year",	now.getYear());
		int month = ServletRequestUtils.getIntParameter(request, "month", now.getMonthValue());
		int day = ServletRequestUtils.getIntParameter(request, "day", now.getDayOfMonth());
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		// get draw calendar info
		LocalDate date = LocalDate.of(year, month, 1);
		int startBlank = (date.getDayOfWeek().getValue() == 7? 0 : date.getDayOfWeek().getValue());
		
		date = LocalDate.of(year, month, date.lengthOfMonth());
		int endBlank = (date.getDayOfWeek().getValue() == 7? 6 : 6-date.getDayOfWeek().getValue());
		
		model.addAttribute("lastDay", date.lengthOfMonth());
		model.addAttribute("startBlank", startBlank);
		model.addAttribute("endBlank", endBlank);
		
		date = LocalDate.of(year, month, day);
		model.addAttribute("cur_monthYear", date.getYear() + "-" + date.getMonthValue());
		
		//search date
		LocalDate prev = date.minusMonths(1);
		int prev_startdate = prev.lengthOfMonth()-(startBlank-1);
		String startdate = prev.getYear() + "-" + prev.getMonthValue() + "-" + prev_startdate;
		model.addAttribute("prev_monthYear", prev.getYear() + "-" + prev.getMonthValue());
		model.addAttribute("pre_lastDay", prev.lengthOfMonth());
		
		LocalDate next = date.plusMonths(1);
		String enddate = next.getYear() + "-" + next.getMonthValue() + "-" + (endBlank < 10? "0":"") + endBlank;
		model.addAttribute("next_monthYear", next.getYear() + "-" + next.getMonthValue());
		
		//get schedule list
		WorkBoard workBoard = new WorkBoard();
		workBoard.setType("schedule");
		workBoard.setStartdate(startdate);
		workBoard.setEnddate(enddate);
		workBoard.setGroup_seq(group_seq);
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		workBoard.setAllyn("Y");
		model.addAttribute("workBoardList", workService.getWorkBoardList(workBoard));
		
		return "/work/group_schedule";
	}
	
	@RequestMapping(value = "/group/{group_seq}/request", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupRequestPage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		String searchOpt = ServletRequestUtils.getStringParameter(request, "searchOpt", "");
		String status = ServletRequestUtils.getStringParameter(request, "status", "");
		
		model.addAttribute("searchOpt", searchOpt);
		model.addAttribute("status", status);
		
		//get schedule list
		WorkBoard workBoard = new WorkBoard();
		workBoard.setType("request");
		workBoard.setStatus(status);
		workBoard.setGroup_seq(group_seq);
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		
		if(searchOpt.equals("worker")) {
			workBoard.setWorker(LoginUtil.getLoginMember(request, response).getId());
		}
		else if(searchOpt.equals("register")) {
			workBoard.setRegister(LoginUtil.getLoginMember(request, response).getId());
		}
		
		model.addAttribute("WorkBoardList", workService.getWorkBoardList(workBoard));
		model.addAttribute("limit", workBoard.getLimit());
		model.addAttribute("offset",workBoard.getOffset());
		
		Member member = LoginUtil.getLoginMember(request, response);
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		if(wgm == null) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		//get group member list
		List<Member> groupMemberList = memberService.getGroupMemberList(wgm);
		model.addAttribute("GroupMemberList", groupMemberList);
		
		return "/work/group_request";
	}
	
	@RequestMapping(value = "/group/{group_seq}/image", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupImagePage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq) {
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
		model.addAttribute("WorkGroup", workGroup);
		
		int limit = limit_image;
		int offset = ServletRequestUtils.getIntParameter(request, "offset", 0);
		model.addAttribute("limit", limit);
		model.addAttribute("offset", offset);
		
		//get file list
		WorkGroupFile wgf = new WorkGroupFile();
		wgf.setGroup_seq(group_seq);
		wgf.setLimit(limit);
		wgf.setOffset(offset);
		wgf.setFile_type("image");
		List<Map<String, Object>> fileList = workService.getGroupFileList(wgf);
		model.addAttribute("FileList", fileList);
		
		return "/work/group_image";
	}
	
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	@WorkLnbSet
	public String searchPage(HttpServletRequest request, HttpServletResponse response, Model model, WorkBoard workBoard) {
		if(workBoard.getGroup_seq() > 0) {
			//get WorkGroup
			WorkGroup workGroup = workService.getWorkGroupOne(workBoard.getGroup_seq());
			workGroup.setMember_count(workService.getWorkGroupMemberCnt(workGroup));
			model.addAttribute("WorkGroup", workGroup);
			
			if(workGroup == null || workGroup.getUseyn().equals("N")) {
				model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
				return "/util/alert";
			}
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		//get Work Boards
		workBoard.setMember_seq(member.getSeq());
		List<WorkBoard> workBoardList = workService.getWorkBoardList(workBoard);
		
		model.addAttribute("WorkBoardList", workBoardList);
		
		model.addAttribute("limit", workBoard.getLimit());
		model.addAttribute("offset",workBoard.getOffset());
		model.addAttribute("total", workService.getWorkBoardCount(workBoard));
		model.addAttribute("search", workBoard.getSearch());
		model.addAttribute("group_seq", workBoard.getGroup_seq());
		
		//get Work Members
		if(workBoard.getGroup_seq() > 0) {
			WorkGroupMember wgm = workService.getWorkGroupMemberOne(workBoard.getGroup_seq(), member.getSeq());
			
			if(wgm == null) {
				model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
				return "/util/alert";
			}
			
			//get group member list
			List<Member> groupMemberList = memberService.getGroupMemberList(wgm);
			model.addAttribute("WorkMemberList", groupMemberList);
		} else {
			Member workMember = new Member();
			workMember.setWork_seq(workBoard.getWork_seq());
			List<Member> WorkMemberList = memberService.getMemberList(workMember);
			model.addAttribute("WorkMemberList", WorkMemberList);
		}
		
				
		return "/work/search";
	}
	
	@RequestMapping(value = "/group/{group_seq}/attend/{code}", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupMemberAttendPage(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("group_seq") int group_seq,
			@PathVariable("code") String code) {
//		
//		if(true) {
//			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
//			return "/util/alert";
//		}
		
		WorkGroup workGroup = workService.getWorkGroupOne(group_seq);
		
		if(workGroup == null || workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return "/util/alert";
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		if(!LoginUtil.getLoginCheck(request, response)) {
			model.addAttribute("msg", "로그인이 필요합니다.");
			return "/util/alert";
		}
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(group_seq, member.getSeq());
		
		if(wgm != null) {
			model.addAttribute("msg", "이미 그룹에 참여한 멤버입니다.");
			return "/util/alert";
		}
		
		GroupInviteLog gil = new GroupInviteLog();
		gil.setCode(code);
		gil = workService.getGroupInviteLogByCode(gil);
		
		if(member.getSeq() != gil.getMember_seq() || gil.getGroup_seq() != group_seq) {
			model.addAttribute("msg", "해당 그룹에 초대된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		//attend group
		int res = workService.attendGroup(gil);
		
		if(res > 0) {
			//reset cache
			workService.clearGroupListCache(member.getWork_seq(), member.getSeq());
		}
		
		return "redirect:/work/group/" + group_seq;
	}
	
	@RequestMapping(value = "/notify", method = RequestMethod.GET)
	public View getNotifyList(HttpServletRequest request, HttpServletResponse response, Model model, Notification notification) {
		notification.setLimit(limit_notify);
		notification.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		model.addAttribute("list", notificationService.getNotificationList(notification));
		return jsonView;
	}
}
