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
</style>
</head>

<script type="text/javascript">
	$(document).ready(function() {
		
		// 연대기 성경 setting
		setBibleContents();

	});

	function openIntro() {
		$("#breth").hide();
		$("#intro").slideToggle();
	}

	function openBreth() {
		$("#intro").hide();
		$("#breth").slideToggle();
	}
	
	function showSentence() {
		$("#sentence").slideToggle();
	}	
	
	function showGallery() {
		$("#gallery").slideToggle();
	}	
	
	function showNews() {
		$("#news").slideToggle();
	}
	
	function showDailyBible(){
		$("#dailyBible").slideToggle();
	}
	
	function showRoute(){
		$("#route").slideToggle();
	}
	
	function showMovie(){
		$("#movie").slideToggle();
	}
	
	function setNewsModalValue(id){
		
		
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getMoimNewsById.json?id=" + id,
			dataType : "json",
			success : function(data) {
				$("#newsTitle").empty();
				$("#newsContents").empty();
				$("#newsLink").empty();
				
				var str = '<font size="3" color="white"><b>['+data["news"].regdate+'] '+data["news"].title+'</b></font>'
				
				$("#newsTitle").append(str.replace('New',''));
				$("#newsContents").append('<font size="3" color="black"><b>'+data["news"].contents+'</font>');
				$("#newsLink").append('<a class="btn #eceff1 blue-grey lighten-5 btn-sm active" href="'+data["news"].url+'" target="_blank"><font color="black"><b>더 자세한 내용 보기</b></font></a>');
				
				$("#centralModalLGInfoNews").modal();
				
			},
			error : function(request,status,error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	
	}
	
	
	function setBibleContents(){
		
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getBibleToday.json",
			dataType : "json",
			success : function(data) {
				$("#bibleContentsToday").empty();
				$("#bibleContentsYester").empty();
				$("#bibleContentsTommo").empty();
				$("dayCount").empty();
				
				var todayList = data["bibleContents"];
				var yesterList = data["bibleContentsBf"];
				var tommoList = data["bibleContentsAf"];
				var dayCount = data["dayCount"];
				
				$("#dayCount").append('( '+dayCount+' 일차 )');
			
				for(var i=0; i<todayList.length;i++){
					if(todayList[i].verse == 1){
						$("#bibleContentsToday").append('<br><font size="4" color="black"><b>'+todayList[i].title + ' ' + todayList[i].chapter+'장</b></font><br>');
					}
					$("#bibleContentsToday").append('<b><font size="3" color="black"><font size="1">'+ todayList[i].verse + '</font>' + todayList[i].contents +'</font><br></b>');
				}
				
				
				for(var i=0; i<yesterList.length;i++){
					if(yesterList[i].verse == 1){
						$("#bibleContentsYester").append('<br><font size="4" color="black"><b>'+yesterList[i].title + ' ' + yesterList[i].chapter+'장</b></font><br>');
					}
					$("#bibleContentsYester").append('<b><font size="3" color="black"><font size="1">'+ yesterList[i].verse + '</font>' + yesterList[i].contents +'</font><br></b>');
				}
				
				for(var i=0; i<tommoList.length;i++){
					if(tommoList[i].verse == 1){
						$("#bibleContentsTommo").append('<br><font size="4" color="black"><b>'+tommoList[i].title + ' ' + tommoList[i].chapter+'장</b></font><br>');
					}
					$("#bibleContentsTommo").append('<b><font size="3" color="black"><font size="1">'+ tommoList[i].verse + '</font>' + tommoList[i].contents +'</font><br></b>');
				}
				
				setGraph(dayCount);
				
			},
			error : function(request,status,error) {
				 alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	
	}
	
	function setGraph( dayCount ){
		
		var num = 365 - dayCount;
		
		// doughnut
		var ctxD = document.getElementById("doughnutChart").getContext('2d');
		var myLineChart = new Chart(ctxD, {
			type : 'doughnut',
			data : {
				labels : [ "읽은 날짜", "남은 날짜" ],
				datasets : [ {
					data : [ dayCount, num ],
					backgroundColor : [ "#e57373", "#b2dfdb" ],
					hoverBackgroundColor : [ "green", "#616774" ]
				} ]
			},
			options : {
				responsive : true
			}
		});
	}
	
</script>

<body class="grey lighten-3">
	<input type="hidden" id="isAdmin" value="${isAdmin }" />

	<%@ include file="../common/header.jsp"%>

	<!--Contents layout-->
	<main class="pt-5 mx-lg-3">
	<div class="container-fluid">

		<!--(1) Grid row -->
		<div class="row wow fadeIn">

			<!--Grid column-->
			<div class="col-md-9">

				<!-- Jumbotron -->
				<div class="card mb-2">

					<!-- Card image -->
					<div class="view overlay rounded-top f9fbe7 lime lighten-5">
						<img src="${pageContext.request.contextPath}/resources/img/swj/main2.jpg" class="img-fluid" alt="Sample image">
						<a href="#">
							<div class="mask rgba-white-slight"></div>
						</a>
					</div>

					<!-- Card content -->
					<div class="card-body text-center ">

						<!-- Title -->
						<h3 class="card-title h3 indigo-text">
							<strong><font size='3' color='black'>그리스도를 닮아 가는 교회</font></strong>
						</h3>
						<!-- Text -->
						<p class="card-text py-1 font-weight-bold">
							<font size='1'>하나님이 미리 아신 자들을 또한 그 아들의 형상을 본받게 하기 위하여 미리 정하셨으니 이는 그로 많은 형제 중에서 맏아들이 되게 하려 하심이니라.<br><br> 로마서 8장 29절
							</font>
						</p>
					</div>

				</div>
				<!-- Jumbotron -->

				<!-- Jumbotron -->
				<div class="card mb-2 #fafafa grey lighten-5">
					<div class="card-header" onclick="javascript:showSentence();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='2' color='black'><b>금주암송말씀</b></font>
						</h2>
					</div>

					<!-- Card content -->
					<div class="card-body text-center " id="sentence">
						<!-- Text -->
						<p class="card-text py-1 font-weight-bold">
							<font size='2'>하나님이 미리 아신 자들을 또한 그 아들의 형상을 본받게 하기 위하여 미리<br> 정하셨으니 이는 그로 많은 형제 중에서 맏아들이 되게 하려 하심이니라.<br> 로마서 8장 29절
							</font>
						</p>
					</div>

				</div>

			</div>
			<!--Grid column-->

			<!--Grid column-->
			<div class="col-md-3 mb-1 ">

				<!--Card-->
				<div class="card mb-2 #fafafa grey lighten-5">

					<!--Card content-->
					<div class="card-body">

						<!-- List group links -->
						<div class="list-group list-group-flush">
							<button class="list-group-item list-group-item-action waves-effect btn btn-unique btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalLGInfoIntro">
								<font size='2' color='black'>수원중부교회 소개</font>
							</button>
							<button class="list-group-item list-group-item-action waves-effect btn btn-unique btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalLGInfoBreth">
								<font size='2' color='black'>형제운동이란?</font>
							</button>
							<button class="list-group-item list-group-item-action waves-effect btn btn-unique btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalFluidSuccessSchedule">
								<font size='2' color='black'>집회일정</font>
							</button>
						</div>
						<!-- List group links -->

					</div>

					<!-- Central Modal Large Info-->
					<div class="modal fade" id="centralModalLGInfoIntro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
							<!--Content-->
							<div class="modal-content">
								<!--Header-->
								<div class="modal-header #66bb6a green lighten-1">
									<p class="heading lead indigo-text font-weight-bold">
										<font size='2' color='white'>수원중부교회 소개</font>
									</p>

									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true" class="white-text">&times;</span>
									</button>
								</div>

								<!--Body-->
								<div class="modal-body #fafafa grey lighten-5">
									<div class="text-center">
										<div style="text-align: left;">
											<font size='2'>
												<p>수원 중부 교회는 복음의 진리를 깨닫고 하나님의 자녀로 거듭난 그리스도인들의 교회으로서 사도행전과 서신서에 나타난 초대교회의 순전한 믿음을 본받아 계승 하기를 원하며19세기 초 영국의 더블린에서 7명의 형제들이 하나님의 은혜의 복음과 신약교회의 진리와 주님의 재림에 대한 소망 그리고 불타는 선교열을 가지고 모이기 시작하여 아일랜드, 영국 전역은 물론 프랑스, 이탈리아, 독일, 스위스, 스페인 등 유럽의 대부분 지역과 미국, 캐나다, 오스트레일리아, 뉴질랜드, 남아메리카, 아프리카, 중국, 인도, 아라비아 등 세계 전역에서 거의 동시에 일어난 형제운동(Brethren Movement)에 그 뿌리를 두고 있다.</p>
												<p>현재는 이와 같이 성경에서 말씀하시는 대로 모이며 교제하는 교회가 전국적으로 약 200여개 세워졌고, 약 9개국에 선교사들을 파송하여 세계선교를 수행하고 있다. 또한 미국, 캐나다 등에 한인지역교회들이 개척 되었으며, 우리와 같은 믿음을 따라 모이는 영국, 미국, 호주, 뉴질랜드, 싱가폴, 말레이시아, 대만, 일본 등 전세계 교회들과 교제를 나누고 있다. 선교기관으로는 엠마오 성경학교, 그리스도인 훈련원, 구도자 전도협회, 군 복음 선교회, 기독 대학 형제단, 예수 그리스도 전도협회, 자매선교회, 열린문 선교후원회, 선한 사마리아원, 전도출판사, 도서출판 미션하우스, 새생명의 사람들, 예수의 사람들 및 크리스찬 넷(Christian net)등이 있으며, 극동방송을 통하여 20여 년간 복음을 전하고 있다.</p>
												<p>하나님께 쓰임 받은 종들로는 성경학자로 근세의 터툴리안(Tertulianus)이라 불리우는 존 다비(J. N. Darby), 일생을 통해서 무수한 기도의 응답을 받았던 조지 뮐러(George Muller), 모세오경을 주석한 맥킨토쉬(C. H. Mackintosh), 수많은 주해를 썼고 다비의 저작 전집을 발행한 윌리엄 켈리(Willian Kelly), 다니엘서를 주해하여 예언서의 기초를 확립시켰던 앤더슨 경(Sir Robert Anderson), 원어에 탁월한 학자인 트레겔레스(S. P. Tregelles), 예언적 입장에서 교회사를 쓴 앤드류 밀러(Andrew Miller), 주해성경의 저자인 토마스 뉴베리(Thomas Newberry), 탁월한 교사요 저술가였던 에릭사우어(Erich Sauer), 완벽한 신구약 성구 사전을 출판한 위그람(George Vice Simus Wigram), 인도에서 주님만 의지하고 선교했던 그로브스(Anthony Noris Groves), 리빙스턴을 이어 아프리카에서 초교파적 선교에 헌신했던 프레드릭 아르놋(Frederick Stanley arnot), 캠브리지 7인 등 대학생들의 회심과 해외 선교 운동에 크고 놀라운 영향을 끼쳤으며, 미국 무디성경학교 설립자 무디(D. L. Moody)와 무어하우스(Henri Moorhouse), 영국이 낳은 세계적인 성경학자인 브루스(F. F. Bruce) 등 천여명의 교계 석학과 지도자들이 오직 주 예수 그리스도의 이름으로 신앙 양심과 성령의 인도하심을 따라 모이게 됨으로써 기독교계에 커다란 감동과 영향을 끼쳤다. 그리피스(Thomas Griffith)는 " 이 형제들이야 말로 하나님의 자녀 중에서 진리를 가장 바르게 해석한 사람들이었다"고 말했으며, 형제들과 함께 교제한 학자요 저술가였던 아이언사이드(H. A. Ironside)는 "하나님을 아는 사람들은 알든지 모르든지 직접적이든 간접적이든 형제들(Brethren)의 도움을 받지 않은 사람이없다"고
													했다.</p>
												<p>이 형제들은 에스라처럼 하나님의 말씀을 연구하고 준행하며, 가르치며, 선교하는 일에 전심전력하였다(스7:10)</p>
												<p>우리는 앞서간 형제들을 주 안에서 본받아 하나님의 말씀대로 오로지 성령의 인도하심을 따라 형제사랑으로 하나되어 우리 주 곧 구주 예수 그리스도를 중심으로 하나님 아버지를 섬기고자 한다.</p>
												<p>우리는 오직 그리스도의 사랑과 진리 안에서 그리스도에게 까지 자라가는 것을 성장의 목표로 삼으며, 그리스도가 나뉘시지 않았기 때문에 우리는 교단 명을 쓰는 것을 원하지 않으며, 오직 성경말씀의 가르침을 순종하고자 한다.</p>
											</font>
										</div>
									</div>
								</div>

							</div>
							<!--/.Content-->
						</div>
					</div>

					<!-- Central Modal Large Info-->
					<div class="modal fade" id="centralModalLGInfoBreth" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
							<!--Content-->
							<div class="modal-content">
								<!--Header-->
								<div class="modal-header #66bb6a green lighten-1">
									<p class="heading lead indigo-text font-weight-bold">
										<font size='2' color='white'>형제운동이란?</font>
									</p>

									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true" class="white-text">&times;</span>
									</button>
								</div>

								<!--Body-->
								<div class="modal-body #fafafa grey lighten-5">
									<div class="text-center">
										<div style="text-align: left;">
											<font size='2'>
												<p>19세기 초 영국제도에서 국교회의 개혁에 한계를 느끼고 국교회로부터의 분리 운동이 일어났다. 그 이유는 주로 유아세례, 성찬식, 장례식과 관련된교리적인 문제로, 그들은 분리 이후에 복음적인 독립교회를 세웠다. 이와같은 배경에서 1827년에 더블린에서 그로브스는 형제운동의 원리를 제안하였는데, 그것은 교파를 초월하여 성직자 없이 단순하게 모여서 떡을 떼는원리이다. 이러한 뜻을 가진 사람들이 모여들면서 자연스럽게 형제운동이일어나게 되었다. 그 중 1832년에 플리머스에서 교회가 빠르게 성장하여외부로 알려지면서 ‘플리머스 형제단’이라는 이름을 얻게 되었다. 같은 시기에 브리스톨의 조지 뮐러와 반스테플의 채프먼에 의해서도 동일한 기독교적 이상을 추구하는 교회가 세워지고 있었다. 이 운동은 선교적 열정을지닌 형제단에 의하여 곧 영국제도뿐 아니라 인도, 스페인, 스위스, 프랑스,독일 등 해외로도 빠르게 퍼져 나갔다.</p>
												<p>이 운동의 초기 확장에 큰 영향을 미쳤던 다비는 자신의 세대주의적 해석에 따라 신비주의적 ‘연합’과 ‘파멸된 교회론’을 주장하였다. 초기 형제운동에서 ‘연합’은 중요한 원리였는데, 다비는 ‘악으로부터의 분리’를 통한 연합을 주장하고, 그로브스는 ‘하나님의 공동체인 가족’으로서의 연합을 추구한다는 면에서 큰 차이점을 가지고 있다. 결국, 분리주의적인 다비의 교회론으로 인하여 형제운동은 1848년에 다비를 따르는 비개방적 형제단과 그로브스, 조지 뮐러, 채프먼을 중심으로 하는 개방적 형제단으로 나누어졌다. 그러나 분열 이후에도 형제단은 지속해서 발전하였다. 다비는 영국제도뿐 아니라 유럽 전역과 북미 지역에까지 찾아갔다. 그 결과 1882년 그가사망할 당시에 약 1,500개의 비개방적 형제단이 세워졌다. 비개방적 형제단은 다비의 죽음을 전후하여 1881년부터 또다시 분열을 거듭하여 여러분파로 나뉘게 되었다가 부분적으로 재결합하거나 일부가 개방적 형제단에 합류하기도 하였다.</p>
												<p>초기에는 비개방적 형제단이 우세하였으나 결국에는 개방적 형제단의 수가 훨씬 많아졌다. 개방적 형제단은 영국제도를 중심으로 지속적으로 퍼져나갔는데, 특히 1859년의 부흥을 통하여 수많은 지도자들이 형제운동에 합류하게 되어 영국제도 곳곳에 형제단 교회가 세워졌다. 해외로는 1829년 그로브스의 바그다드 선교를 기점으로 하여 스위스, 독일, 이탈리아 등 유럽 뿐만 아니라 미국과 캐나다, 남아메리카까지 뻗어 나갔다. 형제운동의선교에서 주목할 만한 곳으로 아프리카를 들 수 있는데, 여기에서는 목숨을 바친 선교사들에 의하여 수백 개의 교회가 세워졌다. 그 결과 전 세계 곳곳에 형제단에 의해서 세워진 교회들이 있다. 따라서 오늘날은 이 형제단이‘크리스찬 형제단(Christian Brethren)’으로 불리기도 한다.</p>
												<p>또한, 형제운동에서 특별히 주목해 보아야 할 점은 그들이 기독교계에 미친 영향이다. 그들은 비록 소수였지만 선교사역에서 중요한 역할을 담당하였고, 성경의 권위를 지켰으며 초교파적으로 영향을 미쳤다. 그리고 교리적인 면에서 볼 때 그들은 교회사에서 정통적으로 받아들이는 교리를 그대로믿고 있어서 역사적인 기독교 정통신앙을 굳게 붙잡고 있다. 실행적인 면에서는 침례와 매 주일 행하는 성찬식, 그리고 비성직자주의와 연합의 원리를가지고 있다.</p>
												<p>이러한 교회사적인 뿌리를 가진 형제운동이 한국에도 전파되어 오늘에이르게 된 것이다. 이 형제운동이 한국에서는 해외의 형제단에서 파송한 내한 선교사들의 지도로 1959년에 회심한 젊은이들을 중심으로 시작되었다.한국에는 현재 230개에 달하는 형제단 교회가 있고, 29명의 해외파송 선교사들이 여러 나라에서 선교하고 있다. 또한, 방송, 인쇄, 교육 등 다양한 기 관을 가지고 있고, 미국, 영국, 캐나다, 호주, 뉴질랜드, 독일, 일본, 대만,인도, 남미와 동남아시아 등 세계 여러 나라에 퍼져 있는 같은 신앙을 가진 형제단과 국제적인 교류를 하면서 타문화권 선교와 교육 선교에 협력하고 있다.</p>
												<p>- 형제운동의 기원과 발전 및 한국으로의 전래 中 발췌, 정인택br 성서교회 -</p>
											</font>
										</div>
									</div>
								</div>

							</div>
							<!--/.Content-->
						</div>
					</div>

					<!-- Central Modal Fluid Success-->
					<div class="modal fade" id="centralModalFluidSuccessSchedule" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg modal-notify modal-info" role="document">

							<!--Content-->
							<div class="modal-content">
								<!--Header-->
								<div class="modal-header #66bb6a green lighten-1">
									<p class="heading lead indigo-text font-weight-bold">
										<font size='2' color='white'>집회일정</font>
									</p>

									<button type="button" class="close" data-dismiss="modal" aria-label="Close">
										<span aria-hidden="true" class="white-text">&times;</span>
									</button>
								</div>
								<div>
									<!--Body-->
									<div class="modal-body #fafafa grey lighten-5">
										<ul class="nav nav-pills" id="pills-tab" role="tablist">
											<li class="nav-item"><a class="btn #eceff1 blue-grey lighten-5 btn-sm active" id="pills-sun-tab" data-toggle="pill" href="#pills-sun" role="tab" aria-controls="pills-sun" aria-selected="true">
													<font color='black'><b>일</b></font>
												</a></li>
											<li class="nav-item"><a class="btn #eceff1 blue-grey lighten-5 btn-sm" id="pills-tues-tab" data-toggle="pill" href="#pills-tues" role="tab" aria-controls="pills-tues" aria-selected="false">
													<font color='black'><b>화</b></font>
												</a></li>
											<li class="nav-item"><a class="btn #eceff1 blue-grey lighten-5 btn-sm" id="pills-wed-tab" data-toggle="pill" href="#pills-wed" role="tab" aria-controls="pills-wed" aria-selected="false">
													<font color='black'><b>수</b></font>
												</a></li>
											<li class="nav-item"><a class="btn #eceff1 blue-grey lighten-5 btn-sm" id="pills-fri-tab" data-toggle="pill" href="#pills-fri" role="tab" aria-controls="pills-fri" aria-selected="false">
													<font color='black'><b>금</b></font>
												</a></li>
											<li class="nav-item"><a class="btn #eceff1 blue-grey lighten-5 btn-sm" id="pills-sat-tab" data-toggle="pill" href="#pills-sat" role="tab" aria-controls="pills-sat" aria-selected="false">
													<font color='black'><b>토</b></font>
												</a></li>
										</ul>
										<div class="tab-content" id="pills-tabContent">
											<div class="tab-pane fade show active" id="pills-sun" role="tabpanel" aria-labelledby="pills-sun-tab">
												<table class="table table-striped btn-table">
													<thead>
														<tr>
															<th><b>시작</b></th>
															<th><b>종료</b></th>
															<th><b>프로그램</b></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>09:00</b></td>
															<td><b>10:30</b></td>
															<td><b>교회학교</b></td>
														</tr>
														<tr>
															<td><b>11:00</b></td>
															<td><b>12:00</b></td>
															<td><b>예 배</b></td>
														</tr>
														<tr>
															<td><b>12:00</b></td>
															<td><b>13:00</b></td>
															<td><b>말 씀</b></td>
														</tr>
														<tr>
															<td><b>13:00</b></td>
															<td><b>14:00</b></td>
															<td><b>애 찬</b></td>
														</tr>
														<tr>
															<td><b>14:30</b></td>
															<td><b>16:00</b></td>
															<td><b>특별활동</b></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="pills-tues" role="tabpanel" aria-labelledby="pills-tues-tab">
												<table class="table table-striped btn-table">
													<thead>
														<tr>
															<th><b>시작</b></th>
															<th><b>종료</b></th>
															<th><b>프로그램</b></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>10:30</b></td>
															<td><b>12:30</b></td>
															<td><b>자매회</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="pills-wed" role="tabpanel" aria-labelledby="pills-wed-tab">
												<table class="table table-striped  btn-table">
													<thead>
														<tr>
															<th><b>시작</b></th>
															<th><b>종료</b></th>
															<th><b>프로그램</b></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>20:00</b></td>
															<td><b>21:00</b></td>
															<td><b>말씀집회</b></td>
														</tr>
														<tr>
															<td><b>21:00</b></td>
															<td><b>22:00</b></td>
															<td><b>기도집회</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="pills-fri" role="tabpanel" aria-labelledby="pills-fri-tab">
												<table class="table table-striped  btn-table">
													<thead>
														<tr>
															<th><b>시작</b></th>
															<th><b>종료</b></th>
															<th><b>프로그램</b></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>20:00</b></td>
															<td><b>22:00</b></td>
															<td><b>양육반<br>가정집회
															</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
													</tbody>
												</table>
											</div>
											<div class="tab-pane fade" id="pills-sat" role="tabpanel" aria-labelledby="pills-sat-tab">
												<table class="table table-striped  btn-table">
													<thead>
														<tr>
															<th><b>시작</b></th>
															<th><b>종료</b></th>
															<th><b>프로그램</b></th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><b>19:00</b></td>
															<td><b>21:00</b></td>
															<td><b>청년부</b></td>
														</tr>
														<tr>
															<td><b>20:30</b></td>
															<td><b>21:30</b></td>
															<td><b>일꾼회의</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
														<tr>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
															<td><b>&nbsp;</b></td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/.Content-->

						</div>
					</div>
					<!-- Central Modal Fluid Success-->

				</div>
				<!--/.Card-->

				<!--Card-->
				<div class="card mb-2 #fafafa grey lighten-5">

					<!--Card content-->
					<div class="card-body">

						<!-- List group links -->
						<div class="list-group list-group-flush">
							<button class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" type="button" aria-haspopup="true" aria-expanded="false">
								<font size='2' color='black'><b>Site Links</b></font>
							</button>
							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>단체</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">
									<a class="dropdown-item indigo-text" href="http://www.cti.or.kr/" target="_blank">
										<font size='2' color='black'>CTI</font>
									</a>
									<a class="dropdown-item indigo-text" href="https:https://gntv.or.kr/main.php" target="_blank">
										<font size='2' color='black'>GNTV</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://timothy.or.kr/" target="_blank">
										<font size='2' color='black'>디모데학교</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://moimnews.or.kr/" target="_blank">
										<font size='2' color='black'>모임뉴스</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://sunhansaram.or.kr/" target="_blank">
										<font size='2' color='black'>선한사마리아</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.emmaus.or.kr/" target="_blank">
										<font size='2' color='black'>엠마오성경학교</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://omsc.or.kr/" target="_blank">
										<font size='2' color='black'>열린문선교후원회</font>
									</a>
								</div>
							</div>
							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>출판사</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/millstone4i" target="_blank">
										<font size='2' color='black'>밀스톤</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.jundo.co.kr/" target="_blank">
										<font size='2' color='black'>전도출판사</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/BrethrenHouse" target="_blank">
										<font size='2' color='black'>형제들의 집</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://blog.daum.net/phlegyas64" target="_blank">
										<font size='2' color='black'>형제출판사</font>
									</a>
								</div>
							</div>
							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>캠프기관</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/goldcamp" target="_blank">
										<font size='2' color='black'>경로캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/dreambible" target="_blank">
										<font size='2' color='black'>드림바이블캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/philachoir" target="_blank">
										<font size='2' color='black'>빌라델비아청소년캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/newlifecamp" target="_blank">
										<font size='2' color='black'>새생명새생활캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://ycc.camp/" target="_blank">
										<font size='2' color='black'>영남어린이캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://withbiblecamp.com/" target="_blank">
										<font size='2' color='black'>위드바이블캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://newnewlifecamp.wixsite.com/camp" target="_blank">
										<font size='2' color='black'>자연나라</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/jccamp" target="_blank">
										<font size='2' color='black'>전국청년연합캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.bibleclass.co.kr/" target="_blank">
										<font size='2' color='black'>청년사경회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/childcamp" target="_blank">
										<font size='2' color='black'>호남어린이캠프</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/hnscamp" target="_blank">
										<font size='2' color='black'>호남학생캠프</font>
									</a>
								</div>
							</div>
							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>서울/경기/강원/인천</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 서울 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.kangseochurch.org/" target="_blank">
										<font size='2' color='black'>강서중부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.rodem.net/" target="_blank">
										<font size='2' color='black'>구로교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://noryangjin.or.kr/home/" target="_blank">
										<font size='2' color='black'>노량진교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.mapomoim.or.kr/" target="_blank">
										<font size='2' color='black'>마포교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.schurch.or.kr/" target="_blank">
										<font size='2' color='black'>서대문교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.sdic.kr" target="_blank">
										<font size='2' color='black'>서울대학로교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://overcomer.or.kr/" target="_blank">
										<font size='2' color='black'>서울북부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/SeoulseobuA" target="_blank">
										<font size='2' color='black'>서울서부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.gojesus.co.kr/" target="_blank">
										<font size='2' color='black'>영등포교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 경기도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://gjchurch.or.kr/" target="_blank">
										<font size='2' color='black'>경기광주교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/gypr" target="_blank">
										<font size='2' color='black'>고양푸른교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.namsamoim.org/" target="_blank">
										<font size='2' color='black'>남사교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.dswch.org/" target="_blank">
										<font size='2' color='black'>동수원교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.bdch.or.kr/" target="_blank">
										<font size='2' color='black'>분당교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://www.nba.or.kr/" target="_blank">
										<font size='2' color='black'>분당북부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://blog.daum.net/sujichurch" target="_blank">
										<font size='2' color='black'>서수지교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://jesusfamily.net/default/" target="_blank">
										<font size='2' color='black'>성남수정교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://achurch.or.kr/" target="_blank">
										<font size='2' color='black'>유평교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.idwch.org/" target="_blank">
										<font size='2' color='black'>인덕원교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://joam.sujeong.kr/" target="_blank">
										<font size='2' color='black'>조암수정교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 강원도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/knassembly" target="_blank">
										<font size='2' color='black'>강릉교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/sokchochurch" target="_blank">
										<font size='2' color='black'>속초교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/yangyangassembly" target="_blank">
										<font size='2' color='black'>양양교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/wonju-church" target="_blank">
										<font size='2' color='black'>원주교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.lordcome.org/" target="_blank">
										<font size='2' color='black'>춘천교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 인천 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://icsongdo.com/g5/" target="_blank">
										<font size='2' color='black'>인천송도교회</font>
									</a>

								</div>
							</div>

							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>경상/광주/대전/충청</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 경상도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://geojemoim.com/" target="_blank">
										<font size='2' color='black'>거제교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://4000church.kr/newsnet/index.php" target="_blank">
										<font size='2' color='black'>사천교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.sghc.kr/" target="_blank">
										<font size='2' color='black'>서김해교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/jinjudongbuu" target="_blank">
										<font size='2' color='black'>진주동부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://cafe.naver.com/tymoim" target="_blank">
										<font size='2' color='black'>통영교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.xn--939ajxj96aztx.com/" target="_blank">
										<font size='2' color='black'>대구강북교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.dgnambu21.co.kr/" target="_blank">
										<font size='2' color='black'>대구남부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://xn--hc0bses4ro6k7nokgt.com/" target="_blank">
										<font size='2' color='black'>대구대명동교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://tmdong.com/" target="_blank">
										<font size='2' color='black'>대구중부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.moimnet.org/" target="_blank">
										<font size='2' color='black'>대구팔공로교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://happyss.modoo.at/" target="_blank">
										<font size='2' color='black'>성서행복한교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.usjungbu.or.kr/" target="_blank">
										<font size='2' color='black'>울산중부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 광주 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://xn--hc0bses4ro6k7nokgt.com/" target="_blank">
										<font size='2' color='black'>광주동부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 대전 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.naedongchurch.kr/" target="_blank">
										<font size='2' color='black'>대전내동교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://daedeok.org/" target="_blank">
										<font size='2' color='black'>대전대덕교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 충청도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.cjchristian.org/" target="_blank">
										<font size='2' color='black'>서청주교회</font>
									</a>

								</div>
							</div>

							<div class="dropdown">
								<button class="list-group-item list-group-item-action waves-effect btn #eceff1 blue-grey lighten-5 dropdown-toggle btn-sm" type="button" id="dropdownMenu5" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
									<font size='2' color='black'>부산/전라/제주/해외</font>
								</button>
								<div class="dropdown-menu" aria-labelledby="dropdownMenu5">

									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 부산 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.gudeok.busan.kr/" target="_blank">
										<font size='2' color='black'>구덕교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.iark.org/" target="_blank">
										<font size='2' color='black'>연제교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 전라도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.gimjechurch.co.kr/" target="_blank">
										<font size='2' color='black'>김제교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.namwonchurch.or.kr/" target="_blank">
										<font size='2' color='black'>남원서문교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/god4i" target="_blank">
										<font size='2' color='black'>정읍금붕교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.ongoeulch.or.kr/" target="_blank">
										<font size='2' color='black'>온고을송천교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://www.kirinro.co.kr/" target="_blank">
										<font size='2' color='black'>전주기린로교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 제주도 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://cafe.daum.net/hsbc9012" target="_blank">
										<font size='2' color='black'>한림서부교회</font>
									</a>
									<a class="dropdown-item indigo-text" href="#">
										<font size='2' color='black'>- - - 해외 - - -</font>
									</a>
									<a class="dropdown-item indigo-text" href="http://club.cyworld.com/burwood-glo" target="_blank">
										<font size='2' color='black'>시드니 버우드교회(호주)</font>
									</a>
									<a class="dropdown-item indigo-text" href="https://www.washingtonmoim.com/" target="_blank">
										<font size='2' color='black'>워싱턴교회(미국)</font>
									</a>

								</div>
							</div>

						</div>
						<!-- List group links -->

					</div>

				</div>
				<!--/.Card-->

				<!--Card-->
				<div class="card mb-1  #fafafa grey lighten-5">

					<!--Card content-->
					<div class="card-body">

						<!-- List group links -->
						<button class="list-group-item list-group-item-action waves-effect btn btn-dark btn-sm" type="button">
							Today&nbsp;&nbsp;<font size='2'>${todayVisitor }</font><br>Total&nbsp;&nbsp;<font size='2'>${totalVisitor }</font>
						</button>
					</div>
					<!-- List group links -->

				</div>

			</div>
			<!--/.Card-->

		</div>
		<!--Grid column-->
		<!--(1) Grid row-->
		<!-- Central Modal Large Info-->
		<div class="row wow fadeIn ">

			<!--Grid column-->
			<div class="col-md-12 mb-2 ">
				<!--Card-->
				<div class="card">
					<div class="card-header" onclick="javascript:showGallery();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='2' color='black'><b>갤러리</b></font>
						</h2>
					</div>
					<!--Card content-->
					<div class="card-body" id="gallery">
						<!-- Section: Testimonials v.2 -->
						<section class="text-center">

							<div class="wrapper-carousel-fix">
								<!-- Carousel Wrapper -->
								<div id="carousel-example-1" class="carousel no-flex testimonial-carousel slide carousel-fade" data-ride="carousel" data-interval="false">
									<!--Slides-->
									<div class="carousel-inner" role="listbox">
										<!--First slide-->
										<div class="carousel-item active">
											<div class="testimonial">
												<!--Avatar-->
												<div class="avatar mx-auto mb-1">
													<!-- Grid row -->
													<div class="row">
														<!-- Grid column -->
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_1.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_2.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_3.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--First slide-->
										<!--Second slide-->
										<div class="carousel-item">
											<div class="testimonial">
												<!--Avatar-->
												<div class="avatar mx-auto mb-1">
													<!-- Grid row -->
													<div class="row">
														<!-- Grid column -->
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_4.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_5.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_6.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--Second slide-->
										<!--Third slide-->
										<div class="carousel-item">
											<div class="testimonial">
												<!--Avatar-->
												<div class="avatar mx-auto mb-1">
													<!-- Grid row -->
													<div class="row">
														<!-- Grid column -->
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_7.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_8.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_9.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--Third slide-->
										<!--Second slide-->
										<div class="carousel-item">
											<div class="testimonial">
												<!--Avatar-->
												<div class="avatar mx-auto mb-1">
													<!-- Grid row -->
													<div class="row">
														<!-- Grid column -->
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_10.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_11.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_12.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--Second slide-->
										<!--Second slide-->
										<div class="carousel-item">
											<div class="testimonial">
												<!--Avatar-->
												<div class="avatar mx-auto mb-1">
													<!-- Grid row -->
													<div class="row">
														<!-- Grid column -->
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_13.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_14.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
														<div class="col-lg-4 col-md-12">
															<img src="${pageContext.request.contextPath}/resources/img/swj/sub_15.jpg" class="rounded" height='300px' alt="First sample avatar image"> <br> <br>
														</div>
													</div>
												</div>
											</div>
										</div>
										<!--Second slide-->
									</div>
									<!--Slides-->
									<!--Controls-->
									<a class="carousel-control-prev left carousel-control" href="#carousel-example-1" role="button" data-slide="prev">
										<i class="fas fa-angle-double-left fa-5x"></i><span class="icon-prev" aria-hidden="true"></span> <span class="sr-only">Previous</span>
									</a>
									<a class="carousel-control-next right carousel-control" href="#carousel-example-1" role="button" data-slide="next">
										<i class="fas fa-angle-double-right fa-5x"></i><span class="icon-next" aria-hidden="true"></span> <span class="sr-only">Next</span>
									</a>
									<!--Controls-->
								</div>
								<!-- Carousel Wrapper -->
							</div>
						</section>
						<!-- Section: Testimonials v.2 -->
					</div>
				</div>

			</div>
		</div>
		<!--(2) Grid row-->
		<!-- Central Modal Large Info-->
		<div class="modal fade" id="centralModalLGInfoNews" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
				<!--Content-->
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header #66bb6a green lighten-1">
						<p class="heading lead indigo-text font-weight-bold">
						<div id="newsTitle"></div>
						</p>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="white-text">&times;</span>
						</button>
					</div>

					<!--Body-->
					<div class="modal-body #fafafa grey lighten-5">
						<div class="text-center">
							<div style="text-align: left;">
								<div id="newsContents"></div>
								<div id="newsLink"></div>
							</div>
						</div>
					</div>
				</div>
				<!--/.Content-->
			</div>
		</div>

		<!-- Central Modal Large Info-->
		<div class="row wow fadeIn ">

			<!--Grid column-->
			<div class="col-md-12 mb-2 ">
				<!--Card-->
				<div class="card">
					<!-- Card header -->
					<div class="card-header" onclick="javascript:showNews();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='2' color='black'><b>모임뉴스</b></font>
						</h2>
						<!-- Section description -->
					</div>
					<div id="news" class="card-body #fafafa grey lighten-5">
						<!-- Grid row -->
						<div class="row">

							<!-- Grid column -->
							<div class="col-lg-3 col-md-3 mb-lg-0 mb-3">

								<!-- Image -->
								<button class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" type="button" aria-haspopup="true" aria-expanded="false">
									<center>
										<i class="fas fa-book-open fa-1x"></i>&nbsp;&nbsp;&nbsp;<font size='2' color='black'>집회소식</font>
									</center>
								</button>
								<c:forEach items="${sermonList}" var="sermon" varStatus="status">
									<!-- Small news -->
									<div class="single-news mb-1">
										<!-- Title -->
										<div class="d-flex justify-content-between" onclick="javasript:setNewsModalValue(${sermon.id})">
											<div class="col-11 text-truncate pl-0 mb-1">
												<c:set var="string1" value="${sermon.title}" />
												<c:set var="string2" value="${fn:replace(string1, 'New', '')}" />
												<a>
													<font size='2'>&nbsp;&nbsp;&nbsp;&nbsp;${sermon.regdate}</font>&nbsp;<font size='2'> ${string2}</font>
												</a>
											</div>
											<a>
												<i class="fas fa-angle-double-right"></i>&nbsp;&nbsp;
											</a>
										</div>

									</div>
									<!-- Small news -->
								</c:forEach>

							</div>
							<!-- Grid column -->

							<!-- Grid column -->
							<div class="col-lg-3 col-md-3 mb-md-0 mb-3">

								<button class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" type="button" aria-haspopup="true" aria-expanded="false">
									<center>
										<i class="fas fa-bible fa-1x"></i>&nbsp;&nbsp;&nbsp;<font size='2' color='black'>지역교회/선교</font>
									</center>
								</button>

								<c:forEach items="${localList}" var="local" varStatus="status">
									<!-- Small news -->
									<div class="single-news mb-1">
										<!-- Title -->
										<div class="d-flex justify-content-between" onclick="javasript:setNewsModalValue(${local.id})">
											<div class="col-11 text-truncate pl-0 mb-1">
												<c:set var="string1" value="${local.title}" />
												<c:set var="string2" value="${fn:replace(string1, 'New', '')}" />
												<a>
													<font size='2'>&nbsp;&nbsp;&nbsp;&nbsp;${local.regdate}</font>&nbsp;<font size='2'> ${string2}</font>
												</a>
											</div>
											<a>
												<i class="fas fa-angle-double-right"></i>&nbsp;&nbsp;
											</a>
										</div>

									</div>
									<!-- Small news -->
								</c:forEach>

							</div>
							<!-- Grid column -->

							<!-- Grid column -->
							<div class="col-lg-3 col-md-3 mb-0 mb-3">

								<button class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" type="button" aria-haspopup="true" aria-expanded="false">
									<center>
										<i class="fas fa-archway fa-1x"></i>&nbsp;&nbsp;&nbsp;<font size='2' color='black'>교육/훈련</font>
									</center>
								</button>

								<c:forEach items="${eduList}" var="edu" varStatus="status">
									<!-- Small news -->
									<div class="single-news mb-1">
										<!-- Title -->
										<div class="d-flex justify-content-between" onclick="javasript:setNewsModalValue(${edu.id})">
											<div class="col-11 text-truncate pl-0 mb-1">
												<c:set var="string1" value="${edu.title}" />
												<c:set var="string2" value="${fn:replace(string1, 'New', '')}" />
												<a>
													<font size='2'>&nbsp;&nbsp;&nbsp;&nbsp;${edu.regdate}</font>&nbsp;<font size='2'> ${string2}</font>
												</a>
											</div>
											<a>
												<i class="fas fa-angle-double-right"></i>&nbsp;&nbsp;
											</a>
										</div>

									</div>
									<!-- Small news -->
								</c:forEach>

							</div>
							<!-- Grid column -->

							<!-- Grid column -->
							<div class="col-lg-3 col-md-3 mb-0 mb-3">

								<button class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" type="button" aria-haspopup="true" aria-expanded="false">
									<center>
										<i class="fas fa-bullhorn fa-1x"></i>&nbsp;&nbsp;&nbsp;<font size='2' color='black'>경조사</font>
									</center>
								</button>

								<c:forEach items="${joyList}" var="joy" varStatus="status">
									<!-- Small news -->
									<div class="single-news mb-1">
										<!-- Title -->
										<div class="d-flex justify-content-between" onclick="javasript:setNewsModalValue(${joy.id})">
											<div class="col-11 text-truncate pl-0 mb-1">
												<c:set var="string1" value="${joy.title}" />
												<c:set var="string2" value="${fn:replace(string1, 'New', '')}" />
												<a>
													<font size='2'>&nbsp;&nbsp;&nbsp;&nbsp;${joy.regdate}</font>&nbsp;<font size='2'> ${string2}</font>
												</a>
											</div>
											<a>
												<i class="fas fa-angle-double-right"></i>&nbsp;&nbsp;
											</a>
										</div>

									</div>
									<!-- Small news -->
								</c:forEach>

							</div>
							<!-- Grid column -->

						</div>
						<!-- Grid row -->
					</div>

					<!-- Section: Magazine v.3 -->
				</div>
			</div>

		</div>
		<!--(2) Grid row-->

		<!--(3) Grid row-->
		<!-- Central Modal Large Info-->
		<div class="modal fade" id="centralModalLGInfoBibleToday" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
				<!--Content-->
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header #66bb6a green lighten-1">
						<p class="heading lead indigo-text font-weight-bold">
							<font size='2' color="white">오늘 연대기 말씀 보기</font>
						</p>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="white-text">&times;</span>
						</button>
					</div>

					<!--Body-->
					<div class="modal-body #fafafa grey lighten-5">
						<div class="text-center">
							<div style="text-align: left;">
								<div id="bibleContentsToday"></div>
							</div>
						</div>
					</div>
				</div>
				<!--/.Content-->
			</div>
		</div>
		<!-- Central Modal Large Info-->
		<!-- Central Modal Large Info-->
		<div class="modal fade" id="centralModalLGInfoBibleYester" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
				<!--Content-->
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header #66bb6a green lighten-1">
						<p class="heading lead indigo-text font-weight-bold">
							<font size='2' color="white">어제 연대기 말씀 보기</font>
						</p>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="white-text">&times;</span>
						</button>
					</div>

					<!--Body-->
					<div class="modal-body #fafafa grey lighten-5">
						<div class="text-center">
							<div style="text-align: left;">
								<div id="bibleContentsYester"></div>
							</div>
						</div>
					</div>
				</div>
				<!--/.Content-->
			</div>
		</div>
		<!-- Central Modal Large Info-->
		<!-- Central Modal Large Info-->
		<div class="modal fade" id="centralModalLGInfoBibleTommo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg modal-notify modal-info" role="document">
				<!--Content-->
				<div class="modal-content">
					<!--Header-->
					<div class="modal-header #66bb6a green lighten-1">
						<p class="heading lead indigo-text font-weight-bold">
							<font size='2' color="white">내일 연대기 말씀 보기</font>
						</p>

						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="white-text">&times;</span>
						</button>
					</div>

					<!--Body-->
					<div class="modal-body #fafafa grey lighten-5">
						<div class="text-center">
							<div style="text-align: left;">
								<div id="bibleContentsTommo"></div>
							</div>
						</div>
					</div>
				</div>
				<!--/.Content-->
			</div>
		</div>
		<!-- Central Modal Large Info-->
		<div class="row wow fadeIn">

			<!--Grid column-->
			<div class="col-md-6 mb-2">

				<!--Card-->
				<div class="card">

					<!-- Card header -->
					<div class="card-header" onclick="javascript:showDailyBible();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='2' color='black'><b>연대기성경</b></font>
						</h2>
						<!-- Section description -->
					</div>

					<!--Card content-->
					<div id="dailyBible" class="card-body #fafafa grey lighten-5">
						<!-- List group links -->
						<div class="list-group list-group-flush">
							<a class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalLGInfoBibleToday">
								<font size='2' color='black'><b><div id="dayCount">오늘 말씀 보기</b>
						</div>
						</font>
						</a>
						<a class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalLGInfoBibleYester">
							<font size='2' color='black'>어제 말씀 보기</font>
						</a>
						<a class="list-group-item list-group-item-action waves-effect btn btn-sm #eceff1 blue-grey lighten-5" data-toggle="modal" data-target="#centralModalLGInfoBibleTommo">
							<font size='2' color='black'>내일 말씀 보기</font>
						</a>
					</div>
					<br>
					<!-- List group links -->
					<canvas id="doughnutChart"></canvas>
				</div>

			</div>
			<!--/.Card-->

		</div>
		<!--Grid column-->

		<!--Grid column-->
		<div class="col-md-6 mb-2">

			<!--Card-->
			<div class="card">

				<!-- Card header -->
				<div class="card-header" onclick="javascript:showRoute();">
					<!-- Section heading -->
					<h2 class="h2-responsive font-weight-bold text-center my-1">
						<font size='2' color='black'><b>찾아오시는길</b></font>
					</h2>
					<!-- Section description -->
				</div>

				<!--Card content-->
				<div id="route" class="card-body #fafafa grey lighten-5">
					<!--Google map-->
					<div id="map-container-google-2" class="z-depth-1-half map-container" style="height: 500px">
						<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3173.991018923548!2d127.0050839156934!3d37.29534667984956!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b5cd024e33fe1%3A0xf5ebd5548c0ca8c9!2z6rK96riw64-EIOyImOybkOyLnCDsnqXslYjqtawg7KCV7J6QMuuPmSDshqHsoJXroZw5MOuyiOq4uCAz!5e0!3m2!1sko!2skr!4v1566596028604!5m2!1sko!2skr" frameborder="0" style="border: 0" allowfullscreen></iframe>
					</div>
				</div>

			</div>
			<!--/.Card-->

		</div>
		<!--Grid column-->

	</div>
	<!--(3) Grid row--> <!--(4) Grid row-->
	<div class="row wow fadeIn">

		<!--Grid column-->
		<div class="col-md-12 mb-2">
			<!--Card-->
			<div class="card">
				<!-- Section: Magazine v.3 -->
				<div class="card-header" onclick="javascript:showMovie();">
					<!-- Section heading -->
					<h2 class="h2-responsive font-weight-bold text-center my-1">
						<font size='2' color='black'><b>말씀영상</b></font>
					</h2>
				</div>
				<div id="movie" class="card-body #fafafa grey lighten-5">
					<!-- Grid row -->
					<div class="row">
						<!-- Section: Social card with video-->
						<!-- Grid column -->
						<div class="col-md-3 col-lg-3 mb-1">

							<!-- Card -->
							<div class="card news-card">

								<!-- Card video-->
								<div class="embed-responsive embed-responsive-1by1">
									<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/659HqOv9nTk" allowfullscreen></iframe>
								</div>

								<!-- Card content -->
								<div class="card-body #eceff1 blue-grey lighten-5">
									<font size='2' color='black'>#성경적신앙생활1</font><br> <font size='2' color='black'>송찬호</font>
								</div>
								<!-- Card content -->
							</div>
							<!-- Card -->

						</div>
						<!-- Grid column -->
						<!-- Grid column -->
						<div class="col-md-3 col-lg-3 mb-1">

							<!-- Card -->
							<div class="card news-card">

								<!-- Card video-->
								<div class="embed-responsive embed-responsive-1by1">
									<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/iq65CCdQSYY" allowfullscreen></iframe>
								</div>

								<!-- Card content -->
								<div class="card-body #eceff1 blue-grey lighten-5">
									<font size='2' color='black'>#성경적신앙생활2</font><br> <font size='2' color='black'>송찬호</font>
								</div>
								<!-- Card content -->
							</div>
							<!-- Card -->

						</div>
						<!-- Grid column -->
						<!-- Grid column -->
						<div class="col-md-3 col-lg-3 mb-1">

							<!-- Card -->
							<div class="card news-card">

								<!-- Card video-->
								<div class="embed-responsive embed-responsive-1by1">
									<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/uYk5FssUu18" allowfullscreen></iframe>
								</div>

								<!-- Card content -->
								<div class="card-body #eceff1 blue-grey lighten-5">
									<font size='2' color='black'>#성경적신앙생활3</font><br> <font size='2' color='black'>송찬호</font>
								</div>
								<!-- Card content -->
							</div>
							<!-- Card -->

						</div>
						<!-- Grid column -->
						<!-- Grid column -->
						<div class="col-md-3 col-lg-3 mb-1">

							<!-- Card -->
							<div class="card news-card">

								<!-- Card video-->
								<div class="embed-responsive embed-responsive-1by1">
									<iframe class="embed-responsive-item" src="https://www.youtube.com/embed/uSPLz40lF0I" allowfullscreen></iframe>
								</div>

								<!-- Card content -->
								<div class="card-body #eceff1 blue-grey lighten-5">
									<font size='2' color='black'>#성경적신앙생활4</font><br> <font size='2' color='black'>송찬호</font>
								</div>
								<!-- Card content -->
							</div>
							<!-- Card -->

						</div>
						<!-- Grid column -->
						<!-- Section: Social card with video-->
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--(4) Grid row-->

	</div>
	</main>
	<!--Contents layout-->

	<%@ include file="../common/footer.jsp"%>
</body>

</html>
