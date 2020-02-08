package com.kr.swjch.source.moimmap.controller;

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
import com.kr.swjch.source.moimmap.service.moimmapService;

@Controller
public class moimmapController {

	private static final Logger logger = LoggerFactory.getLogger(moimmapController.class);

	@Inject
	private moimmapService service;
	@Inject
	private logService logService;

	@RequestMapping(value = "/moimmap.do")
	public String sentence(HttpServletRequest request, Locale locale, Model model, @RequestParam(value = "day", defaultValue = "0") long day)
			throws Exception {

		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "전국모임맵");

		return "source/moimmap";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getMoimMap.json")
	public Map<String, Object> getMoimMap(HttpServletRequest request) throws Exception {

		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "전국모임맵 정보");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("moimmap", service.getMoimMap());
		
		System.out.println("map.size() : "+map.size());

		return map;
	}
	
	
}
