package com.example.springboot.psl.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;

import com.example.springboot.psl.dao.BinUnitDao;
import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.BinUnitService;

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
public class BinUnitServiceImpl implements BinUnitService {
	@Autowired
	BinUnitDao binUnitDao;

	@Override
	public boolean saveBunitShelf(List<BinUnit> binUnitList) {

		return binUnitDao.saveBunitShelf(binUnitList);
	}

	@Override
	@Transactional
	public String saveBunitShelfService(List<BinUnit> binUnitList) {

		boolean succ = false;
		try {
			succ = saveBunitShelf(binUnitList);
		} catch (Exception e) {
			return e.toString();
		}
		if (succ) {
			return "success";
		}

		return "error";
	}

	@Override
	public List<BinUnit> selectShelf() {
		return binUnitDao.selectShelf();
	}

	@Override
	public List<BinUnit> selectBacthByLotId(String lotId) {

		return binUnitDao.selectBacthByLotId(lotId);
	}

	@Override
	public List<BinUnit> selectUnitIdByLotId(String batchLot, String unitId) {

		return binUnitDao.selectUnitIdByLotId(batchLot, unitId);
	}

	@Override
	public List<BinUnit> selectUnitByUnit(String unitId) {

		return binUnitDao.selectUnitByUnit(unitId);
	}

	@Override
	public Map<String, Object> selectCountByLotId(String lotId) {

		return binUnitDao.selectCountByLotId(lotId);
	}

	@Override
	public Map<String, Object> selectShelfByLotId(@Param("lotId") String lotId, @Param("odd") String odd) {

		return binUnitDao.selectShelfByLotId(lotId, odd);
	}

	@Override
	@Transactional
	public String saveUnit(BinUnit binUnit) {
		List<BinUnit> binUnitList = new ArrayList<BinUnit>();

		JSONTokener binUnit1 = new JSONTokener(binUnit.getUnitId());
		JSONArray arraybinUnit1 = (JSONArray) binUnit1.nextValue();

		JSONTokener specId1 = new JSONTokener(binUnit.getSpecId());
		JSONArray arrayspecId1 = (JSONArray) specId1.nextValue();

		JSONTokener qty1 = new JSONTokener(String.valueOf(binUnit.getQty()));
		JSONArray arrayqty1 = (JSONArray) qty1.nextValue();

		JSONTokener binId1 = new JSONTokener(binUnit.getBinId());
		JSONArray arraybinId1 = (JSONArray) binId1.nextValue();

		JSONTokener lotType1 = new JSONTokener(binUnit.getLotType());
		JSONArray arrayotType1 = (JSONArray) lotType1.nextValue();

		JSONTokener pNo1 = new JSONTokener(binUnit.getPno());
		JSONArray arraypNo1 = (JSONArray) pNo1.nextValue();

		for (int j = 0; j < arraybinUnit1.size(); j++) {
			BinUnit binUnit2 = new BinUnit();

			JSONObject binUnit21 = arraybinUnit1.getJSONObject(j);
			JSONObject specId21 = arrayspecId1.getJSONObject(j);
			JSONObject qty21 = arrayqty1.getJSONObject(j);
			JSONObject binId21 = arraybinId1.getJSONObject(j);
			JSONObject lotType21 = arrayotType1.getJSONObject(j);
			JSONObject pNo21 = arraypNo1.getJSONObject(j);

			String unitId = binUnit21.getString("unitId");
			String specId = specId21.getString("specId");
			String qty = qty21.getString("qty");
			String binId = binId21.getString("binId");
			String lotType = lotType21.getString("lotType");
			String pNo = pNo21.getString("pno");

			binUnit2.setUnitId(unitId);
			binUnit2.setSpecId(specId);
			binUnit2.setQty(qty);
			binUnit2.setBinId(binId);
			binUnit2.setLotType(lotType);
			binUnit2.setPno(pNo);
			binUnit2.setLotId(binUnit.getBatchLot());
			binUnit2.setWorkId(binUnit.getWorkId());
			binUnitList.add(binUnit2);

		}
		Integer te;
		boolean flag;
		try {
			te = updateShelfFlag(binUnitList);
			if (te < 1) {
				return "ERROR";
			}
			flag = saveBinUnit(binUnitList);
			if (flag) {
				return "success";
			}
		} catch (Exception e) {
			return "error";
		}

		return "error";

	}

	@Override
	public Integer updateShelfFlag(List<BinUnit> binUnitList) {

		return binUnitDao.updateShelfFlag(binUnitList);
	}

	@Override
	public boolean saveBinUnitId(BinUnit binUnit) {

		return binUnitDao.saveBinUnitId(binUnit);
	}

	@Override
	public boolean saveBinUnit(List<BinUnit> binUnitList) {

		return binUnitDao.saveBinUnit(binUnitList);
	}

