<%@ page contentType="text/html; charset=tis-620" language="java"%>
<% request.setCharacterEncoding("tis-620"); %>

<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<jsp:useBean id="urlBean" scope="session" class="com.standard.StandardURL">
<jsp:setProperty name="urlBean" property="*"/>
</jsp:useBean>
<%
if(request.getParameter("url") != null){ 
    urlBean.setUrl(request.getParameter("url"));
}
if (request.getMethod().equals("POST") && !userBean.authenticated()) {
    userBean.setUsername(request.getParameter("username"));
    userBean.setPassword(request.getParameter("password"));
    userBean.login();
}
%>

<%
if(userBean.authenticated()){
    if(request.getParameter("action") == null || !request.getParameter("action").equals("logout")){
        response.sendRedirect(urlBean.getUrl());
    }else{
        userBean.setUsername("");
        userBean.setPassword("");
        userBean.login();
    }
}
%>

<html>
<head>
<title><jsp:include page="title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="site.css" rel="stylesheet" type="text/css">
</head>

<body>
<div align="center"><img src="./images/sutin-logo.gif" width="200" height="200"> 
</div>
<table width="300" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" height="100%" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td bgcolor="#D8D8C4" height="5%" align="center"> <font face="Verdana" size="-1"><b>Login</b></font></td>
        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top">
            <form action="login.jsp" method="post" name="loginform" id="loginform">
              <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td align="center"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td width="100" align="right">User ID :</td>
                      <td><input name="username" type="text" class="text" id="username" value="admin" size="20"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr valign="top"> 
                <td align="center"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td width="100" align="right">Password :</td>
                      <td><input name="password" type="password" class="text" id="password" value="admin" size="20"></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td bgcolor="#F6F6EB" align="center" width="10%"><table width="100%" border="0" cellspacing="2" cellpadding="0">
                    <tr> 
                      <td width="100" align="right"><input name="url" type="hidden" id="url" value="<%= urlBean.getUrl() %>"></td>
                      <td><input name="signon" type="submit" class="button" id="signon" value="Sign On" ></td>
                    </tr>
                  </table></td>
              </tr>
            </table>
            </form></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>