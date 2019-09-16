
package com.kr.swjch.source.news.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.source.news.vo.moimNewsVO;

@Repository
public class newsDao{

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.source.news.mapper.newsMapper";

	public List<moimNewsVO> getMoimNewsByGubun(String gubun) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gubun", gubun);
		return sqlSession.selectList(Namespace + ".getMoimNewsByGubun", param);
	}
	
	public moimNewsVO getMoimNewsById(int id) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		return sqlSession.selectOne(Namespace + ".getMoimNewsById", param);
	}
}
