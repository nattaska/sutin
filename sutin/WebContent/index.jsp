<%@ page contentType="text/html; charset=tis-620" language="java"%>
<% request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean> 
<%
if(!userBean.authenticated()){
    response.sendRedirect("login.jsp?url=index.jsp");
}
%>
<%-------------------------%>


<html>
<head>
<title><jsp:include page="title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="site.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center"> 
  <p><img src="./images/sutin-logo.gif" width="200" height="200"> </p>
  <table border="0" cellspacing="10" cellpadding="0">
    <tr align="center" valign="bottom"> 
      <% if (userBean.getStatus().equals("A")) { %>
      <td> 
        <table width="200" height="100" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
          <tr> 
            <td> <table width="100%" height="100" border="0" cellspacing="1" cellpadding="5" valign="top" >
                <tr> 
                  <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b>ข้อมูลทั่วไป</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                                <a href="setup/ParameterMT.jsp">กำหนดข้อมูลทั่วไป </a><br>
                            </td>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
        <% } %>
      <td> 
        <table width="200" height="100" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
          <tr> 
            <td> <table width="100%" height="100" border="0" cellspacing="1" cellpadding="5" valign="top" >
                <tr> 
                  <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b> 
                   ระบบบุคคล</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                          <a href="setup/CustomerMultiMT.jsp">ลูกค้า</a><br>
                        <% if (userBean.getStatus().equals("A")) { %>
                          <a href="setup/UserMT.jsp">พนักงาน</a><br>
                          <% } %>
                          <a href="setup/CheckingMT.jsp">ตรวจสภาพรถ</a><br>
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
      <td> 
        <table width="200" height="100" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
          <tr> 
            <td> <table width="100%" height="100" border="0" cellspacing="1" cellpadding="5" valign="top" >
                <tr> 
                  <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b> 
                    รายงาน</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                          <a href="reports/CustomerListRP.jsp">รายงานรายชื่อลูกค้า</a><br>
                          <a href="reports/CustomerLetterRP.jsp">พิมพ์ซองจดหมาย</a><br>
                          <a href="reports/SummaryRP.jsp">รายงานสรุปจำนวนทะเบียนรายปี</a><br>
                          <!-- a href="reports/CheckingRP.jsp">ตรวจสภาพรถ</a><br> -->
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
        </table>
     
  <p> <a href="login.jsp?action=logout&url=index.jsp"><span class="text">ออกจากระบบ</span></a></p>
</div>
</body>
</html>
