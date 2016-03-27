package com.test;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Vector;

import com.insurance.entity.Customer;
import com.insurance.entity.CustomerPage;
import com.insurance.entity.Fire;
import com.insurance.entity.License;
import com.insurance.entity.Life;
import com.insurance.manage.CustomerManager;
import com.standard.STDException;
import com.standard.db.DBControl;
import com.standard.util.DateUtil;
import com.standard.util.ShowData;
import com.standard.util.StringUtil;

public class Test extends DBControl {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws IOException 
	 */
	public static void main(String[] args) {
		System.out.println(StringUtil.toString(Calendar.getInstance().getTime(), "yyyy"));
//		String t = "ผศ-";
//		String st[] = StringUtil.stringTokenToArray(t, "-");
//		System.out.println(st1.length);
//		System.out.println(st[0]);
//		System.out.println(st[1]);
		
//		String t2 = "-1111";
//		String st2[] = StringUtil.stringTokenToArray(t2, "-");
//		System.out.println(st2.length);
//		System.out.println("0 : "+st2[0]);
//		System.out.println("1 : "+st2[1]);

//		SimpleDateFormat sp = new SimpleDateFormat("MMMMM",new java.util.Locale("th","TH"));
//		String aa = "customer.jasper";
//		System.out.println(aa.substring(0,aa.indexOf(".jasper")));
//		System.out.println(StringUtil.toString(Calendar.getInstance().getTime(), "yyyyMM"));
//		System.out.println(15%10);
//		System.out.println("a\nb");
//		String bb = "กษิดิษ เที";
//		String aa = "%A1%C9%D4%B4%D4%C9 %E0%B7%D5";
//		aa = aa.replaceAll("%", "0x");
//		String aaa = "";
//		try {
//			System.out.println(StringUtil.encode2CE(aa));
//			System.out.println(StringUtil.encode2Thai(aa));
//			System.out.println(StringUtil.encode2TIS(aa));
//			System.out.println(StringUtil.ASCII2Unicode(aa));
//			System.out.println(StringUtil.Unicode2ASCII(bb));
//			System.out.println((char)0xA1);
//		    StringBuffer unicode = new StringBuffer("x");
//			System.out.println(StringUtil.encode2CE((char)0xA1));
//			System.out.println(StringUtil.encode2Thai((char)0xA1));
//			System.out.println(StringUtil.encode2TIS((char)0xA1));
//            unicode.setCharAt( 0, (char)((char)0xA1 + 0xD60));
//            System.out.println(unicode.toString());
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//		String[] licenses = StringUtil.stringTokenToArray(ShowData.CheckNull(null), "-");
//		System.out.println(licenses.length);
//		System.out.println(licenses[0]);
//		System.out.println(licenses[1]);
//		Timestamp ti = new Timestamp(Calendar.getInstance().getTimeInMillis());
//		StringBuffer sb = new StringBuffer();
//		sb.append("303/57  ม.11   ต.บางพลีใหญ่   อ.บางพลี   จ.สป.");
//		
//		if (sb.indexOf("สมุทรปราการ")>0 || 
//				sb.indexOf("จ.สป")>0|| 
//				sb.indexOf("จ. สป")>0) {
//			if (sb.indexOf("สมุทรปราการ")>0) sb.delete(sb.indexOf("สมุทรปราการ"), sb.length());
//			else if (sb.indexOf("จ.สป")>0) sb.delete(sb.indexOf("จ.สป"), sb.length());
//			else if (sb.indexOf("จ. สป")>0) sb.delete(sb.indexOf("จ. สป"), sb.length());
//			System.out.println(2);
//		}
//		
//		int index = sb.indexOf("จ.กรุงเทพ");
//		String[] add = StringUtil.token2Array(sb.toString(), " ");
//		String zip = add[add.length-1];
//		System.out.println("Zipcode = "+zip);
//		System.out.println("Province = "+add[add.length-2]);
//		
//		String name = "หจก. พัฒนศิลป์การช่างและค้าไม้";
//		System.out.println(name.indexOf("หจก"));
//		
//		StringBuffer bName = new StringBuffer("บริษัท พัฒนศิลป์การช่างและค้าไม้");
//		String nam = bName.toString();
//		System.out.println(bName.toString());
//		bName.delete(0, bName.length());	
//		System.out.println(bName.toString());
//		bName.append(nam.replaceFirst("บริษัท","" ).trim());
//		System.out.println(bName.toString());
//		
//		String split = "";
//		String[] splits = StringUtil.stringTokenToArray(split, "-");
//		System.out.println(splits.length);
//		System.out.println(splits[0]+","+splits[1]);
		
//		bName.replaceFirst("หจก.","" );
//		bName.indexOf("บริษัท");
//		bName.delete(bName.indexOf("บริษัท"),(bName.indexOf("บริษัท")+6));
//		System.out.println(bName.toString().replaceFirst("หจก.","" ));
//		System.out.println(bName.toString());
//		sb.
//		System.out.println(sb.indexOf("จ.กรุงเทพ"));
//		sb.setLength(index);
//		System.out.println(sb);
//		Test t = new Test();
//		try {
//			System.out.println(t.testNoRow());
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		for (int i=1;i<=12;i++) {
//			if (i < 10)
//				System.out.println(StringUtil.toStringMonth("0"+i));
////				System.out.println("01/0"+i+"/09  "+sp.format(DateUtil.toUtilDate("01/0"+i+"/09")));
//			else 
//				System.out.println(StringUtil.toStringMonth(""+i));
////				System.out.println("01/"+i+"/09  "+sp.format(DateUtil.toUtilDate("01/"+i+"/09")));
//		}
		System.out.println(DateUtil.changeToThaiDate(new Date()));
//		Test t = new Test();
//		try {
//			t.testGetCustomerPage();
//		} catch (SQLException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (STDException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//		String[] str = StringUtil.stringTokenToArray("5:Insert Complete", ":");
//		System.out.println(str[0]);
	}
	
	public void testGetCustomerPage () throws SQLException, STDException, IOException {
		
        CustomerManager manage = new CustomerManager();
        CustomerPage c = new CustomerPage();
        manage.searchCustomerPage(c, CustomerPage.ALL, null);
		
	}
	
	public void testGetCustomer () throws SQLException, STDException, IOException {
		
        CustomerManager manage = new CustomerManager();
        Customer cEntity = manage.getCustomer(1);
        if (cEntity != null) {
        	System.out.println(cEntity.getName()+" : "+cEntity.getProvinceName());
        	Vector licenses = cEntity.getLicenses();
        	for (int i=0;i<licenses.size();i++) {
        		License lEntity = (License)licenses.elementAt(i);
        		System.out.println("\t"+lEntity.getLicense()+" : "+lEntity.getYear());
        	}
        	Vector fires = cEntity.getFires();
        	for (int i=0;i<fires.size();i++) {
        		Fire fEntity = (Fire)fires.elementAt(i);
        		System.out.println("\t"+fEntity.getFire()+" : "+fEntity.getYear());
        	}
        	Vector lives = cEntity.getLives();
        	for (int i=0;i<lives.size();i++) {
        		Life lfEntity = (Life)lives.elementAt(i);
        		System.out.println("\t"+lfEntity.getLife()+" : "+lfEntity.getYear());
        	}
        }
		
	}
	
	public boolean testNoRow () throws SQLException {
		String sql = "select * from customer where custid=1";
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        ResultSet res;
        res = stmt.executeQuery(sql);
        boolean a = res.next();
        res.close();
        stmt.close();
        conn.close();
        
        return a;
		
	}
	
	public boolean testInsertCustomer() throws SQLException {
		String sql = "INSERT INTO customer VALUES (?,?,?,?,?,?,?,?,?,?)";
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        ResultSet res;
        res = stmt.executeQuery(sql);
        boolean a = res.next();
        res.close();
        stmt.close();
        conn.close();
        
        return a;
		
	}

}
