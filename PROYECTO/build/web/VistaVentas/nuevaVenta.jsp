<%-- 
    Document   : nuevaVenta
    Created on : 11 oct 2023, 6:39:05
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
        
        // Obtener la lista de productos para mostrar en el combo box
        String queryProductos = "SELECT * FROM tbproducto";
        ps = con.prepareStatement(queryProductos);
        rs = ps.executeQuery();
    
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nueva Venta</title>
    <link rel="stylesheet" type="text/css" href="../stylosNuevaVenta.css">
    <script>
        function agregarDetalle() {
            var producto = document.getElementById("producto");
            var cantidad = document.getElementById("cantidad").value; // Obtener la cantidad ingresada

            // Verificar si se ha seleccionado un producto y se ha ingresado una cantidad
            if (producto.selectedIndex !== -1 && cantidad !== "") {
                var detalleBoleta = document.getElementById("detalleBoleta");
                var newRow = detalleBoleta.insertRow();

                var cell1 = newRow.insertCell(0);
                var cell2 = newRow.insertCell(1);
                var cell3 = newRow.insertCell(2);

                cell1.innerHTML = '<input type="hidden" name="productos[]" value="' + producto.options[producto.selectedIndex].value + '">' + producto.options[producto.selectedIndex].text;
                cell2.innerHTML = '<input type="hidden" name="cantidades[]" value="' + cantidad + '">' + cantidad;
                cell3.innerHTML = '<button type="button" onclick="eliminarFila(this)">Eliminar</button>';
            } else {
                alert("Por favor, seleccione un producto y especifique la cantidad.");
            }
        }

        function editarFila(button) {
            var row = button.parentElement.parentElement;
            var producto = row.cells[0].innerHTML;
            var cantidad = row.cells[1].innerHTML;

            document.getElementById("producto").value = producto; // Seleccionar el producto en el combo
            document.getElementById("cantidad").value = cantidad;

            row.remove(); // Eliminar la fila
        }

        function eliminarFila(button) {
            var row = button.parentElement.parentElement;
            row.remove(); // Eliminar la fila
        }
        
        function completarDatos() {
            var dni = document.getElementById("clienteDNI").value;

            // Buscamos el cliente en la base de datos
            var clienteEncontrado = clientes.find(function(cliente) {
                return cliente.dni === dni;
            });

            // Si encontramos el cliente, llenamos los campos
            if (clienteEncontrado) {
                document.getElementById("clienteNombres").value = clienteEncontrado.nombres;
                document.getElementById("clienteApellidos").value = clienteEncontrado.apellidos;
            } else {
                // Si no encontramos el cliente, puedes mostrar un mensaje o realizar otra acción.
                alert("Cliente no encontrado");
            }
        }
        
        
    </script>
</head>
<body>
    <div class="container">
        <div class="form-section">
            <form action="procesarventa.jsp" method="post">
                <h1>Nueva Venta</h1>
                <div class="form-group">
                    <label for="clienteDNI">DNI del Cliente</label>
                    <input type="text" id="clienteDNI" name="clienteDNI" required>
                </div>
                <div class="form-group">
                    <label for="clienteNombres">Nombres del Cliente</label>
                    <input type="text" id="clienteNombres" name="clienteNombres" required>
                </div>
                <div class="form-group">
                    <label for="clienteApellidos">Apellidos del Cliente</label>
                    <input type="text" id="clienteApellidos" name="clienteApellidos" required>
                </div>
                <div class="form-group">
                    <label for="dniEmpleado">DNI Empleado:</label>
                    <input type="text" id="dniEmpleado" name="dniEmpleado" required>
                </div>
                <div class="form-group">
                    <label for="producto">Producto:</label>
                    <select id="producto" name="producto" required>
                        <!-- Opciones del producto aquí -->
                        <% while (rs.next()) { %>
                            <option value="<%= rs.getString("idproducto") %>"><%= rs.getString("nombreproducto") %></option>
                        <% } %>
                    </select>
                </div>
                <div class="form-group">
                    <label for="cantidad">Cantidad:</label>
                    <input type="text" id="cantidad" name="cantidad" required>
                </div>
                <button type="button" onclick="agregarDetalle()" class="btn-add">Agregar Detalle</button>
                <div>
                    <div class="detail-section">
                        <h2>Detalle de Boleta</h2>
                        <table id="detalleBoleta">
                            <tr>
                                <th>Producto</th>
                                <th>Cantidad</th>
                                <th>Acciones</th>
                            </tr>
                        </table>
                    </div>
                </div>
                <br>
                <div class="form-group">
                    <button type="submit" class="btn-add">Generar Venta</button>
                </div>
            </form>
        </div>
    </div>
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
