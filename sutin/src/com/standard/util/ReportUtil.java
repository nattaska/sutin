package com.standard.util;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.util.JRLoader;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.standard.db.DBControl;

public class ReportUtil extends DBControl {
	
	public boolean generateReport(String filename, Map parameters, String type,HttpServletRequest request,HttpServletResponse response) {
		Connection conn = null;
		request.getPathInfo();
		
	   try {

	     conn = getConnection(); 
	     // getCompiledReport(request, filename);
	     File reportFile = new File("D:/C4Source/Kung/WebContent/reports/" + filename + ".jasper");
	     System.out.println(reportFile.getPath());
//	     System.out.println(request.get));
	     JasperReport jasperReport = ( JasperReport ) JRLoader.loadObject( reportFile.getPath() );
	     JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile.getPath(), parameters, conn);

	     if ( type.equals( "HTML" ) ) {
	       generateHtmlOutput( jasperPrint, request, response );
	     }
	     else if ( type.equals( "PDF" ) ) {
	       generatePDFOutput( response, parameters, jasperReport );
	     }
	     else if ( type.equals( "EXCEL" ) ) {
	       generateExcelOutput( response, parameters, jasperReport, jasperPrint );
	     }

	   }
	   catch ( Exception ex ) {
	     ex.printStackTrace();
	   }
		return true;
	}

//	private JasperReport getCompiledReport(HttpServletRequest request, String fileName ) throws JRException {
////		   File reportFile = new File(getServletPath().getRealPath("/reports/" + fileName + ".jasper" ) );
//		   File reportFile = new File(getServletPath().getRealPath("/reports/" + fileName + ".jasper" ) );
//
//	   // If compiled file is not found, then
//	   // compile XML template
//	   if ( !reportFile.exists() ) {
//	     JasperCompileManager.compileReportToFile(
//	         getServletContext().getRealPath(
//	         "/reports/" + fileName + ".xml" ) );
//	   }
//
//	   JasperReport jasperReport =
//	       ( JasperReport ) JRLoader.loadObject( reportFile.getPath() );
//
//	   return jasperReport;
//	 }
	
	private void generateHtmlOutput(JasperPrint jasperPrint,HttpServletRequest req,HttpServletResponse response ) throws IOException, JRException {
         JRHtmlExporter exporter = new JRHtmlExporter();
         exporter.setParameter( JRExporterParameter.JASPER_PRINT, jasperPrint );
         exporter.setParameter( JRExporterParameter.OUTPUT_WRITER,response.getWriter() );
         exporter.exportReport();
	}
	
	private void generateExcelOutput(
		     HttpServletResponse response,
		     Map parameters,
		     JasperReport jasperReport, JasperPrint jasperPrint ) throws JRException, NamingException, SQLException, IOException {

		   byte[] bytes = null;
		   JRXlsExporter exporter = new JRXlsExporter();
		   ByteArrayOutputStream xlsReport = new ByteArrayOutputStream();
		   exporter.setParameter( JRExporterParameter.JASPER_PRINT, jasperPrint );
		   exporter.setParameter( JRExporterParameter.OUTPUT_STREAM, xlsReport );
		   exporter.setParameter( JRExporterParameter.OUTPUT_FILE_NAME, "sample.xls" );
		   exporter.exportReport();

		   bytes = xlsReport.toByteArray();

		   response.setContentType( "application/vnd.ms-excel" );
		   response.setContentLength( bytes.length );
		   ServletOutputStream ouputStream = response.getOutputStream();
		   ouputStream.write( bytes, 0, bytes.length );
		   ouputStream.flush();
		   ouputStream.close();

		 }
	
	private void generatePDFOutput(HttpServletResponse resp,Map parameters, JasperReport jasperReport ) throws JRException, NamingException, SQLException, IOException {

		   byte[] bytes = null;
		   bytes =
		       JasperRunManager.runReportToPdf(
		       jasperReport,
		       parameters,
		       getConnection() );

		   resp.setContentType( "application/pdf" );
		   resp.setContentLength( bytes.length );
		   ServletOutputStream ouputStream = resp.getOutputStream();
		   ouputStream.write( bytes, 0, bytes.length );
		   ouputStream.flush();
		   ouputStream.close();

		 }

}
