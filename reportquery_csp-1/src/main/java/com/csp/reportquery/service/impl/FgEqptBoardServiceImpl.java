package com.csp.reportquery.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csp.reportquery.dao.FgEqptBoardDao;
import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.FgEqptBoardService;

/**
 * @ClassNmame FgEqptBoardServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午3:49:00
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class FgEqptBoardServiceImpl implements FgEqptBoardService {
	@Autowired
	FgEqptBoardDao fgEqptBoardDao;

	@Override
	public List<ReportBagHe> queryAllFgEqptBoard(int page, int limit) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		return fgEqptBoardDao.queryAllFgEqptBoard(page1, limit1);
	}

	@Override
	public Integer queryAllCount(String keyWord) {

		return fgEqptBoardDao.queryAllCount(keyWord);
	}

}
