package com.insurance.entity;

public class Checking extends BaseModel { 
	private String license;
	private int province=-1;
	private String cerDate;
	private String regisDate;
	private int brandId=-1;
	private String coachWorkNo;
	private String motorNo;
	private int category=-1;
	private int characteristic=-1;
	private double weight=-1;
	private int motor=-1;
	private int fuel=-1;
	private int coachWorkNoPos=-1;
	private int motorNoPos=-1;
	private int pump=-1;
	private int cc=-1;
	private int axle=-1;
	private int wheel=-1;
	private int tire=-1;
	private int chkName=-1;

	public Checking() {}
	
	public Checking(String license)
	{
		this.license = license;
	}

	public int getAxle() {
		return axle;
	}
	public void setAxle(int axle) {
		this.axle = axle;
	}
	public int getBrandId() {
		return brandId;
	}
	public void setBrandId(int brandId) {
		this.brandId = brandId;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public int getCc() {
		return cc;
	}
	public void setCc(int cc) {
		this.cc = cc;
	}
	public int getCharacteristic() {
		return characteristic;
	}
	public void setCharacteristic(int characteristic) {
		this.characteristic = characteristic;
	}
	public int getChkName() {
		return chkName;
	}
	public void setChkName(int chkName) {
		this.chkName = chkName;
	}
	public String getCoachWorkNo() {
		return coachWorkNo;
	}
	public void setCoachWorkNo(String coachWorkNo) {
		this.coachWorkNo = coachWorkNo;
	}
	public int getCoachWorkNoPos() {
		return coachWorkNoPos;
	}
	public void setCoachWorkNoPos(int coachWorkNoPos) {
		this.coachWorkNoPos = coachWorkNoPos;
	}
	public int getMotor() {
		return motor;
	}
	public void setMotor(int motor) {
		this.motor = motor;
	}
	public int getFuel() {
		return fuel;
	}
	public void setFuel(int fuel) {
		this.fuel = fuel;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public String getMotorNo() {
		return motorNo;
	}
	public void setMotorNo(String motorNo) {
		this.motorNo = motorNo;
	}
	public int getMotorNoPos() {
		return motorNoPos;
	}
	public void setMotorNoPos(int motorNoPos) {
		this.motorNoPos = motorNoPos;
	}
	public int getProvince() {
		return province;
	}
	public void setProvince(int province) {
		this.province = province;
	}
	public int getPump() {
		return pump;
	}
	public void setPump(int pump) {
		this.pump = pump;
	}
	public String getRegisDate() {
		return regisDate;
	}
	public void setRegisDate(String regisDate) {
		this.regisDate = regisDate;
	}
	public int getTire() {
		return tire;
	}
	public void setTire(int tire) {
		this.tire = tire;
	}
	public double getWeight() {
		return weight;
	}
	public void setWeight(double weight) {
		this.weight = weight;
	}
	public int getWheel() {
		return wheel;
	}
	public void setWheel(int wheel) {
		this.wheel = wheel;
	}
	public String getCerDate() {
		return cerDate;
	}
	public void setCerDate(String cerDate) {
		this.cerDate = cerDate;
	}
}
