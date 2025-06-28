<%--
    Document   : formsalestambah.jsp 
    Created on : 28 Juni 2025
    Author     : Zamzam Faqot
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.Barang"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%
    // --- Prasyarat: Pastikan user sudah login ---
    // Jika tidak ada sesi "fullname", redirect ke halaman login untuk mencegah error.
    if (session.getAttribute("fullname") == null) {
        response.sendRedirect("formlogin.jsp");
        return; // Hentikan eksekusi halaman ini
    }

    Sales sales = new Sales();
    
    // Cek apakah ini transaksi baru atau melanjutkan yang sudah ada
    if (request.getParameter("id") == null) {
        // Ini adalah transaksi baru
        // 1. Ambil username dari session
        String user = (String) session.getAttribute("fullname");
        
        // 2. Kirim username ke method tambah()
        sales.tambah(user); 

    } else {
        // Ini melanjutkan transaksi yang sudah ada
        sales.baca(request.getParameter("id"));
    }
    
    // Ambil daftar semua barang untuk dropdown di halaman view
    List<Barang> semuaBarang = Barang.getList();
    
    // Kirim objek sales dan daftar barang ke halaman view
    request.setAttribute("sales", sales);
    request.setAttribute("barangList", semuaBarang);
    
    // Forward ke view
    
    RequestDispatcher dispatcher = request.getRequestDispatcher("formsalestambah.view.jsp");
    dispatcher.forward(request, response);
    
%>