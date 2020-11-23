<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>공지사항 상세</title>
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
<script>
$(document).ready(function() {
	$('#delNotice').click(function () {
		location.href='${root}/notice/delete?no=${notice.no}';
	});
	$('#updateNotice').click(function () {
		$("#detailNotice").attr("action","${root}/notice/update").submit();
	});
	$('#mvNotice').click(function () {
		location.href='${root}/notice/list';
	});
})
</script>
</head>
<body>
<!-- Title-->
<jsp:include page="../title.jsp"/>
<!-- Header-->
<jsp:include page="../header.jsp"/>
	<section class="page-section">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">공지사항</h2>
				<h3 class="section-subheading text-muted">Happy House 공지사항</h3>
			</div>
			<form action="" method="post" id="detailNotice">
				<div class="container col-lg-6" align="center">	
					<div class="mb-3">
						<label for="title">제목</label>
						<input type="text" class="form-control" id="ntitle" name="title" value="${notice.title}">
					</div>
					<div class="mb-3">
						<label for="reg_id">작성자</label>
						<input type="text" class="form-control" id="nwriter" name="writer" value="${notice.writer}">
					</div>
					<div class="mb-3">
						<label for="content">내용</label>
						<textarea class="form-control" rows="5" id="ncontent" name="content">${notice.content}</textarea>
					</div>
					<div class="mb-3">
						<label for="tag">TAG</label>
						<input type="text" class="form-control" id="ntag" name="tag" value="${notice.tag}">
					</div>
					<div class="form-group" align="left">
						<button type="button" class="btn btn-danger" id="delNotice">삭제</button>
						<button type="button" class="btn btn-primary" id="updateNotice">수정</button>
					</div>
				<button type="button" class="btn btn-primary" id="mvNotice">목록</button>
				</div>
			</form>
		</div>
	</section>
<!-- Footer-->
<jsp:include page="../copyright.jsp"/>
</body>
