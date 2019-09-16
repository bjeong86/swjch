package com.kr.swjch.common.log.service;

import java.util.List;

import com.kr.swjch.common.log.vo.logVO;

public interface logService {
	public List<logVO> getLogs() throws Exception;
	
	public List<logVO> getLogTotalView() throws Exception;
	
	public void saveLog(String ip, String sessionId, String url) throws Exception;
	
	public String getTotalVisitor() throws Exception;
	
	public String  getTodayVisitor() throws Exception;
}
