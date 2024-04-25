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
    <title>Listado de Empleados</title>
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
    <h1>LISTA DE EMPLEADOS</h1>
    <div class="button-container">
        <a href="agregarempleado.jsp" class="add-button">AÑADIR EMPLEADO</a>
        <a href="../bienvenida.jsp" class="return-button">MENU</a>
    </div>
    <%@page import="java.sql.*"%>
    <%@page import="java.util.*"%>
    <%
        Connection con = null;
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");
        } catch(Exception e) {
            e.printStackTrace();
        }
        PreparedStatement ps = con.prepareStatement("SELECT * FROM tbempleado;");
        ResultSet rs = ps.executeQuery();
    %>
    <table>
        <thead>
            <tr>
                <th>DNI</th>
                <th>NOMBRE</th>
                <th>APELLIDO</th>
                <th>DIRECCION</th>
                <th>TELEFONO</th>
                <th>EMAIL</th>
                <th>CLAVE</th>
                <th>FOTO</th>
                <th>OPERACIONES</th>
            </tr>
        </thead>
        <%
            while(rs.next()){
                    String dni = rs.getString("dni");
                    String imagenPath = rs.getString("imagen");
        %>
        <tbody>
            <tr>
                <td><%= dni %></td>
                <td><%= rs.getString("nombre") %></td>
                <td><%= rs.getString("apellido") %></td>
                <td><%= rs.getString("direccion") %></td>
                <td><%= rs.getString("telefono") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("clave") %></td>
                <td>
                        <%-- Mostrar la imagen si existe --%>
                        <% if (imagenPath != null && !imagenPath.isEmpty()) { %>
                            <img src="<%= imagenPath %>" alt="Imagen del empleado" width="100">
                        <% } else { %>
                            <p>Sin imagen</p>
                        <% } %>
                </td>
                <td>
                    <a href="editarempleado.jsp?dni=<%= dni %>" class="edit-button">Editar</a>
                    <a href="eliminarempleado.jsp?dni=<%= dni %>" class="delete-button">Eliminar</a>
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


