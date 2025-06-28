<%--
    Document   : sidebar.jsp
    Created on : 27 Jun 2025
    Author     : Zamzam Faqot & Gemini
    Purpose    : Template terpusat untuk menu sidebar.
--%>
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