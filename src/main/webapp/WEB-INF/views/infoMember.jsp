<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>infoMember</title>
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
<script type="text/javascript">
$(document).ready(function() {
	$('#updateBtn').click(function () {   
		$("#updateform").attr("action", "${root}/updateMember").submit();
	});
	$('#removeBtn').click(function () {
		location.href='${root}/removeMember?userid=${member.userid}';
	});
})

$(document).on("click", "#updateBtn", function(){
	let modifyinfo = JSON.stringify({
		"username" : $("#userNAME").val(), "userid" : $("#userID").val(), "userpwd" : $("#userPWD").val(),
		"email" : $("#userEMAIL").val(), "phone" : $("#userPHONE").val(), "address" : $("#userADDR").val()
	})
	$.ajax({
		url: '${root}/updateMember',
		type: 'PUT',
		contentType: 'application/json;charset=utf-8',
		dataType: 'json',
		data: modifyinfo,
		success: function(users){
			makeList(users);
		}
	})
})

$(document).on("click", "#removeBtn", function(){
	if(confirm("정말 삭제?")){
		let delid = $("#userID")
		$.ajax({
			url: '${root}/removeMember/userid=' + delid,
			type: 'DELETE',
			contentType: 'application/json;charset=utf-8',
			dataType: 'json',
			success: function(users){
				makeList(users);
			},
			error: function(xhr, status, msg){
				console.log("상태값 : " + status + " Http 에러메세지" + msg);
			}
		})
	}
})

</script>
<body id="page-top">
	<jsp:include page="title.jsp"/>
	<section class="page-section bg-light">
	<div class="container" align="center">
		<div class="col-lg-6">
			<div>
				<h1>회원 정보</h1>
			</div>
			<form id="updateform" name="updateform" action="">
			  	<div class="container" align="center">
					<div class="col-lg-6" align="center">				
						<div class="form-group" align="left">
							<label for="">아이디</label>
							<input type="text" class="form-control" id="userID" name="userID"  value="${member.userid}">
						</div>
						<div class="form-group" align="left">
							<label for="">비밀번호</label>
							<input type="text" class="form-control" id="userPWD" name="userPWD"  value="${member.userpwd}">
						</div>
						<div class="form-group" align="left">
							<label for="">이름</label>
							<input type="text" class="form-control" id="userNAME" name="userNAME"  value="${member.username}">
						</div>
						<div class="form-group" align="left">
							<label for="">이메일</label>
							<input type="text" class="form-control" id="userEMAIL" name="userEMAIL"  value="${member.email}">
						</div>
						<div class="form-group" align="left">
							<label for="">연락처</label>
							<input type="text" class="form-control" id="userPHONE" name="userPHONE"  value="${member.phone}">
						</div>
						<div class="form-group" align="left">
							<label for="">주소</label>
							<input type="text" class="form-control" id="userADDR" name="userADDR"  value="${member.address}">
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
<jsp:include page="copyright.jsp"/>
</body>
</html>