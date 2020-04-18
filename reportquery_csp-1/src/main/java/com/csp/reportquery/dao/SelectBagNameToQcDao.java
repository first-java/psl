package com.csp.reportquery.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame SelectBagNameToQcDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午1:38:12
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface SelectBagNameToQcDao {
	List<ReportBagHe> querySelectBagNameToQc(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	Integer queryAllCount(@Param("keyWord") String keyWord);

	List<Map<String, Object>> querySelectBagNameToQcByTime(@Param("startTime") String startTime,
			@Param("endTime") String endTime);
}
