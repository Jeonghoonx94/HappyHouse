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
<title>회원 목록</title>
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
	$('#searchbtn').click(function () {   
		pagelist(1);
	})
	<c:if test='${not empty param.key}'>
 		$('#key').val('${param.key}')
	</c:if>

	function pagelist(cpage){
		$("#pageNo").val(cpage);
		$("#searchform").attr('action',"${root}/listMember?key=${searchKey}&word=${searchWord}").submit;
	}
})
</script>
</head>
<body id="page-top">
<jsp:include page="title.jsp"/>
	<section class="page-section bg-light" id="team">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">회원 정보 목록</h2>
				<h3 class="section-subheading text-muted">회원 정보 목록입니다.</h3>
			</div>
		<form id="searchform" action="" method="get" class="searchUser" style="margin: auto; max-width: 50%">
			<select name='key' id='searchKey'>
			  	<option value='all'>--선택하세요--</option>
			  	<option value='userid'>아이디</option>
			  	<option value='username'>이름</option>
		 	</select>
		 	<input type="text"  class="form-control" placeholder="회원 정보 검색" id="searchWord"  name='word' value='${bean.word}'>
		  	<button type="submit" class="btn btn-primary" id="searchbtn">검색</button>
		</form>
		<table class="table table-hover">
		    <thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>이메일</th>
					<th>전화번호</th>
					<th>주소</th>
				</tr>
		    </thead>
		    <tbody>
				<c:choose>
	    			<c:when test='${empty userlist}'>
				    	<div>
				        	<p>조회 할 회원이 없습니다.</p>
				        </div>
	     			</c:when>
		     		<c:otherwise>
		     			<c:forEach var='userinfo' items="${userlist}">
		     			<tr>
		     				<td><a href='${root}/infoMember?userid=${userinfo.userid}'>${userinfo.userid}</a></td>
		     				<td>${userinfo.username}</td>
		     				<td>${userinfo.email}</td>
		     				<td>${userinfo.phone}</td>
		     				<td>${userinfo.address}</td>
		     			</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</tbody>
		</table>
	</div>
	</section>
<jsp:include page="copyright.jsp"/>
</body>
</html>