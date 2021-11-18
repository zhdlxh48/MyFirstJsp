# Jsp Study

Jsp를 공부하면서 정리하기 위해 만든 리포지토리입니다

## 개발환경

- IDE
  - Intellij IDEA
  
- Java Version
  - JDK 11 (Temurin, Adoptium)

- Web Server
  - Tomcat

- Database
  - MySQL

- Web UI
  - Bootstrap
  - JQuery
  - Popper

## 목차

1. 개발환경 설정
- 2021/11/11 [완료]
- JavaEE Web Project, Tomcat 10

2. 기본 유저 관리 클래스 생성
- 2021/11/12 [완료]
- UserDTO
- UserDAO
- DatabaseUtil

3. MySQL 데이터베이스 설정
- 2021/11/14 [완료]
- user 테이블 생성
- evaluation 테이블 생성
- likey 테이블 생성

4. Web UI 설정
- 2021/11/15 [완료]
- 네비게이션 바 UI 디자인
- 메인페이지, 강의평가 및 신고 Modal, 로그인, 회원가입, 이메일 인증 페이지 디자인

5. Web Action 생성
- 2021/11/17 [완료]
- 로그인, 로그아웃, 회원가입, 이메일 인증, 글 업로드 액션

6. XSS 공격 방어 설정
- 2021/11/18 [완료]
- "<", ">" 태그 특수 코드 처리

## DB 스키마

- USER

| Field            | Type        | Null | Key | Default | Extra |
|------------------|-------------|------|-----|---------|-------|
| userID           | varchar(20) | NO   | PRI | NULL    |       |
| userPassword     | varchar(64) | YES  |     | NULL    |       |
| userEmail        | varchar(50) | YES  |     | NULL    |       |
| userEmailHash    | varchar(64) | YES  |     | NULL    |       |
| userEmailChecked | tinyint(1)  | YES  |     | NULL    |       |

- EVALUATION

| Field             | Type          | Null | Key | Default | Extra          |
|-------------------|---------------|------|-----|---------|----------------|
| evaluationID      | int           | NO   | PRI | NULL    | auto_increment |
| userID            | varchar(20)   | YES  |     | NULL    |                |
| lectureName       | varchar(50)   | YES  |     | NULL    |                |
| professorName     | varchar(20)   | YES  |     | NULL    |                |
| lectureYear       | int           | YES  |     | NULL    |                |
| semesterDivide    | varchar(20)   | YES  |     | NULL    |                |
| lectureDivide     | varchar(10)   | YES  |     | NULL    |                |
| evaluationTitle   | varchar(50)   | YES  |     | NULL    |                |
| evaluationContent | varchar(2048) | YES  |     | NULL    |                |
| totalScore        | varchar(5)    | YES  |     | NULL    |                |
| creditScore       | varchar(5)    | YES  |     | NULL    |                |
| comfortableScore  | varchar(5)    | YES  |     | NULL    |                |
| lectureScore      | varchar(5)    | YES  |     | NULL    |                |
| likeCount         | int           | YES  |     | NULL    |                |

- LIKEY

| Field        | Type        | Null | Key | Default | Extra |
|--------------|-------------|------|-----|---------|-------|
| userID       | varchar(20) | NO   | PRI | NULL    |       |
| evaluationID | int         | NO   | PRI | NULL    |       |
| userIP       | varchar(50) | YES  |     | NULL    |       |