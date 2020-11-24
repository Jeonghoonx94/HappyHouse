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
<title>Location</title>
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
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<!-- Third party plugin JS-->
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
<!-- Core theme JS-->
<script src="${root }/js/scripts.js"></script>
<body>
<jsp:include page="title.jsp"/>
<section class="page-section" id="locServices">
    <div class="container">
        <div class="text-center">
            <h2 class="section-heading text-uppercase">관심 지역 목록</h2>
            <h3 class="section-subheading text-muted">등록된 관심 지역 목록입니다.</h3>
        </div>
        <div class="row text-center d-flex justify-content-center font-weight-bold p-3">
            <script>
                let colorArr = ['table-primary','table-success','table-danger'];
                $(document).ready(function(){
                	$.post("${pageContext.request.contextPath}/loc/list"
                        ,function(data, status){
                       	 $("#locResult").empty();
                            $.each(data, function(index, vo) {
                            	let str = "<tr value="+vo.dong+"+"+" class='clickeTr'"+" no="+vo.no+" dong="+vo.dong+">"
			     				+ "<td>" + vo.dong + "/" + vo.gugun_name + "</td>"
			     				+ "<td>"
			     				+ "<button type='button' no='" + vo.no + "' class='btn btn-secondary btn-sm delete'>삭제</button>"
			     				+ "</td>"
				     			+ "</tr>"
                            $("#locResult").append(str);
            				});
                        }//function
                        , "json"
                    );//get
                    $.get("${pageContext.request.contextPath}/map/sido"
                        ,function(data, status){
                            $.each(data, function(index, vo) {
                                $("#locSido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
                            });//each
                        }//function
                        , "json"
                    );//get
                    $("#locSido").change(function() {
                        $.get("${pageContext.request.contextPath}/map/gugun"
                                ,{sido:$("#locSido").val()}
                                ,function(data, status){
                                    $("#locGugun").empty();
                                    $("#locGugun").append('<option value="0">선택</option>');
                                    $.each(data, function(index, vo) {
                                        $("#locGugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
                                    });//each
                                }//function
                                , "json"
                        );//get
                    });//change
                    $("#locGugun").change(function() {
                        $.get("${pageContext.request.contextPath}/map/dong"
                                ,{gugun:$("#locGugun").val()}
                                ,function(data, status){
                                    $("#locDong").empty();
                                    $("#locDong").append('<option value="0">선택</option>');
                                    $.each(data, function(index, vo) {
                                        $("#locDong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
                                    });//each
                                }//function
                                , "json"
                        );//get
                    });//change
                    
                    $("#locAdd").click(function() {
                    	console.log($("#locDong").val())
                    	if($("#locDong").val() !== "0") { // 선택했다면 
//                     		if($("#searchName").val()) {
			                    $.ajax({
			            			url:"${pageContext.request.contextPath}/loc/add",  
			            			type:'GET',
			            			contentType:'application/json;charset=utf-8',
			            			dataType:'json',
			            			data: {  dong:$("#locDong").val(), gugunName:$("#locGugun").val(), userid:"${userlogin.userid}", no:$("#locNo").val() },
			            			success:function(data) {
	                                    $("#locResult").empty();
			                            $.each(data, function(index, vo) {
			                            	let str = "<tr value="+vo.dong+"+"+" class='clickeTr'"+" no="+vo.no+" dong="+vo.dong+">"
						     				+ "<td>" + vo.dong + "/" + vo.gugun_name + "</td>"
						     				+ "<td>"
						     				+ "<button type='button' no='" + vo.no + "' class='btn btn-secondary btn-sm delete'>삭제</button>"
						     				+ "</td>"
							     			+ "</tr>"
			                            $("#locResult").append(str);
			            				});
			            			},
			            			error:function(xhr,status,msg){
			            				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
			            			}
			            		});
//                     		} else {
//                     			alert('아파트 이름을 입력해 주세요!');
//                     		}
                    	} else { // 선택하지 않았다면
                    		alert('읍면동까지 선택해주세요!');
                    	}
                    });
                });//ready

            </script>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">시도</label>
                    <select class="form-control" id="locSido">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">구군</label>
                    <select class="form-control" id="locGugun">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">읍면동</label>
                    <select class="form-control" id="locDong">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <div class="input-group input-group-append">
			        <button class="btn btn-success" id="locAdd">추가</button>
                </div>
            </div>
        </div>
        <div class="row text-center d-flex justify-content-center">
            <div class="col-4">
                <table class="table table-striped" id="locTable">
                    <thead>
                        <tr>
                            <th colspan='2'>관심 지역 목록</th>
                        </tr>
                    </thead>
                    <tbody id="locResult">
                    </tbody>
                </table>
            </div>
            <div class="col-8">
                <div id="locMap" style="width: 100%; height: 300px; margin: auto;"></div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="copyright.jsp"/>
</body>
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDNXC_mR7U_zy1v0r7xDTpnQK9Uxn4vIAw&callback=initMap"></script>
<script>
    var multi = {
        lat : 37.5012743,
        lng : 127.039585
    };
    var map;
    var markers = [];
    var infoWindow;

    function initMap() {
        map = new google.maps.Map(document.getElementById('locMap'), {
            center : multi,
            zoom : 15
        });

        map2 = new google.maps.Map(document.getElementById('map2'), {
            center : multi,
            zoom : 15
        });
        infoWindow = new google.maps.InfoWindow;

        const myposition = "${root}/assets/img/my_position.png";
        console.log(myposition);

        //멀티캠퍼스
        //const multimarker = new google.maps.Marker({coords: multi, content: '멀티캠퍼스', iconImage: myposition});
        var multimarker = {
            coords : multi,
            iconImage : myposition,
            content : '멀티캠퍼스(역삼)'
        };
        var multimarker2 = {
            coords : multi,
            iconImage : myposition,
            content : '멀티캠퍼스(역삼)'
        };
        addMarker(multimarker);
        addMarker2(multimarker2);
        //var marker2 = new google.maps.Marker({position:{lat: mutlti[0], lng: multi[1]}, map: map2}); 
        infoWindow.setPosition(multi);
        infoWindow.setContent('멀티캠퍼스.');
        infoWindow.open(map);
    }
    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ? 'Error: Geolocation 서비스 실패.' : 'Error: Geolocation을 지원하지 않는 브라우저.');
        infoWindow.open(map);
    }
    function addMarker2(props) {
        const marker = new google.maps.Marker({
            position : new google.maps.LatLng(parseFloat(props.coords.lat), parseFloat(props.coords.lng)),
            map : map2
        });
        map2.setCenter(marker.getPosition());
        map2.setZoom(15);

        if (props.iconImage) {
            marker.setIcon(props.iconImage);
        }

        if (props.content) {
            infoWindow = new google.maps.InfoWindow({
                content : props.content
            });

        }

        marker.addListener('click', function() {
            map2.setZoom(17);
            map2.setCenter(marker.getPosition());
            bounceMarker(marker);
        });
        markers.push(marker);
        setMapOnAll(map2);
    }

    function addMarker(props) {
        const marker = new google.maps.Marker({
            position : new google.maps.LatLng(parseFloat(props.coords.lat), parseFloat(props.coords.lng)),
            map : map
        });
        map.setCenter(marker.getPosition());
        map.setZoom(15);

        if (props.iconImage) {
            marker.setIcon(props.iconImage);
        }

        if (props.content) {
            infoWindow = new google.maps.InfoWindow({
                content : props.content
            });

        }

        marker.addListener('click', function() {
            map.setZoom(17);
            map.setCenter(marker.getPosition());
            bounceMarker(marker);
        });
        markers.push(marker);
        setMapOnAll(map);
    }

    function bounceMarker(marker) {
        if (marker.getAnimation() !== null) {
            marker.setAnimation(null);
        } else {
            marker.setAnimation(google.maps.Animation.BOUNCE);
        }
    }

    function deleteMarkers() {
        clearMarkers();
        markers = [];
    }

    function clearMarkers() {
        setMapOnAll(null);
    }

    function setMapOnAll(map) {
        for (let i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
        }
    }

    $('#locTable').on("click", ".clickeTr", function() {
        var area = $(this).attr("value");
        console.log($(this).attr("no"));
        //console.log(area);
        $.get("https://maps.googleapis.com/maps/api/geocode/json", {
            key : 'AIzaSyDNXC_mR7U_zy1v0r7xDTpnQK9Uxn4vIAw',
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
            addMarker(officemarker);
        }, "json");//get
    });

    $('#locTable').on("click", ".delete", function() {
    	console.log($(this).attr("no"));
    	$.ajax({
			url:"${pageContext.request.contextPath}/loc/delete/" + $(this).attr("no"),  
			type:'delete',
			contentType:'application/json;charset=utf-8',
			dataType:'json',
			/* data: { }, */
			success:function(data) {
			 $("#locResult").empty();
                $.each(data, function(index, vo) {
                	let str = "<tr value="+vo.dong+"+"+" class='clickeTr'"+" no="+vo.no+" dong="+vo.dong+">"
     				+ "<td>" + vo.dong + "/" + vo.gugun_name + "</td>"
     				+ "<td>"
     				+ "<button type='button' no='" + vo.no + "' class='btn btn-secondary btn-sm delete'>삭제</button>"
     				+ "</td>"
	     			+ "</tr>"
                $("#locResult").append(str);
				});
 			},
			error:function(xhr,status,msg){
				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
			}
		});
    });
    
    $('#locTable > tbody > tr').on("click", function() {
        var area = $(this).attr("value");
        //console.log(area);
        $.get("https://maps.googleapis.com/maps/api/geocode/json", {
            key : 'AIzaSyDNXC_mR7U_zy1v0r7xDTpnQK9Uxn4vIAw',
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
            addMarker(officemarker);
        }, "json");//get
    });
</script>

