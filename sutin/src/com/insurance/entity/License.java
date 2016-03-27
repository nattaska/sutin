package com.insurance.entity;

public class License extends BaseModel {
	private int custId=-1;
	private String license;
	private int year;
	private int brand=-1;
	private int ltype=-1;
	private int lcomp=-1;
	private int lact=-1;
	private String car;
	private String vat;
	private String act;
	private String chk;
	private double carPrice=-1;
	private double vatPrice=-1;
	private double actPrice=-1;
	private double chkPrice=-1;
	private String carPic;
	private String vatPic;
	private String actPic;
	private String chkPic;
	private double vatService=-1;
	private String comment;
	private int active;
	
	public String getAct() {
		return act;
	}
	public void setAct(String act) {
		this.act = act;
	}
	public int getActive() {
		return active;
	}
	public void setActive(int active) {
		this.active = active;
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
	public int getCustId() {
		return custId;
	}
	public void setCustId(int custId) {
		this.custId = custId;
	}
	public int getLact() {
		return lact;
	}
	public void setLact(int lact) {
		this.lact = lact;
	}
	public int getLcomp() {
		return lcomp;
	}
	public void setLcomp(int lcomp) {
		this.lcomp = lcomp;
	}
	public String getLicense() {
		return license;
	}
	public void setLicense(String license) {
		this.license = license;
	}
	public int getLtype() {
		return ltype;
	}
	public void setLtype(int ltype) {
		this.ltype = ltype;
	}
	public String getVat() {
		return vat;
	}
	public void setVat(String vat) {
		this.vat = vat;
	}
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
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
	public double getVatService() {
		return vatService;
	}
	public void setVatService(double vatService) {
		this.vatService = vatService;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getActPic() {
		return actPic;
	}
	public void setActPic(String actPic) {
		this.actPic = actPic;
	}
	public String getCarPic() {
		return carPic;
	}
	public void setCarPic(String carPic) {
		this.carPic = carPic;
	}
	public String getChkPic() {
		return chkPic;
	}
	public void setChkPic(String chkPic) {
		this.chkPic = chkPic;
	}
	public String getVatPic() {
		return vatPic;
	}
	public void setVatPic(String vatPic) {
		this.vatPic = vatPic;
	}
}
