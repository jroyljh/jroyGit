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
    if(!sform.raw_val.value){  // ����ó�� 
        alert('URL�� �Է��ϼ���!!');
        sform.raw_val.focus();
        return false;
    }
   
    
       
    if(!checkUrlForm(rawurl.toLowerCase())) // ����ó�� httpȮ��!!
    {	raw_form.raw_val.value="http://"+rawurl;
    	alert("URL �ּҸ� Ȯ���Ͻð�, http://�� �ٿ��ּ���!")
    	return;
    }
    
    
    if(rawurl.toLowerCase().match(/localhost\//)){  //short url ó��
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
    		        
    		      //if(confirm("�̵��Ͻðڽ��ϱ�?"))
    		     	//document.location=data;
    		      	
    		    },
    		    error: function (request, status, error){        
    		        var msg = "ERROR : " + request.status + "<br>"
    		      msg +=  + "���� : " + request.responseText + "<br>" + error;
    		      console.log(msg);              
    		    }
    		  });	
    }
    else{ // raw url ó��

        rawurl = raw_form.raw_val.value.toLowerCase(); // �����ּ� �ҹ��ڷ�
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
		       
		        
		      //if(confirm("�̵��Ͻðڽ��ϱ�?"))
		     	//document.location=data;
		      	
		    },
		    error: function (request, status, error){        
		        var msg = "ERROR : " + request.status + "<br>"
		      msg +=  + "���� : " + request.responseText + "<br>" + error;
		      console.log(msg);              
		    }
		  });	
        
        //sform.submit();
    	
    }

    
}


//url ���������� üũ( http, https �� �����ϴ� ���� )
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
      <input type=button value="����" class="btn" onClick=validateForm() onkeypress="" >
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
