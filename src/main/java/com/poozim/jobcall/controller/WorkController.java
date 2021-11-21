package com.poozim.jobcall.controller;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.ws.rs.Consumes;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.aop.WorkLnbSet;
import com.poozim.jobcall.model.ActionLog;
import com.poozim.jobcall.model.Comment;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkCategoryGroup;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.service.WorkService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.MailUtil;
import com.poozim.jobcall.util.TimeUtil;

@Controller
@RequestMapping("/work")
public class WorkController {
	
	@Autowired
	private WorkService workService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private View jsonView;
	
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
		
		//get Work Members
		
		return "/work/view";
	}
	
	
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	@WorkLnbSet
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
		WorkCategoryGroup wcg = new WorkCategoryGroup();
		wcg.setGroupSeqList(groupSeqList);
		wcg.setCategory_seq(category_seq);
		wcg.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		
		int res = workService.moveWorkGroupList(wcg);
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
		
		if(group.getMember_seq() == LoginUtil.getLoginMember(request, response).getSeq()) {
			group.setAccess(workGroup.getAccess());
			group.setContent(workGroup.getContent());
			res = workService.updateWorkGroup(group);
			
		}
		
		model.addAttribute("res", res);
		model.addAttribute("msg", "그룹 마스터만 수정이 가능합니다.");
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
		
		workService.insertWorkGroup(workGroup);
		
		return "redirect:/work/group/" + workGroup.getSeq();
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public View getBoardList(HttpServletRequest request, HttpServletResponse response, Model model, WorkBoard workBoard) {
		List<WorkBoard> workBoardList = workService.getWorkBoardList(workBoard);
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		model.addAttribute("workBoardList", workBoardList);
		return jsonView;
	}
	
	@RequestMapping(value = "/board/{board_seq}", method = RequestMethod.GET)
	public View getBoardOne(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable("board_seq") int board_seq,
			WorkBoard workBoard) {
		workBoard.setMember_seq(LoginUtil.getLoginMember(request, response).getSeq());
		workBoard = workService.getWorkBoardOneMapper(workBoard);
		
		model.addAttribute("Board", workBoard);
		return jsonView;
	}
	
	@RequestMapping(value = "/board", method = RequestMethod.POST)
	public View InsertBoard(HttpServletRequest request, HttpServletResponse response, Model model, WorkBoard workBoard,
			 @RequestParam("attachFiles") List<MultipartFile> attachFiles) {
		Member member = LoginUtil.getLoginMember(request, response);
		
//		String content = ServletRequestUtils.getStringParameter(request, "content", "");
//		String type = ServletRequestUtils.getStringParameter(request, "type", "");
//		int group_seq = ServletRequestUtils.getIntParameter(request, "group_seq", 0);
		
		String content = workBoard.getContent().replaceAll("(\r\n|\r|\n|\n\r)", "\\<br\\>");
		workBoard.setContent(content);
		workBoard.setMember_seq(member.getSeq());
		workBoard.setMember_id(member.getId());
		workBoard.setMember_name(member.getName());
		workBoard.setWork_seq(member.getWork_seq());
		workBoard.setRegister(member.getId());
		workBoard.setRegdate(TimeUtil.getDateTime());
		
		if(attachFiles != null && !attachFiles.isEmpty()) {
			workBoard.setAttachFileList(attachFiles);
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
			}
			if(!worker.equals("")) {
				workBoard.setWorker(worker);
			}
			
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
		System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ : " + work.getSeq());
		System.out.println(memberService.getMemberOneCustom(member));
		if(memberService.getMemberOneCustom(member) != null) {
			model.addAttribute("res", res);
			model.addAttribute("msg", "이미 참여중인 이메일입니다.");
			return jsonView;
		}
		
		//메일 보내기
		String title = "잡콜이야 " + work.getTitle() + "로 초대합니다.";
		String from = "rkdvnfms5@naver.com";
		String text = "URL : " + request.getRequestURL().toString().replace(request.getRequestURI(), "") + "/sign/attend/" + work.getSeq();
		text += "\n참여 코드 : " + work.getCode();
		String to = email;
		String cc = "";
		
		res = MailUtil.mailSend(title, from, text, to, cc);
		model.addAttribute("res", res);
		
		return jsonView;
	}
}
