package com.example.springboot.psl.controller;

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
import com.example.springboot.psl.service.EqptBoardService;

@Controller
@RequestMapping("eqpt")
public class EqptBoardController {
	@Autowired
	EqptBoardService eqptBoardService;
	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("eqpt")
	public String t() {
		logger.info("ee");
		return "eqpt/eqptboard";
	}

	@RequestMapping("eqptboard")
	@ResponseBody
	public Map<String, Object> selectBacthByLotId(String batchLot) {

		List<BinUnit> binUnitList = eqptBoardService.selectEqptAll();
		data.put("code", 0);
		data.put("msg", "");
		data.put("count", 10);
		data.put("data", binUnitList);

		return data;
	}

}
