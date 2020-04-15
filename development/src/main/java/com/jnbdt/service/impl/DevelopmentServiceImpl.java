package com.jnbdt.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.jnbdt.dao.DevelopmentDao;
import com.jnbdt.entity.Development;
import com.jnbdt.service.DevelopmentService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;

/**
 * @ClassNmame DevelopmentServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月13日 下午2:41:31
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
@Transactional
public class DevelopmentServiceImpl implements DevelopmentService {

	@Autowired
	DevelopmentDao developmentDao;

	@Override
	public boolean saveTbarcode(List<Development> development) {

		return developmentDao.saveTbarcode(development);
	}

	@Override
	public Map<String, Object> selectUnitId(String unitId) {

		return developmentDao.selectUnitId(unitId);
	}

	@Override
	public Map<String, Object> selectBarcodeString(String unitId) {

		return developmentDao.selectBarcodeString(unitId);
	}

	Map<String, Object> data = new HashMap<String, Object>();

	@Override
	@Transactional
	public Map<String, Object> saveUnit(String unitId, String workId, String yfQty) {
		Map<String, Object> workIdRrn = selectWorkId(workId);
		if (workIdRrn == null) {
			data.put("code", "2");
			data.put("msg", "此工号无权限！");
			return data;
		}
		Development deve = selectInCacheSeq();
		Development deve1 = selectStockTransSeq();
		String userRrn = workIdRrn.get("USER_RRN").toString();
		String inCacheSeq = deve.getInCacheRrn();
		String stockTransRrn = deve1.getStockTransRrn();

		JSONTokener unitIdJ = new JSONTokener(unitId);
		JSONArray arrayunitId = (JSONArray) unitIdJ.nextValue();

		JSONTokener y1fQty = new JSONTokener(yfQty);
		JSONArray arrayyfQty = (JSONArray) y1fQty.nextValue();
		List<Development> listDeve1 = new ArrayList<Development>();
		List<Development> listDeve2 = new ArrayList<Development>();
		List<Development> listDeve3 = new ArrayList<Development>();
		List<Development> listDeve4 = new ArrayList<Development>();
		List<Development> listDeve5 = new ArrayList<Development>();
		for (int j = 0; j < arrayunitId.size(); j++) {
			Development develop1 = new Development();
			Development develop2 = new Development();
			Development develop3 = new Development();
			Development develop5 = new Development();

			Map<String, Object> deve2 = selectBarcodeSeq();
			String barcodeRrn = deve2.get("BARCODERRN").toString();

			Map<String, Object> deve3 = selectStockSeq();
			String stockRrn = deve3.get("STOCKRRN").toString();

			JSONObject object = arrayunitId.getJSONObject(j);
			JSONObject object1 = arrayyfQty.getJSONObject(j);

			String barcodeString = object.getString("unitId");
			String yfQty1 = object1.getString("yfQty");
			/**
			 * t_material.T_BARCODE
			 */

			develop1.setBarcodeRrn(Integer.parseInt(barcodeRrn));
			develop1.setBarcodeString(barcodeString);
			develop1.setLoginRrn(userRrn);
			develop1.setBarcodeType("10");
			develop1.setYfQty(Integer.parseInt(yfQty1));

			/**
			 * t_material.t_stock
			 */
			develop2.setStockRrn(stockRrn);
			develop2.setBarcodeType("10");
			develop2.setBarcodeRrn(Integer.parseInt(barcodeRrn));
			develop2.setBarcodeId(barcodeString);
			develop2.setLoginRrn(userRrn);
			develop2.setBarcodeStatus("1");
			develop2.setInTrans(stockTransRrn);
			develop2.setRackingRrn("1000001280");
			develop2.setLastTrans(stockTransRrn);

			/**
			 * t_material.t_stock_in_history
			 */
			develop3.setInCacheRrn(inCacheSeq);
			develop3.setBarcodeType("10");
			develop3.setBarcodeRrn(Integer.parseInt(barcodeRrn));
			develop3.setBarcodeId(barcodeString);
			develop3.setLoginRrn(userRrn);
			develop3.setRackingRrn("1000001280");
			develop3.setStockRrn(stockRrn);
			develop3.setTransRrn(stockTransRrn);

			/**
			 * t_material.t_stock_trans_detail
			 */
			develop5.setTransRrn(stockTransRrn);
			develop5.setTransType("1");
			develop5.setTransTypeId("IN");
			develop5.setStockRrn(stockRrn);
			develop5.setBarcodeType("10");
			develop5.setBarcodeRrn(Integer.parseInt(barcodeRrn));
			develop5.setBarcodeId(barcodeString);
			develop5.setLoginRrn(userRrn);
			develop5.setRackingRrn("1000001280");

			listDeve1.add(develop1);
			listDeve2.add(develop2);
			listDeve3.add(develop3);
			listDeve5.add(develop5);
		}
		/**
		 * t_material.t_stock_trans
		 */
		Development develop4 = new Development();
		develop4.setTransRrn(stockTransRrn);
		develop4.setTransType("1");
		develop4.setTransTypeId("IN");
		develop4.setTransQty(String.valueOf(arrayunitId.size()));
		develop4.setLoginRrn(userRrn);

		listDeve4.add(develop4);
		Boolean saveTbarcode = false;
		Integer saveTrans = 0;
		Integer saveStockIn = 0;
		Integer saveStockTrans = 0;
		Integer saveStockTransD = 0;

		try {
			saveTbarcode = saveTbarcode(listDeve1);
			saveTrans = saveTrans(listDeve2);
			saveStockIn = saveStockIn(listDeve3);
			saveStockTrans = saveStockTrans(listDeve4);
			saveStockTransD = saveStockTransD(listDeve5);
			if (saveTbarcode && saveTrans > 0 && saveStockIn > 0 && saveStockTrans > 0 && saveStockTransD > 0) {
				outUnit(unitId, workId, yfQty);

				data.put("code", "1");
				data.put("msg", "入库成功(操作成功)！");
				return data;
			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			data.put("code", "2");
			data.put("msg", "入库失败！数据库异常！" + e.toString());
			return data;

		}
		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		data.put("code", "2");
		data.put("msg", "入库失败！");
		return data;
	}

	@Override
	public Map<String, Object> selectWorkId(String workId) {

		return developmentDao.selectWorkId(workId);
	}

	@Override
	public Development selectInCacheSeq() {

		return developmentDao.selectInCacheSeq();
	}

	@Override
	public Development selectStockTransSeq() {

		return developmentDao.selectStockTransSeq();
	}

	@Override
	public Map<String, Object> selectBarcodeSeq() {

		return developmentDao.selectBarcodeSeq();
	}

	@Override
	public Map<String, Object> selectStockSeq() {

		return developmentDao.selectStockSeq();
	}

	@Override
	public Integer saveTrans(List<Development> development) {

		return developmentDao.saveTrans(development);
	}

	@Override
	public Integer saveStockIn(List<Development> development) {

		return developmentDao.saveStockIn(development);
	}

	@Override
	public Integer saveStockTrans(List<Development> development) {

		return developmentDao.saveStockTrans(development);
	}

	@Override
	public Integer saveStockTransD(List<Development> development) {

		return developmentDao.saveStockTransD(development);
	}

	@Override
	public Map<String, Object> selectOutCache() {

		return developmentDao.selectOutCache();
	}

	@Override
	@Transactional
	public Map<String, Object> outUnit(String unitId, String workId, String yfQty) {
		Map<String, Object> workIdRrn = selectWorkId(workId);
		if (workIdRrn == null) {
			data.put("code", "2");
			data.put("msg", "此工号无权限！");
			return data;
		}
		String userRrn = workIdRrn.get("USER_RRN").toString();
		JSONTokener unitIdJ = new JSONTokener(unitId);
		JSONArray arrayunitId = (JSONArray) unitIdJ.nextValue();

		Development deve1 = selectStockTransSeq();
		String stockTransRrn = deve1.getStockTransRrn();

		JSONTokener y1fQty = new JSONTokener(yfQty);
		JSONArray arrayyfQty = (JSONArray) y1fQty.nextValue();

		List<Development> listDeve1 = new ArrayList<Development>();
		List<Development> listDeve3 = new ArrayList<Development>();
		List<Development> listDeve4 = new ArrayList<Development>();
		List<Development> listDeve5 = new ArrayList<Development>();
		Development develop3 = new Development();
		for (int j = 0; j < arrayunitId.size(); j++) {
			Development develop1 = new Development();
			Development develop4 = new Development();
			Development develop5 = new Development();
			JSONObject object = arrayunitId.getJSONObject(j);
			String barcodeString = object.getString("unitId");

			JSONObject object1 = arrayyfQty.getJSONObject(j);
			String yfQty2 = object1.getString("yfQty");

			/**
			 * t_material.t_stock 修改
			 */
			updateStock(barcodeString, stockTransRrn);// 修改t_material.t_stock表 1
			Map<String, Object> barcodeMap = selectBarcodeId(barcodeString);

			String barcodeRrn = barcodeMap.get("BARCODE_RRN").toString();
			String barcodeId = barcodeMap.get("BARCODE_ID").toString();
			String loginRrn = barcodeMap.get("LOGIN_RRN").toString();
			String StockRrn = barcodeMap.get("STOCK_RRN").toString();
			/**
			 * t_material.t_stock_out_history 新增记录
			 */
			Map<String, Object> outCache = selectOutCache();
			String outTrans = outCache.get("OUTCACHERRN").toString();
			develop1.setOutCacheRrn(outTrans);
			develop1.setBarcodeType("10");
			develop1.setBarcodeRrn(Integer.parseInt(barcodeRrn));
			develop1.setBarcodeId(barcodeId);
			develop1.setLoginRrn(loginRrn);
			develop1.setRackingRrn("1000001280");
			develop1.setStockRrn(StockRrn);
			develop1.setCustomerRrn("1000006815");
			develop1.setTransRrn(stockTransRrn);

			listDeve1.add(develop1);

			/**
			 * t_material.t_stock_trans_detail
			 */
			Map<String, Object> transRrn = selectTransRrn(barcodeString);
			String stockRrn = transRrn.get("STOCK_RRN").toString();
			String barcodeRrn1 = transRrn.get("BARCODE_RRN").toString();
			develop4.setTransRrn(stockTransRrn);
			develop4.setTransType("3");
			develop4.setTransTypeId("OUT");
			develop4.setStockRrn(stockRrn);
			develop4.setBarcodeType("10");
			develop4.setBarcodeRrn(Integer.parseInt(barcodeRrn1));
			develop4.setBarcodeId(barcodeString);
			develop4.setLoginRrn(userRrn);// 工号RRN
			develop4.setRackingRrn("1000001280");

			listDeve4.add(develop4);// 4

			develop5.setBarcodeString(barcodeString);
			develop5.setYfQty(Integer.parseInt(yfQty2));
			develop5.setWorkId(workId);

			listDeve5.add(develop5);

		}
		/**
		 * t_material.t_stock_trans
		 */
		develop3.setTransRrn(stockTransRrn);// 出库，从out history 表中找
		develop3.setTransType("3");
		develop3.setTransTypeId("OUT");
		develop3.setTransQty(String.valueOf(arrayunitId.size()));
		develop3.setLoginRrn(userRrn);// 工号RRN

		listDeve3.add(develop3);
		boolean saveStockOut;
		Integer saveStockTrans;
		Integer saveStockTransD;
		boolean saveJnbdtKu;
		try {
			saveStockOut = saveStockOut(listDeve1);// out history 表
			saveStockTrans = saveStockTrans(listDeve3);// t_stock_trans表
			saveStockTransD = saveStockTransD(listDeve4);// t_stock_trans_detail
			if (saveStockOut && saveStockTrans > 0 && saveStockTransD > 0) {
				saveJnbdtKu = saveJnbdtKu(listDeve5);
				if (saveJnbdtKu) {
					data.put("code", "1");
					data.put("msg", "操作成功！");
					return data;
				} else {
					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
					data.put("code", "2");
					data.put("msg", "保存jnbdt_ku表数据失败！");
					return data;
				}

			}
		} catch (Exception e) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			data.put("code", "2");
			data.put("msg", "出库失败，数据库异常！" + e.toString());

			return data;
		}
		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		data.put("code", "2");
		data.put("msg", "出库失败 ！");

		return data;
	}

	@Override
	public boolean updateStock(String lastTrans, String barcodeString) {

		return developmentDao.updateStock(lastTrans, barcodeString);
	}

	@Override
	public Map<String, Object> selectBarcodeId(String barcodeString) {

		return developmentDao.selectBarcodeId(barcodeString);
	}

	@Override
	public Map<String, Object> selectTransRrn(String barcodeString) {

		return developmentDao.selectTransRrn(barcodeString);
	}

	@Override
	public boolean saveStockOut(List<Development> development) {

		return developmentDao.saveStockOut(development);
	}

	@Override
	public boolean saveJnbdtKu(List<Development> development) {

		return developmentDao.saveJnbdtKu(development);
	}

}
