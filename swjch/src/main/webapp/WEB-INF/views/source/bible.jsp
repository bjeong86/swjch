<%@ include file="../common/taglib.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<head>
<title>수원중부교회</title>
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

</head>

<script type="text/javascript">
	$(document).ready(function() {

		getBibleByDay(${dayCount});
		
		$("#nowDay").val(${dayCount});
		
		$("#selectDay").change(function() {
			$("#nowDay").val($("#selectDay option:selected").val());
			getBibleByDay($("#selectDay option:selected").val());

		});
		
		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${pageContext.request.contextPath}/resources/img/swj/viewLoading.gif" />').appendTo(document.body).hide();
		$(window).ajaxStart(function() {
			loading.show();
		}).ajaxStop(function() {
			loading.hide();
		});

	});
	
	function readBible(){
		
		$.ajax({
			type : "POST",
			url : "/getKakaoTTS.json",
			dataType : "json",
			data : {
				"day" : $("#nowDay").val(),
			},
			success : function(data) {
				alert(data);

			},
			error : function(request, status, error) {
				
				alert(error);
				
			}
		});

	}
	

	
	function showSearchBible() {s
		$("#searchBible").slideToggle();
	}

	function showDailyBible() {
		$("#dailyBible").slideToggle();
	}
	
	function getBibleBf(){
		var nowDay = $("#nowDay").val()*1;
		var day = nowDay-1;
		if(day < 1 || day > 365){
			return;
		}		
		$("#nowDay").val(day);
		$("#bibleTitle").empty();
		$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+day+"일차</font></button><br>");
		getBibleByDay(day);
	}

	function getBibleAf(){
		var nowDay = $("#nowDay").val()*1;
		var day = nowDay+1;
		if(day < 1 || day > 365){
			return;
		}
		$("#nowDay").val(day);
		$("#bibleTitle").empty();
		$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+day+"일차</font></button><br>");
		getBibleByDay(day);
	}
	
	function getBibleToday(){
		$("#nowDay").val(${dayCount});
		$("#bibleTitle").empty();
		$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+${dayCount}+"일차</font></button><br>");
		getBibleByDay(${dayCount});
	}
	
	function getBibleSelect(){
		getBibleByDay($("#selectDay option:selected").val());
	}
	
	function setAudio(day){
		
		$("#audio").empty();
		
		$("#audio").append("<font size='4' color='white'>연대기말씀("+day+"일차) 음성으로 듣기</font><br>");
		$("#audio").append("<br>");
		
		if(day == 10 || day == 9){
			$("#audio").append('<audio src="${pageContext.request.contextPath}/resources/mp3/day_'+day+'_1.mp3" style="width: 97%" controls></audio><br><br>');
			$("#audio").append('<audio src="${pageContext.request.contextPath}/resources/mp3/day_'+day+'_2.mp3" style="width: 97%" controls></audio><br>');
		}else{
			$("#audio").append('<audio src="${pageContext.request.contextPath}/resources/mp3/day_'+day+'.mp3" style="width: 97%" controls></audio><br><br>');
		}
		
	}

	function getBibleByDay(day) {
		
		$("#bibleTitle").empty();
		$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+day+"일차</font></button><br>");

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getBibleByDay.json",
			dataType : "json",
			data : {
				"day" : day,
			},
			success : function(data) {
				setAudio(day);
				
				$("#bibleContents").empty();

				var bibleList = data["bibleContents"];
				var scheduleList = data["bibleSchedule"];
				var kakaoDesc = "";
				
				for (var i = 0; i < scheduleList.length; i++) {
					if(scheduleList[i].title == '시편'){
						if(scheduleList[i].sChapter != scheduleList[i].eChapter){
							$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+scheduleList[i].title +' '+ scheduleList[i].sChapter +' ~ '+scheduleList[i].eChapter+'편</font></button>');
							kakaoDesc += scheduleList[i].title +' '+ scheduleList[i].sChapter +' ~ '+scheduleList[i].eChapter+'편 ';
						}else{
							$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+scheduleList[i].title +' '+ scheduleList[i].sChapter + '편</font></button>');
							kakaoDesc += scheduleList[i].title +' '+ scheduleList[i].sChapter +'편 ';
						}
					}else{
						if(scheduleList[i].sChapter != scheduleList[i].eChapter){
							$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+scheduleList[i].title +' '+ scheduleList[i].sChapter +' ~ '+scheduleList[i].eChapter+'장</font></button>');
							kakaoDesc += scheduleList[i].title +' '+ scheduleList[i].sChapter +' ~ '+scheduleList[i].eChapter+'장 ';
						}else{
							$("#bibleTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">'+scheduleList[i].title +' '+ scheduleList[i].sChapter + '장</font></button>');
							kakaoDesc += scheduleList[i].title +' '+ scheduleList[i].sChapter +'장 ';
						}
					}
				}
				
				$("#kakaoMsg").val(kakaoDesc+'입니다.');
				
				for (var i = 0; i < bibleList.length; i++) {
					if (bibleList[i].verse == 1) {
						$("#bibleContents").append(
								'<br><font size="4" color="black"><b>' + bibleList[i].title
										+ ' ' + bibleList[i].chapter
										+ '장</b></font><br>');
					}
					$("#bibleContents").append(
							'<font size="4" color="black"><font size="2">'
									+ bibleList[i].verse + '</font>'
									+ bibleList[i].contents + '</font><br>');
				}

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});

	}
