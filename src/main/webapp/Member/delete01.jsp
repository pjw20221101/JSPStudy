<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>
    
<%
	String sql = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	/*
	out.println(id + "<p/>");
	out.println(p + "<p/>");
	*/
	try{
		
		sql="select * from mbtbl where idx ="+idx;
		stmt = conn.createStatement();
		rs=stmt.executeQuery(sql);
		
		//rs의 값이 잘 가져왔을때
		
		if(!(rs.next())){
			//값이 없을때
			out.println("해당내용이 DB에 존재하지 않습니다.");
		}else{
			//값이 있을때
%>
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<SCRIPT language = "javascript"> 
	function check () {
		with(document.delete01){
			if ( id.value.length==0){
				alert ("아이디를 입력해 주세요!!"); 
				id.focus();
				return false; 
			}
			if ( passwd.value.length==0){
				alert ("패스워드를 입력해 주세요!!"); 
				passwd.focus();
				return false; 
			}
			document.delete01.submit(); 	
		}	
	}
</SCRIPT>
</head>
<body>
	<form name="delete01" method = "post" action = "delete01_process.jsp"> 
		<input type="hidden" name = "idx" value="<%= idx %>">
		<input type="hidden" name = "page" value="<%= request.getParameter("page") %>">
		<p> 아이디 : <input type = "text" name = "id"></p>
		<p> 패스워드 : <input type = "password" name = "passwd"> </p> 
		<p><a href="#" onclick="history.go(-1)">취소</a> <a href="#" onclick="check()">삭제</a>
			<A href="list01.jsp?go=<%=request.getParameter("page")%>">목록</a>
		</p>
	</form>
	<%
} //if 문종료
		
}catch(Exception e){
	out.println("업데이트 실패");
	e.printStackTrace(); //잘작동될경우 주석처리할 디버깅코드
}finally{
	if(conn != null){conn.close();}
	if(stmt != null){stmt.close();}
	if(rs != null){rs.close();}
}

%>
</body>
</html>

