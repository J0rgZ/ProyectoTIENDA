<%-- 
    Document   : agregarE
    Created on : 5 oct 2023, 17:25:07
    Author     : HP
--%>
<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String dni = request.getParameter("dni");
    String nombres = request.getParameter("nombres");
    String apellidos = request.getParameter("apellidos");

    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("INSERT INTO tbcliente (dni, nombres, apellidos) VALUES (?, ?, ?)");
        ps.setString(1, dni);
        ps.setString(2, nombres);
        ps.setString(3, apellidos);

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Cliente agregado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al añadir el cliente.");
            response.sendRedirect("index.jsp"); 
        }
    } catch (Exception e) {
        session.setAttribute("mensajeError", "Error al añadir el cliente. Por favor, inténtalo de nuevo más tarde.");
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
