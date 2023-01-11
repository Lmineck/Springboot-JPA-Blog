<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file = "../layout/header.jsp" %>

<div class="container">

  <form>
    <div class="form-group">
      <label for="username">Username:</label>
      <input type="text" class="form-control" placeholder="Enter username" id="username">
    </div>
    <div class="form-group">
      <label for="password">Password:</label>
      <input type="password" class="form-control" placeholder="Enter password" id="password">
    </div>
    <div class="form-group">
      <label for="email">Email:</label>
      <input type="email" class="form-control" placeholder="Enter email" id="email">
    </div>
  </form>
  <button id="btn-save" type="btn btn-primary" class="btn btn-dark" style="float: right;">회원가입완료</button>

</div>

<script src="/js/user.js"></script>

<footer>
	<%@ include file="../layout/footer.jsp"%>
</footer>

<style>
.container {
	position: relative;
	width: 500px;
	height: 600px;
	padding: 20px;
	margin-top: 150px;
}
</style>