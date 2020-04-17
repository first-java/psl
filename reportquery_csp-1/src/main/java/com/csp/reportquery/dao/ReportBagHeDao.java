package com.csp.reportquery.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame BagHeDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 上午10:42:56
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface ReportBagHeDao {
	List<ReportBagHe> queryBagHe(@Param("page") int page, @Param("limit") int limit, @Param("keyWord") String keyWord);

	Integer queryAllCount(String keyWord);
}
