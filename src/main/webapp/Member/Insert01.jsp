<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script language="javascript">
function check(){
	with(document.insert01){
		if(id.value.length == 0){
			alert("아이디를 입력해주세요");
			id.focus();
			return false;
		}
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
		document.insert01.submit();	
	}
}
</script>
</head>
<body>
	<form name="insert01" method = "post" action = "insert01_process.jsp"> 
		<p> 아이디 : <input type = "text" name = "id"> </p>
		<p> 패스워드 : <input type = "password" name = "passwd"> </p>
		<p> 이름 : <input type = "text" name = "name"> </p>
		<p> 이메일 : <input type = "text" name = "email"></p>
		<p> 도시 : <input type = "text" name = "city"></p>
		<p> 전화번호 : <input type = "text" name = "phone"></p>
		<p> <a href="#" onclick="history.go(-1)">취소</a> <a href="#" onclick="check()"> 전송</a> </p>
	
	</form>

</body>
</html>

