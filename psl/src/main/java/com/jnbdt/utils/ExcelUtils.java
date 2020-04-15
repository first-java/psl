package com.jnbdt.utils;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassNmame ExcelImportUtils.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月17日 上午8:26:53
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public class ExcelUtils {
	private static final Logger LOGGER = LoggerFactory.getLogger(ExcelUtils.class);

	public static List<Object> excelToShopIdList(InputStream inputStream) {
		List<Object> list = new ArrayList<>();
		Workbook workbook = null;
		try {
			workbook = WorkbookFactory.create(inputStream);
			inputStream.close();
			// 工作表对象
			Sheet sheet = workbook.getSheetAt(0);
			// 总行数
			int rowLength = sheet.getLastRowNum() - 1;
			System.out.println("总行数有多少行" + rowLength);
			// 工作表的列

			Row row = sheet.getRow(0);
			// 总列数
			int colLength = row.getLastCellNum();
			System.out.println("总列数有多少列" + colLength);
			// 得到指定的单元格
			// Cell cell = row.getCell(0);
			for (int i = 0; i < sheet.getLastRowNum(); i++) {
				row = sheet.getRow(i);

				/*
				 * if (row.getCell(i) != null) {
				 * 
				 * String data = row.getCell(0).getStringCellValue(); data = data.trim();
				 * 
				 * // 判断data是否是数字 if (isNumeric(data)) list.add(Integer.parseInt(data)); }
				 */
				row.getCell(0).setCellType(CellType.STRING);
				System.out.println(row.getCell(0).getStringCellValue());
				row.getCell(1).setCellType(CellType.STRING);
				System.out.println(row.getCell(1).getStringCellValue());
				row.getCell(2).setCellType(CellType.STRING);
				System.out.println(row.getCell(2).getStringCellValue());
				row.getCell(3).setCellType(CellType.STRING);

				System.out.println(row.getCell(3).getStringCellValue());
				list.add(row.getCell(i).getStringCellValue());
			}
		} catch (Exception e) {
			LOGGER.error("parse excel file error :", e);
		}
		return list;
	}

	public final static boolean isNumeric(String s) {
		if (s != null && !"".equals(s.trim()))
			return s.matches("^[0-9]*$");
		else
			return false;
	}
}
