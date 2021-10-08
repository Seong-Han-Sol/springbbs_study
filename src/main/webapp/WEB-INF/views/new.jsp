<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>
<form method="post" action="/app/save" id="frmNew" enctype="multipart/form-data">
<table>
	<tr>
		<td>제목</td>
		<td><input type=text name=title></td>
	</tr>
	<tr>
		<td colspan="2">내용</td>
	</tr>
	<tr>
		<td colspan="2"><textarea name=content rows="20" cols="60"></textarea></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><input type="text" name=writer></td>
	</tr>
	<tr>
	<td>업로드 화일</td>
	<td><input type="file" name="ufile" id="ufile"></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="등록"> 
		<input type="button" value="취소" id="btnCancel"></td>
	</tr>
</table>
</form>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnCancel',function(){
	//document.location="/app/list";
	$(location).attr('href','list');
	return false;
})
</script>
</html>