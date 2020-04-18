package com.csp.reportquery.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame AllDetailService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 下午3:53:55
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface AllDetailService {
	List<ReportBagHe> queryAllDetail(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	Integer queryAllCount(String keyWord);

	void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception;

	List<Map<String, Object>> queryAllDetailByTime(@Param("startTime") String startTime,
			@Param("endTime") String endTime);
}
