package com.kr.swjch.admin.hangsa.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ibm.icu.util.Calendar;
import com.ibm.icu.util.ChineseCalendar;
import com.ibm.icu.util.GregorianCalendar;
import com.kr.swjch.admin.hangsa.service.userService;
import com.kr.swjch.admin.hangsa.vo.userVO;
import com.kr.swjch.common.log.service.logService;
import com.kr.swjch.source.home.vo.adminVO;

@Controller
public class userController {
	
	private static final Logger logger = LoggerFactory.getLogger(userController.class);
	
	@Inject
	private userService userService;
	@Inject
	private logService logService;
	
	@RequestMapping(value = "/userList.do")
	public String userList(HttpServletRequest request, Locale locale, Model model) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "주소록");

		return "admin/userList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getUserListByKeyword.json")
	public Map<String, Object> login(HttpServletRequest request, Model model, 
			@RequestParam(value = "keyword", defaultValue = "0") String keyword) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "사용자검색 "+keyword);
		
		Map<String, Object> map = new HashMap<String, Object>();

		List<userVO> userList = new ArrayList<userVO>();
		userList = userService.getUserListByKeyword(keyword);
		
		for (userVO u : userList) {
			if (u.getIsMoon()) {
				Calendar calendar = new GregorianCalendar(Locale.KOREA);
				int nYear = calendar.get(Calendar.YEAR);
				String date = nYear + "" + u.getMonth() + "" + u.getDay();
				String lunarDate = fromLunar(date);
				
				u.setMonth_moon(lunarDate.substring(4, 6));
				u.setDay_moon(lunarDate.substring(6));
			}
		}
		
		map.put("userList", userList);
		return map;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "/getUserListbyMonth.json")
	public Map<String, Object> getUserListbyMonth(HttpServletRequest request, Locale locale, Model model,
			@RequestParam(value = "month", defaultValue = "0") String month) throws Exception {
		
		logService.saveLog(request.getRemoteAddr(), request.getRequestedSessionId(), "사용자검색 "+month);

		Map<String, Object> map = new HashMap<String, Object>();
		
		List<userVO> allUserList = new ArrayList<userVO>();
		List<userVO> birthUserList = new ArrayList<userVO>();
		
		allUserList = userService.getUserList();
		
		for (userVO user : allUserList) {
			if (user.getIsMoon()) {

				Calendar calendar = new GregorianCalendar(Locale.KOREA);
				int nYear = calendar.get(Calendar.YEAR);
				String date = nYear + "" + user.getMonth() + "" + user.getDay();
				String lunarDate = fromLunar(date);
				
				user.setMonth_moon(lunarDate.substring(4, 6));
				user.setDay_moon(lunarDate.substring(6));
				
				if(month.equals(user.getMonth_moon())){
					birthUserList.add(user);
				}
				
			}else{
				
				if(month.equals(user.getMonth())){
					birthUserList.add(user);
				}
			}
		}
		
	
		if("00".equals(month)){
			map.put("userList", allUserList);
		}else{
			map.put("userList", birthUserList);
		}

		return map;
	}
	

	static public String fromLunar(String yyyymmdd) {

		Calendar cal = Calendar.getInstance();
		ChineseCalendar cc = new ChineseCalendar();

		if (yyyymmdd == null)
			return "";

		String date = yyyymmdd.trim();
		if (date.length() != 8) {
			if (date.length() == 4) {
				date = date + "0101";
			} else if (date.length() == 6) {
				date = date + "01";
			} else if (date.length() > 8) {
				date = date.substring(0, 8);
			} else {
				return "";
			}
		}

		// ChinessCalendar.EXTENDED_YEAR 는 Calendar.YEAR 값과 2637 만큼의 차이를 가짐.
		cc.set(ChineseCalendar.EXTENDED_YEAR, Integer.parseInt(date.substring(0, 4)) + 2637);
		cc.set(ChineseCalendar.MONTH, Integer.parseInt(date.substring(4, 6)) - 1);
		cc.set(ChineseCalendar.DAY_OF_MONTH, Integer.parseInt(date.substring(6)));

		cal.setTimeInMillis(cc.getTimeInMillis());

		int y = cal.get(Calendar.YEAR);
		int m = cal.get(Calendar.MONTH) + 1;
		int d = cal.get(Calendar.DAY_OF_MONTH);

		StringBuffer sb = new StringBuffer();
		if (y < 1000)
			sb.append("0");
		else if (y < 100)
			sb.append("00");
		else if (y < 10)
			sb.append("000");
		sb.append(y);

		if (m < 10)
			sb.append("0");
		sb.append(m);

		if (d < 10)
			sb.append("0");
		sb.append(d);

		return sb.toString();
	}
	
}
