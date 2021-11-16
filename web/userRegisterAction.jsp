<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/15
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="user.UserDTO" %>
<%@ page import="user.UserDAO" %>
<%@ page import="util.SHA256" %>
<%@ page import="java.io.PrintWriter" %>

<%
    System.out.println("Start Register Action");
    request.setCharacterEncoding("UTF-8");
    String userID = null;
    String userPassword = null;
    String userEmail = null;

    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID != null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"현재 로그인이 되어있는 상태입니다.\")");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    if (request.getParameter("userID") != null) {
        userID = request.getParameter("userID");
        System.out.println("User ID: " + userID);
    }
    if (request.getParameter("userPassword") != null) {
        userPassword = request.getParameter("userPassword");
        System.out.println("User Password: " + userPassword);
    }
    if (request.getParameter("userEmail") != null) {
        userEmail = request.getParameter("userEmail");
        System.out.println("User Email: " + userEmail);
    }

    if (userID == "" || userPassword == "" || userEmail == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"잘못된 입력입니다. 다시한번 확인해주세요.\");");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.join(new UserDTO(userID, userPassword, userEmail, false, SHA256.getSHA256(userEmail)));
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"이미 존재하는 아이디입니다.\")");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    } else {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'emailSendAction.jsp'");
        script.println("</script>");
        script.close();
    }
%>