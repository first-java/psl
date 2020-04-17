package com.csp.reportquery.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.csp.reportquery.dao.ReportBagHeDao;
import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.ReportBagHeService;

/**
 * @ClassNmame x.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 上午11:11:53
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class ReportBagHeServiceImpl implements ReportBagHeService {
	@Autowired
	ReportBagHeDao reportBagHeDao;

	public ReportBagHeServiceImpl() {
	}

	public List<ReportBagHe> queryBagHe(int page, int limit, String keyWord) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		return this.reportBagHeDao.queryBagHe(page1, limit1, keyWord);
	}

	public Integer queryAllCount(String keyWord) {
		return this.reportBagHeDao.queryAllCount(keyWord);
	}
}
