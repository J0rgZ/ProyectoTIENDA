<%-- 
    Document   : agregarE
    Created on : 5 oct 2023, 17:25:07
    Author     : HP
--%>

<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String idproducto = request.getParameter("idproducto");
    String nombreproducto = request.getParameter("nombreproducto");
    String categoria = request.getParameter("categoria");
    String descripcion = request.getParameter("descripcion");
    String precio = request.getParameter("precio");
    String imagen = request.getParameter("imagen");
    String estado = request.getParameter("estado");
    boolean estadoBoolean = estado != null && estado.equals("on");

    PreparedStatement ps = null;

    try {
        ps = con.prepareStatement("INSERT INTO tbproducto (idproducto, nombreproducto, categoria, descripcion, precio, imagen, estado) VALUES (?, ?, ?, ?, ?, ?, ?)");
        ps.setString(1, idproducto);
        ps.setString(2, nombreproducto);
        ps.setString(3, categoria);
        ps.setString(4, descripcion);
        ps.setString(5, precio);
        ps.setString(6, imagen);
        ps.setBoolean(7, estadoBoolean);

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Producto agregado correctamente.");
            response.sendRedirect("index.jsp");
        } else {
            session.setAttribute("mensajeError", "Error al añadir el producto.");
            response.sendRedirect("index.jsp"); 
        }
    } catch (Exception e) {
        session.setAttribute("mensajeError", "Error al añadir el producto. Por favor, inténtalo de nuevo más tarde.");
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