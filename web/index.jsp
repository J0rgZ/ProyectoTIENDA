<%-- 
    Document   : index
    Created on : 9 oct 2023, 0:46:22
    Author     : JORGE
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            background-color: #ecf0f1; /* Gris claro que combina bien con verde */
        }

        .login-container {
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            max-width: 400px; /* Limité el ancho del formulario para mejorar la visión */
            width: 100%;
            text-align: center;
        }

        .login-container h1 {
            margin-bottom: 20px;
            color: #333;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }

        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box; 
        }

        .submit-button {
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
        }

        .submit-button:hover {
            background-color: #45a049;
        }

        .mensaje-flotante, .mensaje-flotante-error {
            position: fixed;
            bottom: 10px; 
            right: 10px;
            padding: 10px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: none; 
        }

        .mensaje-flotante {
            background-color: #4caf50;
            color: #fff;
        }

        .mensaje-flotante-error {
            background-color: #f44336;
            color: #fff;
        }
    </style>
    <script>
            setTimeout(function() {
                var mensajeElement = document.querySelector('.mensaje-flotante');
                mensajeElement.style.display = 'none';
            }, 5000);

            window.addEventListener('load', function() {
                var mensajeElement = document.querySelector('.mensaje-flotante');
                mensajeElement.style.display = 'block';
            });
            
            setTimeout(function() {
                var mensajeErrorElement = document.querySelector('.mensaje-flotante-error');
                mensajeErrorElement.style.display = 'none';
            }, 5000);
    </script>
</head>
<body>
    <div class="login-container">
        <h1>QUANTUM SYSTEMS</h1>
        <form action="loginCheck.jsp" method="post">
            <div class="form-group">
                <label>USUARIO/DNI:</label>
                <input type="text" name="dni" required>
            </div>
            <div class="form-group">
                <label for="clave">CONTRASEÑA:</label>
                <input type="password" name="clave" required>
            </div>
            <input type="submit" class="submit-button" value="Iniciar Sesión">
        </form>
    </div>
    <div class="mensaje-flotante">
            <%= session.getAttribute("mensaje") %>
            <% session.removeAttribute("mensaje"); %>
    </div>
    <div class="mensaje-flotante-error">
        <%= session.getAttribute("mensajeError") %>
        <% session.removeAttribute("mensajeError"); %>
    </div>
</body>
</html>


