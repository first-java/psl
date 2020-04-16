package com.example.springboot.psl.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.BinUnitService;

@Controller
@RequestMapping("detail")
public class BinUnitDetailController {
	@Autowired(required = false)
	BinUnitService binUnitService;
	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	/*2020/04/15测试提交到github*/	@RequestMapping("detail")
	public String t() {
		return "binunitiddetail";//
	}

	@RequestMapping("unitDateilHtml")
	public String unitDateil() {
		return "unitDateil";//
	}

	@RequestMapping("unitByUnitAll")
	@ResponseBody
	public Map<String, Object> selectBacthByLotId(String unitId) {

		List<BinUnit> binUnitList = binUnitService.selectUnitByUnitAll();
		data.put("code", 0);
		data.put("msg", "");
		data.put("count", 1000);
		data.put("data", binUnitList);
		return data;
	}

	@RequestMapping("selectUnitDateil")
	@ResponseBody
	public Map<String, Object> selectUnitDateil(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, BinUnit binUnit) {
		List<BinUnit> datas = binUnitService.selectUnitDateil(page, limit, binUnit);
		int countx = binUnitService.queryUnitDateilCount();

		data.put("code", 0);
		data.put("msg", "");
		data.put("count", countx);
		data.put("data", datas);
		return data;
	}

	@RequestMapping("unitDateil")
	@ResponseBody
	public Map<String, Object> unitDateil(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, BinUnit binUnit) {
		String lotTypeList = binUnit.getLotType();

		String list[] = lotTypeList.split("-");
		String lotType = list[0];
		String specId = list[1];
		String binId = list[2];

		List<BinUnit> datas = binUnitService.selectUnitDateilByLBI(page, limit, lotType, binId, specId);

		int countx = binUnitService.queryUnitDateilCountByLBI(lotType, binId, specId);

		data.put("code", 0);
		data.put("msg", "");
		data.put("count", countx);
		data.put("data", datas);
		return data;
	}
}
