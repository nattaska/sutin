/*
 * Created on 9 �.�. 2548
 *
 */
package com.insurance.manage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.insurance.entity.Customer;
import com.insurance.entity.CustomerPage;
import com.insurance.entity.Fire;
import com.insurance.entity.License;
import com.insurance.entity.Life;
import com.standard.STDException;
import com.standard.db.DBControl;
import com.standard.util.StringUtil;

public class CustomerManager extends DBControl {
	public static int INSERT=1; 
	public static int UPDATE=2; 
	
	private int getMaxID(int custid) throws STDException {
		String sql = ""; 
		
		if (custid != -1) {
			sql = "select max(fireid) id from fire where custid="+custid;
			
		} else {
			sql = "select max(custid) id from customer ";
		} 
		int maxId=0;
        try
        {
//        	System.out.println(sql);
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);
            
            if (res.next()) 
            	maxId = res.getInt("ID");
            else
            	maxId = 0;
            
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return maxId;
	}
	
	private int getMaxYear(int custid,String param,int year, String type) throws STDException {
		String sql = ""; 
		
		if (type.equals("L")) {
			sql = "select max(year) year from license where custid="+custid+" and license='"+param+"' and year!="+year;
			
		} else if (type.equals("F")) {
			sql = "select max(year) year from fire where custid="+custid+" and year!="+year;
		} else if (type.equals("LF")) {
			sql = "select max(year) year from life where custid="+custid+" and year!="+year;
		} 
		int maxYear=0;
        try
        {
//        	System.out.println(sql);
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);
            
            if (res.next()) 
            	maxYear = res.getInt("YEAR");
            else
            	maxYear = 0;
            
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return maxYear;
	}

    public Vector searchCustomer(CustomerPage cust) throws STDException, IOException
    {
        Vector<CustomerPage> entities = new Vector<CustomerPage>(0);
        String sql = "SELECT c.custid, getParName(3,c.prefix) prefix, c.name name, \n" +
        			 "		 c.province,getParName(1,c.province) provincename, \n" +
        			 "		 c.tel,c.address,c.zipcode, \n" +
        			 "		 l.license,l.brandid, l.carmonth,l.vatmonth,f.fmonth \n" +
        			 "FROM customer c left join fire f on c.custid =f.custid \n" +
        			 "	   left join license l on c.custid =l.custid \n" +
        			 "WHERE 1=1 \n";
        if(cust.getCustId() != -1)
            sql = sql + "AND custid = " + cust.getCustId() + " \n";
        if(cust.getName() != null && !cust.getName().equals(""))
            sql = sql + "AND NAME LIKE '%" + StringUtil.Unicode2ASCII(cust.getName().trim()) + "%' \n"; 
        if(cust.getProvince() != -1)
            sql = sql + "AND PROVINCE = " + cust.getProvince() + " \n";        
        if(cust.getLicense() != null && !cust.getLicense().equals(""))
            sql = sql + "AND LICENSE LIKE '%" + StringUtil.Unicode2ASCII(cust.getLicense().trim()) + "%' \n";
        sql = sql + "ORDER BY c.custid";
//        System.out.println(sql);
        
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            CustomerPage entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new CustomerPage();
            	entity.setCustId(res.getInt("CUSTID"));
            	entity.setPrefixName(StringUtil.encode2Thai(res.getString("PREFIX")));
            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));	
            	entity.setLicense(res.getString("LICENSE")==null?null:StringUtil.encode2Thai(res.getString("LICENSE")));
            	entity.setCar(res.getString("CARMONTH")==null?null:res.getString("CARMONTH"));
            	entity.setVat(res.getString("VATMONTH")==null?null:(res.getString("VATMONTH")));
            	entity.setFire(res.getString("FMONTH")==null?null:(res.getString("FMONTH")));
            	entity.setTel(res.getString("TEL")==null?null:StringUtil.encode2Thai(res.getString("TEL")));
            	entity.setAddress(res.getString("ADDRESS")==null?null:StringUtil.encode2Thai(res.getString("ADDRESS")));
            	entity.setBrand(res.getInt("BRANDID"));
            	entity.setProvince(res.getInt("PROVINCE"));
            	entity.setProvinceName(StringUtil.encode2Thai(res.getString("PROVINCENAME")));
            	entity.setZipCode(res.getInt("ZIPCODE"));
            }

            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
        	e.printStackTrace();
            throw new STDException("Data not found");
        }
        return entities;
    }

    public Vector searchCustomerPage(CustomerPage cust,int type,String month) throws STDException, IOException
    {
        Vector<CustomerPage> entities = new Vector<CustomerPage>(0);
        String mainSql = "( " +
        				"select c.custid,c.name,c.prefix,c.province from customer c  \n" +
				        "where c.custid in (select l.custid  \n" +
				        "                   from license l  \n" +
				        "                   where l.active=1 \n";
        if(cust.getLicense() != null && cust.getLicense().length() > 0)
        	mainSql = mainSql + "and l.license LIKE '%" + StringUtil.Unicode2ASCII(cust.getLicense().trim()) + "%' \n";
        
        if (type == Customer.VAT) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.vatmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.vatmonth is not null \n";
        	}
        } else if (type == Customer.ACT) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.actmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.actmonth is not null \n";
        	}
        } else if (type == Customer.CAR) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.carmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.carmonth is not null \n";
        	}
        } else if (type == Customer.CHK) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.chkmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.chkmonth is not null \n";
        	}
        } else if (type == Customer.ALL) {
        	if (month != null && !month.equals("00")) {
        	mainSql = mainSql+"and (substr(l.carmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.vatmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.chkmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.actmonth,4,2) = '"+month+"') \n";
        	}
        }
        mainSql = mainSql+") \n ";
		mainSql = mainSql+"or c.custid in (select f.custid from fire f where f.active=1  \n";
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(f.fmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and f.fmonth is not null \n";
        	}
        }
        mainSql = mainSql+")";
        mainSql = mainSql+"or c.custid in (select lf.custid from life lf where lf.active=1  \n";
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(lf.lifemonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and lf.lifemonth is not null \n";
        	}
        }
        mainSql = mainSql+") \n";
        mainSql = mainSql+")";
        //"SELECT c.custid, getParName(3,c.prefix) prefix, c.name,c.province,getParName(1,c.province) provincename, \n" +
		// "		 l.license, l.carmonth,l.vatmonth,l.actmonth,f.fmonth,lf.lifemonth \n" +
        String sql = "select ll.custid,getParName(3,ll.prefix) prefix,ll.name,ll.province,getParName(1,ll.province) provincename,\n" +
        			 "ll.license,ll.carmonth,ll.vatmonth,ll.actmonth,ll.chkmonth,ff.fmonth,ee.lifemonth from  \n" +
			        "( \n" +
			        "select cx.custid,cx.prefix,cx.name,cx.province,lx.license,lx.carmonth,lx.vatmonth,lx.actmonth,lx.chkmonth from \n" +
			        mainSql+" cx left join license lx on cx.custid=lx.custid and lx.active=1 \n" +
			        ") ll, \n" +
			        "( \n" +
			        "select cx.custid,fx.fmonth from \n" +
			        //"( \n" +
			        mainSql+" cx left join fire fx on cx.custid=fx.custid and fx.active=1 \n" +
			        ") ff, \n" +
			        "( \n" +
			        "select cx.custid,ex.lifemonth from \n" +
			        //"( \n" +
			        mainSql+" cx left join life ex on cx.custid=ex.custid and ex.active=1) ee \n" +
			        "where ll.custid=ff.custid \n" +
			        "and ll.custid=ee.custid \n" ;
        
        if(cust.getLicense() != null && cust.getLicense().length() > 0)
        	sql = sql + "and ll.license LIKE '%" + StringUtil.Unicode2ASCII(cust.getLicense().trim()) + "%' \n";
        
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ff.fmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ff.fmonth is not null \n";
        } else if (type == Customer.ALL) {
        	if (month != null && !month.equals("00")) {
        		sql = sql + "and (substr(ll.carmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.vatmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.actmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.chkmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ff.fmonth,4,2) = '"+month+"' \n"+
							"	  or substr(ee.lifemonth,4,2) = '"+month+"') \n";
        	} 
        } else if (type == Customer.CAR) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.carmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.carmonth is not null \n";
        } else if (type == Customer.LIFE) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ee.lifemonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ee.lifemonth is not null \n";
        } else if (type == Customer.VAT) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.vatmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.vatmonth is not null \n";        		
        } else if (type == Customer.ACT) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.actmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.actmonth is not null \n";
        } else if (type == Customer.CHK) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.chkmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.chkmonth is not null \n";
        }
        
        if(cust.getCustId() != -1)
            sql = sql + "AND ll.custid = " + cust.getCustId() + " \n";

        if(cust.getName() != null && cust.getName().length() > 0)
            sql = sql + "AND ll.name LIKE '%" + StringUtil.Unicode2ASCII(cust.getName().trim()) + "%' \n";
               
        if(cust.getProvince() != -1)
            sql = sql + "AND ll.province = " + cust.getProvince() + " \n";
        sql = sql + "ORDER BY ll.name,ll.license";
