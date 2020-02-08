<%@ include file="../common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
<title>한국브레들린지도</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="Health medical template project">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Font Awesome -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Bootstrap core CSS -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="${pageContext.request.contextPath}/resources/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="${pageContext.request.contextPath}/resources/css/style.min.css" rel="stylesheet">
<style>
.map-container {
	overflow: hidden;
	padding-bottom: 56.25%;
	position: relative;
	height: 0;
}

.map-container iframe {
	left: 0;
	top: 0;
	height: 100%;
	width: 100%;
	position: absolute;
}

/* 로딩*/
#loading {
	height: 100%;
	left: 0px;
	position: fixed;
	_position: absolute;
	top: 0px;
	width: 100%;
	filter: alpha(opacity = 50);
	-moz-opacity: 0.5;
	opacity: 0.5;
}

.loading {
	background-color: white;
	z-index: 199;
}

#loading_img {
	position: absolute;
	top: 50%;
	left: 50%;
	height: 35px;
	margin-top: -75px; //
	이미지크기 margin-left: -75px; //
	이미지크기 z-index: 200;
}
</style>
<style>
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 82px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 70px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 15px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 9px;
	color: #888;
	margin-top: -2px;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}
</style>

</head>

<script type="text/javascript">
	$(document).ready(function() {

		setMoimMap();

	});
</script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	
	Kakao.init('34b1e6d89790af6e320e1806e42e48d6'); // swjch.org:34b1e6d89790af6e320e1806e42e48d6 ,   local: 29e7a3c5ee8cf7a79c5052c6b71c6ec4
	
	// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
	function sendLink() {
		Kakao.Link.sendDefault({
			objectType : 'feed',
			content : {
				title : '대한민국 브레들린 교회의 위치를 볼 수 있습니다.',
				imageUrl : 'http://swjch.org/resources/img/swj/moimmap.png',
				link : {
					mobileWebUrl : 'http://swjch.org/moimmap.do',
					webUrl : 'http://swjch.org/moimmap.do',
				}
			},
			buttons : [ {
				title : '지도 보기',
				link : {
					mobileWebUrl : 'http://swjch.org/moimmap.do',
					webUrl : 'http://swjch.org/moimmap.do',
				}
			} ]
		});
	}
</script>
<script>
	function setMoimMap() {

		$.ajax({
			type : "POST",
			url : "/getMoimMap.json",
			dataType : "json",
			success : function(data) {

				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				mapOption = {
					center : new kakao.maps.LatLng(36.335525, 127.409561), // 지도의 중심좌표
					level : 13
				// 지도의 확대 레벨
				};

				var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

				// 마커를 표시할 위치와 title 객체 배열입니다 
				var positions = new Array();

				var moimList = data["moimmap"];

				for (var i = 0; i < moimList.length; i++) {

					var moim = {
						title : moimList[i].name,
						address : moimList[i].address,
						latlng : new kakao.maps.LatLng(moimList[i].longitude, moimList[i].latitude)
					}

					positions.push(moim);

				}

				// 마커 이미지의 이미지 주소입니다
				var imageSrc = "http://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

				var overlay = null;
				
				var markers = new Array();

				for (var i = 0; i < positions.length; i++) {

					// 마커 이미지의 이미지 크기 입니다
					var imageSize = new kakao.maps.Size(24, 35);

					// 마커 이미지를 생성합니다    
					var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map : map, // 마커를 표시할 지도
						position : positions[i].latlng, // 마커를 표시할 위치
						title : positions[i].title + '\n' + positions[i].address, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						image : markerImage, // 마커 이미지
						clickable : true
					// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
					});
					
					markers.push(marker);

					var content = '<div class="wrap">' 
								+ '    <div class="info">' 
								+ '        <div class="title">' 
								+ '            ' 
								+ positions[i].title 
								+ '        </div>' 
								+ '        <div class="body">' 
								+ '            <div class="desc">' 
								+ '                <div class="ellipsis">&nbsp;&nbsp;&nbsp;' 
								+ positions[i].address 
								+ '</div>' 
								+ '            </div>' 
								+ '        </div>' 
								+ '    </div>' 
								+ '</div>'; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

					overlay = new kakao.maps.CustomOverlay({
						content : content,
						map : map,
						position : marker.getPosition()
					});

					kakao.maps.event.addListener(marker, 'click', makeClickListener(map, marker, content));

					function makeClickListener(map, marker, content) {
						return function() {
							overlay.setPosition(marker.getPosition());
							overlay.setContent(content)
							overlay.setMap(map);
						};
					}
					
					
					kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
						overlay.setMap(null);
					});
					

					// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다
					overlay.setMap(null);

				}
				
				
				
			    // 마커 클러스터러를 생성합니다 
			    var clusterer = new kakao.maps.MarkerClusterer({
			        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
			        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
			        minLevel: 10 // 클러스터 할 최소 지도 레벨 
			    });
				
			    clusterer.addMarkers(markers);

			},
			error : function(request, status, error) {

				alert(error);

			}
		});

	}

	function closeOverlay(position) {
		alert('closeOverlay');

		var overlay = new kakao.maps.CustomOverlay({
			content : '',
			map : '',
			position : position
		});
		overlay.setMap(null);
	}
</script>


<body class="grey lighten-3">
	<!--Card content-->
	<header>

		<!--Navbar-->
		<nav class="navbar navbar-expand-lg #ffffff white">
			<!-- Navbar brand -->
			<a class="navbar-brand card-title h5 my-1" href="#">
				<font size='5' color='black'><strong>한국브레들린지도</strong></font><br>
				<font size='1' color='black'><strong>- '20.02.08 전국모임주소록 기준</strong></font><br>
				<font size='1' color='black'><strong>- 수정이 필요한 부분이나 기타 의견은 아래 주소로 부탁드립니다.</strong></font><br>
				<font size='1' color='black'><strong>- bjeong86@gmail.com    /   수원중부교회 박정훈</strong></font>
			</a>
			<button type="button" class="btn btn-sm btn-unique" style="width: 20%" onclick="javascript:sendLink();">
				<font size='1' color='white'>KAKAOTalk 공유</font>
			</button>
		</nav>
		<div id="map" style="width: 100%; height: 100%; position: relative;"></div>
		<!-- services와 clusterer, drawing 라이브러리 불러오기 -->
		<!-- local: 29e7a3c5ee8cf7a79c5052c6b71c6ec4 ,  swjch: 34b1e6d89790af6e320e1806e42e48d6 -->
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=34b1e6d89790af6e320e1806e42e48d6&libraries=services,clusterer,drawing"></script>
</body>

</html>
