<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../layout/header.jsp"%>

<div class="container">
	<form action="/auth/loginProc" method="post">
		<div class="form-group">
			<label for="username">Username:</label> <input type="text"
				name="username" class="form-control" placeholder="Enter username"
				id="username">
		</div>
		<div class="form-group">
			<label for="password">Password:</label> <input type="password"
				name="password" class="form-control" placeholder="Enter password"
				id="password">
		</div>
		<div style="display: inline-block; margin: 0 5px; float: right;">
			<a
				href="https://kauth.kakao.com/oauth/authorize?client_id=f79eb714124f6d245b6d02d581fb94ff&redirect_uri=http://localhost:8000/auth/kakao/callback&response_type=code"><img
				height="38px" src="/image/kakao_login_button.png" /></a>
			<button id="btn-login" class="btn btn-dark">로그인</button>
		</div>
	</form>
</div>

<footer>
	<%@ include file="../layout/footer.jsp"%>
</footer>
<style>
.container {
	position: relative;
	width: 500px;
	height: 580px;
	padding: 20px;
	margin-top: 170px;
}
</style>