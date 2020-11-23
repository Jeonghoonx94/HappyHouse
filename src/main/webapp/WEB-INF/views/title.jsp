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
<title>TITLE</title>
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
$(document).ready(function() {
	$('#loginBtn').click(function () {
		if($("#userid").value == "") {
			alert("아이디 입력!!!");
			return;
		} else if($("#userpwd").value == "") {
			alert("비밀번호 입력!!!");
			return;
		} else {
 			$("#loginform").attr("action", "${root}/login").submit();
		}
	})
	$('#forgotPwd').click(function () {
		if($("#hintid").value == "") {
			alert("아이디 입력!!!");
			return;
		} else if($("#hintemail").value == "") {
			alert("이메일 입력!!!");
			return;
		} else {
			$("#forgotform").attr("action", "${root}/findpwd").submit();
		}
	})
})
function logout() {
    $.ajax({
        type: 'GET',
        url: '${root}/logout',
        success: function () {
        	alert("Log Out!");
			location.reload(true);
        }
    });
}
</script>
</head>
<body id="page-top">
<c:if test="${!empty msg}">
	<script type="text/javascript">
	alert('${msg}')
	</script>
	<c:remove var='msg'/>
</c:if>
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top bg-dark" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="${root}">
				<img src="${root }/assets/img/navbar-logo.svg" alt="">
			</a>
			<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation"> Menu <i class="fas fa-bars ml-1"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ml-auto">
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href='${root}/post/list'>게시판</a>
					</li>
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href='${root}/search.do'>관심지역</a>
					</li>
					<li class="nav-item">
						<a class="nav-link js-scroll-trigger" href='${root}/notice/list'>공지사항</a>
					</li>
					<c:choose>
						<c:when test="${empty userlogin}">
							<li class="nav-item">
								<a class="nav-link js-scroll-trigger" data-toggle="modal" data-target="#loginModal">로그인</a>
							</li>
							<li class="nav-item">
								<a class="nav-link js-scroll-trigger" href='${root}/member/join'>회원가입</a>
							</li>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${100 eq userlogin.role}">
									<li class="nav-item">
										<a class="nav-link js-scroll-trigger" href="${root}/member/list">회원정보</a>
									</li>
									<li class="nav-item">
										<a class="nav-link js-scroll-trigger" href='${root}/logout'>로그아웃</a>
<!-- 									<a class="nav-link js-scroll-trigger" href='javascript:logout()'>로그아웃</a> -->
									</li>
								</c:when>
								<c:otherwise>
									<li class="nav-item">
										<a class="nav-link js-scroll-trigger" href='${root}/member/info?userid=${userlogin.userid}'>${userlogin.userid }님</a>
									</li>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
	</nav>
	
<!-- The Modal -->
	<div class="modal" id="loginModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">로그인</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form id="loginform" method="post" action="">
						<div class="form-group">
							<label for="loginid">아이디</label>
							<input type="text" class="form-control" id="userid" name="userid">
						</div>
						<div class="form-group">
							<label for="loginpwd">비밀번호</label>
							<input type="password" class="form-control" id="userpwd" name="userpwd">
						</div>
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="loginBtn">로그인</button>
						<button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#forgotModal" data-dismiss="modal">비밀번호 찾기</button>
					</form>
				</div>

			</div>
		</div>
	</div>

<!-- The Modal -->
	<div class="modal" id="forgotModal">
		<div class="modal-dialog">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">비밀번호 찾기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form  method="post" action="" id="forgotform">
						<div class="form-group">
							<label for="hintid">아이디</label>
							<input type="text" class="form-control" id="hintid" name="userid">
						</div>
						<div class="form-group">
							<label for="hintemail">이메일</label>
							<input type="email" class="form-control" id="hintemail" name="email">
						</div>
						<button type="button" class="btn btn-primary" data-dismiss="modal" id="forgotPwd">비밀번호 찾기</button>
					</form>
				</div>

			</div>
		</div>
	</div>
</body>
</html>