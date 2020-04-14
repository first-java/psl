package com.example.springboot.psl.controller;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.psl.entity.BinUnit;
import com.example.springboot.psl.service.BinUnitService;

@Controller
@RequestMapping("psl")
public class PutUnitOnShelfController {
	@Autowired
	BinUnitService binUnitService;
	Map<String, Object> data = new HashMap<String, Object>();
	Logger logger = LoggerFactory.getLogger(this.getClass());

	@RequestMapping("query")
	public String t() {
		logger.info("ee");
		return "binUnit";// 返回创建蓝膜位置号的页面
	}

	/**
	 * 创建蓝膜位置号
	 * 
	 * @time 2020年4月9日 上午9:10:36
	 */
	@RequestMapping("binUnit")
	@ResponseBody
	public Map<String, Object> binUnit(Integer maxId, String lotId, String workId, HttpServletRequest request,
			HttpSession session) {

		List<BinUnit> binUnitList = new ArrayList<BinUnit>();
		DecimalFormat mFormat = new DecimalFormat("000");
		for (int i = 0; i < maxId; i++) {
			BinUnit binUnit = new BinUnit();

			String pNo = lotId.toUpperCase() + mFormat.format(i + 1);
			binUnit.setPno(pNo);
			binUnit.setLotId(lotId.toUpperCase());
			binUnit.setWorkId(workId);
			binUnitList.add(binUnit);
		}
		String flag = binUnitService.saveBunitShelfService(binUnitList);
		if ("success".equals(flag)) {
			data.put("code", 1);
		} else {
			data.put("code", 2);
			data.put("msg", "创建位置号失败！" + flag);
		}
		return data;
	}

	/**
	 * 蓝膜入库
	 * 
	 * @time 2020年4月9日 上午9:13:18
	 */
	@RequestMapping("bePutInHtml")
	public String bePutInHtml(String batchLot) {

		return "bePutIn";// 返回蓝膜入库页面
	}

	@RequestMapping("selectBacthByLotId")
	@ResponseBody
	public Map<String, Object> selectBacthByLotId(String batchLot) {

		List<BinUnit> binUnitList = binUnitService.selectUnitIdByLotId(batchLot, "");
		data.put("counter", binUnitList);
		return data;
	}

	@RequestMapping("selectShelfByLotId")
	@ResponseBody
	public Map<String, Object> selectShelfByLotId(BinUnit binUnit) {
		/**
		 * 页面提交的参数
		 */
		String batchLot = binUnit.getBatchLot();
		Integer maxId = binUnit.getMaxId();
		String odd = binUnit.getOdd();
		String unitId = binUnit.getUnitId();
		List<BinUnit> binUnit1 = binUnitService.selectUnitByUnit(unitId);
		if (binUnit1.size() > 0) {
			data.put("counter", "ERROR:未找到此片信息,此片已在库房！");
			return data;
		}
		String lotId = batchLot.substring(3, 5).toUpperCase();// 截取产品前两位匹配位置号
		Map<String, Object> binUnitCount = binUnitService.selectCountByLotId(lotId);// 位置号剩余
		if (binUnitCount.size() < 1) {
			data.put("counter", "ERROR:位置号不够，请先创建位置号!");
			return data;
		}
		String binUnitMaxId = binUnitCount.get("MAXID").toString();
		List<BinUnit> binUnitId = binUnitService.selectUnitIdByLotId(batchLot, unitId);// 批号查蓝膜的信息
		Map<String, Object> binUnitList = binUnitService.selectShelfByLotId(lotId, odd);// 获取位置号
		String pno = binUnitList.get("P_NO").toString();
		if (Integer.parseInt(binUnitMaxId) < maxId) {
			data.put("counter", "ERROR:位置号不够，请先创建位置号!");
			return data;
		}
		data.put("coun", pno);
		data.put("counter", binUnitId);
		return data;
	}

	/**
	 * 蓝膜上货架
	 * 
	 * @return
	 * @throws IOException
	 */
	@RequestMapping("saveUnit")
	@ResponseBody
	public Map<String, Object> saveUnit(BinUnit binUnit) {

		String binUnitList = binUnitService.saveUnit(binUnit);
		if ("success".equals(binUnitList)) {
			data.put("code", "上架成功！");
			return data;
		} else {
			data.put("code", "上架失败！");
			return data;
		}

	}
}
