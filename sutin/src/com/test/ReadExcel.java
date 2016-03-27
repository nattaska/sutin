package com.test;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import com.insurance.entity.Customer;
import com.standard.db.DBControl;
import com.standard.util.StringUtil;
import com.standard.db.DBControl;

import jxl.Cell;
import jxl.CellType;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.WriteException;

public class ReadExcel {

	private String inputFile;
	private StringBuffer addr;
	private StringBuffer name;

	public void setInputFile(String inputFile) {
		this.inputFile = inputFile;
	}

	public void read() throws IOException, WriteException {
		File inputWorkbook = new File(inputFile);
		System.out.println(inputWorkbook.getName());
		Workbook w;
		try {
			w = Workbook.getWorkbook(inputWorkbook);
			// Get the first sheet
			Sheet sheet = w.getSheet(1);
			// Loop over first 10 column and lines

			for (int i = 0; i < sheet.getRows(); i++) {
				for (int j = 6; j < 11; j++) {
					Cell cell = sheet.getCell(j, i);
					CellType type = cell.getType();
					System.out.println(cell.getContents()+"\t");
				}
				System.out.println();
			}
		} catch (BiffException e) {
			e.printStackTrace();
		}
	}

	public void read2() throws IOException, WriteException {
		File inputWorkbook = new File(inputFile);
		System.out.println(inputWorkbook.getName());
		Workbook w;
//		Map map = new HashMap();
		name = new StringBuffer();
		addr = new StringBuffer();
		StringBuffer tel = new StringBuffer();
		StringBuffer license = new StringBuffer();
		StringBuffer brand = new StringBuffer();
		int city=-1;
		int zipcode=-1;
//		int prefix=1;
		boolean firstadd=true;
		boolean firsttel=true;
		boolean firstlicense=true;
		int id=0;
		int oldid=0;
		Vector vRec = new Vector();
		try {
			w = Workbook.getWorkbook(inputWorkbook);
			// Get the first sheet
			Sheet sheet = w.getSheet(1);
//			System.out.println("Row = "+sheet.getRows());
			// Loop over first 10 column and lines
//			for (int r = 0; r < sheet.getRows(); r++) {
			for (int r = 0; r < 30; r++) {
//				map.put("ID", new Integer(r));
				city=-1;
				zipcode=-1;
//				prefix=1;
				Cell chkcell = sheet.getCell(0, r);
				CellType type = chkcell.getType();
				if (type != CellType.EMPTY) {
					if (!firstadd) {
						zipcode=chkZipcode();
						city=chkProvince();
//						System.out.println(id+", '"+name.toString()+"','"+tel.toString()+"','"+addr.toString()+"',"+city);
						Customer cust = new Customer();
						cust.setCustId(id);
						cust.setPrefix(chkPrefix());
						cust.setName(name.toString().trim());
						cust.setTel(tel.toString().trim());
						cust.setZipCode(zipcode);
						cust.setAddress(addr.toString().trim());
						cust.setProvince(city);
//						cust.setLicense(license.toString().trim());
//						cust.setBrand(chkBrand(brand.toString()));
//						if (cust.getBrand()==-1 && !brand.toString().equals("")) {
//							System.out.println(cust.getBrand()+"   :   "+brand.toString());
//						}
						vRec.add(cust);
						if (id%10==0) {
							this.addCustomer(vRec);
							vRec.clear();
						}
					}
					name.delete(0, name.length());
					addr.delete(0, addr.length());
					tel.delete(0, tel.length());
					license.delete(0, license.length());
					brand.delete(0, brand.length());
					firstadd = true;
					firsttel = true;
					firstlicense = true;
					id++;
//					System.out.println();
					name.append(sheet.getCell(1, r).getContents());
				} else {
					if (sheet.getCell(1, r).getType() != CellType.EMPTY) {
						if (firstadd) {
							addr.append(sheet.getCell(1, r).getContents());
							firstadd=false;
						} else
							addr.append("\n"+sheet.getCell(1, r).getContents());
							
					}
					if (sheet.getCell(2, r).getType() != CellType.EMPTY) {
						if (firsttel) {
							tel.append(sheet.getCell(2, r).getContents());
							firsttel=false;
						} else
							tel.append(", "+sheet.getCell(2, r).getContents());
					}
					if (sheet.getCell(3, r).getType() != CellType.EMPTY) {
						if (firstlicense) {
							license.append(sheet.getCell(3, r).getContents());
							firstlicense=false;
						} else
							brand.append(sheet.getCell(3, r).getContents());
					}
				}
			}
//			System.out.println(id+", '"+name.toString()+"','"+tel.toString()+"','"+addr.toString()+"',"+city);
			if (vRec.size() > 0)
				this.addCustomer(vRec);
		} catch (BiffException e) {
			e.printStackTrace();
		}
	}
	
