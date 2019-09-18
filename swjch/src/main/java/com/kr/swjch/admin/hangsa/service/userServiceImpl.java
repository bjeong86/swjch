package com.kr.swjch.admin.hangsa.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.kr.swjch.admin.hangsa.dao.userDAO;
import com.kr.swjch.admin.hangsa.vo.userVO;

@Service
public class userServiceImpl implements userService {

	@Inject
	private userDAO dao;

	@Override
	public List<userVO> getUserList() throws Exception {
		return dao.getUserList();
	}

	@Override
	public List<userVO> getUserListByKeyword(String keyword) throws Exception {
		return dao.getUserListByKeyword(keyword);
	}



}
