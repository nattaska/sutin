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
    response.sendRedirect("../login.jsp?url=setup/CustomerMultiMT.jsp");
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
	var hexChars = "0123456789ABCDEF";
	
	function Dec2Hex (Dec) {
		var a = Dec % 16;
		var b = (Dec - a)/16;
		hex = "" + hexChars.charAt(b) + hexChars.charAt(a);
		return hex;
	}
	
	function thai(s){
		s2='';
		//alert(s);
		for(var i=0;i<s.length;i++){
			s2+="|"+s.charCodeAt(i);
			//if(s.charCodeAt(i)>3423){
			//	n=s.charCodeAt(i)-3424;
			//	s2+='%'+Dec2Hex(n);
			//}else{
			//	s2+='%'+Dec2Hex(s.charCodeAt(i)); //s.charAt(i);
			//}
		}
		return s2
	} 
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
	
	function checkYearExp(yearObj){
		  if(isInteger(yearObj))
		  {
		  	 if(yearObj.value.length != 4) {
				alert('กรุณาใส่ปีหมดอายุให้ครบ 4 ตำแหน่ง'); 	
	      		yearObj.value = '';
	      	 } else {
		     	yearObj.value = yearObj.value;
		     }
	      } else {
	      	yearObj.value = '';
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
			} else if (option=='editdataform'){
				document.editdataform.license.focus();
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
		} else if (option=='editdataform'){
			if (pos=='') {
				document.editdataform.elements["license"].value = document.editdataform.elements["license1"].value+'-'+document.editdataform.elements["license2"].value;
				
				if (document.editdataform.elements["license"].value=='-') {
					document.editdataform.elements["brand"].value='-1';
					document.editdataform.elements["vat"].value='';
					document.editdataform.elements["car"].value='';
					document.editdataform.elements["license"].value = '';
					document.editdataform.elements["ltype"].value='-1';
					document.editdataform.elements["lcomp"].value='-1';
					document.editdataform.elements["lact"].value='-1';
				}
			} else {
				document.editdataform.elements["elicense"+pos].value = document.editdataform.elements["elicense1"+pos].value+'-'+document.editdataform.elements["elicense2"+pos].value;
				
				if (document.editdataform.elements["elicense"+pos].value=='-') {
					document.editdataform.elements["ebrand"+pos].value='-1';
					document.editdataform.elements["evat"+pos].value='';
					document.editdataform.elements["ecar"+pos].value='';
					document.editdataform.elements["elicense"+pos].value = '';
					document.editdataform.elements["eltype"+pos].value='-1';
					document.editdataform.elements["elcomp"+pos].value='-1';
					document.editdataform.elements["elact"+pos].value='-1';
				}
			}
		}
	}
	
	function chkPrice(priceObj){
		  if(isDecimal(priceObj))
		  {
		     priceObj.value = dpFormat('',priceObj.value, 2,0);
	      } else {
	      	priceObj.value = '';
	      }
	}
	
	function changesubact(subact,pos)
	{
		document.editdataform.elements["subaction"].value=subact;
		document.editdataform.elements["pos"].value=pos;
	}
	function getDateShow(param) {
		var tmpStr = document.getElementById(param).value.split("/");
//		document.getElementById(param).value=tmpStr[0]+"/"+tmpStr[1]+"/"+((tmpStr[2]*1)+543);
		document.getElementById(param).value=tmpStr[0]+"/"+tmpStr[1];
	}
	
</script>
<html>
<head>
<title><jsp:include page="../title.jsp" /></title>
<link href="../site.css" rel="stylesheet" type="text/css">
<link type="text/css" rel="stylesheet" href="../script/dhtmlgoodies_calendar.css?random=20051112" media="screen"></link>
</head>
<script type='text/javascript' src='../script/scriptMobile.js'></script>
<script type='text/javascript' src='../script/dhtmlgoodies_calendar.js'></script>
<body onLoad="MM_preloadImages('../images/help_f2.gif')">
<%

String username = userBean.getUsername();
User a = userBean.getUserEntity();
System.out.println("action ===> "+action+"\tsubaction ===> "+subaction);

