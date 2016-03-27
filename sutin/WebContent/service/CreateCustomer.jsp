<%@page contentType="text/html; charset=TIS-620"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="com.insurance.entity.*"%>
<%@page import="com.insurance.manage.*"%>
<html>
<head>
	<title><jsp:include page="../title.jsp" /></title>
	<link href="../site.css" rel="stylesheet" type="text/css">
	<script type='text/javascript' src='../setup/scriptMobile.js'></script>
</head>

<body onLoad="MM_preloadImages('../images/home_hover.gif')">
<form  action="../ServiceOrderServlet" method="post" name="ServiceOrder" onSubmit="submitAndReload()">
  <%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<jsp:useBean id="con"  scope="session"  class="com.standard.db.DBControl" />
<%
	if(!userBean.authenticated()){
	    response.sendRedirect("../login.jsp?url=service/CreateServiceOrder.jsp");
	}
	  //response.setCharacterEncoding("tis-620"); 
      	CustomerManager serviceOrderManager = new CustomerManager();      	
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
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">เพิ่มข้อมูล</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="adddataform" id="adddataform">
                          <table width="700" border="0" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td width="20%" align="right"><font color="#FF0000">*</font> <font face="Microsoft Sans Serif">ชื่อลูกค้า</font></td>
                              <td width="70%">                               
		                              <SELECT NAME="prefix" SIZE="1" >
		                              	<%
		  	                              	     ParameterManager manage = new ParameterManager();
		  	                              	     //ParameterDetail et = new ParameterDetail(1,2);
		  	                              	     //out.println(et.getTabId()+"  "+et.getParId());
		  	                              	     Vector prefixs = manage.getParamDetail(new ParameterDetail(3,-1));
		  	                              	     for (int i=0;i<prefixs.size();i++) {
		  	                              	          ParameterDetail prefix = (ParameterDetail)prefixs.elementAt(i);
		                              	%>
		                            	<OPTION <%= (request.getParameter("prefix")==null?"":((Integer.parseInt(request.getParameter("prefix")) == prefix.getParId())?"SELECTED":"")) %> 
		                            		VALUE="<%= prefix.getParId() %>" > <%= prefix.getParName() %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT>
		                              	<input name="custname" type="text" class="text" id="custname" size="50" maxlength="100" value="" onchange="listCust('adddataform',adddataform.custname.value)"> 		                              	 
                              	 <!--a href="#" onclick="listCust('adddataform',adddataform.custname.value)"> เช็คชื่อ  </a> -->
                              	</td>                          
                              <td width="10%" nowrap>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เบอร์ติดต่อ </font></td>
                              <td><input name="tel" type="text" class="text" id="tel" size="50" maxlength="50"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" valign="top" nowrap><font face="Microsoft Sans Serif">ที่อยู่ </font></td>
                              <td><textarea cols="40" rows="5" name="address" type="text" class="text" value="" ></textarea></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">จังหวัด </font></td>
                              <td>
		                              <SELECT NAME="provinceId" SIZE="1" >
		                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกจังหวัด   - - - </OPTION>
		                              	<%
		  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
		  	                              	     for (int i=0;i<tabs.size();i++) {
		  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
		                              	%>
		                            	<OPTION VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">รหัสไปรษณีย์ </font></td>
                              <td><input name="zipcode" type="number" class="number" id="zipcode" size="10" maxlength="5" onchange="checkZipcode(adddataform.zipcode)"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center" bgcolor="#D8D8C4">
                            		<b>ประกันภัยรถ<b>
                            	</td>
                            </tr>
                            <tr class="lineborder" bordercolor="black" background="gray"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" > ทะเบียนรถ</td>
                            </tr>
                            <tr class="lineborder" > 
                              <td > 
                              <input name="license1" type="text" class="text" id="license1" size="3" maxlength="3"  onchange="checkLicense('adddataform')">
                              - <input name="license2" type="text" class="text" id="license2" size="5" maxlength="4"  onchange="checkLicense('adddataform')">
                              <input name="license" type="hidden" class="text" id="license" size="15" maxlength="10" ></td>                          
                              <td align="left" colspan="2">
	                              <SELECT NAME="brand" SIZE="1" onchange="chkLicense('adddataform',adddataform.license,adddataform.brand,'-1')">
	                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกยี่ห้อรถ   - - - </OPTION>
	                              	<%
	  	                              	     manage = new ParameterManager();
	  	                              	     Vector brands = manage.getParamDetail(new ParameterDetail(2,-1));
	  	                              	     for (int i=0;i<brands.size();i++) {
	  	                              	          ParameterDetail ebrand = (ParameterDetail)brands.elementAt(i);
	                              	%>
	                            	<OPTION VALUE="<%= ebrand.getParId() %>" > <%= ebrand.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
	                            	 ประกันภัย<input type="text" value="" class="disabletext" readonly name="car" id="car" onfocus="displayCalendar(document.adddataform.car,'dd/mm/yyyy',this)" onchange="getDateShow('car')">
	                              	ภาษี<input type="text" value="" class="disabletext" readonly name="vat" id="vat" onfocus="displayCalendar(document.adddataform.vat,'dd/mm/yyyy',this)" onchange="getDateShow('vat')">                              	
	                            </td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td></td>
                            	<td colspan="2">
                              <SELECT NAME="ltype" SIZE="1">
                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกประเภทประกัน   - - - </OPTION>                              	<%
  	                              	     Vector types = manage.getParamDetail(new ParameterDetail(4,-1));
  	                              	     for (int i=0;i<types.size();i++) {
  	                              	          ParameterDetail etype = (ParameterDetail)types.elementAt(i);
                              	%>
                            	<OPTION VALUE="<%= etype.getParId() %>" > <%= etype.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              <SELECT NAME="lcomp" SIZE="1">
                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกบริษัทประกัน   - - - </OPTION>                              	<%
  	                              	     Vector comps = manage.getParamDetail(new ParameterDetail(5,-1));
  	                              	     for (int i=0;i<comps.size();i++) {
  	                              	          ParameterDetail ecomp = (ParameterDetail)comps.elementAt(i);
                              	%>
                            	<OPTION VALUE="<%= ecomp.getParId() %>" > <%= ecomp.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              	</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td></td>
                            	<td>
	                              <SELECT NAME="lact" SIZE="1">
	                              	<OPTION "SELECTED" VALUE="-1" > - - -  เลือกบริษัท พ.ร.บ.  - - - </OPTION>                              	<%
	  	                              	     Vector acts = manage.getParamDetail(new ParameterDetail(6,-1));
	  	                              	     for (int i=0;i<acts.size();i++) {
	  	                              	          ParameterDetail eact = (ParameterDetail)acts.elementAt(i);
	                              	%>
	                            	<OPTION VALUE="<%= eact.getParId() %>" > <%= eact.getParName() %> </OPTION>
	                            	<%  }%>
	                              	</SELECT> 
	                              	&nbsp;&nbsp;  พ.ร.บ. <input type="text" value="" class="disabletext" readonly name="act" id="act" onfocus="displayCalendar(document.adddataform.act,'dd/mm/yyyy',this)" onchange="getDateShow('act')">    
                              	</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center" bgcolor="#D8D8C4">
                            		<b>ประกันอัคคีภัย<b>
                            	</td>
                            </tr>
                            <tr class="lineborder" bordercolor="black" background="gray"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="center">ประกันอัคคีภัย</td>                            	                       
                              <td width="15%" align="left"> 
                              <input type="text" value="" class="disabletext" readonly name="fire" id="fire" onfocus="displayCalendar(document.adddataform.fire,'dd/mm/yyyy',this)" onchange="getDateShow('fire')"></td>
                            	<td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td></td>
                              <td>
                              	<input name="submitadd" type="submit" class="button" id="submitadd" onClick="MM_validateForm('custname','ชื่อ','R','address','ที่อยู่','R');return document.MM_returnValue" value="  เพิ่ม  "> 
                              	<input name="custId" type="hidden" id="custId" value=""> 
                              	<input name="action" type="hidden" id="action" value="add"> 
                              	<input name="subaction" type="hidden" id="subaction" value="insert">
                              	<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">&nbsp;</td>
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
<input  class="disabletext"  type="hidden"  value="ADD"   name="DO">
</form>
								 
</body>

</html>

<script language="javascript">

	function listCust(returnPosition, name) {

		winpopup = window.open('','popup','height=400,width=500,menubar=no,scrollbars=no,status=no,toolbar=no,screenX=100,screenY=100,left=100,top=100');
		winpopup.document.write('<html>');
		winpopup.document.write('<head><title>JSP Page</title></head>');
		winpopup.document.write('<body>');
		winpopup.document.write('<form name="list" action="../lov/CustLOV.jsp">');
		winpopup.document.write('<input name="returnpos" type="hidden" value="'+returnPosition+'">');
		winpopup.document.write('<input name="cname" id="cname" type="hidden" value="'+thai(name)+'">');
		winpopup.document.write('<input name="first" id="first" type="hidden" value="'+1+'">');
		winpopup.document.write('</form>');
		winpopup.document.write('</body>');
		winpopup.document.write('<script>document.list.submit();<\/script>');
		winpopup.document.write('</html>');
		winpopup.document.close();	
	}
	
	function listLicense(license) {

		winpopup = window.open('','popup','height=400,width=500,menubar=no,scrollbars=no,status=no,toolbar=no,screenX=100,screenY=100,left=100,top=100');
		winpopup.document.write('<html>');
		winpopup.document.write('<head><title>JSP Page</title></head>');
		winpopup.document.write('<body>');
		winpopup.document.write('<form name="list" action="../lov/LicenseLOV.jsp">');
		winpopup.document.write('<input name="clicense" id="clicense" type="hidden" value="'+thai(license)+'">');
		winpopup.document.write('<input name="first" id="first" type="hidden" value="'+1+'">');
		winpopup.document.write('</form>');
		winpopup.document.write('</body>');
		winpopup.document.write('<script>document.list.submit();<\/script>');
		winpopup.document.write('</html>');
		winpopup.document.close();	
	}
	
	function checkZipcode(zipObj){
		  if(isInteger(zipObj))
		  {
		     zipObj.value = zipObj.value;
	      } else {
	      	zipObj.value = '';
	      }
	}
	
	function chkLicense(option,lObj,mObj,resetValue)
	{
		if(lObj.value=='') {
			alert('กรุณาใส่ข้อมูลทะเบียนรถ');
			mObj.value=resetValue;
			if (option=='adddataform') {
				if (document.adddataform.license1.value=='' || document.adddataform.license2.value=='') {
					alert('กรุณาใส่ข้อมูลทะเบียนรถ');
				}
				document.adddataform.license.focus();
			}
		}
	}
	
	function checkLicense(option,pos)
	{ 
		if (option=='adddataform') {
			if (document.adddataform.license1.value=='' && document.adddataform.license2.value=='') {
				document.adddataform.elements["brand"].value='-1';
				document.adddataform.elements["vat"].value='';
				document.adddataform.elements["car"].value='';
				document.adddataform.elements["ltype"].value='';
				document.adddataform.elements["lcomp"].value='';
				document.adddataform.elements["lact"].value='';
				document.adddataform.license.value = '';
			} else {
				document.adddataform.license.value = document.adddataform.license1.value+'-'+document.adddataform.license2.value;
				if (document.adddataform.license1.value!='' && document.adddataform.license2.value!='') {
					listLicense(document.adddataform.license1.value+'%-%'+document.adddataform.license2.value);
				}
			}
		}
	}
</script>

