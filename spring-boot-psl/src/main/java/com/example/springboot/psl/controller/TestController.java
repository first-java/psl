package com.example.springboot.psl.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.springboot.psl.entity.SysUser;
import com.example.springboot.psl.service.DataShowService;

/**
 * @ClassNmame TestController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午8:54:20
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class TestController {
	@Autowired(required = false)
	private DataShowService dataShowService;

	@ResponseBody
	@RequestMapping("/showData")
	public Map<String, Object> methodx(@RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "15") int limit, String keyWord) {
		List<SysUser> datas = dataShowService.queryAllDataFromTable(page, limit, keyWord);
		int countx = dataShowService.queryAllCount(keyWord);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", 0);
		map.put("msg", "");
		map.put("count", countx);
		map.put("data", datas);
		System.out.println(map.toString());
		return map;
	}

}
