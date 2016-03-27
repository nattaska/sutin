package com.insurance.manage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.insurance.entity.ParameterDetail;
import com.standard.STDException;
import com.standard.db.DBControl;
import com.standard.util.StringUtil;

public class ParameterManager extends DBControl {
	
	private int getMaxParId(int tabid) throws STDException {
		String sql = "select max(parid) maxpar from PARPARAM where tabid = "+tabid;
		int maxId=0;
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);
            if (res.next()) 
            	maxId = res.getInt("MAXPAR");
            
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
	
	public String getTableName(int tabid) throws STDException, IOException {
		String sql = "select tabname from PARTABLE where tabid = "+tabid;
		String tabname = null;
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res = stmt.executeQuery(sql);
            if (res.next()) 
            	tabname = StringUtil.encode2Thai(res.getString("TABNAME"));
            
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return tabname;
	}

	public String insertParamDetail(ParameterDetail entity) throws STDException
	{
		String sql = "INSERT INTO PARPARAM (TABID,PARID,PARNAME,UPDBY,UPDDATE) \n" +
					 "VALUES("+entity.getTabId()+" \n" +
					 ","+(this.getMaxParId(entity.getTabId())+1)+" \n" +
					 ",'"+StringUtil.Unicode2ASCII(entity.getParName())+"' \n" +
					 ",'"+StringUtil.Unicode2ASCII(entity.getUpdBy())+"' \n" +
					 ",now())";
		System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            PreparedStatement prepareStmt = conn.prepareStatement(sql);
            prepareStmt.execute();
            prepareStmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return "!!!\tError\t!!!";
        }
        return "Insert Completed";
	}

	public String updateParamDetail(ParameterDetail entity)
	{
		String sql = "UPDATE PARPARAM SET PARNAME = '"+StringUtil.Unicode2ASCII(entity.getParName())+"' \n" +
					 ",UPDBY = '"+StringUtil.Unicode2ASCII(entity.getUpdBy())+"' \n" +
					 ",UPDDATE = now() \n" +
					 "WHERE TABID = '"+entity.getTabId()+"' \n" +
					 "AND PARID = '"+entity.getParId()+"' \n";
		System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            PreparedStatement prepareStmt = conn.prepareStatement(sql);
            prepareStmt.execute();
            prepareStmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return "!!!\tError\t!!!";
        }
        return "Update Completed";
	}
	public String deleteParamDetail(int tabId,int parId)
	{
		String sql = "DELETE FROM PARPARAM \n" +
					 "WHERE TABID = '"+tabId+"' \n" +
					 "AND PARID = '"+parId+"' \n";
		System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            PreparedStatement prepareStmt = conn.prepareStatement(sql);
            prepareStmt.execute();
            prepareStmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            e.printStackTrace();
            return "!!!\tError\t!!!";
        }
        return "Delete Completed";
	}

    public Vector getAllParamHeader() throws STDException, IOException
    {
        Vector<ParameterDetail> entities = new Vector<ParameterDetail>(0);
        String sql = "SELECT * FROM PARTABLE ORDER BY TABID \n";
        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            ParameterDetail entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new ParameterDetail();
            	entity.setTabId(res.getInt("TABID"));
            	entity.setTabName(StringUtil.encode2Thai(res.getString("TABNAME")));
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

    public Vector getParamDetail(ParameterDetail criterie) throws STDException, IOException
    {
        Vector<ParameterDetail> entities = new Vector<ParameterDetail>(0);
        String sql = "SELECT * FROM PARPARAM WHERE 1=1 \n";
        if (criterie != null) {
	        if(criterie.getTabId() != -1)
	            sql = sql + "AND TABID = " + criterie.getTabId() + " \n";
	        if(criterie.getParId() != -1)
	            sql = sql + "AND PARID = " + criterie.getParId() + " \n";
	        sql = sql + "ORDER BY TABID,PARID";
        }
        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            ParameterDetail entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new ParameterDetail();
            	entity.setTabId(res.getInt("TABID"));
            	entity.setParId(res.getInt("PARID"));
            	entity.setParName(StringUtil.encode2Thai(res.getString("PARNAME")));
            	entity.setUpdBy(StringUtil.encode2Thai(res.getString("UPDBY")));
            	entity.setUpdDate(res.getDate("UPDDATE", calendarTH()));
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

    public String getParamName(int table,int entry) throws STDException, IOException
    {
        String sql = "SELECT PARNAME FROM PARPARAM WHERE TABID = " + table + " AND PARID = " + entry;
        System.out.println(sql);
        String pName = null;

        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            res = stmt.executeQuery(sql);
            if (res.next()) {
            	pName = StringUtil.encode2Thai(res.getString("PARNAME"));
            }
            
            res.close();
            stmt.close();
            conn.close();
        }
        catch(SQLException e)
        {
            throw new STDException("Data not found");
        }
        return pName;
    }

    public Vector searchParamHeader(ParameterDetail criterie) throws STDException, IOException
    {
        Vector<ParameterDetail> entities = new Vector<ParameterDetail>(0);
        String sql = "SELECT * FROM PARPARAM WHERE 1=1 \n";
        if (criterie != null) {
	        if(criterie.getTabId() != -1)
	            sql = sql + "AND TABID = " + criterie.getTabId() + " \n";
	        if(criterie.getParId() != -1)
	            sql = sql + "AND PARID = " + criterie.getParId() + " \n";    
	        if((criterie.getParName() != null)&&(!criterie.getParName().equals("")))
            	sql = sql + "AND PARNAME LIKE '%" + StringUtil.Unicode2ASCII(criterie.getParName().trim()) + "%' \n";
        }
        sql = sql + "ORDER BY TABID,PARID";
        
        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            ParameterDetail entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new ParameterDetail();
            	entity.setTabId(res.getInt("TABID"));
            	entity.setParId(res.getInt("PARID"));
            	entity.setParName(StringUtil.encode2Thai(res.getString("PARNAME")));
            	entity.setUpdBy(StringUtil.encode2Thai(res.getString("UPDBY")));
            	entity.setUpdDate(res.getDate("UPDDATE", calendarTH()));
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

}
