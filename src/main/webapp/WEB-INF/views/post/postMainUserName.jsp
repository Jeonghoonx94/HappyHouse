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
<link rel="icon" type="image/x-icon" href="${root }/assets/img/favicon.ico" />
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
        margin-bottom : 20px;
        margin-top : 20px;
    }

</style>
<body>
    <!-- 메뉴바 -->
	<jsp:include page="../title.jsp"/>
    <!-- ./ 메뉴바 -->
	<section class="page-section bg-light">

<div class="container">

    <form method="post" class="form-inline">
        <div id="margin" class="form-group">
            <select name="select" class="form-control">
                <option value="title" >제목</option>
                <option value="nickname" selected>작성자</option>
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
                <th>${post.getPostNo()}</th>
                <th>${post.getUsername()}</th>
                <th>
                    <a href="${root }/post/view?postId=${post.getPostNo()}&memberId=${post.getUserid()}">${post.getTitle()}</a>
                </th>
                <th>${post.getCount()}</th>
                <th>${post.getUpdateTime()}</th>
                <th>${post.getCreateDateTime()}</th>
            </tr>
        </c:forEach>
    </table>

	<div class="text-right">
    <a href="${root }/post/write" class="btn btn-primary">글쓰기</a>
	</div>
    <ul class="pagination">
        <c:forEach var="i" begin="1" end="${totalPage}" step="1">
            <li class=<c:if test='${i} == ${page} ? "active" : ""'/>>
                <a href='${root }/post/list?page=${i}&pageSize=${pageSize}'>${i}</a>
            </li>
        </c:forEach>
    </ul>
</div>
</section>
	<jsp:include page="../copyright.jsp"/>
</body>
</html>
