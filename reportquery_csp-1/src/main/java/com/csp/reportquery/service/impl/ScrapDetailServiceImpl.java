package com.csp.reportquery.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.ScrapDetailService;
import com.csp.reportquery.dao.ScrapDetailDao;

/**
 * @ClassNmame ScrapDetailServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 上午11:26:16
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class ScrapDetailServiceImpl implements ScrapDetailService {

	@Autowired
	ScrapDetailDao ScrapDetailDao;

	@Override
	public List<ReportBagHe> queryScrapDetail(int page, int limit, String keyWord) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		return ScrapDetailDao.queryScrapDetail(page1, limit1, keyWord);
	}

	@Override
	public Integer queryAllCount(String keyWord) {

		return ScrapDetailDao.queryAllCount(keyWord);
	}
}
