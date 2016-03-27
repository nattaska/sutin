/*
 * Created on 25 ¾.Â. 2548
 *
 */
package com.insurance.report;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.standard.db.DBControl;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
//import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;

public class SummaryReport extends HttpServlet {
	private static final long serialVersionUID = -2896178714254206726L;
	private final String pathFile = "/reports/";
    /** Initializes the servlet.
     */
    public void init(ServletConfig config) throws ServletException {
        super.init(config);        
    }
    
    /** Destroys the servlet.
     */
    public void destroy() {
        
    }
	
	private Map<String, Comparable> mapParameters(HttpServletRequest request) {
		Map<String, Comparable> parameters = new HashMap<String, Comparable>();
	    parameters.put("YEAR",new Integer(request.getParameter("year")));
	    parameters.put("SMONTH",request.getParameter("smonth"));
	    parameters.put("EMONTH",request.getParameter("emonth"));
	   return parameters;
		
	}
	
//	private void generatePDFOutput(HttpServletRequest request, HttpServletResponse response ) throws JRException, NamingException, SQLException, IOException, ServletException {
//
//	    Connection conn; 
//    	InputStream in;
//    	JasperPrint jasperPrint;
//		Map params = this.mapParameters(request);
//		System.out.println("Province : "+params.get("provinceId")+"\tDate : "+
//							params.get("SDATE")+"/"+params.get("month")+"-"+
//							params.get("EDATE")+"/"+params.get("month")+"\tFile : "+file);
//		System.out.println();
//		if (params == null) {
//	           request.setAttribute("url", "pages/service/CustomerListRP.jsp");
//	           request.setAttribute("msg", "!!!Please Select Report Type !!!");
//	           getServletConfig().getServletContext().getRequestDispatcher("/output.jsp").forward(request, response);			
//		} else {
//			conn = new DBControl().getConnection(); 
//			in = request.getSession().getServletContext().getResourceAsStream(this.pathFile+file+".jasper");
//			jasperPrint = JasperFillManager.fillReport(in, params, conn);
//			
//			ByteArrayOutputStream baos = new ByteArrayOutputStream();
//			JRPdfExporter exporter = new JRPdfExporter();
//	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
//	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
//	        exporter.exportReport();
//	        
//	        response.setContentType("application/pdf");
//	        Calendar calendar = Calendar.getInstance();
//	    	DateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
//	    	String fileName = file + df.format(calendar.getTime()) + ".pdf";
//	        response.setHeader("Content-disposition", "attachment; filename=" + fileName);
//	        ServletOutputStream out = response.getOutputStream();
//
//	        byte[]   output=  baos.toByteArray();
//	        out.write(output);
//	        out.flush();
//	        out.close();
//			
//		}
//
//	}
	
	private void generateRTFOutput(HttpServletRequest request, HttpServletResponse response ) throws JRException, NamingException, SQLException, IOException, ServletException {

	    Connection conn; 
    	InputStream in;
    	JasperPrint jasperPrint;
		Map<String, Comparable> params = this.mapParameters(request);
		System.out.println("Month : "+params.get("SMONTH")+"/"+params.get("YEAR")+"-"+
							params.get("EMONTH")+"/"+params.get("YEAR"));
		String url = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+this.pathFile;
		params.put("SUBREPORT_DIR",url);
		if (params == null) {
	           request.setAttribute("url", "pages/service/SummaryRP.jsp");
	           request.setAttribute("msg", "!!!Please Select Report Type !!!");
	           getServletConfig().getServletContext().getRequestDispatcher("/output.jsp").forward(request, response);			
		} else {
			conn = new DBControl().getConnection(); 
			in = request.getSession().getServletContext().getResourceAsStream(this.pathFile+"sum_license.jasper");
			jasperPrint = JasperFillManager.fillReport(in, params, conn);
			
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			JRRtfExporter exporter = new JRRtfExporter();
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
	        exporter.exportReport();
	        
	        Calendar calendar = Calendar.getInstance();
	    	DateFormat df = new SimpleDateFormat("yyyyMMddHHmm");
	    	String fileName = "Summary" + df.format(calendar.getTime()) + ".rtf";
	        response.setHeader("Content-disposition", "attachment; filename=" + fileName);
	        ServletOutputStream out = response.getOutputStream();

	        byte[]   output=  baos.toByteArray();
	        out.write(output);
	        out.flush();
	        out.close();
			
		}

	}
    
    /** Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
	    try {
//			this.generatePDFOutput(request, response);
			this.generateRTFOutput(request, response);
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /** Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	try {
//			this.generatePDFOutput(request, response);
			this.generateRTFOutput(request, response);
		} catch (JRException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    }
    
    /** Returns a short description of the servlet.
     */
    public String getServletInfo() {
        return "Short description";
    }
}
