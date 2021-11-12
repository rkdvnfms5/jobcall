package com.poozim.jobcall.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.poozim.jobcall.model.Work;

public class SessionUtil {

	public static Work getWorkInfo(HttpServletRequest request, HttpServletResponse response) {
		if(LoginUtil.getLoginCheck(request, response)) {
			HttpSession session = request.getSession();
			int workseq = LoginUtil.getLoginMember(request, response).getWork_seq();
			Work returnWork = (Work)session.getAttribute("WorkInfo");
			
			if(returnWork.getSeq() == workseq) {
				return returnWork;
			}
		}
		return null;
	}
}
