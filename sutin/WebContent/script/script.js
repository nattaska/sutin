
function dpFormat(prefix, anyvalue, decimalPoints, fixedLength) {
//alert("dpFormat("+prefix+","+anyvalue+","+decimalPoints+","+fixedLength+")");
  // initialise hashes and spaces
  spaces = "                              ";
  hashes = "##############################";
  
  // convert all numeric arguments to numbers
  anyNum=eval(anyvalue); 
  decimalPoints=eval(decimalPoints); 
  fixedLength=eval(fixedLength);
  //alert(decimalPoints);
  // make a rounded integer string with all the numeric characters required
  workNum = Math.abs(Math.round(anyNum*(Math.pow(10,decimalPoints))));
  workStr = "" + workNum;
  //alert("topzazaaz"+workStr);
  // if string too short, pad with leading zeros to infront of decimal point
  while(workStr.length <= decimalPoints){workStr = "0"+workStr;}
  
  // splice the decimal point into the string
  workStr = workStr.substr(0,workStr.length-decimalPoints) + "." + 
      workStr.substr(workStr.length-decimalPoints);
  
  //if the number is big enough, splice in the thousands comma
  //if (workStr.length > (decimalPoints + 4)) 
      //workStr=workStr.substr(0,workStr.length-(decimalPoints+4)) +
      //"," + workStr.substr(workStr.length-(decimalPoints+4));
  
  // if the number is big enough, splice in the millions comma
  //if (workStr.length > (decimalPoints + 8)) 
      //workStr=workStr.substr(0,workStr.length-(decimalPoints+8)) + 
      //"," + workStr.substr(workStr.length-(decimalPoints+8));
  
  // if the number is big enough, splice in the billions comma
  //if (workStr.length > (decimalPoints + 12)) 
      //workStr=workStr.substr(0,workStr.length-(decimalPoints+12)) +
      //"," + workStr.substr(workStr.length-(decimalPoints+12));
  
  // if the number was negative, put a minus sign on the front
  if (anyNum < 0) workStr = "-" + workStr;
  
  // check if floating prefix and fixed length string required
  if (fixedLength >= 0) {
  // floating prefix
    workStr = prefix + workStr;
  
  // if zero fixedLength, then return a variable length string
    if (fixedLength == 0) return workStr;
  
  // if too short, pad with leading spaces
    while (workStr.length < fixedLength){workStr = " " + workStr;}
  
  // if returned length too small for string, return a string of hashes
    if (workStr.length > fixedLength)
      return hashes.substr(0,fixedLength);
    else
      return workStr;
  }
  
  else {
  // non-floating prefix and fixed length string required
  
  // pad string to required length
    while (workStr.length < Math.abs(fixedLength)) {workStr=" "+workStr;}
  
  // if returned length too small for string, return a string of hashes
    if (workStr.length > Math.abs(fixedLength))
      return hashes.substr(0,Math.abs(fixedLength));
    else {
  // if prefix characters in string are not spaces, return hashes
      if (workStr.substr(0,prefix.length) != spaces.substr(0,prefix.length))
        return hashes.substr(0,Math.abs(fixedLength));
      else {
  // replace prefix spaces in string with the prefix
        workStr=prefix + workStr.substr(prefix.length);
        return workStr;
      }
    }
  }
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') { num = parseFloat(val);
        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
//  } if (errors) alert('The following error(s) occurred:\n'+errors);
  } if (errors) alert('???????????????????????????????');
  document.MM_returnValue = (errors == '');
}
//-->

function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
