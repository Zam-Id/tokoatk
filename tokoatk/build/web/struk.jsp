<%@page import="tokoatk.Sales"%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Struk Pembayaran</title>
    <style>
        body { font-family: 'Courier New', monospace; width: 300px; margin: auto; }
        .header, .footer { text-align: center; }
        .content table { width: 100%; }
        .content th, .content td { padding: 2px 0; }
        .right { text-align: right; }
        .line { border-top: 1px dashed black; margin: 5px 0; }
        @media print {
            body { margin: 0; }
            .no-print { display: none; }
        }
        .btn-print { 
            display: block; width: 100%; padding: 10px; background-color: #4CAF50; 
            color: white; text-align: center; text-decoration: none; 
            border-radius: 5px; margin-top: 20px; border: none; cursor: pointer;
        }
    </style>
</head>
<body>
    <%
        String salesId = request.getParameter("id");
        if (salesId == null) {
            out.println("<p>ID Transaksi tidak ditemukan.</p>");
            return;
        }
        Sales sales = new Sales();
        if (!sales.baca(salesId)) {
            out.println("<p>Transaksi dengan ID " + salesId + " tidak ditemukan.</p>");
            return;
        }
        ArrayList<SalesDetail> details = sales.getDetail();
    %>
    <div class="receipt">
        <div class="header">
            <h3>TOKO ATK SUKSES JAYA</h3>
            <p>Jl. Pembangunan No. 123, Kota Fiktif</p>
        </div>
        <div class="line"></div>
        <div class="info">
            <table>
                <tr>
                    <td>No. Transaksi</td>
                    <td class="right"><%= sales.getId() %></td>
                </tr>
                <tr>
                    <td>Tanggal</td>
                    <td class="right"><%= sales.getWaktu().format(DateTimeFormatter.ofPattern("dd/MM/yy HH:mm")) %></td>
                </tr>
                <tr>
                    <td>Kasir</td>
                    <td class="right"><%= sales.getUsername() %></td>
                </tr>
            </table>
        </div>
        <div class="line"></div>
        <div class="content">
            <table>
            <% for (SalesDetail item : details) { %>
                <tr>
                    <td colspan="2"><%= item.getBarangNama() %></td>
                </tr>
                <tr>
                    <td><%= item.getQty() %> x <%= String.format("%,d", item.getHarga()) %></td>
                    <td class="right">Rp <%= String.format("%,d", item.getTotal()) %></td>
                </tr>
            <% } %>
            </table>
        </div>
        <div class="line"></div>
        <div class="summary">
            <table>
                <tr>
                    <td><strong>TOTAL</strong></td>
                    <td class="right"><strong>Rp <%= String.format("%,d", sales.getTotalKeseluruhan()) %></strong></td>
                </tr>
            </table>
        </div>
        <div class="line"></div>
        <div class="footer">
            <p>Terima Kasih Telah Berbelanja!</p>
        </div>
    </div>
    <button onclick="window.print()" class="btn-print no-print">🖨️ Cetak Struk</button>
</body>
</html>