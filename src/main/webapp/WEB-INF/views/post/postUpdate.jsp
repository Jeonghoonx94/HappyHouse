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
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
        }
    </style>
</head>
<body>

    <!-- 메뉴바 -->
	<jsp:include page="../title.jsp"/>
    <!-- ./ 메뉴바 -->
	<section class="page-section bg-light" id="team">
<div class="container">

    <h1>게시글 수정</h1>

    <form action="${root }/post/update?postNo=${post.postNo}" method="POST">
        <table class="table table-bordered table-condensed">
            <tr>
                <td>게시글 번호</td>
                <td>${post.postNo}</td>
            </tr>
            <tr>
                <td>글 제목</td>
                <td>
                    <textarea class="form-control" name="title" rows="1">${post.title}</textarea>
                </td>
            </tr>
            <tr>
                <td>글 내용</td>
                <td>
                    <textarea class="form-control" name="content" rows="10">${post.content}</textarea>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td>${post.username}</td>
            </tr>
        </table>

        <button type="submit" class="btn btn-primary">저장</button>
        <a href="${root }/comment/list?postNo=${post.postNo}" class="btn btn-warning">댓글</a>
        <a href="${root }/post/delete?postNo=${post.postNo}" class="btn btn-warning" onclick="confirm('삭제하시겠습니까?')">삭제</a>
        <a href="javascript:window.history.back()" class="btn btn-info">뒤로가기</a>
        <a href="${root }/post/list" class="btn btn-info">처음으로</a>
    </form>
</div>
</section>
	<jsp:include page="../copyright.jsp"/>
</body>
</html>