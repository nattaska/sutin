<%@ page contentType="text/html; charset=tis-620" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.insurance.entity.*" %>
<%@ page import="com.standard.util.*" %>
<jsp:directive.page import="com.insurance.manage.ParameterManager"/>
<% request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<%
if(!userBean.authenticated()){
    response.sendRedirect("../login.jsp?url=reports/CustomerLetterRP.jsp");
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

<html>
<head>
<title><jsp:include page="../title.jsp" /></title>
<link href="../site.css" rel="stylesheet" type="text/css">
</head>
<script type='text/javascript' src='../script/scriptMobile.js'></script>
<link href="../script/dhtmlgoodies_calendar.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='../script/dhtmlgoodies_calendar.js'></script>
<body onLoad="MM_preloadImages('../images/help_f2.gif')">
<%
String reportLogo = getServletConfig().getServletContext().getRealPath("/")+"/images/sutin-logo.gif";
//out.write(reportLogo);
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
                      <td colspan="2" class="pagetitle">ลูกค้า</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">ค้นหา</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> 
                       <form  action="../ReportControl" method="post" name="ReportControl" >
                      <!-- form action="?" method="post" name="searchform" id="searchform" -->
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td>
                              	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="2" height="50">
                              		<tr width="100%" class="lineborder"> 
										<%
											String chkString[] = {"","","","",""};
											if(request.getParameter("typeins")!=null)
											{
												if(request.getParameter("typeins").equals("FireLetter_Period"))
													chkString[1] = "checked";
												else if(request.getParameter("typeins").equals("CarLetter_Period"))
													chkString[2] = "checked";
												else if(request.getParameter("typeins").equals("VatLetter_Period"))
													chkString[3] = "checked";
												else if(request.getParameter("typeins").equals("LifeLetter_Period"))
													chkString[4] = "checked";
											}else
												chkString[3] = "checked";
										%>
                              			<td><input name="typeins" type="radio" value="FireLetter_Period" <%=chkString[1]%>>ประกันอัคคีภัย</td>
                              			<td><input name="typeins" type="radio" value="CarLetter_Period" <%=chkString[2]%>>ประกันรถ</td>
                              			<td><input name="typeins" type="radio" value="VatLetter_Period" <%=chkString[3]%>>ภาษีรถ</td>
                              			<td><input name="typeins" type="radio" value="LifeLetter_Period" <%=chkString[4]%>>ประกันเอื้ออารีย์</td>
		                            	</tr>  
                              	</table>
                              </td>                            
                              <td width="30" align="right" rowspan="2">
                              	<table width="39" border="0" align="center" cellpadding="0" cellspacing="2" height=50>
                              		<tr align="center"><td>
                              			<font face="Microsoft Sans Serif">จังหวัด</font> 
                              		</td></tr>
                              		<tr align="center"><td></td></tr>
                              	</table>
                              </td>
                              <td width="125"  rowspan="2"> 
                              	<table width="39" border="0" align="center" cellpadding="0" cellspacing="2" height=50>
                              		<tr align="center"><td>
		                              <SELECT NAME="provinceId" SIZE="1" >
		                              	<OPTION <%= (((action==null)||(request.getParameter("provinceId")==null)||(request.getParameter("provinceId").equals("-1")))?"SELECTED":"") %> 
		                              			VALUE="-1" > - - - - - -   เลือกทั้งหมด   - - - - - - </OPTION>
		                              	<%
		  	                              	     ParameterManager manage = new ParameterManager();
		  	                              	     ParameterDetail et = new ParameterDetail(1,2);
		  	                              	     out.println(et.getTabId()+"  "+et.getParId());
		  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
		  	                              	     for (int i=0;i<tabs.size();i++) {
		  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
		                              	%>
		                            	<OPTION <%= (request.getParameter("provinceId")==null?"":((Integer.parseInt(request.getParameter("provinceId")) == tab.getParId())?"SELECTED":"")) %> 
		                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT>
		                              	</td></tr>
                              		<tr align="center"><td></td></tr>
                              	</table>
                              	</td>
                            </tr>
                            <tr>
                              <td colspan="3" align="center" > 
	                              <table>
	                              	 <tr>
	                              	 	<td>วันที่&nbsp;&nbsp;</td>
	                              	 	<td>
	                              	 		<input type="text" value="" class="disabletext" readonly name="sdate" id="sdate" onfocus="displayCalendar(document.ReportControl.sdate,'dd/mm/yyyy',this)" onchange="getDateShow('sdate')">
	                              	 	</td>
	                              	 	<td>&nbsp;&nbsp;&nbsp; ถึง  &nbsp;&nbsp;&nbsp;</td>
	                              	 	<td>
	                              	 		<input type="text" value="" class="disabletext" readonly name="edate" id="edate" onfocus="displayCalendar(document.ReportControl.edate,'dd/mm/yyyy',this)" onchange="getDateShow('edate')">
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
                                <input name="reportLogo" type="hidden" id="reportLogo" value="<%=reportLogo%>">
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
				document.location="../Reload.jsp?url=reports/CustomerListRP.jsp&msg=Reloading";
			}else{
				document.location="../index.jsp";
			}
		}
</script>