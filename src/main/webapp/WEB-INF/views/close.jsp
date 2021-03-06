<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<spring:eval expression="@property['GOOGLE_API_KEY']" var="GOOGLE_API_KEY" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8"/>
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>COPYRIGHT</title>
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
	$('#table2 > tbody > tr').on("click", function() {
		var area = $(this).attr("value");
		console.log("??");
		$.get("https://maps.googleapis.com/maps/api/geocode/json", {
			key : '${GOOGLE_API_KEY}',
			address : area
		}, function(data, status) {
			console.log(data);
			deleteMarkers();
			var officemarker = {
				coords : {
					lat : data.results[0].geometry.location.lat,
					lng : data.results[0].geometry.location.lng
				},
				iconImage : null,
				content : area
			};
			console.log(officemarker);
			addMarker2(officemarker);
		}, "json");//get
	});
</script>
</head>
<body>
<section class="page-section bg-light" id="portfolio">
	<div class="container">
		<div class="text-center d-inline d-flex justify-content-center p-2">
			<h2 class="section-heading text-uppercase ">?????? ?????? ??? ???????????? ??????</h2>
		</div>
		<div class="row text-center d-flex justify-content-center">
			<div class="col-4">
				<div class="btn-group btn-group-toggle p-3" data-toggle="buttons">
					<label class="btn btn-light active"> <input type="radio"
							name="options" id="option1" autocomplete="off" checked>
						?????? ?????? ??????
					</label> <label class="btn btn-light"> <input type="radio"
							name="options" id="option2" autocomplete="off"> ???????????? ??????
					</label>
				</div>
				<table class="table table-striped" id="table2">
					<tbody>
						<tr>
							<th scope="row">1</th>
							<td>??????????????????
								<button type="button" class="btn btn-secondary btn-sm"
									data-toggle="modal" data-target="#exampleModal">?????????</button>
							</td>
						</tr>

						<tr>
							<th scope="row">2</th>
							<td>?????????????????????
								<button type="button" class="btn btn-secondary btn-sm"
									data-toggle="modal" data-target="#exampleModal">?????????</button>
							</td>
						</tr>
						<tr>
							<th scope="row">3</th>
							<td>???????????????
								<button type="button" class="btn btn-secondary btn-sm"
									data-toggle="modal" data-target="#exampleModal">?????????</button>
							</td>

						</tr>
						<tr>
							<th scope="row">4</th>
							<td>CS ??????
								<button type="button" class="btn btn-secondary btn-sm"
									data-toggle="modal" data-target="#exampleModal">?????????</button>
							</td>
						</tr>

					</tbody>
				</table>

			</div>
			<div class="col-8">
				<div id="map2" style="width: 100%; height: 300px; margin: auto;"></div>
			</div>
		</div>
	</div>
</section>
</body>
