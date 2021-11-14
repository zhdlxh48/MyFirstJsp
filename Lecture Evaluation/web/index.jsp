<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/14
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
  <link>
    <title>강의평가 웹 사이트</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="./css/reset.css">
    <!-- Bootstrap CSS Add -->
    <link rel="stylesheet" href="./css/bootstrap.min.css">
    <!-- My Custom CSS Add -->
    <link rel="stylesheet" href="./css/custom.css">
  </head>
  <body>
    <div class="navbar navbar-expand-lg navbar-light bg-light">
      <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">강의평가 웹 사이트</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar" aria-expanded="false" aria-controls="navbar">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="navbar-nav me-auto">
            <li class="nav-item active">
              <a class="nav-link" href="index.jsp">메인</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" id="dropdown" data-bs-toggle="dropdown" data-bs-target="#navbar-dropdown" aria-expanded="false" aria-controls="navbar-dropdown">
                회원관리
              </a>
              <div id="navbar-dropdown" class="dropdown-menu" aria-labelledby="dropdown">
                <a class="dropdown-item" href="#">로그인</a>
                <a class="dropdown-item" href="#">회원가입</a>
                <a class="dropdown-item" href="#">로그아웃</a>
              </div>
            </li>
          </ul>
          <form class="d-inline-flex my-2 my-lg-0">
            <input class="form-control me-sm-2 w-auto" type="search" placeholder="내용을 입력하세요" aria-label="search" />
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
          </form>
        </div>
      </div>
    </div>

    <!-- JQuery JS Add -->
    <script src="./js/jquery.min.js"></script>
    <!-- Popper JS Add -->
    <script src="./js/popper.min.js"></script>
    <!-- Bootstrap JS Add -->
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>
