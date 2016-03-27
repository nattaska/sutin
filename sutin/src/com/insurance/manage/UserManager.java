/*
 * Created on 8 ¾.Â. 2548
 *
 */
package com.insurance.manage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import com.insurance.entity.User;
import com.standard.STDException;
import com.standard.db.DBControl;
import com.standard.util.StringUtil;

public class UserManager extends DBControl implements java.io.Serializable{
    
    private String username;
    private String password;
    private String name;
    private String position;
    private String status; 
    private boolean authenticated;
    private User userEntity;
    
    public UserManager() {
        username = "";
        password = "";
        name = "";
        position = "";
        status = "";
        authenticated = false;
    }
    
	/**
	 * @return Returns the status.
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * @param status The status to set.
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * @return Returns the userEntity.
	 */
	public User getUserEntity() {
		return userEntity;
	}
	/**
	 * @param userEntity The userEntity to set.
	 */
	public void setUserEntity(User userEntity) {
		this.userEntity = userEntity;
	}
    public boolean authenticated(){
        return authenticated;
    }
    
    public String getUsername() {
        return username;
    }
    
    public void setUsername(String value) {
        username = value;
    }
    
    public String getPassword() {
        return password;
    }
    
    public void setPassword(String value) {
        password = value;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String value) {
    	name = value;
    }
    
    public String getPosition() {
        return position;
    }
    
    public void setPosition(String value) {
    	position = value;
    }

    public void login(){
        try {
			if (verified()) {
			    authenticated = true;
			}else{
			    username = "";
			    password = "";
			    authenticated = false;
			}
		} catch (STDException e) {
			e.printStackTrace();
		}
    }
    
