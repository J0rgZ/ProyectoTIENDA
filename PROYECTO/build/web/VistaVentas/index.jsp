<%-- 
    Document   : index
    Created on : 10 oct. 2023, 14:48:55
    Author     : JOSE
--%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>  
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Ventas</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
</head>
<body>
    <h1>Listado de Ventas</h1>
    <div class="button-container">
        <a href="nuevaVenta.jsp" class="add-button">NUEVA VENTA</a>
        <a href="../bienvenida.jsp" class="return-button">MENU</a>
    </div>
    <table>
        <thead>
            <tr>
                <th>ID Venta</th>
                <th>Cliente DNI</th>
                <th>Cliente</th>
                <th>Empleado DNI</th>
                <th>Empleado</th>
                <th>Fecha</th>
                <th>Hora</th>
                <th>Total Venta</th>
                <th>Operaciones</th>
            </tr>
        </thead>
        <%
            Connection con=null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda","root","");
            }catch(Exception e) {
                e.printStackTrace();
            }
            PreparedStatement ps=con.prepareStatement("SELECT tbventa.IdVenta, tbcliente.dni AS clienteDNI, tbcliente.nombres AS clienteNombres, tbcliente.apellidos AS clienteApellidos, tbempleado.dni AS empleadoDNI, tbempleado.nombre AS empleadoNombres, tbempleado.apellido AS empleadoApellidos, tbventa.fecha, tbventa.hora, tbventa.totalventa FROM tbventa INNER JOIN tbcliente ON tbventa.dnicliente = tbcliente.dni INNER JOIN tbempleado ON tbventa.dniempleado = tbempleado.dni;");
            ResultSet rs=ps.executeQuery();
        %>
        <tbody>
            <%
                while(rs.next()){
            %>
            <tr>
                <td><%= rs.getInt("IdVenta") %></td>
                <td><%= rs.getString("clienteDNI") %></td>
                <td><%= rs.getString("clienteNombres") %> <%= rs.getString("clienteApellidos") %></td>
                <td><%= rs.getString("empleadoDNI") %></td>
                <td><%= rs.getString("empleadoNombres") %> <%= rs.getString("empleadoApellidos") %></td>
                <td><%= rs.getDate("fecha") %></td>
                <td><%= rs.getTime("hora") %></td>
                <td><%= rs.getDouble("totalventa") %></td>
                <td>
                    <form action="descargarpdf.jsp" method="post">
                        <input type="hidden" name="ventaId" value="<%= rs.getInt("IdVenta") %>">
                        <button type="submit" class="pdf-button">Previzualizar</button>
                    </form>
                    <a href="boleta.jsp?ventaId=<%= rs.getInt("IdVenta") %>" download="boleta.jsp" class="boton-descarga">Descargar Boleta</a>
                </td>
            </tr>
            <% }%>
        </tbody>
    </table>
    <div class="mensaje-flotante">
        <%= session.getAttribute("mensaje") %>
        <% session.removeAttribute("mensaje"); %>
    </div>
    <div class="mensaje-flotante-error">
        <%= session.getAttribute("mensajeError") %>
        <% session.removeAttribute("mensajeError"); %>
    </div>
</body>
</html>