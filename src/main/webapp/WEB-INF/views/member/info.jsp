<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
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
<title>회원 상세</title>
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
<script type="text/javascript">
$(document).ready(function() {
	$('#updateBtn').click(function () {   
		$("#updateform").attr("action", "${root}/member/update").submit();
	});
	$('#removeBtn').click(function () {
		location.href='${root}/member/remove?userid=${member.userid}';
	});
})
</script>
</head>
<body id="page-top">
	<jsp:include page="../title.jsp"/>
	<section class="page-section bg-light">
		<div class="container" align="center">
		<div class="col-lg-6">
			<div>
				<h1>회원 정보</h1>
			</div>
			<form id="updateform" name="updateform" action="" method="post">
			  	<div class="container" align="center">
					<div class="col-lg-6" align="center">				
						<div class="form-group" align="left">
							<label for="">아이디</label>
							<input type="text" class="form-control" id="userID" name="userid"  value="${member.userid}">
						</div>
						<div class="form-group" align="left">
							<label for="">비밀번호</label>
							<input type="text" class="form-control" id="userPWD" name="userpwd"  value="${member.userpwd}">
						</div>
						<div class="form-group" align="left">
							<label for="">이름</label>
							<input type="text" class="form-control" id="userNAME" name="username"  value="${member.username}">
						</div>
						<div class="form-group" align="left">
							<label for="">이메일</label>
							<input type="text" class="form-control" id="userEMAIL" name="email"  value="${member.email}">
						</div>
						<div class="form-group" align="left">
							<label for="">연락처</label>
							<input type="text" class="form-control" id="userPHONE" name="phone"  value="${member.phone}">
						</div>
						<div class="form-group" align="left">
							<label for="">주소</label>
							<input type="text" class="form-control" id="userADDR" name="address"  value="${member.address}">
						</div>
						<div class="form-group" align="left">
							<button type="button" class="btn btn-primary" id="updateBtn">수정</button>
							<button type="button" class="btn btn-danger" id="removeBtn">삭제</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	</section>
<jsp:include page="../copyright.jsp"/>
</body>
</html>