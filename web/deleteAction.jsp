<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/15
  Time: 15:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="likey.LikeyDTO" %>
<%@ page import="likey.LikeyDAO" %>
<%@ page import="java.io.PrintWriter" %>
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

    String evaluationID = null;
    if (request.getParameter("evaluationID") != null) {
        evaluationID = request.getParameter("evaluationID");
    }

    EvaluationDAO evaluationDAO = new EvaluationDAO();

    if (userID.equals(evaluationDAO.getUserID(evaluationID))) {
        int result = new EvaluationDAO().delete(evaluationID);
        if (result == 1) {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert(\"성공적으로 삭제되었습니다.\");");
            script.println("location.href = 'index.jsp'");
            script.println("</script>");
            script.close();
            return;
        } else {
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert(\"데이터베이스 오류가 발생했습니다.\");");
            script.println("history.back()");
            script.println("</script>");
            script.close();
            return;
        }
    } else {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"자신이 작성한 글만 삭제가 가능합니다.\");");
        script.println("history.back()");
        script.println("</script>");
        script.close();
        return;
    }
%>