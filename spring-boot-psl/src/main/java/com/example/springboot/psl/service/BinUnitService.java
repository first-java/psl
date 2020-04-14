package com.example.springboot.psl.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.example.springboot.psl.entity.BinUnit;

/**
 * @ClassNmame BinUnitService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月25日 下午2:17:49
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface BinUnitService {
	boolean saveBunitShelf(List<BinUnit> binUnitList);

	String saveBunitShelfService(List<BinUnit> binUnitList);

	List<BinUnit> selectBacthByLotId(String lotId);

	boolean updateShelfStatus(List<BinUnit> binUnitList);

	List<BinUnit> selectUnitByUnitAll();

	boolean updateEqpt(BinUnit eqpt);

	Integer updateUnitStatus(@Param("binUnitList") List<BinUnit> binUnitList,@Param("workId") String workId);


	boolean saveUnitIdToEqpt(List<BinUnit> binUnitList);

	Map<String, Object> selectShelfByLotId(@Param("lotId") String lotId, @Param("odd") String odd);

	String selectMaxBdLotId(@Param("lotId") String lotId);

	String unitIdToEqpt(BinUnit binUnitList);

	Map<String, Object> selectCountByLotId(String lotId);

	List<BinUnit> selectUnitByUnit(String unitId);

	Integer updateShelfFlag(List<BinUnit> binUnitList);

	boolean saveBinUnitId(BinUnit binUnit);

	boolean saveBinUnit(List<BinUnit> binUnitList);

	List<BinUnit> selectBinUnitEqpt(@Param("eqpt") String eqpt);

	List<BinUnit> selectShelf();

	String saveUnit(BinUnit binUnit);

	Integer queryUnitDateilCount();

	Integer queryUnitDateilCountByLBI(@Param("lotType") String lotType,@Param("binId") String binId,@Param("specId") String specId);

	List<BinUnit> selectUnitDateil(@Param("page") int page, @Param("limit") int limit, BinUnit binUnit);// 带贴带明细

	List<BinUnit> selectUnitDateilByLBI(@Param("page") int page, @Param("limit") int limit,
			@Param("lotType") String lotType, @Param("binId") String binId, @Param("specId") String specId);// 带贴带明细

	List<BinUnit> selectUnitIdByLotId(@Param("batchLot") String batchLot, @Param("unitId") String unitId);
}
