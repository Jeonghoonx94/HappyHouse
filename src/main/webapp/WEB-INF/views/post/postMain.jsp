<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
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
<script type="text/javascript">
	function viewPost(postNo) {
		location.href="${root }/post/view?postNo="+postNo;
	}
</script>
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
	<div class="text-center">
		<h2 class="section-heading text-uppercase">게시글 목록</h2>
		<h3 class="section-subheading text-muted">작성된 게시글 목록입니다</h3>
	</div>
    <form method="get" class="form-inline">
        <div id="margin" class="form-group">
            <select name="select" class="form-control">
                <option value="title" <c:if test="${select eq 'title'}">selected</c:if>>제목</option>
                <option value="username" <c:if test="${select eq 'username'}">selected</c:if>>작성자</option>
            </select>
            <input type="text" size=20 class="form-control" name="search"  placeholder="검색" value="${search}">
            <button type="submit" class="btn btn-primary">조회</button>
        </div>
    </form>

    <table class="table table-hover table table-striped">
    	<colgroup>
    		<col width="8%">
    		<col width="12%">
    		<col width="40%">
    		<col width="28%">
    		<col width="12%">
    	</colgroup>
        <tr>
            <th>번호</th>
            <th>작성자</th>
            <th>제목</th>
            <th></th>
            <th>조회수</th>
        </tr>

        <c:forEach items="${posts}" var="post">
            <tr onclick="viewPost(${post.postNo})">
                <th>${post.postNo}</th>
                <th>${post.username}</th>
                <th>
<%--                     <a href="${root }/post/view?postNo=${post.postNo}"> --%>
                    ${post.title}
<!--                     </a> -->
                </th>
                <th style="font-size: 0.85em;">
                작성일: ${post.createDateTime}
                <c:if test="${post.updateTime ne post.createDateTime }">
                <br> 
                수정일: ${post.updateTime}
                </c:if>
                </th>
                <th>${post.count}</th>
            </tr>
        </c:forEach>
    </table>

	<div class="text-right">
    <a href="${root }/post/write" class="btn btn-primary">글쓰기</a>
	</div>
	<div>
	    <ul class="pagination justify-content-center">
	        <c:forEach var="i" begin="1" end="${totalPage}" step="1">
	        	<c:choose>
	        		<c:when test="${i == page}">
	        			<li class="page-item active">
	                		<a class="page-link" href='${root }/post/list?page=${i}&pageSize=${pageSize}&select=${select}&search=${search}'>${i}</a>
	            		</li>
	        		</c:when>
	        		<c:otherwise>
	        			<li class="page-item">
	                		<a class="page-link" href='${root }/post/list?page=${i}&pageSize=${pageSize}&select=${select}&search=${search}'>${i}</a>
	            		</li>
	        		</c:otherwise>
	        	</c:choose>
	        </c:forEach>
	    </ul>
	</div>
</div>
</section>
	<jsp:include page="../copyright.jsp"/>
</body>
</html>
