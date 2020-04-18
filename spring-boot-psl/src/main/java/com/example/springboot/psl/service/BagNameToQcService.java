package com.example.springboot.psl.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.example.springboot.psl.entity.BagNameToQc;

/**
 * @ClassNmame BagNameToQcService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 上午9:38:05
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface BagNameToQcService {
	Map<String, Object> selectGoodBag(@Param("bagName") String bagName);

	boolean saveBagNameToQc(List<BagNameToQc> bagNameToQcList);

	Map<String, Object> selectBag(@Param("bagName") String bagName);

	Map<String, Object> saveBagName(BagNameToQc bagNameToQc);
}
