//-----------------------------------------------------------------------
//
//	Copyright 2002 e Professional Corporation.  All Rights Reserved.
//
//	File:	StringUtil.java
//
//	Author:	Manz
//
//	Date:	14/05/2002
//     
//     Update by:  P
//-----------------------------------------------------------------------

package com.standard.util;

import java.io.IOException;
import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.StringTokenizer;

public class StringUtil implements Serializable {

//------------------------------------------------------------------------
//
//  Method:  toString
//
//  Synopsis:  Convert   java.util.Date date,  to string   format DD/MM/YYYY 
//  Arguments: The Method  requires a value of   java.util.Date date  
//  Returns:   The  method will return a value of java.sql.Date 
//  Notes:     none
//
//------------------------------------------------------------------------
	public static String toString(Date date) { 
		return toString(date, "dd/MM/yyyy") ;
	}

	public static String toString(Date date, String dateFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat (dateFormat) ;
		return formatter.format(date) ;
	}
	
	public static String  toStringTH(Date date) {
		return toStringTH(date, "dd/MM/yyyy") ;
	}

	public static String toStringTH(Date date, String dateFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat (dateFormat, new java.util.Locale("th","TH")) ;
		return formatter.format(date) ;
	}		

//------------------------------------------------------------------------
//
//  Method:  toString
//
//  Synopsis:  Convert   java.sql.Date date,  to string   format DD/MM/YYYY 
//  Arguments: The Method  requires a value of   java.sql.Date date  
//  Returns:   The  method will return a value of java.sql.Date  or  String dateFormat e.g.,
//                      "dd/MM/yyyy"
//  Notes:     none
//
//------------------------------------------------------------------------
	public static String  toString(java.sql.Date date) {
		return toString(date, "dd/MM/yyyy") ;
	}
	public static String toStringMonth(String month) {
		return month==null?null:toString(DateUtil.toUtilDate("01/"+month+"/2009") , "MMMMM") ;
	}

	public static String toString(java.sql.Date date, String dateFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat (dateFormat) ;
		return formatter.format(date) ;
	}		
	
	public static String  toStringTH(java.sql.Date date) {
		return toStringTH(date, "dd/MM/yyyy") ;
	}

	public static String toStringTH(java.sql.Date date, String dateFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat (dateFormat, new java.util.Locale("th","TH")) ;
		return formatter.format(date) ;
	}		

//------------------------------------------------------------------------
//
//  Method:  toString
//
//  Synopsis:  Convert   java.util.Date date,  to string   format DD/MM/YYYY 
//  Arguments: The Method  requires a value of   java.util.Date date  
//  Returns:   The  method will return a value of java.sql.Date 
//  Notes:     none
//
//------------------------------------------------------------------------
	public static String  toString(Timestamp timeStampDate) {
		return toString(timeStampDate, "dd/MM/yyyy") ;
	}

	public static String  toString(Timestamp timeStampDate, String dateFormat) {
		SimpleDateFormat formatter = new SimpleDateFormat (dateFormat) ;
		return formatter.format(timeStampDate) ;
	}

//------------------------------------------------------------------------
//
//  Method:  stringTokenToArray
//
//  Synopsis:  Convert String into array with separet with String delim
//  Arguments: The Method  requires a String and  dilimeter 
//  Returns:   The  method will return a value of java.sql.Date 
//  Notes:     none
//
//------------------------------------------------------------------------
   public static String[] stringTokenToArray(String src) {
		return stringTokenToArray(src, "|") ;
	}

	public static String[] stringTokenToArray(String src, String delim) {
		String[] returnValue = null;
		
		StringTokenizer  tokens = new StringTokenizer(src, delim) ;
		returnValue = new String[tokens.countTokens()] ;
		for(int i = 0 ; tokens.hasMoreTokens() ; i++)
			returnValue[i] = tokens.nextToken() ;
		return returnValue ;
	}

//------------------------------------------------------------------------
//
//  Method:  replace
//
//  Synopsis:  replace String in old word
//  Arguments: The Method  requires a String sourceString ,String oldWord and  String newWord
//  Returns:   The  method will return a value of String    resultString  with already replace
//  Notes:     none
//
//------------------------------------------------------------------------
	public static String replace(String sourceString, String oldWord, String newWord,boolean  ignoreCase  ) {
		String resultString = sourceString ;
      
		if (ignoreCase ==true ){
			if ((sourceString.toLowerCase()).indexOf(oldWord.toLowerCase()) >= 0) {
				resultString = sourceString.substring(0, (sourceString.toLowerCase()).indexOf(oldWord.toLowerCase())) + newWord + sourceString.substring((sourceString.toLowerCase()).indexOf(oldWord.toLowerCase()) + oldWord.length()) ;
			}
		}else {
			if (sourceString.indexOf(oldWord) >= 0) {
				resultString = sourceString.substring(0, sourceString.indexOf(oldWord)) + newWord + sourceString.substring(sourceString.indexOf(oldWord) + oldWord.length()) ;
			}
		
		}
		return resultString ;
	}
	
