<%-- 
    Document   : conexion
    Created on : 6 oct 2023, 0:10:38
    Author     : JORGE
--%>

<%@ page import="java.sql.*" %>
<%
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbtienda", "root", "");
    } catch (Exception e) {
        e.printStackTrace();
    }

    application.setAttribute("con", con);
%>