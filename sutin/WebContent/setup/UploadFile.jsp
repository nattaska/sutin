<%@ page contentType="text/html; charset=tis-620" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.insurance.entity.*" %>
<%@ page import="com.standard.util.*" %>
<% request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<%
if(!userBean.authenticated()){
    response.sendRedirect("../login.jsp?url=setup/UploadFile.jsp");
}
%>
<%-------------------------%>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.CustomerManager"/>
<%
String action = request.getParameter("action");
String subaction = request.getParameter("subaction");
//if (subaction!=null && subaction.equals("findname")) 
//	subaction=null;
//String findname = request.getParameter("findname");
%>

<script language="JavaScript" type="text/JavaScript">
</script>
<html>
<head>
<title><jsp:include page="../title.jsp" /></title>
<link href="../site.css" rel="stylesheet" type="text/css">
</head><script type='text/javascript' src='../script/scriptMobile.js'></script>
<body onLoad="MM_preloadImages('../images/help_f2.gif')">
<%

String username = userBean.getUsername();
User a = userBean.getUserEntity();
String msg = null;
	if(msg != null){
%>
<meta http-equiv="refresh" content="1;URL=?action=search&id=<%= request.getParameter("id") %>&desc=<%= request.getParameter("desc") %>&status=<%= request.getParameter("status") %>">
<table width="500" height="200" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" height="200" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b><jsp:include page="../title.jsp" /></b></span></td>
        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="200" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td align="center"><%= msg %></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
	} // end msq != null

if(action == null || action.equals("search")){
%>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td align="center" bgcolor="#D8D8C4">
              <jsp:include page="../toolbar.jsp" />
              <span><b><jsp:include page="../title.jsp" /></b></span>
			</td>
        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td width="100" align="center"> <table width="700" border="0" cellpadding="0" cellspacing="2">
                    <tr> 
                      <td colspan="2" class="pagetitle">Upload File</td>
                    </tr>
                    <tr> 
                      <td width="100" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">Upload File</td>
                      <td width="760" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> 
                      <form  action="../UploadFile" method="post" name="UploadFile" enctype="multipart/form-data">
                      <!-- form action="?" method="post" name="searchform" id="searchform" -->
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr>
                              <td colspan="2" align="center" > 
                                <input name="custId" type="hidden" id="custId" value="<%= request.getParameter("custId")%>">
                                <input name="year" type="hidden" id="year" value="<%= request.getParameter("year")%>">
                                <input name="license" type="hidden" id="license" value="<%= request.getParameter("license")%>">
	                              <table>
	                              	 <tr>
	                              	 	<td>ภาษี&nbsp;&nbsp;</td>
	                              	 	<td><input type="file" name="vat"/></td>
	                              	 </tr>
	                              	 <tr>
	                              	 	<td>ประกันรถ&nbsp;&nbsp;</td>
	                              	 	<td><input type="file" name="car"/></td>
	                              	 </tr>
	                              	 <tr>
	                              	 	<td>พรบ.&nbsp;&nbsp;</td>
	                              	 	<td><input type="file" name="act"/></td>
	                              	 </tr>
	                              	 <tr>
	                              	 	<td>ตรอ.&nbsp;&nbsp;</td>
	                              	 	<td><input type="file" name="chk"/></td>
	                              	 </tr>
	                              </table>
                              </td>
                            </tr>
                            <tr>
                              <td colspan="/" align="center" > </td>
                            </tr>
                            <tr>
                              <td colspan="/" align="center" > <input name="submitsearch" type="submit" class="button" id="submitsearch" value="upload"> 
                                <input name="action" type="hidden" id="action" value="search">
                              </td>
                            </tr>
                            <tr>
                              <td colspan="2" align="center" > </td>
                            </tr>                            
                          </table>
                        </form></td>
                    </tr>
                  </table></td>
              </tr>
    </table>
    <%
	}
%>
                  </td>
              </tr>
            </table>
            </td>
        </tr>
</table>
</body>
</html> 
<script language="javascript">
		function submitAndReload(){
			//alert("submitAndReload");
			setTimeout('newTransaction();',2000);
		}
		
		function newTransaction(){
			if (confirm("คุณต้องการที่จะเริ่มการทำงานใหม่\nใช่ หรือ ไม่?")) {
				document.location="../Reload.jsp?url=setup/UploadFile.jsp&msg=Reloading";
			}else{
				document.location="../index.jsp";
			}
		}
</script>