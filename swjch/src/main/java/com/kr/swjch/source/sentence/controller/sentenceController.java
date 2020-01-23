package com.kr.swjch.source.sentence.controller;

import java.util.Calendar;
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
import com.kr.swjch.source.sentence.service.sentenceService;

@Controller
public class sentenceController {

	private static final Logger logger = LoggerFactory.getLogger(sentenceController.class);

	@Inject
	private sentenceService service;
	@Inject
	private logService logService;

	@RequestMapping(value = "/sentence.do")
	public String sentence(HttpServletRequest request, Locale locale, Model model, @RequestParam(value = "day", defaultValue = "0") long day)
			throws Exception {

		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "성경 암송");
		
//		long dayCount = day;
//		boolean isToday = false;
//
//		if (dayCount == 0L || dayCount == getDayCount()) {
//			dayCount = getDayCount();
//			isToday = true;
//		}
//
//		model.addAttribute("dayCount", dayCount);
//		model.addAttribute("isToday", isToday);

		return "source/sentence";
	}

//	@ResponseBody
//	@RequestMapping(value = "/getBibleToday.json")
//	public Map<String, Object> getBibleToday(HttpServletRequest request) throws Exception {
//		
//		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연대기성경 오늘");
//
//		Map<String, Object> map = new HashMap<String, Object>();
//		long dayCount = 0;
//
//		if (dayCount == 0L || dayCount == getDayCount()) {
//			dayCount = getDayCount();
//		}
//
//		if (dayCount == 1L) {
//			map.put("bibleContentsBf", service.getBibleContentsByDay((long) 365));
//		} else {
//			map.put("bibleContentsBf", service.getBibleContentsByDay(dayCount - (long) 1));
//		}
//
//		map.put("bibleContents", service.getBibleContentsByDay(dayCount));
//
//		if (dayCount == 365L) {
//			map.put("bibleContentsAf", service.getBibleContentsByDay((long) 1));
//		} else {
//			map.put("bibleContentsAf", service.getBibleContentsByDay(dayCount + (long) 1));
//		}
//
//		map.put("dayCount", dayCount);
//
//		return map;
//	}
//
//	@ResponseBody
//	@RequestMapping(value = "/getBibleByDay.json")
//	public Map<String, Object> getBibleByDay(HttpServletRequest request, Locale locale, Model model,
//			@RequestParam(value = "day", defaultValue = "0") long day) throws Exception {
//		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연대기성경 일별조회");
//
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("bibleContents", service.getBibleContentsByDay(day));
//		map.put("bibleSchedule", service.getBibleScheduleByDay(day));
//
//		return map;
//	}
//
//	public static long getDayCount() {
//		Calendar sday = Calendar.getInstance();
//		Calendar today = Calendar.getInstance();
//		sday.set(2017, Calendar.DECEMBER, 31);
//
//		long l_sday = sday.getTimeInMillis() / (24 * 60 * 60 * 1000);
//		long l_today = today.getTimeInMillis() / (24 * 60 * 60 * 1000);
//
//		long gap = (l_today - l_sday) % 365;
//
//		if (gap == 0) {
//			return 365L;
//		} else {
//			return gap;
//		}
//	}
}
