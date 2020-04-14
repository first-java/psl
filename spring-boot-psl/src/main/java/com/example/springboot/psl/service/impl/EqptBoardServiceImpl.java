package com.example.springboot.psl.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.springboot.psl.dao.EqptBoardDao;
import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.EqptBoardService;

/**
 * @ClassNmame EqptBoardServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月8日 下午3:35:12
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class EqptBoardServiceImpl implements EqptBoardService {
	@Autowired(required=false)
	EqptBoardDao eqptBoardDao;

	/**
	 * 机台看板，查询所有机台，贴带批次号
	 */
	@Override
	public List<BinUnit> selectEqptAll() {

		return eqptBoardDao.selectEqptAll();
	}

}
