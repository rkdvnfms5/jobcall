package com.poozim.jobcall.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.View;

import com.poozim.jobcall.model.Member;
import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.service.MemberService;
import com.poozim.jobcall.service.SignService;
import com.poozim.jobcall.service.WorkService;
import com.poozim.jobcall.util.LoginUtil;
import com.poozim.jobcall.util.MailUtil;
import com.poozim.jobcall.util.PropertiesUil;
import com.poozim.jobcall.util.TimeUtil;

@Controller
@RequestMapping("/sign")
public class SignController {
	
	@Autowired
	private SignService signService;
	
	@Autowired
	private WorkService workService;
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private View jsonView;
	
	@Autowired
	private BCryptPasswordEncoder bcryEncoder;
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String goSignUp(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		session.setAttribute("authYN", "N");
		session.setAttribute("duplYN", "N");
		return "/sign/signup";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String insertSignUp(HttpServletRequest request, HttpServletResponse response, Model model, Work work) {
		String authYN = ServletRequestUtils.getStringParameter(request, "authYN", "N");
		String duplYN = ServletRequestUtils.getStringParameter(request, "duplYN", "N");
		HttpSession session = request.getSession();
		
		if(session.getAttribute("authYN").toString().equals("Y") && authYN.equals("Y") && session.getAttribute("duplYN").toString().equals("Y") && duplYN.equals("Y")) {
			String id = ServletRequestUtils.getStringParameter(request, "id", "");
			String password = ServletRequestUtils.getStringParameter(request, "password", "");
			String name = ServletRequestUtils.getStringParameter(request, "name", "");
			String department = ServletRequestUtils.getStringParameter(request, "department", "");
			String regdate = TimeUtil.getDateTime();
			
			Member member = new Member();
			member.setId(id);
			member.setPassword(password);
			member.setName(name);
			member.setDepartment(department);
			member.setAuth("master");
			member.setEmail(work.getEmail());
			member.setUseyn("Y");
			member.setRegdate(regdate);
			
			work.setRegister(id);
			work.setUseyn("Y");
			work.setRegdate(regdate);
			
			int res = signService.signupWork(work, member);
			
			if(res > 0) {
				LoginUtil.setLoginSession(request, response, member);
			}
		} else if(session.getAttribute("duplYN").toString().equals("N") || duplYN.equals("N")) {
			model.addAttribute("msg", "아이디 중복검사가 필요합니다.");
			return "/util/alert";
		} else {
			model.addAttribute("msg", "이메일 인증이 필요합니다.");
			return "/util/alert";
		}
		
		return "redirect:/work/" + work.getSeq() + "/home";
	}
	
	@RequestMapping(value = "/get_auth", method = RequestMethod.POST)
	public View sendAuthCode(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		String email = ServletRequestUtils.getStringParameter(request, "email", "");
		
		String authcode = getAuthCode();
		String title = "잡콜이야 인증코드 입니다.";
		String from = "rkdvnfms5@naver.com";
		String text = "인증코드 : " + authcode;
		String to = email;
		String cc = "";
		
		MailUtil.mailSend(title, from, text, to, cc);
		
		HttpSession session = request.getSession();
		session.setAttribute("authcode", authcode);
		session.setAttribute("authYN", "N");
		
		return jsonView;
	}
	
	@RequestMapping(value = "/check_auth", method = RequestMethod.POST)
	public View checkAuthCode(HttpServletRequest request, HttpServletResponse response, Model model) throws IOException {
		String value = ServletRequestUtils.getStringParameter(request, "value", "");
		
		HttpSession session = request.getSession();
		String authcode = session.getAttribute("authcode").toString();
		
		if(authcode.equals(value)) {
			session.setAttribute("authYN", "Y");
			model.addAttribute("res", 1);
		} else {
			session.setAttribute("authYN", "N");
			model.addAttribute("res", 0);
		}
		
		return jsonView;
	}
	
	@RequestMapping(value = "/check_dupl", method = RequestMethod.POST)
	public View checkDuplicationId(HttpServletRequest request, HttpServletResponse response, Model model, Member member) throws IOException {
		member = memberService.getMemberById(member);
		
		HttpSession session = request.getSession();
		
		if(member != null && member.getSeq() > 0) {
			session.setAttribute("duplYN", "N");
			model.addAttribute("count", 1);
		} else {
			session.setAttribute("duplYN", "Y");
			model.addAttribute("count", 0);
		}
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
	
	@RequestMapping(value = "/attend/{seq}", method = RequestMethod.GET)
	public String goAttend(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("seq") int seq) {
		HttpSession session = request.getSession();
		session.setAttribute("authYN", "N");
		session.setAttribute("duplYN", "N");
		
		Work work = workService.getWorkOne(seq);
		
		if(work == null || work.getUseyn().equals("N")) {
			model.addAttribute("msg", "해당하는 잡콜센터가 존재하지 않습니다.");
			return "/util/alert";
		}
		model.addAttribute("Work", work);
		return "/sign/attend";
	}
	
	@RequestMapping(value = "/attend/{seq}", method = RequestMethod.POST)
	public String insertMember(HttpServletRequest request, HttpServletResponse response, Model model, 
			@PathVariable("seq") int seq, Member member) {
		String code = ServletRequestUtils.getStringParameter(request, "code", "N");
		String authYN = ServletRequestUtils.getStringParameter(request, "authYN", "N");
		String duplYN = ServletRequestUtils.getStringParameter(request, "duplYN", "N");
		HttpSession session = request.getSession();
		
		Work work = workService.getWorkByCode(code);
		if(work == null || work.getSeq() == 0) {
			model.addAttribute("msg", "참여코드가 올바르지 않습니다.");
			return "/util/alert";
		}
		
		if(session.getAttribute("authYN").toString().equals("Y") && authYN.equals("Y") && session.getAttribute("duplYN").toString().equals("Y") && duplYN.equals("Y")) {
			String regdate = TimeUtil.getDateTime();
			
			member.setAuth("member");
			member.setUseyn("Y");
			member.setRegdate(regdate);
			member.setWork_seq(work.getSeq());
			
			member = signService.attendWork(member);
			
			LoginUtil.setLoginSession(request, response, member);
		} else if(session.getAttribute("duplYN").toString().equals("N") || duplYN.equals("N")) {
			model.addAttribute("msg", "아이디 중복검사가 필요합니다.");
			return "/util/alert";
		} else {
			model.addAttribute("msg", "이메일 인증이 필요합니다.");
			return "/util/alert";
		}
		
		
		
		return "redirect:/work/" + seq + "/home";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String goLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("rtnUrl", ServletRequestUtils.getStringParameter(request, "rtnUrl", ""));
		return "/sign/login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String doLogin(HttpServletRequest request, HttpServletResponse response, Model model,
			Member member) {
		String password = ServletRequestUtils.getStringParameter(request, "password", "");
		String rtnUrl = ServletRequestUtils.getStringParameter(request, "rtnUrl", "");
		
		member = memberService.getMemberById(member);
		
		if(member == null || member.getSeq() == 0 || member.getUseyn().equals("N")) {
			model.addAttribute("msg", "존재하지 않는 아이디입니다.");
			return "/util/alert";
		}
		
		boolean passwordYN = bcryEncoder.matches(password, member.getPassword());
		
		if(!passwordYN) {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
			return "/util/alert";
		} 
		
		LoginUtil.setLoginSession(request, response, member);
		
		return (rtnUrl.equals("")? "redirect:/work/" + member.getWork_seq() + "/home" : "redirect:"+rtnUrl);
	}
	
	@RequestMapping(value = "/logout")
	public String doLogout(HttpServletRequest request, HttpServletResponse response, Model model) {
		LoginUtil.setLogoutSession(request, response);
		return "redirect:/sign/login";
	}
	
	@RequestMapping(value = "/find", method = RequestMethod.GET)
	public String goFind(HttpServletRequest request, HttpServletResponse response, Model model) {
		HttpSession session = request.getSession();
		session.setAttribute("authYN", "N");
		return "/sign/find";
	}
	
	@RequestMapping(value = "/password/modify", method = RequestMethod.POST)
	public View passwordModify(HttpServletRequest request, HttpServletResponse response, Model model,
			@RequestParam(value = "current_password", required = false) String current_password,
			@RequestParam(value = "new_password", required = true) String new_password) {
		Member member;
		
		if(LoginUtil.getLoginCheck(request, response)) {
			member = LoginUtil.getLoginMember(request, response);
		} else {
			HttpSession session = request.getSession();
			String authYN = session.getAttribute("authYN").toString();
			
			if(authYN == null || !authYN.equals("Y")) {
				model.addAttribute("msg", "이메일 인증이 필요합니다.");
				return jsonView;
			}
			
			member = new Member();
			String id = ServletRequestUtils.getStringParameter(request, "id", "");
			String email = ServletRequestUtils.getStringParameter(request, "email", "");
			
			member.setId(id);
			member.setEmail(email);
			member = memberService.getMemberOneCustom(member);
		}
		
		if(member == null || member.getSeq() == 0 || member.getUseyn().equals("N")) {
			model.addAttribute("msg", "회원정보가 존재하지 않습니다.");
			return jsonView;
		}
		
		if(current_password != null && !current_password.equals("")) {
			if(!bcryEncoder.matches(current_password, member.getPassword())) {
				model.addAttribute("msg", "비밀번호가 틀립니다.");
				return jsonView;
			}
		}
		
		member.setPassword(bcryEncoder.encode(new_password));
		
		int res = signService.modifyPassword(member);
		model.addAttribute("res", res);
		
		return jsonView;
	}
	
	
	// for testing
	@RequestMapping(value = "/9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08", method = RequestMethod.GET)
	public String doTestLogin(HttpServletRequest request, HttpServletResponse response, Model model) {
		Member member = new Member();
		member.setId("tester1");
		String password = "gkdlfn123!A";
		
		member = memberService.getMemberById(member);
		
		if(member == null || member.getSeq() == 0 || member.getUseyn().equals("N")) {
			model.addAttribute("msg", "테스트 계정 정보 오류");
			return "/util/alert";
		}
		
		boolean passwordYN = bcryEncoder.matches(password, member.getPassword());
		
		if(!passwordYN) {
			model.addAttribute("msg", "아이디 또는 비밀번호가 틀립니다.");
			return "/util/alert";
		} 
		
		LoginUtil.setLoginSession(request, response, member);
		
		return "redirect:/work/" + member.getWork_seq() + "/home";
	}
}
