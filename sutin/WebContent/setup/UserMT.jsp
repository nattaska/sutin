<%@ page contentType="text/html; charset=tis-620" language="java"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.insurance.entity.*" %>
<%@ page import="com.standard.util.*" %> 
<% //request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<%
if(!userBean.authenticated()){
    response.sendRedirect("../login.jsp?url=setup/UserMT.jsp");
}
%>
<%-------------------------%>


<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.UserManager"/>
<%
String action = request.getParameter("action");
String subaction = request.getParameter("subaction");
%>

<html>
<head>
<title><jsp:include page="../title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="../site.css" rel="stylesheet" type="text/css">
</head>
<script type='text/javascript' src='../script/scriptMobile.js'></script>

<body onLoad="MM_preloadImages('../images/help_f2.gif')">
<%
String username = userBean.getUsername();
User a = userBean.getUserEntity();			//(User)vUser.elementAt(0);

if(action != null){
	String msg = null;
    if(subaction != null){
        if(action.equals("add") && subaction.equals("insert"))
        {
        	User user = new User(request.getParameter("id"));
        	user.setName(request.getParameter("name"));
        	user.setTel(request.getParameter("tel"));
        	user.setPassword(request.getParameter("password"));
        	user.setPosition(request.getParameter("position"));
        	user.setStatus(request.getParameter("status"));
        	user.setActive(request.getParameter("active") == null ? 0 : 1);
        	user.setUpdBy(username);
            msg = queryBean.insertUser(user);
        }else if(action.equals("edit") && subaction.equals("update"))
        {
       // System.out.println(Integer.parseInt(request.getParameter("active") == null ? "0" : "1"));
        	User user = new User(request.getParameter("id"));
        	user.setName(request.getParameter("name"));
        	user.setTel(request.getParameter("tel"));
        	user.setPassword(request.getParameter("password"));
        	user.setPosition(request.getParameter("position"));
        	user.setStatus(request.getParameter("status"));
        	user.setActive(request.getParameter("active") == null ? 0 : 1);
        	user.setUpdBy(username);
            msg = queryBean.updateUser(user);
        }
    }    // end subaction
    if(action.equals("delete")){
        msg = queryBean.deleteUser(new User(request.getParameter("id")));
    }

	if(msg != null){
%>
<meta http-equiv="refresh" content="1;URL=?action=search&id=<%= request.getParameter("id") %>&name=<%= request.getParameter("name") %>&status=<%= request.getParameter("status") %>&active=<%= (request.getParameter("active") == null ? "0" : request.getParameter("active")) %>">
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
}	// end action

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
                      <td colspan="2" class="pagetitle">พนักงาน</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">ค้นหา</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="searchform" id="searchform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td width="80" align="right" nowrap>รหัสพนักงาน :</td>
                              <td width="100"> <input name="id" type="text" class="text" id="id" size="20" maxlength="20"> 
                              </td>
                              <td width="79" align="right" nowrap>ชื่อพนักงาน :</td>
                              <td width="250"> <input name="name" type="text" class="text" id="name" size="40" maxlength="255"></td>
                              <td width="75" nowrap> 
											<%
												String chkString[] = {"",""};
												if(request.getParameter("active")!=null)
												{
													if(request.getParameter("active").equals("0"))
														chkString[1] = "checked";
													else
														chkString[0] = "checked";
												}else
													chkString[0] = "checked";
											%>
                             
	                              	<table>
	                              		<tr>
	                              			<td><input name="active" type="radio" value="1" <%=chkString[0]%>>Active</td>
	                              			<td><input name="active" type="radio" value="0" <%=chkString[1]%>>Inactive</td>
                            			</tr>
                            		</table>
                              </td>                           
                              <td width="122"> <input name="submitsearch" type="submit" class="button" id="submitsearch" value="ค้นหา"> 
                                <input name="action" type="hidden" id="action" value="search"></td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td align="left" bgcolor="#F6F6EB">
                    <a href="?action=add" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('add','','../images/new_f2.gif',1)"><img src="../images/new.gif" alt="เพิ่มรายการ" name="add" width="24" height="24" hspace="0" vspace="0" border="0" id="add"></a> 
                  </td>
              </tr>
              <tr> 
                <td align="left" bgcolor="#F6F6EB"><table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                    <tr align="center"> 
                      <td width="3">ลำดับ</td>
                      <td width="150">รหัส</td>
                      <td width="500">ชื่อพนักงาน</td>
                      <td width="500">ตำแหน่ง</td>
                      <td width="100">&nbsp;</td>
                    </tr>
                  </table></td>
              </tr>
              <tr valign="top"> 
                <td align="center"><div scrollleft="0" scrolltop="0" align="left" style="border: 1px solid;border-color:#D8D8C4;OVERFLOW: scroll; WIDTH: 100%; HEIGHT: 200;background-color:#F6F6EB;"> 
<%
		if(action != null && action.equals("search")){
%>
    <table width="700" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">      
      <%
//                  new String(iso.getBytes("ISO-8859-1"),"TIS-620")
	User user = new User(request.getParameter("id"));
	user.setName(request.getParameter("name"));
	System.out.println(request.getParameter("active"));
	user.setActive(Integer.parseInt((request.getParameter("active") == null || request.getParameter("active").equals("")) ? "0" : request.getParameter("active")));
	
      Vector entities = queryBean.searchUser(user);
            
      for(int i = 0;i < entities.size();i++){
          User entity = (User)entities.elementAt(i);
      %>
      <tr> 
        <td width="50" align="right"><%= (i+1) %></td>
        <td width="150"><%= entity.getUserId() %></td>
        <td width="500"><%= ShowData.CheckNull(entity.getName(),"-") %></td>
        <td width="500"><%= ShowData.CheckNull(entity.getPosition(),"-") %></td>
        <td width="100" align="center"> <table width="100%" border="0" cellpadding="0" cellspacing="2">
            <tr align="center"> 
              <td>
                  <a href="?action=edit&id=<%=entity.getUserId()%>&active=<%=entity.isActive()%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('edit<%= i %>','','../images/edit_f2.gif',1)" ><img src="../images/edit.gif" alt="แก้ไข" name="edit<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="edit<%= i %>"></a> 
              </td>
              <td>
                  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= i %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= entity.getName() %>')) MM_goToURL('parent','?action=delete&id=<%= entity.getUserId() %>')"><img src="../images/delete.gif" alt="??" name="delete<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= i %>"></a> 
                </td>
            </tr>
          </table></td>
      </tr>
      <%
    }
    %>
    </table>
<%
		}
%>
                  </div></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
}else if(action.equals("add") && (subaction == null)){
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
                      <td colspan="2" class="pagetitle">พนักงาน</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">เพิ่มข้อมูล</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="adddataform" id="adddataform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td width="77" align="right" nowrap><font color="#FF0000">*</font> 
                                รหัสพนักงาน : <br><font color="#FF0000">(ไม่เกิน 15 ตัว)</font></td>
                              <td width="100"> <input name="id" type="text" class="text" id="id" size="15" maxlength="15"> 
                              </td>                              
                              <td width="65" nowrap> 
                              	<input name="active" type="checkbox" id="active" value="1" checked>Active
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font> 
                                ชื่อพนักงาน :</td>
                              <td><input name="name" type="text" class="text" id="name" size="50" maxlength="200" onChange="listvalueGoodsType('adddataform.id',document.adddataform.id.value)"></td>
                              <td>&nbsp;</td>
                               </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>ตำแหน่ง : </td>
                              <td><input name="position" type="text" class="text" id="position" size="50" maxlength="50"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>เบอร์โทรศัพท์ : </td>
                              <td><input name="tel" type="text" class="text" id="tel" size="50" value="" maxlength="50"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>สถานะ : </td>
                              <td nowrap>
                              	<input type="radio" name="status" value="A"> Administrator 
                                <input type="radio" name="status" value="U" checked> User 
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font>รหัสผ่าน : </td>
                              <td><input name="password" type="password" class="text" id="password" size="15" value="" maxlength="50"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right">
                              	<input name="submitadd" type="submit" class="button" id="submitadd" onClick="MM_validateForm('id','','R','name','','R','password','','R');return document.MM_returnValue" value="เพิ่ม"> 
                              	<input name="action" type="hidden" id="action" value="add"> 
                              	<input name="subaction" type="hidden" id="subaction" value="insert"></td>
                              <td>
                              	<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right"></td>
                              <td>&nbsp;</td>
                              <td>&nbsp;</td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
}else if(action.equals("edit") && (subaction == null)){
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
                      <td colspan="2" class="pagetitle">พนักงาน</td>
                    </tr>
                    <tr> 
                      <td width="73" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">แก้ไขข้อมูล</td>
                      <td width="621" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <%
//                  new String(iso.getBytes("ISO-8859-1"),"TIS-620")
				User user = new User(request.getParameter("id"));
				user.setActive(Integer.parseInt(request.getParameter("active")));
                Vector entities = queryBean.getUser(user);
                if(entities.size() > 0){
                    User entity = (User)entities.elementAt(0);
                    String statusStr = "";
                    String statusUser = "";
                    String statusValue = "";
                    System.out.println("Status = "+entity.getStatus());
                    if(entity.isActive() == 1)
                    {
                        statusStr = "checked";
                        statusValue = "1";
                    }
                %> <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="editdataform" id="editdataform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td width="77" align="right" nowrap><font color="#FF0000">*</font>รหัสพนักงาน : <br><font color="#FF0000">(ไม่เกิน 15 ตัว)</font></td>
                              <td width="100"> 
                              	<input name="id" type="text" class="disabletext" id="id" value="<%= entity.getUserId() %>" size="15" maxlength="15" readonly="true"> 
                              </td>
                              
                              <td width="65" nowrap> 
                              	<input name="active" type="checkbox" id="active" value="<%=statusValue%>" <%=statusStr%>>Active
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font>ชื่อพนักงาน :</td>
                              <td>
                              <input name="name" type="text" class="text" id="name" value="<%=entity.getName()%>" size="50" maxlength="200">
                              <td></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>ตำแหน่ง : </td>
                              <td>
                              	<input name="position" type="text" class="text" id="position" value="<%=entity.getPosition()%>" size="50" maxlength="50">
                              </td>
                              <td></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>เบอร์โทรศัพท์ : </td>
                              <td><input name="tel" type="text" class="text" id="tel" value="<%= (entity.getTel()==null?"":entity.getTel()) %>" size="50" maxlength="50"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap>สถานะ : </td>
                              <td nowrap>
                              	<input name="status" type="radio" value="A" <% if(entity.getStatus().equals("A")) { out.print("checked"); } %>> Administrator 
                                <input type="radio" name="status" value="U" <% if(entity.getStatus().equals("U")) { out.print("checked"); } %>> User 
                              </td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font>รหัสผ่าน : </td>
                              <td><input name="password" type="password" class="text" id="password" size="15" maxlength="50" value="<%=entity.getPassword()%>"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right">
                              	<input name="submitsedit" type="submit" class="button" id="submitsedit2" onClick="MM_validateForm('id','','R','name','','R','password','','R');return document.MM_returnValue" value="แก้ไข"> 
                              	<input name="action" type="hidden" id="action3" value="edit"> 
                              	<input name="subaction" type="hidden" id="subaction3" value="update">&nbsp;</td>
                              <td>
                             	<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก">
                              </td>
                             
                              <td>&nbsp;</td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table>
                  <%
                 }
                 %> </td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
}
%>
</body>
</html>
