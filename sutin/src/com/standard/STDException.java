package com.standard;

public class STDException extends Exception  {
  private String message = "";
  
  public STDException() {
  }
  
  public STDException(String message){
    this.message = message; 
  } 
  
  public String getError(){
    return (this.message!=null) ? this.message : "!! Error !!";
  }
}