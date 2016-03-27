<%@ page contentType="text/html; charset=tis-620" language="java"%>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.TestManager"/>
<% String action = request.getParameter("action"); %>
<%@page import="com.insurance.entity.Test"%>

<%@page import="java.util.Vector"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head> 
<body>
<form action="?" method="post" name="searchform" id="searchform">
<input name="name" type="text" class="name" id="desc" size="40" maxlength="255">

<% 
if(action != null) {
	Test et = new Test();
	et.setName(request.getParameter("name"));
	Vector entities = queryBean.getTest(et);
	for(int i = 0;i < entities.size();i++) {
		Test entity = (Test)entities.elementAt(i);
		out.print(entity.getId()+" : "+entity.getName());
	}
}
	%>
</form>
</body>
</html>