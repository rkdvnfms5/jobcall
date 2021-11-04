package com.poozim.jobcall.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.aop.WorkLnbSet;
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
	
	@RequestMapping(value = "/group/{groupseq}", method = RequestMethod.GET)
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
	
	@RequestMapping(value = "/group/new", method = RequestMethod.GET)
	@WorkLnbSet
	public String groupNewPage(HttpServletRequest request, HttpServletResponse response, Model model) {
		return "/work/group_new";
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
	
}
