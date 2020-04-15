package com.jnbdt.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jnbdt.entity.Development;

/**
 * @ClassNmame DevelopmentService.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月13日 下午2:41:05
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public interface DevelopmentService {
	boolean saveTbarcode(List<Development> development); // t_material.T_BARCODE保存入库数据

	boolean saveStockOut(List<Development> development);

	boolean saveJnbdtKu(List<Development> development);

	Map<String, Object> selectUnitId(@Param("unitId") String unitId);// 验证是否打过标签

	Map<String, Object> selectBarcodeString(@Param("unitId") String unitId);// 验证是否入过库

	Map<String, Object> selectWorkId(@Param("workId") String workId);// 查询工号RRN

	Development selectStockTransSeq();// 查询stock_trans_rrn序列号

	Map<String, Object> selectBarcodeSeq();// 查询barcodeRrn 序列号

	Map<String, Object> selectStockSeq();// 查询stockRrn 序列号

	Integer saveTrans(List<Development> development);// 保存数据到t_material.t_stock

	Integer saveStockTrans(List<Development> development);// 保存数据到t_material.t_stock_trans

	Integer saveStockTransD(List<Development> development);// 保存数据到t_material.t_stock_trans_detail

	Integer saveStockIn(List<Development> development);// 保存数据到t_material.t_stock_in_history

	Map<String, Object> selectOutCache();// 查询out_cache_rrn 序列号

	Development selectInCacheSeq();// 查询inCacheRrn 序列号

	Map<String, Object> saveUnit(String unitId, String yfQty, String workId);// controller

	Map<String, Object> selectTransRrn(@Param("barcodeString") String barcodeString);

	boolean updateStock(@Param("stockTransRrn") String lastTrans, @Param("barcodeString") String barcodeString);

	Map<String, Object> selectBarcodeId(@Param("barcodeString") String barcodeString);//

	Map<String, Object> outUnit(String unitId, String yfQty, String workId);// controller
}
