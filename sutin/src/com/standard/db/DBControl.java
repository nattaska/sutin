package com.standard.db;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

public class DBControl  {
    //DB Host identification 
    private static final String MYSQL_HOST      = "localhost";
//    private static final String MYSQL_USER      = "root";
//    private static final String MYSQL_PASSWD    = "";
//    private static final String MYSQL_DB        = "insurance";
//    private static final String MYSQL_DB        = "machine";
//    private static final String MYSQL_DB        = "insur";
    private static final String MYSQL_DB        = "sutin_insurance";
    private static final String MYSQL_USER      = "sutin_insurance";
    private static final String MYSQL_PASSWD    = "krungsutin";
    private static final String MYSQL_PORT      = "3306";
    private String msg;
    
//    private String driver = "org.gjt.mm.mysql.Driver";
    private Connection conn = null;
    private String driver = "com.mysql.jdbc.Driver";
    public DBControl() {
        
    }
    
    public Connection getConnection() throws SQLException{
        try {
//        System.out.println(driver);
            Class.forName(driver).newInstance();
//            System.out.println("jdbc:mysql://" + MYSQL_HOST + ":" + MYSQL_PORT + "/" + MYSQL_DB +
//            "?user=" + MYSQL_USER + "&password=" + MYSQL_PASSWD);
            conn = DriverManager.getConnection("jdbc:mysql://" + MYSQL_HOST + ":" + MYSQL_PORT + "/" + MYSQL_DB +
            "?user=" + MYSQL_USER + "&password=" + MYSQL_PASSWD +
            "&useUnicode=true&characterEncoding=utf8&characterSetResults=utf8");
//            conn = DriverManager.getConnection("jdbc:mysql://" + MYSQL_HOST + ":" + MYSQL_PORT + "/" + MYSQL_DB,MYSQL_USER,MYSQL_PASSWD);
            
        }catch(ClassNotFoundException cnfe){
            cnfe.printStackTrace();
        }catch(InstantiationException inte){
            inte.printStackTrace();
        }catch(IllegalAccessException ile){
            ile.printStackTrace();
        }catch (SQLException ex) {
            // handle any errors
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
        }
        
        return conn;
    }
    
    public Vector getSQL(String q,String getvalue){
        Vector value=new Vector();
        try {
            conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs;
            rs = stmt.executeQuery(q);
                /* ResultSetMetaData rsm = rs.getMetaData();
                 
                int Ccount = rsm.getColumnCount();*/
            
            
            while(rs.next()){                
                value.addElement((rs.getString(getvalue)));
            }
            stmt.close();
            conn.close();
        }catch (SQLException ex){
            System.out.println("ERROR::"+ex);
            msg = ex.toString();
        }
        //System.out.println(value);
        return value;
        
        
    }
    
    public Vector getDataOneRow(String q){
        Vector headList = new Vector();
        Vector dataList = new Vector();
        try {
            conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs;
            rs = stmt.executeQuery(q);
            ResultSetMetaData rsm = rs.getMetaData();
            
            int count = rsm.getColumnCount();
            for (int i=1;i<=count;i++ ){
                headList.addElement(rsm.getColumnName(i));
            }
            while(rs.next()){
                //Vector row = new Vector();
                for(int i=1;i<=count;i++){
                    dataList.addElement(rs.getString(rsm.getColumnName(i)));
                }
                //dataList.addElement(row);
            }
            msg =dataList.toString();
            rs.close();
            stmt.close();
            conn.close();
        }catch (SQLException ex){
            System.out.println("ex:::::"+ex);
            msg =ex.toString();
        }
        return dataList;        
    }
    
    public Vector  getData(String q){
        Vector headList = new Vector();
        Vector dataList = new Vector();
        try {
            conn = getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs;
            rs = stmt.executeQuery(q);
            ResultSetMetaData rsm = rs.getMetaData();
            
            int Ccount = rsm.getColumnCount();
            for (int i=1;i<=Ccount;i++ ){
                headList.addElement(rsm.getColumnName(i));
            }
            while(rs.next()){
                Vector row = new Vector();
                for(int i=1;i<=Ccount;i++){
                    row.addElement(rs.getString(rsm.getColumnName(i)));
                }
                dataList.addElement(row);
            }
            msg =dataList.toString();
            rs.close();
            stmt.close();
            conn.close();
        }catch (SQLException ex){
            msg =ex.toString();
        }
        return dataList;
        
    }
    
    public String todayTH(){
        return todayTH("yyyy-MM-dd");
    }
    
    public String todayTH(String format){
        return (new java.text.SimpleDateFormat(format, new java.util.Locale("th","TH"))).format(new java.util.Date());
    }
    
    public String dateTH(java.util.Date date){
        return dateTH("yyyy-MM-dd", date);
    }
    
    public String dateTH(String format, java.util.Date date){
        return (new java.text.SimpleDateFormat(format, new java.util.Locale("th","TH"))).format(date);
    }
    
    public java.util.Calendar calendarTH(){
        return java.util.Calendar.getInstance(new java.util.Locale("th","TH"));
    }
    
    public String now(){
        return todayTH("HH:mm:ss");
    }
    
    public static void main(String args[]){
        DBControl dbControl = new DBControl();
        try {
            System.out.print(dbControl.getConnection());
            
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
    }
}