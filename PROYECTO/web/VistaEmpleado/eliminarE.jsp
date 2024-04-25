<%-- 
    Document   : eliminarE
    Created on : 5 oct 2023, 17:43:00
    Author     : HP
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String dni = request.getParameter("dni");

    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");

        // Preparar la consulta para eliminar el empleado
        ps = con.prepareStatement("DELETE FROM tbempleado WHERE dni=?");
        ps.setString(1, dni);

        // Ejecutar la consulta
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            session.setAttribute("mensaje", "Empleado eliminado correctamente.");
        } else {
            session.setAttribute("mensajeError", "Error al eliminar el empleado.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    response.sendRedirect("index.jsp");
%>
