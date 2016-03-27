<%@page contentType="text/html; charset=TIS-620"%>
<%@page pageEncoding="TIS-620"%>
<%@page import="java.util.*"%>
<jsp:directive.page import="com.insurance.entity.Customer"/>
<jsp:directive.page import="com.standard.util.ShowData"/>
<jsp:directive.page import="com.insurance.manage.ParameterManager"/>
<jsp:directive.page import="com.insurance.entity.ParameterDetail"/>
<jsp:directive.page import="com.standard.util.StringUtil"/>
<jsp:directive.page import="com.insurance.entity.License"/>
<jsp:directive.page import="com.insurance.entity.Fire"/>
<jsp:directive.page import="com.insurance.entity.Life"/>
<html>
<head>
	<title><jsp:include page="../title.jsp" /></title>
	<link href="../site.css" rel="stylesheet" type="text/css">
</head>

<body onLoad="MM_preloadImages('../images/home_hover.gif')">
  <%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.CustomerManager"/>
<%
	if(!userBean.authenticated()){
	    response.sendRedirect("../login.jsp?url=setup/CustomerMultiMT.jsp");
	}
	  //response.setCharacterEncoding("tis-620"); 
	    Customer cEntity = queryBean.getCustomer(Integer.parseInt(request.getParameter("custId")));
	    Vector vLicenses = cEntity.getLicenses();
	    Vector vFires = cEntity.getFires();
	    Vector vLives = cEntity.getLives();
        ParameterManager pManage = new ParameterManager();
        String prefix=null;
        if (cEntity.getPrefix()==0) {
        	prefix="";
        } else {
        	Vector prefixs = pManage.getParamDetail(new ParameterDetail(3,cEntity.getPrefix()));
        	prefix = ((ParameterDetail)prefixs.elementAt(0)).getParName();
        }
        
	%>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td bgcolor="#F6F6EB" align="left" valign="top"> 
           <table width="100%" border="0" cellpadding="0" cellspacing="10" >
              <tr> 
              	<td width="100" align="center"> 
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="adddataform" id="adddataform">
                          <table width="700" border="0" cellpadding="0" cellspacing="0">
                            <tr class="lineborder"> 
                              <td width="20%" align="right"><font face="Microsoft Sans Serif">ชื่อ-นามสกุล&nbsp;:&nbsp;</font></td>
                              <td width="70%"><font face="Microsoft Sans Serif"><%= prefix+ShowData.CheckNull(cEntity.getName()) %></font></td>                          
                              <td width="10%" nowrap>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" valign="top" nowrap><font face="Microsoft Sans Serif">ที่อยู่ปัจจุบัน &nbsp;:&nbsp;</font></td>
                              <td><font face="Microsoft Sans Serif"><%=StringUtil.replaceAll(ShowData.CheckNull(cEntity.getAddress()),"\n","<br>",true)+
                              											"<br>จ."+ShowData.CheckNull(cEntity.getProvinceName())+
                              											"<br>"+cEntity.getZipCode()%></font></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เบอร์ติดต่อ&nbsp;:&nbsp; </font></td>
                              <td><font face="Microsoft Sans Serif"><%=ShowData.CheckNull(cEntity.getTel())%> </font></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center">
                            	</td>
                            </tr>
                          </table>
                          </td>
                    </tr>
                    <tr>
                    	<td>
			              <table width="900" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr class="lineborder"> 
                            	<td align="center" bgcolor="#000080">
                            		<b><font color="#FFFFFF">ประกันภัยรถ</font><b>
                            	</td>
                            </tr>
			              	<tr align="center"> 
			              		<td align="left">
			              			<table width="100%" bordercolor="#FFFFFF" bgcolor="#000080" border="1" cellspacing="0">
			              				<tr align="center">
							                <td width="4%" rowspan="2"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ลำดับ</font></b></td>
							                <td width="5%" rowspan="2"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ปีหมดอายุ</font></b></td>
							                <td width="6%" rowspan="2"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ทะเบียน</font></b></td>
							                <td width="16%" colspan="2"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ภาษี</font></b></td>
							                <td width="26%" colspan="3"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ประกัน/คุ้มครอง</font></b></td>
							                <td width="26%" colspan="3"><b><font face="Microsoft Sans Serif" color="#FFFFFF">พรบ./คุ้มครอง</font></b></td>
							                <td width="16%" colspan="2"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ตรอ.</font></b></td>
							        	</tr>
							        	<tr align="center">
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ภาษี/บริการ</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ประเภท/บริษัท</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ค่าบริการ</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">บริษัท</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ค่าบริการ</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ค่าบริการ</font></b></td>
							        	</tr>
						        	</table>
				                </td>
			              	</tr>
				           	<tr valign="top" align="left"> 
				            	<td align="left" colspan="9">
				              		<table width="100%" border="1" bordercolor="#000080" cellpadding="0" cellspacing="0">
				              			<%
				              				for(int i=0;i < vLicenses.size();i++) {
				              					License eLicense = (License)vLicenses.elementAt(i);
				              			%>
				              			<tr align="center">
				              				<td width="4%"><%= (i+1) %></td>
				              				<td width="5%"><%= eLicense.getYear() %></td>
				              				<td width="6%"><%= ShowData.CheckNull(eLicense.getLicense()) %></td>
				              				<td width="8%"><%= ShowData.CheckNull(eLicense.getVat(),"-") %></td>
				              				<td width="8%"><%= (eLicense.getVatPrice()==-1?"-":eLicense.getVatPrice())+"<br>"+(eLicense.getVatService()==-1?"-":eLicense.getVatService()) %></td>
				              				<td width="8%"><%= ShowData.CheckNull(eLicense.getCar(),"-") %></td>
				              				<td width="10%"><%= (eLicense.getLtype()==-1?"-":pManage.getParamName(4,eLicense.getLtype()))+"<br>"+(eLicense.getLcomp()==-1?"-":pManage.getParamName(5,eLicense.getLcomp()))  %></td>
				              				<td width="8%"><%= eLicense.getCarPrice()==-1?"-":eLicense.getCarPrice() %></td>
				              				<td width="8%"><%= ShowData.CheckNull(eLicense.getAct(),"-") %></td>
				              				<td width="10%"><%= eLicense.getLact()==-1?"-":pManage.getParamName(6,eLicense.getLact()) %></td>
				              				<td width="8%"><%= eLicense.getActPrice()==-1?"-":eLicense.getActPrice() %></td>
				              				<td width="8%"><%= ShowData.CheckNull(eLicense.getChk(),"-") %></td>
				              				<td width="8%"><%= eLicense.getChkPrice()==-1?"-":eLicense.getChkPrice() %></td>
				              			</tr>
				              			<%
				              				}
				              			%>
				              		</table>
				              	</td>
				            </tr>
                          </table>
                        </td>
                    </tr>
                    <tr class="lineborder"> 
                      <td></td>
                    </tr>
                    <tr>
                    	<td>
			              <table width="900" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr class="lineborder"> 
                            	<td align="center" bgcolor="#C80000">
                            		<b><font color="#FFFFFF">ประกันอัคคีภัย</font><b>
                            	</td>
                            </tr>
			              	<tr align="center"> 
			              		<td align="left">
			              			<table width="100%" bordercolor="#FFFFFF" bgcolor="#C80000" border="1" cellspacing="0">
			              				<tr align="center">
							                <td width="4%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ลำดับ</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ปีหมดอายุ</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="15%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">บริษัท</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ค่าบริการ</font></b></td>
							        	</tr>
						        	</table>
				                </td>
			              	</tr>
				           	<tr valign="top" align="left"> 
				            	<td align="left" colspan="9">
				              		<table width="100%" border="1" bordercolor="#C80000" cellpadding="0" cellspacing="0">
				              			<%
				              				for(int i=0;i < vFires.size();i++) {
				              					Fire eFire = (Fire)vFires.elementAt(i);
				              			%>
				              			<tr align="center">
				              				<td width="4%"><%= (i+1) %></td>
				              				<td width="8%"><%= eFire.getYear() %></td>
				              				<td width="10%"><%= ShowData.CheckNull(eFire.getFire(),"-") %></td>
				              				<td width="15%"><%= eFire.getInsurer()==-1?"-":pManage.getParamName(5,eFire.getInsurer()) %></td>
				              				<td width="10%"><%= eFire.getFirePrice()==-1?"-":eFire.getFirePrice() %></td>
				              			</tr>
				              			<%
				              				}
				              			%>
				              		</table>
				              	</td>
				            </tr>
                          </table>
                        </td>
                    </tr>
                    <tr class="lineborder"> 
                      <td></td>
                    </tr>
                    <tr>
                    	<td>
			              <table width="900" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr class="lineborder"> 
                            	<td align="center" bgcolor="#00A854">
                            		<b><font color="#FFFFFF">ประกันเอื้ออารีย์</font><b>
                            	</td>
                            </tr>
			              	<tr align="center"> 
			              		<td align="left">
			              			<table width="100%" bordercolor="#FFFFFF" bgcolor="#00A854" border="1" cellspacing="0">
			              				<tr align="center">
							                <td width="4%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ลำดับ</font></b></td>
							                <td width="8%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ปีหมดอายุ</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">วันที่</font></b></td>
							                <td width="15%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">บริษัท</font></b></td>
							                <td width="10%"><b><font face="Microsoft Sans Serif" color="#FFFFFF">ค่าบริการ</font></b></td>
							        	</tr>
						        	</table>
				                </td>
			              	</tr>
				           	<tr valign="top" align="left"> 
				            	<td align="left" colspan="9">
				              		<table width="100%" border="1" bordercolor="#00A854" cellpadding="0" cellspacing="0">
				              			<%
				              				for(int i=0;i < vLives.size();i++) {
				              					Life eLife = (Life)vLives.elementAt(i);
				              			%>
				              			<tr align="center">
				              				<td width="4%"><%= (i+1) %></td>
				              				<td width="8%"><%= eLife.getYear() %></td>
				              				<td width="10%"><%= ShowData.CheckNull(eLife.getLife(),"-") %></td>
				              				<td width="15%"><%= eLife.getInsurer()==-1?"-":pManage.getParamName(5,eLife.getInsurer()) %></td>
				              				<td width="10%"><%= eLife.getLifePrice()==-1?"-":eLife.getLifePrice() %></td>
				              			</tr>
				              			<%
				              				}
				              			%>
				              		</table>
				              	</td>
				            </tr>
                          </table>
                        </td>
                    </tr>
                  </table></td>
              </tr>
            </table></td>
        </tr>
      </table></td>
  </tr>
</table>
</body>
</html>
