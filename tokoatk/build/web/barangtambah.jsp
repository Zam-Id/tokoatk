<%--
    Document   : barangtambah.jsp (Versi Aman dengan Pengecekan Input)
    Created on : 28 Jun 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@page import="tokoatk.Barang"%>
<%
    // Mengambil semua parameter sebagai String terlebih dahulu
    String nama = request.getParameter("nama");
    String jenis = request.getParameter("jenis");
    String hargaStr = request.getParameter("harga");
    String stokStr = request.getParameter("stok");

    // Menyiapkan variabel dengan nilai default 0
    int harga = 0;
    int stok = 0;

    // [PERBAIKAN] Melakukan konversi dengan aman di dalam blok try-catch
    try {
        // Hanya konversi jika string tidak null dan tidak kosong
        if (hargaStr != null && !hargaStr.isEmpty()) {
            harga = Integer.parseInt(hargaStr);
        }
        if (stokStr != null && !stokStr.isEmpty()) {
            stok = Integer.parseInt(stokStr);
        }
    } catch (NumberFormatException e) {
        // Jika terjadi error saat konversi (misal pengguna memasukkan huruf),
        // biarkan nilai harga dan stok tetap 0 (nilai default).
        // Kita juga bisa mencetak error di log server untuk debugging.
        e.printStackTrace();
    }

    // Buat objek Barang baru
    Barang barang = new Barang();
    
    // Set properti dengan nilai yang sudah aman
    barang.nama = nama;
    barang.jenis = jenis;
    barang.harga = harga;
    barang.stok = stok;
    
    // Panggil method tambah()
    if (barang.tambah()) {
        // Jika berhasil, alihkan ke halaman daftar barang
        response.sendRedirect("baranglist.jsp");
    } else {
        // Jika gagal, tampilkan pesan
        out.println("<h1>Maaf, terjadi kesalahan saat menyimpan data.</h1>");
        out.println("<p>Pastikan semua data terisi dengan benar.</p>");
        out.println("<a href='formbarangtambah.jsp'>Kembali ke form</a>");
    }
%>