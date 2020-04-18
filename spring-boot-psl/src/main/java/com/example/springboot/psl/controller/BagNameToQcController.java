package com.example.springboot.psl.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.psl.entity.BagNameToQc;
import com.example.springboot.psl.service.BagNameToQcService;

/**
 * @ClassNmame BagnameToQc.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 上午9:12:14
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class BagNameToQcController {

	@Autowired
	BagNameToQcService bagNameToQcService;
	Map<String, Object> data = new HashMap<String, Object>();

	@GetMapping("bagNameToQc")
	public String toqcHTML() {
		return "toqc/bagNameToQc";
	}

	
	@RequestMapping("selectGoodBag")
	@ResponseBody
	public Map<String, Object> selectGoodBag(String bagName) {

		Map<String, Object> binUnitList = bagNameToQcService.selectGoodBag(bagName);
		
		Map<String, Object> bag = bagNameToQcService.selectBag(bagName);
		if (bag != null) {
			data.put("code", 1);
			data.put("msg", "[" + bagName + "]有送QC记录，不能重复录入！");
			return data;
		}
		if (binUnitList == null) {
			data.put("code", 1);
			data.put("msg", "未找到[" + bagName + "]静电袋信息！");
			return data;
		}
		return binUnitList;
	}

	@RequestMapping("saveBagNameToQc")
	@ResponseBody
	public Map<String, Object> saveBagNameToQc(BagNameToQc bagNameToQc) {

		Map<String, Object> binUnitList = bagNameToQcService.saveBagName(bagNameToQc);

		return binUnitList;
	}

}
