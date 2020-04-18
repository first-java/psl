package com.csp.reportquery.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame SelectBagNameToQcService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午1:39:17
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface SelectBagNameToQcService {
	List<ReportBagHe> querySelectBagNameToQc(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	Integer queryAllCount(@Param("keyWord") String keyWord);

	List<Map<String, Object>> querySelectBagNameToQcByTime(@Param("startTime") String startTime,
			@Param("endTime") String endTime);

	void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception;
}
