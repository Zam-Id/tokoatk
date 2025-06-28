<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.SalesDetail"%>
<%@page import="tokoatk.Barang"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Keranjang Belanja</title>
    <style>
        body { font-family: sans-serif; margin: 2em; }
        table { width: 100%; border-collapse: collapse; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .total { font-weight: bold; font-size: 1.2em; margin-top: 1em; }
        .btn { padding: 10px 15px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>🛒 Keranjang Belanja Anda</h1>
    <%
        // Ambil atau buat sesi untuk keranjang
        ArrayList<SalesDetail> keranjang = (ArrayList<SalesDetail>) session.getAttribute("keranjang");
        if (keranjang == null) {
            keranjang = new ArrayList<>();
            session.setAttribute("keranjang", keranjang);
        }

        // Logika untuk menambah barang ke keranjang (dari halaman produk)
        String aksi = request.getParameter("aksi");
        if (aksi != null && aksi.equals("tambah")) {
            try {
                int barangId = Integer.parseInt(request.getParameter("barangId"));
                int qty = Integer.parseInt(request.getParameter("qty"));

                Barang barang = new Barang();
                if (barang.baca(String.valueOf(barangId))) {
                    SalesDetail item = new SalesDetail();
                    item.barangId = barangId;
                    item.namaBarang = barang.getNama();
                    item.harga = barang.getHarga();
                    item.qty = qty;
                    
                    // Cek apakah barang sudah ada di keranjang, jika ya, update qty
                    boolean exists = false;
                    for (SalesDetail d : keranjang) {
                        if (d.getBarangId().equals(barangId)) {
                            d.qty += qty;
                            exists = true;
                            break;
                        }
                    }
                    if (!exists) {
                        keranjang.add(item);
                    }
                }
            } catch (NumberFormatException e) {
                // Abaikan jika parameter tidak valid
            }
        }
    %>

    <% if (keranjang.isEmpty()) { %>
        <p>Keranjang Anda masih kosong.</p>
    <% } else { %>
        <table>
            <tr>
                <th>Nama Barang</th>
                <th>Harga Satuan</th>
                <th>Jumlah</th>
                <th>Subtotal</th>
            </tr>
            <% 
                int totalKeseluruhan = 0;
                for (SalesDetail item : keranjang) {
                    int subtotal = item.getTotal();
                    totalKeseluruhan += subtotal;
            %>
            <tr>
                <td><%= item.getBarangNama() %></td>
                <td>Rp <%= String.format("%,d", item.getHarga()) %></td>
                <td><%= item.getQty() %></td>
                <td>Rp <%= String.format("%,d", subtotal) %></td>
            </tr>
            <% } %>
        </table>
        <div class="total">
            Total Harga: Rp <%= String.format("%,d", totalKeseluruhan) %>
        </div>
        <br>
        <a href="checkout.jsp" class="btn">Lanjutkan ke Checkout &raquo;</a>
    <% } %>
</body>
</html>