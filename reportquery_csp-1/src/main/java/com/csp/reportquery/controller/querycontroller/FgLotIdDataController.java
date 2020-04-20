package com.csp.reportquery.controller.querycontroller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.FgLotIdDataService;

/**
 * @ClassNmame FgLotIdDataController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 下午4:43:09
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class FgLotIdDataController {
	Map<String, Object> data = new HashMap<String, Object>();
	@Autowired
	FgLotIdDataService fgLotIdDataService;

	@GetMapping("fgLotIdData")
	private String returnHTML() {
		return "fgLotIdData";

	}

	@GetMapping("queryFgLotIdData")
	@ResponseBody
	public Map<String, Object> unitIdToBeamSplitData(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<ReportBagHe> binUnitList = fgLotIdDataService.queryFgLotIdData(page, limit, keyWord);
		int count = fgLotIdDataService.queryAllCount(keyWord);
		data.put("code", 0);
		data.put("msg", "");
		data.put("count", count);
		data.put("data", binUnitList);
		return data;
	}

	/**
	 * 下载
	 */
	@GetMapping("downloadFgLotIdData")
	public void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception {
		fgLotIdDataService.salaryTemplate(response, startTime, endTime);
	}

}
