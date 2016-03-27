<%@ page contentType="text/html; charset=tis-620" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="com.insurance.entity.*" %>
<jsp:directive.page import="com.standard.util.ShowData"/>
<jsp:directive.page import="com.insurance.manage.ParameterManager"/>
<% request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.CustomerManager"/>
<% 
if(!userBean.authenticated()){
    response.sendRedirect("../login.jsp?url=lov/CustLOV.jsp?cname=" + request.getParameter("cname") );
}
%>
<%-------------------------%>
<%
String laction = request.getParameter("laction");
%>

<script language="JavaScript" type="text/JavaScript">
	var hexChars = "0123456789ABCDEF";
	function hex2dec(s) {
		return (hexChars.indexOf(s.charAt(0))*16+hexChars.indexOf(s.charAt(1)));
	}

	function hex2thai(s) {
		var ret='';
		var arr=s.split("|");
		for (var i=1;i<arr.length;i++)
		{
			ret=ret+String.fromCharCode(arr[i]);
		}
		return (ret);
	}
	function changText(s,f) {
		document.searchlov.cname.value=hex2thai(s);
		if (f != 'null') {
			document.searchlov.submit();
		}
	}
</script>
<html>
<head><script type='text/javascript' src='../script/scriptMobile.js'></script>
<title><jsp:include page="../title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="../site.css" rel="stylesheet" type="text/css">
</head>
<body onLoad="changText('<%= request.getParameter("cname") %>','<%= request.getParameter("first") %>')">
<table width="500" height="400" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> 
    	<table width="100%" height="400" border="0" cellspacing="1" cellpadding="5" valign="top" >
	        <tr> 
	          <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b>
	          <jsp:include page="../title.jsp" /></b></span></td>
	        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="400" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td width="100%" align="center"> 
                <table width="100%" border="0" cellpadding="0" cellspacing="2">
                    <tr> 
                      <td colspan="3" class="pagetitle">ลูกค้า</td>
                    </tr>
                    <tr> 
                      <td align="left" bordercolor="#D8D8C4" bgcolor="#D8D8C4" colspan="3">เลือก</td>                      
                    </tr>
                  </table>                
                		</td>
              		</tr>
					 <form action="?" method="post" name="searchlov" id="searchlov">
					     <input name="cname" type="hidden" class="text" id="cname" value="<%= ShowData.CheckNull(request.getParameter ( "cname" )) %>" >
					     <input name="laction" type="hidden" id="laction" value="search">									 
					</form>
              		<tr valign="top"> 
                <td align="center"><div scrollleft="0" scrolltop="0" align="left" style="border: 1px solid;border-color:#D8D8C4;OVERFLOW: scroll; WIDTH: 100%; HEIGHT: 350;background-color:#F6F6EB;"> 
                    <table width="450" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <%
					if(laction != null && laction.equals("search")){
						try{
							CustomerPage cust = new CustomerPage();
							cust.setName(request.getParameter("cname"));
							Vector entities = queryBean.searchCustomer(cust);
						    if (entities.size() == 0) {
						    %>
						    <script> window.close(); </script>
						    <%
						    }
						      for(int i = 0;i < entities.size();i++){
						          CustomerPage entity = (CustomerPage)entities.elementAt(i);
					%>
	                            <tr align="center">
              						<td width="50" align="center">
              							<input name="submitselect" type="submit" class="button" id="submitselect" value="เลือก" onclick="javascript:window.opener.location=('../setup/CustomerMultiMT.jsp?action=edit&custId=<%=entity.getCustId()%>' ); window.close();" />
           							</td>
	        						<td width="300" align="left"><%= "   "+ShowData.CheckNull(entity.getPrefixName())+ShowData.CheckNull(entity.getName(),"-") %></td>
        							<td width="100" align="left"><%= ShowData.CheckNull(entity.getLicense(),"-") %></td>
	                            <%		  }
								    	} catch(com.standard.STDException e){
								    		e.printStackTrace();
								    	}
							    	}
	                             %>
                    </table>
                  </div></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>