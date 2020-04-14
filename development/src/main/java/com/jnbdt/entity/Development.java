package com.jnbdt.entity;

/**
 * @ClassNmame Development.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月13日 下午1:58:00
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public class Development {
	private String inCacheRrn;
	private String barcodeString;
	private Integer yfQty;
	private Integer barcodeRrn;
	private String loginRrn;
	private String barcodeType;
	private String unitId;
	private String stockTransRrn;
	private String stockRrn;
	private String barcodeId;
	private String barcodeStatus;
	private String inTrans;
	private String rackingRrn;
	private String lastTrans;
	private String transRrn;
	private String transType;
	private String transTypeId;
	private String transQty;
	private String outCacheRrn;
	private String customerRrn;
	private String workId;

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getCustomerRrn() {
		return customerRrn;
	}

	public void setCustomerRrn(String customerRrn) {
		this.customerRrn = customerRrn;
	}

	public String getOutCacheRrn() {
		return outCacheRrn;
	}

	public void setOutCacheRrn(String outCacheRrn) {
		this.outCacheRrn = outCacheRrn;
	}

	public String getTransQty() {
		return transQty;
	}

	public void setTransQty(String transQty) {
		this.transQty = transQty;
	}

	public String getTransType() {
		return transType;
	}

	public void setTransType(String transType) {
		this.transType = transType;
	}

	public String getTransTypeId() {
		return transTypeId;
	}

	public void setTransTypeId(String transTypeId) {
		this.transTypeId = transTypeId;
	}

	public String getTransRrn() {
		return transRrn;
	}

	public void setTransRrn(String transRrn) {
		this.transRrn = transRrn;
	}

	public String getLastTrans() {
		return lastTrans;
	}

	public void setLastTrans(String lastTrans) {
		this.lastTrans = lastTrans;
	}

	public String getRackingRrn() {
		return rackingRrn;
	}

	public void setRackingRrn(String rackingRrn) {
		this.rackingRrn = rackingRrn;
	}

	public String getInTrans() {
		return inTrans;
	}

	public void setInTrans(String inTrans) {
		this.inTrans = inTrans;
	}

	public String getBarcodeStatus() {
		return barcodeStatus;
	}

	public void setBarcodeStatus(String barcodeStatus) {
		this.barcodeStatus = barcodeStatus;
	}

	public String getBarcodeId() {
		return barcodeId;
	}

	public void setBarcodeId(String barcodeId) {
		this.barcodeId = barcodeId;
	}

	public String getStockRrn() {
		return stockRrn;
	}

	public void setStockRrn(String stockRrn) {
		this.stockRrn = stockRrn;
	}

	public String getStockTransRrn() {
		return stockTransRrn;
	}

	public void setStockTransRrn(String stockTransRrn) {
		this.stockTransRrn = stockTransRrn;
	}

	public String getInCacheRrn() {
		return inCacheRrn;
	}

	public void setInCacheRrn(String inCacheRrn) {
		this.inCacheRrn = inCacheRrn;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public Integer getBarcodeRrn() {
		return barcodeRrn;
	}

	public void setBarcodeRrn(Integer barcodeRrn) {
		this.barcodeRrn = barcodeRrn;
	}

	public String getLoginRrn() {
		return loginRrn;
	}

	public void setLoginRrn(String loginRrn) {
		this.loginRrn = loginRrn;
	}

	public String getBarcodeType() {
		return barcodeType;
	}

	public void setBarcodeType(String barcodeType) {
		this.barcodeType = barcodeType;
	}

	public String getBarcodeString() {
		return barcodeString;
	}

	public void setBarcodeString(String barcodeString) {
		this.barcodeString = barcodeString;
	}

	public Integer getYfQty() {
		return yfQty;
	}

	public void setYfQty(Integer yfQty) {
		this.yfQty = yfQty;
	}

	public Development(String inCacheRrn, String barcodeString, Integer yfQty, Integer barcodeRrn, String loginRrn,
			String barcodeType, String unitId, String stockTransRrn) {
		super();
		this.inCacheRrn = inCacheRrn;
		this.barcodeString = barcodeString;
		this.yfQty = yfQty;
		this.barcodeRrn = barcodeRrn;
		this.loginRrn = loginRrn;
		this.barcodeType = barcodeType;
		this.unitId = unitId;
		this.stockTransRrn = stockTransRrn;
	}

	public Development() {

	}

}
