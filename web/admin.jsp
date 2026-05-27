<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
String role = (String) session.getAttribute("role");

if (role == null) {
    response.sendRedirect("login.jsp");
    return;
}

if (!(role.equalsIgnoreCase("admin")
   || role.equalsIgnoreCase("teacher")
   || role.equalsIgnoreCase("faculty"))) {

    response.sendRedirect("login.jsp");
    return;
}

List<String> labels =
(List<String>) request.getAttribute("labels");

List<Integer> data =
(List<Integer>) request.getAttribute("chartData");

if (labels == null) labels = new ArrayList<>();
if (data == null) data = new ArrayList<>();
%>

<!DOCTYPE html>
<html lang="en">
<head>

<meta charset="UTF-8">
<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Dashboard | NextGen Exam</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

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
backdrop-filter:blur(10px);
padding:15px 30px;
box-shadow:
0 5px 20px rgba(0,0,0,0.25);
}

.navbar-brand{
color:white !important;
font-size:22px;
font-weight:700;
}

.navbar a{
color:white !important;
margin-left:14px;
text-decoration:none;
font-size:14px;
}

.navbar a:hover{
color:#00c6ff !important;
}

.main-box{
margin-top:35px;
}

.card-box{
color:white;
padding:22px;
border-radius:18px;
font-size:18px;
font-weight:600;
text-align:center;
backdrop-filter:blur(12px);
box-shadow:
0 8px 25px rgba(0,0,0,0.20);
transition:0.3s;
}

.card-box:hover{
transform:translateY(-4px);
}

.blue{
background:rgba(37,99,235,0.75);
}

.green{
background:rgba(22,163,74,0.75);
}

.cyan{
background:rgba(6,182,212,0.75);
}

.yellow{
background:rgba(245,158,11,0.75);
}

.glass-card{
background:
rgba(255,255,255,0.12);
backdrop-filter:blur(15px);
border-radius:20px;
padding:25px;
box-shadow:
0 8px 30px rgba(0,0,0,0.25);
}

.glass-card h5{
font-weight:700;
margin-bottom:20px;
}

canvas{
background:
rgba(255,255,255,0.05);
border-radius:15px;
padding:12px;
}

.btn-action{
border-radius:12px;
font-weight:500;
padding:10px;
}

.form-control{
background:
rgba(255,255,255,0.10);
border:none;
color:white;
border-radius:10px;
}

.form-control::placeholder{
color:#ddd;
}

.sub-text{
color:#d5d5d5;
}

</style>

</head>

<body>

<nav class="navbar navbar-expand-lg">

<span class="navbar-brand">
NextGen Exam
</span>

<div class="ms-auto">

<%
if("admin".equalsIgnoreCase(role)){
%>

<a href="adminDashboard">
Dashboard
</a>

<%
}else{
%>

<a href="dashboard">
Dashboard
</a>

<%
}
%>

<a href="manageExams">
Manage Exams
</a>

<%
if("admin".equalsIgnoreCase(role)){
%>

<a href="viewUsers">
Students
</a>

<a href="addUser.jsp">
Add Faculty
</a>

<%
}
%>

<a href="viewResults">
Results
</a>

<a href="logout">
Logout
</a>

</div>

</nav>

<div class="container main-box">

<h3 class="fw-bold">
Welcome,
<%= session.getAttribute("username") %>!
</h3>

<p class="sub-text mb-4">
Here's a summary of your platform activity
</p>

<div class="row g-3">

<div class="col-md-3">
<div class="card-box blue">
${students}<br>
Total Students
</div>
</div>

<div class="col-md-3">
<div class="card-box green">
${exams}<br>
Total Exams
</div>
</div>

<div class="col-md-3">
<div class="card-box cyan">
${questions}<br>
Total Questions
</div>
</div>

<div class="col-md-3">
<div class="card-box yellow">
${submissions}<br>
Total Submissions
</div>
</div>

</div>

<div class="row mt-4 g-4">

<div class="col-md-8">

<div class="glass-card">

<h5>Exam Submissions</h5>

<canvas id="examChart">
</canvas>

</div>

</div>

<div class="col-md-4">

<div class="glass-card">

<h5>Quick Actions</h5>

<%
if("admin".equalsIgnoreCase(role)){
%>


<%
}else{
%>

<form action="quickCreateExam"
      method="get">

<input type="text"
       name="title"
       class="form-control mb-2"
       placeholder="Exam Title (MST, Test1, Quiz)"
       required>

<button class="btn btn-primary btn-action w-100 mb-2">
Create Exam
</button>

</form>

<%
}
%>

<a href="manageExams"
class="btn btn-info btn-action w-100 mb-2">
Manage Exams
</a>

<%
if("admin".equalsIgnoreCase(role)){
%>

<a href="addUser.jsp"
class="btn btn-warning btn-action w-100 mb-2">
Add Faculty
</a>

<a href="viewUsers"
class="btn btn-secondary btn-action w-100 mb-2">
Manage Students
</a>

<%
}
%>

<a href="viewResults"
class="btn btn-success btn-action w-100">
View Results
</a>

</div>

</div>

</div>

</div>

<script>

const labels = [
<% for(int i=0;i<labels.size();i++){ %>
"<%= labels.get(i) %>"
<%= (i<labels.size()-1)?",":"" %>
<% } %>
];

const values = [
<% for(int i=0;i<data.size();i++){ %>
<%= data.get(i) %>
<%= (i<data.size()-1)?",":"" %>
<% } %>
];

new Chart(
document.getElementById("examChart"),
{
type:"bar",

data:{
labels:labels,

datasets:[{
label:"Submissions",
data:values,
backgroundColor:"#60a5fa",
borderRadius:8
}]
},

options:{

plugins:{
legend:{
labels:{
color:"#ffffff",
font:{
size:14,
weight:"bold"
}
}
}
},

scales:{

x:{
ticks:{
color:"#ffffff",
font:{
size:13,
weight:"bold"
}
},
grid:{
color:"rgba(255,255,255,0.12)"
}
},

y:{
beginAtZero:true,
ticks:{
color:"#ffffff",
font:{
size:13,
weight:"bold"
}
},
grid:{
color:"rgba(255,255,255,0.12)"
}
}
}
}
});

</script>

</body>
</html>