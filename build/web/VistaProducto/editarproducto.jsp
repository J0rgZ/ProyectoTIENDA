<%-- 
    Document   : editarempleado
    Created on : 5 oct 2023, 17:39:09
    Author     : HP
--%>

<%@ include file="../conexion.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Editar Producto</title>
    <link rel="stylesheet" type="text/css" href="../stylesEditar.css">
</head>
<body>
    <form action="editarP.jsp" method="post">
        <h1>EDITAR PRODUCTO</h1>
        <%
            String idproducto = request.getParameter("idproducto");
            String nombreproducto = "";
            String categoria = "";
            String descripcion = "";
            String precio = "";
            String imagen = "";
            boolean estado = false;

            PreparedStatement ps = null;

            try {
                ps = con.prepareStatement("SELECT nombreproducto, categoria, descripcion, precio, imagen, estado FROM tbproducto WHERE idproducto = ?");
                ps.setString(1, idproducto);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {
                    nombreproducto = rs.getString("nombreproducto");
                    categoria = rs.getString("categoria");
                    descripcion = rs.getString("descripcion");
                    precio = rs.getString("precio");
                    imagen = rs.getString("imagen");
                    estado = rs.getBoolean("estado");
                }

                rs.close();
                ps.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
            <input type="hidden" name="idproducto" value="<%= idproducto %>">
        <label for="idproducto">ID Producto:</label>
        <input type="text" id="idproducto" name="idproducto" value="<%= idproducto %>" readonly>
        <label for="nombreproducto">Nombre Producto:</label>
        <input type="text" id="nombreproducto" name="nombreproducto" required value="<%= nombreproducto %>">
        <label for="categoria">Categoria:</label>
        <input type="text" id="categoria" name="categoria" required value="<%= categoria %>">
        <label for="descripcion">Descripcion:</label>
        <textarea id="descripcion" name="descripcion" required><%= descripcion %></textarea>
        <label for="precio">Precio:</label>
        <input type="text" id="precio" name="precio" required value="<%= precio %>">
        <label for="imagen">Imagen:</label>
        <input type="text" id="imagen" name="imagen" required value="<%= imagen %>">
        <label for="estado">Estado:</label>
        <input type="checkbox" id="estado" name="estado" <%= estado ? "checked" : "" %>>
        <input type="submit" value="Guardar Cambios">
    </form>
</body>
</html>