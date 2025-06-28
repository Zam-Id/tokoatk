<%-- 
    Document   : login
    Created on : 26 Jun 2025, 15.20.01
    Author     : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.User"%>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    
    User user = new User();
    if(user.login(username, password)) {
        session.setAttribute("fullname", user.getFullname());
        response.sendRedirect("home.jsp");
    } else {
            response.sendRedirect("formlogin.jsp");
    }

%>
