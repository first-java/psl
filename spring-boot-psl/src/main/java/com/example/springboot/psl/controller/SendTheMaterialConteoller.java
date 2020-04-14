package com.example.springboot.psl.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.BinUnitService;

@Controller
@RequestMapping("send")
public class SendTheMaterialConteoller {
	@Autowired(required = false)
	BinUnitService binUnitService;

	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("send")
	public String t() {
		logger.info("ee");
		return "paiUnit";// 返回派料页面
	}

	@RequestMapping("selectBinUnitEqpt")
	@ResponseBody
	public Map<String, Object> selectBacthByLotId(String batchLot) {
		List<BinUnit> binUnitList = binUnitService.selectBinUnitEqpt("");
		data.put("code", binUnitList);
		return data;
	}

	@RequestMapping("selectBinUnitEqptStatus")
	@ResponseBody
	public Map<String, Object> selectBinUnitEqptStatus(String eqpt) {

		List<BinUnit> binUnitList = binUnitService.selectBinUnitEqpt(eqpt);
		data.put("code", binUnitList);
		return data;
	}

	SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");// 设置日期格式
	String k = df.format(new Date());

	@RequestMapping("selectBinUnitStatus")
	@ResponseBody
	public Map<String, Object> selectBinUnitStatus(String unitId, String eqpt, String blotId) {

		List<BinUnit> binUnitListUnit = binUnitService.selectUnitByUnit(unitId);
		if (binUnitListUnit.size() < 1) {
			data.put("code", 2);
			data.put("msg", "未找到该片号信息！或者此片已经出库！");
			return data;
		}
		String eqptLot = "";
		if (blotId == null) {
			eqptLot = eqpt + "-" + k.substring(2, 10).replace("-", "");
			String bdLotIdEqpt = binUnitService.selectMaxBdLotId(eqptLot);

			if (bdLotIdEqpt == null) {
				bdLotIdEqpt = k.substring(2, 10).replace("-", "");
				bdLotIdEqpt = eqpt + "-" + bdLotIdEqpt + "-001";
			}
			data.put("BDLOTID", bdLotIdEqpt);
		}
		data.put("code", binUnitListUnit);
		return data;
	}

	@RequestMapping("unitIdToEqpt")
	@ResponseBody
	public Map<String, Object> unitIdToEqpt(BinUnit binUnit) {

		String flag = binUnitService.unitIdToEqpt(binUnit);
		if ("ERROR".equals(flag)) {

			data.put("code", 1);
			data.put("msg", "派料失败！请重试");
			return data;
		}
		data.put("code", 0);
		data.put("msg", "派料成功");
		return data;

	}
}
