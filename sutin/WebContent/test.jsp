<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@page import="java.util.List"%>
<%@page import="com.insurance.entity.CustomerPage"%>
<%@page import="java.util.Vector"%>
<%@page import="com.insurance.entity.Customer"%>
<%@page import="com.insurance.manage.CustomerManager"%>
<%@page import="com.standard.STDException"%>
<%@page import="com.standard.util.StringUtil"%>
<%@ page import = "java.sql.*"%>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.TestManager"/>
<% String action = request.getParameter("action"); %>
<%@page import="com.insurance.entity.Test"%>

<%@page import="java.util.Vector"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head> 
<body>
<form action="test.jsp" method="post" name="searchform" id="searchform">
<input name="name" type="text" class="name" id="desc" size="40" maxlength="255">

<% 
Connection conn=null;
ResultSet result=null;
Statement stmt=null;
ResultSetMetaData rsmd=null;
try
{
Class c=Class.forName("com.mysql.jdbc.Driver");
}
catch(Exception e)
{
out.write("Error!!!!!!" + e);
}
//out.println(action);
if(request.getParameter("name") != null && request.getParameter("name")!="") {
//	Test et = new Test();
//	et.setName(request.getParameter("name"));
//	List entities = queryBean.getTest(et);
//	for(int i = 0;i < entities.size();i++) {
//		Test entity = (Test)entities.get(i);
//		out.print(entity.getId()+" : "+entity.getName());
//	}

	CustomerManager cm = new CustomerManager();
	CustomerPage cust = new CustomerPage();
	cust.setCustId(5);
	//out.write(cm.searchCustomerPage(cust,Customer.ALL,"00"));
	Vector entities = cm.searchCustomerPage(cust,Customer.ALL,"00");
	out.write("Size : "+entities.size()+"</br>");
	for(int i = 0;i < entities.size();i++){
	    CustomerPage entity = (CustomerPage)entities.elementAt(i);
		out.write("ID : "+entity.getCustId());
		out.write("Name : "+entity.getName()+"</br>");
	} 	

	String connecting="jdbc:mysql://localhost:3306/sutin_insurance?user=sutin_insurance&password=krungsutin&useUnicode=true&characterEncoding=utf8&characterSetResults=utf8";

	//String connecting="jdbc:mysql://localhost:3306/sutin_insurance?user=sutin_insurance&password=krungsutin";

	conn=DriverManager.getConnection(connecting);
	
	String sqlins = "INSERT INTO users (userid,password,name) "+
					"VALUES('12','21','"+StringUtil.Unicode2ASCII(request.getParameter("name"))+"')";
	//new String(src.getBytes("ISO8859_1"), "TIS-620")
	try
	{
	    PreparedStatement prepareStmt = conn.prepareStatement(sqlins);
	    prepareStmt.execute();
	    prepareStmt.close();
	    //conn.close();
	}
	catch(SQLException e)
	{
		out.write("Error!!!!!!" + e);
	}
	
    String sql = "SELECT * FROM users WHERE userid='12'\n";
    try
    {
        stmt = conn.createStatement();
        ResultSet res = stmt.executeQuery(sql);
//        out.write("res : "+res);
        if (res.next()) {
        	out.write("ID : "+(res.getString("USERID"))+"</br>");
        	out.write("User : "+StringUtil.encode2Thai(res.getString("NAME"))+"</br>");
        	out.write("User : "+(res.getString("NAME"))+"</br>");
        }
        res.close(); 
        stmt.close();
        //conn.close();
    }
    catch(SQLException e)
    {
    	out.write("Data not found");
    	e.printStackTrace();
    }
	
	String sqldel = "DELETE FROM users WHERE USERID = '12'";
	try
	{
	    PreparedStatement prepareStmt = conn.prepareStatement(sqldel);
	    prepareStmt.execute();
	    prepareStmt.close();
	    conn.close();
	}
	catch(SQLException e)
	{
		out.write("Error!!!!!!" + e);
	}
}

	%>
</form>
</body>
</html>