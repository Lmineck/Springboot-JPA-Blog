<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="layout/header.jsp"%>

<div class="container">
	<br />
	<c:forEach var="board" items="${boards.content}">
		<div class="card border-dark m-2">
			<div class="card-header border-dark d-flex">작성자 :
				${board.user.username}</div>
			<div class="card-body border-dark">
				<h4 class="card-title">${board.title}</h4>
				<a href="/board/${board.id}" class="btn btn-outline-dark">상세보기</a>
			</div>
		</div>
	</c:forEach>

	<ul class="pagination">
		<c:choose>
			<c:when test="${boards.first}">
				<li class="page-item"><a class="btn-link btn-sm disabled"
					href="?page=${boards.number-1}">이전</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="btn-link btn-sm"
					href="?page=${boards.number-1}">이전</a></li>
			</c:otherwise>
		</c:choose>
		<c:choose>
			<c:when test="${boards.last}">
				<li class="page-item"><a class="btn-link btn-sm disabled"
					href="?page=${boards.number+1}">다음</a></li>
			</c:when>
			<c:otherwise>
				<li class="page-item"><a class="btn-link btn-sm"
					href="?page=${boards.number+1}">다음</a></li>
			</c:otherwise>
		</c:choose>
	</ul>

</div>

<%@ include file="layout/footer.jsp"%>

<style>
.container {
	position: relative;
	width: 800px;
	height: 700px;
	padding: 20px;
	margin-top: 50px;
}

.card {
	background-color: rgba(255, 255, 255, 0.5);
}

.pagination {
	position: absolute;
	margin-left: -42px;
	left: 50%;
	bottom: 0;
}

.pagination>li>a {
	font-weight: bold;
}
</style>