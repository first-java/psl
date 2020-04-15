package com.jnbdt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jnbdt.repository.CollectDao;
import com.jnbdt.service.IConllectService;

/**
 * @ClassNmame TestServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月15日 下午8:27:52
 * @Copyright © 2020 by 奥特虾不会写代码
 */

@Service
public class ConllectServiceImpl implements IConllectService {

	@Autowired
	CollectDao conllectDao;

	@Override
	public int query() {

		return conllectDao.query();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> listUser() {

		return conllectDao.listUser();
	}

}
