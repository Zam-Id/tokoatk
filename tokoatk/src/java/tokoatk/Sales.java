/*
 * File: Sales.java (Versi Final & Diperbaiki)
 * Dibuat pada: 28 Juni 2025
 * Author: Zamzam Faqot & Gemini
 */
package tokoatk;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

public class Sales {
    // Properti menggunakan akses public
    public String id;
    public LocalDateTime waktu;
    public String username;
    
    // --- GETTER METHODS ---
    public String getId() { return id; }
    public LocalDateTime getWaktu() { return waktu; }
    public String getUsername() { return username; }

    /**
     * Membaca satu data sales dari database berdasarkan ID.
     * [FIX] Menggunakan try-with-resources untuk manajemen koneksi yang aman.
     * @param id ID sales yang akan dicari.
     * @return true jika data ditemukan, false jika tidak.
     */
    public boolean baca(String id) {
        String sql = "SELECT * FROM salesm WHERE id = ?";
        try (Connection conn = DbConnection.connect();
             PreparedStatement st = conn.prepareStatement(sql)) {
            
            st.setString(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    this.id = rs.getString("id");
                    if (rs.getTimestamp("waktu") != null) {
                        this.waktu = rs.getTimestamp("waktu").toLocalDateTime();
                    }
                    this.username = rs.getString("username");
                    return true;
                } else {
                    return false;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    /**
     * Membuat transaksi sales baru di database.
     * ID transaksi digenerate secara otomatis berdasarkan waktu.
     * [FIX] Menggunakan try-with-resources untuk manajemen koneksi yang aman.
     * @param username Username pengguna yang melakukan transaksi (diambil dari sesi).
     * @return true jika berhasil, false jika gagal.
     */
    public boolean tambah(String username) {
        String sql = "INSERT INTO salesm (id, waktu, username) VALUES (?, ?, ?)";
        try (Connection conn = DbConnection.connect();
             PreparedStatement st = conn.prepareStatement(sql)) {
            
            LocalDateTime dt = LocalDateTime.now();
            this.waktu = dt;
            this.id = dt.format(DateTimeFormatter.ofPattern("yyMMddHHmmssS"));
            this.username = username;

            st.setString(1, this.id);
            st.setTimestamp(2, Timestamp.valueOf(this.waktu));
            st.setString(3, this.username);
            
            st.executeUpdate();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    /**
     * Menghapus data sales beserta semua detailnya dalam satu transaksi.
     * [FIX] Menggunakan transaksi (commit/rollback) untuk menjaga integritas data.
     * Menghapus detail dari 'salesd' terlebih dahulu sebelum master 'salesm'.
     * @return true jika berhasil, false jika ada kegagalan.
     */
    public boolean hapus() {
        Connection conn = null;
        String sqlDetail = "DELETE FROM salesd WHERE salesId = ?";
        String sqlMaster = "DELETE FROM salesm WHERE id = ?";

        try {
            conn = DbConnection.connect();
            // 1. Matikan auto-commit untuk memulai transaksi
            conn.setAutoCommit(false);

            // 2. Hapus semua baris di tabel detail (salesd)
            try (PreparedStatement stDetail = conn.prepareStatement(sqlDetail)) {
                stDetail.setString(1, this.id);
                stDetail.executeUpdate();
            }

            // 3. Hapus baris di tabel master (salesm)
            try (PreparedStatement stMaster = conn.prepareStatement(sqlMaster)) {
                stMaster.setString(1, this.id);
                stMaster.executeUpdate();
            }

            // 4. Jika semua berhasil, simpan perubahan secara permanen
            conn.commit();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            // 5. Jika terjadi error, batalkan semua perubahan
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            return false;
        } finally {
            // 6. Kembalikan mode auto-commit dan tutup koneksi
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    /**
     * Mengambil semua item detail yang dimiliki oleh transaksi ini.
     * @return ArrayList berisi objek SalesDetail.
     */
    public ArrayList<SalesDetail> getDetail() {
        return SalesDetail.getListBySalesId(this.id);
    }
    
    /**
     * Menghitung total harga dari semua item dalam transaksi ini.
     * @return Total harga keseluruhan sebagai integer.
     */
    public int getTotalKeseluruhan() {
        ArrayList<SalesDetail> details = this.getDetail();
        // Menggunakan stream untuk menjumlahkan total dari setiap detail
        return details.stream()
                      .mapToInt(SalesDetail::getTotal)
                      .sum();
    }
    
    /**
     * Method static untuk mengambil semua data sales dari database.
     * Hasil diurutkan berdasarkan waktu terbaru.
     * @return ArrayList berisi objek Sales.
     */
    public static ArrayList<Sales> getList() {
        ArrayList<Sales> result = new ArrayList<>();
        String sql = "SELECT * FROM salesm ORDER BY waktu DESC";

        try (Connection conn = DbConnection.connect();
             PreparedStatement st = conn.prepareStatement(sql);
             ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Sales entry = new Sales();
                entry.id = rs.getString("id");
                if (rs.getTimestamp("waktu") != null) {
                    entry.waktu = rs.getTimestamp("waktu").toLocalDateTime();
                }
                entry.username = rs.getString("username");
                result.add(entry);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}