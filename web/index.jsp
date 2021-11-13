<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/12
  Time: 11:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
    <title>MyFirstJsp</title>
  </head>
  <body>
    <div>로그인 페이지</div>
    <form action="./userJoinAction.jsp" method="post">
      <input type="text" name="userID" placeholder="ID" />
      <input type="password" name="userPassword" placeholder="Password" />
      <input type="submit" value="회원가입" />
    </form>
  </body>
</html>
