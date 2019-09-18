
package com.kr.swjch.admin.hangsa.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kr.swjch.admin.hangsa.vo.userVO;

@Repository
public class userDAO  {

	@Inject
	private SqlSession sqlSession;

	private static final String Namespace = "com.kr.swjch.admin.hangsa.mapper.userMapper";

	public List<userVO> getUserList() throws Exception {
		return sqlSession.selectList(Namespace + ".getUserList");
	}
	
	public List<userVO> getUserListByKeyword(String keyword) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("keyword", keyword);
		
		return sqlSession.selectList(Namespace + ".getUserListByKeyword", param);
	}

}
