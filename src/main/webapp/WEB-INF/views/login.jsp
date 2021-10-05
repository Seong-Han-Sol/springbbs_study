<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="/app/checkLogin" id="loginUser">
	로그인 아이디 : <input type="text" name="uId"><br>
	비밀번호 : <input type="password" name="uPw"><br>
	<input type="submit" value="로그인">
</form>
<input type="button" value="취소" id="btnCancel"><br>
<input type="button" value="회원가입" id="btnNew"><br>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnCancel', function(){
	document.location ="/app/list";
	return false;
})
.on('click','#btnNew', function(){
	document.location ="/app/singUp";
	return false;
})
</script>
</html>