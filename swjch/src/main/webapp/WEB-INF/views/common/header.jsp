<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<li class="nav-item active"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/">
						<font size='3' color='black'><strong>HOME</strong></font>
					</a></li>
				<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/bible.do">
						<font size='3' color='black'><strong>연대기성경</strong></font>
					</a></li>
				<li class="nav-item"><a class="nav-link h3 my-1" href="${pageContext.request.contextPath}/plan.do">
						<font size='3' color='black'><strong>연간계획</strong></font>
					</a></li>
				<li class="nav-item"><a class="nav-link h3 my-1" href="#">
						<font size='3' color='black'><strong>NAS</strong></font>
					</a></li>
				<li class="nav-item">
						<a href=""  class="nav-link h3 my-1" data-toggle="modal" data-target="#modalLRForm"><font size='3' color='BLUE'><strong>LOGIN</strong></font></a>
					</li>
			</ul>
		</div>
		<!-- Collapsible content -->

	</nav>
	<!--/.Navbar-->

</header>
<!--Main Navigation-->