package com.poozim.jobcall.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.poozim.jobcall.aop.WorkLnbSet;
import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.model.WorkBoard;
import com.poozim.jobcall.model.WorkCategory;
import com.poozim.jobcall.model.WorkGroup;
import com.poozim.jobcall.model.WorkGroupMember;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.service.WorkService;
import com.poozim.jobcall.util.LoginUtil;

@Controller
@RequestMapping("/work")
public class WorkController {
	
	@Autowired
	private WorkService workService;
	
	@Autowired
	private MemberService memberService;
	
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
	
	@RequestMapping(value = "/{groupseq}/group", method = RequestMethod.GET)
	@WorkLnbSet
	public String group(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("groupseq") int groupseq) {
		//get WorkGroup
		WorkGroup workGroup = workService.getWorkGroupOne(groupseq);
		model.addAttribute("WorkGroup", workGroup);
		
		if(workGroup != null && workGroup.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당 그룹이 존재하지 않습니다.");
			return "/util/alert";
		}
		
		Member member = LoginUtil.getLoginMember(request, response);
		
		WorkGroupMember wgm = workService.getWorkGroupMemberOne(groupseq, member.getSeq());
		
		if(wgm == null) {
			model.addAttribute("msg", "그룹에 참여된 멤버가 아닙니다.");
			return "/util/alert";
		}
		
		//get Work Boards
		
		
		return "/work/view";
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	@WorkLnbSet
	public String categoryPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		Member member = LoginUtil.getLoginMember(request, response);

		WorkCategory workCategory = new WorkCategory();
		workCategory.setMember_seq(member.getSeq());
		
		List<WorkCategory> workCategoryList = workService.getWorkCategoryList(workCategory);
		return "/work/category";
	}
}
