<%@ page contentType="text/html; charset=tis-620" language="java"%>
<% request.setCharacterEncoding("tis-620"); %>

<html>
<head>
<title><jsp:include page="title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="site.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.style1 {color: #CCCCCC}
-->
</style>
</head>

<body>
<meta http-equiv="refresh" content="1;URL=<%=request.getAttribute("url")%>">
<table width="500" height="200" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" height="200" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b><jsp:include page="title.jsp" /></b></span></td>
        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="200" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td align="center"><%=request.getAttribute("msg")%></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
