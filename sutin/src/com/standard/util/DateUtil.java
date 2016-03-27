//-----------------------------------------------------------------------
//
//	Copyright 2002 e Professional Corporation.  All Rights Reserved.
//
//	File:	DateUtil.java
//
//	Author:	P
//
//	Date:	11/02/2003
//     
//    Comment :  Some Method are applied from old version
//-----------------------------------------------------------------------
package com.standard.util;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;
import java.util.StringTokenizer;
import java.util.Vector;
 

public class DateUtil implements Serializable {
	//------------------------------------------------------------------------
	//
	//  Method       :toSQLDate
	//  Synopsis   : Convert   java.sql.Timestamp  timeStampDate ,
	//                                            java.util.Date  utilDate ,String   sDate, format DD/MM/YYYY or DD/MM/YY 
	//                                             to java.sql.Date
	//  Arguments:The Method  requires a value of  String sDate  ,format DD/MM/YYYY 
	//                         a value of  java.util.Date ,a value of  java.sql.Timestamp
	//  Returns      :The  method will return a value of java.sql.Date 
	//  Notes         :none
	//
	//------------------------------------------------------------------------


	final public static int EN = 1;
	final public static int TH = 2;


	public static java.sql.Date toSQLDate(String sDate) {
		return toSQLDate(sDate, "dd/MM/yyyy");
	}

	public static java.sql.Date toSQLDate(String sDate, String format) {
			java.sql.Date sqlDate = null;
			Date utilDate = null;
			if (sDate !=null){
				utilDate =toUtilDate(sDate,format);
				sqlDate=   toSQLDate(utilDate);
			}
			return  sqlDate;
	}


	public static java.sql.Date toSQLDate(Date utilDate) {
		java.sql.Date sqlDate = null;
		sqlDate = new java.sql.Date(utilDate.getTime());
		return sqlDate;
	}

	public static java.sql.Date toSQLDate(Timestamp timeStampDate) {
		java.sql.Date sqlDate = null;
		sqlDate = new java.sql.Date(new GregorianCalendar(timeStampDate.getYear(), timeStampDate.getMonth(), timeStampDate.getDate()).getTime().getTime());

		return sqlDate;
	}

	//------------------------------------------------------------------------
	//
	//  Method        : toUtilDate
	//
	//  Synopsis     :Convert   java.sql.Timestamp  timeStampDate ,
	//                                             java.sql.Date  sqlDate ,
	//											 String   sDate, format DD/MM/YYYY or DD/MM/YY  
	//                                             to   java.util.Date 
	//  Arguments  :The Method  requires a value of  String sDate  ,format DD/MM/YYYY 
	//                           a value of  java.util.Date ,a value of  java.sql.Timestamp
	//  Returns        :The  method will return a value of java.util.Date
	//  Notes           :none
	//
	//------------------------------------------------------------------------
	public static Date toUtilDate(String sDate) {
		return toUtilDate(sDate, "dd/MM/yyyy");
	}

	public static Date toUtilDate(String sDate, String format) {
		Date utilDate = null;
		try {
			SimpleDateFormat tempDate = new SimpleDateFormat(format);
			utilDate = tempDate.parse(sDate);
		} catch (ParseException e) {
			System.out.println("Found error exception while toUtilDate.\n" + e);
		}
		return utilDate;
	}

	public static Date toUtilDate(java.sql.Date sqlDate) {
		Date utilDate = null;
		utilDate = (Date)sqlDate;
		return utilDate;
	}

	public static Date toUtilDate(Timestamp timeStampDate) {
		Date utilDate = null;
		GregorianCalendar gc = new GregorianCalendar(timeStampDate.getYear(), timeStampDate.getMonth(), timeStampDate.getDate());
		utilDate = gc.getTime();
		return utilDate;
	}

	//------------------------------------------------------------------------
	//
	//  Method:  toTimeStamp
	//
	//  Synopsis:  Convert  	java.util.Date  utilDate ,
	//                                          	java.sql.Date  sqlDate ,
	//											String   sDate, format DD/MM/YYYY or DD/MM/YY 
	//                                           to   java.sql.Timestamp
	//  Arguments: The Method  requires a value of  String sDate 
	//  Returns:   The  method will return a value of java.util.Date
	//  Notes:     none
	//
	//------------------------------------------------------------------------
	public static Timestamp toTimeStamp(String sDate) {
		return toTimeStamp(sDate, "dd/MM/yyyy");
	}

