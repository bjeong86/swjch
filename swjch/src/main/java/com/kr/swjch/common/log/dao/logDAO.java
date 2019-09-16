package com.kr.swjch.common.log.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.common.log.vo.logVO;

@Repository
public class logDAO{

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.common.log.mapper.logMapper";

	public void saveLog(String ip, String sessionId, String url) throws Exception {
		logVO vo = new logVO();
		vo.setIp(ip);
		vo.setSessionId(sessionId);
		vo.setUrl(url);
		
		sqlSession.insert(Namespace + ".insertLog", vo);
	}

	public List<logVO> getLogs() throws Exception {
		return sqlSession.selectList(Namespace + ".getLogs");
	}

	public List<logVO> getLogTotalView() throws Exception {
		return sqlSession.selectList(Namespace + ".getLogTotalView");
	}
	
	
	public String getTotalVisitor() throws Exception{
		return sqlSession.selectOne(Namespace + ".getTotalVisitor");
	}
	
	public String  getTodayVisitor() throws Exception{
		return sqlSession.selectOne(Namespace + ".getTodayVisitor");
	}
	
}
