package com.example.springboot.psl.entity;

/**
 * @ClassNmame BagnameToQc.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年4月18日 上午9:17:39
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public class BagNameToQc {
	private String bagName;
	private String lotType;
	private String binId;
	private String specId;
	private String qty;
	private String workId;

	public String getWorkId() {
		return workId;
	}

	public void setWorkId(String workId) {
		this.workId = workId;
	}

	public String getBagName() {
		return bagName;
	}

	public void setBagName(String bagName) {
		this.bagName = bagName;
	}

	public String getLotType() {
		return lotType;
	}

	public void setLotType(String lotType) {
		this.lotType = lotType;
	}

	public String getBinId() {
		return binId;
	}

	public void setBinId(String binId) {
		this.binId = binId;
	}

	public String getSpecId() {
		return specId;
	}

	public void setSpecId(String specId) {
		this.specId = specId;
	}

	public String getQty() {
		return qty;
	}

	public void setQty(String qty) {
		this.qty = qty;
	}

	public BagNameToQc(String workId, String bagName, String lotType, String binId, String specId, String qty) {
		super();
		this.bagName = bagName;
		this.workId = workId;
		this.lotType = lotType;
		this.binId = binId;
		this.specId = specId;
		this.qty = qty;
	}

	public BagNameToQc() {

	}

}
