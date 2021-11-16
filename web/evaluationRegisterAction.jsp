<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/15
  Time: 15:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
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
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"로그인 해주세요.\")");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }

    String lectureName = null;
    String professorName = null;
    int lectureYear = 0;
    String semesterDivide = null;
    String lectureDivide = null;
    String evaluationTitle = null;
    String evaluationContent = null;
    String totalScore = null;
    String creditScore = null;
    String comfortableScore = null;
    String lectureScore = null;

    if (request.getParameter("userID") != null) {
        userID = request.getParameter("userID");
    }
    if (request.getParameter("lectureName") != null) {
        lectureName = request.getParameter("lectureName");
    }
    if (request.getParameter("professorName") != null) {
        professorName = request.getParameter("professorName");
    }
    if (request.getParameter("lectureYear") != null) {
        try {
            lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
        } catch (Exception e) {
            System.out.println("강의 년도 데이터 오류");
        }
    }
    if (request.getParameter("semesterDivide") != null) {
        semesterDivide = request.getParameter("semesterDivide");
    }
    if (request.getParameter("lectureDivide") != null) {
        lectureDivide = request.getParameter("lectureDivide");
    }
    if (request.getParameter("evaluationTitle") != null) {
        evaluationTitle = request.getParameter("evaluationTitle");
    }
    if (request.getParameter("evaluationContent") != null) {
        evaluationContent = request.getParameter("evaluationContent");
    }
    if (request.getParameter("totalScore") != null) {
        totalScore = request.getParameter("totalScore");
    }
    if (request.getParameter("creditScore") != null) {
        creditScore = request.getParameter("creditScore");
    }
    if (request.getParameter("comfortableScore") != null) {
        comfortableScore = request.getParameter("comfortableScore");
    }
    if (request.getParameter("lectureScore") != null) {
        lectureScore = request.getParameter("lectureScore");
    }

    if (userID == "" || lectureName == "" || professorName == "" || lectureYear == 0 || semesterDivide == "" || lectureDivide == "" || evaluationTitle.equals("") || evaluationContent.equals("") || totalScore == "" || creditScore == "" || comfortableScore == "" || lectureScore == "") {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"잘못된 입력입니다. 다시한번 확인해주세요.\");");
        script.println("history.back();");
        script.println("</script>");
        script.close();
        return;
    }

    EvaluationDAO evaluationDAO = new EvaluationDAO();
    int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear, semesterDivide, lectureDivide, evaluationTitle, evaluationContent, totalScore, creditScore, comfortableScore, lectureScore, 0));
    if (result == -1) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"평가 게시글 등록에 실패했습니다.\")");
//      script.println("history.back();");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
        return;
    } else {
        session.setAttribute("userID", userID);
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"성공적으로 게시했습니다.\")");
        script.println("location.href = 'index.jsp'");
        script.println("</script>");
        script.close();
    }
%>