	public void addCustomer(Vector custs) {
		Connection conn = null;
		PreparedStatement stmt = null;
		PreparedStatement stmtl = null;
		String sql = "INSERT INTO customer (custid,prefix,name,tel,address,province,zipcode,creby,updby,credate,upddate) \n" +
		 "VALUES(?,?,?,?,?,?,?,?,?,?,?)";
		String lsql = "INSERT INTO license (custid,license,brandid,vatmonth,creby,updby,credate,upddate) \n" +
		 "VALUES(?,?,?,?,?,?,?,?)";
		Timestamp time = new Timestamp(Calendar.getInstance().getTimeInMillis());

        try{
	    	DBControl db = new DBControl();
	    	conn = db.getConnection();
	    	conn.setAutoCommit(false);
	    	stmt = conn.prepareStatement(sql);
	    	stmtl = conn.prepareStatement(lsql);
	    	
	        for(int i=0;i<custs.size();i++)
		    {
	           	Customer cust = (Customer) custs.get(i);
//	        	System.out.println("Customer "+(i+1)+" = "+cust.getCustId());
	           	stmt.setInt(1,cust.getCustId());
	           	stmt.setInt(2,cust.getPrefix());
	           	stmt.setString(3,StringUtil.Unicode2ASCII(cust.getName()));
	           	stmt.setString(4,(cust.getTel()==null||cust.getTel().equals(""))?null:StringUtil.Unicode2ASCII(cust.getTel()));
	           	stmt.setString(5,StringUtil.Unicode2ASCII(cust.getAddress()));
	           	if (cust.getProvince()==-1) 
	           		stmt.setString(6,null);
	           	else
	           		stmt.setInt(6,cust.getProvince());
	           	if (cust.getZipCode()==-1) 
	           		stmt.setString(7,null);
	           	else
	           		stmt.setInt(7,cust.getZipCode());
	           	stmt.setString(8,"auto");
	           	stmt.setString(9,"auto");
	           	stmt.setTimestamp(10, time);
	           	stmt.setTimestamp(11, time);
	           	stmt.executeUpdate();

	           	stmtl.setInt(1,cust.getCustId());
//	           	stmtl.setString(2,(cust.getLicense()==null||cust.getLicense().equals(""))?null:StringUtil.Unicode2ASCII(cust.getLicense()));
//	           	if (cust.getBrand()==-1) 
//	           		stmtl.setString(3,null);
//	           	else
//	           		stmtl.setInt(3,cust.getBrand());
	           	stmtl.setInt(4,1);
	           	stmtl.setString(5,"auto");
	           	stmtl.setString(6,"auto");
	           	stmtl.setTimestamp(7, time);
	           	stmtl.setTimestamp(8, time);
//	           	if (cust.getLicense()==null||cust.getLicense().equals("")) 
//	           		System.err.println(cust.getName()+" License NULL");
	           	stmtl.executeUpdate();
		   	}
	        conn.commit();
            stmt.close();
            conn.close();
        }catch(Exception e){
        	e.printStackTrace();
        }
		
	}

	public static void main(String[] args) throws WriteException, IOException {
		ReadExcel test = new ReadExcel();
		test.setInputFile("C:/temp/CustVat.xls");
//		test.read();
		Date start = new Date();
		test.read2();
		Date end = new Date();
		System.out.println("Stat : "+start);
		System.out.println("End : "+start);
		System.out.println("Period : "+(end.getTime()-start.getTime()));
	}
	
