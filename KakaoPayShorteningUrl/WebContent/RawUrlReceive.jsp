<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.kakaopay.getshorturl.MakeShortURL"%>
<%@page import="com.kakaopay.db.DaoShortURL"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.apache.catalina.connector.Request"%>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
JSONObject jsonob = new JSONObject();

request.setCharacterEncoding("UTF-8");
String LoAddress = request.getParameter("Lo_raw_val"); // ��ȯ�� �ּҰ�
LoAddress = LoAddress.replace("http://",""); //http:// ����
LoAddress = LoAddress.replace("https://",""); // https://����
System.out.println(LoAddress);
DaoShortURL DaoSURL = new DaoShortURL();
DaoShortURL.createConnection();
  // RAW_URL �Է½�!!!
// DB ���ؼ�!!

String short_url = DaoSURL.selectUrlCheck(LoAddress);




	if(short_url != "" ) // RAW_URL �����  SHORT_URL
	{
		System.out.println("http://localhost/"+short_url); 
		jsonob.put("SUCCESS_YN", "Y");
		jsonob.put("short_url", "http://localhost/"+short_url);
		jsonob.put("Result", "��ȸ");
		out.println(jsonob);
	}else{  // RAW_URL ����X, SHORT_URL ����!!
	
	int seq = DaoSURL.selectSequence();
	
	
	MakeShortURL MSURL = new MakeShortURL();
	String Short_Url_Make = MSURL.GetURl(seq);
	DaoSURL.insertUrlMapping(seq,  LoAddress, Short_Url_Make);
	DaoSURL.selectUrlMapping();
	jsonob.put("SUCCESS_YN", "Y");
	jsonob.put("short_url", "http://localhost/"+Short_Url_Make);
	jsonob.put("Result", "����");
	out.println(jsonob);
	}



%>