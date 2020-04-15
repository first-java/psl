package com.jnbdt.service;

import java.util.List;
import java.util.Map;

/**
 * @ClassNmame TestService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月15日 下午8:27:12
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface IConllectService {
//数据服务层接口层
	int query();

	@SuppressWarnings("rawtypes")
	List<Map> listUser();
}
