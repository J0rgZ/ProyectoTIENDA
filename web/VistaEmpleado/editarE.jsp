<%-- 
    Document   : editarE
    Created on : 5 oct 2023, 17:49:39
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../conexion.jsp" %>

<%
    String dni = request.getParameter("dni");
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String email = request.getParameter("email");
    String clave = request.getParameter("clave");
    String imagen = request.getParameter("imagen");

    try {
        PreparedStatement ps = con.prepareStatement("UPDATE tbempleado SET nombre=?, apellido=?, direccion=?, telefono=?, email=?, clave=?, imagen=? WHERE dni=?");
        ps.setString(1, nombre);
        ps.setString(2, apellido);
        ps.setString(3, direccion);
        ps.setString(4, telefono);
        ps.setString(5, email);
        ps.setString(6, clave);
        ps.setString(7, imagen);
        ps.setString(8, dni);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Empleado actualizado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al actualizar el empleado.");
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

