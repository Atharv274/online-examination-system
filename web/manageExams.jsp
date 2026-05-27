<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
String role =
(String) session.getAttribute("role");

List<Map<String,String>> exams =
(List<Map<String,String>>)request.getAttribute("exams");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Manage Exams | NextGen Exam</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    background:
    linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    min-height:100vh;
    color:white;
}

.header{
    background:
    rgba(255,255,255,0.08);
    backdrop-filter: blur(10px);
    color:white;
    padding:16px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:
    0 5px 20px rgba(0,0,0,0.25);
}

.header span{
    font-size:24px;
    font-weight:700;
}

.dashboard-btn{
    background:
    linear-gradient(to right,#0072ff,#00c6ff);
    color:white;
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-size:14px;
    font-weight:600;
}

.dashboard-btn:hover{
    opacity:0.92;
    color:white;
}

.container-box{
    width:90%;
    margin:auto;
    margin-top:35px;
    background:
    rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:22px;
    padding:30px;
    box-shadow:
    0 8px 30px rgba(0,0,0,0.25);
}

.container-box h2{
    margin-bottom:22px;
    font-weight:700;
}

.table-wrap{
    overflow-x:auto;
}

table{
    width:100%;
    border-collapse:collapse;
    color:white;
}

th{
    background:
    rgba(255,255,255,0.18);
    padding:14px;
    text-align:left;
}

td{
    padding:12px;
    background:
    rgba(255,255,255,0.08);
    border-bottom:
    1px solid rgba(255,255,255,0.08);
}

tr:hover td{
    background:
    rgba(255,255,255,0.14);
}

.btn{
    padding:8px 14px;
    border:none;
    border-radius:10px;
    font-size:13px;
    text-decoration:none;
    color:white;
    font-weight:500;
    margin-right:8px;
    display:inline-block;
}

.add{
    background:
    linear-gradient(to right,#0072ff,#00c6ff);
}

.delete{
    background:
    linear-gradient(to right,#e53935,#e35d5b);
}

.btn:hover{
    opacity:0.92;
    color:white;
}

@media(max-width:768px){

    .header{
        flex-direction:column;
        gap:12px;
        text-align:center;
    }

    .container-box{
        width:95%;
        padding:20px;
    }

    .header span{
        font-size:20px;
    }

    .btn{
        margin-bottom:6px;
    }
}
</style>

</head>

<body>

<!-- Header -->

<div class="header">

<span>
NextGen Exam - Manage Exams
</span>

<%
if("admin".equalsIgnoreCase(role)){
%>

<a href="adminDashboard"
   class="dashboard-btn">
Dashboard
</a>

<%
}else{
%>

<a href="dashboard"
   class="dashboard-btn">
Dashboard
</a>

<%
}
%>

</div>

<!-- Content -->

<div class="container-box">

<h2>

<%
if("admin".equalsIgnoreCase(role)){
%>

All Exams

<%
}else{
%>

My Subject Exams

<%
}
%>

</h2>

<div class="table-wrap">

<table>

<tr>
    <th>Title</th>
    <th>Duration</th>
    <th>Questions</th>
    <th>Action</th>
</tr>

<%
if(exams != null){

for(Map<String,String> e : exams){
%>

<tr>

<td>
<%= e.get("title") %>
</td>

<td>
<%= e.get("duration") %> mins
</td>

<td>
<%= e.get("count") %>
</td>

<td>

<a class="btn add"
href="addQuestion?exam_id=<%=e.get("id")%>">
Add Qs
</a>

<%
if("admin".equalsIgnoreCase(role)){
%>

<a class="btn delete"
href="deleteExam?id=<%=e.get("id")%>"
onclick="return confirm('Delete exam?')">
Delete
</a>

<%
}
%>

</td>

</tr>

<%
}
}
%>

</table>

</div>

</div>

</body>
</html>