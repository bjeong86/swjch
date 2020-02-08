package com.kr.swjch.source.bible.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.bible.service.bibleService;
import com.kr.swjch.source.bible.vo.bibleContentsVO;
import com.kr.swjch.source.bible.vo.bibleScheduleVO;

@Controller
public class bibleController {

	private static final Logger logger = LoggerFactory.getLogger(bibleController.class);

	@Inject
	private bibleService service;
	@Inject
	private logService logService;

	@RequestMapping(value = "/bible.do")
	public String bible(HttpServletRequest request, Locale locale, Model model, @RequestParam(value = "day", defaultValue = "0") long day)
			throws Exception {

		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연대기성경 메인");

		long dayCount = day;
		boolean isToday = false;

		if (dayCount == 0L || dayCount == getDayCount()) {
			dayCount = getDayCount();
			isToday = true;
		}

		model.addAttribute("dayCount", dayCount);
		model.addAttribute("isToday", isToday);

		return "source/bible";
	}

	@ResponseBody
	@RequestMapping(value = "/getBibleToday.json")
	public Map<String, Object> getBibleToday(HttpServletRequest request) throws Exception {

		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연대기성경 오늘");

		Map<String, Object> map = new HashMap<String, Object>();
		long dayCount = 0;

		if (dayCount == 0L || dayCount == getDayCount()) {
			dayCount = getDayCount();
		}

		if (dayCount == 1L) {
			map.put("bibleContentsBf", service.getBibleContentsByDay((long) 365));
		} else {
			map.put("bibleContentsBf", service.getBibleContentsByDay(dayCount - (long) 1));
		}

		map.put("bibleContents", service.getBibleContentsByDay(dayCount));

		if (dayCount == 365L) {
			map.put("bibleContentsAf", service.getBibleContentsByDay((long) 1));
		} else {
			map.put("bibleContentsAf", service.getBibleContentsByDay(dayCount + (long) 1));
		}

		map.put("dayCount", dayCount);

		return map;
	}

	@ResponseBody
	@RequestMapping(value = "/getBibleByDay.json")
	public Map<String, Object> getBibleByDay(HttpServletRequest request, Locale locale, Model model,
			@RequestParam(value = "day", defaultValue = "0") long day) throws Exception {
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "연대기성경 일별조회");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bibleContents", service.getBibleContentsByDay(day));
		map.put("bibleSchedule", service.getBibleScheduleByDay(day));

		return map;
	}

	public static long getDayCount() {
		Calendar sday = Calendar.getInstance();
		Calendar today = Calendar.getInstance();
		sday.set(2017, Calendar.DECEMBER, 31);

		long l_sday = sday.getTimeInMillis() / (24 * 60 * 60 * 1000);
		long l_today = today.getTimeInMillis() / (24 * 60 * 60 * 1000);

		long gap = (l_today - l_sday) % 365;

		if (gap == 0) {
			return 365L;
		} else {
			return gap;
		}
	}
	
	@RequestMapping(value = "/getKakaoTTS.json")
	@ResponseBody
	public Map getKakaoTTS(@RequestParam("day") long day) throws Exception {
		
		List<bibleContentsVO> bibleContents = service.getBibleContentsByDay(day);
		List<bibleScheduleVO> bibleSchedule = service.getBibleScheduleByDay(day);

		String text = "";
		for(int i = 0; i < bibleContents.size(); i++){
			
//			if(bibleContents.get(i).getChapter().equals("14") || bibleContents.get(i).getChapter().equals("15")){
				if("1".equals(bibleContents.get(i).getVerse())){
					text += bibleContents.get(i).getTitle();
					text += "<say-as interpret-as=\"kakao:number\" format=\"chinese\">";
					text += bibleContents.get(i).getChapter();
					text +=  "</say-as>장 말씀입니다.\n";
				}
				
				//text += "</break>";
				text += bibleContents.get(i).getContents();
				text += "\n";
//			}
		}
		
		System.out.println("text:"+text);
		
		CloseableHttpClient client = HttpClients.createDefault();
		FileOutputStream outstream = null;
		Integer code = null;
		String endpointURI = "https://kakaoi-newtone-openapi.kakao.com/v1/synthesize";
		
		try{
			String params = "<speak><voice name=\"MAN_READ_CALM\"><prosody rate=\"slow\" volume=\"soft\">" + text + "</prosody></voice></speak>";
			String authorization = "KakaoAK b207cbc09ef027935be9493cce83143a";
			String contentType = "application/xml";
			String payload = params;
			
			HttpPost httpPost = new HttpPost(endpointURI);
			httpPost.addHeader("Authorization", authorization);
			httpPost.addHeader("Content-Type", contentType);
			httpPost.setEntity(new ByteArrayEntity(params.getBytes("UTF-8")));
			
			CloseableHttpResponse response = client.execute(httpPost);
			code = response.getStatusLine().getStatusCode();
			
			System.out.println("상태 코드:"+code);
			
			HttpEntity entity = (HttpEntity) response.getEntity();
			if(entity != null){
				outstream = new FileOutputStream("D://day_"+day+".mp3");
				entity.writeTo(outstream);
			}
		}catch( Exception e){
			System.out.println(e.getMessage());
		}finally{
			client.close();
			outstream.close();
		}
		Map map = new HashMap();
		map.put("code", code);
		return map;
	}
	

	public void writeToFile(String filename, byte[] pData)

	{
		if (pData == null) {
			return;
		}
		int lByteArraySize = pData.length;

		System.out.println(filename);

		try {
			File lOutFile = new File("D://" + filename);
			FileOutputStream lFileOutputStream = new FileOutputStream(lOutFile);
			lFileOutputStream.write(pData);
			lFileOutputStream.close();

		} catch (Throwable e) {
			e.printStackTrace(System.out);
		}
	}
}
