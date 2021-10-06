<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 목록</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

<style>
.table1 {
	border-collapse: collapse;
}
.table1 td {
	border: 1px solid;
}
.table1 th {
	color : white;
	background-color: black;
	border: 1px solid yellow;
}
</style>
</head>
<body>
<div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h3 class="card-title">게시글 목록</h3>

                <div class="card-tools">
                  <div class="input-group input-group-sm" style="width: 150px;">
                    <input type="text" name="table_search" class="form-control float-right" placeholder="Search">

                    <div class="input-group-append">
                      <button type="submit" class="btn btn-default"><i class="fas fa-search"></i></button>
                    </div>
                  </div>
                </div>
              </div>
              <!-- /.card-header -->
              <div class="tableBoby">
              <table align="center" valign="top">
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
                <table class="table1"  width="85%">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>작성자</th>
                      <th>제목</th>
                      <th>내용</th>
                      <th>작성일자</th>
                      <th>수정일자</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<c:forEach items="${BBSList}" var="rec">
                  		<tr>
                  		<td><c:out value="${rec.bbs_id}"/></td> <!--xml테이블 스키마명과 똑같은 이름으로 변수 적어줌 -->
                  		<td><c:out value="${rec.writer}"/></td>
                  		<td><c:out value="${rec.title}"/></td>
                  		<td width="25%"><c:out value="${rec.content}"/></td>
                  		<td><c:out value="${rec.created}"/></td>
                  		<td><c:out value="${rec.updated}"/></td>
                  		</tr>
                  	</c:forEach>
                  </tbody>
                </table>
                		<tr>
	                		<td>
	                			<c:if test="${loginCheck eq '1'}">
	                				<input type="button" value="글쓰기" id="btnNew">
	                			</c:if>
	                		</td>
                		</tr>
                </table>
              </div>
              <!-- /.card-body -->
            </div>
            <!-- /.card -->
          </div>
        </div>
</body>
<script src="https://code.jquery.com/jquery-3.5.0.js"></script>
<script>
$(document)
.on('click','.table1 tr',function(){
	let bbs_id=$(this).find('td:eq(0)').text();
	//console.log('bbs_id['+bbs_id+']');
	document.location="/app/view/"+bbs_id;
	return false;
})
.on('click','#btnNew',function(){
	document.location="/app/new";
	return false;
})
.on('click','#btnLogin',function(){
	document.location="/app/login";
	return false;
})
.on('click','#btnLogout',function(){
	document.location = "/app/logout";
	return false;
})
</script>
</html>