<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">
<head>
<title>Bootstrap Example</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
</head>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand" href="/">🏳 블로그 게시판 🏳</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse justify-content-end"
		id="collapsibleNavbar">
		<c:choose>
			<c:when test="${empty principal}">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="/auth/loginForm">로그인</a></li>
					<li class="nav-item"><a class="nav-link" href="/auth/joinForm">회원가입</a>
					</li>
				</ul>
			</c:when>
			<c:otherwise>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="/board/saveForm">글쓰기</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/user/updateForm">회원정보</a></li>
					<li class="nav-item"><a class="nav-link" href="/logout">로그아웃</a>
					</li>
				</ul>
			</c:otherwise>
		</c:choose>
	</div>
</nav>
<br />

<style>
@import url(//fonts.googleapis.com/earlyaccess/jejumyeongjo.css);

input[type=password] {
	font-family: 'Malgun gothic', dotum, sans-serif;
}

::placeholder {
	font-family: 'Jeju Myeongjo', serif;
}

html, body {
	margin: 0;
	padding: 0;
	font-family: 'Jeju Myeongjo', serif;
}

body {
	background-color: rgb(247, 245, 235);
}
</style>