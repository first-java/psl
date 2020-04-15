package com.jnbdt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jnbdt.entity.Development;

/**
 * @ClassNmame DevelopmentDao.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月13日 下午1:57:39
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface DevelopmentDao {
	boolean saveTbarcode(List<Development> development); // t_material.T_BARCODE保存入库数据

	boolean saveStockOut(List<Development> development);

	boolean saveJnbdtKu(List<Development> development);

	Map<String, Object> selectUnitId(@Param("unitId") String unitId);

	Map<String, Object> selectWorkId(@Param("workId") String workId);

	Map<String, Object> selectTransRrn(@Param("barcodeString") String barcodeString);

	Development selectInCacheSeq();// 查询inCacheRrn 序列号

	Map<String, Object> selectBarcodeSeq();// 查询barcodeRrn 序列号

	Map<String, Object> selectOutCache();// 查询out_cache_rrn 序列号

	Map<String, Object> selectBarcodeId(@Param("barcodeString") String barcodeString);//

	boolean updateStock(@Param("stockTransRrn") String lastTrans, @Param("barcodeString") String barcodeString);

	Map<String, Object> selectStockSeq();// 查询stockRrn 序列号

	Integer saveTrans(List<Development> development);// 保存数据到t_material.t_stock

	Integer saveStockTransD(List<Development> development);// 保存数据到t_material.t_stock_trans_detail

	Integer saveStockTrans(List<Development> development);// 保存数据到t_material.t_stock_trans

	Integer saveStockIn(List<Development> development);// 保存数据到t_material.t_stock_in_history

	Development selectStockTransSeq();// 查询stock_trans_rrn序列号

	Map<String, Object> selectBarcodeString(@Param("unitId") String unitId);
}
