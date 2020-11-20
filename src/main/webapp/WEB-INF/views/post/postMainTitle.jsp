<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
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
</head>
<style>
    #margin{
        margin-bottom : 20px
    }

    .navbar.sticky-top.navbar-expand-lg.navbar-light {
        margin : 0px;
        background-color: white;
    }
</style>
<body>


<div class="container">

    <nav class="navbar sticky-top navbar-expand-lg navbar-light">
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost:8080/post/list">Home</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="http://localhost:8080/logout">Logout</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="http://localhost:8080/notice">공지사항</a>
                </li>

                <li class="nav-item dropdown active">
                    <a class="nav-link dropdown-toggle" href="http://localhost:8080/member/update" id="navbarDropdown" role="button"
                       data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        회원정보수정
                    </a>
                </li>

            </ul>


        </div>
    </nav>

    <form method="post" class="form-inline">
        <div id="margin" class="form-group">
            <select name="select" class="form-control">
                <option value="title" selected>제목</option>
                <option value="nickname">작성자</option>
            </select>
            <input type="text" size=20 class="form-control" name="search"  placeholder="검색" >
            <button type="submit" class="btn btn-primary">조회</button>
        </div>
    </form>

    <table class="table table-hover table table-striped">
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th>조회수</th>
            <th>수정시간</th>
            <th>작성시간</th>
        </tr>

        <c:forEach items="${posts}" var="post">
            <tr>
                <th>${post.getPostId()}</th>
                <th>${post.getNickName()}</th>
                <th>
                    <a href="http://localhost:8080/post/view?postId=${post.getPostId()}">${post.getTitle()}</a>
                </th>
                <th>${post.getCount()}</th>
                <th>${post.getUpdateTime()}</th>
                <th>${post.getCreateDateTime()}</th>
            </tr>
        </c:forEach>
    </table>

    <a href="http://localhost:8080/post/write" class="btn btn-default pull-right">글쓰기</a>

    <ul class="pagination">
        <c:forEach var="i" begin="1" end="${totalPage}" step="1">
            <li class=<c:if test='${i} == ${page} ? "active" : ""'/>>
                <a href='/post/list?page=${i}&pageSize=${pageSize}'>${i}</a>
            </li>
        </c:forEach>
    </ul>
</div>
</body>
</html>
