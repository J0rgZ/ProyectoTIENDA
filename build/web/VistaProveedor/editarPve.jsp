<%-- 
    Document   : editarPve
    Created on : 5 oct 2023, 17:49:39
    Author     : HP
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../conexion.jsp" %>

<%
    String idProveedor = request.getParameter("idproveedor");
    String nombreProveedor = request.getParameter("nombreproveedor");
    String direccionProveedor = request.getParameter("direccionproveedor");
    String telefonoProveedor = request.getParameter("telefonoproveedor");

    try {
        PreparedStatement ps = con.prepareStatement("UPDATE tbproveedor SET nombreproveedor=?, direccionproveedor=?, telefonoproveedor=? WHERE idproveedor=?");
        ps.setString(1, nombreProveedor);
        ps.setString(2, direccionProveedor);
        ps.setString(3, telefonoProveedor);
        ps.setString(4, idProveedor);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Proveedor actualizado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al actualizar el proveedor.");
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>


