<%-- File: header.jsp --%>
<%
    String fullname = session.getAttribute("fullname") != null ? (String) session.getAttribute("fullname") : "Pengguna";
    char initial = fullname.isEmpty() ? 'P' : fullname.charAt(0);
%>
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