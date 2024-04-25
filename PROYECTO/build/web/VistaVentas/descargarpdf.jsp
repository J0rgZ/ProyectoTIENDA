<%-- 
    Document   : descargarpdf
    Created on : 10 oct. 2023, 15:17:02
    Author     : JOSE
--%>
<%@ page import="java.sql.*, javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    int ventaIdParam = Integer.parseInt(request.getParameter("ventaId"));
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    PreparedStatement psDetalle = null;
    ResultSet rsDetalle = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");

        String query = "SELECT tbcliente.dni AS clienteDNI, tbcliente.nombres AS clienteNombres, tbcliente.apellidos AS clienteApellidos, tbempleado.dni AS empleadoDNI, tbempleado.nombre AS empleadoNombres, tbempleado.apellido AS empleadoApellidos, tbventa.fecha, tbventa.hora, tbventa.totalventa FROM tbventa INNER JOIN tbcliente ON tbventa.dnicliente = tbcliente.dni INNER JOIN tbempleado ON tbventa.dniempleado = tbempleado.dni WHERE tbventa.IdVenta = ?";
        ps = con.prepareStatement(query);
        ps.setInt(1, ventaIdParam);
        rs = ps.executeQuery();

        if (rs.next()) {
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Boleta Electrónica</title>
    <link rel="stylesheet" type="text/css" href="../stylosBoleta.css">
</head>
<body>
    <div class="boleta">
        <h1>BOLETA ELECTRÓNICA</h1>
        <div class="info-empresa">
            <p class="nombre-empresa">QUANTUM SYSTEMS</p>
            <p class="ruc">RUC: 20343876123</p>
        </div>
        <br>
        <div class="fecha-hora">
            <p><strong>Fecha:</strong> <%= rs.getDate("fecha") %></p>
            <p><strong>Hora:</strong> <%= rs.getTime("hora") %></p>
        </div>
        <div class="info-cliente">
            <p><strong>Cliente DNI:</strong> <%= rs.getString("clienteDNI") %></p>
            <p><strong>Cliente:</strong> <%= rs.getString("clienteNombres") %> <%= rs.getString("clienteApellidos") %></p>
        </div>
        <div class="info-empleado">
            <p><strong>Empleado DNI:</strong> <%= rs.getString("empleadoDNI") %></p>
            <p><strong>Empleado:</strong> <%= rs.getString("empleadoNombres") %> <%= rs.getString("empleadoApellidos") %></p>
        </div>
        <table>
            <tr>
                <th>Nro</th>
                <th>Código Producto</th>
                <th>Nombre Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
            </tr>
            <%
                String queryDetalle = "SELECT tbdetalleventa.idproducto, tbproducto.nombreproducto, tbdetalleventa.cantidad, tbdetalleventa.preciounitario FROM tbdetalleventa INNER JOIN tbproducto ON tbdetalleventa.idproducto = tbproducto.idproducto WHERE idventa = ?";
                psDetalle = con.prepareStatement(queryDetalle);
                psDetalle.setInt(1, ventaIdParam);
                rsDetalle = psDetalle.executeQuery();
                int contador = 1;
                while (rsDetalle.next()) {
            %>
                <tr>
                    <td><%= contador++ %></td>
                    <td><%= rsDetalle.getString("idproducto") %></td>
                    <td><%= rsDetalle.getString("nombreproducto") %></td>
                    <td><%= rsDetalle.getInt("cantidad") %></td>
                    <td><%= rsDetalle.getDouble("preciounitario") %></td>
                </tr>
            <%
                }
            %>
        </table>
        <div class="total">
            <p><strong>Total Venta: S/.</strong> <%= rs.getDouble("totalventa") %></p>
        </div>
    </div>
</body>
</html>
<%
        } else {
            out.println("No se encontró la venta con ID " + ventaIdParam);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (rsDetalle != null) rsDetalle.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (psDetalle != null) psDetalle.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>











