<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import = "java.sql.*" %>

<!-- 
	java.sql* 패키지 해위의 모든 클래스를 import
		connection 객체 : DataBase(Oracle, MMSQL, MSSQL....)
		Statement 객체	 : CRUD를 해서 insert,UPdate, delete,
		PreparedStatement 객체 : Statement 객체의 업그래이드 버젼
		ResultSet 객체 : DB에서 select 한결과를 저장하는 객체

 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Oracle connection</title>
</head>
<body>
	<%
		//변수 초기화 //JSP 블락내에서 주석
		Connection conn = null;
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:XE";
		Boolean connect = false;
		try{
		Class.forName(driver); //오라클 드라이버를 로드함
		conn = DriverManager.getConnection(url, "C##HR", "1234");
		}catch (Exception e){
			e.printStackTrace();
			
		}
		
	%>
</body>
</html>