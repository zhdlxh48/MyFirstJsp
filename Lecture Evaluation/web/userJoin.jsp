<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/14
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
  String userID = null;
  if (session.getAttribute("userID") != null) {
    userID = (String) session.getAttribute("userID");
  }
    if (userID != null) {
      PrintWriter script = response.getWriter();
      script.println("<script>");
//      script.println("alert(\"로그인이 되어있습니다.\")");
      script.println("location.href = 'index.jsp'");
      script.println("</script>");
      script.close();
      return;
    }
%>

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
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
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
                <% if (userID == null) { %>
                <a class="dropdown-item" href="userLogin.jsp">로그인</a>
                <a class="dropdown-item" href="userJoin.jsp">회원가입</a>
                <% } else { %>
                <a class="dropdown-item" href="userLogoutAction.jsp">로그아웃</a>
                <% } %>
              </div>
            </li>
          </ul>
          <form class="d-inline-flex my-2 my-lg-0">
            <input class="form-control me-sm-2 w-auto" type="search" placeholder="내용을 입력하세요" aria-label="search" />
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
          </form>
        </div>
      </div>
    </nav>

    <section class="container" style="max-width: 560px;">
      <form method="post" action="./userRegisterAction.jsp">
        <div class="col my-4">
          <div class="row-cols-1 mb-2">
            <label>아이디</label>
            <input type="text" name="userID" class="form-control mt-1" />
          </div>
          <div class="row-cols-1 my-2">
            <label>비밀번호</label>
            <input type="password" name="userPassword" class="form-control mt-1" />
          </div>
          <div class="row-cols-1 my-2">
            <label>이메일</label>
            <input type="email" name="userEmail" class="form-control mt-1" />
          </div>
          <button type="submit" class="btn btn-primary row-cols-1 mt-2">회원가입</button>
        </div>
      </form>
    </section>

    <footer class="bg-dark mt-4 p-5 text-center" style="color: white">
      Copyright &copy; 2021 MayB All Right Reserved.
    </footer>

    <!-- JQuery JS Add -->
    <script src="./js/jquery.min.js"></script>
    <!-- Popper JS Add -->
    <script src="./js/popper.min.js"></script>
    <!-- Bootstrap JS Add -->
    <script src="./js/bootstrap.min.js"></script>
  </body>
</html>
