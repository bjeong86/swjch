package com.kr.swjch.source.news.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.source.news.dao.newsDao;
import com.kr.swjch.source.news.vo.moimNewsVO;

@Service
public class newsServiceImpl implements newsService {

	@Inject
	private newsDao dao;

	@Override
	public List<moimNewsVO> getMoimNewsByGubun(String gubun) throws Exception {
		return dao.getMoimNewsByGubun(gubun);
	}

	@Override
	public moimNewsVO getMoimNewsById(int id) throws Exception {
		return dao.getMoimNewsById(id);
	}

}
