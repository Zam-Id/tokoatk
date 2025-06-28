<%--
    Document   : api.baranggantinama (Revisi untuk Update Harga)
    Created on : 27 Jun 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%
    String id = request.getParameter("id");
    String namabaru = request.getParameter("namabaru");
    String hargabaruStr = request.getParameter("hargabaru"); // Ambil parameter harga

    // Pengecekan dasar apakah data ada
    if (id != null && namabaru != null && hargabaruStr != null) {
        Barang barang = new Barang();
        // Gunakan method baca() dari Barang.java lama Anda
        if (barang.baca(id)) { 
            // Set properti public secara langsung
            barang.nama = namabaru;
            barang.harga = Integer.parseInt(hargabaruStr); // Set harga baru
            
            // Panggil method update() lama Anda, yang sekarang akan menyimpan nama & harga baru
            if(barang.update()) {
                out.print("ok");
            } else {
                out.print("fail");
            }
        } else {
            out.print("fail: barang tidak ditemukan");
        }
    } else {
        out.print("fail: data yang dikirim tidak lengkap");
    }
%>