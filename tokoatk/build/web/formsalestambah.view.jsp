<%--
    Document   : formsalestambah.view.jsp (Versi Final & Lengkap)
    Created on : 28 Juni 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.Barang"%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.time.format.DateTimeFormatter"%>

<%
    // Ambil objek sales yang sudah disiapkan oleh controller (formsalestambah.jsp)
    Sales sales = (Sales) request.getAttribute("sales");
    // Jika karena suatu hal objek sales tidak ada, kembali ke halaman awal untuk memulai lagi
    if (sales == null) {
        response.sendRedirect("formsalestambah.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Transaksi: ${sales.id}</title>
    <%-- Semua link CSS, Font, dan jQuery Anda biarkan seperti adanya --%>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        <%-- Semua kode CSS Anda yang sudah bagus letakkan di sini --%>
        :root {
            --primary-color: #FF6B6B; --primary-color-dark: #e65a5a; --color-blue: #3B82F6;
            --background-color: #F4F6F9; --text-color: #2D3748; --text-color-light: #64748B;
            --card-bg-color: #FFFFFF; --border-color: #E2E8F0; --shadow-color: rgba(45, 55, 72, 0.1);
            --sidebar-width: 260px; --header-height: 70px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--background-color); color: var(--text-color); }
        .app-container { display: flex; min-height: 100vh; }
        .main-content { flex-grow: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; }
        .sidebar { width: var(--sidebar-width); background-color: var(--card-bg-color); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; position: fixed; top: 0; left: 0; height: 100%; transition: transform 0.3s ease-in-out; z-index: 1000; }
        .sidebar-header { display: flex; align-items: center; gap: 12px; padding: 0 20px; height: var(--header-height); border-bottom: 1px solid var(--border-color); }
        .sidebar-logo { width: 40px; height: 40px; background-color: var(--primary-color); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px; }
        .sidebar-title { font-size: 20px; font-weight: 600; }
        .sidebar-nav { list-style: none; flex-grow: 1; padding-top: 10px; }
        .nav-item a { display: flex; align-items: center; gap: 15px; padding: 12px 20px; margin: 4px 10px; border-radius: 8px; color: var(--text-color-light); text-decoration: none; font-weight: 500; transition: all 0.2s ease; }
        .nav-item a:hover { background-color: #FFF2F2; color: var(--primary-color); }
        .nav-item a.active { background-color: var(--primary-color); color: white; font-weight: 600; box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3); }
        .nav-item a i { font-size: 18px; width: 20px; text-align: center; }
        .main-header { height: var(--header-height); background-color: var(--card-bg-color); border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; padding: 0 30px; position: sticky; top: 0; z-index: 999; }
        .main-container { padding: 30px; flex-grow: 1; }
        .page-title { font-size: 28px; font-weight: 700; margin-bottom: 24px; }
        .pos-container { display: grid; grid-template-columns: 1fr 400px; gap: 24px; }
        .card { background-color: var(--card-bg-color); padding: 24px; border-radius: 16px; border: 1px solid var(--border-color); }
        .card-title { font-size: 18px; font-weight: 600; margin-bottom: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; }
        .form-group input, .form-group select { width: 100%; padding: 12px; border: 1px solid var(--border-color); border-radius: 8px; font-size: 16px; }
        .btn { padding: 12px 24px; border: none; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; }
        .btn-primary { background-color: var(--primary-color); color: white; }
        .btn-success { background-color: #28a745; color: white; width: 100%; justify-content: center; } /* Tombol Selesai */
        .receipt-items { list-style: none; padding: 0; min-height: 150px; max-height: 300px; overflow-y: auto; }
        .receipt-item { display: flex; justify-content: space-between; padding: 12px 0; border-bottom: 1px dashed var(--border-color); }
        .item-info .item-name { font-weight: 500; }
        .item-info .item-details { font-size: 12px; color: var(--text-color-light); }
        .item-total { font-weight: 500; }
        .receipt-total { margin-top: 20px; padding-top: 20px; border-top: 2px solid var(--text-color); }
        .total-row { display: flex; justify-content: space-between; font-size: 20px; font-weight: 600; }
    </style>
</head>
<body>
    <div class="app-container">
        <aside class="sidebar" id="sidebar">
             <%-- ... (Isi sidebar Anda di sini) ... --%>
        </aside>

        <div class="main-content">
            <header class="main-header">
                <%-- ... (Isi header Anda di sini) ... --%>
            </header>

            <main class="main-container">
                <h1 class="page-title">Buat Transaksi Baru</h1>
                
                <div class="pos-container">
                    <%-- Kolom Kiri: Form untuk Menambah Item --%>
                    <div class="card">
                        <h2 class="card-title">Tambah Item</h2>
                        <form action="salesdetailtambah.jsp" method="post">
                            <input type="hidden" name="salesId" value="${sales.id}">
                            
                            <div class="form-group">
                                <label for="barangSelection">Pilih Barang</label>
                                <select name="barangId" id="barangSelection" required onchange="updateHarga()">
                                    <option value="">-- Pilih salah satu --</option>
                                    <c:forEach var="brg" items="${barangList}">
                                        <option value="${brg.id}" data-harga="${brg.harga}" data-stok="${brg.stok}">${brg.nama} (Stok: ${brg.stok})</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="qty">Jumlah (Qty)</label>
                                <input name="qty" id="qtyInput" type="number" value="1" min="1" required>
                            </div>

                            <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Tambah Item</button>
                        </form>
                    </div>

                    <%-- Kolom Kanan: Struk Berjalan --%>
                    <div class="card">
                        <div class="receipt-header">
                            <h2 class="card-title">Transaksi Saat Ini</h2>
                            <p>ID: ${sales.id}</p>
                            <p>Kasir: ${sales.username}</p>
                        </div>
                        <ul class="receipt-items">
                             <c:if test="${empty sales.getDetail()}">
                                <p style="text-align: center; color: #999; padding: 20px 0;">Belum ada item ditambahkan.</p>
                             </c:if>
                             <c:forEach var="row" items="${sales.getDetail()}">
                                <li class="receipt-item">
                                    <div class="item-info">
                                        <div class="item-name">${row.getBarangNama()}</div>
                                        <div class="item-details">${row.qty} x Rp <fmt:formatNumber value="${row.harga}" pattern="#,##0" /></div>
                                    </div>
                                    <div class="item-total">Rp <fmt:formatNumber value="${row.getTotal()}" pattern="#,##0" /></div>
                                </li>
                             </c:forEach>
                        </ul>
                        <div class="receipt-total">
                            <div class="total-row">
                                <span>TOTAL</span>
                                <span>Rp <fmt:formatNumber value="${sales.getTotalKeseluruhan()}" pattern="#,##0" /></span>
                            </div>
                        </div>

                        <%-- INI TOMBOL YANG DITAMBAHKAN --%>
                        <a href="struk.jsp?id=${sales.id}" class="btn btn-success" style="margin-top: 20px;">
                            <i class="fas fa-print"></i> Selesai & Cetak Struk
                        </a>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
        // Fungsi untuk mengupdate stok maksimal pada input qty dan mengisi harga
        function updateHarga() {
            const selectElement = document.getElementById('barangSelection');
            const qtyInput = document.getElementById('qtyInput');
            const selectedOption = selectElement.options[selectElement.selectedIndex];
            
            if (selectedOption.value) {
                const maxStok = selectedOption.getAttribute('data-stok');
                qtyInput.setAttribute('max', maxStok);
                qtyInput.focus();
            }
        }
    </script>
</body>
</html>