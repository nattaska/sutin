package com.standard.util;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;


public class ShowData implements Serializable {

	public ShowData() {
	
	}
	
	public static String CheckNull(String checkValue){
		return CheckNull(checkValue, "");
	}
	public static String CheckNull(String checkValue, String showValue){
		String returnValue=showValue;
		if(checkValue != null)
			returnValue = checkValue;
		return returnValue;
	}

	public String CheckNull(int checkValue){
		String returnValue="";
		if(String.valueOf(checkValue) != "null")
			returnValue = String.valueOf(checkValue);
		return returnValue;
	}

	public String CheckNull(boolean checkValue){
		String returnValue="";
		if(String.valueOf(checkValue) != "null")
			returnValue = String.valueOf(checkValue);
		return returnValue;
	}

	public String CheckNull(char checkValue){
		String returnValue="";
		if(String.valueOf(checkValue) != "null")
			returnValue = String.valueOf(checkValue);
		return returnValue;
	}

	public String CheckNull(Date checkValue, String pattern) {
		String returnValue="";
		if(checkValue != null) {
			SimpleDateFormat  formatDate = typeOfDateFormat(pattern);
			returnValue = formatDate.format(checkValue);
		}
		return returnValue;
	}

	public String CheckNull(java.sql.Date checkValue, String pattern) {
		String returnValue="";
		if(checkValue != null) {
			SimpleDateFormat  formatDate = typeOfDateFormat(pattern);
			returnValue = formatDate.format(checkValue);
		}
		return returnValue;
	}

	public String CheckNull(Timestamp checkValue, String pattern) {
		String returnValue="";
		if(checkValue != null) {
			SimpleDateFormat  formatDate = typeOfDateFormat(pattern);
			returnValue = formatDate.format(checkValue);
		}
		return returnValue;
	}
	public String CheckNull(double checkValue, int numberFraction, String prefix, boolean haveComma) {
		String returnValue="";
		if(String.valueOf(checkValue) != "null") {
		 	NumberFormat numberFormat = NumberFormat.getInstance();
			numberFormat.setGroupingUsed(haveComma);
			numberFormat.setMinimumFractionDigits(numberFraction);
			numberFormat.setMaximumFractionDigits(numberFraction);
			returnValue = prefix + numberFormat.format(checkValue);
		}
		return returnValue;
	}

	public String CheckNull(double checkValue, int minFraction, int maxFraction, String prefix, boolean haveComma) {
		String returnValue = "";
		if(String.valueOf(checkValue) != "null") {
		 	NumberFormat numberFormat = NumberFormat.getInstance();
			numberFormat.setGroupingUsed(haveComma);
			numberFormat.setMinimumFractionDigits(minFraction);
			numberFormat.setMaximumFractionDigits(maxFraction);
			returnValue = prefix + numberFormat.format(checkValue);
		}
		return returnValue;
	}

	public String CheckNull(float checkValue, int numberFraction, String prefix, boolean haveComma) {
		String returnValue="";
		if(String.valueOf(checkValue) != "null") {
			double passParam = Double.parseDouble(String.valueOf(checkValue));
			returnValue = CheckNull(passParam, numberFraction, prefix, haveComma);
		}
		return returnValue;
	}

	public String CheckNull(float checkValue, int minFraction, int maxFraction, String prefix, boolean haveComma) {
		String returnValue="";
		if(String.valueOf(checkValue) != "null") {
			double passParam = Double.parseDouble(String.valueOf(checkValue));
			returnValue = CheckNull(passParam, minFraction, maxFraction, prefix, haveComma);
		}
		return returnValue;
	}

	 private SimpleDateFormat typeOfDateFormat(String pattern) {
		pattern = pattern.equals("") ? "dd/MM/yyyy" : pattern;
		SimpleDateFormat  formatDate = new SimpleDateFormat(pattern, Locale.ENGLISH);
		return formatDate;
	}
	public String showMatchData(String realValue, String compareValue, String showValue) {
		String returnValue = "";
		String[] 	compareValues = StringUtil.token2Array(compareValue);
		String[] 	showValues = StringUtil.token2Array(showValue);

		for (int i=0; i<compareValues.length; i++) {
			if (compareValues[i].equals(realValue)) {
				returnValue = showValues[i];
				break;
			}
		}
		return returnValue;
	}


	public String ConvertDateFromEngToThai(Timestamp checkValue) {
		String returnValue="";
		if(checkValue != null) {
			String tempMonth =  (checkValue.getMonth()+1) < 10  ?  "0"+(checkValue.getMonth()+1)  : ""+(checkValue.getMonth()+1);			
			returnValue = checkValue.getDate()+"/"+tempMonth+"/"+(checkValue.getYear()+1900+543);
		}
		return returnValue;
	}
	
		public String ConvertDateFromEngToThai(Date checkValue) {
		String returnValue="";
		if(checkValue != null) {
			String tempMonth =  (checkValue.getMonth()+1) < 10  ?  "0"+(checkValue.getMonth()+1)  : ""+(checkValue.getMonth()+1);			
			returnValue = checkValue.getDate()+"/"+tempMonth+"/"+(checkValue.getYear()+1900+543);
		}
		return returnValue;
	}
	
	public String ConvertStringFromThaiToEng(String str) {
		String returnValue="";
		ConvertDataType convert = new ConvertDataType();
		Timestamp checkValue = convert.ConvertStringToTimestamp(str,"/");
		if(checkValue != null) {			
			String tempMonth =  (checkValue.getMonth()+1) < 10  ?  "0"+(checkValue.getMonth()+1)  : ""+(checkValue.getMonth()+1);			
			returnValue = checkValue.getDate()+"/"+tempMonth+"/"+(checkValue.getYear()+1900+543);
		}
		return returnValue;
	}	
}