package com.jnbdt.controller;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jnbdt.service.DevelopmentService;

/**
 * @ClassNmame DevelopmentContriller.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月13日 下午1:56:39
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class DevelopmentController {

	@Autowired
	DevelopmentService developmentService;

	@RequestMapping("development")
	public String name() {
		return "development";
	}

	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("selectUntiId")
	@ResponseBody
	public Map<String, Object> selectUntiId(String unitId) {
		Map<String, Object> developtment = developmentService.selectUnitId(unitId);
		if (developtment == null) {
			data.put("code", 2);
			data.put("msg", "该流水号未打过标签，请确认！！");
		}
		Map<String, Object> barcodeString = developmentService.selectBarcodeString(unitId);
		if (barcodeString != null) {
			data.put("code", 2);
			data.put("msg", "该流水号已经入过库！！");
		}

		data.put("code", 1);
		data.put("msg", "");
		return data;
	}

	@RequestMapping("saveUnit")
	@ResponseBody
	public Map<String, Object> saveUnit(String unitId, String workId, String yfQty) {
		Map<String, Object> developtment = developmentService.saveUnit(unitId, workId, yfQty);

		return developtment;
	}
}
