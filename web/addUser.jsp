<%@ page contentType="text/html;charset=UTF-8" %>

<%
String role =
(String) session.getAttribute("role");

if(session.getAttribute("user")==null
   || !"admin".equalsIgnoreCase(role)){

    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">
<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Add Faculty | NextGen Exam</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
rel="stylesheet">

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
display:flex;
justify-content:center;
align-items:center;
padding:25px;
}

/* Glass Card */

.form-box{
width:100%;
max-width:520px;
background:
rgba(255,255,255,0.12);
backdrop-filter:blur(15px);
border-radius:22px;
padding:35px;
box-shadow:
0 8px 30px rgba(0,0,0,0.25);
}

/* Heading */

.form-box h2{
text-align:center;
font-weight:700;
margin-bottom:25px;
}

/* Labels */

label{
font-weight:500;
margin-bottom:8px;
display:block;
}

/* Inputs */

input,
select{
width:100%;
padding:12px 14px;
border:none;
border-radius:12px;
margin-bottom:18px;
background:
rgba(255,255,255,0.10);
color:white;
font-size:14px;
}

input::placeholder{
color:#ddd;
}

input:focus,
select:focus{
outline:none;
box-shadow:
0 0 0 3px rgba(255,255,255,0.18);
}

/* Dropdown Fix */

select option{
color:black;
}

/* Button */

.btn-add{
width:100%;
border:none;
border-radius:12px;
padding:12px;
font-size:15px;
font-weight:600;
color:white;
background:
linear-gradient(to right,#0072ff,#00c6ff);
transition:0.3s;
}

.btn-add:hover{
opacity:0.92;
transform:translateY(-2px);
}

/* Back */

.back-btn{
display:block;
margin-top:15px;
text-align:center;
text-decoration:none;
font-weight:500;
color:#d9ecff;
}

.back-btn:hover{
color:#00c6ff;
}

@media(max-width:576px){

.form-box{
padding:25px 20px;
}

}

</style>

<script>

function toggleSubject(){

    var role =
    document.getElementById("role").value;

    var subjectDiv =
    document.getElementById("subjectDiv");

    var subjectInput =
    document.getElementById("subjectInput");

    if(role === "faculty"){

        subjectDiv.style.display="block";
        subjectInput.required=true;

    }else{

        subjectDiv.style.display="none";
        subjectInput.required=false;
        subjectInput.value="";
    }
}

</script>

</head>

<body>

<div class="form-box">

<h2>Add Faculty / User</h2>

<form action="addUser" method="post">

<label>Name</label>

<input name="name"
       placeholder="Enter Name"
       required>

<label>Email</label>

<input type="email"
       name="email"
       placeholder="Enter Email"
       required>

<label>Password</label>

<input type="password"
       name="password"
       placeholder="Enter Password"
       required>

<label>Role</label>

<select name="role"
        id="role"
        onchange="toggleSubject()">

<option value="student">
Student
</option>

<option value="faculty">
Faculty
</option>

</select>

<!-- Subject -->

<div id="subjectDiv"
     style="display:none;">

<label>Subject Name</label>

<input type="text"
       id="subjectInput"
       name="subject_name"
       placeholder="Enter Subject Name">

</div>

<button type="submit"
        class="btn-add">

Add User

</button>

</form>

<a class="back-btn"
   href="dashboard">

← Back to Dashboard

</a>

</div>

</body>
</html>