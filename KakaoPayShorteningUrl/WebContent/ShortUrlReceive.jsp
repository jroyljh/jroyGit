<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kakaopay.db.DaoShortURL"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%


JSONObject jsonob = new JSONObject();


request.setCharacterEncoding("EUC-KR");
String ShortUrlAddress = request.getParameter("short_url_val"); // 변환된 주소값
ShortUrlAddress = ShortUrlAddress.replace("http://",""); //http:// 제거
ShortUrlAddress = ShortUrlAddress.replace("https://",""); // https://제거


System.out.println(ShortUrlAddress);
DaoShortURL DaoSURL = new DaoShortURL();
DaoShortURL.createConnection();
String Raw_URL="";

if( ShortUrlAddress.substring(0, 10).equals("localhost/") ){ // short_url 입력시!!
	
	Raw_URL = DaoSURL.selectShortUrlCheck(ShortUrlAddress.substring(10));

	if(Raw_URL != "") 
	{

		
		Raw_URL = "http://"+Raw_URL;
		jsonob.put("SUCCESS_YN", "Y");
		jsonob.put("Raw_URL", Raw_URL);
		jsonob.put("Result", "잠시후 이동!");
		
		//response.sendRedirect("http://"+Raw_URL); // 결과 주소로 redirect!!
		out.println(jsonob);
	}
	else{
		Raw_URL ="유효하지 않은 SHORT_URL 입니다!!";
		jsonob.put("SUCCESS_YN", "N");
		jsonob.put("Raw_URL", Raw_URL);
		System.out.println("유효하지 않은 SHORT_URL 입니다!!");	
		out.println(jsonob);
	}


}
System.out.println("=====================================================");	

%>