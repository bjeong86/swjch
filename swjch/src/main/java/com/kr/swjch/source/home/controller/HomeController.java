package com.kr.swjch.source.home.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.home.vo.adminVO;
import com.kr.swjch.source.news.service.newsService;

@Controller
public class HomeController {
	
	@Inject
	private newsService newsService;
	@Inject
	private logService logService;

	@RequestMapping(value = "/")
	public String home(HttpServletRequest request, Model model) throws Exception {
		
		HttpSession httpSession = request.getSession(true);
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "HOME isAdmin:"+httpSession.getAttribute("isAdmin"));
		
		model.addAttribute("sermonList", newsService.getMoimNewsByGubun("sermon"));
		model.addAttribute("localList", newsService.getMoimNewsByGubun("local-mission"));
		model.addAttribute("eduList", newsService.getMoimNewsByGubun("edu-training"));
		model.addAttribute("joyList", newsService.getMoimNewsByGubun("joy-sad"));
		
		model.addAttribute("totalVisitor", logService.getTotalVisitor());
		model.addAttribute("todayVisitor", logService.getTodayVisitor());

		return "source/index";
	}
	
	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, Model model, adminVO user) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "로그인");
		
		HttpSession httpSession = request.getSession(true);
		if("111".equals(user.getUserId()) && "111".equals(user.getUserPw())){
			httpSession.setAttribute("isAdmin", "y");
		}else{
			httpSession.setAttribute("isAdmin", "n");
		}
		
		model.addAttribute("sermonList", newsService.getMoimNewsByGubun("sermon"));
		model.addAttribute("localList", newsService.getMoimNewsByGubun("local-mission"));
		model.addAttribute("eduList", newsService.getMoimNewsByGubun("edu-training"));
		model.addAttribute("joyList", newsService.getMoimNewsByGubun("joy-sad"));
		
		model.addAttribute("totalVisitor", logService.getTotalVisitor());
		model.addAttribute("todayVisitor", logService.getTodayVisitor());

		return "source/index";
	}
	
	@RequestMapping(value = "/logout.do")
	public String logout(HttpServletRequest request, Model model) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "로그아웃");
		
		HttpSession httpSession = request.getSession(true);
		httpSession.setAttribute("isAdmin", "n");
		
		model.addAttribute("sermonList", newsService.getMoimNewsByGubun("sermon"));
		model.addAttribute("localList", newsService.getMoimNewsByGubun("local-mission"));
		model.addAttribute("eduList", newsService.getMoimNewsByGubun("edu-training"));
		model.addAttribute("joyList", newsService.getMoimNewsByGubun("joy-sad"));
		
		model.addAttribute("totalVisitor", logService.getTotalVisitor());
		model.addAttribute("todayVisitor", logService.getTodayVisitor());

		return "source/index";
	}
	
}

