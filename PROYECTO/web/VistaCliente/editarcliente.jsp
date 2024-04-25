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
    <title>Editar Cliente</title>
    <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
</head>
<body>
    <h1>Editar Cliente</h1>
    <form action="editarC.jsp" method="post">
        <%
            String dni = request.getParameter("dni");
            String nombres = "";
            String apellidos = "";

            try {
                PreparedStatement ps = con.prepareStatement("SELECT nombres, apellidos FROM tbcliente WHERE dni = ?");
                ps.setString(1, dni);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    nombres = rs.getString("nombres");
                    apellidos = rs.getString("apellidos");
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
        <label for="nombres">Nombres:</label>
        <input type="text" id="nombres" name="nombres" required value="<%= nombres %>">
        <label for="apellidos">Apellidos:</label>
        <input type="text" id="apellidos" name="apellidos" required value="<%= apellidos %>">
        <input type="submit" value="Guardar Cambios">
    </form>
</body>
</html>