	private int chkPrefix() {
		String nam = name.toString();
		name.delete(0, name.length());		
		
		if (nam.trim().indexOf("บริษัท")==0||nam.trim().indexOf("บ.")==0) {
//			name.delete(name.indexOf("บริษัท"),(name.indexOf("บริษัท")+6));
			if (nam.trim().indexOf("บริษัท")==0) name.append(nam.replaceFirst("บริษัท","" ).trim());
			else if (nam.trim().indexOf("บ.")==0) name.append(nam.replaceFirst("บ.","" ).trim());
			return 2;
		} else if (nam.trim().indexOf("หจก.") == 0) {
//			name.delete(name.indexOf("หจก."),(name.indexOf("หจก.")+4));
			name.append(nam.replaceFirst("หจก.","" ).trim());
			return 3;
		} else if (nam.trim().indexOf("หจก") == 0) {
//			name.delete(name.indexOf("หจก"),(name.indexOf("หจก")+3));
			name.append(nam.replaceFirst("หจก","" ).trim());
			return 3;
		} else {
			name.append(nam.toString());
		}
		return 1;
	}   
	
	private int chkProvince() {
		int cityId = -1;
		
		if (addr.indexOf("สมุทรปราการ")>0 || 
			addr.indexOf("จ.สป")>0|| 
			addr.indexOf("จ. สป")>0|| 
			addr.indexOf("จสป")>0|| 
			addr.indexOf("สมทุรปราการ")>0|| 
			addr.indexOf("ส.ป.")>0) {
			if (addr.indexOf("สมุทรปราการ")>0) addr.delete(addr.indexOf("สมุทรปราการ"), addr.length());
			else if (addr.indexOf("สมทุรปราการ")>0) addr.delete(addr.indexOf("สมทุรปราการ"), addr.length());
			else if (addr.indexOf("จ.สป")>0) addr.delete(addr.indexOf("จ.สป"), addr.length());
			else if (addr.indexOf("จสป")>0) addr.delete(addr.indexOf("จสป"), addr.length());
			else if (addr.indexOf("จ. สป")>0) addr.delete(addr.indexOf("จ. สป"), addr.length());
			else if (addr.indexOf("ส.ป.")>0) addr.delete(addr.indexOf("ส.ป."), addr.length());
			cityId = 2;
		} else if (addr.indexOf("กรุงเทพ")>0 || 
				addr.indexOf("กทม")>0) {
			if (addr.indexOf("กรุงเทพ")>0) addr.delete(addr.indexOf("กรุงเทพ"), addr.length());
			else if (addr.indexOf("กทม")>0) addr.delete(addr.indexOf("กทม"), addr.length());			
			cityId = 1;
		} else if (addr.indexOf("นนทบุรี")>0) {
			addr.delete(addr.indexOf("นนทบุรี"), addr.length());		
			cityId = 3;
		} else if (addr.indexOf("ปทุมธานี")>0|| 
				   addr.indexOf("จ.ปท")>0) {
			if (addr.indexOf("ปทุมธานี")>0) addr.delete(addr.indexOf("ปทุมธานี"), addr.length());
			else if (addr.indexOf("จ.ปท")>0) addr.delete(addr.indexOf("จ.ปท"), addr.length());
			cityId = 4;
		} else if (addr.indexOf("ชลบุรี")>0) {
			addr.delete(addr.indexOf("ชลบุรี"), addr.length());
			cityId = 11;
		} else if (addr.indexOf("ระยอง")>0) {
			addr.delete(addr.indexOf("ระยอง"), addr.length());
			cityId = 12;
		} else if (addr.indexOf("ฉะเชิงเทรา")>0 || addr.indexOf("ฉช")>0) {
			if (addr.indexOf("ฉะเชิงเทรา")>0) addr.delete(addr.indexOf("ฉะเชิงเทรา"), addr.length());
			else if (addr.indexOf("ฉช")>0) addr.delete(addr.indexOf("ฉช"), addr.length());
			cityId = 15;
		} else if (addr.indexOf("บุรีรัมย์")>0) {
			addr.delete(addr.indexOf("บุรีรัมย์"), addr.length());
			cityId = 20;
		} else if (addr.indexOf("ศรีสะเกษ")>0) {
			addr.delete(addr.indexOf("ศรีสะเกษ"), addr.length());
			cityId = 22;
		} else if (addr.indexOf("ชัยภูมิ")>0) {
			addr.delete(addr.indexOf("ชัยภูมิ"), addr.length());
			cityId = 25;
		} else if (addr.indexOf("ขอนแก่น")>0) {
			addr.delete(addr.indexOf("ขอนแก่น"), addr.length());
			cityId = 28;
		} else if (addr.indexOf("อุดรธานี")>0) {
			addr.delete(addr.indexOf("อุดรธานี"), addr.length());
			cityId = 29;
		} else if (addr.indexOf("สกลนคร")>0) {
			addr.delete(addr.indexOf("สกลนคร"), addr.length());
			cityId = 35;
		} else if (addr.indexOf("เชียงใหม่")>0) {
			addr.delete(addr.indexOf("เชียงใหม่"), addr.length());
			cityId = 38;
		} else if (addr.indexOf("อุตรดิตถ์")>0) {
			addr.delete(addr.indexOf("อุตรดิตถ์"), addr.length());
			cityId = 41;
		} else if (addr.indexOf("นครสวรรค์")>0) {
			addr.delete(addr.indexOf("นครสวรรค์"), addr.length());
			cityId = 47;
		} else if (addr.indexOf("ตาก")>0) {
			addr.delete(addr.indexOf("ตาก"), addr.length());
			cityId = 50;
		} else if (addr.indexOf("พิษณุโลก")>0) {
			addr.delete(addr.indexOf("พิษณุโลก"), addr.length());
			cityId = 52;
		} else if (addr.indexOf("พิจิ")>0) {
			addr.delete(addr.indexOf("พิจิ"), addr.length());
			cityId = 53;
		} else if (addr.indexOf("เพชรบูรณ์")>0) {
			addr.delete(addr.indexOf("เพชรบูรณ์"), addr.length());
			cityId = 54;
		} else if (addr.indexOf("ตรัง")>0) {
			addr.delete(addr.indexOf("ตรัง"), addr.length());
			cityId = 72;
		}
		if (cityId == -1) {
			System.out.println(addr.toString());
		}
		 if (addr.indexOf("จ.") > 0)
			 addr.setLength(addr.indexOf("จ."));
		return cityId;
	}   
	
