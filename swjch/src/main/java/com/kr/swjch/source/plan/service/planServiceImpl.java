package com.kr.swjch.source.plan.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.source.plan.dao.planDAO;
import com.kr.swjch.source.plan.vo.calendarVO;

@Service
public class planServiceImpl implements planService {

	@Inject
	private planDAO dao;
	
	@Override
	public List<calendarVO> getPlanInfoByYear(String year) throws Exception {
		return dao.getPlanInfoByYear(year);
	}

}
