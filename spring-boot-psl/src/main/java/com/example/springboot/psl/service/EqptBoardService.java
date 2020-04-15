package com.example.springboot.psl.service;

import java.util.List;

import com.example.springboot.psl.entity.BinUnit;

/**
 * @ClassNmame EqptBoardService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月8日 下午3:34:24
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface EqptBoardService {
	List<BinUnit> selectEqptAll();
}
