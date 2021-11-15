<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/15
  Time: 20:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>

<%
    request.setCharacterEncoding("UTF-8");
    String code = null;
    if (request.getParameter("code") != null) {
        code = request.getParameter("code");
    }

    UserDAO userDAO = new UserDAO();

    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"로그인 해주세요.\");");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    String userEmail = userDAO.getUserEmail(userID);
    String sha256 = SHA256.getSHA256(userEmail);
    boolean isRight = sha256.equals(code);
    if (isRight) {
        userDAO.setUserEmailChecked(userID);
        System.out.println(String.format("SHA256 is equal with email's code!\n\tSHA256 (Converted): %s\n\tEmail's Code: %s", sha256, code));
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"성공적으로 인증되었습니다!\");");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else {
        System.out.println(String.format("SHA256 is not equal with email's code..\n\tSHA256 (Converted): %s\n\tEmail's Code: %s", sha256, code));
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"유효하지 않은 코드입니다.\");");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
%>