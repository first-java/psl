/*package action;

import java.io.File;
import java.io.FileInputStream;
import java.util.List;

import org.apache.http.entity.ContentType;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;
import org.testng.annotations.Test;

*//**
 * @author Shuoshi.Yan
 * @package:com.yss.poi
 * @className:
 * @description:
 * @date 2019-09-23 10:32
 * @version:V1.0 @NOTICE： @ Copyright xxx. All rights reserved.
 **//*

public class A {
	
	public enum ColorEnum
	{
		saveShelf1,
		BLUE,
		GREEN,RED
	}

public static void doit(ColorEnum c){
	
	
}
	public static String ttt() {
		System.out.println("1234");
		return null;

	}

	public static String o() {
		String u1 = "ttt()";
		String u = "ttt";

		if ("ttt".equals(u)) {
			System.out.println("123");
			return ttt();
		}
		return u1;

	}

	@Test
	public static void main(String[] args) throws Exception {

		doit(ColorEnum.RED);


		File pdfFile = new File("C:\\Users\\pengs\\Desktop\\2.xlsx");

		try {
			FileInputStream fileInputStream = new FileInputStream(pdfFile);
			MultipartFile multipartFile = new MockMultipartFile(pdfFile.getName(), pdfFile.getName(),
					ContentType.APPLICATION_OCTET_STREAM.toString(), fileInputStream);
			List<List<String>> list = POIUtil2.readExcel(multipartFile);
			list.forEach(list1 -> {
				// log.info("list1:" + list1);
				// 在这里进行导入的数据入库处理等
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}*/