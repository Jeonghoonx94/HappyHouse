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
        /* body { font-family: 굴림체; }
        table.table { width: 500px; }
        table td:nth-child(1) { background-color: #eee; }
        h1 {
            margin-top: 30px;
            margin-bottom: 20px;
        } */
    </style>
</head>
<body>
<jsp:include page="../title.jsp"/>
<section class="page-section bg-light">
	<div class="container">
		<div class="text-center">
			<h2 class="section-heading text-uppercase">게시글 댓글 목록</h2>
			<h3 class="section-subheading text-muted">해당 게시글의 댓글 목록입니다</h3>
		</div>
	    <%-- <a href="${root }/comment/list?postNo=${postNo}">댓글 목록 </a> --%>
	    <table class="table table-hover table table-striped w-100">
			<colgroup>
				<col width="100px">
				<col>
				<col width="180px">
				<col width="180px">
				<col width="100px">
			</colgroup>
	        <tr>
	            <th>작성자</th>
	            <th>내용</th>
	            <th>작성시간</th>
	            <th>수정시간</th>
	            <th></th>
	        </tr>
	
	        <c:forEach items="${comments}" var="comment">
	            <tr>
	                <th>${comment.username}</th>
	                <th>${comment.content}</th>
	                <th>${comment.createDateTime}</th>
	                <th>${comment.updateTime}</th>
	                <th>
	                <c:choose>
		                <c:when test="${comment.userid eq userlogin.userid}">
			                <a href="${root }/comment/update?commentNo=${comment.commentNo}">수정</a> | 
			                <a href="${root }/comment/delete?commentNo=${comment.commentNo}">삭제</a>
		                </c:when>
		                <c:otherwise >
		                	<c:if test="${100 eq userlogin.role}">
		                		<a href="${root }/comment/delete?commentNo=${comment.commentNo}">삭제</a>
		                	</c:if>
		                </c:otherwise>
	                </c:choose>
	                </th>
	            </tr>
	        </c:forEach>
	    </table>
	    <a href="${root }/post/view?postNo=${postNo}" class="btn btn-info">게시글로 가기</a>
	</div>
</section>
<jsp:include page="../copyright.jsp"/>
</body>
</html>