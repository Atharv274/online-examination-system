<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Add Question | NextGen Exam</title>

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
align-items:center;
justify-content:center;
padding:30px 15px;
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
margin-bottom:25px;
}

.form-label{
font-weight:500;
margin-bottom:8px;
}

.form-control,
.form-select{
border:none;
border-radius:12px;
min-height:48px;
padding:12px 14px;
margin-bottom:15px;
}

textarea.form-control{
min-height:110px;
resize:none;
}

.form-control:focus,
.form-select:focus{
box-shadow:
0 0 0 3px rgba(255,255,255,0.18);
}

.btn-custom{
border:none;
border-radius:12px;
padding:11px 18px;
font-weight:600;
}

.btn-next{
background:
linear-gradient(to right,#0072ff,#00c6ff);
color:white;
}

.btn-finish{
background:
linear-gradient(to right,#00b09b,#96c93d);
color:white;
}

.btn-custom:hover{
opacity:0.92;
transform:translateY(-1px);
}

@media(max-width:576px){

.form-box{
padding:25px 18px;
}

.action-btns{
flex-direction:column;
gap:10px;
}

.action-btns button{
width:100%;
}
}
</style>

</head>

<body>

<div class="form-box">

<h3>Add Question</h3>

<form action="addQuestion"
method="post">

<input type="hidden"
name="exam_id"
value="<%= request.getAttribute("exam_id") %>">

<label class="form-label">
Question
</label>

<textarea name="question_text"
class="form-control"
required></textarea>

<input type="text"
name="optionA"
class="form-control"
placeholder="Option A"
required>

<input type="text"
name="optionB"
class="form-control"
placeholder="Option B"
required>

<input type="text"
name="optionC"
class="form-control"
placeholder="Option C"
required>

<input type="text"
name="optionD"
class="form-control"
placeholder="Option D"
required>

<label class="form-label">
Correct Answer
</label>

<select name="correct_answer"
class="form-select">

<option value="A">
Option A
</option>

<option value="B">
Option B
</option>

<option value="C">
Option C
</option>

<option value="D">
Option D
</option>

</select>

<div class="d-flex justify-content-between gap-3 mt-3 action-btns">

<button type="submit"
name="action"
value="next"
class="btn btn-custom btn-next w-100">

Save & Next

</button>

<button type="submit"
name="action"
value="finish"
class="btn btn-custom btn-finish w-100">

Save & Finish

</button>

</div>

</form>

</div>

</body>
</html>