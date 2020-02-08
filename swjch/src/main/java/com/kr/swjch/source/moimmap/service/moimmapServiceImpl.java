package com.kr.swjch.source.moimmap.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.source.moimmap.dao.moimmapDAO;
import com.kr.swjch.source.moimmap.vo.moimmapVO;

@Service
public class moimmapServiceImpl implements moimmapService {

	@Inject
	private moimmapDAO dao;

	@Override
	public List<moimmapVO> getMoimMap() throws Exception {
		// TODO Auto-generated method stub
		return dao.getMoimMap();
	}

}