	public static String replaceAll(String sourceString, String oldWord, String newWord,boolean  ignoreCase) {
		StringBuffer firstString = new StringBuffer("") ;
		StringBuffer lastString = new StringBuffer(sourceString) ;
		if (ignoreCase ==true ){
			while(((lastString.toString()).toLowerCase()).indexOf(oldWord.toLowerCase()) >= 0) {
				firstString.append( lastString.substring(0, ((lastString.toString()).toLowerCase()).indexOf(oldWord.toLowerCase()) ) + newWord) ;
				lastString = new StringBuffer(lastString.substring(((lastString.toString()).toLowerCase()).indexOf(oldWord.toLowerCase()) + oldWord.length())) ;
			}	
		}else {
			while(lastString.toString().indexOf(oldWord) >= 0) {
				firstString.append( lastString.substring(0, lastString.toString().indexOf(oldWord) ) + newWord) ;
				lastString = new StringBuffer(lastString.substring(lastString.toString().indexOf(oldWord) + oldWord.length())) ;
			}	
		}
			
		
			return firstString.toString() + lastString.toString() ;
	}

	
	public static String replaceLast(String sourceString, String oldWord, String newWord,boolean  ignoreCase) {
		String resultString = sourceString ;
		if (ignoreCase ==true ){
			if ((sourceString.toLowerCase()).indexOf(oldWord.toLowerCase()) >= 0) {
				resultString = sourceString.substring(0, (sourceString.toLowerCase()).lastIndexOf(oldWord.toLowerCase())) + newWord + sourceString.substring((sourceString.toLowerCase()).lastIndexOf(oldWord.toLowerCase()) + oldWord.length()) ;
			}
		}else {	
			if (sourceString.indexOf(oldWord) >= 0) {
			resultString = sourceString.substring(0, sourceString.lastIndexOf(oldWord)) + newWord + sourceString.substring(sourceString.lastIndexOf(oldWord) + oldWord.length()) ;
			}
		}
		return resultString ;
	}

 //------------------------------------------------------------------------
//
//  Method:  token2Array
//
//  Synopsis:  Convert String into array with separet with String delim
//  Arguments: The Method  requires a String and  dilimeter 
//  Returns:   The  method will return a value of java.sql.Date 
//  Notes:     none
//
//------------------------------------------------------------------------       	
   public static String[] token2Array(String src) {
		return token2Array(src, "|") ;
	}

	public static String[] token2Array(String src, String delim) {
		String[] result = null ;
		
		StringTokenizer tokens = new StringTokenizer(src, delim) ;
		result = new String[tokens.countTokens()] ;
		for(int i = 0 ; tokens.hasMoreTokens() ; i++)
			result[i] = tokens.nextToken() ;
		return result ;
	}    

//------------------------------------------------------------------------
//
//  Method:  encode2Thai
//
//  Synopsis:  encode   character  to Thai language  
//  Arguments: The Method  requires a value of  String src  with input for encode  
//  Returns:   The  method will return a value of java.sql.Date 
//  Notes:     none
//
//------------------------------------------------------------------------	
	public static String encode2Thai(String src) throws IOException {
		return src==null?null:(new String(src.getBytes("ISO8859_1"), "MS874")) ;
	}
	public static String encode2TIS(String src) throws IOException {
		return src==null?null:new String(src.getBytes("ISO8859_1"), "TIS-620") ;
	}
	
	public static String encode2CE(String src) throws IOException {
		return src==null?null:new String(src.getBytes("MS874"), "ISO8859_1") ;
	}	

	   public static String Unicode2ASCII(String unicode) {
		   if (unicode==null) return null;
	       StringBuffer ascii = new StringBuffer(unicode);
	       int code;
	       for(int i = 0; i < unicode.length(); i++) {
	           code = (int)unicode.charAt(i);
	           if ((0xE01<=code) && (code <= 0xE5B ))
	               ascii.setCharAt( i, (char)(code - 0xD60));
	       }
	       return ascii.toString();
	   }

	   public static String ASCII2Unicode(String ascii) {
		   if (ascii==null) return null;
	       StringBuffer unicode = new StringBuffer(ascii);
	       int code;
	       for(int i = 0; i < ascii.length(); i++) {
	           code = (int)ascii.charAt(i);
	           if ((0xA1 <= code) && (code <= 0xFB))
	               unicode.setCharAt( i, (char)(code + 0xD60));
	       }
	       return unicode.toString();

	   }

}    	
