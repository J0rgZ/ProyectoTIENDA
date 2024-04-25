<%-- 
    Document   : boleta
    Created on : 12 oct 2023, 6:47:21
    Author     : JORGE
--%>

<%@ page import="java.io.*, com.itextpdf.text.*, com.itextpdf.text.pdf.*, java.sql.*, javax.servlet.*" %>
<%@ page import="com.itextpdf.text.Document, com.itextpdf.text.DocumentException, com.itextpdf.text.Paragraph, com.itextpdf.text.pdf.PdfPCell, com.itextpdf.text.pdf.PdfPTable, com.itextpdf.text.pdf.PdfWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
        <p class="empresa">QUANTUM SYSTEMS</p>
        <p class="ruc">RUC: 20343876123</p>
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
                <th>ID Detalle</th>
                <th>ID Venta</th>
                <th>ID Producto</th>
                <th>Cantidad</th>
                <th>Precio Unitario</th>
            </tr>
            <%
                String queryDetalle = "SELECT * FROM tbdetalleventa WHERE idventa = ?";
                psDetalle = con.prepareStatement(queryDetalle);
                psDetalle.setInt(1, ventaIdParam);
                rsDetalle = psDetalle.executeQuery();
                while (rsDetalle.next()) {
            %>
                <tr>
                    <td><%= rsDetalle.getInt("iddetalle") %></td>
                    <td><%= rsDetalle.getInt("idventa") %></td>
                    <td><%= rsDetalle.getString("idproducto") %></td>
                    <td><%= rsDetalle.getInt("cantidad") %></td>
                    <td><%= rsDetalle.getDouble("preciounitario") %></td>
                </tr>
            <%
                }
            %>
        </table>
        <div class="total">
            <p><strong>Total Venta:</strong> <%= rs.getDouble("totalventa") %></p>
        </div>
    </div>
</body>
</html>

<%
        // Generación del PDF
        Document document = new Document();
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        document.open();
        
        // Agregar contenido al PDF (debería coincidir con la boleta HTML)
        document.add(new Paragraph("BOLETA ELECTRÓNICA"));
        document.add(new Paragraph("QUANTUM SYSTEMS"));
        document.add(new Paragraph("RUC: 20343876123"));

        // Agregar la fecha y hora
        document.add(new Paragraph("Fecha: " + rs.getDate("fecha")));
        document.add(new Paragraph("Hora: " + rs.getTime("hora")));

        // Agregar información del cliente
        document.add(new Paragraph("Cliente DNI: " + rs.getString("clienteDNI")));
        document.add(new Paragraph("Cliente: " + rs.getString("clienteNombres") + " " + rs.getString("clienteApellidos")));

        // Agregar información del empleado
        document.add(new Paragraph("Empleado DNI: " + rs.getString("empleadoDNI")));
        document.add(new Paragraph("Empleado: " + rs.getString("empleadoNombres") + " " + rs.getString("empleadoApellidos")));

        // Agregar tabla con detalle de la venta
        PdfPTable table = new PdfPTable(5); // 5 columnas
        table.addCell("ID Detalle");
        table.addCell("ID Venta");
        table.addCell("ID Producto");
        table.addCell("Cantidad");
        table.addCell("Precio Unitario");

        // Llenar la tabla con datos del detalle de la venta
        while (rsDetalle.next()) {
            table.addCell(String.valueOf(rsDetalle.getInt("iddetalle")));
            table.addCell(String.valueOf(rsDetalle.getInt("idventa")));
            table.addCell(rsDetalle.getString("idproducto"));
            table.addCell(String.valueOf(rsDetalle.getInt("cantidad")));
            table.addCell(String.valueOf(rsDetalle.getDouble("preciounitario")));
        }

        document.add(table);

        // Agregar el total de la venta
        document.add(new Paragraph("Total Venta: " + rs.getDouble("totalventa")));
        
        document.close();

        // Establece el tipo de respuesta y los encabezados para descargar el archivo PDF
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=boleta.pdf");

        // Escribe el PDF en la respuesta
        OutputStream os = response.getOutputStream();
        baos.writeTo(os);
        os.flush();
        os.close();
    }
        
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // Cierra las conexiones y recursos
        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (rsDetalle != null) rsDetalle.close(); } catch (SQLException e) { e.printStackTrace(); }
        try { if (psDetalle != null) psDetalle.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

