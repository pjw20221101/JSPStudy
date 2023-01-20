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
	PreparedStatement pstmt = null;
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
	
	
	
	sql = "insert into mbtbl (idx,id,pass,name,email,city,phone) ";
	sql +="values(?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setInt(1, idx);
	pstmt.setString(2, id);
	pstmt.setString(3, pa);
	pstmt.setString(4, na);
	pstmt.setString(5, em);
	pstmt.setString(6, ci);
	pstmt.setString(7, ph);
	pstmt.executeUpdate();
	
	
	
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
		 if(pstmt != null){
			 pstmt.close();
		 }
		 if(rs != null){
			 rs.close();
		 }
	 }
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
[<a href="list02.jsp?go=1">게시판 목록으로</a>]
</body>
</html>