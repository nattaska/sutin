package com.insurance.manage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.insurance.entity.Checking;
import com.insurance.entity.Customer;
import com.insurance.entity.CustomerPage;
import com.standard.STDException;
import com.standard.db.DBControl;
import com.standard.util.StringUtil;

public class CheckingManager extends DBControl {
	public static int INSERT=1; 
	public static int UPDATE=2; 

    public Vector searchChecked(Checking chk) throws STDException, IOException
    {
        Vector<Checking> entities = new Vector<Checking>(0);
        String sql = "SELECT license,coachworkno,motorno \n" +
        			 "FROM checking  \n" +
        			 "WHERE 1=1 \n";
        if(chk.getLicense() != null && !chk.getLicense().equals(""))
            sql = sql + "AND license LIKE '%" + StringUtil.Unicode2ASCII(chk.getLicense().trim()) + "%' \n";
        if(chk.getCoachWorkNo() != null && !chk.getCoachWorkNo().equals(""))
            sql = sql + "AND coachworkno LIKE '%" + StringUtil.Unicode2ASCII(chk.getCoachWorkNo().trim()) + "%' \n";
        if(chk.getMotorNo() != null && !chk.getMotorNo().equals(""))
            sql = sql + "AND motorno LIKE '%" + StringUtil.Unicode2ASCII(chk.getMotorNo().trim()) + "%' \n";
        sql = sql + "ORDER BY license";
        System.out.println(sql);
        
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            Checking entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new Checking();
            	entity.setLicense(res.getString("LICENSE")==null?null:StringUtil.encode2Thai(res.getString("LICENSE")));
            	entity.setCoachWorkNo(res.getString("COACHWORKNO")==null?null:StringUtil.encode2Thai(res.getString("COACHWORKNO")));
            	entity.setMotorNo(res.getString("MOTORNO")==null?null:StringUtil.encode2Thai(res.getString("MOTORNO")));
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

    public Checking getChecked(String license) throws STDException, IOException
    {
        Checking entity = null;
        String sql = "SELECT license,ifnull(province,-1) province,cerdate,regisdate, \n" +
        			 "ifnull(brandid,-1) brandid,coachworkno,motorno, \n" +
		 			 "ifnull(category,-1) category,ifnull(characteristic,-1) characteristic, \n" +
		 			 "ifnull(weight,-1) weight,ifnull(motor,-1) motor,ifnull(fuel,-1) fuel, \n" +
		 			 "ifnull(coachWorkNoPos,-1) coachWorkNoPos,ifnull(motorNoPos,-1) motorNoPos, \n"+
		 			 "ifnull(pump,-1) pump,ifnull(cc,-1) cc,ifnull(axle,-1) axle,ifnull(wheel,-1) wheel, \n" +
		 			 "ifnull(tire,-1) tire,ifnull(chkname,-1) chkname \n"+
        			 "FROM checking  \n" +
        			 "WHERE 1=1 \n";
        if(license != null && !license.equals(""))
            sql = sql + "AND license LIKE '%" + StringUtil.Unicode2ASCII(license.trim()) + "%' \n";
        System.out.println(sql);
        
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);
            if (res.next()) {
                System.out.println("Row : "+res.getRow());
            	entity = new Checking();
            	entity.setLicense(res.getString("LICENSE")==null?null:StringUtil.encode2Thai(res.getString("LICENSE")));
            	entity.setProvince(res.getInt("PROVINCE"));
            	entity.setCerDate(res.getString("CERDATE")==null?null:res.getString("CERDATE"));
            	entity.setRegisDate(res.getString("REGISDATE")==null?null:res.getString("REGISDATE"));
            	entity.setBrandId(res.getInt("BRANDID"));            	
            	entity.setCoachWorkNo(res.getString("COACHWORKNO")==null?null:res.getString("COACHWORKNO"));
            	entity.setMotorNo(res.getString("MOTORNO")==null?null:res.getString("MOTORNO"));            	
            	entity.setCategory(res.getInt("CATEGORY"));
            	entity.setCharacteristic(res.getInt("CHARACTERISTIC"));
            	entity.setWeight(res.getInt("WEIGHT"));
            	entity.setMotor(res.getInt("MOTOR"));
            	entity.setFuel(res.getInt("FUEL"));
            	entity.setCoachWorkNoPos(res.getInt("COACHWORKNOPOS"));
            	entity.setMotorNoPos(res.getInt("MOTORNOPOS"));
            	entity.setPump(res.getInt("PUMP"));
            	entity.setCc(res.getInt("CC"));
            	entity.setAxle(res.getInt("AXLE"));
            	entity.setWheel(res.getInt("WHEEL"));
            	entity.setTire(res.getInt("TIRE"));
            	entity.setChkName(res.getInt("CHKNAME"));            	
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
        return entity;
    }

	public String updateChecked(Checking chk,int type) throws STDException
	{
		StringBuffer chkSql = new StringBuffer();
		chkSql.append("REPLACE INTO CHECKING (license, province, cerdate, regisdate, \n");
		chkSql.append("			brandid, coachworkno, motorno, category, characteristic, \n");
		chkSql.append("			weight, motor, fuel, coachWorkNoPos, motorNoPos, pump, cc, axle, \n");
		chkSql.append("			wheel, tire, chkname, ");

		if (type == CheckingManager.INSERT) {
			chkSql.append("creby, credate, ");
		}
		chkSql.append("updby, upddate) \n" );
		chkSql.append("VALUES('"+ StringUtil.Unicode2ASCII(chk.getLicense())+"'");
		chkSql.append(" , "+(chk.getProvince()==-1?"null":chk.getProvince()));
		if (chk.getCerDate().equals("")) {
			chkSql.append(" , null ");
		} else {
			chkSql.append(" ,'"+(chk.getCerDate())+"'");
		}
		if (chk.getRegisDate().equals("")) {
			chkSql.append(" , null ");
		} else {
			chkSql.append(" ,'"+(chk.getRegisDate())+"'");
		}
		chkSql.append(" , "+(chk.getBrandId()==-1?"null":chk.getBrandId()));
		if (chk.getCoachWorkNo().equals("")) {
			chkSql.append(" , null ");
		} else {
			chkSql.append(" ,'"+(StringUtil.Unicode2ASCII(chk.getCoachWorkNo()))+"'");
		}
		if (chk.getMotorNo().equals("")) {
			chkSql.append(" , null ");
		} else {
			chkSql.append(" ,'"+(StringUtil.Unicode2ASCII(chk.getMotorNo()))+"'");
		}
		chkSql.append(" , "+(chk.getCategory()==-1?"null":chk.getCategory()));
		chkSql.append(" , "+(chk.getCharacteristic()==-1?"null":chk.getCharacteristic()));
		chkSql.append(" , "+(chk.getWeight()==-1?"null":chk.getWeight()));
		chkSql.append(" , "+(chk.getMotor()==-1?"null":chk.getMotor()));
		chkSql.append(" , "+(chk.getFuel()==-1?"null":chk.getFuel()));
		chkSql.append(" , "+(chk.getCoachWorkNoPos()==-1?"null":chk.getCoachWorkNoPos()));
		chkSql.append(" , "+(chk.getMotorNoPos()==-1?"null":chk.getMotorNoPos()));
		chkSql.append(" , "+(chk.getPump()==-1?"null":chk.getPump()));
		chkSql.append(" , "+(chk.getCc()==-1?"null":chk.getCc()));
		chkSql.append(" , "+(chk.getAxle()==-1?"null":chk.getAxle()));
		chkSql.append(" , "+(chk.getWheel()==-1?"null":chk.getWheel()));
		chkSql.append(" , "+(chk.getTire()==-1?"null":chk.getTire()));
		chkSql.append(" , "+(chk.getChkName()==-1?"null":chk.getChkName()));
		if (type == CheckingManager.INSERT) {
			chkSql.append(" ,'"+(StringUtil.Unicode2ASCII(chk.getCreBy()))+"'");
			chkSql.append(" ,now()" );
		}
		chkSql.append(" ,'"+(StringUtil.Unicode2ASCII(chk.getUpdBy()))+"'" );
		chkSql.append(" ,now())" );
		System.out.println(chkSql);

		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            stmt = conn.createStatement(); 
            stmt.executeUpdate(chkSql.toString());            
    		conn.commit();
        } catch(SQLException e)
        {
        	try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
        	e.printStackTrace();
            return "!!!\tError\t!!!";
        } finally {
        	try {
        		if(stmt != null) {
        			stmt.close();
        		}
        		if(conn != null) {
        			conn.close();
        		}
    		}catch(SQLException ex) {
    			ex.printStackTrace();
    		}
        }

		return "บันทึกข้อมูลการตรวจสภาพรถเรียบร้อย";
	}
	
	public String deleteChecked(String license)
	{
		String sql = "DELETE FROM CHECKING WHERE license = '"+StringUtil.Unicode2ASCII(license)+"' \n";
		System.out.println(sql);
		
		Connection conn = null;
		Statement stmt = null;
        try
        {
            conn = getConnection();
            conn.setAutoCommit(false);
            
            stmt = conn.createStatement(); 
            stmt.executeUpdate(sql);
            conn.commit();
	    } catch(SQLException e)
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
}
