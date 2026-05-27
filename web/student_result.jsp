<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
List<Map<String, Object>> results =
(List<Map<String, Object>>) request.getAttribute("results");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>My Results | NextGen Exam</title>

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
    display:flex;
    justify-content:space-between;
    align-items:center;
}

.navbar h2{
    margin:0;
    font-size:24px;
    font-weight:700;
    color:white;
}

.btn-top{
    border-radius:10px;
    padding:8px 14px;
    font-size:14px;
    font-weight:500;
    text-decoration:none;
    color:white;
}

.main-box{
    margin:40px auto;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 8px 30px rgba(0,0,0,0.25);
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
    text-align:center;
}

.table td{
    background: rgba(255,255,255,0.08);
    color:white !important;
    border-color: rgba(255,255,255,0.08);
    text-align:center;
    vertical-align:middle;
}

.empty-msg{
    text-align:center;
    font-size:18px;
    padding:20px;
}

@media(max-width:768px){
    .navbar{
        flex-direction:column;
        gap:10px;
        text-align:center;
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

<div class="navbar">
    <h2>My Results</h2>

    <div>
        <a href="studentDashboard" class="btn btn-primary btn-top me-2">
            Dashboard
        </a>

        <a href="logout" class="btn btn-danger btn-top">
            Logout
        </a>
    </div>
</div>

<div class="container">

<div class="main-box">

<div class="table-responsive">

<table class="table align-middle">

<tr>
    <th>Subject</th>
    <th>Score</th>
    <th>Correct Answers</th>
</tr>

<%
if (results != null && !results.isEmpty()) {
    for (Map<String, Object> r : results) {
%>

<tr>
    <td><%= r.get("subject") %></td>
    <td><%= r.get("score") %></td>
    <td><%= r.get("score") %> / <%= r.get("total") %></td>
</tr>

<%
    }
} else {
%>

<tr>
    <td colspan="3" class="empty-msg">No results found</td>
</tr>

<%
}
%>

</table>

</div>

</div>
</div>

</body>
</html>