//        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            CustomerPage entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new CustomerPage();
            	entity.setCustId(res.getInt("CUSTID"));
            	entity.setPrefixName(StringUtil.encode2Thai(res.getString("PREFIX")));
            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));	
            	entity.setProvinceName(StringUtil.encode2Thai(res.getString("PROVINCENAME")));
            	entity.setLicense(res.getString("LICENSE")==null?null:StringUtil.encode2Thai(res.getString("LICENSE")));
            	entity.setCar(res.getString("CARMONTH")==null?null:(res.getString("CARMONTH")));	
            	entity.setVat(res.getString("VATMONTH")==null?null:(res.getString("VATMONTH")));
            	entity.setAct(res.getString("ACTMONTH")==null?null:(res.getString("ACTMONTH")));
            	entity.setFire(res.getString("FMONTH")==null?null:(res.getString("FMONTH")));
            	entity.setLife(res.getString("LIFEMONTH")==null?null:(res.getString("LIFEMONTH")));
            	entity.setChk(res.getString("CHKMONTH")==null?null:(res.getString("CHKMONTH")));
            }

            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
        	
            throw new STDException("Data not found");
        }
        return entities;
    }

    public String searchCustomerPageString(CustomerPage cust,int type,String month) throws STDException, IOException
    {
        Vector<CustomerPage> entities = new Vector<CustomerPage>(0);
        String mainSql = "( " +
        				"select c.custid,c.name,c.prefix,c.province from customer c  \n" +
				        "where c.custid in (select l.custid  \n" +
				        "                   from license l  \n" +
				        "                   where l.active=1 \n";
        if(cust.getLicense() != null && cust.getLicense().length() > 0)
        	mainSql = mainSql + "and l.license LIKE '%" + StringUtil.Unicode2ASCII(cust.getLicense().trim()) + "%' \n";
        
        if (type == Customer.VAT) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.vatmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.vatmonth is not null \n";
        	}
        } else if (type == Customer.ACT) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.actmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.actmonth is not null \n";
        	}
        } else if (type == Customer.CAR) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.carmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.carmonth is not null \n";
        	}
        } else if (type == Customer.CHK) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(l.chkmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and l.chkmonth is not null \n";
        	}
        } else if (type == Customer.ALL) {
        	if (month != null && !month.equals("00")) {
        	mainSql = mainSql+"and (substr(l.carmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.vatmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.chkmonth,4,2) = '"+month+"'  \n" +
						      "or substr(l.actmonth,4,2) = '"+month+"') \n";
        	}
        }
        mainSql = mainSql+") \n ";
		mainSql = mainSql+"or c.custid in (select f.custid from fire f where f.active=1  \n";
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(f.fmonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and f.fmonth is not null \n";
        	}
        }
        mainSql = mainSql+")";
        mainSql = mainSql+"or c.custid in (select lf.custid from life lf where lf.active=1  \n";
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) {
        		mainSql = mainSql + "and substr(lf.lifemonth,4,2) = '"+month+"' \n";
        	} else {
        		mainSql = mainSql + "and lf.lifemonth is not null \n";
        	}
        }
        mainSql = mainSql+") \n";
        mainSql = mainSql+")";
        //"SELECT c.custid, getParName(3,c.prefix) prefix, c.name,c.province,getParName(1,c.province) provincename, \n" +
		// "		 l.license, l.carmonth,l.vatmonth,l.actmonth,f.fmonth,lf.lifemonth \n" +
        String sql = "select ll.custid,getParName(3,ll.prefix) prefix,ll.name,ll.province,getParName(1,ll.province) provincename,\n" +
        			 "ll.license,ll.carmonth,ll.vatmonth,ll.actmonth,ll.chkmonth,ff.fmonth,ee.lifemonth from  \n" +
			        "( \n" +
			        "select cx.custid,cx.prefix,cx.name,cx.province,lx.license,lx.carmonth,lx.vatmonth,lx.actmonth,lx.chkmonth from \n" +
			        mainSql+" cx left join license lx on cx.custid=lx.custid and lx.active=1 \n" +
			        ") ll, \n" +
			        "( \n" +
			        "select cx.custid,fx.fmonth from \n" +
			        //"( \n" +
			        mainSql+" cx left join fire fx on cx.custid=fx.custid and fx.active=1 \n" +
			        ") ff, \n" +
			        "( \n" +
			        "select cx.custid,ex.lifemonth from \n" +
			        //"( \n" +
			        mainSql+" cx left join life ex on cx.custid=ex.custid and ex.active=1) ee \n" +
			        "where ll.custid=ff.custid \n" +
			        "and ll.custid=ee.custid \n" ;
        
        if(cust.getLicense() != null && cust.getLicense().length() > 0)
        	sql = sql + "and ll.license LIKE '%" + StringUtil.Unicode2ASCII(cust.getLicense().trim()) + "%' \n";
        
        if (type == Customer.FIRE) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ff.fmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ff.fmonth is not null \n";
        } else if (type == Customer.ALL) {
        	if (month != null && !month.equals("00")) {
        		sql = sql + "and (substr(ll.carmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.vatmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.actmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ll.chkmonth,4,2) = '"+month+"' \n" +
							"	  or substr(ff.fmonth,4,2) = '"+month+"' \n"+
							"	  or substr(ee.lifemonth,4,2) = '"+month+"') \n";
        	} 
        } else if (type == Customer.CAR) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.carmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.carmonth is not null \n";
        } else if (type == Customer.LIFE) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ee.lifemonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ee.lifemonth is not null \n";
        } else if (type == Customer.VAT) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.vatmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.vatmonth is not null \n";        		
        } else if (type == Customer.ACT) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.actmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.actmonth is not null \n";
        } else if (type == Customer.CHK) {
        	if (month != null && !month.equals("00")) 
        		sql = sql + "and substr(ll.chkmonth,4,2) = '"+month+"' \n";
        	else
        		sql = sql + "and ll.chkmonth is not null \n";
        }
        
        if(cust.getCustId() != -1)
            sql = sql + "AND ll.custid = " + cust.getCustId() + " \n";

        if(cust.getName() != null && cust.getName().length() > 0)
            sql = sql + "AND ll.name LIKE '%" + StringUtil.Unicode2ASCII(cust.getName().trim()) + "%' \n";
               
        if(cust.getProvince() != -1)
            sql = sql + "AND ll.province = " + cust.getProvince() + " \n";
        sql = sql + "ORDER BY ll.name,ll.license";
