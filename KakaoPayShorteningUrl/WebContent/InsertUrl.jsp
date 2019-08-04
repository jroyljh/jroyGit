<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<link href="insert.css" rel="stylesheet" type="text/css">
<title>KAKAOPAY Shortening Service</title>
</head>
<body>
<script language="JavaScript">
function validateForm(){
	$("#ajaxReturn").html("");
	$("#ajaxConfirm").html("");
	
    var sform = document.forms["raw_form"];
    var rawurl = raw_form.raw_val.value; 
    if(!sform.raw_val.value){  // 예외처리 
        alert('URL을 입력하세요!!');
        sform.raw_val.focus();
        return false;
    }
   
    
       
    if(!checkUrlForm(rawurl.toLowerCase())) // 예외처리 http확인!!
    {	raw_form.raw_val.value="http://"+rawurl;
    	alert("URL 주소를 확인하시고, http://를 붙여주세요!")
    	return;
    }
    
    
    if(rawurl.toLowerCase().match(/localhost\//)){  //short url 처리
    	short_url_form.short_url_val.value = rawurl;
    	 $.ajax({
    		    url: "ShortUrlReceive.jsp",
    		    type: "POST",
    		    cache: false,
    		    dataType: "json",
    		    data: {'short_url_val':rawurl}, 
    		    success: function(data){
    		    	$("#ajaxReturn").html(data.Raw_URL);
    		    	$("#ajaxConfirm").html(data.Result);
    		    	
    		    	
    		        console.log(data);
    		        if(data.SUCCESS_YN == 'Y')
    		        	document.location=data.Raw_URL;
    		        
    		      //if(confirm("이동하시겠습니까?"))
    		     	//document.location=data;
    		      	
    		    },
    		    error: function (request, status, error){        
    		        var msg = "ERROR : " + request.status + "<br>"
    		      msg +=  + "내용 : " + request.responseText + "<br>" + error;
    		      console.log(msg);              
    		    }
    		  });	
    }
    else{ // raw url 처리

        rawurl = raw_form.raw_val.value.toLowerCase(); // 받은주소 소문자로
        raw_form.Lo_raw_val.value = rawurl;
        $.ajax({
		    url: "RawUrlReceive.jsp",
		    type: "POST",
		    cache: false,
		    dataType: "json",
		    data: {'Lo_raw_val':rawurl}, 
		    success: function(data){
		    	$("#ajaxReturn").html(data.short_url);
		    	$("#ajaxConfirm").html(data.Result);
		        console.log(data);
		       
		        
		      //if(confirm("이동하시겠습니까?"))
		     	//document.location=data;
		      	
		    },
		    error: function (request, status, error){        
		        var msg = "ERROR : " + request.status + "<br>"
		      msg +=  + "내용 : " + request.responseText + "<br>" + error;
		      console.log(msg);              
		    }
		  });	
        
        //sform.submit();
    	
    }

    
}


//url 형식인지를 체크( http, https 를 포함하는 형식 )
function checkUrlForm(strUrl) {
    var expUrl = /^http[s]?\:\/\//i;
    return expUrl.test(strUrl);
}


</script>





<form name=raw_form method="POST" action= "RawUrlReceive.jsp">
 <div class="box">
  <div class="container-1">
      <span class="icon"><i class="fa fa-search"></i></span>
      <input type="search" id="text" placeholder="Search..." name="raw_val" value="" onkeypress="if(event.keyCode==13) {validateForm(); return false;}" >
      <input type=button value="전송" class="btn" onClick=validateForm() onkeypress="" >
  </div>

</div>

<input type="hidden" name="Lo_raw_val" value="">
</form>

<form name=short_url_form method="POST" action= "ShortUrlReceive.jsp">
<div id="ajaxReturn" style = "color:white;"></div>
<div id="ajaxConfirm" style = "color:yellow;"></div>
<input type="hidden" name="short_url_val" value="">
</form>

</body>
</html>
