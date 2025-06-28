<%--
    Document   : index.jsp (Revisi Final: Latar Terang)
    Created on : 26 Juni 2025
    Author     : Zamzam Faqot & Gemini (Rekan Full-stack Anda)
    Purpose    : Halaman pemuat dengan palet "Fajar Ceria" (latar terang).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Toko ATK - Memuat...</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* [PERUBAHAN] Palet Warna "Fajar Ceria" dengan Latar Terang */
        :root {
            --primary-color: #FF6B6B;      /* Living Coral (Warna utama tetap) */
            --background-color: #F4F6F9;   /* Light Cool Grey (Latar terang & bersih) */
            --text-color: #2D3748;         /* Dark Slate (Teks gelap agar kontras) */
            --progress-track-color: #E2E8F0; /* Warna track progress bar yang lebih terang */
        }

        body {
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: var(--background-color); /* [PERUBAHAN] Latar terang */
            font-family: 'Poppins', sans-serif;
            color: var(--text-color); /* [PERUBAHAN] Teks gelap */
            overflow: hidden;
        }

        .container {
            text-align: center;
            opacity: 0;
            animation: fadeIn 0.8s 0.2s ease-in-out forwards;
        }
        
        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }
        
        .app-icon {
            font-size: 3rem;
            color: var(--primary-color);
            margin-bottom: 20px;
        }

        .loading-text {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 25px;
        }

        .progress-bar {
            width: 250px;
            height: 6px;
            background-color: var(--progress-track-color); /* [PERUBAHAN] Latar progress bar */
            border-radius: 3px;
            overflow: hidden;
            margin: 0 auto;
        }

        .progress-bar::before {
            content: '';
            display: block;
            width: 0;
            height: 100%;
            background-color: var(--primary-color);
            border-radius: 3px;
            animation: progress 2.5s linear forwards;
        }

        @keyframes progress {
            from { width: 0%; }
            to { width: 100%; }
        }
    </style>
</head>
<body>

    <div class="container">
        <div class="app-icon">
            <i class="fas fa-store-alt"></i> 
        </div>
        <p class="loading-text">Selamat Datang di Aplikasi Toko ATK</p>
        <div class="progress-bar"></div>
    </div>

    <%
        boolean isLoggedIn = session.getAttribute("fullname") != null;
    %>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const redirectDelay = 2500; 
            setTimeout(function() {
                const isLoggedIn = <%= isLoggedIn %>;
                if (isLoggedIn) {
                    window.location.href = 'home.jsp';
                } else {
                    window.location.href = 'formlogin.jsp';
                }
            }, redirectDelay);
        });
    </script>

</body>
</html>