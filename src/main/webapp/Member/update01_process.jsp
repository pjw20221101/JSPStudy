<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ include file="conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	
	String id = request.getParameter("id");
	String pa = request.getParameter("passwd");
	String na = request.getParameter("name");
	String em = request.getParameter("email");
	String ci = request.getParameter("city");
	String ph = request.getParameter("phone");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 수정된 내용을 DB에 저장하는 페이지</title>
</head>
<body>
[<a href="list01.jsp?go=<%= p %>">게시판 목록으로</a>]

<%

String sql = null;
Statement stmt = null;
ResultSet rs = null;

//DB에서 해당 id 에 대한 password를 가져와서 폼에서 전송됨 password와 확인
sql= "select * from mbtbl where idx ="+idx;
stmt = conn.createStatement();
rs = stmt.executeQuery(sql);


if(!(rs.next())){ 
	out.println("DB에 해당내용일 존재하지 않습니다");
}else{
	String DBid = rs.getString("id");
	String DBpa = rs.getString("pass");
	try{
		if(id.equals(DBid)){
			if(pa.equals(DBpa)){
				//update 진행
				sql = "update mbtbl set name = '"+na+"' ,";
				sql += "email = '"+em+"',city = '"+ci+"' ,phone = '"+ph+"' where idx ="+idx+"";
			
				stmt.executeUpdate(sql);
				out.println("<p/> 내용이 수정되엇습니다.");
			

			}else{
				//페스워드가 다릅니다 출력
				out.println("패스워드가 일치하지 않습니다.");
			}
		}else{
			out.println("아이디가 일치하지 않습니다.");
		}
	}catch(Exception e){
		out.println("DB저장시 오류가 발생되었습니다");
		e.printStackTrace();
	}finally{
		if(conn != null)conn.close();
		if(stmt != null)stmt.close();
		if(rs != null)rs.close();
	}
}
%>



</body>
</html>