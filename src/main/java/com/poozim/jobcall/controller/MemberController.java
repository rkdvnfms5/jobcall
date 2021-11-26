package com.poozim.jobcall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.util.LoginUtil;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private View jsonView;
	
	@RequestMapping(value = "/{seq}", method = RequestMethod.PUT)
	public View modifyMember(HttpServletRequest request, HttpServletResponse response, Model model, Member param,
			@PathVariable("seq") int seq, 
			@RequestParam(value = "profileImage", required = false) MultipartFile profileImage) {
		if(LoginUtil.getLoginMember(request, response).getSeq() != seq) {
			
			model.addAttribute("msg", "본인만 수정가능합니다.");
			return jsonView;
		}
		
		int res = 0;
		
		Member member = memberService.getMemberOne(seq);
		
		//필수
		if(param.getName() != null && !param.getName().equals("")) {
			member.setName(param.getName());
		}
		
		if(param.getDepartment() != null && !param.getDepartment().equals("")) {
			member.setDepartment(param.getDepartment());
		}
		
		//선택
		member.setPosition(param.getPosition());
		member.setTel(param.getTel());
		member.setWorktime(param.getWorktime());
		member.setDescription(param.getDescription());
		
		if(profileImage != null && !profileImage.isEmpty()) {
			member.setProfileImage(profileImage);
		}
		
		res = memberService.updateMember(member, request, response);
		
		model.addAttribute("res", res);
		return jsonView;
	}
}
