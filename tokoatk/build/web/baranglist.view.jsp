<%--
    Document   : baranglist.view.jsp (Revisi Final - HANYA STYLE)
    Created on : 27 Juni 2025
    Author     : Zamzam Faqot & Gemini
    Purpose    : Tampilan modern yang 100% kompatibel dengan backend lama.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manajemen Barang - Toko ATK</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        /* Menggunakan CSS Base yang sama persis dari home.view.jsp */
        :root {
            --primary-color: #FF6B6B; --primary-color-dark: #e65a5a; --color-blue: #3B82F6;
            --background-color: #F4F6F9; --text-color: #2D3748; --text-color-light: #64748B;
            --card-bg-color: #FFFFFF; --border-color: #E2E8F0; --shadow-color: rgba(45, 55, 72, 0.1);
            --sidebar-width: 260px; --header-height: 70px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--background-color); color: var(--text-color); }
        .app-container { display: flex; min-height: 100vh; }
        
        /* Semua style Sidebar & Main Content disalin dari home.view.jsp */
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
        
        /* Styling untuk Tabel dan Kontrol Halaman Ini */
        .card { background-color: var(--card-bg-color); padding: 24px; border-radius: 16px; border: 1px solid var(--border-color); }
        .table-controls { display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; flex-wrap: wrap; gap: 15px; }
        .search-wrapper { position: relative; }
        .search-wrapper input { padding: 10px 15px 10px 40px; border: 1px solid var(--border-color); border-radius: 8px; font-family: 'Poppins', sans-serif; width: 280px; outline: none; transition: border-color 0.2s, box-shadow 0.2s; }
        .search-wrapper input:focus { border-color: var(--primary-color); box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1); }
        .search-wrapper i { position: absolute; left: 15px; top: 50%; transform: translateY(-50%); color: var(--text-color-light); }
        .btn { padding: 10px 18px; border: none; border-radius: 8px; cursor: pointer; font-size: 14px; font-weight: 600; font-family: 'Poppins', sans-serif; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; transition: all 0.2s ease; }
        .btn-primary { background-color: var(--primary-color); color: white; }
        .btn-primary:hover { background-color: var(--primary-color-dark); transform: translateY(-2px); box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3); }
        .btn-secondary { background-color: #f1f5f9; color: var(--text-color); }
        .btn-secondary:hover { background-color: #e2e8f0; }
        .table-responsive { overflow-x: auto; }
        .data-table { width: 100%; border-collapse: collapse; }
        .data-table th, .data-table td { padding: 16px; text-align: left; border-bottom: 1px solid var(--border-color); }
        .data-table thead th { font-size: 12px; font-weight: 600; color: var(--text-color-light); text-transform: uppercase; letter-spacing: 0.5px; }
        .data-table tbody tr:hover { background-color: var(--background-color); }
        .item-name { font-weight: 600; }
        .actions-cell { display: flex; gap: 10px; }
        .action-btn { width: 32px; height: 32px; border-radius: 8px; display: inline-flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.2s ease; border: none; cursor: pointer; }
        .action-btn.edit { background-color: #EBF5FF; color: var(--color-blue); }
        .action-btn.edit:hover { background-color: var(--color-blue); color: white; }
        .action-btn.delete { background-color: #FFF2F2; color: var(--primary-color); }
        .action-btn.delete:hover { background-color: var(--primary-color); color: white; }
        @media (max-width: 992px) { .sidebar { transform: translateX(-100%); } .sidebar.active { transform: translateX(0); } .main-content { margin-left: 0; } .mobile-menu-button { display: block; } }
    </style>
</head>
<body>
    <%
        String fullname = session.getAttribute("fullname") != null ? (String) session.getAttribute("fullname") : "Pengguna";
        char initial = fullname.isEmpty() ? 'P' : fullname.charAt(0);
    %>
    <div class="app-container">
        <jsp:include page="sidebar.jsp" />
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
                <h1 class="page-title">Manajemen Barang</h1>
                <p class="page-subtitle">Kelola semua daftar inventaris barang yang tersedia di toko Anda.</p>
                <div class="card">
                    <div class="table-controls">
                        <div class="search-wrapper">
                            <i class="fas fa-search"></i>
                            <input type="text" id="searchInput" placeholder="Cari barang...">
                        </div>
                        <a href="formbarangtambah.jsp" class="btn btn-primary"><i class="fas fa-plus"></i><span>Tambah Barang</span></a>
                    </div>
                    <div class="table-responsive">
                        <table class="data-table" id="barangTable">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Nama Barang</th>
                                    <th>Harga</th>
                                    <th>Stok</th> 
                                    <th>Aksi</th> </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="barang" items="${list}">
                                    <tr>
                                        <td>${barang.id}</td>
                                        <td class="item-name" id="nama-${barang.id}">${barang.nama}</td>
                                        <td>Rp <span id="harga-${barang.id}"><fmt:formatNumber type="number" pattern="#,##0" value="${barang.harga}" /></span></td>

                                        <td id="stok-${barang.id}">${barang.stok}</td>

                                        <td class="actions-cell">
                                            <button class="action-btn edit" title="Edit Nama" onclick="editNama('${barang.id}')">
                                                <i class="fas fa-font"></i>
                                            </button>

                                            <button class="action-btn edit" title="Edit Harga" onclick="editHarga('${barang.id}')" style="background-color: #E6F4EA; color: #34A853;">
                                                <i class="fas fa-tags"></i>
                                            </button>

                                            <button class="action-btn edit" title="Edit Stok" onclick="editStok('${barang.id}')" style="background-color: #FEF3C7; color: #D97706;">
                                                <i class="fas fa-cubes"></i>
                                            </button>

                                            <a href="baranghapus.jsp?id=${barang.id}" class="action-btn delete" title="Hapus Barang" onclick="return confirm('Yakin ingin menghapus barang \'${barang.nama}\'?');">
                                                <i class="fas fa-trash-alt"></i>
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

        // 1. Fungsi HANYA untuk mengedit nama
        function editNama(id) {
            let namaLama = $('#nama-' + id).text();
            let namaBaru = prompt("Edit nama barang:", namaLama);

            if (namaBaru !== null) {
                // Panggil API yang sudah ada untuk ganti nama
                $.post("api.baranggantinama.jsp", { id: id, namabaru: namaBaru })
                    .done(function(response) {
                        if (response.trim().toLowerCase() === "ok") {
                            $('#nama-' + id).text(namaBaru);
                            alert("Nama barang berhasil diubah!");
                        } else {
                            alert("Gagal mengubah nama.");
                        }
                    })
                    .fail(() => alert("Terjadi kesalahan koneksi."));
            }
        }

        // 2. Fungsi HANYA untuk mengedit harga
        function editHarga(id) {
            let hargaLamaText = $('#harga-' + id).text().replace(/\./g, '');
            let hargaLama = parseInt(hargaLamaText, 10);
            let hargaBaruStr = prompt("Edit harga barang:", hargaLama);

            if (hargaBaruStr !== null) {
                // Panggil API BARU khusus untuk ganti harga
                $.post("api.baranghargabaru.jsp", { id: id, hargabaru: hargaBaruStr })
                    .done(function(response) {
                        if (response.trim().toLowerCase() === "ok") {
                            var hargaFormatted = new Intl.NumberFormat('id-ID').format(hargaBaruStr);
                            $('#harga-' + id).text(hargaFormatted);
                            alert("Harga barang berhasil diperbarui!");
                        } else {
                            alert("Gagal memperbarui harga.");
                        }
                    })
                    .fail(() => alert("Terjadi kesalahan koneksi."));
            }
        }

        // [TAMBAHKAN FUNGSI INI DI DALAM TAG SCRIPT ANDA]

        // Fungsi HANYA untuk mengedit stok
        function editStok(id) {
            // Ambil nilai stok saat ini dari tabel
            let stokLama = $('#stok-' + id).text();

            // Minta input stok baru dari pengguna
            let stokBaruStr = prompt("Edit jumlah stok:", stokLama);

            // Jika pengguna tidak menekan "Cancel"
            if (stokBaruStr !== null) {

                // Panggil API yang sudah kita siapkan
                $.post("api.barangstokbaru.jsp", { id: id, stokbaru: stokBaruStr })
                    .done(function(response) {
                        // Jika API merespon "ok"
                        if (response.trim().toLowerCase() === "ok") {
                            // Update tampilan stok di tabel secara langsung
                            $('#stok-' + id).text(stokBaruStr);
                            alert("Stok barang berhasil diperbarui!");
                        } else {
                            // Tampilkan pesan gagal jika respon bukan "ok"
                            alert("Gagal memperbarui stok. Pesan: " + response);
                        }
                    })
                    .fail(function() {
                        // Tampilkan pesan jika koneksi ke API gagal (misal error 404 atau 500)
                        alert("Terjadi kesalahan koneksi ke API.");
                    });
            }
        }
    </script>
</body>
</html>