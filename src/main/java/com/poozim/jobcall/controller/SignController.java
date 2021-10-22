package com.poozim.jobcall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.service.SignService;

@Controller
public class SignController {
	
	@Autowired
	private SignService signService;
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String goSignUp(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		return "/sign/insert";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String insertSignUp(HttpServletRequest request, HttpServletResponse response, Model model, Work work) {
		Member member = new Member();
		int res = signService.signupWork(work, member);
		return "/sign/insert";
	}
}
