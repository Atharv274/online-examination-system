<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Exam | NextGen Exam</title>

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
    padding:40px 15px;
    color:white;
}

.container{
    width:100%;
    max-width:900px;
    margin:auto;
}

.header-box{
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    border-radius:20px;
    padding:25px;
    margin-bottom:25px;
    box-shadow:0 8px 30px rgba(0,0,0,0.25);
    text-align:center;
}

.header-box h2{
    font-size:30px;
    font-weight:700;
}

.question{
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    padding:22px;
    margin-bottom:18px;
    border-radius:18px;
    box-shadow:0 8px 25px rgba(0,0,0,0.20);
}

.question p{
    font-size:18px;
    font-weight:600;
    margin-bottom:18px;
    line-height:1.5;
}

.option{
    display:block;
    background: rgba(255,255,255,0.08);
    padding:12px 14px;
    border-radius:12px;
    margin-bottom:10px;
    cursor:pointer;
    transition:0.3s;
}

.option:hover{
    background: rgba(255,255,255,0.16);
}

.option input{
    margin-right:10px;
    transform:scale(1.1);
}

.submit-btn{
    width:100%;
    padding:14px;
    border:none;
    border-radius:14px;
    font-size:17px;
    font-weight:600;
    color:white;
    background:linear-gradient(to right,#0072ff,#00c6ff);
    cursor:pointer;
    transition:0.3s;
}

.submit-btn:hover{
    opacity:0.92;
    transform:translateY(-2px);
}

@media(max-width:768px){
    .question p{
        font-size:16px;
    }

    .header-box h2{
        font-size:24px;
    }
}
</style>

</head>

<body>

<div class="container">

<div class="header-box">
    <h2>Exam Started</h2>
</div>

<form action="submitExam" method="post">

<%
List<Map<String,String>> questions =
(List<Map<String,String>>)request.getAttribute("questions");

int i = 1;

for(Map<String,String> q : questions){
%>

<div class="question">

<p>Q<%= i++ %>. <%= q.get("text") %></p>

<label class="option">
    <input type="radio"
           name="q<%= q.get("id") %>"
           value="a"
           required>
    <%= q.get("A") %>
</label>

<label class="option">
    <input type="radio"
           name="q<%= q.get("id") %>"
           value="b">
    <%= q.get("B") %>
</label>

<label class="option">
    <input type="radio"
           name="q<%= q.get("id") %>"
           value="c">
    <%= q.get("C") %>
</label>

<label class="option">
    <input type="radio"
           name="q<%= q.get("id") %>"
           value="d">
    <%= q.get("D") %>
</label>

</div>

<%
}
%>

<button type="submit" class="submit-btn">
    Submit Exam
</button>

</form>

</div>

</body>
</html>