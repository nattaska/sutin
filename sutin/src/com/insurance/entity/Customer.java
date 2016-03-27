/*
 * Created on 8 ¾.Â. 2548
 *
 */
package com.insurance.entity;

import java.sql.Date;
import java.util.Vector;

/**
 * @author Turbo
 * Create Date : 8 ¾.Â. 2548
 * Update By : Turbo
 * Update Date : 8 ¾.Â. 2548
 * Version : 1.0
 * 
 */
public class Customer extends BaseModel { 
	public static final int ALL = 0;
	public static final int FIRE = 1; 
	public static final int CAR = 2; 
	public static final int VAT = 3; 
	public static final int ACT = 4; 
	public static final int LIFE = 5; 
	public static final int CHK = 6; 
	
	private int custId=-1;
	private String name;
	private int prefix=-1;
	private String prefixName;
	private String firstName;
	private String lastName;
	private String tel;
	private String address;
	private String moo;
	private String village;
	private String soi;
	private String road;
	private String district;
	private String zone;
	private int province=-1;
	private String provinceName;
	private int zipCode;
	private Vector<License> licenses;
	private Vector<Fire> fires;
	private Vector<Life> lives;

	public Customer() {}
	
	public Customer(int custId)
	{
		this.custId = custId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public Vector getFires() {
		return fires;
	}

	public void setFire(Vector fires) {
		this.fires = fires;
	}

	public Vector getLives() {
		return lives;
	}

	public void setLives(Vector lives) {
		this.lives = lives;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public Vector getLicenses() {
		return licenses;
	}

	public void setLicenses(Vector licenses) {
		this.licenses = licenses;
	}

	public String getMoo() {
		return moo;
	}

	public void setMoo(String moo) {
		this.moo = moo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getPrefix() {
		return prefix;
	}

	public void setPrefix(int prefix) {
		this.prefix = prefix;
	}

	public String getPrefixName() {
		return prefixName;
	}

	public void setPrefixName(String prefixName) {
		this.prefixName = prefixName;
	}

	public int getProvince() {
		return province;
	}

	public void setProvince(int province) {
		this.province = province;
	}

	public String getProvinceName() {
		return provinceName;
	}

	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	public String getRoad() {
		return road;
	}

	public void setRoad(String road) {
		this.road = road;
	}

	public String getSoi() {
		return soi;
	}

	public void setSoi(String soi) {
		this.soi = soi;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public int getZipCode() {
		return zipCode;
	}

	public void setZipCode(int zipCode) {
		this.zipCode = zipCode;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
	}
}
