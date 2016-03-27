package com.insurance.entity;

public class Life extends BaseModel {
	private int custId=-1;
	private int year;
	private int insurer=-1;
	private String life;
	private double lifePrice=-1;
	private String lifePic;
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
	public String getLife() {
		return life;
	}
	public void setLife(String life) {
		this.life = life;
	}
	public double getLifePrice() {
		return lifePrice;
	}
	public void setLifePrice(double lifePrice) {
		this.lifePrice = lifePrice;
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
	public String getLifePic() {
		return lifePic;
	}
	public void setLifePic(String lifePic) {
		this.lifePic = lifePic;
	}

}
