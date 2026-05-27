<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>NextGen Exam</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <link rel="stylesheet" href="<%= request.getContextPath() %>/css/home.css">
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <div class="logo">
    <h2>NextGen <span>Exam</span></h2>
  </div>

  <ul class="nav-links">
    <li><a href="#" class="active">Home</a></li>
    <li><a href="#features">Features</a></li>
    <li><a href="#about">About</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="login.jsp">Login</a></li>
  </ul>
</nav>

<!-- HERO -->
<section class="hero">
  <div class="hero-content">
    <h1>
      Conduct Secure <span>Online Exams</span><br>
      Anytime, Anywhere
    </h1>

    <p>
      NextGen Exam helps colleges conduct secure, scalable online tests.
    </p>

    <div class="hero-buttons">
      <a href="login.jsp" class="btn primary">Get Started</a>
      <a href="signup.jsp" class="btn secondary">Register</a>
    </div>
  </div>

  <div class="hero-image">
    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135755.png">
  </div>
</section>

<!-- FEATURES -->
<section class="features" id="features">
  <div class="section-title">
    <h2>Our Powerful Features</h2>
    <p>Smart tools to simplify online examinations</p>
  </div>

  <div class="features-grid">

    <div class="feature-card">
      <div class="icon">🛡️</div>
      <h3>Secure Exams</h3>
      <p>Advanced security system for fair testing.</p>
    </div>

    <div class="feature-card">
      <div class="icon">⚡</div>
      <h3>Auto Evaluation</h3>
      <p>Instant automated grading system.</p>
    </div>

    <div class="feature-card">
      <div class="icon">📊</div>
      <h3>Analytics</h3>
      <p>Track performance with reports.</p>
    </div>

  </div>
</section>

<!-- STATS -->
<section class="stats">
  <div class="stats-container">

    <div class="stat-box">
      <h2 class="counter" data-target="1000">0</h2>
      <p>Students</p>
    </div>

    <div class="stat-box">
      <h2 class="counter" data-target="500">0</h2>
      <p>Exams</p>
    </div>

    <div class="stat-box">
      <h2 class="counter" data-target="99">0</h2>
      <p>Success Rate</p>
    </div>

    <div class="stat-box">
      <h2 class="counter" data-target="24">0</h2>
      <p>Support</p>
    </div>

  </div>
</section>

<!-- FOOTER -->
<footer class="footer" id="contact">
  <div class="footer-bottom">
    NextGen Exam. All rights reserved.
  </div>
</footer>

<script src="<%= request.getContextPath() %>/js/home.js"></script>

</body>
</html>