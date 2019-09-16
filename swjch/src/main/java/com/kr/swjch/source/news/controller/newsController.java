package com.kr.swjch.source.news.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.news.service.newsService;

@Controller
public class newsController {

	@Inject
	private newsService newsService;
	@Inject
	private logService logService;

	@ResponseBody
	@RequestMapping(value = "/getMoimNewsById.json")
	public Map<String, Object> getMoimNewsById(HttpServletRequest request, @RequestParam(value = "id", defaultValue = "0") int id) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "모임뉴스 조회");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("news", newsService.getMoimNewsById(id));

		return map;
	}

}
