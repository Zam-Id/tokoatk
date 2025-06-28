<%--
    Document   : home.jsp (Controller untuk Dashboard)
    Created on : 28 Juni 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%-- File: home.jsp (Controller untuk Dashboard) --%>
<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.Barang"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%
    int totalBarang = Barang.getList().size();
    ArrayList<Sales> semuaTransaksi = Sales.getList();
    List<Sales> riwayatTerbaru = semuaTransaksi.subList(0, Math.min(semuaTransaksi.size(), 5));
    
    request.setAttribute("totalBarang", totalBarang);
    request.setAttribute("totalTransaksi", semuaTransaksi.size());
    request.setAttribute("riwayatTerbaru", riwayatTerbaru);

    RequestDispatcher dispatcher = request.getRequestDispatcher("home.view.jsp");
    dispatcher.forward(request, response);
%>