//        System.out.println(sql);
//        try
//        {
//            Connection conn = getConnection();
//            Statement stmt = conn.createStatement();
//            ResultSet res;
//            CustomerPage entity = null;
//            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
//            {
//            	entity = new CustomerPage();
//            	entity.setCustId(res.getInt("CUSTID"));
//            	entity.setPrefixName(StringUtil.encode2Thai(res.getString("PREFIX")));
//            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));	
//            	entity.setProvinceName(StringUtil.encode2Thai(res.getString("PROVINCENAME")));
//            	entity.setLicense(res.getString("LICENSE")==null?null:StringUtil.encode2Thai(res.getString("LICENSE")));
//            	entity.setCar(res.getString("CARMONTH")==null?null:(res.getString("CARMONTH")));	
//            	entity.setVat(res.getString("VATMONTH")==null?null:(res.getString("VATMONTH")));
//            	entity.setAct(res.getString("ACTMONTH")==null?null:(res.getString("ACTMONTH")));
//            	entity.setFire(res.getString("FMONTH")==null?null:(res.getString("FMONTH")));
//            	entity.setLife(res.getString("LIFEMONTH")==null?null:(res.getString("LIFEMONTH")));
//            	entity.setChk(res.getString("CHKMONTH")==null?null:(res.getString("CHKMONTH")));
//            }
//
//            res.close();
//            stmt.close();
//            conn.close();
//        }
//        catch(SQLException e)
//        {
//        	
//            throw new STDException("Data not found");
//        }
        return sql;
    }

    public Customer getCustomer(int custId) throws STDException, IOException
    {
		Connection conn = null;
		Statement cStmt = null;
		Statement lStmt = null;
		Statement fStmt = null;
		Statement lfStmt = null;
        ResultSet cRes = null;
        ResultSet lRes = null;
        ResultSet fRes = null;
        ResultSet lfRes = null;
		
        Customer cEntity = null;
        License lEntity = null;
        Fire fEntity = null;
        Life lfEntity = null;
        
        String cSql  = "SELECT custid,prefix,name,tel,address,province,getParName(1,province) provincename,zipcode from customer \n";
        String fSql  = "SELECT custid,year,ifnull(insurer,-1) insurer,fmonth,ifnull(fireprice,-1) fireprice,firepic,active from fire \n";
        String lfSql = "SELECT custid,year,ifnull(insurer,-1) insurer,lifemonth,ifnull(lifeprice,-1) lifeprice,lifepic,active from life \n";
        String lSql  = "SELECT custid,license,year,ifnull(brandid,-1) brandid,ifnull(ltype,-1) ltype, \n" +
        			   "		  ifnull(lcomp,-1) lcomp,ifnull(lact,-1) lact, \n" +
        			   "		  carmonth,vatmonth,actmonth,chkmonth, ifnull(carprice,-1) carprice, \n" +
        			   "		  ifnull(vatprice,-1) vatprice,ifnull(actprice,-1) actprice, \n" +
        			   "		  ifnull(chkprice,-1) chkprice,ifnull(vatservice,-1) vatservice, \n" +
        			   "		  vatpic,carpic,actpic,chkpic,comment,active " +
        			   "FROM license \n";
		String where = "WHERE custid = " + custId + " \n";
		String order = "order by year desc\n";
        try
        {
            conn = getConnection();
            cStmt = conn.createStatement();
            lStmt = conn.createStatement();
            fStmt = conn.createStatement();
            lfStmt = conn.createStatement();
            Vector<License> licenses = new Vector<License>();
            Vector<Fire> fires = new Vector<Fire>();
            Vector<Life> lives = new Vector<Life>();
            cRes = cStmt.executeQuery(cSql+where);
            lRes = lStmt.executeQuery(lSql+where+order);
            fRes = fStmt.executeQuery(fSql+where+order);
            lfRes = lfStmt.executeQuery(lfSql+where+order);
//    		System.out.println(cSql+where);
            while (cRes.next()) {
            	cEntity = new Customer();
            	cEntity.setCustId(cRes.getInt("CUSTID"));
            	cEntity.setPrefix(cRes.getInt("PREFIX"));
            	cEntity.setName(StringUtil.encode2Thai(cRes.getString("NAME")));
            	cEntity.setTel(cRes.getString("TEL")==null?null:StringUtil.encode2Thai(cRes.getString("TEL")));
            	cEntity.setAddress(cRes.getString("ADDRESS")==null?null:StringUtil.encode2Thai(cRes.getString("ADDRESS")));
            	cEntity.setProvince(cRes.getInt("PROVINCE"));
            	cEntity.setProvinceName(StringUtil.encode2Thai(cRes.getString("PROVINCENAME")));
            	cEntity.setZipCode(cRes.getInt("ZIPCODE"));

//        		System.out.println(lSql+where+order);
                while (lRes.next()) {
                	lEntity = new License();
                	lEntity.setCustId(lRes.getInt("CUSTID"));
                	lEntity.setLicense(lRes.getString("LICENSE")==null?null:StringUtil.encode2Thai(lRes.getString("LICENSE")));        	
                	lEntity.setYear(lRes.getInt("YEAR"));
                	lEntity.setCar(lRes.getString("CARMONTH")==null?null:lRes.getString("CARMONTH"));
                	lEntity.setVat(lRes.getString("VATMONTH")==null?null:(lRes.getString("VATMONTH")));
                	lEntity.setAct(lRes.getString("ACTMONTH")==null?null:(lRes.getString("ACTMONTH")));  
                	lEntity.setChk(lRes.getString("CHKMONTH")==null?null:(lRes.getString("CHKMONTH")));            	
                	lEntity.setBrand(lRes.getInt("BRANDID"));
                	lEntity.setLtype(lRes.getInt("LTYPE"));
                	lEntity.setLcomp(lRes.getInt("LCOMP"));
                	lEntity.setLact(lRes.getInt("LACT"));
                	lEntity.setCarPrice(lRes.getDouble("CARPRICE"));
                	lEntity.setVatPrice(lRes.getDouble("VATPRICE"));
                	lEntity.setActPrice(lRes.getDouble("ACTPRICE"));
                	lEntity.setChkPrice(lRes.getDouble("CHKPRICE")); 
                	lEntity.setCarPic(lRes.getString("CARPIC")==null?null:lRes.getString("CARPIC"));
                	lEntity.setVatPic(lRes.getString("VATPIC")==null?null:(lRes.getString("VATPIC")));
                	lEntity.setActPic(lRes.getString("ACTPIC")==null?null:(lRes.getString("ACTPIC")));  
                	lEntity.setChkPic(lRes.getString("CHKPIC")==null?null:(lRes.getString("CHKPIC")));
                	lEntity.setVatService(lRes.getDouble("VATSERVICE"));
                	lEntity.setComment(lRes.getString("COMMENT")==null?"":StringUtil.encode2Thai(lRes.getString("COMMENT")));
                	lEntity.setActive(lRes.getInt("ACTIVE"));
                    licenses.add(lEntity);
                }
            	cEntity.setLicenses(licenses);

//        		System.out.println(fSql+where+order);
                while (fRes.next()) {
                	fEntity = new Fire();
                	fEntity.setCustId(fRes.getInt("CUSTID"));
                	fEntity.setYear(fRes.getInt("YEAR"));
                	fEntity.setInsurer(fRes.getInt("INSURER"));
                	fEntity.setFire(fRes.getString("FMONTH")==null?null:(fRes.getString("FMONTH")));
                	fEntity.setFirePrice(fRes.getDouble("FIREPRICE"));
                	fEntity.setFirePic(fRes.getString("FIREPIC")==null?null:fRes.getString("FIREPIC"));
                	fEntity.setActive(fRes.getInt("ACTIVE"));
                    fires.add(fEntity);
                }
            	cEntity.setFire(fires);

//        		System.out.println(lfSql+where+order);
                while (lfRes.next()) {
                	lfEntity = new Life();
                	lfEntity.setCustId(lfRes.getInt("CUSTID"));
                	lfEntity.setYear(lfRes.getInt("YEAR"));
                	lfEntity.setInsurer(lfRes.getInt("INSURER"));
                	lfEntity.setLife(lfRes.getString("LIFEMONTH")==null?null:(lfRes.getString("LIFEMONTH")));
                	lfEntity.setLifePrice(lfRes.getDouble("LIFEPRICE"));
                	lfEntity.setLifePic(lfRes.getString("LIFEPIC")==null?null:lfRes.getString("LIFEPIC"));
                	lfEntity.setActive(lfRes.getInt("ACTIVE"));
                    lives.add(lfEntity);
                }
            	cEntity.setLives(lives);
            }

            cRes.close();
            lRes.close();
            fRes.close();
            lfRes.close();
            cStmt.close();
            lStmt.close();
            fStmt.close();
            lfStmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
        	e.printStackTrace();
            throw new STDException("Data not found");
        }
        finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(cStmt != null) {
        			cStmt.close();
        		}
        		if(lStmt != null) {
        			lStmt.close();
        		}
        		if(fStmt != null) {
        			fStmt.close();
        		}
        		if(lfStmt != null) {
        			lfStmt.close();
        		}
        		if(cRes != null) {
        			cRes.close();
        		}
        		if(lRes != null) {
        			lRes.close();
        		}
        		if(fRes != null) {
        			fRes.close();
        		}
        		if(lfRes != null) {
        			lfRes.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
        return cEntity;
    }
	
	public String insertFire(CustomerPage cust) throws STDException
	{
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            if (cust.getFire() != null && !cust.getFire().equals("") && cust.getYear() != 0) {
                stmt.executeUpdate(this.getFireStatement(cust,CustomerManager.INSERT));
           		stmt.executeUpdate(this.updateStatusFire(cust, 1));
           		stmt.executeUpdate(this.updateStatusFire(cust, 0));
            } else {
            	return "!!!\t��س����������ѹ��� ��л��������\t!!!";
            }
            
    		conn.commit();
        }
        catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        }finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(stmt != null) {
        			stmt.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
		return "Insert Fire Completed";
	}
	
	public String insertLife(CustomerPage cust) throws STDException
	{
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            if (cust.getLife() != null && !cust.getLife().equals("") && cust.getYear() != 0) {
                stmt.executeUpdate(this.getLifeStatement(cust,CustomerManager.INSERT));
           		stmt.executeUpdate(this.updateStatusLife(cust, 1));
           		stmt.executeUpdate(this.updateStatusLife(cust, 0));
            } else {
            	return "!!!\t��س����������ѹ��� ��л��������\t!!!";
            }
            
    		conn.commit();
        }
        catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        }finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(stmt != null) {
        			stmt.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
		return "Insert Life Completed";
	}
	
	public String insertLicense(CustomerPage cust) throws STDException
	{
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            stmt = conn.createStatement(); 
            if (cust.getLicense() != null && !cust.getLicense().equals("") && cust.getYear() != 0) {
                stmt.executeUpdate(this.getLicenseStatement(cust,CustomerManager.INSERT));
           		stmt.executeUpdate(this.updateStatusLicense(cust, 1));
           		stmt.executeUpdate(this.updateStatusLicense(cust, 0));
            } else {
            	return "!!!\t��س��������ŷ���¹ö ��л��������\t!!!";
            }
            
    		conn.commit();
        }
        catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        }finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(stmt != null) {
        			stmt.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
		return "Insert License Completed";
	}
	
	public String insertCustomer(CustomerPage cust) throws STDException
	{
		int maxId = this.getMaxID(-1);
		cust.setCustId(maxId+1);
		StringBuffer sqlbuff = new StringBuffer();
		sqlbuff.append("INSERT INTO customer (custid,prefix,name,tel,address,province,zipcode,creby,credate,updby,upddate) \n");
		sqlbuff.append("VALUES("+cust.getCustId());
		sqlbuff.append(" , "+(cust.getPrefix()==-1?null:cust.getPrefix()));
		sqlbuff.append(" , '"+(cust.getName()==""?null:StringUtil.Unicode2ASCII(cust.getName()))+"'");
		sqlbuff.append(" , '"+(cust.getTel()==""?null:StringUtil.Unicode2ASCII(cust.getTel()))+"'");
		sqlbuff.append(" , '"+(cust.getAddress()==""?null:StringUtil.Unicode2ASCII(cust.getAddress()))+"' ");
		sqlbuff.append(" , "+(cust.getProvince()==-1?null:cust.getProvince()));
		sqlbuff.append(" , "+(cust.getZipCode()==0?null:cust.getZipCode()));
		sqlbuff.append(" , '"+StringUtil.Unicode2ASCII(cust.getCreBy())+"'");
		sqlbuff.append(" , now()");
		sqlbuff.append(" , '"+StringUtil.Unicode2ASCII(cust.getUpdBy())+"'");
		sqlbuff.append(" , now()) \n");
//		System.out.println(sqlbuff.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sqlbuff.toString());
//            if (cust.getLicense() != null && !cust.getLicense().equals("")) {
//                stmt.executeUpdate(this.getLicenseStatement(cust,CustomerManager.INSERT));
//            }
//            
//    		if (cust.getFire() != null && !cust.getFire().equals("")) {
//                stmt.executeUpdate(this.getFireStatement(cust,CustomerManager.INSERT));
//            }
    		
    		conn.commit();
        }
        catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        }finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(stmt != null) {
        			stmt.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
    		
        return cust.getCustId()+":Insert Completed";
	}
	
	public String getLicenseStatement(CustomerPage cust,int type) throws STDException
	{
		StringBuffer carSql = new StringBuffer();
		if (type == CustomerManager.INSERT) {			
			carSql.append("INSERT INTO license (custid,license,year,brandid,ltype,lcomp,lact,carmonth,vatmonth,actmonth,chkmonth,carprice,vatprice,actprice,chkprice,vatservice,comment,creby,credate,updby,upddate) \n");
			carSql.append(" VALUES("+ cust.getCustId());
			carSql.append(" , '"+(cust.getLicense().equals("")?null:StringUtil.Unicode2ASCII(cust.getLicense()))+"' ");
			carSql.append(" , "+cust.getYear());
			carSql.append(" , "+(cust.getBrand()==-1?"null":cust.getBrand()));
			carSql.append(" , "+(cust.getLtype()==-1?"null":cust.getLtype()));
			carSql.append(" , "+(cust.getLcomp()==-1?"null":cust.getLcomp()));
			carSql.append(" , "+(cust.getLact()==-1?"null":cust.getLact()));
			if (cust.getCar().equals("")||cust.getCar().equals("00")) {
				carSql.append(" , null ");
			} else {
				carSql.append(" , '"+(StringUtil.Unicode2ASCII(cust.getCar()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getVat().equals("")||cust.getVat().equals("00")) {
				carSql.append(" , null ");
			} else {
				carSql.append(" , '"+(StringUtil.Unicode2ASCII(cust.getVat()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getAct().equals("")||cust.getAct().equals("00")) {
				carSql.append(" , null ");
			} else {
				carSql.append(" , '"+(StringUtil.Unicode2ASCII(cust.getAct()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getChk().equals("")||cust.getChk().equals("00")) {
				carSql.append(" , null ");
			} else {
				carSql.append(" , '"+(StringUtil.Unicode2ASCII(cust.getChk()))+"/"+cust.getYear()+"' ");
			}
			carSql.append(" , "+(cust.getCarPrice()==-1?"null":cust.getCarPrice()));
			carSql.append(" , "+(cust.getVatPrice()==-1?"null":cust.getVatPrice()));
			carSql.append(" , "+(cust.getActPrice()==-1?"null":cust.getActPrice()));
			carSql.append(" , "+(cust.getChkPrice()==-1?"null":cust.getChkPrice()));
			carSql.append(" , "+(cust.getVatService()==-1?"null":cust.getVatService()));
			carSql.append(" , '"+(cust.getComment().equals("")?null:StringUtil.Unicode2ASCII(cust.getComment()))+"' ");
			carSql.append(" , '"+StringUtil.Unicode2ASCII(cust.getCreBy())+"' ");
			carSql.append(" , now() ");
			carSql.append(" , '"+StringUtil.Unicode2ASCII(cust.getUpdBy())+"' ");
			carSql.append(" , now()) ");
		} else {
			carSql.append("UPDATE license \n ");
			carSql.append("SET BRANDID = "+(cust.getBrand()==-1?"null":cust.getBrand())+" \n");
			carSql.append("	   ,ltype = "+(cust.getLtype()==-1?"null":cust.getLtype())+" \n");
			carSql.append("	   ,lcomp = "+(cust.getLcomp()==-1?"null":cust.getLcomp())+" \n");
			carSql.append("	   ,lact = "+(cust.getLact()==-1?"null":cust.getLact())+" \n");
			if (cust.getCar().equals("")||cust.getCar().equals("00")) {
				carSql.append("	   ,carmonth=null \n ");
			} else {
				carSql.append(", carmonth='"+(StringUtil.Unicode2ASCII(cust.getCar()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getVat().equals("")||cust.getVat().equals("00")) {
				carSql.append(",vatmonth=null \n ");
			} else {
				carSql.append(" , vatmonth='"+(StringUtil.Unicode2ASCII(cust.getVat()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getAct().equals("")||cust.getAct().equals("00")) {
				carSql.append(",actmonth=null \n ");
			} else {
				carSql.append(",actmonth='"+(StringUtil.Unicode2ASCII(cust.getAct()))+"/"+cust.getYear()+"' ");
			}
			if (cust.getChk().equals("")||cust.getChk().equals("00")) {
				carSql.append(",chkmonth=null \n ");
			} else {
				carSql.append(",chkmonth='"+(StringUtil.Unicode2ASCII(cust.getChk()))+"/"+cust.getYear()+"' ");
			}
			carSql.append(",carprice="+(cust.getCarPrice()==-1?"null":cust.getCarPrice()));
			carSql.append(",vatprice="+(cust.getVatPrice()==-1?"null":cust.getVatPrice()));
			carSql.append(",actprice="+(cust.getActPrice()==-1?"null":cust.getActPrice()));
			carSql.append(",chkprice="+(cust.getChkPrice()==-1?"null":cust.getChkPrice()));
			carSql.append(",vatservice="+(cust.getVatService()==-1?"null":cust.getVatService()));
			carSql.append(",comment='"+(cust.getComment().equals("")?null:StringUtil.Unicode2ASCII(cust.getComment()))+"' \n");
			carSql.append(",updby='"+StringUtil.Unicode2ASCII(cust.getCreBy())+"' \n ");
			carSql.append(",upddate= now() \n ");
			carSql.append("WHERE custid="+cust.getCustId()+" \n");
			carSql.append("AND license='"+StringUtil.Unicode2ASCII(cust.getLicense())+"' \n");
			carSql.append("AND year="+cust.getYear()+" \n");
		}
//			System.out.println(carSql);
			
        return carSql.toString();
	}

	public String getFireStatement(CustomerPage cust,int type) throws STDException
	{	
		StringBuffer fireSql = new StringBuffer();
		if (type == CustomerManager.INSERT) {
			fireSql.append("INSERT INTO fire (custid,year,insurer,fmonth,fireprice,creby,credate,updby,upddate) \n" );
			fireSql.append("VALUES("+ cust.getCustId());
			fireSql.append(" , "+cust.getYear());
			fireSql.append(" , "+(cust.getFireInsurer()==-1?"null":cust.getFireInsurer()));
			if (cust.getFire().equals("")||cust.getFire().equals("00"))
				fireSql.append(" , null ");
			else
				fireSql.append(" ,'"+(cust.getFire())+"/"+cust.getYear()+"'");
			fireSql.append(" , "+(cust.getFirePrice()==-1?"null":cust.getFirePrice()));
			fireSql.append(" ,'"+(StringUtil.Unicode2ASCII(cust.getCreBy()))+"'");
			fireSql.append(" ,now()" );
			fireSql.append(" ,'"+(StringUtil.Unicode2ASCII(cust.getUpdBy()))+"'" );
			fireSql.append(" ,now())" );
//			System.out.println(fireSql);
		} else {
			fireSql.append("UPDATE fire SET \n ");
			if (cust.getFire().equals("")||cust.getFire().equals("00")) {
				fireSql.append("fmonth=null \n ");
			} else {
				fireSql.append(" fmonth='"+(StringUtil.Unicode2ASCII(cust.getFire()))+"/"+cust.getYear()+"' \n");
			}
			fireSql.append(",insurer = "+(cust.getFireInsurer()==-1?"null":cust.getFireInsurer())+" \n");			
			fireSql.append(",fireprice="+(cust.getFirePrice()==-1?"null":cust.getFirePrice())+" \n");
			fireSql.append(",updby='"+(StringUtil.Unicode2ASCII(cust.getUpdBy()))+"' \n ");
			fireSql.append(",upddate= now() \n ");
			fireSql.append("WHERE custid="+cust.getCustId());
			fireSql.append(" AND year="+cust.getYear());
		}
			
	    return fireSql.toString();
	}

	public String getLifeStatement(CustomerPage cust,int type) throws STDException
	{	
		StringBuffer lifeSql = new StringBuffer();
		if (type == CustomerManager.INSERT) {
			lifeSql.append("INSERT INTO life (custid,year,insurer,lifemonth,lifeprice,creby,credate,updby,upddate) \n" );
			lifeSql.append("VALUES("+ cust.getCustId());
			lifeSql.append(" , "+cust.getYear());
			lifeSql.append(" , "+(cust.getLifeInsurer()==-1?"null":cust.getLifeInsurer()));
			if (cust.getLife().equals("")||cust.getLife().equals("00"))
				lifeSql.append(" , null ");
			else
				lifeSql.append(" ,'"+(cust.getLife())+"/"+cust.getYear()+"'");
			lifeSql.append(" , "+(cust.getLifePrice()==-1?"null":cust.getLifePrice()));
			lifeSql.append(" ,'"+(StringUtil.Unicode2ASCII(cust.getCreBy()))+"'");
			lifeSql.append(" ,now()" );
			lifeSql.append(" ,'"+(StringUtil.Unicode2ASCII(cust.getUpdBy()))+"'" );
			lifeSql.append(" ,now())" );
		} else {
			lifeSql.append("UPDATE life SET \n ");
			if (cust.getLife().equals("")||cust.getLife().equals("00")) {
				lifeSql.append("lifemonth=null \n ");
			} else {
				lifeSql.append(" lifemonth='"+(StringUtil.Unicode2ASCII(cust.getLife()))+"/"+cust.getYear()+"' \n");
			}			
			lifeSql.append(",insurer = "+(cust.getLifeInsurer()==-1?"null":cust.getLifeInsurer())+" \n");
			lifeSql.append(",lifeprice="+(cust.getLifePrice()==-1?"null":cust.getLifePrice())+" \n");
			lifeSql.append(",updby='"+(StringUtil.Unicode2ASCII(cust.getUpdBy()))+"' \n ");
			lifeSql.append(",upddate= now() \n ");
			lifeSql.append("WHERE custid="+cust.getCustId());
			lifeSql.append(" AND year="+cust.getYear());
		}
//		System.out.println(lifeSql);
			
	    return lifeSql.toString();
	}
	
	public String updateCustomer(CustomerPage cust) throws STDException
	{
		StringBuffer sqlbuff = new StringBuffer();
		sqlbuff.append("UPDATE customer SET  \n");
		sqlbuff.append("prefix = "+(cust.getPrefix()==-1?null:cust.getPrefix())+" \n");
		sqlbuff.append(",name = '"+(cust.getName()==""?null:StringUtil.Unicode2ASCII(cust.getName()))+"' \n");
		sqlbuff.append(",tel = '"+(cust.getTel()==""?null:StringUtil.Unicode2ASCII(cust.getTel()))+"' \n");
		sqlbuff.append(",address = '"+(cust.getAddress()==""?null:StringUtil.Unicode2ASCII(cust.getAddress()))+"' \n");
		sqlbuff.append(",province = "+(cust.getProvince()==-1?null:cust.getProvince())+" \n");
		sqlbuff.append(",zipcode = "+(cust.getZipCode()==0?null:cust.getZipCode())+" \n");
		sqlbuff.append(",updby = '"+StringUtil.Unicode2ASCII(cust.getUpdBy())+"' \n");
		sqlbuff.append(",upddate = now() \n");
		sqlbuff.append("WHERE custid = "+cust.getCustId()+" \n");
//		System.out.println(sqlbuff.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sqlbuff.toString());
    		conn.commit();
        }
        catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        }finally {
        	try {
        		if(conn != null) {
        			conn.close();
        		}
        		if(stmt != null) {
        			stmt.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }
        return "Update Completed";
	}
	
	public String deleteCustomer(CustomerPage cust)
	{
		String sql = "DELETE FROM customer WHERE custid = "+cust.getCustId()+" \n";
//		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            stmt = conn.createStatement(); 
            stmt.executeUpdate(this.getDeleteFire(cust));
            stmt.executeUpdate(this.getDeleteLicense(cust));
            stmt.executeUpdate(this.getDeleteLife(cust));
            stmt.executeUpdate(sql);
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
        return "Delete Completed";
	}
	
	public String deleteLicense(CustomerPage cust,int type) throws STDException
	{
		String sql = "DELETE FROM license WHERE custid = "+cust.getCustId()+ " \n "+
					 "and license = '"+cust.getLicense()+"' \n" +
		 			 "and year = "+cust.getYear();
//		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sql);
            cust.setYear(this.getMaxYear(cust.getCustId(), cust.getLicense(), cust.getYear(), "L"));
            stmt.executeUpdate(this.updateStatusLicense(cust, 1));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    if (type == Customer.CAR) {
	    	return "Delete License Completed";
	    } else {
	    	return "Delete Completed";
	    }
	}
	
	public String deleteFire(CustomerPage cust,int type) throws STDException
	{
		String sql = "DELETE FROM fire WHERE custid = "+cust.getCustId()+ " \n "+
		 			 "and year = "+cust.getYear();
//		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sql);
            cust.setYear(this.getMaxYear(cust.getCustId(), null, cust.getYear(), "F"));
            stmt.executeUpdate(this.updateStatusFire(cust, 1));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    return "Delete Fire Completed";
	}
	
	public String deleteLife(CustomerPage cust,int type) throws STDException
	{
		String sql = "DELETE FROM life WHERE custid = "+cust.getCustId()+ " \n "+
		 			 "and year = "+cust.getYear();
//		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sql);
            cust.setYear(this.getMaxYear(cust.getCustId(), null, cust.getYear(), "LF"));
            stmt.executeUpdate(this.updateStatusLife(cust, 1));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    return "Delete Life Completed";
	}
	
	public String updateFire(CustomerPage cust,int oldyear) throws STDException
	{
		StringBuffer fireSql = new StringBuffer();
		
        if (cust.getFire() == null || cust.getFire().equals("")) {
        	return "!!!\t��س����������ѹ�������\t!!!";
        }

		fireSql.append("UPDATE fire SET year = "+cust.getYear()+"\n ");
		fireSql.append("WHERE custid="+cust.getCustId()+" \n");
		fireSql.append("AND year="+oldyear+" \n");

//		System.out.println(fireSql.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
       		stmt.executeUpdate(fireSql.toString());
       		stmt.executeUpdate(this.getFireStatement(cust,CustomerManager.UPDATE));
       		stmt.executeUpdate(this.updateStatusFire(cust, 1));
       		stmt.executeUpdate(this.updateStatusFire(cust, 0));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    return "Update Fire Completed";
	}
	
	public String updateLife(CustomerPage cust,int oldyear) throws STDException
	{
		StringBuffer lifeSql = new StringBuffer();
		
        if (cust.getLife() == null || cust.getLife().equals("")) {
        	return "!!!\t��س����������ѹ�������\t!!!";
        }

		lifeSql.append("UPDATE life SET year = "+cust.getYear()+"\n ");
		lifeSql.append("WHERE custid="+cust.getCustId()+" \n");
		lifeSql.append("AND year="+oldyear+" \n");

//		System.out.println(lifeSql.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement();
       		stmt.executeUpdate(lifeSql.toString());
       		stmt.executeUpdate(this.getLifeStatement(cust,CustomerManager.UPDATE));
       		stmt.executeUpdate(this.updateStatusLife(cust, 1));
       		stmt.executeUpdate(this.updateStatusLife(cust, 0));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    return "Update Fire Completed";
	}
	
	public String updateLicense(CustomerPage cust,String oldlicense,int oldyear, int type) throws STDException
	{
		StringBuffer carSql = new StringBuffer();
		
        if (cust.getLicense() == null || cust.getLicense().equals("") || cust.getYear() == 0 ) {
        	return "!!!\t��س��������ŷ���¹ö ��л��������\t!!!";
        }

		carSql.append("UPDATE license \n ");
		carSql.append("SET license = '"+StringUtil.Unicode2ASCII(cust.getLicense())+"' \n");
		carSql.append("	   ,year = "+cust.getYear());
		carSql.append("	   ,BRANDID = "+cust.getBrand());
		if (cust.getCar().equals("")||cust.getCar().equals("00"))
			carSql.append("	   ,carmonth=null \n ");
		else
			carSql.append(", carmonth='"+(StringUtil.Unicode2ASCII(cust.getCar()))+"/"+cust.getYear()+"' ");
		if (cust.getVat().equals("")||cust.getVat().equals("00"))
			carSql.append(",vatmonth=null \n ");
		else
			carSql.append(" , vatmonth='"+(StringUtil.Unicode2ASCII(cust.getVat()))+"/"+cust.getYear()+"' ");
		carSql.append(",updby='"+StringUtil.Unicode2ASCII(cust.getCreBy())+"' \n ");
		carSql.append(",upddate= now() \n ");
		carSql.append("WHERE custid="+cust.getCustId()+" \n");
		carSql.append("AND license='"+StringUtil.Unicode2ASCII(oldlicense)+"' \n");
		carSql.append("AND year="+oldyear+" \n");
//		System.out.println(carSql.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(carSql.toString());
       		stmt.executeUpdate(this.getLicenseStatement(cust,CustomerManager.UPDATE));
       		stmt.executeUpdate(this.updateStatusLicense(cust, 1));
       		stmt.executeUpdate(this.updateStatusLicense(cust, 0));
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	        return "!!!\tError\t!!!";
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	    return "Update License Completed";
	}
	
	public String getDeleteLicense(CustomerPage cust)
	{
		String sql = "DELETE FROM license WHERE custid = "+cust.getCustId();
//		System.out.println(sql);
        return sql;
	}
	
	public String getDeleteLife(CustomerPage cust)
	{
		String sql = "DELETE FROM life WHERE custid = "+cust.getCustId();
//		System.out.println(sql);
        return sql;
	}
	
	public String getDeleteFire(CustomerPage cust)
	{
		String sql = "DELETE FROM fire WHERE custid = "+cust.getCustId();
//		System.out.println(sql);
        return sql;
	}
    
    public boolean existsLicense(CustomerPage cust) throws STDException {
    	boolean exists;
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            String sql = "select 1 from license where custid="+cust.getCustId()+" \n" +
            			 "and license='"+ (StringUtil.Unicode2ASCII(cust.getLicense()))+"' \n" +
            			 "and year="+cust.getYear();
//            System.out.println(sql);
            ResultSet res = stmt.executeQuery(sql);
            exists = res.next();
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return exists;
    }
    
    public boolean existsFire(CustomerPage cust) throws STDException {
    	boolean exists;

        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            String sql = "select 1 from fire where custid="+cust.getCustId()+" and year="+cust.getYear();
            ResultSet res = stmt.executeQuery(sql);
            exists = res.next();
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return exists;
    }
	
	public String updateStatusLicense(CustomerPage cust, int status) throws STDException
	{
		StringBuffer carAct = new StringBuffer();
		
        carAct.append("UPDATE license \n ");
        carAct.append("SET active = "+status+" \n");
        carAct.append("WHERE custid="+cust.getCustId()+" \n");
        carAct.append("AND license='"+StringUtil.Unicode2ASCII(cust.getLicense())+"' \n");
        if (status == 1) {
        	carAct.append("AND year="+cust.getYear()+" \n");
        } else {
        	carAct.append("AND year!="+cust.getYear()+" \n");        	
        }
		
//		System.out.println(carAct.toString());
	    return carAct.toString();
	}
	
	public String updateStatusFire(CustomerPage cust, int status) throws STDException
	{
		StringBuffer fireAct = new StringBuffer();
		
		fireAct.append("UPDATE fire \n ");
		fireAct.append("SET active = "+status+" \n");
		fireAct.append("WHERE custid="+cust.getCustId()+" \n");
        if (status == 1) {
        	fireAct.append("AND year="+cust.getYear()+" \n");
        } else {
        	fireAct.append("AND year!="+cust.getYear()+" \n");        	
        }
		
//		System.out.println(fireAct.toString());
	    return fireAct.toString();
	}
	
	public String updateStatusLife(CustomerPage cust, int status) throws STDException
	{
		StringBuffer fireAct = new StringBuffer();
		
		fireAct.append("UPDATE life \n ");
		fireAct.append("SET active = "+status+" \n");
		fireAct.append("WHERE custid="+cust.getCustId()+" \n");
        if (status == 1) {
        	fireAct.append("AND year="+cust.getYear()+" \n");
        } else {
        	fireAct.append("AND year!="+cust.getYear()+" \n");        	
        }
		
//		System.out.println(fireAct.toString());
	    return fireAct.toString();
	}
	
	public void updatePicture(String cust,String year,String license,String col,String filename) throws STDException
	{
		StringBuffer carSql = new StringBuffer();
		if ("firepic".equalsIgnoreCase(col)) {
			carSql.append("UPDATE fire \n ");
			carSql.append("SET upddate= now() \n");
			carSql.append(","+col+"='"+filename+"' \n ");
			carSql.append("WHERE custid="+cust+" \n");
			carSql.append("AND year="+year+" \n");
		} else if ("lifepic".equalsIgnoreCase(col)) {
			carSql.append("UPDATE life \n ");
			carSql.append("SET upddate= now() \n");
			carSql.append(","+col+"='"+filename+"' \n ");
			carSql.append("WHERE custid="+cust+" \n");
			carSql.append("AND year="+year+" \n");
		} else {
			carSql.append("UPDATE license \n ");
			carSql.append("SET upddate= now() \n");
			carSql.append(","+col+"='"+filename+"' \n ");
			carSql.append("WHERE custid="+cust+" \n");
			carSql.append("AND license='"+StringUtil.Unicode2ASCII(license)+"' \n");
			carSql.append("AND year="+year+" \n");
		}
//		System.out.println(carSql.toString());
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(carSql.toString());
            conn.commit();
	    }
	    catch(SQLException e)
	    {
	    	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
	    	e.printStackTrace();
	    }finally {
	    	try {
	    		if(conn != null) {
	    			conn.close();
	    		}
	    		if(stmt != null) {
	    			stmt.close();
	    		}
			}catch(SQLException ex) {
				ex.printStackTrace();
			}
	    }
	}

}
