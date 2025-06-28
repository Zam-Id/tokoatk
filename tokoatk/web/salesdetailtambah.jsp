<%--
    Document    : salesdetailtambah.jsp 
    Created on  : 28 Juni 2025
    Author      : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.SalesDetail"%>
<%
    String salesId = request.getParameter("salesId");
    String barangIdStr = request.getParameter("barangId");
    String qtyStr = request.getParameter("qty");

    if (salesId == null || barangIdStr == null || qtyStr == null || barangIdStr.isEmpty() || qtyStr.isEmpty()) {
        out.println("Error: Data tidak lengkap.");
        return;
    }

    try {
        SalesDetail detail = new SalesDetail();
        detail.salesId = salesId;
        detail.barangId = Integer.parseInt(barangIdStr);
        detail.qty = Integer.parseInt(qtyStr);

        detail.tambah(); // Method ini akan menyimpan & mengurangi stok

        // Redirect kembali ke halaman transaksi dengan ID yang sama
        response.sendRedirect("formsalestambah.jsp?id=" + salesId);
    } catch (NumberFormatException e) {
        out.println("Error: Format angka tidak valid.");
    }
%>