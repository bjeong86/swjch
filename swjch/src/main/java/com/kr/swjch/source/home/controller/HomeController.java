package com.kr.swjch.source.home.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.news.service.newsService;

@Controller
public class HomeController {
	
	@Inject
	private newsService newsService;
	@Inject
	private logService logService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "HOME");
		
		model.addAttribute("sermonList", newsService.getMoimNewsByGubun("sermon"));
		model.addAttribute("localList", newsService.getMoimNewsByGubun("local-mission"));
		model.addAttribute("eduList", newsService.getMoimNewsByGubun("edu-training"));
		model.addAttribute("joyList", newsService.getMoimNewsByGubun("joy-sad"));
		
		model.addAttribute("totalVisitor", logService.getTotalVisitor());
		model.addAttribute("todayVisitor", logService.getTodayVisitor());

		return "source/index";
	}
	
}

