<%-- 
    Document   : eliminarE
    Created on : 5 oct 2023, 17:43:00
    Author     : HP
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<%
    Connection con = null;
    PreparedStatement ps = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");
        
        String dni = request.getParameter("dni");

        // Comprueba que el DNI no sea nulo o vacío antes de continuar
        if (dni != null && !dni.isEmpty()) {
            // Query para eliminar el cliente
            String query = "DELETE FROM tbcliente WHERE dni = ?";

            ps = con.prepareStatement(query);
            ps.setString(1, dni);
            ps.executeUpdate();

            // Mensaje de éxito
            session.setAttribute("mensaje", "Cliente eliminado correctamente");
        } else {
            // Si el DNI es nulo o vacío, muestra un mensaje de error
            session.setAttribute("mensajeError", "Error al eliminar el cliente");
        }

    } catch (Exception e) {
        e.printStackTrace();
        // Manejo de errores, muestra un mensaje de error
        session.setAttribute("mensajeError", "Error al eliminar el cliente");
    } finally {
        // Cierra la conexión y la declaración
        if (ps != null) ps.close();
        if (con != null) con.close();
    }

    // Redirige de vuelta a la lista de clientes
    response.sendRedirect("index.jsp");
%>
