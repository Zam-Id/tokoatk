<%-- File: home.view.jsp (Tampilan Dashboard Final) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Toko ATK</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <style>
        :root {
            --primary-color: #FF6B6B; --primary-color-dark: #e65a5a; --color-blue: #3B82F6;
            --color-green: #10B981; --color-yellow: #F59E0B;
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
        .page-title { font-size: 28px; font-weight: 700; margin-bottom: 24px; }
        .dashboard-grid { display: grid; gap: 24px; }
        .grid-col-4 { grid-template-columns: repeat(4, 1fr); }
        .grid-col-2 { grid-template-columns: repeat(2, 1fr); }
        .stat-card { background: var(--card-bg-color); padding: 20px; border-radius: 12px; display: flex; align-items: center; gap: 20px; }
        .stat-card .icon { font-size: 24px; width: 50px; height: 50px; border-radius: 10px; display: flex; align-items: center; justify-content: center; color: white; }
        .stat-card .icon.blue { background: var(--color-blue); }
        .stat-card .icon.green { background: var(--color-green); }
        .stat-card .icon.yellow { background: var(--color-yellow); }
        .stat-card .icon.red { background: var(--primary-color); }
        .stat-card .info .title { font-size: 14px; color: var(--text-color-light); }
        .stat-card .info .value { font-size: 28px; font-weight: 700; }
        .action-card { background: var(--card-bg-color); padding: 24px; border-radius: 12px; text-decoration: none; color: var(--text-color); display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 15px; text-align: center; transition: all 0.2s ease; }
        .action-card:hover { transform: translateY(-5px); box-shadow: 0 8px 25px var(--shadow-color); }
        .action-card .icon { font-size: 36px; color: var(--primary-color); }
        .action-card .title { font-size: 18px; font-weight: 600; }
        .action-card .subtitle { font-size: 14px; color: var(--text-color-light); }
        .card { background-color: var(--card-bg-color); padding: 24px; border-radius: 16px; }
        .card-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .card-title { font-size: 18px; font-weight: 600; }
        .view-all-link { font-size: 14px; color: var(--primary-color); text-decoration: none; font-weight: 500; }
        .table-responsive { overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 16px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .data-table thead th { font-size: 12px; font-weight: 600; color: var(--text-color-light); text-transform: uppercase; }
        @media (max-width: 1200px) { .grid-col-4 { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 992px) { .sidebar { transform: translateX(-100%); } .sidebar.active { transform: translateX(0); } .main-content { margin-left: 0; } .mobile-menu-button { display: block; } }
        @media (max-width: 768px) { .grid-col-2, .grid-col-4 { grid-template-columns: 1fr; } }
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
                <h1 class="page-title">Selamat Datang, <%= fullname %>!</h1>
                <div class="dashboard-grid grid-col-4" style="margin-bottom: 24px;">
                    <div class="stat-card">
                        <div class="icon blue"><i class="fas fa-dollar-sign"></i></div>
                        <div class="info">
                            <div class="title">Total Penjualan</div>
                            <div class="value">Rp ---</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="icon green"><i class="fas fa-receipt"></i></div>
                        <div class="info">
                            <div class="title">Jumlah Transaksi</div>
                            <div class="value">${totalTransaksi}</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="icon yellow"><i class="fas fa-box-open"></i></div>
                        <div class="info">
                            <div class="title">Jumlah Jenis Barang</div>
                            <div class="value">${totalBarang}</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="icon red"><i class="fas fa-users"></i></div>
                        <div class="info">
                            <div class="title">Total Pengguna</div>
                            <div class="value">1</div>
                        </div>
                    </div>
                </div>
                
                <div class="dashboard-grid grid-col-2" style="margin-bottom: 24px;">
                    <a href="formsalestambah.jsp" class="action-card">
                        <div class="icon"><i class="fas fa-cash-register"></i></div>
                        <div class="title">Buat Transaksi Baru</div>
                        <div class="subtitle">Mulai penjualan untuk pelanggan</div>
                    </a>
                    <a href="baranglist.jsp" class="action-card">
                        <div class="icon"><i class="fas fa-boxes-stacked"></i></div>
                        <div class="title">Kelola Barang</div>
                        <div class="subtitle">Tambah, edit, atau hapus item</div>
                    </a>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">Riwayat Transaksi Terbaru</h2>
                        <a href="saleslist.jsp" class="view-all-link">Lihat Semua &rarr;</a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID Transaksi</th>
                                    <th>Waktu</th>
                                    <th>Kasir</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="trx" items="${riwayatTerbaru}">
                                    <tr>
                                        <td>${trx.id}</td>
                                        <td><fmt:formatDate value="${trx.waktu}" pattern="dd MMM yyyy, HH:mm" /></td>
                                        <td>${trx.username}</td>
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