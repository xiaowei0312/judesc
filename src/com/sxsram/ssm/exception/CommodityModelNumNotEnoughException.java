package com.sxsram.ssm.exception;

public class CommodityModelNumNotEnoughException extends Exception {

	private String message;
	private Integer currentNum;
	private Integer buyNum;
	private Integer oldNum;

	public CommodityModelNumNotEnoughException() {

	}

	public CommodityModelNumNotEnoughException(String commodityName, Integer currentNum, Integer buyNum) {
		this.currentNum = currentNum;
		this.buyNum = buyNum;
		this.message = "商品【" + commodityName + "】库存不足，无法完成购买【现有库存：" + currentNum + " / 购买数量：" + buyNum + "】";
	}
	
	public CommodityModelNumNotEnoughException(String commodityName, Integer currentNum, Integer buyNum,Integer oldNum) {
		this.currentNum = currentNum;
		this.buyNum = buyNum;
		this.oldNum = oldNum;
		this.message = "商品【" + commodityName + "】库存不足，无法完成购买【现有库存：" + currentNum + " / 购买数量：" + buyNum + "】";
	}
	
	public Integer getOldNum() {
		return oldNum;
	}

	public void setOldNum(Integer oldNum) {
		this.oldNum = oldNum;
	}

	public Integer getCurrentNum() {
		return currentNum;
	}

	public void setCurrentNum(Integer currentNum) {
		this.currentNum = currentNum;
	}

	public Integer getBuyNum() {
		return buyNum;
	}

	public void setBuyNum(Integer buyNum) {
		this.buyNum = buyNum;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
}
