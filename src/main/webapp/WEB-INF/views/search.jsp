<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="root" value="${pageContext.request.contextPath}" />
<spring:eval expression="@property['GOOGLE_API_KEY']" var="GOOGLE_API_KEY" />
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>MemberList</title>
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
<section class="page-section" id="services">
    <div class="container">
        <div class="text-center">
            <h2 class="section-heading text-uppercase">실거래가 검색 및 결과</h2>
            <h3 class="section-subheading text-muted">아파트, 다세대, 주택의 매매와 전월세를 보여드립니다.</h3>
        </div>
        <div class="row text-center d-flex justify-content-center font-weight-bold p-3">
            <script>
                let colorArr = ['table-primary','table-success','table-danger'];
               	var storeMarked = false;
               	var pollutionMarked = false;
               	var cctvMarked = false;
               	
                $(document).ready(function(){
//                 	showCctvAll();
                	
                    $.get("${pageContext.request.contextPath}/map/sido"
                        ,function(data, status){
                            $.each(data, function(index, vo) {
                                $("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
                            });//each
                        }//function
                        , "json"
                    );//get
                    $("#sido").change(function() {
                        $.get("${pageContext.request.contextPath}/map/gugun"
                                ,{sido:$("#sido").val()}
                                ,function(data, status){
                                    $("#gugun").empty();
                                    $("#gugun").append('<option value="0">선택</option>');
                                    $.each(data, function(index, vo) {
                                        $("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
                                    });//each
                                }//function
                                , "json"
                        );//get
                    });//change
                    $("#gugun").change(function() {
                        $.get("${pageContext.request.contextPath}/map/dong"
                                ,{gugun:$("#gugun").val()}
                                ,function(data, status){
                                    $("#dong").empty();
                                    $("#dong").append('<option value="0">선택</option>');
                                    $.each(data, function(index, vo) {
                                        $("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
                                    });//each
                                }//function
                                , "json"
                        );//get
                    });//change
                    $("#dong").change(function() {
                        $.get("${pageContext.request.contextPath}/map/apt"
                                ,{dong:$("#dong").val(), type:$("#type").val()}
                                ,function(data, status){
                                	storeMarked = false;
                                	pollutionMarked = false;
                                	cctvMarked = false;
                                	
                                	$("#searchTable").css({"overflow-y":"auto", "height":"340px"});
                                    $("#searchResult").empty();
                                    
                                    $.each(data, function(index, vo) {
                                    	console.log(vo);
                                    	console.log("vo : "+vo);
                                    	console.log("rentMoney" + vo.rentMoney);
                                    	
                                        //let str = "<tr value='서울특별시+강남구+역삼동+테헤란로+212'>"
                                        let str = "<tr value="+vo.dong+"+"+vo.aptName+"+"+vo.jibun+" class='clickeTr'"+" no="+vo.no+" dong="+vo.dong+" aptName="+vo.aptName+" jibun="+vo.jibun+" code="+vo.code+ " rentMoney=" +vo.rentMoney+" dealAmount="+vo.dealAmount+">"
                                        +"<th scope='row'>"+vo.no+"</th>"
                                        +"<td>" + vo.aptName + "</td><td>"
                                        +"<button type='button'"+" no="+vo.no+" dong="+vo.dong+" aptName="+vo.aptName+" jibun="+vo.jibun+" code="+vo.code+ " rentMoney=" +vo.rentMoney+" dealAmount="+vo.dealAmount+ " dealDate='" + vo.dealYear+"년 "+vo.dealMonth + "월 "+vo.dealDay+"일' class='btn btn-secondary btn-sm detail' data-toggle='modal' data-target='#exampleModal'>자세히</button>"
                                        +"</td>"
                                        +"</tr>";
	                                    $("#searchResult").append(str);
                                    });//each
                                    //geocode(data);
                                }//function
                                , "json"
                        );//get
                    });//change
                    
                    $("#searchBtn").click(function() {
                    	console.log($("#dong").val(),$("#searchName").val())
                    	if($("#dong").val() !== "0") { // 선택했다면 
		                    $.ajax({
		            			url:"${pageContext.request.contextPath}/map/search",  
		            			type:'GET',
		            			contentType:'application/json;charset=utf-8',
		            			dataType:'json',
		            			data: {dong:$("#dong").val(), type:$("#type").val(), aptName:$("#searchName").val()},
		            			success:function(data) {
		            				console.log(data);
		            				
                                	storeMarked = false;
                                	pollutionMarked = false;
                                	cctvMarked = false;
                                	
                                	$("#searchTable").css({"overflow-y":"auto", "height":"340px"});
		                            $("#searchResult").empty();
		                            
		                            $.each(data, function(index, vo) {
		                            	console.log(vo);
		                            	console.log("vo : "+vo);
		                            	console.log("rentMoney" + vo.rentMoney);
		                                let str = "<tr value="+vo.dong+"+"+vo.aptName+"+"+vo.jibun+" class='clickeTr'"+" no="+vo.no+" dong="+vo.dong+" aptName="+vo.aptName+" jibun="+vo.jibun+" code="+vo.code+ " rentMoney=" +vo.rentMoney+" dealAmount="+vo.dealAmount+">"
		                                +"<th scope='row'>"+vo.no+"</th>"
		                                +"<td>" + vo.aptName + "</td><td>"
		                                +"<button type='button'"+" no="+vo.no+" dong="+vo.dong+" aptName="+vo.aptName+" jibun="+vo.jibun+" code="+vo.code+ " rentMoney=" +vo.rentMoney+" dealAmount="+vo.dealAmount+ " dealDate='" + vo.dealYear+"년 "+vo.dealMonth + "월 "+vo.dealDay+"일' class='btn btn-secondary btn-sm detail' data-toggle='modal' data-target='#exampleModal'>자세히</button>"
		                                +"</td>"
		                                +"</tr>"
	                                	$("#searchResult").append(str);
		                            });//each
		            			},
		            			error:function(xhr,status,msg){
		            				console.log("상태값 : " + status + " Http에러메시지 : "+msg);
		            			}
		            		});
                    	} else { // 선택하지 않았다면
                    		alert('읍/면/동 을 확인해주세요!');
                    	}
                    }); // searchBtn
                    
                    // 업종 정보 버튼 클릭
                    $("#storeBtn").click(function() {
                    	if(!storeMarked) {
                    		console.log("주변 상가 버튼 클릭!");
                    		if($("#dong").val() !== "0") {
	                    		storeMarked = true;
	                    		console.log("주변 상가 표시!");
	                    		showStoreMarker($("#dong").val());
                    		} else {
                    			alert("읍/면/동 을 확인해주세요!");
                    		}
                    	}
                    }); // end storeBtn

					$("#pollutionBtn").click(function() {
                    	if(!pollutionMarked) {
                    		console.log("주변 대기오염 시설 버튼 클릭!");
                    		if($("#dong").val() !== "0") {
	                    		pollutionMarked = true;
	                    		console.log("대기오염 시설 정보 표시!");
	                    		showPollutionMarker($("#dong").val());
                    		} else {
                    			alert("읍/면/동 을 확인해주세요!");
                    		}
                    	}
                    }); // end pollutionBtn
                    
					$("#cctvBtn").click(function() {
                    	if(!cctvMarked) {
                    		console.log("주변 cctv 버튼 클릭!");
                    		if($("#dong").val() !== "0") {
	                    		cctvMarked = true;
	                    		console.log("cctv 표시!");
// 	                    		showCctv($("#dong").val());
								showCctvAll();
                    		} else {
                    			alert("읍/면/동 을 확인해주세요!");
                    		}
                    	}
                    }); // end cctvBtn
                    
                });//ready

            </script>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">타입</label>
                    <select class="form-control" id="type">
                        <option value="1">아파트 매매가</option>
                        <option value="2">주택 매매가</option>
                        <option value="3">아파트 전/월세</option>
                        <option value="4">주택 전/원세</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">시도</label>
                    <select class="form-control" id="sido">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">구군</label>
                    <select class="form-control" id="gugun">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3">
                <form class="form-inline">
                    <label class="pr-2">읍면동</label>
                    <select class="form-control" id="dong">
                        <option value="0">선택하세요</option>
                    </select>
                </form>
            </div>
            <div class="col-3 mt-2">
                <div class="input-group">
			      <input type="text" class="form-control" id="searchName" placeholder="아파트 이름" />
			      <div class="input-group-append">
			        <button class="btn btn-success" id="searchBtn">검색</button>
			      </div>
                </div>
            </div>
        </div>
       	
        <div class="row text-center d-flex justify-content-center">
            <div style="width: 320px">
				<div class="btn-group btn-group-toggle">
					<Button class="btn btn-light" type="button" id="storeBtn">주변 상가</Button>
					<Button class="btn btn-light" type="button" id="pollutionBtn">대기오염 시설</Button>
					<Button class="btn btn-light" type="button" id="cctvBtn">cctv</Button>
				</div>
				<div id="searchTable">
	                <table class="table table-striped" id="table1">
	                	<colgroup>
	                		<col width="20%"/>
	                		<col width="50%"/>
	                		<col width="30%"/>
	                	</colgroup>
	                    <thead>
	                        <tr>
	                            <th>번호</th>
	                            <th>아파트이름</th>
	                            <th>세부정보</th>
	                        </tr>
	                    </thead>
	                    <tbody id="searchResult">
	                        <tr>
	                            <th scope="row">1</th>
	                            <td>멀티캠퍼스</td>
	                            <td>
	                                <button type="button" class="btn btn-secondary btn-sm"
	                                    data-toggle="modal" data-target="#exampleModal">자세히</button>
	                            </td>
	                        </tr>
	                    </tbody>
	                </table>
				</div>
            </div>
            
            <div class="col-8">
            	<div class="text-right">
       				<Button class="btn btn-light" type="button" onclick="deleteMarkers()">마커 지우기</Button>
       			</div>
                <div id="map1" style="width: 100%; height: 340px; margin: auto;"></div>

            </div>
        </div>
    </div>
</section>
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1"
    role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">세부 거래 정보</h5>
                <button type="button" class="close" data-dismiss="modal"
                    aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-striped">
                    <tbody>
                        <tr>
                            <th scope="col">번호</th>
                            <td id="detailNum">0</td>
                        </tr>
                        <tr>
                            <th scope="col">법정동</th>
                            <td id="detailAddr">SSAFY</td>
                        </tr>
                        <tr>
                            <th scope="col">아파트이름</th>
                            <td id="detailName">멀티캠퍼스</td>
                        </tr>
                        <tr>
                            <th scope="col">지번</th>
                            <td id="detailAddr2">235</td>
                        </tr>
                        <tr>
                            <th scope="col">지역코드</th>
                            <td id="detailCode">132450</td>
                        </tr>
                        <tr>
                        	<th scope="col">가격</th>
                        	<td id="detailPrice">500000</td>
                        </tr>
                        <tr>
                        	<th scope="col">거래일자</th>
                        	<td id="detailDate">2020년 7월 7일</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary"
                    data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
</body>
<script defer src="https://maps.googleapis.com/maps/api/js?key=${GOOGLE_API_KEY}&callback=initMap"></script>
<script>

    var multi = {
        lat : 37.5012743,
        lng : 127.039585
    };
    var map;
    var markers = [];
    var infoWindow;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map1'), {
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
        
        addMarker(multimarker);
    }
    function handleLocationError(browserHasGeolocation, infoWindow, pos) {
        infoWindow.setPosition(pos);
        infoWindow.setContent(browserHasGeolocation ? 'Error: Geolocation 서비스 실패.' : 'Error: Geolocation을 지원하지 않는 브라우저.');
        infoWindow.open(map);
    }
    
    function addMarker2(props) {
        const marker = new google.maps.Marker({
            position : new google.maps.LatLng(parseFloat(props.coords.lat), parseFloat(props.coords.lng)),
            map : map,
//             label: props.name,
            title: props.name
        });

        if (props.iconImage) {
            marker.setIcon(props.iconImage);
        }

        marker.addListener('click', function() {
            map.setCenter(marker.getPosition());
			popInfoWindow(marker.getPosition(), props.content, marker);
        });
        markers.push(marker);
        setMapOnAll(map);
    }

    function addMarker(props) {
        const marker = new google.maps.Marker({
            position : new google.maps.LatLng(parseFloat(props.coords.lat), parseFloat(props.coords.lng)),
            map : map,
            title: props.name
        });
        
        map.setCenter(marker.getPosition());
        map.setZoom(15);

        if (props.iconImage) {
            marker.setIcon(props.iconImage);
        }

        marker.addListener('click', function() {
            map.setZoom(16);
            map.setCenter(marker.getPosition());
			popInfoWindow(marker.getPosition(), props.content, marker);
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
		storeMarked = false;
		pollutionMarked = false;
		cctvMarked = false;
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

    function popInfoWindow(latlng, content, marker){
    	var geocoder = new google.maps.Geocoder();
   		map.setCenter(latlng);
//     		addMarker(latlng);	//마커출력
   		geocoder.geocode({'latLng': latlng}, function(results, status) {
	    	if (status == google.maps.GeocoderStatus.OK) {
	    		if (results[1]) {
	    			var contentString =
	    				'<div id="content">'+
	    					'<br><div id=="adress">'+
	    					'<b>'+content+'</b>'+
	    					'<br></div>'+
	    					'<p>' +
	           				'<b>주소 :</b> ' +results[1].formatted_address+
	    					'</p>'+
	    				'</div>';
	    			infoWindow.setContent(contentString);
	    			infoWindow.open(map, marker);
	    		} else {
	    			alert("No results found");
	    		}
	    	}else{
    			alert("Geocoder failed due to: " + status);
    		}
    	});
    }

    $('#table1').on("click", ".clickeTr", function() {
//     	deleteMarkers();
		storeMarked = false;
		pollutionMarked = false;
		cctvMarked = false;
		
        var area = $(this).attr("value");
        console.log($(this).attr("no"));
        //console.log(area);
        $.get("https://maps.googleapis.com/maps/api/geocode/json", {
            key : '${GOOGLE_API_KEY}',
            address : area
        	}, function(data, status) {
            	console.log(data);
//             	deleteMarkers();
            	var officemarker = {
                	coords : {
                	    lat : data.results[0].geometry.location.lat,
                	    lng : data.results[0].geometry.location.lng
                	},
                	iconImage : null,
                	content : area,
                	name : $(this).attr("aptName")
            	};
            	console.log(officemarker);
            	addMarker(officemarker);
			}, "json");//get
        
//         showStoreMarker($(this).attr("dong"));
    });

    function showStoreMarker(dongVal) {
    	console.log(dongVal);
        // 상점
        $.get("${root}/store/list"
			,{dong:dongVal}
			,function(data, status){
				console.log("store!", data.length);
				$.each(data, function(index, vo) {
					let marker = {
						coords : {
							lat : vo.lat,
							lng : vo.lng
						},
						iconImage : "${root}/assets/img/store.png",
						content : vo.shopName,
						name : vo.shopName
					};
					addMarker2(marker);
				});//each
			}//function
			, "json"
		);//get
    }
    
    function showPollutionMarker(dongVal) {
    	console.log(dongVal);
        // 환경정보
        $.get("${root}/pollution/list"
			,{dong:dongVal}
            ,function(data, status){
             	console.log("pollution!", data.length);
                $.each(data, function(index, vo) {
                	let marker = {
                        coords : {
                        	lat : vo.lat,
                            lng : vo.lng
                        },
						iconImage : "${root}/assets/img/pollution_s.png",
                        content : vo.name,
                        name : vo.name
                    };
                	addMarker2(marker);
				});//each
             }//function
             , "json"
        );//get
    }
    
    function showCctv(dongVal) {
    	console.log(dongVal);
        // cctv
        $.get("${root}/cctv/search"
			,{dong:dongVal}
            ,function(data, status){
             	console.log("cctv!", data.length);
				$.each(data, function(index, cctv) {
					console.log(cctv);
					var circle = new google.maps.Circle({
					    center : new google.maps.LatLng(cctv.lat, cctv.lon),  // 원의 중심좌표 
					    radius: 40, // 미터 단위, 원의 반지름
					    strokeWeight: 3, // 선 두께
					    strokeColor: '#FDBACB', // 선 색깔
					    strokeOpacity: 0.7, // 선의 불투명도. 1에서 0 사이의 값으로 0에 가까울수록 투명
					    strokeStyle: 'none', // 선 스타일
					    fillColor: '#FDBACB', // 채우기 색깔
					    fillOpacity: 0.45  // 채우기 불투명도
					}); 
					markers.push(circle);
					circle.setMap(map);
				}); // each
             }//function
             , "json"
        );//get
    }
    
    function showCctvAll() {
        $.get("${root}/cctv/list"
            ,function(data, status){
             	console.log("cctv!", data.length);
				$.each(data, function(index, cctv) {
					console.log(cctv);
					var circle = new google.maps.Circle({
					    center : new google.maps.LatLng(cctv.lat, cctv.lon),  // 원의 중심좌표 
					    radius: 40, // 미터 단위, 원의 반지름
					    strokeWeight: 3, // 선 두께
					    strokeColor: '#FDBACB', // 선 색깔
					    strokeOpacity: 0.7, // 선의 불투명도. 1에서 0 사이의 값으로 0에 가까울수록 투명
					    strokeStyle: 'none', // 선 스타일
					    fillColor: '#FDBACB', // 채우기 색깔
					    fillOpacity: 0.45  // 채우기 불투명도
					}); 
					markers.push(circle);
					circle.setMap(map);
				}); // each
             }//function
             , "json"
        );//get
    }
    
    
    $('#table1').on("click", ".detail", function() {
        var no = $(this).attr("no");
        $("#detailNum").text(no);
        var dong = $(this).attr("dong");
        $("#detailAddr ").text(dong);
        var aptName = $(this).attr("aptName");
        $("#detailName").text(aptName);
        var jibun = $(this).attr("jibun");
        $("#detailAddr2 ").text(jibun);
        var code = $(this).attr("code");
        $("#detailCode").text(code);
        var price = "";
        console.log("aptname"+$(this).attr("aptName"));
        console.log("rentmoney"+$(this).attr("rentMoney"));
        console.log("dealamount"+$(this).attr("dealAmount"));
        if($(this).attr("rentMoney") == "null"){
        	price = $(this).attr("dealAmount");
        }
        else{
        	price = $(this).attr("rentMoney");	
        }
        $("#detailPrice").text(price);
        var dealDate = $(this).attr("dealDate");
        $("#detailDate").text(dealDate);
        
    });
</script>

