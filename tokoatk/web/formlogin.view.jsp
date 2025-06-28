<%--
    Document   : formlogin.view.jsp (Revisi Total)
    Created on : 26 Jun 2025
    Author     : Zamzam Faqot & Gemini (Rekan Full-stack Anda)
    Purpose    : Halaman login dengan desain bersih, modern, dan konsisten.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Toko ATK</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* [PENYESUAIAN WARNA] Menggunakan palet "Fajar Ceria" secara konsisten */
        :root {
            --primary-color: #FF6B6B;      /* Living Coral */
            --background-color: #F4F6F9;   /* Light Cool Grey */
            --text-color: #2D3748;         /* Dark Slate */
            --text-color-light: #64748B;   /* Grey untuk sub-teks */
            --card-bg-color: #FFFFFF;      /* Warna card */
            --border-color: #E2E8F0;      /* Warna border input */
            --shadow-color: rgba(45, 55, 72, 0.1); /* Warna bayangan yang lembut */
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: var(--background-color); /* [DISEDERHANAKAN] Latar belakang solid */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-container {
            background-color: var(--card-bg-color);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 40px var(--shadow-color); /* [DISEDERHANAKAN] Shadow yang lebih lembut */
            text-align: center;
            max-width: 400px;
            width: 100%;
            animation: slideUp 0.7s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .logo-section {
            margin-bottom: 24px;
        }

        .logo {
            width: 64px;
            height: 64px;
            background-color: var(--primary-color); /* [PENYESUAIAN WARNA] Logo solid */
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.4);
        }

        .logo i {
            font-size: 28px;
            color: var(--card-bg-color);
        }

        .brand-title {
            font-size: 24px;
            font-weight: 600;
            color: var(--text-color);
            margin-bottom: 4px;
        }

        .brand-subtitle {
            font-size: 14px;
            color: var(--text-color-light);
            margin-bottom: 32px;
        }

        .form-container {
            text-align: left;
        }

        .input-group {
            margin-bottom: 20px;
            position: relative;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--text-color);
            font-weight: 500;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }
        
        .input-icon {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-color-light);
            transition: color 0.3s ease;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 14px 16px 14px 48px;
            border: 2px solid var(--border-color);
            border-radius: 12px;
            font-size: 16px; /* Mencegah auto-zoom di iOS */
            font-family: 'Poppins', sans-serif;
            color: var(--text-color);
            background-color: var(--card-bg-color);
            outline: none;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        
        /* [UX LEBIH BAIK] Interaksi focus yang lebih halus */
        input[type="text"]:focus,
        input[type="password"]:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.1);
        }

        input[type="text"]:focus ~ .input-icon,
        input[type="password"]:focus ~ .input-icon {
            color: var(--primary-color);
        }

        .login-button {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-color); /* [PENYESUAIAN WARNA] Tombol solid */
            color: var(--card-bg-color);
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
        }
        
        .login-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(255, 107, 107, 0.3);
        }

        .login-button:active {
            transform: translateY(0);
            box-shadow: none;
        }
        
        /* [UX LEBIH BAIK] Loading state yang tidak mengubah ukuran tombol */
        .login-button.loading {
            cursor: not-allowed;
            background-color: #FF8A8A; /* Warna primary yg lebih terang saat loading */
        }
        
        .login-button .button-text {
             transition: opacity 0.3s ease;
        }

        .login-button.loading .button-text {
            opacity: 0;
        }
        
        .login-button .spinner {
            position: absolute;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255, 255, 255, 0.3);
            border-top-color: var(--card-bg-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .login-button.loading .spinner {
            opacity: 1;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }

        /* [PENYESUAIAN WARNA] Pesan error yang konsisten */
        .error-message {
            background-color: rgba(255, 107, 107, 0.1);
            border: 1px solid rgba(255, 107, 107, 0.3);
            color: #D32F2F; /* Merah yg lebih gelap agar terbaca jelas */
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 14px;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 10px;
            animation: shake 0.5s ease;
        }
        
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .forgot-password {
            text-align: center;
            margin-top: 24px;
        }

        .forgot-password a {
            color: var(--primary-color);
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: opacity 0.2s ease;
        }

        .forgot-password a:hover {
            opacity: 0.8;
            text-decoration: underline;
        }

    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="logo">
                <i class="fas fa-store"></i>
            </div>
            <h1 class="brand-title">Selamat Datang Kembali!</h1>
            <p class="brand-subtitle">Masuk untuk mengelola Toko ATK Anda.</p>
        </div>

        <form action="login.jsp" method="post" id="loginForm" class="form-container">
            <div class="input-group">
                <label for="username">Username</label>
                <div class="input-wrapper">
                    <input type="text" id="username" name="username" placeholder="cth: admin.toko" required>
                    <i class="fas fa-user input-icon"></i>
                </div>
            </div>
            
            <div class="input-group">
                <label for="password">Password</label>
                <div class="input-wrapper">
                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                    <i class="fas fa-lock input-icon"></i>
                </div>
            </div>
            
            <button type="submit" class="login-button" id="loginBtn">
                 <span class="button-text">Login</span>
                 <div class="spinner"></div>
            </button>
            
            <%
                // [KONSISTENSI] Menggunakan "errorMessage" sesuai standar awal kita
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null && !errorMessage.isEmpty()) {
            %>
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <span><%= errorMessage %></span>
                </div>
            <%
                }
            %>
        </form>

        <div class="forgot-password">
            <a href="#">Lupa password?</a>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const loginForm = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            
            loginForm.addEventListener('submit', function(e) {
                // Tambah class 'loading' saat form disubmit
                loginBtn.classList.add('loading');
                
                // Menonaktifkan tombol untuk mencegah klik ganda
                loginBtn.disabled = true;

                // (Opsional) Jika ada proses validasi client-side yang lama,
                // baris di atas sudah cukup. Form akan lanjut submit ke server.
            });
            
            // Auto-focus ke field username untuk pengalaman yang lebih cepat
            const usernameInput = document.getElementById('username');
            if(usernameInput) {
                // Diberi sedikit delay agar animasi slide-up selesai dulu
                setTimeout(() => {
                    usernameInput.focus();
                }, 700);
            }
        });
    </script>
</body>
</html>