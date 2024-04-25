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
        <title>Listado de Clientes</title>
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
        <h1>Listado de Clientes</h1>
        <div class="button-container">
            <a href="agregarcliente.jsp" class="add-button">AÑADIR CLIENTE</a>
            <a href="../bienvenida.jsp" class="return-button">MENU</a>
        </div>
        <%@page import="java.sql.*"%>
        <%@page import="java.util.*"%>
        <%
            Connection con=null;
            try{
                Class.forName("com.mysql.jdbc.Driver");
                con=DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda","root","");
            }catch(Exception e) {
                e.printStackTrace();
            }
            PreparedStatement ps=con.prepareStatement("select * from tbcliente;");
            ResultSet rs=ps.executeQuery();
        %>
        <table>
            <thead>
                <tr>
                    <th>DNI</th>
                    <th>NOMBRES</th>
                    <th>APELLIDOS</th>
                    <th>OPERACIONES</th>
                </tr>
            </thead>
            <%
                while(rs.next()){
                    String dni=rs.getString("dni");
            %>
            <tbody>
                <tr>
                    <td><%= dni %></td>
                    <td><%= rs.getString("nombres") %></td>
                    <td><%= rs.getString("apellidos") %></td>
                    <td>
                        <a href="editarcliente.jsp?dni=<%= dni %>" class="edit-button">Editar</a>
                        <a href="eliminarcliente.jsp?dni=<%= dni %>" class="delete-button">Eliminar</a>
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

