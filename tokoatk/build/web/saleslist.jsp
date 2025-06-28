<%-- 
    Document   : saleslist
    Created on : 26 Jun 2025, 17.36.15
    Author     : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Sales"%>
<%
    ArrayList<Sales> list = Sales.getList();
    
    request.setAttribute("list", list);
    
    RequestDispatcher dispacher = request.getRequestDispatcher("saleslist.view.jsp");
    dispacher.forward(request, response);
%>
<%--
    Document   : saleslist.jsp (Controller untuk Daftar Transaksi)
    Created on : 28 Juni 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@page import="tokoatk.Sales"%>
<%@page import="java.util.ArrayList"%>
<%
    // 1. Mengambil semua data transaksi dari database
    ArrayList<Sales> listTransaksi = Sales.getList();

    // 2. Mengirim data tersebut ke halaman view
    request.setAttribute("salesList", listTransaksi);

    // 3. Forward ke halaman view
    RequestDispatcher dispatcher = request.getRequestDispatcher("saleslist.view.jsp");
    dispatcher.forward(request, response);
%>