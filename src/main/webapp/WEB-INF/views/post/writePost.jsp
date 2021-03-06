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
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<jsp:include page="../title.jsp"/>
	<section class="page-section bg-light">
	<div class="container">
		<div class="text-center">
			<h2 class="section-heading text-uppercase">게시글 등록</h2>
			<h3 class="section-subheading text-muted">새로운 게시글을 등록할 수 있습니다</h3>
		</div>
	    <form method="post" action="${root }/post/write" >
			<div class="container col-lg" align="center">
					<div class="col-md">
	        			<table class="table table-bordered table-condensed">
				            <tr>
				                <td>글 제목</td>
				                <td>
				                    <textarea class="form-control" name="title" rows="1"></textarea>
				                </td>
				            </tr>
				            <tr>
				                <td>작성자</td>
				                <td>
				                    <input type="text" name="nickname" value="${member.getUsername()}" class="form-control" readonly>
				                </td>
				            </tr>
				            <tr>
				                <td>글 내용</td>
				                <td>
				                    <textarea class="form-control" name="content" rows="10"></textarea>
				                </td>
				            </tr>
	        			</table>
			        <button type="submit" class="btn btn-primary">등록</button>
			       	<a href="javascript:window.history.back()" class="btn btn-secondary">목록</a>
		        </div>
	        </div>
	    </form>
	
	</div>
</section>
<jsp:include page="../copyright.jsp"/>
</body>
</html>
