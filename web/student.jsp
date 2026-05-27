<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.user" %>
<%@ page import="java.util.*" %>

<%
user u = (user) session.getAttribute("user");

if(u == null){
    response.sendRedirect("login.jsp");
    return;
}

Map<String, Double> percentageMap =
    (Map<String, Double>) request.getAttribute("percentageMap");

if(percentageMap == null){
    percentageMap = new LinkedHashMap<>();
}

Integer totalExams = (Integer) request.getAttribute("totalExams");
Double avgScore = (Double) request.getAttribute("avgScore");
Integer bestScore = (Integer) request.getAttribute("bestScore");

if(totalExams == null) totalExams = 0;
if(avgScore == null) avgScore = 0.0;
if(bestScore == null) bestScore = 0;
%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Student Dashboard | NextGen Exam</title>

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
}

.navbar-brand{
    color:white !important;
    font-size:22px;
    font-weight:700;
}

.section-box{
    background: rgba(255,255,255,0.12);
    backdrop-filter: blur(15px);
    padding:30px;
    border-radius:20px;
    margin-bottom:25px;
    box-shadow:0 8px 30px rgba(0,0,0,0.25);
}

.section-box h5{
    font-weight:700;
    margin-bottom:20px;
}

.summary-card{
    background: rgba(255,255,255,0.08);
    border-radius:15px;
    padding:20px;
    transition:0.3s;
}

.summary-card:hover{
    transform:translateY(-4px);
}

.summary-card h6{
    color:#dcdcdc;
    margin-bottom:10px;
}

.summary-card b{
    font-size:26px;
    color:white;
}

.top-btn{
    border-radius:10px;
    padding:8px 14px;
    font-size:14px;
}

canvas{
    background: rgba(255,255,255,0.05);
    border-radius:15px;
    padding:15px;
}

@media(max-width:768px){
    .navbar{
        padding:15px;
    }

    .section-box{
        padding:20px;
    }

    .summary-card{
        margin-bottom:15px;
    }
}
</style>

</head>

<body>

<!-- Navbar -->
<nav class="navbar px-4">
    <span class="navbar-brand">NextGen Exam</span>

    <div class="ms-auto">
        <a href="<%= request.getContextPath() %>/studentDashboard"
           class="btn btn-primary top-btn">
           Dashboard
        </a>

        <a href="<%= request.getContextPath() %>/viewExams"
           class="btn btn-secondary top-btn me-2">
           View Exams
        </a>

        <a href="<%= request.getContextPath() %>/studentResult"
           class="btn btn-success top-btn me-2">
           Results
        </a>

        <a href="logout"
           class="btn btn-danger top-btn">
           Logout
        </a>
    </div>
</nav>

<div class="container mt-4">

<!-- Summary -->
<div class="section-box">
    <h5>Performance Summary</h5>

    <div class="row text-center g-3">

        <div class="col-md-4">
            <div class="summary-card">
                <h6>Total Exams</h6>
                <b><%= totalExams %></b>
            </div>
        </div>

        <div class="col-md-4">
            <div class="summary-card">
                <h6>Average Score</h6>
                <b><%= String.format("%.2f", avgScore) %>%</b>
            </div>
        </div>

        <div class="col-md-4">
            <div class="summary-card">
                <h6>Best Score</h6>
                <b><%= bestScore %></b>
            </div>
        </div>

    </div>
</div>

<!-- Chart -->
<div class="section-box">
    <h5>Score History</h5>
    <canvas id="chart"></canvas>
</div>

</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
let labels = [];
let data = [];

<%
for(Map.Entry<String, Double> entry : percentageMap.entrySet()){
%>
labels.push("<%= entry.getKey() %>");
data.push(<%= String.format("%.2f", entry.getValue()) %>);
<%
}
%>

if(data.length === 0){
    labels = ["No Data"];
    data = [0];
}

new Chart(document.getElementById("chart"), {
    type: 'line',
    data: {
        labels: labels,
        datasets: [{
            label: "Percentage (%)",
            data: data,
            borderColor: "#00ff99",
            backgroundColor: "#00ff99",
            borderWidth: 3,
            pointRadius: 5,
            pointHoverRadius: 7,
            fill: false,
            tension: 0.4
        }]
    },
    options: {
        plugins:{
            legend:{
                labels:{
                    color:"white"
                }
            }
        },
        scales: {
            x: {
                ticks:{
                    color:"white"
                },
                grid:{
                    color:"rgba(255,255,255,0.08)"
                }
            },
            y: {
                beginAtZero: true,
                max: 100,
                ticks:{
                    color:"white"
                },
                grid:{
                    color:"rgba(255,255,255,0.08)"
                }
            }
        }
    }
});
</script>

</body>
</html>