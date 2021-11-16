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

    if (request.getParameter("userID") != null) {
        userID = request.getParameter("userID");
        System.out.println("User ID: " + userID);
    }
    if (request.getParameter("userPassword") != null) {
        userPassword = request.getParameter("userPassword");
        System.out.println("User Password: " + userPassword);
    }

    if (userID == "" || userPassword == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"잘못된 입력입니다. 다시한번 확인해주세요.\");");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    UserDAO userDAO = new UserDAO();
    int result = userDAO.login(userID, userPassword);
    if (result == 1) {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else if (result == 0 || result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"비밀번호 혹은 아이디가 틀렸거나 존재하지 않습니다.\")");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    } else if (result == -2) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"내부 데이터베이스 오류가 발생했습니다.\n관리자에게 문의바랍니다.\")");
        script.println("history.back();");
        script.println("</script>");
        script.close();
    }
%>