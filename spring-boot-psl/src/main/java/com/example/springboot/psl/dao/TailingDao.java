package com.example.springboot.psl.dao;

import java.util.List;

import com.example.springboot.psl.entity.BinUnit;

/**
 * @ClassNmame TailingDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月7日 下午2:38:33
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface TailingDao {
	List<BinUnit> tailingPutIn(String binUnitList);

	BinUnit selectUnitIdPno(String unitId);

	boolean saveBinUnitId(BinUnit binUnit);

	Integer updateShelfFlag(String pno,Integer flag);

	Integer updateUnitFlag(String unitId,String workId);
}
