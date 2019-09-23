<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!--Main Navigation-->
<header>

	<!--Navbar-->
	<nav class="navbar navbar-expand-lg #ffffff white">
		<!-- Navbar brand -->
		<a class="navbar-brand card-title h5 my-1" href="${pageContext.request.contextPath}/">
			<font size='4' color='black'><strong>수원중부교회</strong></font>
		</a>
		<!-- Collapse button -->
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#basicExampleNav" aria-controls="basicExampleNav" aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span><i class="fas fa-bars"></i>
		</button>
		<!-- Collapsible content -->
		<div class="collapse navbar-collapse" id="basicExampleNav">
			<!-- Links -->
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/bible.do">
						<font size='2' color='black'><strong>연대기성경</strong></font>
					</a></li>
				<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/plan.do">
						<font size='2' color='black'><strong>연간계획</strong></font>
					</a></li>
				<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/userList.do">
						<font size='2' color='black'><strong>주소록</strong></font>
					</a></li>
				<c:if test="${sessionScope.isAdmin eq 'y'}">
					<li class="nav-item"><a class="nav-link h3 my-1" href="#">
							<font size='2' color='black'><strong>NAS</strong></font>
						</a></li>
					<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/log.do">
							<font size='2' color='black'><strong>LOG</strong></font>
						</a></li>
				</c:if>
				<li class="nav-item"><c:if test="${sessionScope.isAdmin eq 'n' || empty sessionScope.isAdmin}">
						<a href="" class="nav-link h3 my-1" data-toggle="modal" data-target="#modalLRForm">
							<font size='2' color='BLUE'><strong>LOGIN</strong></font>
						</a>
					</c:if> <c:if test="${sessionScope.isAdmin eq 'y'}">
						<a href="/logout.do" class="nav-link h3 my-1">
							<font size='2' color='grey'><strong>LOGOUT</strong></font>
						</a>
					</c:if></li>
			</ul>
		</div>
		<!-- Collapsible content -->

	</nav>
	<!--/.Navbar-->

	<!--Modal: Login / Register Form-->
	<div class="modal fade" id="modalLRForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog cascading-modal" role="document">
			<!--Content-->
			<div class="modal-content">

				<!--Modal cascading tabs-->
				<div class="modal-c-tabs">

					<!-- Nav tabs -->
					<ul class="nav nav-tabs md-tabs tabs-2 success-color-dark #007E33" role="tablist">
						<li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#panel7" role="tab">
								<i class="fas fa-user mr-1 cyan-text"></i><font color='black'>Login</font>
							</a></li>
					</ul>

					<!-- Tab panels -->
					<div class="tab-content">
						<!--Panel 7-->
						<div class="tab-pane fade in show active" id="panel7" role="tabpanel">
							<!--Body-->
							<form id="loginForm" action="/login.do" method="post">
								<div class="modal-body mb-1">
									<div class="md-form form-sm mb-5">
										<i class="fas fa-user prefix grey-text"></i> <input id="userId" name="userId" type="text" id="modalLRInput10" class="form-control form-control-sm"> <label data-error="wrong" data-success="right" for="modalLRInput10"></label>
									</div>

									<div class="md-form form-sm mb-4">
										<i class="fas fa-lock prefix grey-text"></i> <input id="userPw" name="userPw" type="password" id="modalLRInput11" class="form-control form-control-sm"> <label data-error="wrong" data-success="right" for="modalLRInput11"></label>
									</div>
									<div class="text-center mt-2">
										<button class="btn btn-info" onclick="document.getElementById('loginForm').submit();">
											Login <i class="fas fa-sign-in ml-1"></i>
										</button>
										<button type="button" class="btn btn-outline-info waves-effect ml-auto" data-dismiss="modal">Close</button>
									</div>
								</div>
							</form>
						</div>
						<!--/.Panel 7-->

					</div>

				</div>
			</div>
			<!--/.Content-->
		</div>
	</div>
	<!--Modal: Login / Register Form-->
</header>
<!--Main Navigation-->