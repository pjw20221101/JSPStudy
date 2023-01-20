<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.*,java.sql.*,java.text.*" %>
<%@ include file="conn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>컬럼의 특정 레코드를 읽는 페이지 </title>
</head>
<body>

	
	<%
		
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		sql = "select * from mbtbl where idx = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,idx);
		rs = pstmt.executeQuery(); //select 문인 경우 executeQuery()
									//insert,update,delete문인경우 : executeupdate()
		
	if(rs.next()){
				
	%>
		<div>아이디 : <%=rs.getString("id") %></div>
		<div>이름 : <%=rs.getString("name") %></div>
		<div>이메일 : <%=rs.getString("email") %></div>
		<div>도시 : <%=rs.getString("city") %></div>
		<div>전화번호 : <%=rs.getString("phone") %></div>
	<%
		}else{
			out.println("해당 레코드는 존재하지 않습니다.");
		}
	%> 	  
		
   
		<A href="list02.jsp?go=<%= request.getParameter("page")%>">목록</a>
		<A href="rinsert02.jsp?idx=<%= request.getParameter("idx")%>&page=<%=request.getParameter("page") %>">답변</A>
		<A href="update02.jsp?idx=<%=idx %>&page=<%= request.getParameter("page")%>">수정</A>
		<A href="delete02.jsp?idx=<%=idx %>&page=<%= request.getParameter("page")%>">삭제</A>
	

</BODY>
</HTML>

