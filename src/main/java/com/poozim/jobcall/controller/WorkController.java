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

import com.poozim.jobcall.model.Work;
import com.poozim.jobcall.service.WorkService;

@Controller
@RequestMapping("/work")
public class WorkController {
	
	@Autowired
	private WorkService workService;
	
	@RequestMapping(value = "/view/{code}")
	public String main(HttpServletRequest request, HttpServletResponse response, Model model,
			@PathVariable("code") String code) {
		
		return "/main/main";
	}
	
	@RequestMapping(value = "/get", method = RequestMethod.GET)
	public String getWorkList(HttpServletRequest request, HttpServletResponse response, Model model) {
		List<Work> workList = workService.getWorkList();
		System.out.println(workList);
		return "/main/main";
	}
}
