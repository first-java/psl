package com.jnbdt.domain;

/**
 * @ClassNmame ShippingInformation.java
 * @author 奥特虾不会写代码
 * @author E-mail:pengshiliang@latticepower.com
 * @version 1.0
 * @time 创建时间：2020年3月16日 上午11:16:37
 * @Copyright © 2020 by 奥特虾不会写代码
 */
public class ShippingInformation {
	private String binTapeId;
	private String mesLot;
	private String Bin;
	private String lmQty;

	public String getBinTapeId() {
		return binTapeId;
	}

	public void setBinTapeId(String binTapeId) {
		this.binTapeId = binTapeId;
	}

	public String getMesLot() {
		return mesLot;
	}

	public void setMesLot(String mesLot) {
		this.mesLot = mesLot;
	}

	public String getBin() {
		return Bin;
	}

	public void setBin(String bin) {
		Bin = bin;
	}

	public String getLmQty() {
		return lmQty;
	}

	public void setLmQty(String lmQty) {
		this.lmQty = lmQty;
	}

}
