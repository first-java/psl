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
import com.example.springboot.psl.service.TailingService;

@Controller
@RequestMapping("tailing")
public class TailingCollectConteoller {
	@Autowired(required = false)
	TailingService tailingService;
	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("tailing")
	public String t() {
		logger.info("ee");
		return "binunitweiliao";// 返回尾料收集
	}

	@RequestMapping("binfed")
	public String binfed() {
		logger.info("ee");
		return "binfed";//
	}

	@RequestMapping("tailingputin")
	@ResponseBody
	public Map<String, Object> selectBacthByLotId(String unitId) {

		List<BinUnit> binUnitList = tailingService.tailingPutIn(unitId);// 尾料入库用蓝膜号查找入库是对应的批次号，截取两位批次头查找新的位置号
		if (binUnitList.size() > 0) {
			data.put("code", binUnitList);
			return data;
		}

		data.put("code", 1);
		data.put("msg", "此片蓝膜不是出库状态，不能使用尾料入库功能！");
		return data;
	}

	@RequestMapping("binfedStock")
	@ResponseBody
	public Map<String, Object> binfedStock(String unitId,String workId) {

		String binUnitList = tailingService.tailing(unitId,workId);// 尾料入库用蓝膜号查找入库是对应的批次号，截取两位批次头查找新的位置号
		if ("SUCCESS".equals(binUnitList)) {
			data.put("msg", "出库成功！");
		} else {
			data.put("msg", "出库失败，请确认数据是否符合要求！");
		}
		return data;
	}

	@RequestMapping("wputIn")
	@ResponseBody
	public Map<String, Object> wputIn(BinUnit binUnit) {

		String string = tailingService.saveBinUnitService(binUnit);// 尾料入库用蓝膜号查找入库是对应的批次号，截取两位批次头查找新的位置号
		if ("SUCCESS".equals(string)) {
			data.put("msg", "入库成功");
		} else {
			data.put("msg", "入库失败");
		}
		return data;
	}
}
