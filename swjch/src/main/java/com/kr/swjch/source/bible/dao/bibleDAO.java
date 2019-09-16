
package com.kr.swjch.source.bible.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.source.bible.vo.bibleContentsVO;
import com.kr.swjch.source.bible.vo.bibleScheduleVO;

@Repository
public class bibleDAO  {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.source.bible.mapper.bibleMapper";

	public List<bibleContentsVO> getBibleContentsByDay(long day) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("day", day);

		return sqlSession.selectList(Namespace + ".getBibleContentsByDay", param);
	}

	public List<bibleScheduleVO> getBibleScheduleByDay(long day) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("day", day);

		return sqlSession.selectList(Namespace + ".getBibleScheduleByDay", param);
	}
	
	public List<bibleContentsVO> getBibleContentsAll() throws Exception {
		return sqlSession.selectList(Namespace + ".getBibleContentsAll");
	}

	public List<bibleScheduleVO> getBibleScheduleAll() throws Exception {
		return sqlSession.selectList(Namespace + ".getBibleScheduleAll");
	}

}
