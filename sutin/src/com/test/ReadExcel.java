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
		
		if (nam.trim().indexOf("����ѷ")==0||nam.trim().indexOf("�.")==0) {
//			name.delete(name.indexOf("����ѷ"),(name.indexOf("����ѷ")+6));
			if (nam.trim().indexOf("����ѷ")==0) name.append(nam.replaceFirst("����ѷ","" ).trim());
			else if (nam.trim().indexOf("�.")==0) name.append(nam.replaceFirst("�.","" ).trim());
			return 2;
		} else if (nam.trim().indexOf("˨�.") == 0) {
//			name.delete(name.indexOf("˨�."),(name.indexOf("˨�.")+4));
			name.append(nam.replaceFirst("˨�.","" ).trim());
			return 3;
		} else if (nam.trim().indexOf("˨�") == 0) {
//			name.delete(name.indexOf("˨�"),(name.indexOf("˨�")+3));
			name.append(nam.replaceFirst("˨�","" ).trim());
			return 3;
		} else {
			name.append(nam.toString());
		}
		return 1;
	}   
	
	private int chkProvince() {
		int cityId = -1;
		
		if (addr.indexOf("��طû�ҡ��")>0 || 
			addr.indexOf("�.ʻ")>0|| 
			addr.indexOf("�. ʻ")>0|| 
			addr.indexOf("�ʻ")>0|| 
			addr.indexOf("����û�ҡ��")>0|| 
			addr.indexOf("�.�.")>0) {
			if (addr.indexOf("��طû�ҡ��")>0) addr.delete(addr.indexOf("��طû�ҡ��"), addr.length());
			else if (addr.indexOf("����û�ҡ��")>0) addr.delete(addr.indexOf("����û�ҡ��"), addr.length());
			else if (addr.indexOf("�.ʻ")>0) addr.delete(addr.indexOf("�.ʻ"), addr.length());
			else if (addr.indexOf("�ʻ")>0) addr.delete(addr.indexOf("�ʻ"), addr.length());
			else if (addr.indexOf("�. ʻ")>0) addr.delete(addr.indexOf("�. ʻ"), addr.length());
			else if (addr.indexOf("�.�.")>0) addr.delete(addr.indexOf("�.�."), addr.length());
			cityId = 2;
		} else if (addr.indexOf("��ا෾")>0 || 
				addr.indexOf("���")>0) {
			if (addr.indexOf("��ا෾")>0) addr.delete(addr.indexOf("��ا෾"), addr.length());
			else if (addr.indexOf("���")>0) addr.delete(addr.indexOf("���"), addr.length());			
			cityId = 1;
		} else if (addr.indexOf("�������")>0) {
			addr.delete(addr.indexOf("�������"), addr.length());		
			cityId = 3;
		} else if (addr.indexOf("�����ҹ�")>0|| 
				   addr.indexOf("�.��")>0) {
			if (addr.indexOf("�����ҹ�")>0) addr.delete(addr.indexOf("�����ҹ�"), addr.length());
			else if (addr.indexOf("�.��")>0) addr.delete(addr.indexOf("�.��"), addr.length());
			cityId = 4;
		} else if (addr.indexOf("�ź���")>0) {
			addr.delete(addr.indexOf("�ź���"), addr.length());
			cityId = 11;
		} else if (addr.indexOf("���ͧ")>0) {
			addr.delete(addr.indexOf("���ͧ"), addr.length());
			cityId = 12;
		} else if (addr.indexOf("���ԧ���")>0 || addr.indexOf("��")>0) {
			if (addr.indexOf("���ԧ���")>0) addr.delete(addr.indexOf("���ԧ���"), addr.length());
			else if (addr.indexOf("��")>0) addr.delete(addr.indexOf("��"), addr.length());
			cityId = 15;
		} else if (addr.indexOf("���������")>0) {
			addr.delete(addr.indexOf("���������"), addr.length());
			cityId = 20;
		} else if (addr.indexOf("�������")>0) {
			addr.delete(addr.indexOf("�������"), addr.length());
			cityId = 22;
		} else if (addr.indexOf("�������")>0) {
			addr.delete(addr.indexOf("�������"), addr.length());
			cityId = 25;
		} else if (addr.indexOf("�͹��")>0) {
			addr.delete(addr.indexOf("�͹��"), addr.length());
			cityId = 28;
		} else if (addr.indexOf("�شøҹ�")>0) {
			addr.delete(addr.indexOf("�شøҹ�"), addr.length());
			cityId = 29;
		} else if (addr.indexOf("ʡŹ��")>0) {
			addr.delete(addr.indexOf("ʡŹ��"), addr.length());
			cityId = 35;
		} else if (addr.indexOf("��§����")>0) {
			addr.delete(addr.indexOf("��§����"), addr.length());
			cityId = 38;
		} else if (addr.indexOf("�صôԵ��")>0) {
			addr.delete(addr.indexOf("�صôԵ��"), addr.length());
			cityId = 41;
		} else if (addr.indexOf("������ä�")>0) {
			addr.delete(addr.indexOf("������ä�"), addr.length());
			cityId = 47;
		} else if (addr.indexOf("�ҡ")>0) {
			addr.delete(addr.indexOf("�ҡ"), addr.length());
			cityId = 50;
		} else if (addr.indexOf("��ɳ��š")>0) {
			addr.delete(addr.indexOf("��ɳ��š"), addr.length());
			cityId = 52;
		} else if (addr.indexOf("�Ԩ�")>0) {
			addr.delete(addr.indexOf("�Ԩ�"), addr.length());
			cityId = 53;
		} else if (addr.indexOf("ྪú�ó�")>0) {
			addr.delete(addr.indexOf("ྪú�ó�"), addr.length());
			cityId = 54;
		} else if (addr.indexOf("��ѧ")>0) {
			addr.delete(addr.indexOf("��ѧ"), addr.length());
			cityId = 72;
		}
		if (cityId == -1) {
			System.out.println(addr.toString());
		}
		 if (addr.indexOf("�.") > 0)
			 addr.setLength(addr.indexOf("�."));
		return cityId;
	}   
	
	private int chkZipcode() {
		String[] add = StringUtil.token2Array(addr.toString(), " ");
		String zip = add[add.length-1];
		if ((zip.length() == 5)&&(zip.indexOf("�")==-1)) {
			addr.setLength(addr.indexOf(zip)-1);
			return Integer.parseInt(zip);
		}
		return -1;
	}   
	
	private int chkBrand(String brand) {

		if (brand.indexOf("��µ��")!=-1 || 
			brand.indexOf("⵵��")!=-1) {
			return 1;
		} else if (brand.indexOf("�͹���")!=-1) {
			return 2;
		} else if (brand.indexOf("������")!=-1) {
			return 3;
		} else if (brand.indexOf("��ʻ��")!=-1) {
			return 4;
		} else if (brand.indexOf("�ʹ")!=-1) {
			return 5;
		} else if (brand.indexOf("�٫١�")!=-1) {
			return 6;
		} else if (brand.indexOf("������")!=-1) {
			return 7;
		} else if (brand.indexOf("�ի٫�")!=-1) {
			return 8;
		} else if (brand.indexOf("����ѹ")!=-1) {
			return 9;
		} else if (brand.indexOf("�Ե��")!=-1) {
			return 10;
		}
		return -1;
	}
	
}

