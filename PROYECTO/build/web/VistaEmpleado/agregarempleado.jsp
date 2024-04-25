<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Añadir Empleado</title>
    <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
</head>
<body>
    <h1>Añadir Empleado</h1>
    <form action="agregarE.jsp" method="post">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required>
        <label for="dni">DNI:</label>
        <input type="text" id="dni" name="dni" required>
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name "direccion" required>
        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" name="telefono" required>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        <label for="clave">Clave:</label>
        <input type="password" id="clave" name="clave" required>
        <label for="imagen">Imagen (URL):</label>
        <input type="text" id="imagen" name="imagen" required>
        <input type="submit" value="Guardar">
        <input type="button" value="Cancelar" class="cancelar-button" onclick="window.location.href='index.jsp'">
    </form>
</body>
</html>

