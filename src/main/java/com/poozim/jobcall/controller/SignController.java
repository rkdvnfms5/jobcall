package com.poozim.jobcall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.service.SignService;
import com.poozim.jobcall.util.MailUtil;

@Controller
@RequestMapping("/sign")
public class SignController {
	
	@Autowired
	private SignService signService;
	
	@Autowired
	private View jsonView;
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String goSignUp(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		return "/sign/signup";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String insertSignUp(HttpServletRequest request, HttpServletResponse response, Model model, Work work) {
		String id = ServletRequestUtils.getStringParameter(request, "id", "");
		String password = ServletRequestUtils.getStringParameter(request, "password", "");
		String name = ServletRequestUtils.getStringParameter(request, "name", "");
		String department = ServletRequestUtils.getStringParameter(request, "department", "");
		
		Member member = new Member();
		member.setId(id);
		member.setPassword(password);
		member.setName(name);
		member.setDepartment(department);
		member.setAuth("master");
		member.setEmail(work.getEmail());
		
		work.setRegister(name);
		
		int res = signService.signupWork(work, member);
		return "/sign/insert";
	}
	
	@RequestMapping(value = "/get_auth", method = RequestMethod.POST)
	public View sendAuthCode(HttpServletRequest request, HttpServletResponse response, Model model) {
		String title = "잡콜이야 인증코드 입니다.";
		String from = "rkdvnfms5@naver.com";
		String text = "인증코드 : " + getAuthCode();
		String to = "rkdvnfms5@naver.com";
		String cc = "";
		
		MailUtil.mailSend(title, from, text, to, cc);
		return jsonView;
	}
	
	public String getAuthCode() {
		char[] arr_num = {'1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
		StringBuffer code = new StringBuffer();
		Random random = new Random();
		
		for (int j = 0; j < 6; j++) {
			code.append(arr_num[random.nextInt(arr_num.length)]);
		}
		
		return code.toString();
	}
}
