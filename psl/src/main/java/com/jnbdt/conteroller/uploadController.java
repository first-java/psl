package com.jnbdt.conteroller;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.jnbdt.utils.ExcelUtils;

/**
 * @ClassNmame ShippingInformationController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月16日 上午11:13:26
 * @Copyright © 2020 by 奥特虾不会写代码 文件上传
 */
@Controller
public class uploadController {
	Logger logger = LoggerFactory.getLogger(getClass());

	@PostMapping("file/upload")
	@ResponseBody
	public List<Object> pubggupload(@RequestParam("file") MultipartFile file) throws Exception {
		logger.info("jinru");
		String name = file.getOriginalFilename();
		if (name.length() < 6 || !name.substring(name.length() - 5).equals(".xlsx")) {
			List<Object> li = new ArrayList<>();
			li.add("文件格式错误");
			return li;
		}
		List<Object> list = ExcelUtils.excelToShopIdList(file.getInputStream());

		return list;

	}

}
