<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*,java.util.*,java.text.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file = "conn_oracle.jsp" %>

<%
	String id = request.getParameter("id");
	String pa = request.getParameter("passwd");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String ph = request.getParameter("phone");
	
	int idx = 1;

	String sql = null; 
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
	stmt = conn.createStatement();
	sql = "select max(idx) from mbtbl";
	rs = stmt.executeQuery(sql);
	
	if(!(rs.next())){
		idx = 1;
	}else{
		idx = rs.getInt(1)+1;
	}
	
	sql = "insert into mbtbl (idx,id,pass,name,email,city,phone)";
	sql +="values("+idx+",'"+id+"','"+pa+"','"+na+"','"+em+"','"+ci+"','"+ph+"')";

	stmt.executeQuery(sql); 
	
	
	}catch(SQLIntegrityConstraintViolationException j){
		out.println("아이디 중복");
		 j.printStackTrace();
	}catch(Exception e){
		out.println("DB저장중 오류발생");
		 e.printStackTrace();
	}finally{
		 if(conn != null){
			 conn.close();
		 }
		 if(stmt != null){
			 stmt.close();
		 }
		 if(rs != null){
			 rs.close();
		 }
	 }
%>

<jsp:forward page ="list01.jsp"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>