package com.example.springboot.psl.entity;

import java.io.Serializable;
import java.util.Date;

/**
 * @ClassNmame BinUnit.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月25日 上午9:00:50
 * @Copyright © 2020 by 奥特虾不会写代码
 */

public class BinUnit implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String lotId;

	private Integer flag;
	private Date createtime;
	private Integer maxId;
	private String workId;
	private String pno;
	private String batchLot;
	private String unitId;
	private String qty;
	private String BinId;
	private String specId;
	private String lotType;
	private String odd;
	private String eqpt;
	private String status;
	private String bdLotId;
	private String sexian;
	private String outWorkId;
	private String flagType;
	private String unitType;

	public BinUnit() {
	}

	public String getWorkId() {
		return workId;
	}

	public String getPno() {
		return pno;
	}

	public void setPno(String pno) {
		this.pno = pno;
	}

	public String getBatchLot() {
		return batchLot;
	}

	public void setBatchLot(String batchLot) {
		this.batchLot = batchLot;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public String getBinId() {
		return BinId;
	}

	public void setBinId(String binId) {
		BinId = binId;
	}

	public String getSpecId() {
		return specId;
	}

	public void setSpecId(String specId) {
		this.specId = specId;
	}

	public String getLotType() {
		return lotType;
	}

	public void setLotType(String lotType) {
		this.lotType = lotType;
	}

	public String getOdd() {
		return odd;
	}

	public void setOdd(String odd) {
		this.odd = odd;
	}

	public String getEqpt() {
		return eqpt;
	}

	public void setEqpt(String eqpt) {
		this.eqpt = eqpt;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getBdLotId() {
		return bdLotId;
	}

	public void setBdLotId(String bdLotId) {
		this.bdLotId = bdLotId;
	}

	public String getSexian() {
		return sexian;
	}

	public void setSexian(String sexian) {
		this.sexian = sexian;
	}

	public String getOutWorkId() {
		return outWorkId;
	}

	public void setOutWorkId(String outWorkId) {
		this.outWorkId = outWorkId;
	}

	public String getFlagType() {
		return flagType;
	}

	public void setFlagType(String flagType) {
		this.flagType = flagType;
	}

	public String getUnitType() {
		return unitType;
	}

	public void setUnitType(String unitType) {
		this.unitType = unitType;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public Integer getMaxId() {
		return maxId;
	}

	public void setMaxId(Integer maxId) {
		this.maxId = maxId;
	}

	public Integer getFlag() {
		return flag;
	}

	public void setFlag(Integer flag) {
		this.flag = flag;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public String getLotId() {
		return lotId;
	}

	public void setLotId(String lotId) {
		this.lotId = lotId;
	}

	public BinUnit(String lotId, Integer flag, Date createtime, Integer maxId, String workId, String pno,
			String batchLot, String unitId, String qty, String binId, String specId, String lotType, String odd,
			String eqpt, String status, String bdLotId, String sexian, String outWorkId, String flagType,
			String unitType) {
		super();
		this.lotId = lotId;
		this.flag = flag;
		this.createtime = createtime;
		this.maxId = maxId;
		this.workId = workId;
		this.pno = pno;
		this.batchLot = batchLot;
		this.unitId = unitId;
		this.qty = qty;
		BinId = binId;
		this.specId = specId;
		this.lotType = lotType;
		this.odd = odd;
		this.eqpt = eqpt;
		this.status = status;
		this.bdLotId = bdLotId;
		this.sexian = sexian;
		this.outWorkId = outWorkId;
		this.flagType = flagType;
		this.unitType = unitType;
	}

	@Override
	public String toString() {
		return "BinUnit [lotId=" + lotId + ", flag=" + flag + ", createtime=" + createtime + ", maxId=" + maxId
				+ ", workId=" + workId + ", pno=" + pno + ", batchLot=" + batchLot + ", unitId=" + unitId + ", qty="
				+ qty + ", BinId=" + BinId + ", specId=" + specId + ", lotType=" + lotType + ", odd=" + odd + ", eqpt="
				+ eqpt + ", status=" + status + ", bdLotId=" + bdLotId + ", sexian=" + sexian + ", outWorkId="
				+ outWorkId + ", flagType=" + flagType + ", unitType=" + unitType + "]";
	}

}
