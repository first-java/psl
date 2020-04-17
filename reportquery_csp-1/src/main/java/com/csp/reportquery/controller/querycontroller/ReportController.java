package com.csp.reportquery.controller.querycontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.ReportBagHeService;

/**
 * @ClassNmame BagHeController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 上午10:16:42
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class ReportController {
	@Autowired
	ReportBagHeService reportBagHeService;
	Map<String, Object> data = new HashMap<String, Object>();

	public ReportController() {
	}

	@GetMapping({ "query" })
	public String query() {
		return "queryBagHe";
	}

	@GetMapping({ "queryBagHeData" })
	@ResponseBody
	public Map<String, Object> queryBagHeData(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<ReportBagHe> binUnitList = reportBagHeService.queryBagHe(page, limit, keyWord);
		int count = reportBagHeService.queryAllCount(keyWord);
		this.data.put("code", 0);
		this.data.put("msg", "");
		this.data.put("count", count);
		this.data.put("data", binUnitList);
		return this.data;
	}
}
