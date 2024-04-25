<%-- 
    Document   : loginCheck
    Created on : 9 oct 2023, 11:39:58
    Author     : JORGE
--%>

<%@ include file="conexion.jsp" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*,java.util.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>

<%
    String dni = request.getParameter("dni");
    String clave = request.getParameter("clave");

    PreparedStatement psEmpleado = null;
    ResultSet rsEmpleado = null;

    PreparedStatement psUsuario = null;
    ResultSet rsUsuario = null;

    try {
        con = (Connection)application.getAttribute("con");

        // Verificar si es un empleado
        psEmpleado = con.prepareStatement("SELECT * FROM tbempleado WHERE dni=? AND clave=?");
        psEmpleado.setString(1, dni);
        psEmpleado.setString(2, clave);

        rsEmpleado = psEmpleado.executeQuery();

        if (rsEmpleado.next()) {
            // Es un empleado
            session.setAttribute("dni", dni);
            session.setAttribute("mensaje", "Inicio de sesión exitoso.");
            response.sendRedirect("bienvenidaEmple.jsp");
        } else {
            // No es un empleado, ahora verifica si es un usuario
            psUsuario = con.prepareStatement("SELECT * FROM tbusuario WHERE usuario=? AND clave=?");
            psUsuario.setString(1, dni);
            psUsuario.setString(2, clave);

            rsUsuario = psUsuario.executeQuery();

            if (rsUsuario.next()) {
                // Es un usuario/admin
                session.setAttribute("dni", dni);
                session.setAttribute("mensaje", "Inicio de sesión exitoso.");
                response.sendRedirect("bienvenida.jsp");
            } else {
                // No es un usuario válido
                session.setAttribute("mensajeError", "Credenciales incorrectas. Intente de nuevo.");
                response.sendRedirect("index.jsp");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (rsEmpleado != null) rsEmpleado.close();
            if (psEmpleado != null) psEmpleado.close();
            if (rsUsuario != null) rsUsuario.close();
            if (psUsuario != null) psUsuario.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>

