<%--
    Document   : formbarangtambah.view.jsp (Revisi Style Penuh)
    Created on : 27 Juni 2025, 23:19:04 WIB
    Author     : Zamzam Faqot & Gemini
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Barang Baru - Toko ATK</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* [KONSISTEN] Menggunakan CSS Base yang sama persis dari halaman lain */
        :root {
            --primary-color: #FF6B6B; --primary-color-dark: #e65a5a; --color-blue: #3B82F6;
            --background-color: #F4F6F9; --text-color: #2D3748; --text-color-light: #64748B;
            --card-bg-color: #FFFFFF; --border-color: #E2E8F0; --shadow-color: rgba(45, 55, 72, 0.1);
            --sidebar-width: 260px; --header-height: 70px;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Poppins', sans-serif; background-color: var(--background-color); color: var(--text-color); }
        .app-container { display: flex; min-height: 100vh; }
        
        /* Semua style Sidebar & Main Content disalin untuk konsistensi */
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
        
        /* Styling untuk Form */
        .card { background-color: var(--card-bg-color); padding: 30px; border-radius: 16px; border: 1px solid var(--border-color); }
        .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .form-group { margin-bottom: 15px; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-group label { display: block; margin-bottom: 8px; font-weight: 500; color: var(--text-color); }
        .form-group input, .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-family: 'Poppins', sans-serif;
            font-size: 16px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-group input:focus, .form-group select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(255, 107, 107, 0.1);
        }
        .form-actions {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: flex-end; /* Tombol di kanan */
            gap: 12px;
        }
        .btn { padding: 12px 24px; border: none; border-radius: 8px; cursor: pointer; font-size: 15px; font-weight: 600; font-family: 'Poppins', sans-serif; display: inline-flex; align-items: center; gap: 8px; text-decoration: none; transition: all 0.2s ease; }
        .btn-primary { background-color: var(--primary-color); color: white; }
        .btn-primary:hover { background-color: var(--primary-color-dark); transform: translateY(-2px); box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3); }
        .btn-secondary { background-color: #f1f5f9; color: var(--text-color); }
        .btn-secondary:hover { background-color: #e2e8f0; }

        @media (max-width: 992px) { .sidebar { transform: translateX(-100%); } .sidebar.active { transform: translateX(0); } .main-content { margin-left: 0; } .mobile-menu-button { display: block; } }
        @media (max-width: 768px) { .form-grid { grid-template-columns: 1fr; } }
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
                <h1 class="page-title">Tambah Barang Baru</h1>
                <p class="page-subtitle">Isi detail di bawah ini untuk menambahkan item baru ke inventaris.</p>
                
                <div class="card">
                    <form action="barangtambah.jsp" method="post">
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="id">ID Barang</label>
                                <input type="text" id="id" name="id" readonly style="background-color: #e9ecef; cursor: not-allowed;">
                            </div>
                            
                            <div class="form-group">
                                <label for="jenis">Jenis Barang</label>
                                <input type="text" id="jenis" name="jenis" placeholder="cth: Buku Tulis" required>
                            </div>

                            <div class="form-group full-width">
                                <label for="nama">Nama Barang</label>
                                <input type="text" id="nama" name="nama" placeholder="cth: Buku Tulis Campus 38 Lembar" required>
                            </div>
                            
                            <div class="form-group">
                                <label for="harga">Harga (Rp)</label>
                                <input type="number" id="harga" name="harga" placeholder="cth: 3500" required>
                            </div>

                            <div class="form-group">
                                <label for="stok">Stok Awal</label>
                                <input type="number" id="stok" name="stok" placeholder="cth: 100" required>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <a href="baranglist.jsp" class="btn btn-secondary">Kembali</a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                Simpan Barang
                            </button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </div>

    <script>
        // Script untuk toggle sidebar di mobile
        document.getElementById('mobile-menu-btn').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('active');
        });

        // [BARU] Script untuk mengisi ID otomatis secara visual
        document.addEventListener('DOMContentLoaded', function() {
            const idField = document.getElementById('id');
            const now = new Date();
            const year = String(now.getFullYear()).slice(-2); // Ambil 2 digit terakhir tahun
            const month = String(now.getMonth() + 1).padStart(2, '0'); // Bulan dari 0-11
            const day = String(now.getDate()).padStart(2, '0');
            const randomChars = Math.random().toString(36).substring(2, 6).toUpperCase();

            idField.value = `ID-${day}${month}${year}-${randomChars}`;
        });
    </script>
    
</body>
</html>