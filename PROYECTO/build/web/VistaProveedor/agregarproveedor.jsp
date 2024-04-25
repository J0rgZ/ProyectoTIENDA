<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Añadir Proveedor</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        form {
            max-width: 500px;
            margin: 0 auto;
            background: #f9f9f9;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 10px 20px;
            cursor: pointer;
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
    <h1>Añadir Proveedor</h1>
    <form action="agregarPve.jsp" method="post">
        <label for="idproveedor">ID Proveedor:</label>
        <input type="text" id="idproveedor" name="idproveedor" required>
        <br>
        <label for="nombreproveedor">Nombre del Proveedor:</label>
        <input type="text" id="nombreproveedor" name="nombreproveedor" required>
        <br>
        <label for="direccionproveedor">Dirección del Proveedor:</label>
        <input type="text" id="direccionproveedor" name="direccionproveedor" required>
        <br>
        <label for="telefonoproveedor">Teléfono del Proveedor:</label>
        <input type="text" id="telefonoproveedor" name="telefonoproveedor" required>
        <br>

        <input type="submit" value="Guardar">
        <input type="button" value="Cancelar" class="cancelar-button" onclick="window.location.href='index.jsp'">
    </form>
</body>
</html>


