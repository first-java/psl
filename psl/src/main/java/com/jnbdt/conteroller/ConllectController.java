package com.jnbdt.conteroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.jnbdt.service.IConllectService;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @ClassNmame ConllectController.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月20日 上午9:49:49
 * @Copyright © 2020 by 奥特虾不会写代码
 */
@Controller
public class ConllectController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Resource
	IConllectService conllectService;

	@GetMapping("/conllect")
	String conllect() {
		logger.info("conllect");
		logger.info(String.valueOf(conllectService.query()));
		return null;
	}

}
