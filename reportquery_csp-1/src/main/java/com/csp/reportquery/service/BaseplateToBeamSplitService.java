package com.csp.reportquery.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame BaseplateToBeamSplitService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 上午8:32:23
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface BaseplateToBeamSplitService {
	List<ReportBagHe> queryBaseplateToBeamSplit(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	Integer queryAllCount(@Param("keyWord") String keyWord);

	List<Map<String, Object>> queryBaseplateToBeamSplitByTime(@Param("startTime") String startTime,
			@Param("endTime") String endTime);
	
	void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception;
}
