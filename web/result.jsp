<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
List<Map<String, Object>> results =
(List<Map<String, Object>>) request.getAttribute("results");

String role =
(String) session.getAttribute("role");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Results | NextGen Exam</title>

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

.navbar{
    background:
    rgba(255,255,255,0.08);
    backdrop-filter: blur(10px);
    padding:16px 30px;
    color:white;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 5px 20px rgba(0,0,0,0.25);
}

.navbar h2{
    font-size:24px;
    font-weight:700;
}

.nav-buttons a{
    text-decoration:none;
    margin-left:10px;
}

.btn{
    padding:9px 16px;
    border-radius:10px;
    color:white;
    font-size:14px;
    font-weight:600;
    display:inline-block;
}

.dashboard{
    background:
    linear-gradient(to right,#0072ff,#00c6ff);
}

.exams{
    background:
    linear-gradient(to right,#6c757d,#8a8f94);
}

.logout{
    background:
    linear-gradient(to right,#e53935,#e35d5b);
}

.btn:hover{
    opacity:0.92;
}

.container-box{
    width:90%;
    margin:35px auto;
    background:
    rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:22px;
    padding:30px;
    box-shadow:
    0 8px 30px rgba(0,0,0,0.25);
}

.page-title{
    text-align:center;
    margin-bottom:25px;
    font-size:28px;
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
    text-align:center;
}

td{
    padding:12px;
    text-align:center;
    background:
    rgba(255,255,255,0.08);
    border-bottom:
    1px solid rgba(255,255,255,0.08);
}

tr:hover td{
    background:
    rgba(255,255,255,0.14);
}

.no-data{
    font-weight:500;
}
</style>

</head>

<body>

<div class="navbar">

<h2>NextGen Exam</h2>

<div class="nav-buttons">

<%
if("admin".equalsIgnoreCase(role)){
%>

<a href="adminDashboard"
   class="btn dashboard">
Dashboard
</a>

<a href="manageExams"
   class="btn exams">
Manage Exams
</a>

<%
}else{
%>

<a href="dashboard"
   class="btn dashboard">
Dashboard
</a>

<%
}
%>

<a href="logout"
   class="btn logout">
Logout
</a>

</div>

</div>

<div class="container-box">

<h2 class="page-title">

<%
if("admin".equalsIgnoreCase(role)){
%>
All Student Results
<%
}else{
%>
My Subject Results
<%
}
%>

</h2>

<div class="table-wrap">

<table>

<tr>
    <th>Student</th>
    <th>Subject</th>
    <th>Score</th>
    <th>Correct Answers</th>
</tr>

<%
if(results != null && !results.isEmpty()){

for(Map<String,Object> r : results){
%>

<tr>
    <td><%= r.get("student") %></td>
    <td><%= r.get("subject") %></td>
    <td><%= r.get("score") %></td>
    <td>
        <%= r.get("score") %> /
        <%= r.get("total") %>
    </td>
</tr>

<%
}
}else{
%>

<tr>
<td colspan="4"
    class="no-data">

No results found

</td>
</tr>

<%
}
%>

</table>

</div>
</div>

</body>
</html>