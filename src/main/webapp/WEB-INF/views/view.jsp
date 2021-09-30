<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="text" id="bbs_id" value="${post.bbs_id}">
<table>
	<tr>
		<td>제목</td>
		<td>${post.title}</td>
	</tr>
	<tr>
		<td>내용</td>
	</tr>
	<tr>
		<td>${post.content}</textarea></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td>${post.writer}</td>
	</tr>
	<tr>
		<td>작성일자</td>
		<td>${post.created}</td>
	</tr>
	<tr>
		<td>수정일자</td>
		<td>${post.updated}</td>
	</tr>
</table>
</body>
</html>