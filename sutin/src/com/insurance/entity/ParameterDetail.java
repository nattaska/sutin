package com.insurance.entity;

public class ParameterDetail extends ParameterHeader {
	private int parId;
	private String parName;
	
	public ParameterDetail() {}
	
	public ParameterDetail(int parId) {
		this.parId = parId;
	}
	
	public ParameterDetail(int tabId,int parId) {
		super.setTabId(tabId);
		this.parId = parId;
	}
	
	public int getParId() {
		return parId;
	}
	public void setParId(int parId) {
		this.parId = parId;
	}
	public String getParName() {
		return parName;
	}
	public void setParName(String parName) {
		this.parName = parName;
	}
}
