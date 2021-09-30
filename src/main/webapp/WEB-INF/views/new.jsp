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
<form method="post" action="/app/save">
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
		<td>비밀번호</td>
		<td><input type="text" name=passcode></td>
	</tr>
	<tr>
		<td colspan="2"><input type="submit" value="등록"> 
		<input type="button" value="취소"></td>
	</tr>
</table>
</form>
</body>
</html>