</script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	var Now = new Date();
	var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');
	var today = new Date().getDay();
	var todayLabel = week[today];

	var NowTime = '';
	if(${isToday}){
		NowTime += Now.getFullYear() + '년 ';
		NowTime += Now.getMonth() + 1;
		NowTime += '월 ' + Now.getDate() + '일 ';
		NowTime += todayLabel;
	}
	NowTime += ' 성경읽기는';
	//<![CDATA[
	// // 사용할 앱의 JavaScript 키를 설정해 주세요.
	// Kakao.init('29e7a3c5ee8cf7a79c5052c6b71c6ec4'); // local
	Kakao.init('34b1e6d89790af6e320e1806e42e48d6'); // swjch.org
	
	// // 카카오링크 버튼을 생성합니다. 처음 한번만 호출하면 됩니다.
	function sendLink() {
		Kakao.Link.sendDefault({
			objectType : 'feed',
			content : {
				title : '[' + $("#nowDay").val() + '일차] ' + NowTime,
				description : $("#kakaoMsg").val(),
				imageUrl : 'http://swjch.org/resources/img/swj/bible.jpg',
				link : {
					mobileWebUrl : 'http://swjch.org/bible.do?day='+$("#nowDay").val(),
					webUrl : 'http://swjch.org/bible.do?day='+$("#nowDay").val(),
				}
			},
			buttons : [ {
				title : '오늘 연대기 말씀 보기',
				link : {
					mobileWebUrl : 'http://swjch.org/bible.do?day='+$("#nowDay").val(),
					webUrl : 'http://swjch.org/bible.do?day='+$("#nowDay").val(),
				}
			} ]
		});
	}
	//]]>
</script>
<body class="grey lighten-3">
	<%@ include file="../common/header.jsp"%>

	<!--Contents layout-->
	<main class="pt-5 mx-lg-5">
	<div class="container-fluid">
		<!--(1)Grid row-->
		<input id="nowDay" type="hidden" value="" />
		<div class="row wow fadeIn">
			<!-- Grid column-->
			<div class="col-md-12 mb-1">

				<!--Card-->
				<div class="card #cfd8dc blue-grey lighten-4">

					<!-- Card header -->
					<div class="card-header" onclick="javascript:showSearchBible();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='3' color='black'><b>연대기성경</b></font>
						</h2>
						<!-- Section description -->
					</div>

					<!--Card content-->
					<div id="searchBible" class="card-body #fafafa grey lighten-5" style="display: block;">
						<!-- Horizontal Steppers -->
						<div class="row">
							<div class="col-md-12">
								<select id="selectDay" class="browser-default custom-select" style="width: 200px; font-size: 15px; float: right;">
									<option value="1">연대기 순서 검색</option>
									<c:forEach var="i" begin="1" end="365">
										<option value="${i}">${i}일차</option>
									</c:forEach>
								</select>
								<br> <br>
								<div class="btn-group" role="group" aria-label="Button group with nested dropdown" style="width: 100%">
									<button type="button" class="btn btn-sm #fafafa grey lighten-5" style="width: 30%" onclick="javascript:getBibleBf();">
										<font size='3' color='black'><b><<</b></font>
									</button>
									<button type="button" class="btn btn-sm #fafafa grey lighten-5" style="width: 60%" onclick="javascript:getBibleToday();">
										<c:if test="${isToday eq true }">
											<font size='2' color='black'><b>오늘말씀보기( ${dayCount }일차 )</b></font>
										</c:if>
										<c:if test="${isToday eq false }">
											<font size='2' color='black'><b> ${dayCount }일차 말씀보기</b></font>
										</c:if>
									</button>
									<button type="button" class="btn btn-sm #fafafa grey lighten-5" style="width: 30%" onclick="javascript:getBibleAf();">
										<font size='3' color='black'><b>>></b></font>
									</button>
								</div>
								<br> <br>
								<div id="searchResult" class="card " style="max-width: 100%; display: block;">
									<button type="button" class="btn btn-sm btn-unique" style="width: 98%">

										<div id="audio"></div>

										<br>
									</button>
									<div class="card-body">
										<div id="bibleTitle"></div>
										<div class="card-text">
											<div id="bibleContents"></div>
										</div>
										<input type="hidden" id="kakaoMsg" value="" />
									</div>
									<!-- 
									<a href="#" onclick="javascript:readBible();">...</a>
									 -->
									<button type="button" class="btn btn-sm btn-unique" style="width: 98%" onclick="javascript:sendLink();">
										<font size='2' color='white'>KAKAOTalk 공유</font>
									</button>
								</div>

							</div>
						</div>
						<!-- /.Horizontal Steppers -->
					</div>
				</div>
				<!--/.Card-->

			</div>
			<!--Grid column-->

		</div>
		<!--(1)Grid row-->

	</div>
	</main>
	<!--Contents layout-->

	<%@ include file="../common/footer.jsp"%>
</body>

</html>
