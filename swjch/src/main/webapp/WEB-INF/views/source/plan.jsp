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

		var Now = new Date();
		var year = new Date().getFullYear();

		getPlanByYear(year);

		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${pageContext.request.contextPath}/resources/img/swj/viewLoading.gif" />').appendTo(document.body).hide();
		$(window).ajaxStart(function() {
			loading.show();
		}).ajaxStop(function() {
			loading.hide();
		});

		setYear();

		$("#selectYear").change(function() {
			getPlanByYear($("#selectYear option:selected").val());

		});

	});

	// select box 연도 표시
	function setYear() {
		var dt = new Date();
		var now_year = dt.getFullYear();
		for (var y = now_year; y >= (now_year - 3); y--) {
			if (y == now_year) {
				$("#selectYear").append('<option value='+ y +' selected>' + y + '년</option>');
			} else {
				$("#selectYear").append('<option value='+ y +' >' + y + '년</option>');
			}
		}
	}

	function showPlan() {
		$("#showPlan").slideToggle();
	}

	function getPlanByYear(year) {

		$("#planTitle").empty();

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getPlanByYear.json",
			dataType : "json",
			data : {
				"year" : year,
			},
			success : function(data) {
				$("#planContents").empty();

				var planList = data["planInfo"];

				for (var i = 0; i < planList.length; i++) {
					$("#planTitle").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm"><font size="2" color="black">' + planList[i].title + '</font></button>');
				}

				for (var i = 0; i < planList.length; i++) {
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">1월 :: January</font><br><br><font size="2" color="black">' + planList[i].month_1 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">2월 :: Feburary</font><br><br><font size="2" color="black">' + planList[i].month_2 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">3월 :: March</font><br><br><font size="2" color="black">' + planList[i].month_3 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">4월 :: April</font><br><br><font size="2" color="black">' + planList[i].month_4 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">5월 :: May</font><br><br><font size="2" color="black">' + planList[i].month_5 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">6월 :: June</font><br><br><font size="2" color="black">' + planList[i].month_6 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">7월 :: July</font><br><br><font size="2" color="black">' + planList[i].month_7 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">8월 :: August</font><br><br><font size="2" color="black">' + planList[i].month_8 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">9월 :: September</font><br><br><font size="2" color="black">' + planList[i].month_9 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">10월 :: October</font><br><br><font size="2" color="black">' + planList[i].month_10 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">11월 : November</font><br><br><font size="2" color="black">' + planList[i].month_11 + '</font></button><br>');
					$("#planContents").append('<button type="button" class="btn btn-outline-default waves-effect btn-sm" style="text-align:left;width:100%;"><font size="4" color="black">12월 : December</font><br><br><font size="2" color="black">' + planList[i].month_12 + '</font></button><br>');
				}

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});

	}
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
					<div class="card-header" onclick="javascript:showPlan();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='3' color='black'><b>연간계획</b></font>
						</h2>
						<!-- Section description -->
					</div>

					<!--Card content-->
					<div id="showPlan" class="card-body #fafafa grey lighten-5" style="display: block;">
						<!-- Horizontal Steppers -->
						<div class="row">
							<div class="col-md-12">
								<select id="selectYear" class="browser-default custom-select" style="width: 100px; font-size: 15px; float: right;">
								</select>
								<br> <br>
								<div id="planTitle"></div>
								<div class="card-text">
									<div id="planContents"></div>
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
