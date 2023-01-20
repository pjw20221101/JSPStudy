<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="java.sql.*" %> 
<%@ include file="conn_oracle.jsp" %>
    
    <%
	String sql = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	int idx = Integer.parseInt(request.getParameter("idx"));
	String p = request.getParameter("page");
	/*
	out.println(id + "<p/>");
	out.println(p + "<p/>");
	*/
	try{
		
		sql="select * from mbtbl where idx =?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,idx);
		rs=pstmt.executeQuery();
		
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
<title>Update 를 통한 데이터 수정 </title>
<script language="javascript">
function check(){
	with(document.update02){
		if(passwd.value.length == 0){
			alert("암호를 입력해주세요");
			passwd.focus();
			return false;
		}
		if(name.value.length == 0){
			alert("이름을 입력해주세요");
			name.focus();
			return false;
		}
		if(email.value.length == 0){
			alert("이메일을 입력해주세요");
			email.focus();
			return false;
		}
		document.update02.submit();	
	}
}
</script>
</head>
<body>

	<form name="update02" method = "post" action = "update02_process.jsp"> 
		<input type="hidden" name = "idx" value="<%= idx %>">
		<input type="hidden" name = "page" value="<%= request.getParameter("page") %>">
		<p> 이름 : <input type = "text" name = "name" value="<%=rs.getString("name") %>"> </p>
		<p> 이메일 : <input type = "text" name = "email" value="<%=rs.getString("email") %>"></p>
		<p> 도시 : <input type = "text" name = "city" value="<%=rs.getString("city") %>"></p>
		<p> 전화번호 : <input type = "text" name = "phone" value="<%=rs.getString("phone") %>"></p>
		<p>==수정하기 위해선 아이디/패스워드를 입력해주세요===</p>
		<p> 아이디 : <input type = "text" name = "id"></p>
		<p> 패스워드 : <input type = "password" name = "passwd"></p>
		<p><a href="#" onclick="history.go(-1)">취소</a> <a href="#" onclick="check()"> 수정</a>
		<A href="list02.jsp?go=<%=request.getParameter("page")%>">목록</a>
		</p>
	
	</form>
<%
		} //if 문종료
		
}catch(Exception e){
	out.println("업데이트 실패");
	e.printStackTrace(); //잘작동될경우 주석처리할 디버깅코드
}finally{
	if(conn != null){conn.close();}
	if(pstmt != null){pstmt.close();}
	if(rs != null){rs.close();}
}

%>
</body>
</html>