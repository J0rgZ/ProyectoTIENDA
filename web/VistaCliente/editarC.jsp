<%-- 
    Document   : editarE
    Created on : 5 oct 2023, 17:49:39
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../conexion.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Cliente</title>
</head>
<body>
    <%
        String dni = request.getParameter("dni");
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");

        try {
            PreparedStatement ps = con.prepareStatement("UPDATE tbcliente SET nombres=?, apellidos=? WHERE dni=?");
            ps.setString(1, nombres);
            ps.setString(2, apellidos);
            ps.setString(3, dni);
            int rowsUpdated = ps.executeUpdate();

            if (rowsUpdated > 0) {
                session.setAttribute("mensaje", "Cliente actualizado correctamente");
            } else {
                session.setAttribute("mensajeError", "Error al actualizar el cliente");
            }

            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("mensajeError", "Error al actualizar el cliente");
        }

        response.sendRedirect("index.jsp");
    %>
</body>
</html>


