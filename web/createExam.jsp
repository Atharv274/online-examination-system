<%@ page contentType="text/html; charset=UTF-8" %>

<%
String role =
(String) session.getAttribute("role");

String subject =
(String) session.getAttribute("subject");
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Create Exam | NextGen Exam</title>

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
    display:flex;
    justify-content:center;
    align-items:center;
    padding:20px;
}

.form-box{
    width:100%;
    max-width:650px;
    background:
    rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:22px;
    padding:35px;
    box-shadow:
    0 8px 30px rgba(0,0,0,0.25);
    color:white;
}

.form-box h3{
    text-align:center;
    font-weight:700;
    margin-bottom:28px;
}

.form-label{
    font-weight:500;
    margin-bottom:8px;
}

.form-control{
    border:none;
    border-radius:12px;
    min-height:48px;
    padding:12px 14px;
    margin-bottom:18px;
}

.form-control:focus{
    box-shadow:
    0 0 0 3px rgba(255,255,255,0.18);
}

.btn-create{
    width:100%;
    border:none;
    border-radius:12px;
    padding:12px;
    font-size:16px;
    font-weight:600;
    color:white;
    background:
    linear-gradient(to right,#0072ff,#00c6ff);
    transition:0.3s;
}

.btn-create:hover{
    opacity:0.92;
    transform:translateY(-2px);
}

@media(max-width:576px){
    .form-box{
        padding:25px 18px;
    }
}
</style>

</head>

<body>

<div class="form-box">

<h3>Create Exam</h3>

<form action="${pageContext.request.contextPath}/createExam"
      method="post">

<label class="form-label">
Course Name
</label>

<%
if("admin".equalsIgnoreCase(role)){
%>

<input type="text"
       class="form-control"
       name="course_name"
       placeholder="Enter Course Name"
       required>

<%
}else{
%>

<input type="text"
       class="form-control"
       name="course_name"
       value="<%=subject%>"
       readonly
       required>

<%
}
%>

<label class="form-label">
Course Code
</label>

<input type="text"
       class="form-control"
       name="course_code"
       placeholder="Enter Course Code"
       required>

<label class="form-label">
Total Marks (No. of MCQs)
</label>

<input type="number"
       class="form-control"
       name="total"
       placeholder="Enter Total Marks"
       required>

<label class="form-label">
Duration (minutes)
</label>

<input type="number"
       class="form-control"
       name="duration"
       placeholder="Enter Duration"
       required>

<button class="btn-create">
Next → Add Questions
</button>

</form>

</div>

</body>
</html>