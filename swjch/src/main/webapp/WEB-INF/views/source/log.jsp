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

</head>
<script type="text/javascript">
	function showLog() {
		$("#showLog").slideToggle();
	}

	function showLog() {
		$("#showLogView").slideToggle();
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
				<div class="card #66bb6a green lighten-1">

					<!-- Card header -->
					<div class="card-header" onclick="javascript:showPlan();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='3' color='white'>로그요약</font>
						</h2>
						<!-- Section description -->
					</div>

					<!--Card content-->
					<div id="showLogView" class="card-body #fafafa grey lighten-5" style="display: block;">
						<!-- Horizontal Steppers -->
						<div class="row">
							<div class="col-md-12">
								<div id="searchResult" class="card border-success" style="max-width: 100%; display: block;">
									<div class="card-body">
										<c:forEach items="${logTotalViewList}" var="view" varStatus="status">			
											[ ${view.regdate}] ${view.url} [${view.count}]<br>
											</font>
										</c:forEach>
									</div>
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


		<!--(2)Grid row-->
		<input id="nowDay" type="hidden" value="" />
		<div class="row wow fadeIn">
			<!-- Grid column-->
			<div class="col-md-12 mb-1">

				<!--Card-->
				<div class="card #66bb6a green lighten-1">

					<!-- Card header -->
					<div class="card-header" onclick="javascript:showPlan();">
						<!-- Section heading -->
						<h2 class="h2-responsive font-weight-bold text-center my-1">
							<font size='3' color='white'>로그</font>
						</h2>
						<!-- Section description -->
					</div>

					<!--Card content-->
					<div id="showLog" class="card-body #fafafa grey lighten-5" style="display: block;">
						<!-- Horizontal Steppers -->
						<div class="row">
							<div class="col-md-12">
								<div id="searchResult" class="card border-success" style="max-width: 100%; display: block;">
									<div class="card-body">
										<c:forEach items="${logList}" var="log" varStatus="status">			
											[ ${log.regdate}] ${log.url} [${log.ip}]<br>
											</font>
										</c:forEach>


									</div>
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
		<!--(2)Grid row-->


	</div>
	</main>
	<!--Contents layout-->

	<%@ include file="../common/footer.jsp"%>
</body>

</html>
