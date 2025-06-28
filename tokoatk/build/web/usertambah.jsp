<%-- 
    Document   : usertambah
    Created on : 26 Jun 2025, 15.22.37
    Author     : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.User"%>
<%
    String username = request.getParameter("username").toString();
    String fullname = request.getParameter("fullname").toString();
    String password = request.getParameter("password").toString();
    
    User user = new User();
    user.username = username;
    user.fullname = fullname;
    user.tambah(password);
    
    response.sendRedirect("userlist.jsp");
%>