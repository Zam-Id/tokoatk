<%--
    Document   : api.baranghargabaru.jsp
    Created on : 27 Jun 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String hargabaruStr = request.getParameter("hargabaru");

    if (id != null && hargabaruStr != null) {
        Barang barang = new Barang();
        // Gunakan method baca() dari Barang.java lama Anda
        if (barang.baca(id)) {
            // Set HANYA properti harga
            barang.harga = Integer.parseInt(hargabaruStr);
            
            // Panggil method updateHarga() yang akan kita buat
            if(barang.updateHarga()) { 
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