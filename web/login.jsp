<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | NextGen Exam</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family:'Poppins',sans-serif;
        }

        body{
            height:100vh;
            background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .login-card{
            width:100%;
            max-width:420px;
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(15px);
            border-radius:20px;
            padding:40px 30px;
            box-shadow:0 8px 30px rgba(0,0,0,0.25);
            color:white;
        }

        .login-card h2{
            text-align:center;
            font-weight:700;
            margin-bottom:10px;
        }

        .login-card p{
            text-align:center;
            font-size:14px;
            color:#dcdcdc;
            margin-bottom:30px;
        }

        .form-control{
            height:50px;
            border-radius:12px;
            border:none;
            padding-left:15px;
            margin-bottom:18px;
        }

        .form-control:focus{
            box-shadow:0 0 0 3px rgba(255,255,255,0.25);
        }

        .btn-login{
            height:50px;
            border:none;
            border-radius:12px;
            background:#00c6ff;
            background:linear-gradient(to right,#0072ff,#00c6ff);
            color:white;
            font-weight:600;
            font-size:16px;
            transition:0.3s;
        }

        .btn-login:hover{
            transform:translateY(-2px);
            box-shadow:0 8px 18px rgba(0,0,0,0.2);
        }

        .signup-text{
            text-align:center;
            margin-top:20px;
            font-size:14px;
            color:#eee;
        }

        .signup-text a{
            color:#00c6ff;
            text-decoration:none;
            font-weight:600;
        }

        .signup-text a:hover{
            text-decoration:underline;
        }

        @media(max-width:500px){
            .login-card{
                margin:20px;
                padding:30px 20px;
            }
        }
    </style>
</head>

<body>

<div class="login-card">

    <h2>Welcome Back</h2>
    <p>Login to continue your exam portal</p>

    <form action="login" method="post">

        <input type="email"
               name="email"
               class="form-control"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               class="form-control"
               placeholder="Enter Password"
               required>

        <button type="submit" class="btn btn-login w-100">
            Login
        </button>

    </form>

    <div class="signup-text">
        New user? <a href="signup.jsp">Create Account</a>
    </div>

</div>

</body>
</html>