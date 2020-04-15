package action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.FileUtils;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.struts2.ServletActionContext;

import entity.Psp;
import service.FileUpService;
import service.PspService;

public class PspAction {
	private String methodstr;
	private String query;
	private String workId;
	private int id;
	private String getOne;
	private String getTwo;

	public String getGetTwo() {
		return getTwo;
	}

	public void setGetTwo(String getTwo) {
		this.getTwo = getTwo;
	}

	@Resource
	PspService pspService;

	public String getGetOne() {
		return getOne;
	}

	public void setGetOne(String getOne) {
		this.getOne = getOne;
	}

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getQuery() {
		return query;
	}

	public void setQuery(String query) {
		this.query = query;
	}

	private File[] excel;
	// 提交过来的file的名字
	private String[] excelFileName;
	@Resource
	private FileUpService fileUpService;
	private String batch;

	public String getBatch() {
		return batch;
	}

	public void setBatch(String batch) {
		this.batch = batch;
	}

	public String getMethodstr() {
		return methodstr;
	}

	public void setMethodstr(String methodstr) {
		this.methodstr = methodstr;
	}

	public File[] getExcel() {
		return excel;
	}

	public void setExcel(File[] excel) {
		this.excel = excel;
	}

	public String[] getExcelFileName() {
		return excelFileName;
	}

	public void setExcelFileName(String[] excelFileName) {
		this.excelFileName = excelFileName;
	}

	/*
	 * 通过贴带级别查询机种号
	 */
	public String getOne() {

		HttpServletRequest request = ServletActionContext.getRequest();
		Psp report = new Psp();
		report.setLuminance(getOne);

		List<Psp> plan = pspService.getOne(report);
		request.setAttribute("queryAll", plan);
		return "selectType";

	}

	/*
	 * 通过机种号查询贴带级别
	 */
	/*
	 * public String getTwo() {
	 * 
	 * HttpServletRequest request = ServletActionContext.getRequest(); Psp
	 * report = new Psp(); report.setModelNo(getTwo);
	 * 
	 * List<Psp> plan = pspService.getTwo(report);
	 * request.setAttribute("queryAll", plan); return "select";
	 * 
	 * }
	 */

	private List<Psp> excelBatchPrefix(HSSFSheet sheet) {
		List<Psp> list = new ArrayList<>();
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {

			HSSFRow row = sheet.getRow(i);
			for (int j = 0; j < row.getCell(3).getStringCellValue().split(",").length; j++) {
				for (int k = 0; k < row.getCell(4).getStringCellValue().split(",").length; k++) {
					for (int o = 0; o < row.getCell(5).getStringCellValue().split(",").length; o++) {
						Psp batchPrefixEntity = new Psp();
						row.getCell(0).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setModelNo(row.getCell(0).getStringCellValue());

						row.getCell(1).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setProduct(row.getCell(1).getStringCellValue());

						row.getCell(2).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setsRa(row.getCell(2).getStringCellValue());

						String a[] = row.getCell(3).getStringCellValue().split(",");
						row.getCell(3).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setCz(a[j]);

						String b[] = row.getCell(4).getStringCellValue().split(",");
						row.getCell(4).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setLuminance(b[k]);

						String c[] = row.getCell(5).getStringCellValue().split(",");
						row.getCell(5).setCellType(Cell.CELL_TYPE_STRING);
						batchPrefixEntity.setTension(c[o]);

						list.add(batchPrefixEntity);
					}
				}
			}
		}
		return list;
	}

	public String execute2() throws IOException {

		Map<String, Object> mapList = new HashMap<>();
		for (int i = 0; i < excel.length; i++) {
			try {
				String desPath = ServletActionContext.getServletContext().getRealPath("/excel");
				File csv = new File(desPath, excelFileName[i]);
				FileUtils.copyFile(excel[i], csv);

				HSSFWorkbook book = new HSSFWorkbook(new FileInputStream(excel[i]));
				//
				HSSFSheet sheet = book.getSheetAt(0);

				mapList.put("binData", excelBatchPrefix(sheet));

			} catch (IOException e) {
				e.printStackTrace();
			}

		}
		try {

			fileUpService.exportData(mapList);

		} catch (Exception e) {

			if (mapList.get("errorCode") != null && (int) mapList.get("errorCode") == 2) {

				return "error";

			}
			e.printStackTrace();
		}

		return "success";
	}

	public String execute() throws IOException {

		if ("execute2".equals(methodstr)) {

			return execute2();

		} else if ("getOne".equals(methodstr)) {

			return getOne();
		}
		return methodstr;
	}

}
