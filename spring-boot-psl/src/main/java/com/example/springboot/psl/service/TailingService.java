package com.example.springboot.psl.service;

import java.util.List;

import com.example.springboot.psl.entity.BinUnit;

/**
 * @ClassNmame TailingService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午2:39:05
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface TailingService {
	List<BinUnit> tailingPutIn(String binUnitList);

	boolean saveBinUnitId(BinUnit binUnit);

	Integer updateShelfFlag(String pno,Integer flag);

	 BinUnit  selectUnitIdPno(String unitId);

	Integer updateUnitFlag(String unitId,String workId);

	String tailing(String unitId,String workId);

	String saveBinUnitService(BinUnit binUnit);
}
