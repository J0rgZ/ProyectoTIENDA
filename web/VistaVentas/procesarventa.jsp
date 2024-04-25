<%-- 
    Document   : procesarventa
    Created on : 11 oct 2023, 10:57:16
    Author     : JORGE
--%>
<%@ page import="java.sql.*, javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../conexion.jsp" %>

<%
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = (Connection)application.getAttribute("con");

        String clienteDNI = request.getParameter("clienteDNI");
        String clienteNombres = request.getParameter("clienteNombres");
        String clienteApellidos = request.getParameter("clienteApellidos");

        // Verificar si el cliente ya existe
        String queryCliente = "SELECT * FROM tbcliente WHERE dni = ?";
        ps = con.prepareStatement(queryCliente);
        ps.setString(1, clienteDNI);
        rs = ps.executeQuery();

        if (!rs.next()) {
            // Si el cliente no existe, lo insertamos
            String insertCliente = "INSERT INTO tbcliente (dni, nombres, apellidos) VALUES (?, ?, ?)";
            ps = con.prepareStatement(insertCliente);
            ps.setString(1, clienteDNI);
            ps.setString(2, clienteNombres);
            ps.setString(3, clienteApellidos);
            ps.executeUpdate();
        }

        // Obtener el DNI del empleado
        String dniEmpleado = request.getParameter("dniEmpleado");

        // Obtener la fecha y hora actual
        java.util.Date date = new java.util.Date();
        java.sql.Date fecha = new java.sql.Date(date.getTime());
        java.sql.Time hora = new java.sql.Time(date.getTime());

        // Obtener detalles de la boleta
        String[] productos = request.getParameterValues("productos[]");
        String[] cantidades = request.getParameterValues("cantidades[]");
        double totalVenta = 0;

        for (int i = 0; i < productos.length; i++) {
            String idProducto = productos[i];
            int cantidad = Integer.parseInt(cantidades[i]);

            // Obtener el precio del producto
            String queryPrecio = "SELECT precio FROM tbproducto WHERE idproducto = ?";
            ps = con.prepareStatement(queryPrecio);
            ps.setString(1, idProducto);
            rs = ps.executeQuery();
            double precioUnitario = 0;
            if (rs.next()) {
                precioUnitario = rs.getDouble("precio");
            }

            // Calcular el total del detalle
            double totalDetalle = cantidad * precioUnitario;
            totalVenta += totalDetalle;

            // Insertar detalle de venta
            String insertDetalle = "INSERT INTO tbdetalleventa (idproducto, cantidad, preciounitario) VALUES (?, ?, ?)";
            ps = con.prepareStatement(insertDetalle);
            ps.setString(1, idProducto);
            ps.setInt(2, cantidad);
            ps.setDouble(3, precioUnitario);
            ps.executeUpdate();
        }

        // Insertar la venta
        String insertVenta = "INSERT INTO tbventa (dnicliente, dniempleado, fecha, hora, totalventa) VALUES (?, ?, ?, ?, ?)";
        ps = con.prepareStatement(insertVenta, Statement.RETURN_GENERATED_KEYS);
        ps.setString(1, clienteDNI);
        ps.setString(2, dniEmpleado);
        ps.setDate(3, fecha);
        ps.setTime(4, hora);
        ps.setDouble(5, totalVenta);
        ps.executeUpdate();

        // Obtener el idventa generado
        ResultSet generatedKeys = ps.getGeneratedKeys();
        int idVentaGenerado = -1;
        if (generatedKeys.next()) {
            idVentaGenerado = generatedKeys.getInt(1);
        }

        // Actualizar el stock de los productos
        for (int i = 0; i < productos.length; i++) {
            String idProducto = productos[i];
            int cantidad = Integer.parseInt(cantidades[i]);

            String updateStock = "UPDATE tbproducto SET stock = stock - ? WHERE idproducto = ?";
            ps = con.prepareStatement(updateStock);
            ps.setInt(1, cantidad);
            ps.setString(2, idProducto);
            ps.executeUpdate();
            
            // Obtener el precio del producto
            String queryPrecio = "SELECT precio FROM tbproducto WHERE idproducto = ?";
            ps = con.prepareStatement(queryPrecio);
            ps.setString(1, idProducto);
            rs = ps.executeQuery();
            double precioUnitario = 0;
            if (rs.next()) {
                precioUnitario = rs.getDouble("precio");
            }

            // Calcular el total del detalle
            double totalDetalle = cantidad * precioUnitario;
            totalVenta += totalDetalle;

            // Insertar detalle de venta
            String insertDetalle = "INSERT INTO tbdetalleventa (idventa, idproducto, cantidad, preciounitario) VALUES (?, ?, ?, ?)";
            ps = con.prepareStatement(insertDetalle);
            ps.setInt(1, idVentaGenerado);  // Asegúrate de tener el idVentaGenerado correctamente
            ps.setString(2, idProducto);
            ps.setInt(3, cantidad);
            ps.setDouble(4, precioUnitario);
            ps.executeUpdate();
        }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Procesar Venta</title>
    <!-- Agrega aquí tus estilos si es necesario -->
</head>
<body>
    <h1>Venta Procesada</h1>
    <p>El total de la venta es: <%= totalVenta %></p>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>



