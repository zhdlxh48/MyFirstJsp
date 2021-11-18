<%--
  Created by IntelliJ IDEA.
  User: zhdlxh48
  Date: 2021/11/14
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.UserDAO" %>
<%@ page import="evaluation.EvaluationDTO" %>
<%@ page import="evaluation.EvaluationDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>

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
<%
    request.setCharacterEncoding("UTF-8");

    String lectureDivide = "전체";
    String searchType = "최신순";
    String search = "";
    int pageNumber = 0;

    if (request.getParameter("lectureDivide") != null) {
        lectureDivide = request.getParameter("lectureDivide");
    }
    if (request.getParameter("searchType") != null) {
        searchType = request.getParameter("searchType");
    }
    if (request.getParameter("search") != null) {
        search = request.getParameter("search");
    }
    if (request.getParameter("pageNumber") != null) {
        try {
            pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
        } catch (Exception e) {
            System.out.println("페이지 번호 오류");
        }
    }

    String userID = null;
    if (session.getAttribute("userID") != null) {
        userID = (String) session.getAttribute("userID");
    }
    if (userID == null) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"로그인이 필요합니다.\")");
        script.println("location.href = 'userLogin.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
    boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
    if (!emailChecked) {
        PrintWriter script = response.getWriter();
        script.println("<script>");
        script.println("alert(\"이메일 인증이 완료되지 않았습니다. 인증을 완료해주세요.\")");
        script.println("location.href = 'emailSendConfirm.jsp'");
        script.println("</script>");
        script.close();
        return;
    }
%>
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

<section class="container">
    <form method="get" action="./index.jsp" class="d-inline-flex mt-3">
        <select name="lectureDivide" class="form-control mx-1 mt-2 w-auto">
            <option value="전체">전체</option>
            <option value="전공" <% if (lectureDivide.equals("전공")) { out.println("selected"); } %>>전공</option>
            <option value="교양" <% if (lectureDivide.equals("교양")) { out.println("selected"); } %>>교양</option>
            <option value="기타" <% if (lectureDivide.equals("기타")) { out.println("selected"); } %>>기타</option>
        </select>
        <select name="searchType" class="form-control mx-1 mt-2 w-auto">
            <option value="최신순">최신순</option>
            <option value="추천순" <% if (searchType.equals("전공")) { out.println("selected"); } %>>추천순</option>
        </select>
        <input type="text" name="search" class="form-control mx-1 mt-2 w-auto" placeholder="내용을 입력하세요."/>
        <button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
        <a class="btn btn-primary mx-1 mt-2" data-bs-toggle="modal" href="#registerModal">등록하기</a>
        <a class="btn btn-danger mx-1 mt-2" data-bs-toggle="modal" href="#reportModal">신고</a>
    </form>

    <%
        ArrayList<EvaluationDTO> evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);

        if (evaluationList != null) {
            for (int i = 0; i < evaluationList.size(); i++) {
                if (i == 5) break;
                EvaluationDTO evaluation = evaluationList.get(i);
    %>
    <div class="card bg-light mt-3">
        <div class="card-header bg-light">
            <div class="row">
                <div class="col-8 text-start"><%= evaluation.getLectureName() %>&nbsp;<small><%= evaluation.getProfessorName() %></small></div>
                <div class="col-4 text-end">종합&nbsp;<span style="color: red;"><%= evaluation.getTotalScore() %></span></div>
            </div>
        </div>
        <div class="card-body">
            <h5 class="card-title">
                <%= evaluation.getEvaluationTitle() %>&nbsp;<small>(<%= evaluation.getLectureYear() %>년 <%= evaluation.getSemesterDivide() %>)</small>
            </h5>
            <p class="card-text"><%= evaluation.getEvaluationContent() %></p>
            <div class="row">
                <div class="col-9 text-start">
                    강의&nbsp;<span style="color: red;"><%= evaluation.getLectureScore() %></span>
                    여유도&nbsp;<span style="color: red;"><%= evaluation.getComfortableScore() %></span>
                    성적&nbsp;<span style="color: red;"><%= evaluation.getCreditScore() %></span>
                    <span style="color: green;">(추천: <%= evaluation.getLikeCount() %>)</span>
                </div>
                <div class="col-3 text-end">
                    <a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
                    <a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
                </div>
            </div>
        </div>
    </div>
    <%
            }
        }
    %>
