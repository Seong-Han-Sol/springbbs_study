<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
		<td colspan="2">${post.content}</textarea></td>
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
<!-- c:if 쓴 이유 = 게시글 작성가자 아닌 사람이 게시글을 클릭했을쌔 수정 삭제버튼 지우기 -->
<td><c:if test="${userId eq post.writer}"><input type="button" id="btnUpdate" value="수정"></c:if></td>
<td><c:if test="${userId eq post.writer}"><input type="button" id="btnDelete" value="삭제"></c:if></td>
<td><input type="button" id="btnList" value="목록보기"></td>
</tr>
<c:if test="${userId ne ''}">
	<tr id="curTR">
		<td>
			<table style="width: 100% ">
				<tr>
					<td>
						<textarea rows="5" cols="60" id="reply_content"></textarea></td>
					<td><input type="button" id="btnAddReply" style="background-color: gray;" value="댓글등록"></td>
				</tr>
			</table>
		</td>
	</tr>
</c:if>
</table>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>

//javascript object
/*
 * public class Board {
	
	private Long no;
	private String title;
	private String contents;
}

let numbers = []
const board = {}
const board = {no:1, title:"첫 게시글입니다.", contents:"내용입니다."}

 */

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
.on('click','#btnList',function(){ //목록으로 돌아가기
	document.location='/app/list';
	return false;
})
.on('click','#btnAddReply',function(){
	pstr=$('#reply_content').val();
	pstr=$.trim(pstr);
	if(pstr=='')return false;
	// $.post(URI, Object, callback)
	// 나는 URI에 POST 방식으로 요청할거야.
	// 근데 너한테 요청할 때 객체를 넘겨줄게
	// 그 결과를 callback 함수에다가 줘
	const url = "http://localhost:8080/app/ReplyControl";
	const reply = {optype:'add',content:pstr,bbs_id:$('#bbs_id').val()};
	$.post(url, reply, function(result){
		alert("댓글 등록이 완료됐습니다");
	},'text')
})
</script>
</html>