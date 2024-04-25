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
    <title>Editar Proveedor</title>
    <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
</head>
<body>
    <h1>Editar Proveedor</h1>
    <form action="editarPve.jsp" method="post">
        <%
            String idProveedor = request.getParameter("idproveedor");
            String nombreProveedor = "";
            String direccionProveedor = "";
            String telefonoProveedor = "";

            try {
                PreparedStatement ps = con.prepareStatement("SELECT nombreproveedor, direccionproveedor, telefonoproveedor FROM tbproveedor WHERE idproveedor = ?");
                ps.setString(1, idProveedor);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    nombreProveedor = rs.getString("nombreproveedor");
                    direccionProveedor = rs.getString("direccionproveedor");
                    telefonoProveedor = rs.getString("telefonoproveedor");
                }

                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <input type="hidden" name="idproveedor" value="<%= idProveedor %>">
        <label for="idproveedor">ID del Proveedor:</label>
        <input type="text" id="idproveedor" name="idproveedor" value="<%= idProveedor %>" readonly>
        <label for="nombreproveedor">Nombre del Proveedor:</label>
        <input type="text" id="nombreproveedor" name="nombreproveedor" required value="<%= nombreProveedor %>">
        <label for="direccionproveedor">Dirección del Proveedor:</label>
        <input type="text" id="direccionproveedor" name="direccionproveedor" required value="<%= direccionProveedor %>">
        <label for="telefonoproveedor">Teléfono del Proveedor:</label>
        <input type="text" id="telefonoproveedor" name="telefonoproveedor" required value="<%= telefonoProveedor %>">
        <input type="submit" value="Guardar Cambios">
    </form>
</body>
</html>