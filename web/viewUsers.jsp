<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.user" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>All Users | NextGen Exam</title>

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

/* Header */
.header{
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(10px);
    padding:15px 30px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 5px 20px rgba(0,0,0,0.25);
}

.header span{
    font-size:22px;
    font-weight:700;
    color:white;
}

/* Buttons */
.dashboard-btn{
    background:#3498db;
    color:white;
    padding:10px 18px;
    border-radius:10px;
    text-decoration:none;
    font-size:14px;
    font-weight:500;
}

.dashboard-btn:hover{
    background:#2980b9;
    color:white;
}

/* Main Container */
.container-box{
    width:90%;
    margin:auto;
    margin-top:35px;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:20px;
    padding:30px;
    box-shadow:0 8px 30px rgba(0,0,0,0.25);
}

.container-box h2{
    margin-bottom:20px;
    font-weight:700;
    color:white;
}

/* Table */
.table{
    color:white;
    border-radius:14px;
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

.table tr:hover td{
    background: rgba(255,255,255,0.14);
}

/* Delete */
.delete-btn{
    background:#e74c3c;
    color:white;
    padding:8px 14px;
    border-radius:10px;
    text-decoration:none;
    font-size:13px;
    font-weight:500;
}

.delete-btn:hover{
    background:#c0392b;
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
}
</style>

</head>

<body>

<!-- Header -->
<div class="header">

    <span>NextGen Exam - All Users</span>

    <a href="dashboard" class="dashboard-btn">
        Dashboard
    </a>

</div>

<!-- Content -->
<div class="container-box">

<h2>All Users</h2>

<div class="table-responsive">

<table class="table align-middle">

<tr>
    <th>Name</th>
    <th>Email</th>
    <th>Role</th>
    <th>Action</th>
</tr>

<%
List<user> users = (List<user>)request.getAttribute("users");

if(users != null){
    for(user u : users){
%>

<tr>

    <td><%= u.getName() %></td>
    <td><%= u.getEmail() %></td>
    <td><%= u.getRole() %></td>

    <td>
        <a class="delete-btn"
           href="${pageContext.request.contextPath}/deleteUser?email=<%= u.getEmail() %>"
           onclick="return confirm('Delete this user?')">
           Delete
        </a>
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