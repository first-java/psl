package com.jnbdt.repository;

import java.util.List;
import java.util.Map;

/**
 * @ClassNmame TestDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月15日 下午8:25:49
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface CollectDao {
	int query();

	@SuppressWarnings("rawtypes")
	List<Map> listUser();
}
