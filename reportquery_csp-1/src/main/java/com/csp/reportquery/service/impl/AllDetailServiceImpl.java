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

import com.csp.reportquery.dao.AllDetailDao;
import com.csp.reportquery.entity.ReportBagHe;
import com.csp.reportquery.service.AllDetailService;

/**
 * @ClassNmame AllDetailServiceImpl.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月17日 下午3:54:12
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Service
public class AllDetailServiceImpl implements AllDetailService {
	@Autowired
	AllDetailDao allDetailDao;

	@Override
	public List<ReportBagHe> queryAllDetail(int page, int limit, String keyWord) {
		int page1 = (page - 1) * limit + 1;
		int limit1 = page * limit;
		return allDetailDao.queryAllDetail(page1, limit1, keyWord);
	}

	@Override
	public Integer queryAllCount(String keyWord) {

		return allDetailDao.queryAllCount(keyWord);
	}

	public void salaryTemplate(HttpServletResponse response, String startTime, String endTime) throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();
		exportExcel(workbook, startTime, endTime);
		response.setHeader("Content-type", "application/vnd.ms-excel");

		response.setCharacterEncoding("UTF-8");// 解决导出文件名中文乱码
		response.setHeader("Content-Disposition",
				"attachment;filename=" + new String("各类在制明细".getBytes("UTF-8"), "ISO-8859-1") + ".xls");
		workbook.write(response.getOutputStream());
	}

	// 导入为模版
	private void exportExcel(HSSFWorkbook workbook, String startTime, String endTime) throws Exception {
		// 创建创建sheet
		HSSFSheet sheet = workbook.createSheet("各类在制明细");

		// 创建单元格样式
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setFillForegroundColor(HSSFColor.SKY_BLUE.index);

		// 设置首行标题标题
		HSSFRow headerRow = sheet.createRow(0);

		headerRow.createCell(0).setCellStyle(cellStyle);
		headerRow.createCell(0).setCellValue("类型");

		headerRow.createCell(1).setCellStyle(cellStyle);
		headerRow.createCell(1).setCellValue("袋号");

		headerRow.createCell(2).setCellStyle(cellStyle);
		headerRow.createCell(2).setCellValue("种类");

		headerRow.createCell(3).setCellStyle(cellStyle);
		headerRow.createCell(3).setCellValue("BIN");

		headerRow.createCell(4).setCellStyle(cellStyle);
		headerRow.createCell(4).setCellValue("数量");

		headerRow.createCell(5).setCellStyle(cellStyle);
		headerRow.createCell(5).setCellValue("创建时间");
		
		headerRow.createCell(6).setCellStyle(cellStyle);
		headerRow.createCell(6).setCellValue("备注");


		List<Map<String, Object>> listMap = queryAllDetailByTime(startTime, endTime);

		// 创建三行数据
		HSSFRow row;
		for (int i = 0; i < listMap.size(); i++) {

			row = sheet.createRow(i + 1);
			row.createCell(0).setCellStyle(cellStyle);
			row.createCell(0).setCellValue(
					listMap.get(i).get("LEIXING") == null ? "" : listMap.get(i).get("LEIXING").toString());

			row.createCell(1).setCellStyle(cellStyle);
			row.createCell(1)
					.setCellValue(listMap.get(i).get("BAGNAME") == null ? "" : listMap.get(i).get("BAGNAME").toString());

			row.createCell(2).setCellStyle(cellStyle);
			row.createCell(2).setCellValue(
					listMap.get(i).get("LOTTYPE") == null ? "" : listMap.get(i).get("LOTTYPE").toString());

			row.createCell(3).setCellStyle(cellStyle);
			row.createCell(3)
					.setCellValue(listMap.get(i).get("BIN") == null ? "" : listMap.get(i).get("BIN").toString());

			row.createCell(4).setCellStyle(cellStyle);
			row.createCell(4)
					.setCellValue(listMap.get(i).get("QTY") == null ? "" : listMap.get(i).get("QTY").toString());

			row.createCell(5).setCellStyle(cellStyle);
			row.createCell(5).setCellValue(
					listMap.get(i).get("CREATETIME") == null ? "" : listMap.get(i).get("CREATETIME").toString());
			

			row.createCell(6).setCellStyle(cellStyle);
			row.createCell(6).setCellValue(
					listMap.get(i).get("REMARK") == null ? "" : listMap.get(i).get("REMARK").toString());

		}
	}

	@Override
	public List<Map<String, Object>> queryAllDetailByTime(String startTime, String endTime) {
	 
		return allDetailDao.queryAllDetailByTime(startTime, endTime);
	}


}
