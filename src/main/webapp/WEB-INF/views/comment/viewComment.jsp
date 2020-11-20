<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>게시판</title>
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"	rel="stylesheet" type="text/css" />
<link	href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic"	rel="stylesheet" type="text/css" />
<link	href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700"	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Contact form JS-->
<!-- <script src="assets/mail/jqBootstrapValidation.js"></script> -->
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
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
<body id="page-top">
<jsp:include page="title.jsp"/>

<div class="container">

    <a href="${root }/comment/list?postId=${postId}"><h1>댓글 목록 </h1></a>
    <table class="table table-hover table table-striped">
        <tr>
            <th>댓글번호</th>
            <th>작성자</th>
            <th>내용</th>
            <th>작성시간</th>
            <th>수정시간</th>
            <th>삭제</th>
        </tr>

        <c:forEach items="${list}" var="comment">
            <tr>
                <th>${comment.getCommentId()}</th>
                <th>${comment.getNickname()}</th>
                <th><a href="http://localhost:8080/comment/update?commentId=${comment.getCommentId()}">${comment.getContent()}</a></th>
                <th>${comment.getCreateDateTime()}</th>
                <th>${comment.getUpdateTime()}</th>
                <th><a href="http://localhost:8080/comment/delete?commentId=${comment.getCommentId()}">삭제</a></th>
            </tr>
        </c:forEach>
    </table>
    <a href="http://localhost:8080/post/view?postId=${postId}" class="btn btn-info">게시글로 가기</a>
</div>

<jsp:include page="copyright.jsp"/>
</body>
</html>