<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file = "conn_oracle.jsp" %>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import = "java.sql.*,java.util.*" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DB의 내용을 가져와서 출력 하기 </title>

<SCRIPT language="javascript">
 function check(){
  with(document.search){
   if(sval.value.length == 0){
    alert("검색어를 입력해 주세요!!");
    sval.focus();
    return false;
   }	
   document.search.submit();
  }
 }
 /*
 function rimgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/arrow.gif";
  }

 function imgchg(p1,p2) {
  if (p2==1) 
   document.images[p1].src= "image/open.gif";
  else
   document.images[p1].src= "image/close.gif";
 }
 */
</SCRIPT>
</head>
<body>
<table width = "500" border="1"> 

	<tr> 
		<th> 아이디 </th>  
		<th> 이름 </th> 
		<th>email</th> 
		<th> city</th>
		<th>phone</th>  
	</tr>
	<%
		Vector id = new Vector();
		Vector pass = new Vector();
		Vector name = new Vector();
		Vector email = new Vector();
		Vector city = new Vector();
		Vector phone = new Vector();
		Vector keyid = new Vector();
		
		int where = 1;
		
		int totalgroup = 0;
		int maxpages = 2;
		int startpage = 1;	
		int endpage = startpage + maxpages -1;
		int wheregroup = 1;
		
		if(request.getParameter("go")!=null){ 
			where = Integer.parseInt(request.getParameter("go")); 
			wheregroup =(where -1) / maxpages + 1;
			startpage = (wheregroup -1 ) * maxpages + 1;
			endpage = startpage + maxpages -1;
			
		}else if(request.getParameter("gogroup")!=null){
			wheregroup = Integer.parseInt(request.getParameter("gogroup"));
			startpage = (wheregroup - 1) * maxpages +1;
			where = startpage;
			endpage = startpage + maxpages -1;
		}
		
		int nextgroup = wheregroup +1;
		int priorgroup = wheregroup -1;

		int nextpage = where +1;
		int priorpage = where -1;
		
		int startrow = 0;
		int endrow = 0;
		int maxrow = 1;
		int totalrows = 0;
		int totalpages = 0;
		
		
		
		
		int idx = 0;
		String em = null;
		
		String sql = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		sql = "select * from mbtbl order by ? desc";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1,idx);
		rs = pstmt.executeQuery();
		
		if(!(rs.next())){
			out.println("게시판에 올라온 글이 없습니다");
		}else{
			do{
				id.addElement(rs.getString("id"));
				name.addElement(rs.getString("name"));
				email.addElement(rs.getString("email"));
				pass.addElement(rs.getString("pass"));
				city.addElement(rs.getString("city"));
				phone.addElement(rs.getString("phone"));
				keyid.addElement(new Integer(rs.getString("idx")));
			
				}while(rs.next());
			}
		totalrows = name.size(); 		//DB에서 가져온 총 레코드 갯수 
		totalpages = (totalrows-1) / maxrow + 1; 	// 전체 페이지 갯수 출력 
		startrow = (where - 1) * maxrow ; 		//해당 페이지에서 Vector의 방번호 : 시작
		endrow = startrow + maxrow - 1 ; 		//해당 페이지에서 Vector의 방번호 : 마지막
		
		totalgroup = (totalpages -1) / maxpages + 1 ; 
			// 전체 페이지 그룹, 하단에 출력할 페이지 갯수(5개)의 그룹핑   
		
		
		//endrow 가 totalrows보다 크면 totalrows -1로 처리해야함.
		if ( endrow >= totalrows) {
			endrow = totalrows -1 ; 
		}
		if (endpage > totalpages){
			endpage = totalpages; 
		}
	
	
	for(int j = startrow; j <= endrow; j++ ){
	%>
	<tr> 
		<td><%=id.elementAt(j) %></td>  
		<td> <%=name.elementAt(j) %></td> 
		<td><a href="read02.jsp?idx=<%=keyid.elementAt(j) %>&page=<%= where %>"> <%=email.elementAt(j) %></a> </td> 
		<td> <%=city.elementAt(j) %> </td>
		<td> <%=phone.elementAt(j) %> </td>  
	</tr>
	<%
	}
	%>			
			
			
</table>
<%
	if(wheregroup > 1){ 
 		out.println("[<a href='list02.jsp?gogroup=1'>처음</a>]");
 		out.println("[<a href='list02.jsp?gogroup="+priorgroup+"'>이전</a>]");
 	}else{	
 		out.println("[처음]");
 		out.println("[이전]");
 	}
	if(name.size()!=0){ 
		 
		 for(int jj = startpage; jj <= endpage; jj++){
			 if(jj == where){ 
			 	out.println("["+jj+"]");
			 }else{ 
				 out.println("[<a href='list02.jsp?go="+jj+"'>"+jj+"</a>]");
		 	}
	 	}
 	} 
	if(wheregroup < totalgroup){ 
		out.println("[<a href='list02.jsp?gogroup="+nextgroup+"'>다음</a>]");
		out.println("[<a href='list02.jsp?gogroup="+totalgroup+"'>마지막</a>]");
	}else{ 
		out.println("[다음]");
		out.println("[마지막]");
	}
	out.println("전체 글수 : "+totalrows); 
 %>
 
 <FORM method="post" name="search" action="search02.jsp">
<TABLE border=0 width=600 cellpadding=0 cellspacing=0>
 <TR>
  <TD align=right width="241"> 
   <SELECT name=stype >
    <OPTION value=1 >아이디</OPTION>
    <OPTION value=2 >이름</OPTION>
    <OPTION value=3 >이메일</OPTION>
    <OPTION value=4 >아이디+이름</OPTION>
    <OPTION value=5 >아이디+이메일</OPTION>
    <OPTION value=6 >이름+이메일</OPTION>
    <OPTION value=7 >아이디+이름+이메일</OPTION>
   </SELECT>
  </TD>
  <TD width="127" align="center">
   <INPUT type=text size="17" name="sval" >
  </TD>
  <TD>&nbsp;<a href="#" onClick="check();"></A></TD>
  <TD><A href="Insert02.jsp">글쓰기</A></TD>
 </TR>
</TABLE>
</FORM>
 
</body>
</html>