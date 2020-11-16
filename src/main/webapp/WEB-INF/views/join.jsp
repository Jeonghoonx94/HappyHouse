<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Agency - Start Bootstrap Theme</title>
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js" crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
<link href="https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<!-- Bootstrap core JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Member form JS -->
<script src="assets/member/registerValidation.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>

</head>
<body id="page-top">
<jsp:include page="title.jsp"/>
<div class="container">
	<section class="page-section" id="contact">
		<div class="text-center">
			<h2 class="section-heading text-uppercase">회원가입</h2>
			<h3 class="section-subheading text-muted">다음 항목을 입력해주세요.</h3>
		</div>
		<form id="joinform" name="joinform" method="post" action="insertMember" novalidate="novalidate">
			<div class="row align-items-stretch mb-5">
				<div class="col-md-6">
				    <div class="form-group">
				        <input class="form-control" id="userId" type="text" name="userId" placeholder="User ID" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userPwd" type="password" name="userPwd"  placeholder="영문 숫자 포함 6자리 이상 " required="required" />
				        <div id="pwdmessage">
				            <p id="pwdletter" class="invalid">
				                A <b>lowercase</b> letter
				            </p>
				            <p id="pwdnumber" class="invalid">
				                A <b>number</b>
				            </p>
				            <p id="pwdlength" class="invalid">
				                Minimum <b>8 characters</b>
				            </p>
				        </div>
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userName" type="text" name="userName" placeholder="User Name" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userEmail" type="email" name="userEmail" placeholder="email" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userPhone" type="tel" name="userPhone"  placeholder="010-xxxx-xxxx" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userAddr" type="text" name="userAddr" placeholder="서울시 종로구" required="required" />
				    </div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary text-uppercase" id="join">회원가입</button>
						<button type="reset" class="btn btn-warning">초기화</button>
					</div>
				</div>
			</div>
		</form>
	</section>
</div>
<script>
$(document).ready(function() {
	$('#join').on("click", function() {
		if($("#userId").val() == "") {
	        alert("아이디 필수 입력!");
	        return;
	    } else if($("#userPwd").val() == "") {
	        alert("비밀번호 필수 입력!");
	        return;
	    } else if($("#userName").val() == "") {
	        alert("이름 필수 입력!");
	        return;
	    } else if($("#userEmail").val() == "") {
	        alert("이메일 필수 입력!");
	        return;
	    } else if($("#userPhone").val() == "") {
	        alert("연락처 필수 입력!");
	        return;
	    } else if($("#userAddr").val() == "") {
	        alert("주소 필수 입력!");
	        return;
	    }
		
		let registerinfo = JSON.stringify({
			"username" : $("#userName").val(), "userid" : $("#userId").val(), "userpwd" : $("#userPwd").val(),
			"email" : $("#userEmail").val(), "phone" : $("#userPhone").val(), "address" : $("#userAddr").val()
		})
		
		$.ajax({
			url: '${root}/member/mvJoin',
			type: 'POST',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			data: registerinfo,
			success: function(users){
				$("#userName").val('');
				$("#userId").val('');
				$("#userPwd").val('');
				$("#userEmail").val('');
				$("#userPhone").val('');
				$("#userAddr").val('');
				makeList(users);
			},
			error: function(xhr, status, msg){
				console.log("상태값 : " + status + " Http에러메세지 : " + msg);
			}
		})
	});
}

function makeList(users) {
	$("#userlist").empty();
	$(users).each(function(index, user) {
		let str = "<tr id=\"view_" + user.userid + "\" class=\"view\" data-id=\"" + user.userid + "\">"
		+ "	<td>" + user.userid + "</td>"
		+ "	<td>" + user.userpwd + "</td>"
		+ "	<td>" + user.username + "</td>"
		+ "	<td>" + user.email + "</td>"
		+ "	<td>" + user.phone + "</td>" 
		+ "	<td>" + user.address + "</td>"
		+ "	<td><button type=\"button\" class=\"modiBtn btn btn-outline-primary btn-sm\">수정</button> "
		+ "		<button type=\"button\" class=\"delBtn btn btn-outline-danger btn-sm\">삭제</button></td>"
		+ "</tr>"
		+ "<tr id=\"mview_" + user.userid + "\" data-id=\"" + user.userid + "\" style=\"display: none;\">"
		+ "	<td>" + user.userid + "</td>"
		+ "	<td><input type=\"text\" name=\"userpwd\" id=\"userpwd" + user.userid + "\" value=\"" + user.userpwd + "\"></td>"
		+ "	<td>" + user.username + "</td>"
		+ "	<td><input type=\"text\" name=\"email\" id=\"email" + user.userid + "\" value=\"" + user.email + "\"></td>"
		+ "	<td><input type=\"text\" name=\"phone\" id=\"phone" + user.userid + "\" value=\"" + user.phone + "\"></td>"
		+ "	<td><input type=\"text\" name=\"address\" id=\"address" + user.userid + "\" value=\"" + user.address + "\"></td>" 
		+ "	<td><button type=\"button\" class=\"modifyBtn btn btn-primary btn-sm\">수정</button> "
		+ "		<button type=\"button\" class=\"cancelBtn btn btn-danger btn-sm\">취소</button></td>"
		+ "</tr>";
		$("#userlist").append(str);
	});//each
}
</script>
<jsp:include page="copyright.jsp"/>
</body>
</html>