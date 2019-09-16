package com.kr.swjch.source.bible.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.source.bible.dao.bibleDAO;
import com.kr.swjch.source.bible.vo.bibleContentsVO;
import com.kr.swjch.source.bible.vo.bibleScheduleVO;

@Service
public class bibleServiceImpl implements bibleService {

	@Inject
	private bibleDAO dao;

	@Override
	public List<bibleContentsVO> getBibleContentsByDay(long day) throws Exception {
		return dao.getBibleContentsByDay(day);
	}

	@Override
	public List<bibleScheduleVO> getBibleScheduleByDay(long day) throws Exception {
		return dao.getBibleScheduleByDay(day);
	}
	
	@Override
	public List<bibleContentsVO> getBibleContentsAll() throws Exception {
		return dao.getBibleContentsAll();
	}

	@Override
	public List<bibleScheduleVO> getBibleScheduleAll() throws Exception {
		return dao.getBibleScheduleAll();
	}

}
