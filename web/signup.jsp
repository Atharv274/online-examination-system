<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | NextGen Exam</title>

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

        .signup-card{
            width:100%;
            max-width:430px;
            background: rgba(255,255,255,0.12);
            backdrop-filter: blur(15px);
            border-radius:20px;
            padding:40px 30px;
            box-shadow:0 8px 30px rgba(0,0,0,0.25);
            color:white;
        }

        .signup-card h2{
            text-align:center;
            font-weight:700;
            margin-bottom:10px;
        }

        .signup-card p{
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

        .btn-register{
            height:50px;
            border:none;
            border-radius:12px;
            background:linear-gradient(to right,#00b09b,#96c93d);
            color:white;
            font-weight:600;
            font-size:16px;
            transition:0.3s;
        }

        .btn-register:hover{
            transform:translateY(-2px);
            box-shadow:0 8px 18px rgba(0,0,0,0.2);
        }

        .login-text{
            text-align:center;
            margin-top:20px;
            font-size:14px;
            color:#eee;
        }

        .login-text a{
            color:#00c6ff;
            text-decoration:none;
            font-weight:600;
        }

        .login-text a:hover{
            text-decoration:underline;
        }

        @media(max-width:500px){
            .signup-card{
                margin:20px;
                padding:30px 20px;
            }
        }
    </style>
</head>

<body>

<div class="signup-card">

    <h2>Create Account</h2>
    <p>Register to access your exam portal</p>

    <form action="register" method="post">

        <input type="text"
               name="name"
               class="form-control"
               placeholder="Full Name"
               required>

        <input type="email"
               name="email"
               class="form-control"
               placeholder="Enter Email"
               required>

        <input type="password"
               name="password"
               class="form-control"
               placeholder="Create Password"
               required>

        <button type="submit" class="btn btn-register w-100">
            Register
        </button>

    </form>

    <div class="login-text">
        Already have account?
        <a href="login.jsp">Login</a>
    </div>

</div>

</body>
</html>