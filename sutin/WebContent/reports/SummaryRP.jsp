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
    response.sendRedirect("../login.jsp?url=reports/SummaryRP.jsp");
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
System.out.println("action ===> "+action+"\tsubaction ===> "+subaction);
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
                      <td colspan="2" class="pagetitle">รายงานสรุปจำนวนทะเบียนรายปี</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">ค้นหา</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> 
                      <form  action="../SummaryReport" method="post" name="SummaryReport" >
                      <!-- form action="?" method="post" name="searchform" id="searchform" -->
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr>
                              <td colspan="3" align="center" > 
	                              <table>
	                              	 <tr>
	                              	 	<td>ปี&nbsp;&nbsp;</td>
	                              	 	<td>
			                              	<input name="year" type="number" class="number" id="yearexp" value="<%=(request.getParameter("year")==null?(Integer.parseInt(StringUtil.toString(Calendar.getInstance().getTime(), "yyyy"))+1):request.getParameter("year")) %>" size="4" maxlength="4">
		                              	</td>
	                              	 	<td>&nbsp;&nbsp;เดือน&nbsp;&nbsp;</td>
	                              	 	<td>
				                              <SELECT NAME="smonth" SIZE="1" >
				                              	<%
														for (int i=1;i<=12;i++) {
				                              	%>
				                            	<OPTION <%= ((request.getParameter("smonth")==null&&i==1)?"SELECTED":request.getParameter("smonth")==null?"":((Integer.parseInt(request.getParameter("smonth")) == i)?"SELECTED":"")) %> 
				                            		VALUE="<%= ((i < 10)?("0"+i):(""+i)) %>" > <%= ((i < 10)?(StringUtil.toStringMonth("0"+i)):(StringUtil.toStringMonth(""+i))) %> </OPTION>
				                            	<%  }
				                              	%>
				                              	</SELECT>&nbsp;&nbsp;-&nbsp;&nbsp;
				                              <SELECT NAME="emonth" SIZE="1" >
				                              	<%
														for (int i=1;i<=12;i++) {
				                              	%>
				                            	<OPTION <%= ((request.getParameter("emonth")==null&&i==12)?"SELECTED":request.getParameter("smonth")==null?"":((Integer.parseInt(request.getParameter("emonth")) == i)?"SELECTED":"")) %> 
				                            		VALUE="<%= ((i < 10)?("0"+i):(""+i)) %>" > <%= ((i < 10)?(StringUtil.toStringMonth("0"+i)):(StringUtil.toStringMonth(""+i))) %> </OPTION>
				                            	<%  }
				                              	%>
				                              	</SELECT>
	                              	 	</td>
	                              	 </tr>
	                              </table>
                              </td>
                            </tr>
                            <tr>
                              <td colspan="3" align="center" > </td>
                            </tr>
                            <tr>
                              <td colspan="3" align="center" > <input name="submitsearch" type="submit" class="button" id="submitsearch" value="ค้นหา"> 
                                <input name="action" type="hidden" id="action" value="search">
                              </td>
                            </tr>
                            <tr>
                              <td colspan="3" align="center" > </td>
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
				document.location="../Reload.jsp?url=reports/SummaryRP.jsp&msg=Reloading";
			}else{
				document.location="../index.jsp";
			}
		}
</script>