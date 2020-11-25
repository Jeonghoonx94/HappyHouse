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
<!-- Core theme JS-->
<script src="${root }/js/scripts.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	$('#searchbtn').click(function () {   
// 		pagelist(1);
	})
	function pagelist(cpage){
		$("#pageNo").val(cpage);
		$("#searchform").attr('action',"${root}/member/list?key=${searchKey}&word=${searchWord}").submit;
	}
	$('#removeMember').click(function () {   
		if(alert('정말 삭제하시겠습니까?')){
			location.href='${root}/member/remove?userid=${userinfo.userid}';
		}
	})
})
</script>
</head>
<body id="page-top">
<jsp:include page="../title.jsp"/>
	<section class="page-section bg-light" id="team">
		<div class="container">
			<div class="text-center">
				<h2 class="section-heading text-uppercase">회원 목록</h2>
				<h3 class="section-subheading text-muted">가입된 회원 목록입니다</h3>
			</div>
			
			<form id="searchform" action="" method="get" class="form-inline" style="margin: auto; max-width: 50%">
				<div class="form-group">
					<select name='key' id='searchKey' class="form-control">
					  	<option value='all' <c:if test="${empty key or 'all' eq key}">selected</c:if>>선택하세요</option>
					  	<option value='userid' <c:if test="${key eq 'userid'}">selected</c:if>>아이디</option>
					  	<option value='username' <c:if test="${key eq 'username'}">selected</c:if>>이름</option>
				 	</select>
				 	<input type="text"  class="form-control" placeholder="회원 정보 검색" id="searchWord"  name='word' value='${word}'>
				  	<button type="submit" class="btn btn-primary" id="searchbtn">검색</button>
				</div>
			</form>
			<table class="table table-hover">
			    <thead>
					<tr>
						<th>아이디</th>
						<th>이름</th>
						<th>이메일</th>
						<th>전화번호</th>
						<th>주소</th>
						<th></th>
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
			     				<td>${userinfo.userid}</td>
			     				<td>${userinfo.username}</td>
			     				<td>${userinfo.email}</td>
			     				<td>${userinfo.phone}</td>
			     				<td>${userinfo.address}</td>
			     				<td>
			     					<a class="btn btn-danger btn-sm" href="${root }/member/list/remove?userid=${userinfo.userid}"  onclick="confirm('정말 삭제하시겠습니까?')">삭제</a>
			     				</td>
			     			</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		    <ul class="pagination justify-content-center">
		        <c:forEach var="i" begin="1" end="${totalPage}" step="1">
		        	<c:choose>
		        		<c:when test="${i == page}">
		        			<li class="page-item active">
		                		<a class="page-link" href='${root }/member/list?page=${i}&pageSize=${pageSize}&key=${key}&word=${word}'>${i}</a>
		            		</li>
		        		</c:when>
		        		<c:otherwise>
		        			<li class="page-item">
		                		<a class="page-link" href='${root }/member/list?page=${i}&pageSize=${pageSize}&key=${key}&word=${word}'>${i}</a>
		            		</li>
		        		</c:otherwise>
		        	</c:choose>
		        </c:forEach>
		    </ul>
		</div>
	</section>
<jsp:include page="../copyright.jsp"/>
</body>
</html>
