package com.example.springboot.psl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.springboot.psl.dao.TailingDao;
import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.TailingService;

/**
 * @ClassNmame BinUnitServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月25日 下午2:18:32
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
@Transactional
public class TailingServiceImpl implements TailingService {
	@Autowired(required = false)
	TailingDao tailingDao;

	@Override
	public List<BinUnit> tailingPutIn(String binUnitList) {

		return tailingDao.tailingPutIn(binUnitList);
	}

	@Override
	@Transactional
	public String saveBinUnitService(BinUnit binUnit) {
		boolean flag = true;
		Integer uflag = 0;
		try {
			binUnit.setUnitType("1");

			uflag = updateShelfFlag(binUnit.getPno(), 1);
			flag = saveBinUnitId(binUnit);
		} catch (Exception e) {

			e.printStackTrace();
		}
		if (flag && uflag > 0) {
			return "SUCCESS";
		}
		return "ERROR";
	}

	@Override
	public boolean saveBinUnitId(BinUnit binUnit) {

		return tailingDao.saveBinUnitId(binUnit);
	}

	@Override
	public Integer updateShelfFlag(String pno, Integer flag) {

		return tailingDao.updateShelfFlag(pno, flag);
	}

	Map<String, Object> data = new HashMap<String, Object>();

	@Override
	@Transactional
	public String tailing(String unitId, String workId) {
		BinUnit list = selectUnitIdPno(unitId);
		if (list == null) {
			return "ERROR";
		}
		String pno = list.getPno();
		Integer flag = updateUnitFlag(unitId, workId);
		Integer uflag = 0;
		if (flag > 0) {
			uflag = updateShelfFlag(pno, 0);
			if (uflag > 0) {
				return "SUCCESS";
			}
		}
		return "ERROR";
	}

	@Override
	public Integer updateUnitFlag(String unitId, String workId) {

		return tailingDao.updateUnitFlag(unitId, workId);
	}

	@Override
	public BinUnit selectUnitIdPno(String unitId) {

		return tailingDao.selectUnitIdPno(unitId);
	}

}
