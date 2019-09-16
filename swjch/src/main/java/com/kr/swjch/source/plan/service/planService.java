package com.kr.swjch.source.plan.service;

import java.util.List;
import com.kr.swjch.source.plan.vo.calendarVO;

public interface planService {
	public List<calendarVO> getPlanInfoByYear(String year) throws Exception;
}
