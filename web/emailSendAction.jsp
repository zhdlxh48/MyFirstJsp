<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/15
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="javax.mail.*" %>
<%@ page import="util.Gmail" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.util.Properties" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%
    UserDAO userDAO = new UserDAO();
    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) { // If session is invalid
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"로그인이 필요합니다.\");");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    boolean emailChecked = userDAO.getUserEmailChecked(userID);
    if (emailChecked) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"이미 인증 된 회원입니다.\");");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    String host = "http://localhost:8080/Lecture_Evaluation_war_exploded";
    String from = System.getenv("DEV_EMAIL");
    String to = userDAO.getUserEmail(userID);
    System.out.println("인증메일 발송: " + to);
    String subject = "강의 평가를 위한 이메일 인증 메일입니다.";
    String content = "다음 링크에 접속하여 이메일 인증을 진행해주세요.\n" + String.format("<a href=\"%s/emailCheckAction.jsp?code=%s\">이메일 인증하기</a>", host, SHA256.getSHA256(to));

    Properties p = new Properties();
    p.put("mail.smtp.user", from);
    p.put("mail.smtp.host", "smtp.gmail.com");
    p.put("mail.smtp.port", "465");
    p.put("mail.smtp.starttle.enable", "true");
    p.put("mail.smtp.auth", "true");
    p.put("mail.smtp.debug", "true");
    p.put("mail.smtp.socketFactory.port", "465");
    p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    p.put("mail.smtp.socketFactory.fallback", "false");

    try {
        Authenticator auth = new Gmail();
        Session ses = Session.getInstance(p, auth);
        ses.setDebug(true);
        MimeMessage msg = new MimeMessage(ses);
        msg.setSubject(subject);
        Address fromAddr = new InternetAddress(from);
        msg.setFrom(fromAddr);
        Address toAddr = new InternetAddress(to);
        msg.addRecipient(Message.RecipientType.TO, toAddr);
        msg.setContent(content, "text/html;charset=UTF-8");
        Transport.send(msg);
    } catch (Exception e) {
        e.printStackTrace();
        System.out.println("Error Accour Test (Can not be here sad...)");
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"오류가 발생했습니다.\");");
        script.println("history.back()");
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
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar"
                aria-expanded="false" aria-controls="navbar">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp">메인</a>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="dropdown" data-bs-toggle="dropdown"
                       data-bs-target="#navbar-dropdown" aria-expanded="false" aria-controls="navbar-dropdown">
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
            <form action="./index.jsp" method="get" class="d-inline-flex my-2 my-lg-0">
                <input type="text" name="search" class="form-control me-sm-2 w-auto" type="search" placeholder="내용을 입력하세요" aria-label="search"/>
                <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
            </form>
        </div>
    </div>
</nav>

<section class="container" style="max-width: 560px;">
    <div class="alert alert-success mt-4" role="alert">
        이메일 주소 인증 메일이 전송되었습니다. 회원가입시 입력했던 이메일을 확인해주세요.
    </div>
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