if(action != null){
	String msg = null;
    if(subaction != null){
        if(action.equals("add") && subaction.equals("insert"))
        {
        	CustomerPage cust = new CustomerPage();
        	cust.setPrefix(Integer.parseInt(request.getParameter("prefix")));
        	cust.setName(request.getParameter("custname"));
        	cust.setTel(request.getParameter("tel"));
        	cust.setAddress(request.getParameter("address"));
        	cust.setProvince(Integer.parseInt(request.getParameter("provinceId")));
        	String zipcode = request.getParameter("zipcode");
        	cust.setZipCode((zipcode==null||zipcode.equals(""))?0:Integer.parseInt(zipcode));
        	cust.setCreBy(username);
        	cust.setUpdBy(username);
            msg = queryBean.insertCustomer(cust);
        }else if(action.equals("edit") && (subaction != null && !subaction.equals(""))) 
        {
        	if (subaction.equals("update")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	cust.setPrefix(Integer.parseInt(request.getParameter("prefix")));
	        	cust.setName(request.getParameter("custName"));
	        	cust.setTel(request.getParameter("tel"));
	        	cust.setAddress(request.getParameter("address"));
	        	cust.setProvince(Integer.parseInt(request.getParameter("provinceId")));
	        	String zipcode = request.getParameter("zipcode");
	        	cust.setZipCode((zipcode==null||zipcode.equals(""))?0:Integer.parseInt(zipcode));
	        	cust.setUpdBy(username);
	            msg = queryBean.updateCustomer(cust);
	        } else if (subaction.equals("addfire")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String yearexp = request.getParameter("fireyear");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setFireInsurer(Integer.parseInt(request.getParameter("fcomp")));
	        	cust.setFire(request.getParameter("fire"));
	        	cust.setFirePrice((request.getParameter("fireprice")==null||request.getParameter("fireprice").equals(""))?-1:Double.parseDouble(request.getParameter("fireprice")));
	        	cust.setCreBy(username);
	        	cust.setUpdBy(username);
	            msg = queryBean.insertFire(cust);
	        } else if (subaction.equals("editfire")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String pos = request.getParameter("pos");
	        	String yearexp = request.getParameter("efireyear"+pos);
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setFireInsurer(Integer.parseInt(request.getParameter("efcomp"+pos)));
	        	cust.setFire(request.getParameter("efire"+pos));
	        	cust.setFirePrice((request.getParameter("efireprice"+pos)==null||request.getParameter("efireprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("efireprice"+pos)));
	        	cust.setUpdBy(username);
	        	String oldeyear = request.getParameter("oldefireyear"+pos);
	        	int oldYear = (oldeyear==null||oldeyear.equals(""))?0:Integer.parseInt(oldeyear);
	            msg = queryBean.updateFire(cust,oldYear);
	        } else if (subaction.equals("deletefire")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String yearexp = request.getParameter("yearexp");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
        		msg = queryBean.deleteFire(cust,Customer.FIRE);
	        } else if (subaction.equals("addlicense")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	cust.setLicense(request.getParameter("license"));
	        	String yearexp = request.getParameter("yearexp");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setBrand(Integer.parseInt(request.getParameter("brand")));
	        	cust.setCar(request.getParameter("car"));
	        	cust.setVat(request.getParameter("vat"));
        		cust.setAct(request.getParameter("act"));
        		cust.setChk(request.getParameter("chk"));
	        	cust.setLtype(Integer.parseInt(request.getParameter("ltype")));
	        	cust.setLcomp(Integer.parseInt(request.getParameter("lcomp")));
	        	cust.setLact(Integer.parseInt(request.getParameter("lact")));
	        	cust.setCarPrice((request.getParameter("carprice")==null||request.getParameter("carprice").equals(""))?-1:Double.parseDouble(request.getParameter("carprice")));
	        	cust.setVatPrice((request.getParameter("vatprice")==null||request.getParameter("vatprice").equals(""))?-1:Double.parseDouble(request.getParameter("vatprice")));
        		cust.setActPrice((request.getParameter("actprice")==null||request.getParameter("actprice").equals(""))?-1:Double.parseDouble(request.getParameter("actprice")));
        		cust.setChkPrice((request.getParameter("chkprice")==null||request.getParameter("chkprice").equals(""))?-1:Double.parseDouble(request.getParameter("chkprice")));
        		cust.setVatService((request.getParameter("vatservice")==null||request.getParameter("vatservice").equals(""))?-1:Double.parseDouble(request.getParameter("vatservice")));
	        	cust.setComment(request.getParameter("comment"));
	        	cust.setCreBy(username);
	        	cust.setUpdBy(username);
	            msg = queryBean.insertLicense(cust);
	        } else if (subaction.equals("editlicense")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String pos = request.getParameter("pos");
	        	cust.setLicense(request.getParameter("elicense"+pos));
	        	String yearexp = request.getParameter("eyearexp"+pos);
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setBrand(Integer.parseInt(request.getParameter("ebrand"+pos)));
	        	cust.setCar(request.getParameter("ecar"+pos));
	        	cust.setVat(request.getParameter("evat"+pos));
	        	cust.setAct(request.getParameter("eact"+pos));
        		cust.setChk(request.getParameter("echk"+pos));
	        	cust.setLtype(Integer.parseInt(request.getParameter("eltype"+pos)));
	        	cust.setLcomp(Integer.parseInt(request.getParameter("elcomp"+pos)));
	        	cust.setLact(Integer.parseInt(request.getParameter("elact"+pos)));
	        	cust.setCarPrice((request.getParameter("ecarprice"+pos)==null||request.getParameter("ecarprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("ecarprice"+pos)));
	        	cust.setVatPrice((request.getParameter("evatprice"+pos)==null||request.getParameter("evatprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("evatprice"+pos)));
        		cust.setActPrice((request.getParameter("eactprice"+pos)==null||request.getParameter("eactprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("eactprice"+pos)));
        		cust.setChkPrice((request.getParameter("echkprice"+pos)==null||request.getParameter("echkprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("echkprice"+pos)));
        		cust.setVatService((request.getParameter("evatservice"+pos)==null||request.getParameter("evatservice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("evatservice"+pos)));
	        	cust.setComment(request.getParameter("ecomment"+pos));
	        	cust.setCreBy(username);
	        	cust.setUpdBy(username);
	        	String oldlicense = request.getParameter("oldelicense"+pos);
	        	String oldeyear = request.getParameter("oldeyear"+pos);
	        	int oldYear = (oldeyear==null||oldeyear.equals(""))?0:Integer.parseInt(oldeyear);
	            msg = queryBean.updateLicense(cust,oldlicense,oldYear,queryBean.UPDATE);
	        } else if (subaction.equals("deletelicense")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	cust.setLicense(request.getParameter("license"));
	        	String yearexp = request.getParameter("yearexp");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
        		msg = queryBean.deleteLicense(cust,Customer.CAR);
	        } else if (subaction.equals("addlife")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String yearexp = request.getParameter("lifeyear");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setLifeInsurer(Integer.parseInt(request.getParameter("lfcomp")));
	        	cust.setLife(request.getParameter("life"));
	        	cust.setLifePrice((request.getParameter("lifeprice")==null||request.getParameter("lifeprice").equals(""))?-1:Double.parseDouble(request.getParameter("lifeprice")));
	        	cust.setCreBy(username);
	        	cust.setUpdBy(username);
	            msg = queryBean.insertLife(cust);
	        } else if (subaction.equals("editlife")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String pos = request.getParameter("pos");
	        	String yearexp = request.getParameter("elifeyear"+pos);
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
	        	cust.setLifeInsurer(Integer.parseInt(request.getParameter("elfcomp"+pos)));
	        	cust.setLife(request.getParameter("elife"+pos));
	        	cust.setLifePrice((request.getParameter("elifeprice"+pos)==null||request.getParameter("elifeprice"+pos).equals(""))?-1:Double.parseDouble(request.getParameter("elifeprice"+pos)));
	        	cust.setUpdBy(username);
	        	String oldeyear = request.getParameter("oldelifeyear"+pos);
	        	int oldYear = (oldeyear==null||oldeyear.equals(""))?0:Integer.parseInt(oldeyear);
	            msg = queryBean.updateLife(cust,oldYear);
	        } else if (subaction.equals("deletelife")) {
	        	CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
	        	String yearexp = request.getParameter("yearexp");
	        	cust.setYear((yearexp==null||yearexp.equals(""))?0:Integer.parseInt(yearexp));
        		msg = queryBean.deleteLife(cust,Customer.FIRE);
	        }
        }
    }    // end subaction
    if(action.equals("delete")){
        CustomerPage cust = new CustomerPage(Integer.parseInt(request.getParameter("custId")));
        //cust.setLicense(request.getParameter("license"));
        msg = queryBean.deleteCustomer(cust);
    }

	if(msg != null){
		String custId = "";
	    if (msg.indexOf(":")!=-1) {
	    	String[] str = StringUtil.stringTokenToArray(msg, ":");
	    	custId=str[0];
	    	msg=str[1];
	    } else {
	    	custId=request.getParameter("custId");
	    }
		if (msg.indexOf("กรุณา") != -1||msg.indexOf("Error") != -1 || msg.indexOf("Insert Completed") != -1) {
%>
		 <meta http-equiv="refresh" content="1;URL=?action=edit&custId=<%= custId %>"> 
		 <% } else { %>
		 <meta http-equiv="refresh" content="1;URL=?action=search&custId=<%= custId %>"> 
		  <% }  %>
		
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
                <td width="100" align="center"> 
                  <table width="700" border="0" cellpadding="0" cellspacing="2">
                    <tr> 
                      <td colspan="2" class="pagetitle">ลูกค้า</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">ค้นหา</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="800" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="searchform" id="searchform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td>
                              	<table width="80%" border="0" align="center" cellpadding="0" cellspacing="2" height="50">
                              		<tr width="100%" class="lineborder" > 
		                              <td align="right"><font face="Microsoft Sans Serif">ชื่อลูกค้า </font></td>
		                              <td colspan="2"><input name="custName" type="text" class="text" id="custName" size="30" maxlength="255" value="<%= (request.getParameter("custName")==null?"":request.getParameter("custName")) %>"></td>  
		                              <td align="right"><font face="Microsoft Sans Serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ทะเบียน&nbsp;&nbsp;&nbsp; </font></td>
		                              <td colspan="2"><input name="slicense" type="text" class="text" id="slicense" size="15" maxlength="12" value="<%= (request.getParameter("slicense")==null?"":request.getParameter("slicense")) %>"></td>		                              	
                              		</tr>
										<%
											String chkString[] = {"","","","","","",""};
											if(request.getParameter("typeins")!=null)
											{
												if(Integer.parseInt(request.getParameter("typeins"))==Customer.ALL) {
													chkString[Customer.ALL] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.FIRE) {
													chkString[Customer.FIRE] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.CAR) {
													chkString[Customer.CAR] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.LIFE) {
													chkString[Customer.LIFE] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.VAT) {
													chkString[Customer.VAT] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.ACT) {
													chkString[Customer.ACT] = "checked";
												} else if(Integer.parseInt(request.getParameter("typeins"))==Customer.CHK) {
													chkString[Customer.CHK] = "checked";
												}
											} else {
												chkString[0] = "checked";
											}
										%>
                              		<tr width="100%" class="lineborder"> 
                              			<td><input name="typeins" type="radio" value="<%=Customer.ALL %>" <%=chkString[Customer.ALL]%>>All&nbsp;&nbsp;</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.FIRE %>" <%=chkString[Customer.FIRE]%>>ประกันอัคคีภัย</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.LIFE %>" <%=chkString[Customer.LIFE]%>>ประกันเอื้ออารีย์</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.CAR %>" <%=chkString[Customer.CAR ]%>>ประกันรถ</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.VAT %>" <%=chkString[Customer.VAT]%>>ภาษีรถ</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.ACT %>" <%=chkString[Customer.ACT]%>>พรบ.</td>
                              			<td><input name="typeins" type="radio" value="<%=Customer.CHK %>" <%=chkString[Customer.CHK]%>>ตรอ.</td>
		                            </tr>  
                              	</table>
                              </td>
                              <td width="5%" align="right" rowspan="2">
                              	<table width="39" border="0" align="center" cellpadding="0" cellspacing="2" height=50>
                              		<tr align="center"><td>
                              			<font face="Microsoft Sans Serif">จังหวัด</font> 
                              		</td></tr>
                              		<tr align="center"><td>
                              			<font face="Microsoft Sans Serif">เดือน</font> 
                              		</td></tr>
                              	</table>
                              </td>
                              <td width="75"  rowspan="2"> 
                              	<table width="39" border="0" align="center" cellpadding="0" cellspacing="2" height=50>
                              		<tr align="center"><td>
		                              <SELECT NAME="provinceId" SIZE="1" >
		                              	<OPTION <%= (((action==null)||(request.getParameter("provinceId")==null)||(request.getParameter("provinceId").equals("-1")))?"SELECTED":"") %> 
		                              			VALUE="-1" > - - - - เลือกทั้งหมด - - - - </OPTION>
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
                              		<tr align="center"><td>
		                              <SELECT NAME="month" SIZE="1" >
		                              	<OPTION <%= (((action==null)||(request.getParameter("month")==null)||(request.getParameter("month").equals("-1")))?"SELECTED":"") %> 
		                              			VALUE="00" > - - - - เลือกทั้งหมด - - - - </OPTION>
		                              	<%
												for (int i=1;i<=12;i++) {
		                              	%>
		                            	<OPTION <%= (request.getParameter("month")==null?"":((Integer.parseInt(request.getParameter("month")) == i)?"SELECTED":"")) %> 
		                            		VALUE="<%= ((i < 10)?("0"+i):(""+i)) %>" > <%= ((i < 10)?(StringUtil.toStringMonth("0"+i)):(StringUtil.toStringMonth(""+i))) %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT>
                              		</td></tr>
                              	</table>
                              	</td>
                              <td width="122"  align="center" rowspan="2"> <input name="submitsearch" type="submit" class="button" id="submitsearch" value="ค้นหา"> 
                                <input name="action" type="hidden" id="action" value="search">
                              </td>
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
              <tr valign="top"> 
                <td align="center"><div scrollleft="0" scrolltop="0" align="left" style="border: 1px solid;border-color:#D8D8C4;OVERFLOW: scroll; WIDTH: 100%; HEIGHT: 200;background-color:#F6F6EB;"> 
<%
		if(action != null && action.equals("search")){
%>
    <table width="800" border="1" align="center" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
         <tr> 
               <td width="3" align="center">ลำดับ</td>
               <td width="200" align="center">ชื่อลูกค้า</td>
               <td width="150" align="center">จังหวัด</td>
               <td width="130" align="center">ทะเบียนรถ</td>
               <td width="100" align="center">ตรอ.</td>
               <td width="100" align="center">พรบ.</td>
               <td width="100" align="center">ภาษีรถ</td>
               <td width="100" align="center">ประกันรถ</td>
               <td width="100" align="center">ประกันอัคคีภัย</td>
               <td width="100" align="center">ประกันเอื้ออารีย์</td>
               <td width="100">&nbsp;&nbsp;</td>
         </tr>
      <%
	try{
		CustomerPage cust = new CustomerPage();
		int typeins = request.getParameter("typeins")==null?0:Integer.parseInt(request.getParameter("typeins"));
		cust.setName(request.getParameter("custName"));
		int custId = request.getParameter("custId")==null?-1:Integer.parseInt(request.getParameter("custId"));
		String month = request.getParameter("month");
		cust.setCustId(custId);
		cust.setLicense(request.getParameter("slicense"));
		cust.setProvince(request.getParameter("provinceId")==null?-1:Integer.parseInt(request.getParameter("provinceId")));
	    Vector entities = queryBean.searchCustomerPage(cust,typeins,month);

	      for(int i = 0;i < entities.size();i++){
	          CustomerPage entity = (CustomerPage)entities.elementAt(i);
	      %>
      <tr> 
        <td width="50" align="center"><%= (i+1) %></td>
        <td width="200"><%= entity.getPrefixName() + ShowData.CheckNull(entity.getName(),"-") %></td>
        <td width="150" align="center"><%= ShowData.CheckNull(entity.getProvinceName(),"-") %></td>
        <td width="130" align="center"><%= ShowData.CheckNull(entity.getLicense(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getChk(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getAct(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getVat(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getCar(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getFire(),"-") %></td>
        <td width="100" align="center"><%= ShowData.CheckNull(entity.getLife(),"-") %></td>
        <td width="100" align="center"> 
        <table width="100%" border="0" cellpadding="0" cellspacing="2">
            <tr align="center"> 
              <td>
                  <a href="CustomerView.jsp?custId=<%= entity.getCustId() %>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('view<%= i %>','','../images/preview_f2.gif',1)" ><img src="../images/preview.gif" alt="ดูข้อมูล" name="view<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="edit<%= i %>"></a> 
              </td>
              <td>
                  <a href="?action=edit&custId=<%= entity.getCustId() %>&plate=<%= entity.getLicense() %>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('edit<%= i %>','','../images/edit_f2.gif',1)" ><img src="../images/edit.gif" alt="แก้ไข" name="edit<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="edit<%= i %>"></a> 
              </td>
              <td>
                  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= i %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= (entity.getPrefixName() + entity.getName()) %>')) MM_goToURL('parent','?action=delete&custId=<%= entity.getCustId() %>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= i %>"></a> 
                </td>
            </tr>
          </table></td>
      </tr>
      	<%
    		}
    	}catch(com.standard.STDException e){
    		e.printStackTrace();
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
} else if(action.equals("add") && (subaction == null)){
%>
<table width="800" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td align="center" bgcolor="#D8D8C4">
              <!-- <jsp:include page="../toolbar.jsp" /> -->
              <a href="CustomerMultiMT.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('back','','../images/back_f2.gif',1)" > 
				<img src="../images/back.gif" name="back" alt="กลับไปก่อนหน้า" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a>
				<a href="../index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/home_hover.gif',1)"> 
				<img src="../images/home.gif" name="home" alt="กลับไปหน้าแรก" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a>
				<a href="../login.jsp?action=logout&url=index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('logout','','../images/logout_f2.gif',1)"> 
				<img src="../images/logout.gif" name="logout" alt="ออกจากระบบ" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a> 
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
		                              	<OPTION <%= (((subaction==null)||(request.getParameter("provinceId").equals("-1")))?"SELECTED":"") %> 
		                              			VALUE="-1" > - - -   เลือกจังหวัด   - - - </OPTION>
		                              	<%
		  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
		  	                              	     for (int i=0;i<tabs.size();i++) {
		  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
		                              	%>
		                            	<OPTION <%= (request.getParameter("provinceId")==null?"":((Integer.parseInt(request.getParameter("provinceId")) == tab.getParId())?"SELECTED":"")) %> 
		                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
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
<%
}else if(action.equals("edit") && (subaction == null)){
%>
<table width="700" border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#8899FF">
  <tr> 
    <td> <table width="100%" border="0" cellspacing="1" cellpadding="5" valign="top" >
        <tr> 
          <td align="center" bgcolor="#D8D8C4">
              <!-- <jsp:include page="../toolbar.jsp" /> -->
              <a href="CustomerMultiMT.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('back','','../images/back_f2.gif',1)" > 
				<img src="../images/back.gif" name="back" alt="กลับไปก่อนหน้า" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a>
				<a href="../index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('home','','../images/home_hover.gif',1)"> 
				<img src="../images/home.gif" name="home" alt="กลับไปหน้าแรก" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a>
				<a href="../login.jsp?action=logout&url=index.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('logout','','../images/logout_f2.gif',1)"> 
				<img src="../images/logout.gif" name="logout" alt="ออกจากระบบ" width="24" height="24" hspace="0" vspace="0" border="0" align="left"> 
				</a> 
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
                      <td width="73" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">แก้ไขข้อมูล</td>
                      <td width="621" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <%
                  try{
				//	Customer cust = new Customer(Integer.parseInt(request.getParameter("custId")));
				//cust.setActive(Integer.parseInt(request.getParameter("active")));
					String plate = request.getParameter("plate");
					int nextyear = (Integer.parseInt(StringUtil.toString(Calendar.getInstance().getTime(), "yyyy"))+1);
	                Customer cEntity = queryBean.getCustomer(Integer.parseInt(request.getParameter("custId")));
	                if(cEntity != null){
                       //session.setAttribute("eCust",cEntity);
	                   // Customer entity = (Customer)entities.elementAt(0);
	                   // System.out.println("Address = "+entity.getAddress()+"\tActive = "+entity.isActive());
                    String statusStr = "";
                    String statusValue = "";
                    String picPath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/images/";
                %> <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="editdataform" id="editdataform">
                          <table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
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
		                            	<OPTION <%= (cEntity.getPrefix()==0?"":((cEntity.getPrefix() == prefix.getParId())?"SELECTED":"")) %> 
		                            		VALUE="<%= prefix.getParId() %>" > <%= prefix.getParName() %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT>
                              <input name="custName" type="text" class="text" id="custName" size="50" maxlength="100" value="<%= ShowData.CheckNull(cEntity.getName()) %>"></td>                          
                              <td width="10%" nowrap>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เบอร์ติดต่อ </font></td>
                              <td><input name="tel" type="text" class="text" id="tel" value="<%=ShowData.CheckNull(cEntity.getTel())%>" size="30" maxlength="200">                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" valign="top" nowrap><font face="Microsoft Sans Serif">ที่อยู่ </font></td>
                              <td><textarea cols="40" rows="5" name="address" type="text" class="text"><%=cEntity.getAddress()%></textarea></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">จังหวัด </font></td>
                              <td>
		                              <SELECT NAME="provinceId" SIZE="1" >
		                              	<OPTION <%= (((cEntity.getProvince()==0))?"SELECTED":"") %> 
		                              			VALUE="-1" > - - -   เลือกจังหวัด   - - - </OPTION>
		                              	<%
		  	                              	     //ParameterManager manage = new ParameterManager();
		  	                              	     //ParameterDetail et = new ParameterDetail(1,2);
		  	                              	     //out.println(et.getTabId()+"  "+et.getParId());
		  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
		  	                              	     for (int i=0;i<tabs.size();i++) {
		  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
		                              	%>
		                            	<OPTION <%= (cEntity.getProvince()==0?"":((cEntity.getProvince() == tab.getParId())?"SELECTED":"")) %> 
		                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
		                            	<%  }
		                              	%>
		                              	</SELECT></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">รหัสไปรษณีย์ </font></td>
                              <td><input name="zipcode" type="number" class="number" id="zipcode" size="10" maxlength="5" value="<%= cEntity.getZipCode()==0?"":cEntity.getZipCode() %>" onchange="checkZipcode(editdataform.zipcode)"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right">
                              	<input name="custId" type="hidden" id="custId" value="<%=cEntity.getCustId() %>"> 
                              	<input name="plate" type="hidden" id="custId" value="<%=plate %>"> 
                              	<input name="action" type="hidden" id="action" value="edit"> 
                              	<input name="subaction" type="hidden" id="subaction" value="update">
                              	<input name="pos" type="hidden" id="pos" value="">
                              </td>
                              <td>
                              	<input name="submitsedit" type="submit" class="button" id="submitsedit2" onClick="MM_validateForm('custname','ชื่อ','R','address','ที่อยู่','R');return document.MM_returnValue" value="แก้ไข"> 
                              	&nbsp;<input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>                              
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3"></td>
                            </tr>
                            <%
                            	Vector vFires = cEntity.getFires();
                            	Fire lActFire = new Fire();
                            	for(int j=0;j < vFires.size();j++) {
                            		lActFire = (Fire)vFires.elementAt(j);
                            		
                            		if (lActFire.getActive()==1) {
                            			break;
                            		}
                            	}
                            %>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center" bgcolor="#C80000">
                            		<b><font color="#FFFFFF">ประกันอัคคีภัย</font><b>
                            	</td>
                            </tr>
                            <tr class="lineborder" bordercolor="black" background="gray"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="center">ปีหมดอายุ <input name="fireyear" type="number" class="number" id="fireyear"  value="<%= nextyear %>" size="4" maxlength="4" onchange="checkYearExp(editdataform.fireyear)"></td>
                              <td width="15%" align="left"> 
                              	วันที่<input type="text" size="5" value="<%= ShowData.CheckNull(lActFire.getFire()).equals("")?"":lActFire.getFire().substring(0,5) %>" class="disabletext" readonly name="fire" id="fire" onfocus="displayCalendar(document.editdataform.fire,'dd/mm/yyyy',this)" onchange="getDateShow('fire')">
                               &nbsp;&nbsp;&nbsp;
                               <SELECT NAME="fcomp" SIZE="1">
                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกบริษัทประกัน   - - - </OPTION>                              	<%
  	                              	     Vector comps = manage.getParamDetail(new ParameterDetail(5,-1));
  	                              	     for (int i=0;i<comps.size();i++) {
  	                              	          ParameterDetail ecomp = (ParameterDetail)comps.elementAt(i);
                              	%>
	                            	<OPTION <%= ((lActFire.getInsurer() == ecomp.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= ecomp.getParId() %>" > <%= ecomp.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              	&nbsp;&nbsp;&nbsp;ค่าบริการ <input name="fireprice" size="10" type="number" class="number" id="fireprice" value="<%=lActFire.getFirePrice()==-1?"":lActFire.getFirePrice() %>" onchange="chkPrice(editdataform.fireprice)">
                              </td>
                              <td><input name="addfire" type="submit" class="button" id="addfire" onClick="changesubact('addfire','')" value="  เพิ่ม  "></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#C80000"></hr>
                              </td>
                            </tr>
                            <% 
                            	
                            	for(int j=0;j < vFires.size();j++) {
                            		Fire fEntity = (Fire)vFires.elementAt(j);
                            %>
                            <tr class="lineborder" bgcolor="<%= (fEntity.getActive()==1?"#FF80FF":"") %>"> 
                              <td align="center">
                              	ปีหมดอายุ <input name="efireyear<%= j %>" size="4" maxlength="4" type="number" class="number" id="efireyear<%= j %>"  value="<%=fEntity.getYear() %>" size="4" maxlength="4" onchange="checkYearExp(editdataform.efireyear)">
                              			<input name="oldefireyear<%= j %>" type="hidden" class="number" id="oldefireyear<%= j %>" size="5" maxlength="5" value="<%= fEntity.getYear()==0?"":fEntity.getYear() %>" size="4" maxlength="4"> 
                              </td>
                              <td width="15%" align="left"> 
                              	วันที่<input type="text" size="5" value="<%= ShowData.CheckNull(fEntity.getFire()).equals("")?"":fEntity.getFire().substring(0,5) %>" class="disabletext" readonly name="efire<%= j %>" id="efire<%= j %>" onfocus="displayCalendar(document.editdataform.efire<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('efire<%= j %>')">
                            	&nbsp;&nbsp;&nbsp;                            	
	                              <SELECT NAME="efcomp<%= j %>" id="efcomp<%= j %>" SIZE="1" >
	                              	<OPTION <%= (((fEntity.getInsurer()==-1))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - เลือกบริษัทประกัน - - </OPTION>
	                              	<% 
	  	                              	     for (int i=0;i<comps.size();i++) {
	  	                              	          ParameterDetail elcomp = (ParameterDetail)comps.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((fEntity.getInsurer() == elcomp.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= elcomp.getParId() %>" > <%= elcomp.getParName() %> </OPTION>
	                            	<%  } %>
	                              	</SELECT>
	                             &nbsp;&nbsp;&nbsp;ค่าบริการ <input name="efireprice<%= j %>" size="10" type="number" class="number" id="efireprice<%= j %>" value='<%= fEntity.getFirePrice()==-1?"":fEntity.getFirePrice() %>' onchange="chkPrice(editdataform.efireprice<%= j %>)">
                              	 <% if (fEntity.getFirePic()!=null) { %>&nbsp;<a href="<%= picPath+"fire/"+fEntity.getFirePic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= fEntity.getYear()%>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } %>
                              </td>
                              <td>
                            	<input name="editfire" type="submit" class="button" id="editfire" onClick="changesubact('editfire','<%= j %>')" value="แก้ไข">                           		
                            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= j %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= (fEntity.getFire()) %>')) MM_goToURL('parent','?action=edit&subaction=deletefire&custId=<%= cEntity.getCustId() %>&yearexp=<%= fEntity.getYear() %>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= j %>"></a>
                            	<a href="UploadFire.jsp?custId=<%=cEntity.getCustId() %>&year=<%= fEntity.getYear() %>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('upload<%= j %>','','../images/upload_f2.png',1)">
                            	<img src="../images/upload.png" alt="upload" name="uploadfire<%= j %>" id="uploadfire<%= j %>"></a>
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#80FF00"></hr>
                              </td>
                            </tr> 
                            <% } %>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <%
                            	Vector vLives = cEntity.getLives();
                            	Life lActLife = new Life();
                            	for(int j=0;j < vLives.size();j++) {
                            		lActLife = (Life)vLives.elementAt(j);
                            		
                            		if (lActLife.getActive()==1) {
                            			break;
                            		}
                            	}
                            %>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center" bgcolor="#00A854">
                            		<b><font color="#FFFFFF">ประกันเอื้ออารีย์</font><b>
                            	</td>
                            </tr>
                            <tr class="lineborder" bordercolor="black" background="gray"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="center">ปีหมดอายุ <input name="lifeyear" type="number" class="number" id="lifeyear"  value="<%=nextyear %>" size="4" maxlength="4" onchange="checkYearExp(editdataform.lifeyear)"></td>
                              <td width="15%" align="left"> 
                              	วันที่<input type="text" size="5" value="<%= ShowData.CheckNull(lActLife.getLife()).equals("")?"":lActLife.getLife().substring(0,5) %>" class="disabletext" readonly name="life" id="life" onfocus="displayCalendar(document.editdataform.life,'dd/mm/yyyy',this)" onchange="getDateShow('life')">
                            	&nbsp;&nbsp;&nbsp;
                               <SELECT NAME="lfcomp" SIZE="1">
                              	<OPTION "SELECTED" VALUE="-1" > - - -   เลือกบริษัทประกัน   - - - </OPTION>                              	
                              	<%
  	                              	     for (int i=0;i<comps.size();i++) {
  	                              	          ParameterDetail ecomp = (ParameterDetail)comps.elementAt(i);
                              	%>
                            	<OPTION <%= ((lActLife.getInsurer() == ecomp.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= ecomp.getParId() %>" > <%= ecomp.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              	&nbsp;&nbsp;&nbsp;ค่าบริการ <input name="lifeprice" size="10" type="number" class="number" id="lifeprice" value="<%=lActLife.getLifePrice()==-1?"":lActLife.getLifePrice() %>" onchange="chkPrice(editdataform.lifeprice)">
                              </td>
                              <td><input name="addlife" type="submit" class="button" id="addlife" onClick="changesubact('addlife','')" value="  เพิ่ม  "></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#00A854"></hr>
                              </td>
                            </tr>
                            <% 
                            	
                            	for(int j=0;j < vLives.size();j++) {
                            		Life lfEntity = (Life)vLives.elementAt(j);
                            %>
                            <tr class="lineborder" bgcolor="<%= (lfEntity.getActive()==1?"#80FF00":"") %>"> 
                              <td align="center">
                              	ปีหมดอายุ <input name="elifeyear<%= j %>" size="4" maxlength="4" type="number" class="number" id="elifeyear<%= j %>"  value="<%=lfEntity.getYear() %>" size="4" maxlength="4" onchange="checkYearExp(editdataform.elifeyear)">
                              			<input name="oldelifeyear<%= j %>" type="hidden" class="number" id="oldelifeyear<%= j %>" size="5" maxlength="5" value="<%= lfEntity.getYear()==0?"":lfEntity.getYear() %>" size="4" maxlength="4"> 
                              </td>
                              <td width="15%" align="left"> 
                              	วันที่<input type="text" size="5" value="<%= ShowData.CheckNull(lfEntity.getLife()).equals("")?"":lfEntity.getLife().substring(0,5) %>" class="disabletext" readonly name="elife<%= j %>" id="elife<%= j %>" onfocus="displayCalendar(document.editdataform.elife<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('elife<%= j %>')">
                            	&nbsp;&nbsp;&nbsp;                            	
	                              <SELECT NAME="elfcomp<%= j %>" id="elfcomp<%= j %>" SIZE="1" >
	                              	<OPTION <%= (((lfEntity.getInsurer()==-1))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - เลือกบริษัทประกัน - - </OPTION>
	                              	<% 
	  	                              	     for (int i=0;i<comps.size();i++) {
	  	                              	          ParameterDetail elcomp = (ParameterDetail)comps.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((lfEntity.getInsurer() == elcomp.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= elcomp.getParId() %>" > <%= elcomp.getParName() %> </OPTION>
	                            	<%  } %>
	                              	</SELECT>
	                             &nbsp;&nbsp;&nbsp;ค่าบริการ <input name="elifeprice<%= j %>" size="10" type="number" class="number" id="elifeprice<%= j %>" value='<%= lfEntity.getLifePrice()==-1?"":lfEntity.getLifePrice() %>' onchange="chkPrice(editdataform.elifeprice<%= j %>)">
                              	 <% if (lfEntity.getLifePic()!=null) { %>&nbsp;<a href="<%= picPath+"life/"+lfEntity.getLifePic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= lfEntity.getYear()%>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } %>
                              </td>
                              <td>
                            	<input name="editlife" type="submit" class="button" id="editlife" onClick="changesubact('editlife','<%= j %>')" value="แก้ไข">                           		
                            	<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= j %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= (lfEntity.getLife()) %>')) MM_goToURL('parent','?action=edit&subaction=deletelife&custId=<%= cEntity.getCustId() %>&yearexp=<%= lfEntity.getYear() %>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= j %>"></a>
                            	<a href="UploadLife.jsp?custId=<%=cEntity.getCustId() %>&year=<%= lfEntity.getYear() %>" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('upload<%= j %>','','../images/upload_f2.png',1)">
                            	<img src="../images/upload.png" alt="upload" name="uploadlife<%= j %>" id="uploadlife<%= j %>"></a>
                              </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#80FF00"></hr>
                              </td>
                            </tr> 
                            <% } %>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center"></td>
                            </tr>
                            <%
                            	Vector vLicenses = cEntity.getLicenses();
                            	License lActive = new License();
                            	for(int j=0;j < vLicenses.size();j++) {
                            		lActive = (License)vLicenses.elementAt(j);
                            		if (lActive.getActive()==1 && lActive.getLicense().equals(plate)) {
                            			break;
                            		}
                            	}
                            %>
                            <tr class="lineborder"> 
                            	<td colspan="3" align="center" bgcolor="#000080">
                            		<b><font color="#FFFFFF">ประกันภัยรถ</font></b>
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
                              <% 
                              		String[] lActLicense = StringUtil.stringTokenToArray(ShowData.CheckNull(lActive.getLicense()), "-"); 
                              		if (lActLicense.length == 2) {
                              %>
                              <input name="license1" type="text" class="text" id="license1" size="3" maxlength="3" value="<%= (lActLicense.length==0?"":lActLicense[0]) %>" onchange="checkLicense('editdataform','')">
                              - <input name="license2" type="text" class="text" id="license2" size="5" maxlength="4" value="<%= (lActLicense.length==0?"":lActLicense[1]) %>" onchange="checkLicense('editdataform','')">                              
                              <% 
                              		}  else if (lActLicense.length == 1){
                              		if (lActive.getLicense().indexOf("-")==0)
                              %>
                              <input name="license1" type="text" class="text" id="license1" size="3" maxlength="3" value="<%= (lActive.getLicense().indexOf("-")!=0?lActLicense[0]:"") %>" onchange="checkLicense('editdataform','')">
                              - <input name="license2" type="text" class="text" id="license2" size="5" maxlength="4" value="<%= (lActive.getLicense().indexOf("-")==0?lActLicense[0]:"") %>" onchange="checkLicense('editdataform','')">
                               <% 
                              		} else {
                              %>
                              <input name="license1" type="text" class="text" id="license1" value="" size="3" maxlength="3"  onchange="checkLicense('editdataform','')">
                              - <input name="license2" type="text" class="text" id="license2" value="" size="5" maxlength="4"  onchange="checkLicense('editdataform','')"><% 
                              		}
                              %>
                              <input name="license" type="hidden" class="text" id="license" value="<%=lActive.getLicense() %>" size="15" maxlength="10" ></td>                          
                              <td align="left">
                              <SELECT NAME="brand" SIZE="1" onchange="chkLicense('editdataform',editdataform.license,editdataform.brand,'-1')">
                              	<OPTION VALUE="-1" > - - - เลือกยี่ห้อรถ   - - - </OPTION>
                              	<%
                              	//System.out.println("Brand");
  	                              	     manage = new ParameterManager();
  	                              	    // et = new ParameterDetail(2);
  	                              	     Vector brands = manage.getParamDetail(new ParameterDetail(2,-1));
  	                              	     for (int i=0;i<brands.size();i++) {
  	                              	          ParameterDetail ebrand = (ParameterDetail)brands.elementAt(i);
                              	%>
                            	<OPTION <%= ((lActive.getBrand() == ebrand.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= ebrand.getParId() %>" > <%= ebrand.getParName() %> </OPTION>
                            	<%  }
                              	%>
                              	</SELECT>
                            	 ประกันภัย<input type="text" size="5" class="disabletext" readonly name="car" id="car" value="<%=ShowData.CheckNull(lActive.getCar()).equals("")?"":lActive.getCar().substring(0,5) %>" onClick="checkYearExp(editdataform.yearexp)" onfocus="displayCalendar(document.editdataform.car,'dd/mm/yyyy',this)" onchange="getDateShow('car')">
                              	ภาษี<input type="text" size="5" class="disabletext" readonly name="vat" id="vat" value="<%=ShowData.CheckNull(lActive.getVat()).equals("")?"":lActive.getVat().substring(0,5) %>" onClick="checkYearExp(editdataform.yearexp)" onfocus="displayCalendar(document.editdataform.vat,'dd/mm/yyyy',this)" onchange="getDateShow('vat')">
                              	พรบ.<input type="text" size="5" class="disabletext" readonly name="act" id="act" value="<%=ShowData.CheckNull(lActive.getAct()).equals("")?"":lActive.getAct().substring(0,5) %>" onClick="checkYearExp(editdataform.yearexp)" onfocus="displayCalendar(document.editdataform.act,'dd/mm/yyyy',this)" onchange="getDateShow('act')">
                              	ตรอ.<input type="text" size="5" class="disabletext" readonly name="chk" id="chk" value="<%=ShowData.CheckNull(lActive.getChk()).equals("")?"":lActive.getChk().substring(0,5) %>" onClick="checkYearExp(editdataform.yearexp)" onfocus="displayCalendar(document.editdataform.chk,'dd/mm/yyyy',this)" onchange="getDateShow('chk')">
                              	<td align="left"><input name="addlicense" type="submit" class="button" id="addlicense" onClick="changesubact('addlicense','')" value="  เพิ่ม  "> </td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td>
                              		ปีหมดอายุ <input name="yearexp" type="number" class="number" id="yearexp" value="<%=nextyear %>" size="4" maxlength="4" onchange="checkYearExp(editdataform.yearexp)">
                              	</td>
                            	<td colspan="2">
                              <SELECT NAME="ltype" SIZE="1">
                              	<OPTION VALUE="-1" > - - -   เลือกประเภทประกัน   - - - </OPTION>                              	<%
  	                              	     Vector types = manage.getParamDetail(new ParameterDetail(4,-1));
  	                              	     for (int i=0;i<types.size();i++) {
  	                              	          ParameterDetail etype = (ParameterDetail)types.elementAt(i);
                              	%>
                            	<OPTION <%= ((lActive.getLtype() == etype.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= etype.getParId() %>" > <%= etype.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              <SELECT NAME="lcomp" SIZE="1">
                              	<OPTION VALUE="-1" > - - -   เลือกบริษัทประกัน   - - - </OPTION>                              	<%
  	                              	     //Vector comps = manage.getParamDetail(new ParameterDetail(5,-1));
  	                              	     for (int i=0;i<comps.size();i++) {
  	                              	          ParameterDetail ecomp = (ParameterDetail)comps.elementAt(i);
                              	%>
                            	<OPTION <%= ((lActive.getLcomp() == ecomp.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= ecomp.getParId() %>" > <%= ecomp.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              <SELECT NAME="lact" SIZE="1">
                              	<OPTION VALUE="-1" > - - - เลือกบริษัท พ.ร.บ. - - - </OPTION>                              	<%
  	                              	     Vector acts = manage.getParamDetail(new ParameterDetail(6,-1));
  	                              	     for (int i=0;i<acts.size();i++) {
  	                              	          ParameterDetail eact = (ParameterDetail)acts.elementAt(i);
                              	%>
                            	<OPTION <%= ((lActive.getLact() == eact.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= eact.getParId() %>" > <%= eact.getParName() %> </OPTION>
                            	<%  } %>
                              	</SELECT>
                              	</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td rowspan="2">ค่าบริการ</td>
                            	<td colspan="2">
                            		ประกัน <input name="carprice" type="number" class="number" id="carprice" value="<%=lActive.getCarPrice()==-1?"":lActive.getCarPrice() %>" size="10" onchange="chkPrice(editdataform.carprice)">
                            		&nbsp;&nbsp;&nbsp;ภาษี <input name="vatprice" type="number" class="number" id="vatprice" value="<%=lActive.getVatPrice()==-1?"":lActive.getVatPrice() %>" size="10" onchange="chkPrice(editdataform.vatprice)">
                            		&nbsp;&nbsp;&nbsp;บริการภาษี <input name="vatservice" type="number" class="number" id="vatservice" value="<%=lActive.getVatService()==-1?"":lActive.getVatService() %>" size="10" onchange="chkPrice(editdataform.vatservice)">
                            	</td>
                            </tr>
                            <tr class="lineborder">
                            	<td colspan="2">
                            		&nbsp;&nbsp;&nbsp;พรบ.<input name="actprice" type="number" class="number" id="actprice" value="<%=lActive.getActPrice()==-1?"":lActive.getActPrice() %>" size="10" onchange="chkPrice(editdataform.actprice)">
                            		&nbsp;&nbsp;&nbsp;ตรอ.<input name="chkprice" type="number" class="number" id="chkprice" value="<%=lActive.getChkPrice()==-1?"":lActive.getChkPrice() %>" size="10" onchange="chkPrice(editdataform.chkprice)">
                            	</td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td>หมายเหตุ</td>
                            	<td colspan="2">
                               		<textarea cols="40" rows="2" name="comment" type="text" class="comment"><%=lActive.getComment()%></textarea>
                             	</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#000080"></hr>
                              </td>
                            </tr>
                            <% 
                            	for(int j=0;j < vLicenses.size();j++) {
                            		License lEntity = (License)vLicenses.elementAt(j);
                            		//session.setAttribute("year"+j,lEntity.getYear());
                            		session.setAttribute("license"+j,lEntity.getLicense());
                            %>
                            <tr class="lineborder" bgcolor="<%= (lEntity.getActive()==1?"#8899FF":"") %>"> 
                              <td> 
                              <% 
                              		String[] licenses = StringUtil.stringTokenToArray(ShowData.CheckNull(lEntity.getLicense()), "-"); 
                              		if (licenses.length == 2) {
                              %>
                              <input name="elicense1<%= j %>" type="text" class="text" id="elicense1<%= j %>" size="3" maxlength="3" value="<%= (licenses.length==0?"":licenses[0]) %>" onchange="checkLicense('editdataform','<%= j %>')">
                              - <input name="elicense2<%= j %>" type="text" class="text" id="elicense2<%= j %>" size="5" maxlength="4" value="<%= (licenses.length==0?"":licenses[1]) %>" onchange="checkLicense('editdataform','<%= j %>')">                              
                              <% 
                              		}  else if (licenses.length == 1){
                              		if (lEntity.getLicense().indexOf("-")==0)
                              %>
                              <input name="elicense1<%= j %>" type="text" class="text" id="elicense1<%= j %>" size="3" maxlength="3" value="<%= (lEntity.getLicense().indexOf("-")!=0?licenses[0]:"") %>" onchange="checkLicense('editdataform','<%= j %>')">
                              - <input name="elicense2<%= j %>" type="text" class="text" id="elicense2<%= j %>" size="5" maxlength="4" value="<%= (lEntity.getLicense().indexOf("-")==0?licenses[0]:"") %>" onchange="checkLicense('editdataform','<%= j %>')">
                               <% 
                              		}  
                              %>
                              <input name="elicense<%= j %>" type="hidden" class="text" id="elicense<%= j %>" size="15" maxlength="10" value="<%= ShowData.CheckNull(lEntity.getLicense()) %>" >
                              <input name="oldelicense<%= j %>" type="hidden" class="text" id="oldelicense<%= j %>" size="15" maxlength="10" value="<%= ShowData.CheckNull(lEntity.getLicense()) %>" > 
                              </td>                          
                              <td align="left">
                              <SELECT NAME="ebrand<%= j %>" id="ebrand<%= j %>" SIZE="1" onchange="chkLicense('editdataform',editdataform.elicense<%= j %>,editdataform.ebrand<%= j %>,'-1')">
                              	<OPTION <%= (((lEntity.getBrand()==-1))?"SELECTED":"") %> 
                              			VALUE="-1" > - - เลือกยี่ห้อรถ  - - </OPTION>
                              	<%
                              	//System.out.println("Brand");
  	                              	     manage = new ParameterManager();
  	                              	    // et = new ParameterDetail(2);
  	                              	     //Vector brands = manage.getParamDetail(new ParameterDetail(2,-1));
  	                              	     for (int i=0;i<brands.size();i++) {
  	                              	          ParameterDetail ebrand = (ParameterDetail)brands.elementAt(i);
                              	%>
                            	<OPTION <%= ((lEntity.getBrand() == ebrand.getParId())?"SELECTED":"") %> 
                            		VALUE="<%= ebrand.getParId() %>" > <%= ebrand.getParName() %> </OPTION>
                            	<%  }
                              	%>
                              	</SELECT>
                            	 ประกันภัย<input type="text" size="5" value="<%= ShowData.CheckNull(lEntity.getCar()).equals("")?"":lEntity.getCar().substring(0,5) %>" class="disabletext" readonly name="ecar<%= j %>" id="ecar<%= j %>" onfocus="displayCalendar(document.editdataform.ecar<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('ecar<%= j %>')" width="5" >
                              	ภาษี<input type="text" size="5" value="<%= ShowData.CheckNull(lEntity.getVat()).equals("")?"":lEntity.getVat().substring(0,5) %>" class="disabletext" readonly name="evat<%= j %>" id="evat<%= j %>" onfocus="displayCalendar(document.editdataform.evat<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('evat<%= j %>')">
                              	พรบ.<input type="text" size="5" value="<%= ShowData.CheckNull(lEntity.getAct()).equals("")?"":lEntity.getAct().substring(0,5) %>" class="disabletext" readonly name="eact<%= j %>" id="eact<%= j %>" onfocus="displayCalendar(document.editdataform.eact<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('eact<%= j %>')">
                              	ตรอ.<input type="text" size="5" value="<%= ShowData.CheckNull(lEntity.getChk()).equals("")?"":lEntity.getChk().substring(0,5) %>" class="disabletext" readonly name="echk<%= j %>" id="echk<%= j %>" onfocus="displayCalendar(document.editdataform.echk<%= j %>,'dd/mm/yyyy',this)" onchange="getDateShow('echk<%= j %>')">
                                
                              	<td align="left">
                              		<input name="editlicense" type="submit" class="button" id="editlicense" onClick="changesubact('editlicense','<%= j %>')" value="แก้ไข">
                              		<a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= j %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= " ทะเบียน  "+(lEntity.getLicense())+" ปี "+lEntity.getYear() %>')) MM_goToURL('parent','?action=edit&subaction=deletelicense&custId=<%= cEntity.getCustId() %>&license=<%= lEntity.getLicense() %>&yearexp=<%= lEntity.getYear() %>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= j %>"></a>
								</td>
                            </tr>
                            <tr class="lineborder" bgcolor="<%= (lEntity.getActive()==1?"#8899FF":"") %>"> 
                            	<td>
                              		ปีหมดอายุ <input name="eyearexp<%= j %>" type="number" class="number" id="eyearexp<%= j %>" value='<%= lEntity.getYear()==0?"":lEntity.getYear() %>' size="4" maxlength="4" onchange="checkYearExp(editdataform.eyearexp<%= j %>)">
                              			   <input name="oldeyear<%= j %>" type="hidden" class="number" id="oldeyear<%= j %>" size="5" maxlength="10" value="<%= lEntity.getYear()==0?"":lEntity.getYear() %>" size="4" maxlength="4"> 
                              	</td>
                            	<td colspan="2">
	                              <SELECT NAME="eltype<%= j %>" id="eltype<%= j %>" SIZE="1" >
	                              	<OPTION <%= (((lEntity.getLtype()==-1))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - เลือกประเภทประกัน  - - </OPTION>
	                              	<% 
	  	                              	     for (int i=0;i<types.size();i++) {
	  	                              	          ParameterDetail eltype = (ParameterDetail)types.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((lEntity.getLtype() == eltype.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= eltype.getParId() %>" > <%= eltype.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
	                              <SELECT NAME="elcomp<%= j %>" id="elcomp<%= j %>" SIZE="1" >
	                              	<OPTION <%= (((lEntity.getLcomp()==-1))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - เลือกบริษัทประกัน - - </OPTION>
	                              	<% 
	  	                              	     for (int i=0;i<comps.size();i++) {
	  	                              	          ParameterDetail elcomp = (ParameterDetail)comps.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((lEntity.getLcomp() == elcomp.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= elcomp.getParId() %>" > <%= elcomp.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
	                              <SELECT NAME="elact<%= j %>" id="elact<%= j %>" SIZE="1" >
	                              	<OPTION <%= (((lEntity.getLact()==-1))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - เลือกบริษัท พ.ร.บ. - - </OPTION>
	                              	<% 
	  	                              	     for (int i=0;i<acts.size();i++) {
	  	                              	          ParameterDetail elact = (ParameterDetail)acts.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((lEntity.getLact() == elact.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= elact.getParId() %>" > <%= elact.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
                              	</td>
                            </tr>
                            <tr class="lineborder" bgcolor="<%= (lEntity.getActive()==1?"#8899FF":"") %>"> 
                            	<td rowspan="2">ค่าบริการ</td>
                            	<td colspan="2">
                            		ประกัน <input name="ecarprice<%= j %>" size="10" type="number" class="number" id="ecarprice<%= j %>" value='<%= lEntity.getCarPrice()==-1?"":lEntity.getCarPrice() %>' onchange="chkPrice(editdataform.ecarprice<%= j %>)">
	                                <% if (lEntity.getCarPic()!=null) { %>&nbsp;<a href="<%= picPath+"license/car/"+lEntity.getCarPic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= lEntity.getYear()+""+lEntity.getLicense() %>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } else { %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% }%>
                            		&nbsp;&nbsp;&nbsp;ภาษี <input name="evatprice<%= j %>" size="10" type="number" class="number" id="evatprice<%= j %>" value='<%= lEntity.getVatPrice()==-1?"":lEntity.getVatPrice() %>' onchange="chkPrice(editdataform.evatprice<%= j %>)">
	                                <% if (lEntity.getVatPic()!=null) { %>&nbsp;<a href="<%= picPath+"license/vat/"+lEntity.getVatPic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= lEntity.getYear()+""+lEntity.getLicense() %>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } else { %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% }%>
                            		&nbsp;&nbsp;&nbsp;บริการภาษี <input name="evatservice<%= j %>" size="10" type="number" class="number" id="evatservice<%= j %>" value='<%= lEntity.getVatService()==-1?"":lEntity.getVatService() %>' onchange="chkPrice(editdataform.evatservice<%= j %>)">
                            	</td>
                            </tr>
                            <tr class="lineborder" bgcolor="<%= (lEntity.getActive()==1?"#8899FF":"") %>">
                            	<td colspan="2">
                            		&nbsp;&nbsp;&nbsp;พรบ.<input name="eactprice<%= j %>" size="10" type="number" class="number" id="eactprice<%= j %>" value='<%= lEntity.getActPrice()==-1?"":lEntity.getActPrice() %>' onchange="chkPrice(editdataform.eactprice<%= j %>)">
	                                <% if (lEntity.getActPic()!=null) { %>&nbsp;<a href="<%= picPath+"license/act/"+lEntity.getActPic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= lEntity.getYear()+""+lEntity.getLicense() %>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } else { %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% }%>
                            		&nbsp;&nbsp;&nbsp;ตรอ.<input name="echkprice<%= j %>" size="10" type="number" class="number" id="echkprice<%= j %>" value='<%= lEntity.getChkPrice()==-1?"":lEntity.getChkPrice() %>' onchange="chkPrice(editdataform.echkprice<%= j %>)">
	                                <% if (lEntity.getChkPic()!=null) { %>&nbsp;<a href="<%= picPath+"license/chk/"+lEntity.getChkPic() %>" target="_blank"><img src="../images/icon-download.png" alt="<%= lEntity.getYear()+""+lEntity.getLicense() %>" name="view<%= j %>" width="24" height="24" hspace="0" vspace="0" border="0" id="view<%= j %>"></a> 
	                                <% } else { %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<% }%>
                            	</td>
                            </tr>
                            <tr class="lineborder" bgcolor="<%= (lEntity.getActive()==1?"#8899FF":"") %>"> 
                            	<td>หมายเหตุ</td>
                            	<td colspan="2">
                               		<textarea cols="40" rows="2" name="ecomment<%= j %>" type="text" class="ecomment<%= j %>"><%=lEntity.getComment()%></textarea>
                              		&nbsp;&nbsp;&nbsp;<a href="UploadLicense.jsp?custId=<%=cEntity.getCustId() %>&year=<%= lEntity.getYear() %>&license=license<%=j %>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('upload<%= j %>','','../images/upload_f2.png',1)"><img src="../images/upload.png" alt="upload" name="upload<%= j %>" id="upload<%= j %>"></a>
                             	</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="3">
                              <hr color="#80FF00"></hr>
                              </td>
                            </tr> 
                            <% } %>
                            <tr class="lineborder"> 
                            	<td colspan="3"></td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table>
                  <%
                 	}
                 }catch(com.standard.STDException e){
                 	e.printStackTrace();
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