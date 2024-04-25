<%-- 
    Document   : eliminarempleado
    Created on : 5 oct 2023, 17:41:34
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Eliminar Empleado</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }

            h1 {
                text-align: center;
            }

            form {
                max-width: 300px;
                margin: 0 auto;
                background: #f9f9f9;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 0 10px rgba(0,0,0,0.1);
                text-align: center;
            }

            input[type="submit"] {
                background-color: #f44336;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                cursor: pointer;
            }

            a {
                display: block;
                text-align: center;
                margin-top: 10px;
            }
            
            .cancelar-button {
                background-color: #f44336;
                color: #fff;
                border: none;
                border-radius: 5px;
                padding: 10px 20px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h1>¿Estás seguro que quieres eliminar este empleado?</h1>
        <form action="eliminarE.jsp" method="post">
            <input type="hidden" name="dni" value="<%= request.getParameter("dni") %>">
            <input type="submit" value="Eliminar">
            <input type="button" value="Cancelar" class="cancelar-button" onclick="window.location.href='index.jsp'">
        </form>
        
    </body>
</html>