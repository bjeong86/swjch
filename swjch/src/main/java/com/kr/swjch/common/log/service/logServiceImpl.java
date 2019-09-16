package com.kr.swjch.common.log.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.common.log.dao.logDAO;
import com.kr.swjch.common.log.vo.logVO;

@Service
public class logServiceImpl implements logService {

	@Inject
	private logDAO dao;

	@Override
	public void saveLog(String ip, String sessionId, String url) throws Exception {
		dao.saveLog(ip, sessionId, url);
	}

	@Override
	public List<logVO> getLogs() throws Exception {
		return dao.getLogs();
	}

	@Override
	public List<logVO> getLogTotalView() throws Exception {
		return dao.getLogTotalView();
	}

	@Override
	public String getTotalVisitor() throws Exception {
		return dao.getTotalVisitor();
	}

	@Override
	public String getTodayVisitor() throws Exception {
		return dao.getTodayVisitor();
	}
}
