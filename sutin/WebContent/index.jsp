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
                  <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b>�����ŷ����</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                                <a href="setup/ParameterMT.jsp">��˹������ŷ���� </a><br>
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
                   �к��ؤ��</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                          <a href="setup/CustomerMultiMT.jsp">�١���</a><br>
                        <% if (userBean.getStatus().equals("A")) { %>
                          <a href="setup/UserMT.jsp">��ѡ�ҹ</a><br>
                          <% } %>
                          <a href="setup/CheckingMT.jsp">��Ǩ��Ҿö</a><br>
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
                    ��§ҹ</b></span></td>
                </tr>
                <tr> 
                  <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="100" border="0" cellpadding="0" cellspacing="5" >
                      <tr> 
                        <td align="center" valign="top">
                          <a href="reports/CustomerListRP.jsp">��§ҹ��ª����١���</a><br>
                          <a href="reports/CustomerLetterRP.jsp">�����ͧ������</a><br>
                          <a href="reports/SummaryRP.jsp">��§ҹ��ػ�ӹǹ����¹��»�</a><br>
                          <!-- a href="reports/CheckingRP.jsp">��Ǩ��Ҿö</a><br> -->
                      </tr>
                    </table></td>
                </tr>
              </table></td>
          </tr>
        </table></td>
    </tr>
        </table>
     
  <p> <a href="login.jsp?action=logout&url=index.jsp"><span class="text">�͡�ҡ�к�</span></a></p>
</div>
</body>
</html>
