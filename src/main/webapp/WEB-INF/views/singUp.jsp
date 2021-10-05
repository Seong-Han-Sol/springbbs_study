<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form method="post" action="/app/join" id="newJoin">
	이름(실명)<br>
	<input type="text" name="realName"><br>
	로그인 아이디<br>
	<input type="text" name="newId"><br>
	비밀번호<br>
	<input type="password" name="pw1"><br>
	비밀번호 확인<br>
	<input type="password" name="pw2"><br><br>
	<input type="submit" value="회원가입">
</form>
<input type="button" value="취소" id="btnCancel">
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('submit','#newJoin',function(){
	if($('input[name=realName]').val()==''){
		alert("이름을 입력하세요");
		return false;
	}
	if($('input[name=newId]').val()==''){
		alert("ID를 입력하세요");
		return false;
	}
	if($('input[name=pw1]').val()==''){
		alert("비밀번호를 입력하세요");
		return false;
	}
	if($('input[name=pw1]').val()!=$('input[name=pw2]').val()){
		alert("비밀번호가 일치하지 않습니다");
		return false;
	}
	return true;
})
.on('click','#btnCancel',function(){
	document.location = "/app/list";
})

</script>
</html>