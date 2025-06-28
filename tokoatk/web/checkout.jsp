<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Pastikan user sudah login
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("login.jsp?error=Silakan login untuk checkout.");
        return;
    }

    // Ambil keranjang dari sesi
    ArrayList<SalesDetail> keranjang = (ArrayList<SalesDetail>) session.getAttribute("keranjang");
    if (keranjang == null || keranjang.isEmpty()) {
        response.sendRedirect("keranjang.jsp?error=Keranjang kosong.");
        return;
    }

    // 1. Buat record Sales (Master Transaksi)
    Sales sales = new Sales();
    boolean salesBerhasil = sales.tambah(username); // Menggunakan username dari sesi

    if (salesBerhasil) {
        // 2. Simpan setiap item di keranjang sebagai SalesDetail
        for (SalesDetail item : keranjang) {
            item.salesId = sales.getId(); // Set ID transaksi master
            item.tambah(); // Method tambah() di SalesDetail akan mengurangi stok juga
        }

        // 3. Kosongkan keranjang di sesi
        session.removeAttribute("keranjang");

        // 4. Alihkan ke halaman struk dengan membawa ID transaksi
        response.sendRedirect("struk.jsp?id=" + sales.getId());

    } else {
        // Jika gagal membuat record sales master
        out.println("<h1>Error: Gagal memproses checkout!</h1>");
        out.println("<p>Terjadi kesalahan saat menyimpan data transaksi. Silakan coba lagi.</p>");
    }
%>