package com.kr.swjch.common.log.controller;

import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kr.swjch.common.log.service.logService;

@Controller
public class logController {

	private static final Logger logger = LoggerFactory.getLogger(logController.class);

	@Inject
	private logService service;

	@RequestMapping(value = "/log.do", method = RequestMethod.GET)
	public String log(HttpServletRequest request, Locale locale, Model model) throws Exception {

		model.addAttribute("logList",  service.getLogs());
		model.addAttribute("logTotalViewList",  service.getLogTotalView());
		
		return "source/log";
	}

}
