<%-- 
    Document   : bienvenida
    Created on : 9 oct 2023, 11:42:35
    Author     : JORGE
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bienvenida</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background-color: #f9f9f9; /* Cambié el color de fondo */
        }

        h1 {
            margin-top: 40px; /* Incrementé el espacio superior */
            color: #333;
        }

        h2 {
            color: #333;
        }

        .boton-container {
            display: flex;
            justify-content: center;
            margin-top: 30px; /* Añadí un poco de espacio entre los botones y los encabezados */
        }

        .boton {
            width: 180px; /* Aumenté el ancho del botón */
            height: 180px; /* Aumenté la altura del botón */
            border: none;
            margin: 10px;
            cursor: pointer;
            border-radius: 10px; /* Aumenté el radio de borde para esquinas redondeadas */
            color: #fff;
            font-size: 20px; /* Aumenté el tamaño de la fuente */
            text-align: center;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background-color: #4caf50;
            background-image: linear-gradient(to bottom, #4caf50, #45a049); /* Agregué un degradado de color */
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Añadí una sombra suave */
            transition: background-color 0.3s, transform 0.2s; /* Agregué transiciones para animaciones */
        }

        .boton:hover {
            transform: scale(1.10);
            background-color: #388e3c;
        }

        .boton-verde {
            background-color: #4caf50;
            background-image: linear-gradient(to bottom, #4caf50, #45a049);
        }

        .boton-rojo, .boton-azul {
            width: 150px; /* Ajusté el ancho de los nuevos botones */
            height: 40px; /* Ajusté la altura de los nuevos botones */
            margin: 0 10px; /* Añadí un margen a los nuevos botones */
            font-size: 16px; /* Ajusté el tamaño de la fuente de los nuevos botones */
        }

        .boton-rojo {
            background-color: #f44336;
            background-image: linear-gradient(to bottom, #f44336, #e53935); 
        }

        .boton-azul {
            background-color: #2196F3;
            background-image: linear-gradient(to bottom, #2196F3, #1976D2); 
        }
    </style>
</head>
<body>
    <h1 style="display: flex; justify-content: space-between; align-items: center; margin: 0;">
        <div>
            <a href="CambiarClaveServlet" class="boton boton-azul">Cambiar Clave</a>
        </div>
        <span style="flex-grow: 1;">QUANTUM SYSTEMS</span>
        <div class="boton-container">
            <a href="index.jsp" class="boton boton-rojo">Cerrar Sesión</a>
        </div>
    </h1>
    
    <h2>BIENVENIDO ADMINISTRADOR</h2>
    <div class="boton-container">
        <a href="VistaProducto/index.jsp" class="boton boton-verde">Productos</a>
        <a href="VistaCliente/index.jsp" class="boton boton-verde">Clientes</a>
        <a href="VistaEmpleado/index.jsp" class="boton boton-verde">Empleados</a>
        <a href="VistaProveedor/index.jsp" class="boton boton-verde">Proveedor</a>
        <a href="VistaVentas/index.jsp" class="boton boton-verde">Ventas</a>
    </div>
</body>
</html>