	public static Timestamp toTimeStamp(String sDate, String format) {
		   Timestamp timeStampDate = null;
			Date utilDate = null;
			if (sDate != null){
				utilDate =toUtilDate(sDate,format);
				timeStampDate=   toTimeStamp(utilDate);
			}
			return  timeStampDate;
	}

	public static Timestamp toTimeStamp(Date utilDate) {
		Timestamp timeStampDate = null;
		if (utilDate != null) {
			timeStampDate = new Timestamp(utilDate.getTime());
		}
		return timeStampDate;
	}

	public static Timestamp toTimeStamp(java.sql.Date sqlDate) {
		Timestamp timeStampDate = null;
		if (sqlDate != null) {
			timeStampDate = new Timestamp(sqlDate.getTime());
		}
		return timeStampDate;
	}

	public static Date changeToThaiDate(Date utilDate) {
		java.util.Calendar calendar = java.util.Calendar.getInstance();
		calendar.setTime(utilDate);
		if (calendar.get(java.util.Calendar.YEAR) < 2500)
		{
			calendar.set(Calendar.YEAR , calendar.get(java.util.Calendar.YEAR) + 543);
		}
		return (calendar.getTime());
	}

	public static Date changeToEnDate(Date utilDate) {
		java.util.Calendar calendar = java.util.Calendar.getInstance();
		calendar.setTime(utilDate);
		if (calendar.get(java.util.Calendar.YEAR) > 2500)
		{
			calendar.set(Calendar.YEAR , calendar.get(java.util.Calendar.YEAR) - 543);
		}
		return (calendar.getTime());
	}
	
	public static Date changeToThaiDate(String utilDate) {		
		java.util.Calendar calendar = java.util.Calendar.getInstance();
		calendar.setTime(toUtilDate(utilDate));
		if (calendar.get(java.util.Calendar.YEAR) < 2500)
		{
			calendar.set(Calendar.YEAR , calendar.get(java.util.Calendar.YEAR) + 543);
		}
		return (calendar.getTime());
	}

	public static Date changeToEnDate(String utilDate) {
		java.util.Calendar calendar = java.util.Calendar.getInstance();
		calendar.setTime(toUtilDate(utilDate));
		if (calendar.get(java.util.Calendar.YEAR) > 2500)
		{
			calendar.set(Calendar.YEAR , calendar.get(java.util.Calendar.YEAR) - 543);
		}
		return (calendar.getTime());		
	}





	



	public static String getJavaScriptDate(java.util.Date date)
	{
		SimpleDateFormat formatter = new SimpleDateFormat ("MMMMMMMM dd, yyyy", Locale.US);				
		String dateString = formatter.format(date);
		dateString += " 00:00:00";
 		
		return "'"+dateString+"'";
	}

	public static String getJavaScriptDate(Calendar date)
	{
		return getJavaScriptDate(date.getTime());
	}

	/**
	 * @param String("dd/MM/yyyy)
	 * @return int
	 */
	public static Vector getElementDate(String dateStr)
	{
		Vector vec = new Vector();
		StringTokenizer stk = new StringTokenizer(dateStr, "/"); 
		while (stk.hasMoreElements())
			vec.addElement((String)stk.nextElement());
		return vec;		
	}
	
	/**
	 * @param String("dd/MM/yyyy)
	 * @return Calendar 
	 */
	public static Calendar getCalendar(String dateStr, int inputYearType, int outputYearType)
	{	
		// date (dd/MM/yyyy)
		Vector d = getElementDate(dateStr);
		
		int day   = Integer.parseInt((String)d.elementAt(0));
		int month = Integer.parseInt((String)d.elementAt(1));
		int year  = Integer.parseInt((String)d.elementAt(2));
		
			switch (inputYearType)
			{
				case EN :
						if (outputYearType==TH)
							year += 543;
						break;
				case TH :
						if (outputYearType==EN)
							year -= 543;
						break;
			}
			
			return new GregorianCalendar(year, month-1, day); 	//MUST SUB 1, BECAUSE MONTH START FROM 0
	}
}