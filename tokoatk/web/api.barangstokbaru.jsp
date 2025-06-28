<%--
    Document   : api.barangstokbaru.jsp
    Created on : 28 Jun 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String stokbaruStr = request.getParameter("stokbaru");

    if (id != null && stokbaruStr != null) {
        Barang barang = new Barang();
        if (barang.baca(id)) { 
            barang.stok = Integer.parseInt(stokbaruStr);
            
            if(barang.updateStok()) { // Panggil method baru updateStok()
                out.print("ok");
            } else {
                out.print("fail");
            }
        } else {
            out.print("fail: barang tidak ditemukan");
        }
    } else {
        out.print("fail: data tidak lengkap");
    }
%>