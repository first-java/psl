package com.csp.reportquery.service.impl;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.csp.reportquery.dao.UnitIdToBeamSplitDao;
import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.UnitIdToBeamSplitService;

/**
 * @ClassNmame ScrollToBeamSplitServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 下午7:37:14
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class UnitIdToBeamSplitServiceImpl implements UnitIdToBeamSplitService {

	@Autowired
	UnitIdToBeamSplitDao unitIdToBeamSplitDao;

	@Override
	public List<ReportBagHe> queryUnitIdToBeamSplit(int page, int limit, String keyWord) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		return unitIdToBeamSplitDao.queryUnitIdToBeamSplit(page1, limit1, keyWord);
	}

	@Override
	public Integer queryAllCount(String keyWord) {

		return unitIdToBeamSplitDao.queryAllCount(keyWord);
	}

	@Override
	public List<Map<String, Object>> queryUnitIdToBeamSplitByTime(String startTime, String endTime) {

		return unitIdToBeamSplitDao.queryUnitIdToBeamSplitByTime(startTime, endTime);
	}

	@Override
	public void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception {

		HSSFWorkbook workbook = new HSSFWorkbook();
		exportExcel(workbook, startTime, endTime);
		response.setHeader("Content-type", "application/vnd.ms-excel");

		response.setCharacterEncoding("UTF-8");// 解决导出文件名中文乱码
		response.setHeader("Content-Disposition",
				"attachment;filename=" + new String("卷轴转分光明细".getBytes("UTF-8"), "ISO-8859-1") + ".xls");
		workbook.write(response.getOutputStream());
	}

	// 导入为模版
	private void exportExcel(HSSFWorkbook workbook, String startTime, String endTime) throws Exception {
		// 创建创建sheet
		HSSFSheet sheet = workbook.createSheet("卷轴转分光明细");

		// 创建单元格样式
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);

		// 设置首行标题标题
		HSSFRow headerRow = sheet.createRow(0);

		headerRow.createCell(0).setCellStyle(cellStyle);
		headerRow.createCell(0).setCellValue("创建时间");

		headerRow.createCell(1).setCellStyle(cellStyle);
		headerRow.createCell(1).setCellValue("操作人");

		headerRow.createCell(3).setCellStyle(cellStyle);
		headerRow.createCell(3).setCellValue("种类");

		headerRow.createCell(4).setCellStyle(cellStyle);
		headerRow.createCell(4).setCellValue("蓝膜号");

		headerRow.createCell(5).setCellStyle(cellStyle);
		headerRow.createCell(5).setCellValue("原始数量");

		headerRow.createCell(6).setCellStyle(cellStyle);
		headerRow.createCell(6).setCellValue("原始总数量");

		headerRow.createCell(7).setCellStyle(cellStyle);
		headerRow.createCell(7).setCellValue("袋号");

		headerRow.createCell(8).setCellStyle(cellStyle);
		headerRow.createCell(8).setCellValue("状态");

		headerRow.createCell(9).setCellStyle(cellStyle);
		headerRow.createCell(9).setCellValue("重量g(含袋子)");

		headerRow.createCell(10).setCellStyle(cellStyle);
		headerRow.createCell(10).setCellValue("袋子重量g");

		headerRow.createCell(11).setCellStyle(cellStyle);
		headerRow.createCell(11).setCellValue("标签重量g");

		headerRow.createCell(12).setCellStyle(cellStyle);
		headerRow.createCell(12).setCellValue("净重g");

		headerRow.createCell(13).setCellStyle(cellStyle);
		headerRow.createCell(13).setCellValue("单颗重量g");

		headerRow.createCell(14).setCellStyle(cellStyle);
		headerRow.createCell(14).setCellValue("计算数量");

		headerRow.createCell(15).setCellStyle(cellStyle);
		headerRow.createCell(15).setCellValue("损失数量");

		headerRow.createCell(16).setCellStyle(cellStyle);
		headerRow.createCell(16).setCellValue("出库日期");

		headerRow.createCell(17).setCellStyle(cellStyle);
		headerRow.createCell(17).setCellValue("出库操作人");

		headerRow.createCell(18).setCellStyle(cellStyle);
		headerRow.createCell(18).setCellValue("出库类型");
		List<Map<String, Object>> listMap = queryUnitIdToBeamSplitByTime(startTime, endTime);

		// 创建三行数据
		HSSFRow row;
		for (int i = 0; i < listMap.size(); i++) {

			row = sheet.createRow(i + 1);
			row.createCell(0).setCellStyle(cellStyle);
			row.createCell(0).setCellValue(
					listMap.get(i).get("CREATETIME") == null ? "" : listMap.get(i).get("CREATETIME").toString());

			row.createCell(1).setCellStyle(cellStyle);
			row.createCell(1).setCellValue(
					listMap.get(i).get("WORKID") == null ? "" : listMap.get(i).get("WORKID").toString());

			row.createCell(2).setCellStyle(cellStyle);
			row.createCell(2).setCellValue(
					listMap.get(i).get("LOTHEAD") == null ? "" : listMap.get(i).get("LOTHEAD").toString());

			row.createCell(3).setCellStyle(cellStyle);
			row.createCell(3)
					.setCellValue(listMap.get(i).get("BINUNITID") == null ? "" : listMap.get(i).get("BINUNITID").toString());

			row.createCell(4).setCellStyle(cellStyle);
			row.createCell(4)
					.setCellValue(listMap.get(i).get("QTY") == null ? "" : listMap.get(i).get("QTY").toString());

			row.createCell(5).setCellStyle(cellStyle);
			row.createCell(5).setCellValue(
					listMap.get(i).get("TOTAL_OUT_DIE_QTY") == null ? "" : listMap.get(i).get("TOTAL_OUT_DIE_QTY").toString());

			row.createCell(6).setCellStyle(cellStyle);
			row.createCell(6).setCellValue(
					listMap.get(i).get("BAGNAME") == null ? "" : listMap.get(i).get("BAGNAME").toString());

			
			row.createCell(7).setCellStyle(cellStyle);
			row.createCell(7).setCellValue(
					listMap.get(i).get("FLAG") == null ? "NORMAL" : "HOLD");

			row.createCell(8).setCellStyle(cellStyle);
			row.createCell(8).setCellValue(
					listMap.get(i).get("WEIGHT") == null ? "" : listMap.get(i).get("WEIGHT").toString());

			row.createCell(9).setCellStyle(cellStyle);
			row.createCell(9).setCellValue(
					listMap.get(i).get("BAGWEIGHT") == null ? "" : listMap.get(i).get("BAGWEIGHT").toString());

			row.createCell(10).setCellStyle(cellStyle);
			row.createCell(10).setCellValue(
					listMap.get(i).get("LABELWEIGHT") == null ? "" : listMap.get(i).get("LABELWEIGHT").toString());

			row.createCell(11).setCellStyle(cellStyle);
			row.createCell(11).setCellValue(
					listMap.get(i).get("JING_WEIGHT") == null ? "" : listMap.get(i).get("JING_WEIGHT").toString());

			row.createCell(12).setCellStyle(cellStyle);
			row.createCell(12).setCellValue(
					listMap.get(i).get("EACHWEIGHT") == null ? "" : listMap.get(i).get("EACHWEIGHT").toString());

			row.createCell(13).setCellStyle(cellStyle);
			row.createCell(13).setCellValue(
					listMap.get(i).get("ZH_QTY") == null ? "" : listMap.get(i).get("ZH_QTY").toString());

			row.createCell(14).setCellStyle(cellStyle);
			row.createCell(14).setCellValue(
					listMap.get(i).get("NOW_DIE_QTY") == null ? "" : listMap.get(i).get("NOW_DIE_QTY").toString());

			row.createCell(15).setCellStyle(cellStyle);
			row.createCell(15).setCellValue(
					listMap.get(i).get("NG_QTY") == null ? "" : listMap.get(i).get("NG_QTY").toString());

			row.createCell(16).setCellStyle(cellStyle);
			row.createCell(16).setCellValue(
					listMap.get(i).get("OUTTIME") == null ? "" : listMap.get(i).get("OUTTIME").toString());

			row.createCell(17).setCellStyle(cellStyle);
			row.createCell(17).setCellValue(
					listMap.get(i).get("OUTWORKID") == null ? "" : listMap.get(i).get("OUTWORKID").toString());

			row.createCell(18).setCellStyle(cellStyle);
			row.createCell(18).setCellValue(
					listMap.get(i).get("CHULEI") == null ? "" : listMap.get(i).get("CHULEI").toString());

		}
	}

}
