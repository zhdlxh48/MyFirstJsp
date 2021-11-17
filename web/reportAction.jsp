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
    request.setCharacterEncoding("UTF-8");

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

    String reportTitle = null;
    String reportContent = null;

    if (request.getParameter("reportTitle") != null) {
        reportTitle = request.getParameter("reportTitle");
    }
    if (request.getParameter("reportContent") != null) {
        reportContent = request.getParameter("reportContent");
    }

    if (reportTitle == "" | reportContent == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"입력이 올바르지 않습니다.\");");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();

    String host = "http://localhost:8080/Lecture_Evaluation_war_exploded";
    String from = System.getenv("DEV_EMAIL");
    String to = System.getenv("DEV_EMAIL");
    System.out.println("신고 메일 발송");
    String subject = String.format("[강의평가 신고메일] (%s) %s", userID, reportTitle);
    String content = String.format("신고자 ID: %s<br/>신고자 Email: %s<br/>신고제목: %s<br/>신고내역: <br/>%s", userID, userDAO.getUserEmail(userID), reportTitle, reportContent);

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
    PrintWriter script = response.getWriter();
    script.println("<script>");
    script.println("alert(\"신고 접수가 정상적으로 완료되었습니다.\");");
    script.println("history.back()");
    script.println("</script>");
    script.close();
    return;
%>