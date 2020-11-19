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
<header class="masthead">
	<div class="container">
		<div class="masthead-subheading">=== Welcome To Our ===</div>
		<div class="masthead-heading text-uppercase">HAPPY HOUSE</div>
		<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
			data-toggle="modal" data-target="#exampleModal2">관심지역등록</a>
	</div>
</header>
<!-- Concern Modal -->
<div class="modal fade" id="exampleModal2" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">관심 지역 등록</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-4">관심지역 설정</div>
					<div class="col-8">
						<select class="custom-select p-2">
							<option selected>도/광역시</option>
							<option value="1">서울</option>
							<option value="2">광주</option>
							<option value="3">대구</option>
						</select>
						<select class="custom-select p-2">
							<option selected>시/군/구</option>
							<option value="1">역삼</option>
							<option value="2">종로</option>
							<option value="3">홍대</option>
						</select>
						<select class="custom-select p-2">
							<option selected>동</option>
							<option value="1">관악</option>
							<option value="2">명륜</option>
							<option value="3">율전</option>
						</select>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
	</div>
</div>
</body>