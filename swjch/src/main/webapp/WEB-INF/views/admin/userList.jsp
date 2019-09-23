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

		getUserListByMonth();

		$("#selectMonth").change(function() {
			getUserListByMonth();
		});

		$("#keyword").keypress(function(e) {
			if (e.keyCode == 13) {
				getUserListByKeyword();
			}
		});
		
		var loading = $('<div id="loading" class="loading"></div><img id="loading_img" alt="loading" src="${pageContext.request.contextPath}/resources/img/swj/viewLoading.gif" />').appendTo(document.body).hide();
		$(window).ajaxStart(function() {
			loading.show();
		}).ajaxStop(function() {
			loading.hide();
		});

	});

	function getUserListByMonth() {

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getUserListbyMonth.json",
			dataType : "json",
			data : {
				"month" : $("#selectMonth").val(),
			},
			success : function(data) {
				$("#userList").empty();

				var innerHtml = '';

				var userList = data["userList"];

				innerHtml += "<table id='dtBasicExample' class='table table-striped table-bordered' bgcolor='white' cellspacing='0' width='100%' style='text-align: center;'>";

				innerHtml += "<thead>";
				innerHtml += "<tr>";
				innerHtml += "<th class='th-sm'><b>이름</b></th>";
				innerHtml += "<th class='th-sm'><b>양력</b></th>";
				innerHtml += "<th class='th-sm'><b>음력</b></th>";
				innerHtml += "<th class='th-sm'><b>연락처</b></th>";
				innerHtml += "</tr>";
				innerHtml += "</thead>";
				innerHtml += "<tbody>";
				for (var i = 0; i < userList.length; i++) {
					innerHtml += "<tr>";
					if (userList[i].isMoon) {

						innerHtml += "<td><a onclick='javascript:getFamilyById(" + userList[i].id + ");'><font color='black'><b>" + userList[i].name + "</b></font></a></td>";
						innerHtml += "<td><font color='black'><b>" + userList[i].month_moon + "월" + userList[i].day_moon + "일</b></font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].month + "월" + userList[i].day + "일</font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					} else {

						innerHtml += "<td><a onclick='javascript:getFamilyById(" + userList[i].id + ");'><font color='black'><b>" + userList[i].name + "</b></font></a></td>";
						if(userList[i].month == ''){
							innerHtml += "<td>-</td>";
						}else{
							innerHtml += "<td><font color='black'><b>" + userList[i].month + "월" + userList[i].day + "일</b></font></td>";
						}
						innerHtml += "<td>-</td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					}
					innerHtml += "</tr>"
				}
				innerHtml += "</tbody>";
				innerHtml += "</table>";

				$("#userList").html(innerHtml);

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function getUserListByKeyword() {

		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getUserListByKeyword.json",
			dataType : "json",
			data : {
				"keyword" : $("#keyword").val(),
			},
			success : function(data) {
				$("#userList").empty();

				var innerHtml = '';

				var userList = data["userList"];

				innerHtml += "<table id='dtBasicExample' class='table table-striped table-bordered' bgcolor='white' cellspacing='0' width='80%' style='text-align: center;'>";

				innerHtml += "<thead>";
				innerHtml += "<tr>";
				innerHtml += "<th class='th-sm'><b>이름</b></th>";
				innerHtml += "<th class='th-sm'><b>양력</b></th>";
				innerHtml += "<th class='th-sm'><b>음력</b></th>";
				innerHtml += "<th class='th-sm'><b>연락처</b></th>";
				innerHtml += "</tr>";
				innerHtml += "</thead>";
				innerHtml += "<tbody>";
				for (var i = 0; i < userList.length; i++) {
					innerHtml += "<tr>";
					if (userList[i].isMoon) {

						innerHtml += "<td><a onclick='javascript:getFamilyById(" + userList[i].id + ");'><font color='black'><b>" + userList[i].name + "</b></font></a></td>";
						innerHtml += "<td><font color='black'><b>" + userList[i].month_moon + "월" + userList[i].day_moon + "일</b></font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].month + "월" + userList[i].day + "일</font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					} else {

						innerHtml += "<td><a onclick='javascript:getFamilyById(" + userList[i].id + ");'><font color='black'><b>" + userList[i].name + "</b></font></a></td>";
						innerHtml += "<td><font color='black'><b>" + userList[i].month + "월" + userList[i].day + "일</b></font></td>";
						innerHtml += "<td>-</td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					}
					innerHtml += "</tr>"
				}
				innerHtml += "</tbody>";
				innerHtml += "</table>";

				$("#userList").html(innerHtml);

			},
			error : function(request, status, error) {
				alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
			}
		});
	}

	function getFamilyById(id) {

		$("#familyList").empty();
		
		$.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/getFamilyById.json",
			dataType : "json",
			data : {
				"id" : id,
			},
			success : function(data) {

				var innerHtml = '';

				var userList = data["familyList"];

				innerHtml += "<table id='dtBasicExample' class='table table-sm' style='text-align: center;'>";

				innerHtml += "<thead>";
				innerHtml += "<tr>";
				innerHtml += "<th scope='col'><b>이름</b></th>";
				innerHtml += "<th scope='col'><b>양력</b></th>";
				innerHtml += "<th scope='col'><b>음력</b></th>";
				innerHtml += "<th scope='col'><b>주소</b></th>";
				innerHtml += "<th scope='col'><b>연락처</b></th>";
				innerHtml += "</tr>";
				innerHtml += "</thead>";
				innerHtml += "<tbody>";
				for (var i = 0; i < userList.length; i++) {
					innerHtml += "<tr>";
					if (userList[i].isMoon) {

						innerHtml += "<td scope='row'><font color='black'><b>" + userList[i].name + "</b></font></td>";
						innerHtml += "<td><font color='black'><b>" + userList[i].year + "/" + userList[i].month_moon + "/" + userList[i].day_moon + "</b></font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].year + "/" + userList[i].month + "/" + userList[i].day + "</font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].address + "</font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					} else {

						innerHtml += "<td scope='row'><font color='black'><b>" + userList[i].name + "</b></font></td>";
						if(userList[i].month == ''){
							innerHtml += "<td>-</td>";
						}else{
							innerHtml += "<td><font color='black'><b>" + userList[i].year + "/" + userList[i].month + "/" + userList[i].day + "</b></font></td>";
						}
						innerHtml += "<td>-</td>";
						innerHtml += "<td><font color='black'>" + userList[i].address + "</font></td>";
						innerHtml += "<td><font color='black'>" + userList[i].phone + "</font></td>";

					}
					innerHtml += "</tr>"
				}
				innerHtml += "</tbody>";
				innerHtml += "</table>";

				$("#fullHeightModalRight").modal();
				$("#familyList").html(innerHtml);

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
		<form onsubmit="return false;" class="form-inline md-form form-sm active-purple-2 mt-2" style="width: 250px; float: right;">
			<input id="keyword" class="form-control form-control-sm mr-3 w-75" type="text" placeholder="Search" aria-label="Search" style="width: 50%;">
			<a onclick="javascript:getUserListByKeyword();">
				<i class="fas fa-search" aria-hidden="true"></i>
			</a>
		</form>
		<table id="dtBasicExample" class="table table-striped table-bordered" bgcolor="white" cellspacing="0" width="100%">
			<tr>
				<select id="selectMonth" class="browser-default custom-select" style="width: 100%; font-size: 15px; float: right;">
					<option value="00" selected>전체</option>
					<option value="01">1월 생일</option>
					<option value="02">2월 생일</option>
					<option value="03">3월 생일</option>
					<option value="04">4월 생일</option>
					<option value="05">5월 생일</option>
					<option value="06">6월 생일</option>
					<option value="07">7월 생일</option>
					<option value="08">8월 생일</option>
					<option value="09">9월 생일</option>
					<option value="10">10월 생일</option>
					<option value="11">11월 생일</option>
					<option value="12">12월 생일</option>
				</select>
			</tr>
		</table>

		<!-- Full Height Modal Right -->
		<div class="modal fade top" id="fullHeightModalRight" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

			<!-- Add class .modal-full-height and then add class .modal-right (or other classes from list above) to set a position to the modal -->
			<div class="modal-dialog modal-full-height modal-top" role="document">


				<div class="modal-content">
				
					<div class="modal-header #66bb6a green lighten-1">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true" class="white-text">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="familyList"></div>
					</div>
					<div class="modal-footer justify-content-center">
						<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>
		<!-- Full Height Modal Right -->
		<div id="userList"></div>
	</div>
	</main>
	<!--Contents layout-->

	<%@ include file="../common/footer.jsp"%>
</body>

</html>
