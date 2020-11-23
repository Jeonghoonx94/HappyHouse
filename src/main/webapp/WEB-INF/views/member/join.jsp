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
<title>회원 가입</title>
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
	$('#joinbtn').on("click", function() {
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
	    } else if(letter.classList.contains("invalid") ||
	    		number.classList.contains("invalid") ||
	    		length.classList.contains("invalid")) {
	        alert("비밀번호는 적어도 하나 이상의 소문자와 숫자, 최소 8자 이상이어야 합니다.");
	        return;
	    } else {
	        $("#joinform").attr("action", "${root}/member/join").submit();
	    }

	});
	

// 	$("#registForm").on("submit", function() {
// 		if(!checkId){
// 			alert("아이디 중복체크 실패");
// 			return;
// 		}
// 		alert("회원 가입이 완료되었습니다.");
// 	});
	
	//password 유효성 검사
	var myInput = document.getElementById("userPwd");
	var letter = document.getElementById("pwdletter");
	var number = document.getElementById("pwdnumber");
	var length = document.getElementById("pwdlength");

	console.log(myInput);
	myInput.onfocus = function() {
  		document.getElementById("pwdmessage").style.display = "block";
	}

	myInput.onblur = function() {
  		document.getElementById("pwdmessage").style.display = "none";
	}

	myInput.onkeyup = function() {
	// Validate lowercase letters
  		var lowerCaseLetters = /[a-z]/g;
  		if(myInput.value.match(lowerCaseLetters)) {
    		letter.classList.remove("invalid");
    		letter.classList.add("valid");
  		} else {
    		letter.classList.remove("valid");
    		letter.classList.add("invalid");
	}
	
	  // Validate numbers
	  var numbers = /[0-9]/g;
	  if(myInput.value.match(numbers)) {
	  		number.classList.remove("invalid");
	  		number.classList.add("valid");
	  } else {
	    	number.classList.remove("valid");
	    	number.classList.add("invalid");
	  }

		// Validate length
		if(myInput.value.length >= 8) {
	    	length.classList.remove("invalid");
			length.classList.add("valid");
		} else {
	    	length.classList.remove("valid");
			length.classList.add("invalid");
		}
	}
	
});
</script>
</head>
<body id="page-top">
<jsp:include page="../title.jsp"/>
<div class="container">
	<section class="page-section" id="contact">
		<div class="text-center">
			<h2 class="section-heading text-uppercase">회원가입</h2>
			<h3 class="section-subheading text-muted">다음 항목을 입력해주세요.</h3>
		</div>
		<form id="joinform" name="joinform" method="post" action="" novalidate="novalidate">
			<div class="row align-items-stretch mb-5">
				<div class="col-md-6">
				    <div class="form-group">
				        <input class="form-control" id="userId" type="text" name="userid" placeholder="아이디를 입력하세요" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userPwd" type="password" name="userpwd"  placeholder="영문 숫자 포함 6자리 이상 " required="required" />
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
				        <input class="form-control" id="userName" type="text" name="username" placeholder="이름을 입력하세요" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userEmail" type="email" name="email" placeholder="xxxx@xxx.xxx" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userPhone" type="tel" name="phone"  placeholder="010-xxxx-xxxx" required="required" />
				    </div>
				    <div class="form-group">
				        <input class="form-control" id="userAddr" type="text" name="address" placeholder="주소를 입력하세요" required="required" />
				    </div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary text-uppercase" id="joinbtn">회원가입</button>
						<button type="reset" class="btn btn-warning">초기화</button>
					</div>
				</div>
			</div>
		</form>
	</section>
</div>
<jsp:include page="../copyright.jsp"/>
</body>
</html>