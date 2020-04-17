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
import com.csp.reportquery.service.AllDetailService;

/**
 * @ClassNmame AllDetailController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 下午3:53:27
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class AllDetailController {

	@Autowired
	AllDetailService allDetailService;

	Map<String, Object> data = new HashMap<String, Object>();

	@GetMapping("queryAllDetail" )
	public String query() {
		return "queryAllDetail";
	}

	@GetMapping("queryAllDetailData")
	@ResponseBody
	public Map<String, Object> queryAllDetailData(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<ReportBagHe> binUnitList = allDetailService.queryAllDetail(page, limit, keyWord);
		int count = allDetailService.queryAllCount(keyWord);
		this.data.put("code", 0);
		this.data.put("msg", "");
		this.data.put("count", count);
		this.data.put("data", binUnitList);
		return this.data;
	}
	/**
	 * 下载
	 */
	@GetMapping("downloadAllDetail")
	public void salaryTemplate(HttpServletResponse response,String startTime,String endTime) throws Exception {
		allDetailService.salaryTemplate(response,startTime,endTime);
	}
	
	@GetMapping("queryDetailDataByKeyWord")
	@ResponseBody
	public Map<String, Object> queryDetailDataByKeyWord(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<ReportBagHe> binUnitList = allDetailService.queryAllDetail(page, limit, keyWord);
		int count = allDetailService.queryAllCount(keyWord);
		this.data.put("code", 0);
		this.data.put("msg", "");
		this.data.put("count", count);
		this.data.put("data", binUnitList);
		return this.data;
	}
}