</section>

<ul class="pagination justify-content-center mt-3">
    <li class="page-item">
        <%  if (pageNumber <= 0) { %>
        <a class="page-link disabled">이전</a>
        <%  } else { %>
        <a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber - 1 %>">이전</a>
        <%  } %>
    </li>
    <li class="page-item">
        <%  if (evaluationList.size() < 6) { %>
        <a class="page-link disabled">다음</a>
        <%  } else { %>
        <a class="page-link" href="./index.jsp?lectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%= pageNumber + 1 %>">다음</a>
        <%  } %>
    </li>
</ul>

<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="register-modal-title">평가 등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="./evaluationRegisterAction.jsp" method="post">
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <label>강의명</label>
                            <input type="text" name="lectureName" class="form-control mt-1" maxlength="20">
                        </div>
                        <div class="col-sm-6">
                            <label>교수</label>
                            <input type="text" name="professorName" class="form-control mt-1" maxlength="20">
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-sm-4">
                            <label>수강년도</label>
                            <select name="lectureYear" class="form-control mt-1">
                                <option value="2018">2018</option>
                                <option value="2019">2019</option>
                                <option value="2020">2020</option>
                                <option value="2021" selected>2021</option>
                                <option value="2022">2022</option>
                                <option value="2023">2023</option>
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <label>수강학기</label>
                            <select name="semesterDivide" class="form-control mt-1">
                                <option value="1학기" selected>1학기</option>
                                <option value="여름학기">여름학기</option>
                                <option value="2학기">2학기</option>
                                <option value="겨울학기">겨울학기</option>
                            </select>
                        </div>
                        <div class="col-sm-4">
                            <label>강의</label>
                            <select name="lectureDivide" class="form-control mt-1">
                                <option value="전공" selected>전공</option>
                                <option value="교양">교양</option>
                                <option value="기타">기타</option>
                            </select>
                        </div>
                    </div>
                    <div class="mt-2">
                        <label>제목</label>
                        <input type="text" name="evaluationTitle" class="form-control mt-1" maxlength="30"/>
                    </div>
                    <div class="mt-2">
                        <label>내용</label>
                        <textarea name="evaluationContent" class="form-control mt-1" maxlength="2048"
                                  style="height: 180px;"></textarea>
                    </div>
                    <div class="row mt-2">
                        <div class="col-sm-3">
                            <label>종합</label>
                            <select name="totalScore" class="form-control mt-1">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label>강의</label>
                            <select name="lectureScore" class="form-control mt-1">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label>여유도</label>
                            <select name="comfortableScore" class="form-control mt-1">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                        <div class="col-sm-3">
                            <label>성적</label>
                            <select name="creditScore" class="form-control mt-1">
                                <option value="A" selected>A</option>
                                <option value="B">B</option>
                                <option value="C">C</option>
                                <option value="D">D</option>
                                <option value="F">F</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                    <button type="submit" class="btn btn-primary" data-bs-dismiss="modal">등록</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="report-modal-title">신고하기</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="./reportAction.jsp" method="post">
            <div class="modal-body">
                    <div>
                        <label>제목</label>
                        <input type="text" name="reportTitle" class="form-control mt-1" maxlength="30"/>
                    </div>
                    <div class="mt-2">
                        <label>신고내용</label>
                        <textarea name="reportContent" class="form-control mt-1" maxlength="2048"
                                  style="height: 180px;"></textarea>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="submit" class="btn btn-danger" data-bs-dismiss="modal">신고</button>
            </div>
        </form>
        </div>
    </div>
</div>

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
