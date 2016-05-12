package com.insurance.manage;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import com.insurance.entity.Customer;
import com.insurance.entity.Test;
import com.standard.STDException; 
import com.standard.db.DBControl;
import com.standard.util.StringUtil;

public class TestManager extends DBControl {
	
	public List<Test> getTest(Test cust) throws STDException, IOException
    {
	    List<Test> entities = new ArrayList<Test>();
	    String sql = "SELECT * FROM users WHERE 1=1 and name like '%"+
	    			 StringUtil.Unicode2ASCII(cust.getName())+"%'\n";

        System.out.println(sql);
        try
        {
            Connection conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet res;
            Test entity = null;
            for(res = stmt.executeQuery(sql); res.next(); entities.add(entity))
            {
            	entity = new Test();
            	entity.setId(res.getString("USERID"));
            	entity.setName(StringUtil.encode2Thai(res.getString("NAME")));
            }
            System.out.println(entities.size());

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
