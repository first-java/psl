/*
 * package action;
 * 
 * 
 * import java.io.FileNotFoundException; import java.io.IOException; import
 * java.io.InputStream; import java.util.ArrayList; import java.util.List;
 * 
 * import org.apache.poi.hssf.usermodel.HSSFWorkbook; import
 * org.apache.poi.ss.usermodel.Cell; import org.apache.poi.ss.usermodel.Row;
 * import org.apache.poi.ss.usermodel.Sheet; import
 * org.apache.poi.ss.usermodel.Workbook; import
 * org.apache.poi.xssf.usermodel.XSSFWorkbook; import
 * org.springframework.stereotype.Component; import
 * org.springframework.web.multipart.MultipartFile;
 * 
 *//**
	 * @author Shuoshi.Yan
	 * @package:com.yss.poi
	 * @className:
	 * @description:
	 * @date 2019-09-23 10:16
	 * @version:V1.0 @NOTICE： @ Copyright xxx. All rights reserved.
	 **/
/*
 * @Component
 * 
 * public class POIUtil2 {
 * 
 * private final static String xls = "xls"; private final static String xlsx =
 * "xlsx";
 * 
 *//**
	 * 读入excel文件，解析后返回
	 * 
	 * @param file
	 * @throws IOException
	 *//*
		 * public static List<List<String>> readExcel(MultipartFile file) throws
		 * IOException { // 检查文件 checkFile(file); // 获得Workbook工作薄对象 Workbook workbook =
		 * getWorkBook(file); // 创建返回对象，把每行中的值作为一个集合，所有行作为一个集合返回 // 这里也可以作为一个数组
		 * List<List<String>> list = new ArrayList<>(); if (workbook != null) { for (int
		 * sheetNum = 0; sheetNum < workbook.getNumberOfSheets(); sheetNum++) { //
		 * 获得当前sheet工作表 Sheet sheet = workbook.getSheetAt(sheetNum); if (sheet == null)
		 * { continue; } // 获得当前sheet的开始行 int firstRowNum = sheet.getFirstRowNum(); //
		 * 获得当前sheet的结束行 int lastRowNum = sheet.getLastRowNum(); // 循环除了第一行的所有行 for (int
		 * rowNum = firstRowNum + 1; rowNum <= lastRowNum; rowNum++) { // 获得当前行 Row row
		 * = sheet.getRow(rowNum); if (row == null) { continue; } // 获得当前行的开始列 int
		 * firstCellNum = row.getFirstCellNum(); // 获得当前行的列数 int lastCellNum =
		 * row.getPhysicalNumberOfCells(); List<String> cells = new ArrayList<>(); //
		 * 循环当前行 for (int cellNum = firstCellNum; cellNum < lastCellNum; cellNum++) {
		 * Cell cell = row.getCell(cellNum); cells.add(getCellValue(cell)); }
		 * list.add(cells); } } ((InputStream) workbook).close(); } return list; }
		 * 
		 * public static void checkFile(MultipartFile file) throws IOException { //
		 * 判断文件是否存在 if (null == file) { throw new FileNotFoundException("文件不存在！"); } //
		 * 获得文件名 String fileName = file.getOriginalFilename(); // 判断文件是否是excel文件 if
		 * (!fileName.endsWith(xls) && !fileName.endsWith(xlsx)) { throw new
		 * IOException(fileName + "不是excel文件"); } }
		 * 
		 * public static Workbook getWorkBook(MultipartFile file) { // 获得文件名 String
		 * fileName = file.getOriginalFilename(); // 创建Workbook工作薄对象，表示整个excel Workbook
		 * workbook = null; try { // 获取excel文件的io流 InputStream is =
		 * file.getInputStream(); // 根据文件后缀名不同(xls和xlsx)获得不同的Workbook实现类对象 if
		 * (fileName.endsWith(xls)) { // xls workbook = new HSSFWorkbook(is); } else if
		 * (fileName.endsWith(xlsx)) { // xlsx workbook = new XSSFWorkbook(is); } }
		 * catch (IOException e) { e.printStackTrace(); } return workbook; }
		 * 
		 * public static String getCellValue(Cell cell) { String cellValue = ""; if
		 * (cell == null) { return cellValue; } else { // 判断数据类型，这里使用的是字符串 //
		 * 字符串：String.valueOf(cell.getStringCellValue()) //
		 * 数字：String.valueOf(cell.getNumericCellValue()) //
		 * 公式：String.valueOf(cell.getCellFormula()) //
		 * Boolean：String.valueOf(cell.getBooleanCellValue()) cellValue =
		 * String.valueOf(cell.getStringCellValue()); } return cellValue; } }
		 */