	@Override
	public List<BinUnit> selectBinUnitEqpt(String eqpt) {

		return binUnitDao.selectBinUnitEqpt(eqpt);
	}

	@Override
	public String selectMaxBdLotId(String lotId) {

		return binUnitDao.selectMaxBdLotId(lotId);
	}

	@Override
	@Transactional
	public String unitIdToEqpt(BinUnit binUnitList1) {
		List<BinUnit> binUnitList = new ArrayList<BinUnit>();

		JSONTokener binUnit1 = new JSONTokener(binUnitList1.getUnitId());
		JSONArray arraybinUnit1 = (JSONArray) binUnit1.nextValue();

		JSONTokener qty1 = new JSONTokener(String.valueOf(binUnitList1.getQty()));
		JSONArray arrayqty1 = (JSONArray) qty1.nextValue();

		JSONTokener pno1 = new JSONTokener(String.valueOf(binUnitList1.getPno()));
		JSONArray arraypno1 = (JSONArray) pno1.nextValue();

		String specId = binUnitList1.getSpecId();
		String binId = binUnitList1.getBinId();
		String lotType = binUnitList1.getLotType();
		String bdLotId = binUnitList1.getBdLotId();
		String eqpt = binUnitList1.getEqpt();
		for (int j = 0; j < arraybinUnit1.size(); j++) {
			BinUnit binUnit2 = new BinUnit();

			JSONObject binUnit21 = arraybinUnit1.getJSONObject(j);
			JSONObject qty21 = arrayqty1.getJSONObject(j);
			JSONObject pno21 = arraypno1.getJSONObject(j);

			String unitId = binUnit21.getString("unitId");
			String qty = qty21.getString("qty");
			String pno = pno21.getString("pno");

			binUnit2.setEqpt(eqpt);
			binUnit2.setUnitId(unitId);
			binUnit2.setSpecId(specId);
			binUnit2.setQty(qty);
			binUnit2.setPno(pno);
			binUnit2.setBinId(binId);
			binUnit2.setLotType(lotType);
			binUnit2.setFlagType("贴带出库");
			binUnit2.setBdLotId(bdLotId);
			binUnit2.setWorkId(binUnitList1.getWorkId());
			binUnit2.setOutWorkId(binUnitList1.getWorkId());
			binUnitList.add(binUnit2);
		}
		List<BinUnit> l = selectBinUnitEqpt(eqpt);
		boolean flag;
		boolean eqptFlag = true;
		int unitFlag;
		boolean shelfFlag;
		try {
			shelfFlag = updateShelfStatus(binUnitList);
			flag = saveUnitIdToEqpt(binUnitList);
			if (l.size() > 0) {
				eqptFlag = updateEqpt(binUnitList1);
			}
			unitFlag = updateUnitStatus(binUnitList, binUnitList1.getWorkId());
			if (flag && eqptFlag && unitFlag > 0 && shelfFlag) {
				return "SUCCESS";
			}
		} catch (Exception e) {
			e.printStackTrace();
			/**
			 * 强制使用事务回滚，任意方法有异常回滚事务
			 */
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			return "ERROR";
		}

		return "ERROR";

	}

	@Override
	public boolean updateShelfStatus(List<BinUnit> binUnitList) {

		return binUnitDao.updateShelfStatus(binUnitList);
	}

	@Override
	public boolean saveUnitIdToEqpt(List<BinUnit> binUnitList) {

		return binUnitDao.saveUnitIdToEqpt(binUnitList);
	}

	@Override
	public boolean updateEqpt(BinUnit eqpt) {

		return binUnitDao.updateEqpt(eqpt);
	}

	@Override
	public Integer updateUnitStatus(List<BinUnit> binUnitList, String workId) {

		return binUnitDao.updateUnitStatus(binUnitList, workId);
	}

	@Override
	public List<BinUnit> selectUnitByUnitAll() {

		return binUnitDao.selectUnitByUnitAll();
	}

	@Override
	public List<BinUnit> selectUnitDateil(int page, int limit, BinUnit binUnit) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		page = page1;
		limit = limit1;
		return binUnitDao.selectUnitDateil(page, limit, binUnit);
	}

	@Override
	public Integer queryUnitDateilCount() {

		return binUnitDao.queryUnitDateilCount();
	}

	@Override
	public List<BinUnit> selectUnitDateilByLBI(int page, int limit, String lotType, String binId, String specId) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		page = page1;
		limit = limit1;
		return binUnitDao.selectUnitDateilByLBI(page, limit, lotType, binId, specId);
	}

	@Override
	public Integer queryUnitDateilCountByLBI(String lotType, String binId, String specId) {

		return binUnitDao.queryUnitDateilCountByLBI(lotType, binId, specId);
	}

}
