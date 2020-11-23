<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>게시판</title>
<link rel="icon" type="image/x-icon" href="${root }/assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"	rel="stylesheet" type="text/css" />
<link	href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic"	rel="stylesheet" type="text/css" />
<link	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${root }/css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Core theme JS-->
<script src="${root }/js/scripts.js"></script>
    <style>
        body { font-family: 굴림체; }
        table.table { width: 500px; }
        table td:nth-child(1) { background-color: #eee; }

        h1 {
            margin-top: 30px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <!-- 메뉴바 -->
	<jsp:include page="../title.jsp"/>
    <!-- ./ 메뉴바 -->
	<section class="page-section bg-light">
<div class="container">

    <h1>게시글 보기</h1>

    <form method="POST">
        <table class="table table-bordered table-condensed w-100">
        	<colgroup>
        		<col width="150px">
        		<col>
        	</colgroup>
            <tr>
                <td>게시글 번호</td>
                <td>${post.postNo}</td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td>
                    <textarea class="form-control" name="title" rows="1" readonly>${post.title}</textarea>
                </td>
            </tr>
            <tr>
                <td>글 내용</td>
                <td>
                    <textarea class="form-control" name="content" rows="10" readonly>${post.content}</textarea>
                </td>
            </tr>

            <tr>
                <td>작성자</td>
                <td>${post.username}</td>
            </tr>
            <tr>
                <td>작성시간</td>
                <td>${post.createDateTime}</td>
            </tr>
            <c:if test="${post.createDateTime ne post.updateTime }">
	            <tr>
	                <td>수정시간</td>
	                <td>${post.updateTime}</td>
	            </tr>
            </c:if>
        </table>
<!--         관리자 계정 삭제 가능 -->
		<c:choose>
			<c:when test="${post.userid eq userlogin.userid }">
		    	<a class="btn btn-primary" href="${root }/post/update?postNo=${post.postNo}&userid=${post.userid}">수정</a>
				<a href="${root }/post/delete?postNo=${post.postNo}" class="btn btn-warning">삭제</a>
			</c:when>
			<c:otherwise>
				<c:if test="${100 eq userlogin.role }">
					<a href="${root }/post/delete?postNo=${post.postNo}" class="btn btn-warning">삭제</a>
				</c:if>
			</c:otherwise>
		</c:choose>
        <a href="${root}/comment/list?postNo=${post.postNo}" class="btn btn-warning">댓글 보기</a>
<!--         <a href="javascript:window.history.back()" class="btn btn-info">목록으로</a> -->
		<a href="${root}/post/list" class="btn btn-info">목록으로</a>
    </form>

	<hr>
	<table class="table table-hover table table-striped w-100">
		<colgroup>
			<col width="100px">
			<col>
			<col width="165px">
			<col width="100px">
		</colgroup>
        <c:forEach items="${comments}" var="comment">
            <tr>
                <th>${comment.username}</th>
                <th>${comment.content}</th>
                <th style="font-size: 0.76em">작성: ${comment.createDateTime}<hr>수정: ${comment.updateTime}</th>
                <th>
<!--                 userlogin : 로그인정보, 댓글 작성자와 로그인 아이디가 같다면 수정, 삭제 가능 -->
                <c:choose>
	                <c:when test="${comment.userid eq userlogin.userid}">
		                <a href="${root }/comment/update?commentNo=${comment.commentNo}">수정</a> | 
		                <a href="${root }/post/deleteComment?commentNo=${comment.commentNo}">삭제</a>
	                </c:when>
	                <c:otherwise>
<!-- 	                관리자일 경우 삭제만 가능 -->
	                	<c:if test="${100 eq userlogin.role}">
	                		<a href="${root }/post/deleteComment?commentNo=${comment.commentNo}">삭제</a>
	                	</c:if>
	                </c:otherwise>
                </c:choose>
                </th>
            </tr>
        </c:forEach>
    </table>
    <hr>
    <h3>댓글 등록</h3>
    <form action="${root }/comment/write" method="POST">
                <input type="hidden" name="postNo" value="${post.postNo}">
        <table class="table table-bordered table-condensed w-100">
            <tr>
                <td class="mid" width="100">댓글</td>
                <td>
                	<c:choose>
                		<c:when test="${empty userlogin }">
                			<p>로그인이 필요합니다.</p>
                		</c:when>
	                	<c:otherwise>
	                    	<textarea class="form-control" name="content" rows="2"></textarea>
	                	</c:otherwise>
                	</c:choose>
                </td>
                <td width="100px">
        			<button type="submit" class="btn btn-primary" <c:if test="${empty userlogin}">disabled</c:if>>등록</button>
                </td>
            </tr>
        </table>
    </form>

</div>
</section>
	<jsp:include page="../copyright.jsp"/>
</body>
</html>