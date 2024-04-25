<%-- 
    Document   : agregarE
    Created on : 5 oct 2023, 17:25:07
    Author     : HP
--%>

<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String nombre = request.getParameter("nombre");
    String apellido = request.getParameter("apellido");
    String dni = request.getParameter("dni");
    String direccion = request.getParameter("direccion");
    String telefono = request.getParameter("telefono");
    String email = request.getParameter("email");
    String clave = request.getParameter("clave");
    String imagen = request.getParameter("imagen"); // Nuevo campo de imagen

    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("INSERT INTO tbempleado (dni, nombre, apellido, direccion, telefono, email, clave, imagen) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, dni);
        ps.setString(2, nombre);
        ps.setString(3, apellido);
        ps.setString(4, direccion);
        ps.setString(5, telefono);
        ps.setString(6, email);
        ps.setString(7, clave);
        ps.setString(8, imagen); // Nuevo campo de imagen

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Empleado agregado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al añadir el empleado.");
            response.sendRedirect("index.jsp"); 
        }
    } catch (Exception e) {
        session.setAttribute("mensajeError", "Error al añadir el empleado. Por favor, inténtalo de nuevo más tarde.");
        e.printStackTrace();
        response.sendRedirect("index.jsp");
    } finally {
        try {
            if (ps != null) ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