	private int chkZipcode() {
		String[] add = StringUtil.token2Array(addr.toString(), " ");
		String zip = add[add.length-1];
		if ((zip.length() == 5)&&(zip.indexOf("จ")==-1)) {
			addr.setLength(addr.indexOf(zip)-1);
			return Integer.parseInt(zip);
		}
		return -1;
	}   
	
	private int chkBrand(String brand) {

		if (brand.indexOf("โตโยต้า")!=-1 || 
			brand.indexOf("โตต้า")!=-1) {
			return 1;
		} else if (brand.indexOf("ฮอนด้า")!=-1) {
			return 2;
		} else if (brand.indexOf("บีเอ็ม")!=-1) {
			return 3;
		} else if (brand.indexOf("เวสป้า")!=-1) {
			return 4;
		} else if (brand.indexOf("ฟอด")!=-1) {
			return 5;
		} else if (brand.indexOf("ซูซูกิ")!=-1) {
			return 6;
		} else if (brand.indexOf("ไดฮัสสุ")!=-1) {
			return 7;
		} else if (brand.indexOf("อีซูซุ")!=-1) {
			return 8;
		} else if (brand.indexOf("นิสสัน")!=-1) {
			return 9;
		} else if (brand.indexOf("มิตซู")!=-1) {
			return 10;
		}
		return -1;
	}
	
}

