package com.example.springboot.psl.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.example.springboot.psl.entity.BinUnit;

/**
 * @ClassNmame BinUnitDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月25日 下午2:15:47
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface BinUnitDao {
	boolean saveBunitShelf(List<BinUnit> binUnitList);

	List<BinUnit> selectShelf();

	Map<String, Object> selectShelfByLotId(@Param("lotId") String lotId, @Param("odd") String odd);

	Map<String, Object> selectCountByLotId(String lotId);

	boolean updateEqpt(BinUnit eqpt);

	Integer updateUnitStatus(@Param("binUnitList") List<BinUnit> binUnitList,@Param("workId") String workId);

	List<BinUnit> selectUnitByUnit(String unitId);

	List<BinUnit> selectUnitByUnitAll();

	String selectMaxBdLotId(@Param("lotId") String lotId);

	Integer updateShelfFlag(List<BinUnit> binUnitList);

	boolean saveUnitIdToEqpt(List<BinUnit> binUnitList);

	boolean updateShelfStatus(List<BinUnit> binUnitList);

	boolean saveBinUnitId(BinUnit binUnit);

	boolean saveBinUnit(List<BinUnit> binUnitList);

	Integer queryUnitDateilCount();

	Integer queryUnitDateilCountByLBI(@Param("lotType") String lotType,@Param("binId") String binId,@Param("specId") String specId);

	List<BinUnit> selectUnitDateil(@Param("page") int page, @Param("limit") int limit, BinUnit binUnit);// 带贴带明细

	List<BinUnit> selectUnitDateilByLBI(@Param("page") int page, @Param("limit") int limit,
			@Param("lotType") String lotType,@Param("binId") String binId,@Param("specId") String specId);// 带贴带明细

	List<BinUnit> selectBinUnitEqpt(@Param("eqpt") String eqpt);

	List<BinUnit> selectBacthByLotId(String lotId);

	List<BinUnit> selectUnitIdByLotId(@Param("batchLot") String batchLot, @Param("unitId") String unitId);
}
