<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.user" %>

<%
user u = (user) session.getAttribute("user");

if(u == null){
    response.sendRedirect("login.jsp");
    return;
}

List<Map<String,String>> exams =
    (List<Map<String,String>>) request.getAttribute("exams");

Set<Integer> attemptedExams =
    (Set<Integer>) request.getAttribute("attemptedExams");

if(attemptedExams == null){
    attemptedExams = new HashSet<>();
}

String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Available Exams | NextGen Exam</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background: linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

.navbar{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(10px);
    padding:15px 30px;
    box-shadow:0 5px 20px rgba(0,0,0,0.25);
}

.navbar-brand{
    color:white !important;
    font-size:22px;
    font-weight:700;
}

.main-box{
    margin-top:40px;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 8px 30px rgba(0,0,0,0.25);
}

.main-box h3{
    font-weight:700;
    margin-bottom:20px;
}

.table{
    color:white;
    border-radius:12px;
    overflow:hidden;
}

.table th{
    background: rgba(255,255,255,0.18);
    color:white;
    border:none;
}

.table td{
    background: rgba(255,255,255,0.08);
    color:white !important;
    border-color: rgba(255,255,255,0.08);
    vertical-align:middle;
}

.table tr{
    color:white;
}

.btn-custom{
    border:none;
    border-radius:10px;
    padding:8px 16px;
    font-size:14px;
    font-weight:500;
}

.btn-start{
    background:linear-gradient(to right,#0072ff,#00c6ff);
    color:white;
}

.btn-start:hover{
    opacity:0.9;
}

.btn-done{
    background:#6c757d;
    color:white;
}

.alert{
    border:none;
    border-radius:12px;
}

.top-btn{
    border-radius:10px;
    font-size:14px;
    padding:8px 14px;
}

@media(max-width:768px){
    .navbar{
        padding:15px;
    }

    .main-box{
        padding:20px;
    }

    .table{
        font-size:14px;
    }
}
</style>

</head>

<body>

<nav class="navbar">
    <span class="navbar-brand">NextGen Exam</span>

    <div class="ms-auto">
        <a href="<%= request.getContextPath() %>/studentDashboard"
           class="btn btn-primary top-btn me-2">
           Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/studentResult"
           class="btn btn-success top-btn me-2">
           Results
        </a>

        <a href="logout"
           class="btn btn-danger top-btn">
           Logout
        </a>
    </div>
</nav>

<div class="container">

<div class="main-box">

<h3>Available Exams</h3>

<%
if("attempted".equals(error)){
%>
<div class="alert alert-danger">
    You have already attempted this exam.
</div>
<%
}
%>

<%
if(exams == null){
%>

<div class="alert alert-warning">
    No exams loaded. Please access via View Exams button.
</div>

<%
}else if(exams.isEmpty()){
%>

<div class="alert alert-info">
    No exams available.
</div>

<%
}else{
%>

<div class="table-responsive">

<table class="table text-center align-middle">

<tr>
    <th>Exam ID</th>
    <th>Title</th>
    <th>Duration</th>
    <th>Total Marks</th>
    <th>Action</th>
</tr>

<%
for(Map<String,String> e : exams){

    int examId = Integer.parseInt(e.get("exam_id"));
%>

<tr>
    <td><%= examId %></td>
    <td><%= e.get("title") %></td>
    <td><%= e.get("duration") %> mins</td>
    <td><%= e.get("total_marks") %></td>

    <td>

    <%
    if(attemptedExams.contains(examId)){
    %>

        <button class="btn btn-custom btn-done" disabled>
            ✔ Submitted
        </button>

    <%
    }else{
    %>

        <a href="<%= request.getContextPath() %>/startExam?exam_id=<%= examId %>"
           class="btn btn-custom btn-start">
           Start Exam
        </a>

    <%
    }
    %>

    </td>
</tr>

<%
}
%>

</table>

</div>

<%
}
%>

</div>
</div>

</body>
</html>