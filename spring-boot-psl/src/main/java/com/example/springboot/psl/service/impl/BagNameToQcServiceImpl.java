package com.example.springboot.psl.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.springboot.psl.dao.BagNameToQcDao;
import com.example.springboot.psl.entity.BagNameToQc;
import com.example.springboot.psl.service.BagNameToQcService;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;

/**
 * @ClassNmame BagNameToQcServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 上午9:38:25
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
@Transactional
public class BagNameToQcServiceImpl implements BagNameToQcService {
	@Autowired
	BagNameToQcDao bagNameToQcDao;
	Map<String, Object> data = new HashMap<String, Object>();

	@Override
	public Map<String, Object> selectGoodBag(String bagName) {

		return bagNameToQcDao.selectGoodBag(bagName);
	}

	@Override
	public boolean saveBagNameToQc(List<BagNameToQc> bagNameToQcList) {

		return bagNameToQcDao.saveBagNameToQc(bagNameToQcList);
	}

	@Override
	public Map<String, Object> saveBagName(BagNameToQc bagNameToQc) {

		List<BagNameToQc> binUnitList = new ArrayList<BagNameToQc>();

		JSONTokener bagname1 = new JSONTokener(bagNameToQc.getBagName());
		JSONArray arraybagname1 = (JSONArray) bagname1.nextValue();

		JSONTokener specId1 = new JSONTokener(bagNameToQc.getSpecId());
		JSONArray arrayspecId1 = (JSONArray) specId1.nextValue();

		JSONTokener qty1 = new JSONTokener(bagNameToQc.getQty());
		JSONArray arrayqty1 = (JSONArray) qty1.nextValue();

		JSONTokener binId1 = new JSONTokener(bagNameToQc.getBinId());
		JSONArray arraybinId1 = (JSONArray) binId1.nextValue();

		JSONTokener lotType1 = new JSONTokener(bagNameToQc.getLotType());
		JSONArray arrayotType1 = (JSONArray) lotType1.nextValue();

		for (int j = 0; j < arraybagname1.size(); j++) {
			BagNameToQc binUnit2 = new BagNameToQc();

			JSONObject bagname21 = arraybagname1.getJSONObject(j);
			JSONObject specId21 = arrayspecId1.getJSONObject(j);
			JSONObject qty21 = arrayqty1.getJSONObject(j);
			JSONObject binId21 = arraybinId1.getJSONObject(j);
			JSONObject lotType21 = arrayotType1.getJSONObject(j);

			String bagName = bagname21.getString("bagName");
			String specId = specId21.getString("specId");
			String qty = qty21.getString("qty");
			String binId = binId21.getString("binId");
			String lotType = lotType21.getString("lotType");

			binUnit2.setSpecId(specId);
			binUnit2.setQty(qty);
			binUnit2.setBinId(binId);
			binUnit2.setBagName(bagName);
			binUnit2.setLotType(lotType);
			binUnit2.setWorkId(bagNameToQc.getWorkId());

			binUnitList.add(binUnit2);

		}

		boolean flag;
		try {
			flag = saveBagNameToQc(binUnitList);
			if (flag) {

				data.put("msg", "保存成功！");
			} else {

				data.put("msg", "保存失败");
			}

		} catch (Exception e) {

			data.put("msg", "数据库异常" + e.toString());

		}

		return data;

	}

	@Override
	public Map<String, Object> selectBag(String bagName) {
		 
		return bagNameToQcDao.selectBag(bagName);
	}

}
