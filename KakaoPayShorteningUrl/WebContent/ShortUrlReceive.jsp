<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kakaopay.db.DaoShortURL"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%


JSONObject jsonob = new JSONObject();


request.setCharacterEncoding("EUC-KR");
String ShortUrlAddress = request.getParameter("short_url_val"); // ��ȯ�� �ּҰ�
ShortUrlAddress = ShortUrlAddress.replace("http://",""); //http:// ����
ShortUrlAddress = ShortUrlAddress.replace("https://",""); // https://����


System.out.println(ShortUrlAddress);
DaoShortURL DaoSURL = new DaoShortURL();
DaoShortURL.createConnection();
String Raw_URL="";

if( ShortUrlAddress.substring(0, 10).equals("localhost/") ){ // short_url �Է½�!!
	
	Raw_URL = DaoSURL.selectShortUrlCheck(ShortUrlAddress.substring(10));

	if(Raw_URL != "") 
	{

		
		Raw_URL = "http://"+Raw_URL;
		jsonob.put("SUCCESS_YN", "Y");
		jsonob.put("Raw_URL", Raw_URL);
		jsonob.put("Result", "����� �̵�!");
		
		//response.sendRedirect("http://"+Raw_URL); // ��� �ּҷ� redirect!!
		out.println(jsonob);
	}
	else{
		Raw_URL ="��ȿ���� ���� SHORT_URL �Դϴ�!!";
		jsonob.put("SUCCESS_YN", "N");
		jsonob.put("Raw_URL", Raw_URL);
		System.out.println("��ȿ���� ���� SHORT_URL �Դϴ�!!");	
		out.println(jsonob);
	}


}
System.out.println("=====================================================");	

%>