<%-- 
    Document   : agregarE
    Created on : 5 oct 2023, 17:25:07
    Author     : HP
--%>

<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idProveedor = request.getParameter("idproveedor");
    String nombreProveedor = request.getParameter("nombreproveedor");
    String direccionProveedor = request.getParameter("direccionproveedor");
    String telefonoProveedor = request.getParameter("telefonoproveedor");

    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("INSERT INTO tbproveedor (idproveedor, nombreproveedor, direccionproveedor, telefonoproveedor) VALUES (?, ?, ?, ?)");
        ps.setString(1, idProveedor);
        ps.setString(2, nombreProveedor);
        ps.setString(3, direccionProveedor);
        ps.setString(4, telefonoProveedor);

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Proveedor agregado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al añadir el proveedor.");
            response.sendRedirect("index.jsp"); 
        }
    } catch (Exception e) {
        session.setAttribute("mensajeError", "Error al añadir el proveedor. Por favor, inténtalo de nuevo más tarde.");
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
