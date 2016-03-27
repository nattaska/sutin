package com.insurance.manage;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.insurance.entity.Customer;
import com.insurance.entity.CustomerPage;
import com.standard.STDException;
import com.standard.util.StringUtil;

public class UploadFile  extends HttpServlet {
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String pictype = (String)session.getAttribute("pictype");
		if ("license".equalsIgnoreCase(pictype)) {
			this.uploadLicense(request, response);
		} else if ("fire".equalsIgnoreCase(pictype)) {
			this.uploadFire(request, response);
			
		} else if ("life".equalsIgnoreCase(pictype)) {
			this.uploadLife(request, response);			
		}
	}
	
	private void uploadLicense(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException { 
//		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//		 Create a factory for disk-based file items
		String custId=null;
		String year=null;
		String license=null;
		CustomerManager cManage = new CustomerManager();
		DiskFileItemFactory  factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1*1024*1024); //1 MB
		factory.setRepository(new File("temp"));
		
//		 Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		HttpSession session = request.getSession();
//		System.out.println("eCust : "+session.getAttribute("eCust"));
//		if (session.getAttribute("eCust")!=null) {
//			Customer cEntity = (Customer)request.getAttribute("eCust");
//			System.out.println("CustId : "+cEntity.getName());
//		}

//		 Parse the request
//		System.out.println("--------- Uploading --------------");
		try {
			List /* FileItem */ items = upload.parseRequest(request);
//			 Process the uploaded items
			Iterator iter = items.iterator();
			File fi = null ;
			File file = null ;
			Calendar calendar = Calendar.getInstance();
	    	DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
	    	String fileName = df.format(calendar.getTime()) + ".jpg";
			while (iter.hasNext()) {
			    FileItem item = (FileItem) iter.next();

			    if (item.isFormField()) {
//			    	System.out.println(item.getFieldName()+" : "+item.getName()+" : "+item.getString()+" : "+item.getContentType());
			    	if (item.getFieldName().equals("custId")&&!item.getString().equals("")) {
			    		custId = item.getString();
//			    		System.out.println("custId : "+custId);
			    	}
			    	if (item.getFieldName().equals("year")&&!item.getString().equals("")) {
			    		year = item.getString();
//			    		System.out.println("year : "+year);
			    	}
			    	if (item.getFieldName().equals("license")&&!item.getString().equals("")) {
			    		license = (String)session.getAttribute(item.getString());
//			    		System.out.println("license : "+license+" : "+session.getAttribute(item.getString()));
			    	}
			    } else {
//			    	Handle Uploaded files.
//			    	System.out.println("Handle Uploaded files.");
			    	if (item.getFieldName().equals("vat")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/license/vat/"+year+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "vatpic", year+fileName);
			    	}
			    	if (item.getFieldName().equals("car")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/license/car/"+year+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "carpic", year+fileName);
			    	}
			    	if (item.getFieldName().equals("act")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/license/act/"+year+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "actpic", year+fileName);
			    	}
			    	if (item.getFieldName().equals("chk")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/license/chk/"+year+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "chkpic", year+fileName);
			    	}
			    }
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();			
		}
		request.setAttribute("url", "setup/CustomerMultiMT.jsp?action=search&custId="+custId);
        request.setAttribute("msg", "!!!Uploading !!!");
        getServletConfig().getServletContext().getRequestDispatcher("/Reload.jsp").forward(request, response);
		
	}
	
	private void uploadFire(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException { 
//		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//		 Create a factory for disk-based file items
		String custId=null;
		String year=null;
		String license=null;
		CustomerManager cManage = new CustomerManager();
		DiskFileItemFactory  factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1*1024*1024); //1 MB
		factory.setRepository(new File("temp"));
		
//		 Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		HttpSession session = request.getSession();

//		 Parse the request
//		System.out.println("--------- Uploading --------------");
		try {
			List /* FileItem */ items = upload.parseRequest(request);
//			 Process the uploaded items
			Iterator iter = items.iterator();
			File fi = null ;
			File file = null ;
//   		Calendar calendar = Calendar.getInstance();
//	    	DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
//	    	String fileName = df.format(calendar.getTime()) + ".jpg";
			while (iter.hasNext()) {
			    FileItem item = (FileItem) iter.next();

			    if (item.isFormField()) {
//			    	System.out.println(item.getFieldName()+" : "+item.getName()+" : "+item.getString()+" : "+item.getContentType());
			    	if (item.getFieldName().equals("custId")&&!item.getString().equals("")) {
			    		custId = item.getString();
			    		System.out.println("custId : "+custId);
			    	}
			    	if (item.getFieldName().equals("year")&&!item.getString().equals("")) {
			    		year = item.getString();
			    		System.out.println("year : "+year);
			    	}
			    } else {
//			    	Handle Uploaded files.
//			    	System.out.println("Handle Uploaded files.");
			    	String fileName = year + custId + ".jpg";
			    	if (item.getFieldName().equals("fire")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/fire/"+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "firepic", fileName);
			    	}
			    }
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();			
		}
		request.setAttribute("url", "setup/CustomerMultiMT.jsp?action=search&custId="+custId);
        request.setAttribute("msg", "!!!Uploading !!!");
        getServletConfig().getServletContext().getRequestDispatcher("/Reload.jsp").forward(request, response);
		
	}
	
	private void uploadLife(HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException { 
//		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
//		 Create a factory for disk-based file items
		String custId=null;
		String year=null;
		String license=null;
		CustomerManager cManage = new CustomerManager();
		DiskFileItemFactory  factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1*1024*1024); //1 MB
		factory.setRepository(new File("temp"));
		
//		 Create a new file upload handler
		ServletFileUpload upload = new ServletFileUpload(factory);
		HttpSession session = request.getSession();

//		 Parse the request
//		System.out.println("--------- Uploading --------------");
		try {
			List /* FileItem */ items = upload.parseRequest(request);
//			 Process the uploaded items
			Iterator iter = items.iterator();
			File fi = null ;
			File file = null ;
//			Calendar calendar = Calendar.getInstance();
//	    	DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
//	    	String fileName = df.format(calendar.getTime()) + ".jpg";
			while (iter.hasNext()) {
			    FileItem item = (FileItem) iter.next();

			    if (item.isFormField()) {
//			    	System.out.println(item.getFieldName()+" : "+item.getName()+" : "+item.getString()+" : "+item.getContentType());
			    	if (item.getFieldName().equals("custId")&&!item.getString().equals("")) {
			    		custId = item.getString();
			    		System.out.println("custId : "+custId);
			    	}
			    	if (item.getFieldName().equals("year")&&!item.getString().equals("")) {
			    		year = item.getString();
			    		System.out.println("year : "+year);
			    	}
			    } else {
//			    	Handle Uploaded files.
//			    	System.out.println("Handle Uploaded files.");
			    	String fileName = year + custId + ".jpg";
			    	if (item.getFieldName().equals("life")&&!item.getName().equals("")) {
					    fi = new File(item.getName());
					    File uploadedFile = new File(getServletContext().getRealPath("/images/life/"+fileName));
					    item.write(uploadedFile);
					    cManage.updatePicture(custId, year, license, "lifepic", fileName);
			    	}
			    }
			}
		} catch (FileUploadException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();			
		}
		request.setAttribute("url", "setup/CustomerMultiMT.jsp?action=search&custId="+custId);
        request.setAttribute("msg", "!!!Uploading !!!");
        getServletConfig().getServletContext().getRequestDispatcher("/Reload.jsp").forward(request, response);
		
	}

}	 
//	the above code represents for uploading file and images using java. download the file the folliwing code ileInputStream fis = null; String location=getLocation(locationKey); if(!location.endsWith("			")) location=location+"			"; int index=fileName.lastIndexOf('.'); String docType=fileName.substring(index+1,fileName.length()); String docName=fileName.substring(0,index);	 try { fis = new FileInputStream(location+fileName); int noOfBytes = fis.available(); byte[] dataBytes = new byte[noOfBytes]; fis.read(dataBytes); writeToServletOutputStream(response,docType,docName,dataBytes); } catch (FileNotFoundException f) { } finally { if(fis != null) { fis.close(); } }	 for image downloading u have u have to use this data FileInputStream fis = null;	 byte[] dataBytes=null; try { fis = new FileInputStream(filePath); int noOfBytes = fis.available(); dataBytes = new byte[noOfBytes]; fis.read(dataBytes); } catch (FileNotFoundException f) { } finally { if(fis != null) { fis.close(); } } return dataBytes; for image downloading the bytes that are returned that has to be kept request.getSession().setAttribute("imageData",CommonUtils.getImageData(request,imageLoc)); keep that in session attribute in java class access that session attribute in jsp page1 i used the following code  picture.jsp file another file in this u have to write the following code dynamically the code is <% ServletOutputStream sos=null; byte[] baos = (byte[])session.getAttribute("imageData"); try { if(baos!=null) { response.setContentType("image/gif"); sos= response.getOutputStream(); sos.write(baos); System.out.println("inside the if block in picture jsp"); } sos.flush(); } catch(Exception e) { e.printStackTrace(); } %>}
