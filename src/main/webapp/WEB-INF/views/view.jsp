<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="bbs_id" value="${post.bbs_id}">
<table>
<tr>
<td colspan="2">
<table id="tbContent">
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
</td>
</tr>
<tr>
<td><input type="button" id="btnUpdate" value="수정"></td>
<td><input type="button" id="btnDelete" value="삭제"></td>
</tr>
</table>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','#btnUpdate',function(){ //수정
	let bbs_id=$('#bbs_id').val();
	document.location="/app/update_view/"+bbs_id;
	return false;
})
.on('click','#btnDelete',function(){ //삭제
//	let bbs_id=$('#bbs_id').val();
//	console.log('bbs_id='+bbs_id);
//	document.location="/app/delete/"+bbs_id;
	//document.location = GET
	document.location='/app/delete/'+$('#bbs_id').val();
	return false;
})
</script>
</html>