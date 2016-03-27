<%@ page contentType="text/html; charset=tis-620" language="java"%>
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
    response.sendRedirect("../login.jsp?url=setup/ParameterMT.jsp");
}
%>
<%-------------------------%>


<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.ParameterManager"/>
<%
String action = request.getParameter("action");
String subaction = request.getParameter("subaction");
%>

<html>
<head>
<title><jsp:include page="../title.jsp" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=tis-620">
<link href="../site.css" rel="stylesheet" type="text/css">
<script language="javaScript">
function Linkup()
{
	var number = document.searchform.tabid.selectedIndex;
//	if (document.searchform.tabid.options[number].value != -1)
		location.href = "?action=search&tabid="+document.searchform.tabid.options[number].value;
}
</script>
</head>
<script type='text/javascript' src='../script/scriptMobile.js'></script>

<body onLoad="MM_preloadImages('../images/help_f2.gif')">
<%
String username = userBean.getUsername();
//Vector vUser = (Vector)pum.get(username,"","");
//Mobile b = new Mobile(username);
//Vector vUser = userBean.getUserEntity();   //Vector)pum.get(b);
User a = userBean.getUserEntity();	//(User)vUser.elementAt(0);
System.out.println("action ===> "+action+"\tsubaction ===> "+subaction);
if(action != null){
	String msg = null;
    if(subaction != null){
        if(action.equals("add") && subaction.equals("insert"))
        {
        	ParameterDetail param = new ParameterDetail();
	param.setTabId(Integer.parseInt(request.getParameter("tabid")));
//        	param.setParId(Integer.parseInt(request.getParameter("parid")));
        	param.setParName(request.getParameter("desc"));
        	param.setUpdBy(username);
            msg = queryBean.insertParamDetail(param);
        }else if(action.equals("edit") && subaction.equals("update"))
        {
        	ParameterDetail param = new ParameterDetail();
	param.setTabId(Integer.parseInt(request.getParameter("tabid")));
        	param.setParId(Integer.parseInt(request.getParameter("parid")));
        	param.setParName(request.getParameter("desc"));
        	param.setUpdBy(username);
            msg = queryBean.updateParamDetail(param);
        }
    }    // end subaction
    if(action.equals("delete")){
        msg = queryBean.deleteParamDetail(Integer.parseInt(request.getParameter("tabid")),Integer.parseInt(request.getParameter("parid")));
    }

	if(msg != null){
%>
<meta http-equiv="refresh" content="1;URL=?action=search&tabid=<%=request.getParameter("tabid")%>&desc=<%=request.getParameter("desc")%>%>">
<table width="500" height="200" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" height="200" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td bgcolor="#D8D8C4" height="5%" align="center"> <span><b><jsp:include page="../title.jsp" /></b></span></td>
        </tr>
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> <table width="100%" height="200" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
                <td align="center"><%=msg%></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
<%
} // end msq != null
}	// end action
try{
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
                      <td colspan="2" class="pagetitle">Parameter Setup</td>
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
                              <td width="80" align="right" nowrap>ประเภทข้อมูล :</td>
                              <td width="100"> 
                              <SELECT NAME="tabid" SIZE="1" onchange="Linkup(this.form);" >
                              	<OPTION <%=(((action==null)||(request.getParameter("tabid").equals("-1")))?"SELECTED":"")%> 
                              			VALUE="0" > - - - - - -   เลือก   - - - - - - </OPTION>
                              	<%
                              	                              	                            	    ParameterManager manage = new ParameterManager();
                              	                              	                            	    Vector tabs = manage.getAllParamHeader();
                              	                              	                            	    for (int i=0;i<tabs.size();i++) {
                              	                              	                            	    	ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
                              	%>
                            	<OPTION <%=(request.getParameter("tabid")==null?"":((Integer.parseInt(request.getParameter("tabid")) == tab.getTabId())?"SELECTED":""))%> 
                            		VALUE="<%=tab.getTabId()%>" > <%=tab.getTabName()%> </OPTION>
                            	<%
                            	}
                            	%>
                              	</SELECT>
 							  </td>
                              <td width="75" nowrap> รายละเอียด :</td>
                              <td width="250"> <input name="desc" type="text" class="text" id="desc" size="40" maxlength="255"></td>
                              <td width="122"> <input name="submitsearch" type="submit" class="button" id="submitsearch" value="ค้นหา"> 
                              <input name="action" type="hidden" id="action" value="search"></td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table>
                 </td>
              </tr>
              <tr> 
                <td align="left" bgcolor="#F6F6EB">
                	<% if ((request.getParameter("tabid")!=null)&&(!request.getParameter("tabid").equals("0"))) { %>
                    	<a href="?action=add&tabid=<%=request.getParameter("tabid")%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('add','','../images/new_f2.gif',1)"><img src="../images/new.gif" alt="เพิ่มรายการ" name="add" width="24" height="24" hspace="0" vspace="0" border="0" id="add"></a> 
                    <% } %>
                  </td>
              </tr>
              <tr> 
                <td align="left" bgcolor="#F6F6EB"><table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                    <tr align="center"> 
                      <td width="3">ลำดับ</td>
                      <td width="500">รายละเอียด</td>
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
                                    	ParameterDetail param = new ParameterDetail();
                                    	param.setTabId(request.getParameter("tabid")==null?-1:Integer.parseInt(request.getParameter("tabid")));
                                    	//param.setParId(Integer.parseInt(request.getParameter("parid")==null?"-1":request.getParameter("tabid")));
                                    	param.setParId(-1);
                                    	param.setParName(request.getParameter("desc"));
                                    	
                                        Vector entities = queryBean.searchParamHeader(param);
                                                
                                          for(int i = 0;i < entities.size();i++){
                                              ParameterDetail entity = (ParameterDetail)entities.elementAt(i);
            %>
      <tr> 
        <td width="50" align="right"><%=(i+1)%></td>
        <td width="500"><%= ShowData.CheckNull(entity.getParName(),"-") %></td>
        <td width="100" align="center"> <table width="100%" border="0" cellpadding="0" cellspacing="2">
            <tr align="center"> 
              <td>
                  <a href="?action=edit&tabid=<%=entity.getTabId()%>&parid=<%=entity.getParId()%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('edit<%=i%>','','../images/edit_f2.gif',1)" ><img src="../images/edit.gif" alt="แก้ไข" name="edit<%=i%>" width="24" height="24" hspace="0" vspace="0" border="0" id="edit<%=i%>"></a> 
              </td>
              <td>
                  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%=i%>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%=entity.getParName()%>')) MM_goToURL('parent','?action=delete&tabid=<%=entity.getTabId()%>&parid=<%=entity.getParId()%>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%=i%>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%=i%>"></a> 
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
                      <td colspan="2" class="pagetitle"><%=queryBean.getTableName(Integer.parseInt(request.getParameter("tabid")))%></td>
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
                                รหัส :</td>
                              <td width="100"> <input name="id" type="disabletext" class="disabletext" id="id" value="AUTO" size="10" maxlength="3"> 
                              </td>                                
                              <td width="65" nowrap> 
                              	
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font>รายละเอียด :</td>                                	
                              <td><input name="desc" type="text" class="text" id="desc" size="50" maxlength="255"></td>
                              <td width="65" nowrap> </td>
                               </tr>                               
                            <tr class="lineborder" > <td colspan="3"></td></tr>
                            <tr class="lineborder"> 
                              <td align="right">
                              	<input name="tabid" type="hidden" id="tabid" value="<%=request.getParameter("tabid")%>"> 
                              	<input name="action" type="hidden" id="action" value="add"> 
                              	<input name="subaction" type="hidden" id="subaction" value="insert"></td>
                              <td align="center">
                              	<input name="submitadd" type="submit" class="button" id="submitadd" onClick="MM_validateForm('desc','','R');return document.MM_returnValue" value="  เพิ่ม  "> 
                              	<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก">
                              </td>                              
                             <td width="65" nowrap> </td>
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
                      <td colspan="2" class="pagetitle"><%=queryBean.getTableName(Integer.parseInt(request.getParameter("tabid")))%></td>
                    </tr>
                    <tr> 
                      <td width="73" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">แก้ไขข้อมูล</td>
                      <td width="621" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <%
                                    	            		ParameterDetail paramEdit = new ParameterDetail();
                                    	            		paramEdit.setTabId(Integer.parseInt(request.getParameter("tabid")));
                                    	              		paramEdit.setParId(Integer.parseInt(request.getParameter("parid")));
                                                             Vector entitiesEdit = queryBean.getParamDetail(paramEdit);
                                                             if(entitiesEdit.size() > 0){
                                                                 ParameterDetail param = (ParameterDetail)entitiesEdit.elementAt(0);
                  %> <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="editdataform" id="editdataform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td width="77" align="right" nowrap><font color="#FF0000">*</font> 
                                รหัส :</td>
                              <td width="100"> <input name="parid" type="text" class="disabletext" id="parid" value="<%= param.getParId() %>" size="10" maxlength="3" readonly="true"> 
                              </td>            
                              <td width="65" nowrap> 
                              	
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font color="#FF0000">*</font> 
                                	รายละเอียด :</td>
                              <td>
                              <input name="desc" type="text" class="text" id="desc" value="<%=param.getParName()%>" size="50" maxlength="255" >
                              </td>                           
                              <td width="65" nowrap> </td>
                              
                            </tr>
                            <tr class="lineborder" > <td colspan="3"></td></tr>
                            <tr class="lineborder"> 
                              <td align="right">
                              	<input name="tabid" type="hidden" id="tabid" value="<%= request.getParameter("tabid") %>"> 
                              	<input name="action" type="hidden" id="action3" value="edit"> 
                              	<input name="subaction" type="hidden" id="subaction3" value="update">&nbsp;</td>
                              <td align="center">
                              	<input name="submitsedit" type="submit" class="button" id="submitsedit2" onClick="MM_validateForm('id','','R','desc','','R','goodstype','','R','unitid','','R');return document.MM_returnValue" value=" แก้ไข "> &nbsp;
                              	<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>                               
                              <td width="65" nowrap> </td>
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
}catch(com.standard.STDException e){
	e.printStackTrace();
}
%>
</body>
</html>
