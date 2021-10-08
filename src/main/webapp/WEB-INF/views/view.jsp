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
	<td>
		<c:if test="${loginCheck eq '0'}">
			<input type="button" value="로그인" id="btnLogin">
		</c:if>
		<c:if test="${loginCheck eq '1'}">
			<input type="button" value="로그아웃" id="btnLogout">
		</c:if>
	</td>
	</tr>
	<tr>
		<td>제목</td>
		<td>${post.title}</td>
	</tr>
	<tr>
		<td>내용</td>
	</tr>
	<tr>
		<td colspan="2">${post.content}
		<c:if test="${post.img_loc ne ''}">
			<br><img src="/app/resources/${post.img_loc}"
		</c:if>
		</td>
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
<!-- c:if 쓴 이유 = 게시글 작성가자 아닌 사람이 게시글을 클릭했을때 수정 삭제버튼 지우기 -->
<td><c:if test="${userId eq post.writer}"><input type="button" id="btnUpdate" value="수정"></c:if></td>
<td><c:if test="${userId eq post.writer}"><input type="button" id="btnDelete" value="삭제"></c:if></td>
<td><input type="button" id="btnList" value="목록보기"></td>
</tr>
<c:if test="${userId ne ''}">
	<c:if test="${userId ne null}">
	<tr id="curTR">
		<td>
			<table style="width: 100% ">
				<tr>
					<td>
						<textarea rows="2" cols="60" id="replyContent"></textarea></td>
					<td><input type="button" id="btnAddReply" style="background-color: gray;" value="댓글등록"></td>
				</tr>
			</table>
		</td>
	</tr>
	</c:if>
</c:if>
<c:forEach items="${replyList}" var="reply">
	<tr>
		<td>
		<input type="text" value="${reply.reply_id}">
		<table style="width: 100%">
			<tr><td>${reply.content}</td></tr>
			<tr><td>${reply.writer} [${reply.created}]</td></tr>
			<tr><td align="right">
				<c:if test="${userId eq reply.writer}">
					<input type="button" id="btnUpdateReply" value="수정" reply_id='${reply.reply_id}'>
					<input type="button" id="btnDeleteReply" value="삭제" reply_id='${reply.reply_id}'>
				</c:if>
			<tr><td><hr></td></tr>
		</table>
		</td>
	</tr>
</c:forEach>
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
.on('click','#btnList',function(){ //목록으로 돌아가기
	document.location='/app/list';
	return false;
})
.on('click','#btnAddReply',function(){ //댓글등록
	pstr=$('#replyContent').val();
	pstr=$.trim(pstr);
	if(pstr=='')return false;
	$.post("http://localhost:8080/app/addReply", {optype:'add',content:pstr,bbs_id:$('#bbs_id').val()}, function(result){
		console.log(result);
		if(result=="ok"){
			alert("댓글등록이 완료되었습니다")
			location.reload();
		}
	},'text')
	return false;
})
.on('click','#btnUpdateReply', function(){ //댓글 수정버튼 누르면 텍스트창이 열리고 수정완료/취소 버튼이 나온다
	let content=$(this).closest('table').find('tr:eq(0) td:eq(0)').text();
	let rId=$(this).attr('reply_id');
	$(this).closest('table').find('tr:lt(2)').hide();
	let str='<textarea rows=2 cols=60 id=reply_update>'+content+
	'</textarea><br>'+
	'<input type=button id=update value="수정완료" reply_id='+rId+'>' +
	'<input type=button id=cancel value="취소">';
	$(this).closest('td').html(str);
	return false;
})

.on('click','#cancel', function(){ //댓글수정취소
	document.location="/app/view/"+$('#bbs_id').val();
}) 
.on('click','#update', function(){//수정완료버튼(댓글)
	let updateText =$('#reply_update').val();
	updateText=$.trim(updateText);
	let reply_id =$(this).attr('reply_id');
	if(!confirm("수정하시겠습니까?")) return false;
	$.post('http://localhost:8080/app/updateReply',
			{optype:'update',content:updateText,reply_id:reply_id},function(result){
				if(result=="ok"){
					alert("댓글수정완료");
					document.location='/app/view/'+$('#bbs_id').val();
				}
	},'text')
	return false;
})
.on('click','#btnDeleteReply',function(){
	let reply_id =$(this).attr('reply_id');
	if(!confirm("삭제하시겠습니까?")) return false;
	$.post('http://localhost:8080/app/deleteReply', {optype:'delete',reply_id:reply_id}, function(result){
 		if(result=="ok"){
			alert("댓글삭제완료");
			document.location='/app/view/'+$('#bbs_id').val();
		}
	},'text')
})
</script>
</html>