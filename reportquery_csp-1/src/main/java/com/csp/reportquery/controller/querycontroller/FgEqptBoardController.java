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
import com.csp.reportquery.service.FgEqptBoardService;

/**
 * @ClassNmame FgEqptBoard.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午3:42:49
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class FgEqptBoardController {
	Map<String, Object> data = new HashMap<String, Object>();
	@Autowired
	FgEqptBoardService fgEqptBoardService;

	@GetMapping("queryAllFgEqptBoard")
	public String query() {
		return "queryAllFgEqptBoard";
	}

	@GetMapping("fgEqptBoard")
	@ResponseBody
	public Map<String, Object> queryAllDetailData(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<ReportBagHe> binUnitList = fgEqptBoardService.queryAllFgEqptBoard(page, limit);
		int count = fgEqptBoardService.queryAllCount(keyWord);
		this.data.put("code", 0);
		this.data.put("msg", "");
		this.data.put("count", count);
		this.data.put("data", binUnitList);
		return this.data;
	}
}
