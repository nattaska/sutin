<%@ page contentType="text/html; charset=tis-620" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.insurance.entity.*" %>
<%@ page import="com.standard.util.*" %>
<jsp:directive.page import="com.insurance.manage.ParameterManager"/>
<jsp:directive.page import="com.insurance.manage.CheckingManager"/>
<% request.setCharacterEncoding("tis-620"); %>

<%-- User Authentication --%>
<jsp:useBean id="userBean" scope="session" class="com.insurance.manage.UserManager">
<jsp:setProperty name="userBean" property="*"/>
</jsp:useBean>
<%
if(!userBean.authenticated()){
    response.sendRedirect("../login.jsp?url=setup/CheckingMT.jsp");
}
%>
<%-------------------------%>
<jsp:useBean id="queryBean" scope="request" class="com.insurance.manage.CheckingManager"/>
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
		}
		return s2
	} 
	
	function chkIntDecVal(obj,type){
		if (type=='N') {
		  if(!isInteger(obj)) {
	      	obj.value = '';
	      }
		} else {
		  if(isDecimal(obj)) {
		     obj.value = dpFormat('',obj.value, 2,0);
	      } else {
	      	obj.value = '';
	      }
	    }
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
	
	function changesubact(subact,pos)
	{
		document.editdataform.elements["subaction"].value=subact;
		document.editdataform.elements["pos"].value=pos;
	}
	function getDateShow(param) {
		var tmpStr = document.getElementById(param).value.split("/");
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
String msg = null;

if(action != null){
    if(subaction != null){
        //if(action.equals("add") && subaction.equals("insert"))
        if(subaction.equals("insert") || subaction.equals("update")) {
        	Checking entity = new Checking();
        	entity.setLicense(request.getParameter("license").equals("")?null:request.getParameter("license"));
           	entity.setProvince(Integer.parseInt(request.getParameter("province")));
           	entity.setCerDate(request.getParameter("cerdate"));
           	entity.setRegisDate(request.getParameter("regisdate"));
           	entity.setBrandId(Integer.parseInt(request.getParameter("brandid")));
           	entity.setCoachWorkNo(request.getParameter("coachworkno"));
           	entity.setMotorNo(request.getParameter("motorno"));
           	entity.setCategory(Integer.parseInt(request.getParameter("category")));
           	entity.setCharacteristic(Integer.parseInt(request.getParameter("characteristic")));
           	entity.setMotor(Integer.parseInt(request.getParameter("motor")));
           	entity.setWeight((request.getParameter("weight")==null||request.getParameter("weight").equals(""))?-1:Double.parseDouble(request.getParameter("weight")));
           	entity.setFuel(Integer.parseInt(request.getParameter("fuel")));
           	entity.setCoachWorkNoPos(Integer.parseInt(request.getParameter("coachworknopos")));
           	entity.setMotorNoPos(Integer.parseInt(request.getParameter("motornopos")));
           	entity.setPump((request.getParameter("pump")==null||request.getParameter("pump").equals(""))?-1:Integer.parseInt(request.getParameter("pump")));
           	entity.setCc((request.getParameter("cc")==null||request.getParameter("cc").equals(""))?-1:Integer.parseInt(request.getParameter("cc")));
           	entity.setAxle((request.getParameter("axle")==null||request.getParameter("axle").equals(""))?-1:Integer.parseInt(request.getParameter("axle")));
           	entity.setWheel((request.getParameter("wheel")==null||request.getParameter("wheel").equals(""))?-1:Integer.parseInt(request.getParameter("wheel")));
           	entity.setTire((request.getParameter("tire")==null||request.getParameter("tire").equals(""))?-1:Integer.parseInt(request.getParameter("tire")));
           	entity.setChkName(Integer.parseInt(request.getParameter("chkname")));
           	entity.setCreBy(username);
           	entity.setUpdBy(username);
           	if (subaction.equals("insert")) {
            	msg = queryBean.updateChecked(entity,CheckingManager.INSERT);
            } else if (subaction.equals("update")) {
            	msg = queryBean.updateChecked(entity,CheckingManager.UPDATE);
            }
         }
    }    // end subaction
    if(action.equals("delete")){
        msg = queryBean.deleteChecked(request.getParameter("license"));
    }

	if(msg != null){
	System.out.println("MSG Flag : "+msg.indexOf("กรุณา"));
		if (msg.indexOf("กรุณา") != -1) {
%>
		 <meta http-equiv="refresh" content="1;URL=?action=edit&plate=<%= request.getParameter("license") %>"> 
		 <% } else { 
		 System.out.println("action=search&license="+request.getParameter("license"));
		 %>
		 <meta http-equiv="refresh" content="1;URL=?action=search&license=<%= request.getParameter("license") %>"> 
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
                      <td colspan="2" class="pagetitle">ตรวจสภาพรถ</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">ค้นหา</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="800" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="searchform" id="searchform">
                          <table width="800" border="0" align="center" cellpadding="0" cellspacing="2">
                            <tr class="lineborder"> 
                              <td>
                              	<table width="700" border="0" align="center" cellpadding="0" cellspacing="2">
                              		<tr width="100%" class="lineborder" align="center" valign="middle"> 
		                              <td width="20%">ทะเบียนรถ&nbsp;&nbsp;<input name="license" type="text" class="text" id="license" size="10" maxlength="7" value="<%= ((request.getParameter("license")==null)?"":request.getParameter("license")) %>"></td>
		                              <td width="25%">เลขตัวรถ&nbsp;&nbsp;<input name="coachworkno" type="text" class="text" id="coachworkno" size="25" maxlength="20" value="<%= (request.getParameter("coachworkno")==null?"":request.getParameter("coachworkno")) %>"></td>
		                              <td width="25%">เลขเครื่องยนต์&nbsp;&nbsp;<input name="motorno" type="text" class="text" id="motorno" size="25" maxlength="20" value="<%= (request.getParameter("motorno")==null?"":request.getParameter("motorno")) %>"></td>
                              		</tr>
                              	</table>
                              </td>
                              <td width="122"  align="center"> <input name="submitsearch" type="submit" class="button" id="submitsearch" value="ค้นหา"> 
                                <input name="action" type="hidden" id="action" value="search">
                              </td>
                            </tr>
                          </table>
                        </form></td>
                    </tr>
                  </table>
                </td>
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
         <tr bgcolor="#D8D8FF"> 
               <td width="3" align="center">ลำดับ</td>
               <td width="200" align="center">ทะเบียนรถ</td>
               <td width="150" align="center">เลขตัวรถ</td>
               <td width="130" align="center">เลขเครื่องยนต์</td>
               <td width="100">&nbsp;&nbsp;</td>
         </tr>
      <%
	try{
		Checking chk = new Checking();
		chk.setLicense(request.getParameter("license"));
		chk.setMotorNo(request.getParameter("motorno"));
		chk.setCoachWorkNo(request.getParameter("coachworkno"));
	    Vector entities = queryBean.searchChecked(chk);

	      for(int i = 0;i < entities.size();i++){
	          Checking entity = (Checking)entities.elementAt(i);
	      %>
      <tr> 
        <td width="50" align="center"><%= (i+1) %></td>
        <td width="200" align="center"><%= ShowData.CheckNull(entity.getLicense(),"-") %></td>
        <td width="150" align="center"><%= ShowData.CheckNull(entity.getCoachWorkNo(),"-") %></td>
        <td width="130" align="center"><%= ShowData.CheckNull(entity.getMotorNo(),"-") %></td>
        <td width="100" align="center"> 
        <table width="100%" border="0" cellpadding="0" cellspacing="2">
            <tr align="center"> 
              <td>
                  <a href="?action=edit&plate=<%= entity.getLicense() %>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('edit<%= i %>','','../images/edit_f2.gif',1)" ><img src="../images/edit.gif" alt="แก้ไข" name="edit<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="edit<%= i %>"></a> 
              </td>
              <td>
                  <a href="#" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('delete<%= i %>','','../images/delete_f2.gif',1)" onClick="if(confirmDelete('<%= (entity.getLicense()) %>')) MM_goToURL('parent','?action=delete&license=<%= entity.getLicense() %>')"><img src="../images/delete.gif" alt="ลบ" name="delete<%= i %>" width="24" height="24" hspace="0" vspace="0" border="0" id="delete<%= i %>"></a> 
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
              <a href="CheckingMT.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('back','','../images/back_f2.gif',1)" > 
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
                      <td colspan="2" class="pagetitle">ตรวจสภาพรถ</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">เพิ่มข้อมูล</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="adddataform" id="adddataform">
                          <table width="700" border="0" cellpadding="1" cellspacing="0">
                            <tr class="lineborder"> 
                              <td width="20%" align="right"><font color="#FF0000">*</font> <font face="Microsoft Sans Serif">ทะเบียนรถ</font></td>
                              <td width="30%"> <input name="license" type="text" class="text" id="license" size="15" maxlength="10" value=""> 		                              	 </td>
                              <td width="20%" align="right">จังหวัด</td>
                              <td width="30%" >
	                              <SELECT NAME="province" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("province").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - -   เลือกจังหวัด   - - - </OPTION>
	                              	<%
	  	                              	     ParameterManager manage = new ParameterManager();
	  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("province")==null?"":((Integer.parseInt(request.getParameter("province")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }%>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">วันตรวจ </font></td>
                              <td><input type="text" size="10" value="" class="disabletext" readonly name="cerdate" id="cerdate" onfocus="displayCalendar(document.adddataform.cerdate,'dd/mm/yyyy',this)"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">วันจดทะเบียน</td>
                              <td><input type="text" size="10" value="" class="disabletext" readonly name="regisdate" id="regisdate" onfocus="displayCalendar(document.adddataform.regisdate,'dd/mm/yyyy',this)"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เลขตัวรถ </font></td>
                              <td><input name="coachworkno" type="text" class="text" id="coachworkno" size="20" maxlength="20" value=""></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เลขเครื่องยนต์</td>
                              <td><input name="motorno" type="text" class="text" id="motorno" size="20" maxlength="20" value=""> </td>
                            </tr>
                            <tr class="lineborder">
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ประเภทรถ </font></td>
                              <td>
	                              <SELECT NAME="category" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("category").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(7,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("category")==null?"":((Integer.parseInt(request.getParameter("category")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  } %>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ลักษณะรถ </font></td>
                              <td>
	                              <SELECT NAME="characteristic" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("characteristic").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(8,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("characteristic")==null?"":((Integer.parseInt(request.getParameter("characteristic")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดรถ </font></td>
                              <td>
	                              <SELECT NAME="brandid" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("brandid").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(2,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("brandid")==null?"":((Integer.parseInt(request.getParameter("brandid")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดเครื่องยนต์ </font></td>
                              <td>
	                              <SELECT NAME="motor" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("motor").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(2,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("motor")==null?"":((Integer.parseInt(request.getParameter("motor")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดเชื้อเพลิง </font></td>
                              <td>
	                              <SELECT NAME="fuel" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("fuel").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(9,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("fuel")==null?"":((Integer.parseInt(request.getParameter("fuel")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ตำแหน่งเลขตัวรถ </font></td>
                              <td>
	                              <SELECT NAME="coachworknopos" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("coachworknopos").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(10,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("coachworknopos")==null?"":((Integer.parseInt(request.getParameter("coachworknopos")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ตำแหน่งเลขเครื่องยนต์ </font></td>
                              <td>
	                              <SELECT NAME="motornopos" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("motornopos").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(11,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("motornopos")==null?"":((Integer.parseInt(request.getParameter("motornopos")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ผู้ควบคุมการตรวจ </font></td>
                              <td>
	                              <SELECT NAME="chkname" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("chkname").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(12,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= (request.getParameter("chkname")==null?"":((Integer.parseInt(request.getParameter("chkname")) == tab.getParId())?"SELECTED":"")) %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
	                            	<%  }
	                              	%>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">น้ำหนัก </font></td>
                              <td><input name="weight" size="10" type="number" class="number" id="weight" value="" onchange="chkIntDecVal(adddataform.weight,'D')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">สูบ</td>
                              <td><input name="pump" type="number" class="number" id="pump" size="10" maxlength="2" value="" onchange="chkIntDecVal(adddataform.pump,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ซีซี </font></td>
                              <td><input name="cc" size="10" maxlength="5" type="number" class="number" id="cc" value="" onchange="chkIntDecVal(adddataform.cc,'N')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เพลา</td>
                              <td><input name="axle" type="number" class="number" id="axle" size="10" maxlength="2" value="" onchange="chkIntDecVal(adddataform.axle,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ล้อ </font></td>
                              <td><input name="wheel" size="10" maxlength="2" type="number" class="number" id="wheel" value="" onchange="chkIntDecVal(adddataform.wheel,'N')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ยาง</td>
                              <td><input name="tire" type="number" class="number" id="tire" size="10" maxlength="2" value="" onchange="chkIntDecVal(adddataform.tire,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="4" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td></td>
                              <td align="right">
                              	<input name="submitadd" type="submit" class="button" id="submitadd" onClick="MM_validateForm('custname','ชื่อ','R','address','ที่อยู่','R');return document.MM_returnValue" value="  เพิ่ม  "> 
                              	<input name="custId" type="hidden" id="custId" value=""> 
                              	<input name="action" type="hidden" id="action" value="add"> 
                              	<input name="subaction" type="hidden" id="subaction" value="insert"></td>
                              <td><input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="4">&nbsp;</td>
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
              <a href="CheckingMT.jsp" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('back','','../images/back_f2.gif',1)" > 
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
                      <td colspan="2" class="pagetitle">ตรวจสภาพรถ</td>
                    </tr>
                    <tr> 
                      <td width="60" align="center" bordercolor="#D8D8C4" bgcolor="#D8D8C4">แก้ไข</td>
                      <td width="802" bordercolor="#D8D8C4">&nbsp;</td>
                    </tr>
                  </table>
                  <%
                  try{
				//	Customer cust = new Customer(Integer.parseInt(request.getParameter("custId")));
				//cust.setActive(Integer.parseInt(request.getParameter("active")));
					String plate = request.getParameter("plate");
					int nextyear = (Integer.parseInt(StringUtil.toString(Calendar.getInstance().getTime(), "yyyy"))+1);
	                Checking cEntity = queryBean.getChecked(plate);
	                if(cEntity != null){
                %>
                  <table width="700" border="1" cellpadding="0" cellspacing="0" bordercolor="#D8D8C4">
                    <tr> 
                      <td bordercolor="#D8D8C4"> <form action="?" method="post" name="editdataform" id="editdataform">
                          <table width="700" border="0" cellpadding="1" cellspacing="0">
                            <tr class="lineborder"> 
                              <td width="20%" align="right"><font color="#FF0000">*</font> <font face="Microsoft Sans Serif">ทะเบียนรถ</font></td>
                              <td width="30%"> <input name="license" type="text" class="text" id="license" size="15" maxlength="10" value="<%= ShowData.CheckNull(cEntity.getLicense()) %>"> 		                              	 </td>
                              <td width="20%" align="right">จังหวัด</td>
                              <td width="30%" >
	                              <SELECT NAME="province" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("province").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - -   เลือกจังหวัด   - - - </OPTION>
	                              	<%
	  	                              	     ParameterManager manage = new ParameterManager();
	  	                              	     Vector tabs = manage.getParamDetail(new ParameterDetail(1,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getProvince() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">วันตรวจ </font></td>
                              <td><input type="text" size="10" value="<%= ShowData.CheckNull(cEntity.getCerDate()) %>" class="disabletext" readonly name="cerdate" id="cerdate" onfocus="displayCalendar(document.editdataform.cerdate,'dd/mm/yyyy',this)"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">วันจดทะเบียน</td>
                              <td><input type="text" size="10" value="<%= ShowData.CheckNull(cEntity.getRegisDate()) %>" class="disabletext" readonly name="regisdate" id="regisdate" onfocus="displayCalendar(document.editdataform.regisdate,'dd/mm/yyyy',this)"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เลขตัวรถ </font></td>
                              <td><input name="coachworkno" type="text" class="text" id="coachworkno" size="20" maxlength="20" value="<%= ShowData.CheckNull(cEntity.getCoachWorkNo()) %>"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เลขเครื่องยนต์</td>
                              <td><input name="motorno" type="text" class="text" id="motorno" size="20" maxlength="20" value="<%= ShowData.CheckNull(cEntity.getMotorNo()) %>"> </td>
                            </tr>
                            <tr class="lineborder">
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ประเภทรถ </font></td>
                              <td>
	                              <SELECT NAME="category" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("category").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(7,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getCategory() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ลักษณะรถ </font></td>
                              <td>
	                              <SELECT NAME="characteristic" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("characteristic").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(8,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getCharacteristic() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดรถ </font></td>
                              <td>
	                              <SELECT NAME="brandid" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("brandid").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(2,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getBrandId() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดเครื่องยนต์ </font></td>
                              <td>
	                              <SELECT NAME="motor" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("motor").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(2,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getMotor() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ชนิดเชื้อเพลิง </font></td>
                              <td>
	                              <SELECT NAME="fuel" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("fuel").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(9,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getFuel() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ตำแหน่งเลขตัวรถ </font></td>
                              <td>
	                              <SELECT NAME="coachworknopos" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("coachworknopos").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(10,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getCoachWorkNoPos() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ตำแหน่งเลขเครื่องยนต์ </font></td>
                              <td>
	                              <SELECT NAME="motornopos" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("motornopos").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(11,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getMotorNoPos() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ผู้ควบคุมการตรวจ </font></td>
                              <td>
	                              <SELECT NAME="chkname" SIZE="1" >
	                              	<OPTION <%= (((subaction==null)||(request.getParameter("chkname").equals("-1")))?"SELECTED":"") %> 
	                              			VALUE="-1" > - - - เลือก  - - - </OPTION>
	                              	<%
	  	                              	     tabs = manage.getParamDetail(new ParameterDetail(12,-1));
	  	                              	     for (int i=0;i<tabs.size();i++) {
	  	                              	          ParameterDetail tab = (ParameterDetail)tabs.elementAt(i);
	                              	%>
	                            	<OPTION <%= ((cEntity.getChkName() == tab.getParId())?"SELECTED":"") %> 
	                            		VALUE="<%= tab.getParId() %>" > <%= tab.getParName() %> </OPTION>
                            	<%  } %>
	                              	</SELECT>
		                      </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">น้ำหนัก </font></td>
                              <td><input name="weight" size="10" type="number" class="number" id="weight" value="<%= cEntity.getWeight()==-1?"":cEntity.getWeight() %>" onchange="chkIntDecVal(editdataform.weight,'D')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">สูบ</td>
                              <td><input name="pump" type="number" class="number" id="pump" size="10" maxlength="2" value="<%= cEntity.getPump()==-1?"":cEntity.getPump() %>" onchange="chkIntDecVal(editdataform.pump,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ซีซี </font></td>
                              <td><input name="cc" size="10" maxlength="5" type="number" class="number" id="cc" value="<%= cEntity.getCc()==-1?"":cEntity.getCc() %>" onchange="chkIntDecVal(editdataform.cc,'N')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">เพลา</td>
                              <td><input name="axle" type="number" class="number" id="axle" size="10" maxlength="2" value="<%= cEntity.getAxle()==-1?"":cEntity.getAxle() %>" onchange="chkIntDecVal(editdataform.axle,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ล้อ </font></td>
                              <td><input name="wheel" size="10" maxlength="2" type="number" class="number" id="wheel" value="<%= cEntity.getWheel()==-1?"":cEntity.getWheel() %>" onchange="chkIntDecVal(editdataform.wheel,'N')"></td>
                              <td align="right" nowrap><font face="Microsoft Sans Serif">ยาง</td>
                              <td><input name="tire" type="number" class="number" id="tire" size="10" maxlength="2" value="<%= cEntity.getTire()==-1?"":cEntity.getTire() %>" onchange="chkIntDecVal(editdataform.tire,'N')"> </td>
                            </tr>
                            <tr class="lineborder"> 
                            	<td colspan="4" align="center"></td>
                            </tr>
                            <tr class="lineborder"> 
                              <td></td>
                              <td align="right">
                              	<input name="submitedit" type="submit" class="button" id="submitedit" onClick="MM_validateForm('license','ทะเบียน','R');return document.MM_returnValue" value="  แก้ไข  "> 
                              	<input name="action" type="hidden" id="action" value="edit"> 
                              	<input name="subaction" type="hidden" id="subaction" value="update"></td>
                              <td><input name="cancel" type="button" class="button" id="cancel" onClick="window.history.back()" value="ยกเลิก"></td>
                              <td>&nbsp;</td>
                            </tr>
                            <tr class="lineborder"> 
                              <td colspan="4">&nbsp;</td>
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
                 
                 %></td>
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