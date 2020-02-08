
package com.kr.swjch.source.moimmap.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.source.bible.vo.bibleContentsVO;
import com.kr.swjch.source.bible.vo.bibleScheduleVO;
import com.kr.swjch.source.moimmap.vo.moimmapVO;

@Repository
public class moimmapDAO  {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.source.moimmap.mapper.moimmapMapper";
	
	public List<moimmapVO> getMoimMap() throws Exception {
		return sqlSession.selectList(Namespace + ".getMoimMap");
	}

}
