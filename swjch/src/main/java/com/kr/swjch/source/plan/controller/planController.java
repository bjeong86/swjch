package com.kr.swjch.source.plan.controller;

import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.plan.service.planService;

@Controller
public class planController {
	
	private static final Logger logger = LoggerFactory.getLogger(planController.class);
	
	@Inject
	private planService planService;
	@Inject
	private logService logService;
	
	@RequestMapping(value = "/plan.do")
	public String plan(HttpServletRequest request, Locale locale, Model model) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연간계획 메인");
		
		model.addAttribute("planInfo", planService.getPlanInfoByYear("2019"));
		return "source/plan";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getPlanByYear.json")
	public Map<String, Object> getPlanByYear(HttpServletRequest request, Locale locale, Model model,
			@RequestParam(value = "year", defaultValue = "0") String year) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연간계획 년도별조회");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("planInfo", planService.getPlanInfoByYear(year));

		return map;
	}
	
}
