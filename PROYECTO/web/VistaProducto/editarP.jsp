<%-- 
    Document   : editarE
    Created on : 5 oct 2023, 17:49:39
    Author     : HP
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../conexion.jsp" %>

<%
    String idproducto = request.getParameter("idproducto");
    String nombreproducto = request.getParameter("nombreproducto");
    String categoria = request.getParameter("categoria");
    String descripcion = request.getParameter("descripcion");
    String precio = request.getParameter("precio");
    String imagen = request.getParameter("imagen");
    String estado = request.getParameter("estado");

    try {
        PreparedStatement ps = con.prepareStatement("UPDATE tbproducto SET nombreproducto=?, categoria=?, descripcion=?,  precio=?, imagen=?, estado=? WHERE idproducto=?");
        ps.setString(1, nombreproducto);
        ps.setString(2, categoria);
        ps.setString(3, descripcion);
        ps.setString(4, precio);
        ps.setString(5, imagen);
        ps.setBoolean(6, estado != null && estado.equals("1"));
        ps.setString(7, idproducto);

        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Producto actualizado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al actualizar el producto.");
            response.sendRedirect("index.jsp");
        }
    } catch (Exception e) {
        session.setAttribute("mensajeError", "Error al actualizar el producto. Por favor, inténtalo de nuevo más tarde.");
        e.printStackTrace();
        response.sendRedirect("index.jsp");
    }
%>

