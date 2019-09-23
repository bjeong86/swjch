package com.kr.swjch.admin.hangsa.service;

import java.util.List;

import com.kr.swjch.admin.hangsa.vo.userVO;

public interface userService {
	public List<userVO> getUserList() throws Exception;
	
	public List<userVO> getUserListByKeyword(String keyword) throws Exception;

	public List<userVO> getFamilyById(String id) throws Exception;

}
