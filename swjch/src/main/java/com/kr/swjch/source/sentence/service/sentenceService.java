package com.kr.swjch.source.sentence.service;

import java.util.List;

import com.kr.swjch.source.bible.vo.bibleContentsVO;
import com.kr.swjch.source.bible.vo.bibleScheduleVO;

public interface sentenceService {
	public List<bibleContentsVO> getBibleContentsByDay(long day) throws Exception;
	public List<bibleScheduleVO> getBibleScheduleByDay(long day) throws Exception;
	
	public List<bibleContentsVO> getBibleContentsAll() throws Exception;
	public List<bibleScheduleVO> getBibleScheduleAll() throws Exception;
}
