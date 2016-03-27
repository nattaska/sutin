package com.insurance.entity;

public class Fire extends BaseModel {
	private int custId=-1;
	private int year;
	private int insurer=-1;
	private String fire;
	private double firePrice=-1;
	private String firePic;
	private int active;
	
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
	}
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public String getFire() {
		return fire;
	}
	public void setFire(String fire) {
		this.fire = fire;
	}
	public double getFirePrice() {
		return firePrice;
	}
	public void setFirePrice(double firePrice) {
		this.firePrice = firePrice;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public int getInsurer() {
		return insurer;
	}
	public void setInsurer(int insurer) {
		this.insurer = insurer;
	}
	public String getFirePic() {
		return firePic;
	}
	public void setFirePic(String firePic) {
		this.firePic = firePic;
	}

}
