<%--
    Document   : saleslist.view.jsp (Tampilan Daftar Transaksi)
    Created on : 28 Juni 2025
    Author     : Zamzam Faqot & Gemini
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Transaksi - Toko ATK</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        /* Menggunakan CSS Base yang sama persis dari halaman lain */
        :root {
            --primary-color: #FF6B6B; --primary-color-dark: #e65a5a; --color-blue: #3B82F6;
            --background-color: #F4F6F9; --text-color: #2D3748; --text-color-light: #64748B;
            --card-bg-color: #FFFFFF; --border-color: #E2E8F0; --shadow-color: rgba(45, 55, 72, 0.1);
            --sidebar-width: 260px; --header-height: 70px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--background-color); color: var(--text-color); }
        .app-container { display: flex; min-height: 100vh; }
        .sidebar { width: var(--sidebar-width); background-color: var(--card-bg-color); border-right: 1px solid var(--border-color); display: flex; flex-direction: column; position: fixed; top: 0; left: 0; height: 100%; transition: transform 0.3s ease-in-out; z-index: 1000; }
        .sidebar-header { display: flex; align-items: center; gap: 12px; padding: 0 20px; height: var(--header-height); border-bottom: 1px solid var(--border-color); }
        .sidebar-logo { width: 40px; height: 40px; background-color: var(--primary-color); border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; font-size: 20px; }
        .sidebar-title { font-size: 20px; font-weight: 600; }
        .sidebar-nav { list-style: none; flex-grow: 1; padding-top: 10px; }
        .nav-item a { display: flex; align-items: center; gap: 15px; padding: 12px 20px; margin: 4px 10px; border-radius: 8px; color: var(--text-color-light); text-decoration: none; font-weight: 500; transition: all 0.2s ease; }
        .nav-item a:hover { background-color: #FFF2F2; color: var(--primary-color); }
        .nav-item a.active { background-color: var(--primary-color); color: white; font-weight: 600; box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3); }
        .nav-item a i { font-size: 18px; width: 20px; text-align: center; }
        .sidebar-footer { padding: 20px; border-top: 1px solid var(--border-color); }
        .logout-button { background-color: #FFF2F2; color: var(--primary-color-dark); }
        .logout-button:hover { background-color: var(--primary-color-dark); color: white; }
        .main-content { flex-grow: 1; margin-left: var(--sidebar-width); display: flex; flex-direction: column; }
        .main-header { height: var(--header-height); background-color: var(--card-bg-color); border-bottom: 1px solid var(--border-color); display: flex; justify-content: space-between; align-items: center; padding: 0 30px; position: sticky; top: 0; z-index: 999; }
        .mobile-menu-button { display: none; font-size: 24px; background: none; border: none; cursor: pointer; color: var(--text-color); }
        .user-profile { position: relative; cursor: pointer; }
        .user-profile-toggle { display: flex; align-items: center; gap: 10px; }
        .user-avatar { width: 40px; height: 40px; border-radius: 50%; background-color: var(--primary-color); color: white; display: flex; align-items: center; justify-content: center; font-weight: 600; }
        .user-name { font-weight: 600; }
        .user-dropdown { position: absolute; top: calc(100% + 10px); right: 0; background-color: var(--card-bg-color); border-radius: 8px; box-shadow: 0 4px 20px var(--shadow-color); width: 200px; z-index: 10; overflow: hidden; opacity: 0; visibility: hidden; transform: translateY(10px); transition: all 0.2s ease; }
        .user-profile:hover .user-dropdown { opacity: 1; visibility: visible; transform: translateY(0); }
        .user-dropdown a { display: flex; gap: 10px; padding: 12px 15px; color: var(--text-color); text-decoration: none; }
        .user-dropdown a:hover { background-color: var(--background-color); }
        .main-container { padding: 30px; flex-grow: 1; }
        .page-title { font-size: 28px; font-weight: 700; margin-bottom: 8px; }
        .page-subtitle { font-size: 16px; color: var(--text-color-light); margin-bottom: 24px; }
        .card { background-color: var(--card-bg-color); padding: 24px; border-radius: 16px; border: 1px solid var(--border-color); }
        .table-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px; }
        .search-wrapper { position: relative; }
        .search-wrapper input { padding: 10px 15px 10px 40px; border: 1px solid var(--border-color); border-radius: 8px; font-family: 'Poppins', sans-serif; width: 280px; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
        .search-wrapper input:focus { border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1); }
        .search-wrapper i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-color-light); }
        .btn { padding: 10px 18px; border: none; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600; font-family: 'Poppins', sans-serif; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; transition: all 0.2s ease; }
        .btn-primary { background-color: var(--primary-color); color: white; }
        .btn-primary:hover { background-color: var(--primary-color-dark); transform: translateY(-2px); box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3); }
        .table-responsive { overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 16px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .data-table thead th { font-size: 12px; font-weight: 600; color: var(--text-color-light); text-transform: uppercase; letter-spacing: 0.5px; }
        .data-table tbody tr:hover { background-color: var(--background-color); }
        .actions-cell { text-align: right !important; }
        .action-btn { width: auto; padding: 6px 12px; height: auto; border-radius: 6px; }
        .action-btn.view { background-color: #EBF5FF; color: var(--color-blue); }
        .action-btn.view:hover { background-color: var(--color-blue); color: white; }
        @media (max-width: 992px) { .sidebar { transform: translateX(-100%); } .sidebar.active { transform: translateX(0); } .main-content { margin-left: 0; } .mobile-menu-button { display: block; } }
    </style>
</head>
<body>
    <%
        String fullname = session.getAttribute("fullname") != null ? (String) session.getAttribute("fullname") : "Pengguna";
        char initial = fullname.isEmpty() ? 'P' : fullname.charAt(0);
    %>
    <div class="app-container">
        <aside class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo"><i class="fas fa-store"></i></div>
                <h2 class="sidebar-title">Toko ATK</h2>
            </div>
            <ul class="sidebar-nav">
                <li class="nav-item">
                    <a href="home.jsp">
                        <i class="fas fa-tachometer-alt"></i><span>Dashboard</span>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="baranglist.jsp">
                        <i class="fas fa-boxes-stacked"></i><span>Manajemen Barang</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="formsalestambah.jsp">
                        <i class="fas fa-cash-register"></i><span>Transaksi Baru</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="userlist.jsp">
                        <i class="fas fa-users"></i><span>Manajemen User</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="saleslist.jsp">
                        <i class="fas fa-history"></i><span>Riwayat</span>
                    </a>
                </li>

                <li class="nav-item">
                    <a href="#"><i class="fas fa-chart-pie"></i><span>Laporan</span></a>
                </li>
                <li class="nav-item">
                    <a href="#"><i class="fas fa-cog"></i><span>Pengaturan</span></a>
                </li>
            </ul>
            <div class="sidebar-footer">
                <a href="logout.jsp" class="nav-item logout-button"><i class="fas fa-sign-out-alt"></i><span>Logout</span></a>
            </div>
        </aside>

        <div class="main-content">
            <header class="main-header">
                <button class="mobile-menu-button" id="mobile-menu-btn"><i class="fas fa-bars"></i></button>
                <div class="header-title"></div>
                <div class="header-actions">
                    <div class="user-profile">
                        <div class="user-profile-toggle">
                            <div class="user-avatar"><%= initial %></div>
                            <span class="user-name"><%= fullname %></span>
                            <i class="fas fa-chevron-down"></i>
                        </div>
                        <div class="user-dropdown">
                            <a href="#"><i class="fas fa-user-circle"></i> Profil Saya</a>
                            <a href="logout.jsp"><i class="fas fa-sign-out-alt"></i> Logout</a>
                        </div>
                    </div>
                </div>
            </header>

            <main class="main-container">
                <h1 class="page-title">Riwayat Transaksi</h1>
                <p class="page-subtitle">Lihat semua riwayat penjualan yang telah tercatat di sistem.</p>

                <div class="card">
                    <div class="table-controls">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Cari berdasarkan ID Transaksi atau Kasir...">
                        </div>
                        <a href="formsalestambah.jsp" class="btn btn-primary">
                            <i class="fas fa-plus"></i>
                            <span>Buat Transaksi Baru</span>
                        </a>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="data-table" id="salesTable">
                            <thead>
                                <tr>
                                    <th>ID Transaksi</th>
                                    <th>Waktu</th>
                                    <th>Kasir</th>
                                    <th>Total Item</th>
                                    <th>Total Harga</th>
                                    <th style="text-align: right;">Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="sales" items="${salesList}">
                                    <tr>
                                        <td>${sales.id}</td>
                                        <td><fmt:formatDate value="${sales.waktu}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td>${sales.username}</td>
                                        <td>${sales.getDetail().size()} item</td>
                                        <td>Rp <fmt:formatNumber type="number" pattern="#,##0" value="${sales.getTotalKeseluruhan()}" /></td>
                                        <td class="actions-cell">
                                            <a href="formsalestambah.jsp?id=${sales.id}" class="btn action-btn view">
                                                <i class="fas fa-eye"></i> Lihat Detail
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <script>
            $(document).ready(function() {
        // --- LOGIKA STANDAR UNTUK SEMUA HALAMAN ---

        // 1. Fungsi untuk toggle sidebar di mobile
        $('#mobile-menu-btn').on('click', function() {
            $('#sidebar').toggleClass('active');
        });

        // 2. Fungsi untuk menandai menu aktif di sidebar (Versi Sederhana & Benar)
        const currentFile = window.location.pathname.split('/').pop();
        const sidebarLinks = $('.sidebar-nav a');
        
        sidebarLinks.removeClass('active'); // Selalu hapus semua class active dulu

        let linkFound = false;
        sidebarLinks.each(function() {
            const linkFile = $(this).attr('href');
            if (linkFile === currentFile) {
                $(this).addClass('active');
                linkFound = true;
            }
        });
        
        // Jika tidak ada link yang cocok (misalnya di halaman index atau root),
        // maka aktifkan link Dashboard sebagai default.
        if (!linkFound && currentFile === '') {
             $('.sidebar-nav a[href="home.jsp"]').addClass('active');
        }
    });

    // --- FUNGSI SPESIFIK UNTUK SETIAP HALAMAN (JIKA ADA) ---
    // contoh: function editNama(), function updateHarga(), dll.
    </script>
</body>
</html>