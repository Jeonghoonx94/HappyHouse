<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>MemberList</title>
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
<script src="assets/mail/jqBootstrapValidation.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
<body>
<!-- Title-->
<jsp:include page="title.jsp"/>
<!-- Header-->
<jsp:include page="header.jsp"/>
	<section class="page-section" id="notice">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">공지사항</h2>
				<h3 class="section-subheading text-muted">Happy House 공지사항 관리하는
					곳입니다.</h3>
			</div>
			<form id="boardForm" name="boardForm" method="post">
				<table class="table table-striped table-hover">
					<thead>
						<tr>
							<th>번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>날짜</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody id="tBody">
					</tbody>
				</table>
	
				<div>
					<button type="button" class="btn btn-success" data-toggle="modal"
						data-target="#noticemodal">글쓰기</button>
				</div>
			</form>
		</div>
	</section>
<!-- Footer-->
<jsp:include page="copyright.jsp"/>
</body>
	<!-- The Notice Modal -->
	<div class="modal" id="noticemodal">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Notice</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="#">
						<div class="mb-3">
							<label for="title">제목</label>
							<input type="text" class="form-control" name="title"
								id="noticeTitle" placeholder="제목을 입력해 주세요">
						</div>
	
						<div class="mb-3">
							<label for="reg_id">작성자</label>
							<input type="text" class="form-control" name="reg_id"
								id="noticeWriter" placeholder="이름을 입력해 주세요">
						</div>
	
						<div class="mb-3">
							<label for="content">내용</label>
							<textarea class="form-control" rows="5" name="content"
								id="noticeContent" placeholder="내용을 입력해 주세요"></textarea>
						</div>
	
						<div class="mb-3">
							<label for="tag">TAG</label>
							<input type="text" class="form-control" name="tag" id="noticeTag"
								placeholder="태그를 입력해 주세요">
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">Close</button>
					<button type="button" class="btn btn-primary" id="noticeSubmit"
						data-dismiss="modal">Submit</button>
				</div>
			</div>
		</div>
	</div>
<script>
	$('#noticeSubmit').on("click", function() {
		let cnt = 1;
		$('#tBody > tr').each(function() {
			cnt += 1;
		});
		console.log("클릭했습니다.");
		let title = $("#noticeTitle").val();
		let writer = $("#noticeWriter").val();
		let content = $("#noticeContent").val();
		let tag = $("#noticeTag").val();
		$("#tBody").append("<tr>" + "<td>" + cnt + "</td>" + "<td>" + title + "</td>" + "<td>" + writer + "</td>" + "<td>" + "2019/09/21" + "</td>" + "<td>" + "123" + "</td>" + "</tr>");
	});
</script>