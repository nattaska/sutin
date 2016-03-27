package com.standard.util;

public class ConvertDataType implements java.io.Serializable {

	public ConvertDataType() {
	
	}

	public java.util.Date ConvertStringToUtilDate(String dateString, String delim) {
		java.util.Date returnValue = new java.util.Date();
		if(dateString != null && !dateString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(dateString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-1900);
	 	}	
		return returnValue;
	}
	
	public java.util.Date ConvertStringThaiToUtilDateEng(String dateString, String delim) {
		java.util.Date returnValue = new java.util.Date();
		if(dateString != null && !dateString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(dateString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-543-1900);
	 	}	
		return returnValue;
	}

	public java.sql.Date ConvertStringToSqlDate(String dateString, String delim) {
		java.util.Date currenDate = new java.util.Date();
		java.sql.Date returnValue = new java.sql.Date(currenDate.getYear(), currenDate.getMonth(), currenDate.getDate());
		if(dateString != null && !dateString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(dateString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-1900);
	 	}	
		return returnValue;
	}

	public java.sql.Date ConvertStringThaiToSqlDateEng(String dateString, String delim) {
		java.util.Date currenDate = new java.util.Date();
		java.sql.Date returnValue = new java.sql.Date(currenDate.getYear(), currenDate.getMonth(), currenDate.getDate());
		if(dateString != null && !dateString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(dateString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-543-1900);
	 	}	
		return returnValue;
	}

	public java.sql.Timestamp ConvertStringToTimestamp(String timeStampString, String delim) {
		java.util.Date currenDate = new java.util.Date();
		java.sql.Timestamp returnValue = new java.sql.Timestamp(currenDate.getTime());
		if(timeStampString != null && !timeStampString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(timeStampString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-1900);
	 	}	
		return returnValue;
	}

	public java.sql.Timestamp ConvertStringThaiToTimestampEng(String timeStampString, String delim) {
		java.util.Date currenDate = new java.util.Date();
		java.sql.Timestamp returnValue = new java.sql.Timestamp(currenDate.getTime());
		if(timeStampString != null && !timeStampString.equals("")) {
	 		StringUtil stringUtil  = new StringUtil();
			String[] dateStringArray = stringUtil.token2Array(timeStampString,delim);
			
			returnValue.setDate(Integer.parseInt(dateStringArray[0]));
			returnValue.setMonth(Integer.parseInt(dateStringArray[1])-1);
			returnValue.setYear(Integer.parseInt(dateStringArray[2])-543-1900);
	 	}	
		return returnValue;
	}

}	
