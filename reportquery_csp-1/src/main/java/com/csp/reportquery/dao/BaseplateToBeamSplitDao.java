package com.csp.reportquery.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/** @ClassNmame BaseplateToBeamSplitDao.java
  * @author 奥特虾不会写代码 
  * @author E-mail:pengshiliang@latticepower.com
  * @version 1.0
  * @time 创建时间：2020年4月18日 上午8:31:31
  * @Copyright © 2020 by 奥特虾不会写代码  
*/
public interface BaseplateToBeamSplitDao {
	List<ReportBagHe> queryBaseplateToBeamSplit(@Param("page") int page, @Param("limit") int limit,
			@Param("keyWord") String keyWord);

	Integer queryAllCount(@Param("keyWord") String keyWord);

	List<Map<String, Object>> queryBaseplateToBeamSplitByTime(@Param("startTime") String startTime,
			@Param("endTime") String endTime);
}