	public String insertUser(User user)
	{
		String sql = "INSERT INTO USERS (userid,password,name,tel,position,status,active,cuser,cdate) \n" +
					 "		VALUES('"+user.getUserId()+"' \n" +
					 "		,'"+user.getPassword()+"' \n" +
					 "		,'"+StringUtil.Unicode2ASCII(user.getName())+"' \n" +
					 "		,'"+user.getTel()+"' \n" +
					 "		,'"+user.getPosition()+"' \n" +
					 "		,'"+user.getStatus()+"' \n" +
					 "		,"+user.isActive()+" \n" +
					 "		,'"+StringUtil.Unicode2ASCII(user.getUpdBy())+"' \n" +
					 "		,now())";
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
            return "!!!\tError\t!!!";
        }
        return "Insert Completed";
	}
	public String updateUser(User user)
	{
		String sql = "UPDATE USERS SET PASSWORD = '"+user.getPassword()+"' \n" +
					 "		,NAME = '"+StringUtil.Unicode2ASCII(user.getName())+"' \n" +
					 "		,POSITION = '"+user.getPosition()+"' \n" +
					 "		,TEL = '"+user.getTel()+"' \n" +
					 "		,STATUS = '"+user.getStatus()+"' \n" +
					 "		,ACTIVE = "+user.isActive()+" \n" +
					 "		,CUSER = '"+StringUtil.Unicode2ASCII(user.getUpdBy())+"' \n" +
					 "		,CDATE = now() \n" +
					 "WHERE USERID = '"+user.getUserId()+"' \n";
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
            return "!!!\tError\t!!!";
        }
        return "Update Completed";
	}
	public String deleteUser(User user)
	{
		String sql = "DELETE FROM USERS " +
					 "WHERE USERID = '"+user.getUserId()+"'";
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
            return "!!!\tError\t!!!";
        }
        return "Delete Completed";
	}

    public Vector getUser(User user) throws STDException, IOException
    {
        Vector entities = new Vector(0);
        String sql = "SELECT * FROM USERS WHERE 1=1 \n";
        if(user.getUserId() != null)
            sql = sql + "AND USERID = '" + user.getUserId().trim() + "' \n";
        if(user.getName() != null)
            sql = sql + "AND NAME = '" + user.getName().trim() + "' \n";
        if(user.getPosition() != null)
            sql = sql + "AND POSITION = '" + user.getPosition().trim() + "' \n";
        if(user.getStatus() != null)
            sql = sql + "AND STATUS = '" + user.getStatus().trim() + "' \n";    
        sql = sql + "AND ACTIVE = " + user.isActive()+ " \n";
        sql = sql + "ORDER BY USERID";
        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            User entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new User();
            	entity.setUserId(res.getString("USERID"));
            	entity.setPassword(res.getString("PASSWORD"));
            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));
            	entity.setPosition(res.getString("POSITION"));
            	entity.setTel(res.getString("TEL"));
            	entity.setStatus(res.getString("STATUS"));
            	entity.setActive(res.getInt("ACTIVE"));
            	entity.setUpdBy(StringUtil.encode2Thai(res.getString("CUSER")));
            	entity.setUpdDate(res.getDate("CDATE", calendarTH()));
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

    public Vector searchUser(User user) throws STDException, IOException
    {
        Vector entities = new Vector(0);
        String sql = "SELECT * FROM USERS WHERE 1=1 \n";
        if(user.getUserId() != null)
            sql = sql + "AND USERID LIKE '%" + user.getUserId().trim() + "%' \n";        
        if(user.getName() != null)
            sql = sql + "AND NAME LIKE '%" + user.getName().trim() + "%' \n";        
        if(user.getPosition() != null)
            sql = sql + "AND POSITION LIKE '%" + user.getPosition().trim() + "%' \n";        
        if(user.getStatus() != null && !user.getStatus().equals(""))
            sql = sql + "AND STATUS LIKE '%" + user.getStatus().trim() + "%' \n";   
        if(user.isActive() != -1)
        	sql = sql + "AND ACTIVE = " + user.isActive()+ " \n";
        sql = sql + "ORDER BY USERID";
        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            User entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new User();
            	entity.setUserId(res.getString("USERID"));
            	entity.setPassword(res.getString("PASSWORD"));
            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));
            	entity.setPosition(res.getString("POSITION"));
            	entity.setStatus(res.getString("STATUS"));
            	entity.setActive(res.getInt("ACTIVE"));
            	entity.setUpdBy(StringUtil.encode2Thai(res.getString("CUSER")));
            	entity.setUpdDate(res.getDate("CDATE", calendarTH()));
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

    public boolean verified() throws STDException
    {
        String sql = "";
        User entity = null;
        if(username != null){
        	sql = "SELECT * FROM USERS WHERE 1=1 \n";
            sql = sql + "AND USERID = '" + username.trim() + "' \n";
	        sql = sql + "AND ACTIVE = 1 \n";
	        sql = sql + "ORDER BY USERID";
	        System.out.println(sql);
	        try
	        {
	            Connection conn = getConnection();
	            Statement stmt = conn.createStatement();
	            ResultSet res;
	            res = stmt.executeQuery(sql);
	            if(res.next())
	            {            	
	            	if (password.equals(res.getString("PASSWORD")))
	            	{
	            		entity = new User();
	                	entity.setUserId(res.getString("USERID"));
	                	entity.setPassword(res.getString("PASSWORD"));
	                	entity.setName(res.getString("NAME"));
	                	entity.setPosition(res.getString("POSITION"));
	                	entity.setStatus(res.getString("STATUS"));
	                	entity.setActive(res.getInt("ACTIVE"));
	                	entity.setUpdBy(res.getString("CUSER"));
	                	entity.setUpdDate(res.getDate("CDATE", calendarTH()));
	                	
	                	this.username = res.getString("USERID");
	                	this.password = res.getString("PASSWORD");
	                	this.name = res.getString("NAME");
	                	this.position = res.getString("POSITION");
	                	this.status = res.getString("STATUS");
	                	this.userEntity = entity;
	                	return true;
	            	}
	            }
	            res.close();
	            stmt.close();
	            conn.close();
	        }
	        catch(SQLException e)
	        {
	            e.printStackTrace();
	        }
        }
        return false;
    }

}
