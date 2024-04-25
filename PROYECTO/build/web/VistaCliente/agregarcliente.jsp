<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Añadir Cliente</title>
        <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
    </head>
    <body>
        <h1>Añadir Cliente</h1>
        <form action="agregarC.jsp" method="post">
            <label for="dni">DNI:</label>
            <input type="text" id="dni" name="dni" required>
            <label for="nombres">Nombres:</label>
            <input type="text" id="nombres" name="nombres" required>
            <label for="apellidos">Apellidos:</label>
            <input type="text" id="apellidos" name="apellidos" required>
            <input type="submit" value="Guardar">
            <input type="button" value="Cancelar" class="cancelar-button" onclick="window.location.href='index.jsp'">
        </form>
    </body>
</html>
