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
<!-- Contact form JS-->
<!-- <script src="assets/mail/jqBootstrapValidation.js"></script> -->
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
            <tr>
                <td>게시글 번호</td>
                <td>${posts.getPostNo()}</td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td>
                    <textarea class="form-control" name="title" rows="1" readonly>${posts.getTitle()}</textarea>
                </td>
            </tr>
            <tr>
                <td>글 내용</td>
                <td>
                    <textarea class="form-control" name="content" rows="10" readonly>${posts.getContent()}</textarea>
                </td>
            </tr>

            <tr>
                <td>작성자</td>
                <td>${posts.getUsername()}</td>
            </tr>
            <tr>
                <td>작성시간</td>
                <td>${posts.getCreateDateTime()}</td>
            </tr>
        </table>

        <a href="${root }/comment/list?postId=${posts.getPostNo()}" class="btn btn-warning">댓글</a>
        <a href="javascript:window.history.back()" class="btn btn-info">뒤로가기</a>
        <a href="${root }/post/list" class="btn btn-info">처음으로</a>
    </form>
	<hr>
	<table class="table table-hover table table-striped w-100">
		<colgroup>
			<col width="15%">
			<col width="35%">
			<col width="20%">
			<col width="20%">
			<col width="10%">
		</colgroup>
        <c:forEach items="${list}" var="comment">
            <tr>
                <th>${comment.getUsername()}</th>
                <th>${comment.getContent()}</th>
                <th style="font-size: 0.76em">작성: ${comment.getCreateDateTime()}<hr>수정: ${comment.getUpdateTime()}</th>
                <th>
                <c:if test="${userlogin.getUserid() == comment.getUserid() }">
                <a href="${root }/comment/update?commentId=${comment.getCommentNo()}">수정</a> | 
                <a href="${root }/comment/delete?commentId=${comment.getCommentNo()}">삭제</a>
                </c:if>
                </th>
            </tr>
        </c:forEach>
    </table>
    <hr>

    <h1>댓글 등록</h1>
    <form action="${root }/comment/view" method="POST">
        <table class="table table-bordered table-condensed w-100">
            <tr>
                <td class="mid" width="100">댓글</td>
                <td>
                    <textarea class="form-control" name="content" rows="2"></textarea>
                </td>
                <td width="100px"><textarea class="form-control" name="postId" rows="2" readonly>${posts.getPostNo()}</textarea></td>
            </tr>
        </table>
        <button type="submit" class="btn btn-primary">등록</button>
    </form>

</div>
</section>

	<jsp:include page="../copyright.jsp"/>
</body>
</html>