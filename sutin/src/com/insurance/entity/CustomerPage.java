/*
 * Created on 8 ¾.Â. 2548
 *
 */
package com.insurance.entity;

/**
 * @author Turbo
 * Create Date : 8 ¾.Â. 2548
 * Update By : Turbo
 * Update Date : 8 ¾.Â. 2548
 * Version : 1.0
 * 
 */
public class CustomerPage extends BaseModel { 
	public static int ALL = 0;
	public static int FIRE = 1; 
	public static int CAR = 2; 
	public static int VAT = 3; 
	public static int LIFE = 4; 
	
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
	private String license;
	private int year;
	private String fire;
	private String life;
	private int brand=-1;
	private int ltype=-1;
	private int lcomp=-1;
	private int fireInsurer=-1;
	private int lifeInsurer=-1;
	private int lact=-1;
	private String car;
	private String vat;
	private String act;
	private String chk;
	private int factive;
	private int lactive;
	private int lfactive;
	private double carPrice=-1;
	private double vatPrice=-1;
	private double actPrice=-1;
	private double firePrice=-1;
	private double lifePrice=-1;
	private double chkPrice=-1;
	private double vatService=-1;
	private String comment;

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getChk() {
		return chk;
	}

	public void setChk(String chk) {
		this.chk = chk;
	}

	public double getChkPrice() {
		return chkPrice;
	}

	public void setChkPrice(double chkPrice) {
		this.chkPrice = chkPrice;
	}

	public CustomerPage() {}
	
	public CustomerPage(int custId)
	{
		this.custId = custId;
	}

	public int getCustId() {
		return custId;
	}

	public void setCustId(int custId) {
		this.custId = custId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getMoo() {
		return moo;
	}

	public void setMoo(String moo) {
		this.moo = moo;
	}

	public String getVillage() {
		return village;
	}

	public void setVillage(String village) {
		this.village = village;
	}

	public String getSoi() {
		return soi;
	}

	public void setSoi(String soi) {
		this.soi = soi;
	}

	public String getRoad() {
		return road;
	}

	public void setRoad(String road) {
		this.road = road;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getZone() {
		return zone;
	}

	public void setZone(String zone) {
		this.zone = zone;
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

	public int getZipCode() {
		return zipCode;
	}

	public void setZipCode(int zipCode) {
		this.zipCode = zipCode;
	}

	public int getBrand() {
		return brand;
	}

	public void setBrand(int brand) {
		this.brand = brand;
	}

	public String getCar() {
		return car;
	}

	public void setCar(String car) {
		this.car = car;
	}

	public String getFire() {
		return fire;
	}

	public void setFire(String fire) {
		this.fire = fire;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getVat() {
		return vat;
	}

	public void setVat(String vat) {
		this.vat = vat;
	}
	
	public String getAct() {
		return act;
	}

	public void setAct(String act) {
		this.act = act;
	}

	public int getYear() {
		return year;
	}

	public void setYear(int year) {
		this.year = year;
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

	public int getLcomp() {
		return lcomp;
	}

	public void setLcomp(int lcomp) {
		this.lcomp = lcomp;
	}

	public int getLtype() {
		return ltype;
	}

	public void setLtype(int ltype) {
		this.ltype = ltype;
	}

	public int getLact() {
		return lact;
	}

	public void setLact(int lact) {
		this.lact = lact;
	}

	public int getFactive() {
		return factive;
	}

	public void setFactive(int factive) {
		this.factive = factive;
	}

	public int getLactive() {
		return lactive;
	}

	public void setLactive(int lactive) {
		this.lactive = lactive;
	}

	public double getActPrice() {
		return actPrice;
	}

	public void setActPrice(double actPrice) {
		this.actPrice = actPrice;
	}

	public double getCarPrice() {
		return carPrice;
	}

	public void setCarPrice(double carPrice) {
		this.carPrice = carPrice;
	}

	public double getVatPrice() {
		return vatPrice;
	}

	public void setVatPrice(double vatPrice) {
		this.vatPrice = vatPrice;
	}

	public double getFirePrice() {
		return firePrice;
	}

	public void setFirePrice(double firePrice) {
		this.firePrice = firePrice;
	}

	public int getLfactive() {
		return lfactive;
	}

	public void setLfactive(int lfactive) {
		this.lfactive = lfactive;
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

	public int getFireInsurer() {
		return fireInsurer;
	}

	public void setFireInsurer(int fireInsurer) {
		this.fireInsurer = fireInsurer;
	}

	public int getLifeInsurer() {
		return lifeInsurer;
	}

	public void setLifeInsurer(int lifeInsurer) {
		this.lifeInsurer = lifeInsurer;
	}

	public double getVatService() {
		return vatService;
	}

	public void setVatService(double vatService) {
		this.vatService = vatService;
	}
}
