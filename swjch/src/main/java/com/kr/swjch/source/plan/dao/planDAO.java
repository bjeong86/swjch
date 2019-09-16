package com.kr.swjch.source.plan.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.source.plan.vo.calendarVO;

@Repository
public class planDAO {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.source.plan.mapper.planMapper";

	public List<calendarVO> getPlanInfoByYear(String year) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("year", year);
		return sqlSession.selectList(Namespace + ".getPlanInfoByYear", param);
	}

}
