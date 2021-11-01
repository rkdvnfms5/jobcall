package com.poozim.jobcall.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poozim.jobcall.model.Member;

public class LoginUtil {

	public static void setLoginSession(HttpServletRequest request, HttpServletResponse response, Member member) {
		HttpSession session = request.getSession();
		session.setAttribute("member", member);
		session.setAttribute("loginCheck", true);
	}
	
	public static boolean getLoginCheck(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		if(session.getAttribute("loginCheck") == null || !(boolean)session.getAttribute("loginCheck")) {
			return false;
		}
		return true;
	}
	
	public static Member getLoginMember(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		return (Member)session.getAttribute("member");
	}
}
