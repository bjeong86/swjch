package com.kr.swjch.source.news.service;

import java.util.List;

import com.kr.swjch.source.news.vo.moimNewsVO;

public interface newsService {
	public List<moimNewsVO> getMoimNewsByGubun(String gubun) throws Exception;
	
	public moimNewsVO getMoimNewsById(int id) throws Exception;
}
