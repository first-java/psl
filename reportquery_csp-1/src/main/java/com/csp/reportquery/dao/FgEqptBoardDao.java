package com.csp.reportquery.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.csp.reportquery.entity.ReportBagHe;

/**
 * @ClassNmame FgEqptBoardDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午3:46:35
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface FgEqptBoardDao {
	List<ReportBagHe> queryAllFgEqptBoard(@Param("page") int page, @Param("limit") int limit);

	Integer queryAllCount(String keyWord);
}
