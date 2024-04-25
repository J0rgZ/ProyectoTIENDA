<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Añadir Producto</title>
    <style>
        body {
        font-family: Arial, sans-serif;
        text-align: center;
        background-color: #f4f4f4;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    form {
        max-width: 600px;
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0,0,0,0.1);
        text-align: left;
        margin-top: 20px;
    }

    h1 {
        margin-bottom: 20px;
        color: #333;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #555;
    }

    input[type="text"],
    input[type="number"] {
        width: calc(100% - 20px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
        margin-bottom: 10px;
    }

    input[type="checkbox"] {
        margin-top: 10px;
    }

    input[type="submit"],
    .cancelar-button {
        background-color: #4caf50;
        color: #fff;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        cursor: pointer;
        font-size: 16px;
        margin-top: 20px;
        margin-right: 10px;
    }

    .cancelar-button {
        background-color: #f44336;
    }

    .cancelar-button:hover {
        background-color: #d32f2f;
    }

    input[type="submit"]:hover {
        background-color: #45a049;
    }

    .container {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 20px;
    }

    .cancelar-button {
        margin-left: auto;
    }
    
    .form-group label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #555;
    }

    .form-group input,
    .form-group select {
        width: calc(100% - 20px);
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
        font-size: 16px;
    }
    
    textarea {
        height: 150px;
        resize: none;
    }
    
    textarea#descripcion {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 8px;
        font-size: 16px;
        box-sizing: border-box;
        height: 150px;
        resize: none;
    }
    </style>
</head>
<body>
    
    <form action="agregarP.jsp" method="post">
    <h1>Añadir Producto</h1>
    <div class="form-group">
        <label for="idproducto">ID PRODUCTO:</label>
        <input type="text" id="idproducto" name="idproducto" required>
    </div>
    <div class="form-group">
        <label for="nombreproducto">Nombre:</label>
        <input type="text" id="nombreproducto" name="nombreproducto" required>
    </div>
    <div class="form-group">
        <label for="categoria">Categoría:</label>
        <input type="text" id="categoria" name="categoria" required>
    </div>
    <div class="form-group">
        <label for="descripcion">Descripción:</label>
        <textarea id="descripcion" name="descripcion" required></textarea>
    </div>
    <div class="form-group">
        <label for="precio">Precio:</label>
        <input type="text" id="precio" name="precio" required>
    </div>
    <div class="form-group">
        <label for="stock">Stock:</label>
        <input type="number" id="stock" name="stock" required>
    </div>
    <div class="form-group">
        <label for="imagen">Imagen (URL):</label>
        <input type="text" id="imagen" name="imagen" required>
    </div>
    <div class="form-group">
        <label for="estado">Estado:</label>
        <input type="checkbox" id="estado" name="estado" required>
    </div>
    <div class="form-group">
        <input type="submit" value="Guardar">
        <input type="button" value="Cancelar" class="cancelar-button" onclick="window.location.href='index.jsp'">
    </div>
</form>
</body>
</html>
