<%-- 
    Document   : index
    Created on : 3 oct. 2023, 19:19:00
    Author     : hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Listado de Productos</title>
    <link rel="stylesheet" type="text/css" href="../styles.css">
    <script>
        setTimeout(function() {
            var mensajeElement = document.querySelector('.mensaje-flotante');
            mensajeElement.style.display = 'none';
        }, 5000);

        window.addEventListener('load', function() {
            var mensajeElement = document.querySelector('.mensaje-flotante');
            mensajeElement.style.display = 'block';
        });
    </script>
</head>
<body>
    <h1>LISTA DE PRODUCTOS</h1>
    <div class="button-container">
        <a href="agregarproducto.jsp" class="add-button">AÑADIR PRODUCTO</a>
        <a href="../bienvenida.jsp" class="return-button">MENU</a>
    </div>
    <%@page import="java.sql.*"%>
    <%@page import="java.util.*"%>
    <%
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");
        } catch(Exception e) {
            e.printStackTrace();
        }
        PreparedStatement ps = con.prepareStatement("SELECT * FROM tbproducto;");
        ResultSet rs = ps.executeQuery();
    %>
    <table>
        <thead>
            <tr>
                <th>ID Producto</th>
                <th>Nombre Producto</th>
                <th>Categoría</th>
                <th>Descripción</th>
                <th>Precio</th>
                <th>Stock</th>
                <th>Imagen</th>
                <th>Estado</th>
                <th>Operaciones</th>
            </tr>
        </thead>
        <%
            while(rs.next()){
                String idproducto = rs.getString("idproducto");
                String imagenPath = rs.getString("imagen");
        %>
        <tbody>
            <tr>
                <td><%= idproducto %></td>
                <td><%= rs.getString("nombreproducto") %></td>
                <td><%= rs.getString("categoria") %></td>
                <td><%= rs.getString("descripcion") %></td>
                <td><%= rs.getBigDecimal("precio") %></td>
                <td><%= rs.getInt("stock") %></td>
                <td>
                    <%-- Mostrar la imagen si existe --%>
                    <% if (imagenPath != null && !imagenPath.isEmpty()) { %>
                        <img src="<%= imagenPath %>" alt="Imagen del producto" width="100">
                    <% } else { %>
                        <p>Sin imagen</p>
                    <% } %>
                </td>
                <td><%= rs.getBoolean("estado") ? "Activo" : "Inactivo" %></td>
                <td>
                    <a href="editarproducto.jsp?idproducto=<%= idproducto %>" class="edit-button">Editar</a>
                    <a href="eliminarproducto.jsp?idproducto=<%= idproducto %>" class="delete-button">Eliminar</a>
                </td>
            </tr>
        </tbody>
        <% }%>
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


