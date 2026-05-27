<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Question" %>

<%
List<Question> questions =
(List<Question>) session.getAttribute("questions");

Map<String,String> answers =
(Map<String,String>) session.getAttribute("answers");

if(answers == null){
    answers = new HashMap<>();
    session.setAttribute("answers", answers);
}

if(questions == null || questions.isEmpty()){
%>
<p style="color:red; text-align:center; margin-top:50px; font-size:22px;">
    Error: Questions not loaded
</p>
<%
return;
}

int current = request.getParameter("q") != null ?
        Integer.parseInt(request.getParameter("q")) : 1;

Question q = questions.get(current - 1);

int attempted = answers.size();
int total = questions.size();
int notVisited = total - attempted;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Take Exam | NextGen Exam</title>

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
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 30px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(10px);
    box-shadow:0 5px 20px rgba(0,0,0,0.25);
}

.header h2{
    font-size:24px;
    font-weight:700;
}

/* Layout */
.main{
    display:flex;
    gap:20px;
    padding:25px;
}

/* Sidebar */
.sidebar{
    width:28%;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    padding:22px;
    border-radius:20px;
    box-shadow:0 8px 30px rgba(0,0,0,0.20);
}

.sidebar p{
    margin-bottom:12px;
    font-size:15px;
}

.grid{
    display:grid;
    grid-template-columns:repeat(5,1fr);
    gap:10px;
    margin-top:18px;
}

.grid a{
    text-decoration:none;
}

.qbox{
    padding:10px;
    text-align:center;
    border-radius:10px;
    background: rgba(255,255,255,0.08);
    color:white;
    font-weight:600;
    transition:0.3s;
}

.qbox:hover{
    background: rgba(255,255,255,0.18);
}

.qbox.answered{
    background:#16a34a;
}

.qbox.current{
    background:#0072ff;
}

/* Content */
.content{
    width:72%;
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    padding:28px;
    border-radius:20px;
    box-shadow:0 8px 30px rgba(0,0,0,0.20);
}

.content h3{
    font-size:24px;
    margin-bottom:15px;
}

.question-text{
    font-size:18px;
    margin-bottom:20px;
    line-height:1.6;
}

/* Options */
.option{
    display:block;
    margin-bottom:12px;
    padding:14px;
    border-radius:14px;
    background: rgba(255,255,255,0.08);
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

/* Footer Buttons */
.footer{
    margin-top:28px;
    display:flex;
    justify-content:space-between;
    gap:10px;
}

.btn{
    padding:12px 22px;
    border:none;
    border-radius:12px;
    font-size:15px;
    font-weight:600;
    color:white;
    cursor:pointer;
}

.prev{
    background:linear-gradient(to right,#6c757d,#8a8f94);
}

.next{
    background:linear-gradient(to right,#0072ff,#00c6ff);
}

.submit{
    background:linear-gradient(to right,#00b09b,#96c93d);
}

.btn:hover{
    opacity:0.92;
}

@media(max-width:900px){
    .main{
        flex-direction:column;
    }

    .sidebar,
    .content{
        width:100%;
    }

    .grid{
        grid-template-columns:repeat(5,1fr);
    }
}

@media(max-width:500px){
    .grid{
        grid-template-columns:repeat(4,1fr);
    }

    .footer{
        flex-direction:column;
    }

    .btn{
        width:100%;
    }
}
</style>

</head>

<body>

<div class="header">
    <h2>NextGen Exam</h2>
</div>

<div class="main">

<!-- Sidebar -->
<div class="sidebar">

    <p><b>Attempted:</b> <%=attempted%> / <%=total%></p>
    <p><b>Not Visited:</b> <%=notVisited%></p>

    <div class="grid">

    <% for(int i=1;i<=total;i++){

        String cls = "";

        if(answers.containsKey("q"+questions.get(i-1).getQuestionId())){
            cls = "answered";
        }

        if(i == current){
            cls = "current";
        }
    %>

        <a href="<%=request.getContextPath()%>/takeExam.jsp?q=<%=i%>">
            <div class="qbox <%=cls%>"><%=i%></div>
        </a>

    <% } %>

    </div>

</div>

<!-- Question Area -->
<div class="content">

<h3>Question <%=current%></h3>

<p class="question-text">
    <%= q.getText() %>
</p>

<form method="post">

<label class="option">
<input type="radio" name="answer" value="A"
<%= "A".equals(answers.get("q"+q.getQuestionId()))?"checked":"" %>>
<%= q.getOptionA() %>
</label>

<label class="option">
<input type="radio" name="answer" value="B"
<%= "B".equals(answers.get("q"+q.getQuestionId()))?"checked":"" %>>
<%= q.getOptionB() %>
</label>

<label class="option">
<input type="radio" name="answer" value="C"
<%= "C".equals(answers.get("q"+q.getQuestionId()))?"checked":"" %>>
<%= q.getOptionC() %>
</label>

<label class="option">
<input type="radio" name="answer" value="D"
<%= "D".equals(answers.get("q"+q.getQuestionId()))?"checked":"" %>>
<%= q.getOptionD() %>
</label>

<input type="hidden" name="qid" value="<%=q.getQuestionId()%>">
<input type="hidden" name="current" value="<%=current%>">

<div class="footer">

<% if(current > 1){ %>
<button type="submit"
        formaction="saveAnswer"
        name="action"
        value="prev"
        class="btn prev">
    Previous
</button>
<% } else { %>
<div></div>
<% } %>

<% if(current < total){ %>

<button type="submit"
        formaction="saveAnswer"
        name="action"
        value="next"
        class="btn next">
    Next
</button>

<% } else { %>

<button type="submit"
        formaction="saveAnswer"
        name="action"
        value="submit"
        class="btn submit"
        onclick="return confirm('Are you sure you want to submit?');">
    Submit
</button>

<% } %>

</div>

</form>

</div>

</div>

</body>
</html>