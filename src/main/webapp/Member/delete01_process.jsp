<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ include file="conn_oracle.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글을 삭제를 처리하는 페이지</title>
</head>
<body>

[<a href="list01.jsp?go=<%= request.getParameter("page") %>"> 
게시판으로이동 </a>]


<%
//db 접속하는 객체 선언
String sql =null;
Statement stmt = null;
ResultSet rs = null;

int idx = Integer.parseInt(request.getParameter("idx"));
int page1 = Integer.parseInt(request.getParameter("page"));
String id = request.getParameter("id");
String pa = request.getParameter("passwd");

/*
out.println(id + "<p/>");
out.println(page1 + "<p/>");
out.println(pw + "<p/>");

if(true) return;
*/

	try{	//DB에 쿼리를 보내는 블락 : DB에 오류가 발생시 프로그햄이 종료되지 않도록 처리
		
		sql = "select * from mbtbl where idx="+idx; //실무에서는 *사용은 자제
		stmt =conn.createStatement();
		rs = stmt.executeQuery(sql);
		
		if(!(rs.next())){//rs의 값이 비어있을때
			out.println("해당값이 존재하지 않습니다.");
		}else{ //rs의 값이 존재할때
			//rs 의 password 컬럼의 값을 가져와서
				//pwd : DB엣 ㅓ가져온 password
				//pw : 사용자가 폼에서 넘긴 password
			String DBpa = rs.getString("pass");
			String DBid = rs.getString("id");
			
			if(id.equals(DBid)){
				if(pa.equals(DBpa)){ //DB의 password와 폼의 password가 같을때
					//delete 쿼리를 적용
					sql = "delete mbtbl where idx ="+idx;
					stmt = conn.createStatement();
					stmt.executeUpdate(sql);
				
					//db에서 위쿼리가 성공적으로 작동되면 아래 코드가 실행
					out.println("삭제 완료되었습니다.");
				
				}else{ //다를때
					out.println("패스워드가 다릅니다.");
				}
			}else{
				out.println("아이디가 다릅니다");
			}
			
		}
		
	}catch(Exception e){
		out.println("DB오류로 인한 삭제 실패했습니다.");
		e.printStackTrace();//디버깅
		
	}finally{
		if(conn != null){conn.close();}
		if(stmt != null){stmt.close();}
		if(rs != null){rs.close();}
	}


%>


</body>
</html>