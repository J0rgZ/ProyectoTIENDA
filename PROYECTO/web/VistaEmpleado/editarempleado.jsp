<%-- 
    Document   : editarempleado
    Created on : 5 oct 2023, 17:39:09
    Author     : HP
--%>

<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Empleado</title>
    <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
</head>
<body>
    <h1>EDITAR EMPLEADO</h1>
    <form action="editarE.jsp" method="post">
        <%
            String dni = request.getParameter("dni");
            String nombre = "";
            String apellido = "";
            String direccion = "";
            String telefono = "";
            String email = "";
            String clave = "";
            String imagen = "";

            try {
                PreparedStatement ps = con.prepareStatement("SELECT nombre, apellido, direccion, telefono, email, clave, imagen FROM tbempleado WHERE dni = ?");
                ps.setString(1, dni);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    nombre = rs.getString("nombre");
                    apellido = rs.getString("apellido");
                    direccion = rs.getString("direccion");
                    telefono = rs.getString("telefono");
                    email = rs.getString("email");
                    clave = rs.getString("clave");
                    imagen = rs.getString("imagen");
                }

                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <input type="hidden" name="dni" value="<%= dni %>">
        <label for="dni">DNI:</label>
        <input type="text" id="dni" name="dni" value="<%= dni %>" readonly>
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required value="<%= nombre %>">
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required value="<%= apellido %>">
        <label for="direccion">Dirección:</label>
        <input type="text" id="direccion" name="direccion" required value="<%= direccion %>">
        <label for="telefono">Teléfono:</label>
        <input type="text" id="telefono" name="telefono" required value="<%= telefono %>">
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required value="<%= email %>">
        <label for="clave">Clave:</label>
        <input type="password" id="clave" name="clave" required value="<%= clave %>">
        <label for="imagen">Imagen (URL):</label>
        <input type="text" id="imagen" name="imagen" required value="<%= imagen %>">
        <input type="submit" value="Guardar Cambios">
    </form>
</body>
</html>
