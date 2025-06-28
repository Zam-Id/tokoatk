<%-- 
    Document   : userlist
    Created on : 26 Jun 2025, 15.21.35
    Author     : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.User"%>
<%@page import="java.util.ArrayList"%>
<%
    ArrayList<User> list = User.getList();
    
    request.setAttribute("list", list);
    
    RequestDispatcher dispacher = request.getRequestDispatcher("userlist.view.jsp");
    dispacher.forward(request, response);
%>
