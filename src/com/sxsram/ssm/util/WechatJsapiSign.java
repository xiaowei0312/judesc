package com.sxsram.ssm.util;

public class WechatJsapiSign {
	private String appId;
	private String nonceStr;
	private String timestamp;
	private String signature;

	public String getAppId() {
		return appId;
	}

	public void setAppId(String appId) {
		this.appId = appId;
	}

	public String getNonceStr() {
		return nonceStr;
	}

	public void setNonceStr(String nonceStr) {
		this.nonceStr = nonceStr;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	@Override
	public String toString() {
		return "WechatJsapiSign [appId=" + appId + ", nonceStr=" + nonceStr + ", timestamp=" + timestamp
				+ ", signature=" + signature + "]";
	}

}
