package com.poozim.jobcall.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MainController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String root(HttpServletRequest request, HttpServletResponse response, Model model) {
		
		return "redirect:/main.poo";
	}
	
	@RequestMapping(value = "/main.poo", method = RequestMethod.GET)
	public String main(HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("@@@@@@@@@@@@@@@@@@@@@ddd");
		return "/main/main";
	}
}
