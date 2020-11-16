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
<script type="text/javascript">
$(document).ready(function() {
	//회원 목록
	$.ajax({
		url:'${root}/member/list',  
		type:'GET',
		contentType:'application/json;charset=utf-8',
		dataType:'json',
		success:function(users) {
			makeList(users);
		},
		error:function(xhr,status,msg){
			console.log("상태값 : " + status + " Http에러메시지 : "+msg);
		}
	});
}

$(document).on("dblclick", "tr.view", function(){
	let vid = $(this).attr("data-id");
	$.ajax({
		url: '${root}/member/info/' + vid,
		type: 'GET',
		contentType: 'application/json; charset=utf-8',
		success: function(user){
			$("#vid").text(user.userid);
			$("#vpwd").text(user.userpwd);
			$("#vname").text(user.username);
			$("#vemail").text(user.email);
			$("#vphone").text(user.phone);
			$("#vaddress").text(user.address);
		},
		error: function(xhr, status, msg){
			console.log("상태값 : " + status + " Http 에러메세지 : " + msg);
		}
	})
})

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

function mdelete(){
	alert("정말 삭제하시겠습니까?");
}
$(function() {
	$('#infoBtn').click(function () {   
		location.href='${root}/infoMember?userid=${userinfo.userid}'
	})
})
$(function() {
	$('#searchbtn').click(function () {   
		pagelist(1);
	})
	<c:if test='${not empty param.key}'>
 		$('#key').val('${param.key}')
	</c:if>
})
function pagelist(cpage){
	$("#pageNo").val(cpage);
	var searchform = $("#searchform");
	searchform.attr('action',"${root}/listMember");
	searchform.submit();
}
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
		<form id="searchform" class="searchUser" style="margin: auto; max-width: 50%">
			<select name='key' id='key'>
			  	<option value='all'>--선택하세요--</option>
			  	<option value='userid'>아이디</option>
			  	<option value='username'>이름</option>
		 	</select>
		 	<input type="text"  class="form-control" placeholder="회원 정보 검색" id="word"  name='word' value='${bean.word}'>
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
		    <tbody id="userlist"></tbody>
		</table>
	</div>
	</section>
	<!-- The Modal -->
	<div class="modal" id="memberUpdate">
		<div class="modal-dialog">
			<div class="modal-content">
	
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">회원 정보 수정</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
	
				<!-- Modal body -->
				<div class="modal-body">
					<form action="#">
						<div class="form-group">
							<label>아이디</label>
							<input type="text">
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password">
						</div>
						<div class="form-group">
							<label>이름</label>
							<input type="text">
						</div>
						<div class="form-group">
							<label>이메일</label>
							<input type="email">
						</div>
						<div class="form-group">
							<label>전화번호</label>
							<input type="tel">
						</div>
						<div class="form-group">
							<label>주소</label>
							<input type="text">
						</div>
						<button type="submit" class="btn btn-primary" data-dismiss="modal">확인</button>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">취소</button>
					</form>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="copyright.jsp"/>
</body>
</html>