<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
<form action="/app/update" method="post">
<input type="hidden" id="bbs_id" name="bbs_id" value="${post.bbs_id}">
<table>
	<tr>
		<td>제목</td>
		<td><input type=text name=title value="${post.title}"></td>
	</tr>
	<tr>
		<td colspan="2">내용</td>
	</tr>
	<tr>
		<td colspan="2"><textarea name=content rows="20" cols="60">${post.content}</textarea></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name=writer value="${post.writer}" readonly="readonly"></td>
	</tr>
	<tr>
		<td>비밀번호 확인</td>
		<td><input type="password" name="passcode2"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="수정등록"> 
		<input type="button" value="수정취소" id="updateCancel"></td>
	</tr>
</table>
<input type="password" name=passcode value="${post.passcode}">
</form>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#updateCancel',function(){
	document.location="/app/list";
	return false;
})
</script>
</html>