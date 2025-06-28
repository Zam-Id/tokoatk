/*
 * File: SalesDetail.java (Versi Final & Diperbaiki)
 * Dibuat pada: 28 Juni 2025
 * Author: Zamzam Faqot & Gemini
 */
package tokoatk;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class SalesDetail {
    // Properti Class
    public Integer id;
    public String salesId;
    // [FIX] Ubah tipe data barangId dari String ke Integer agar sesuai dengan database
    public Integer barangId; 
    public Integer qty;
    public Integer harga;
    public String namaBarang;

    // --- GETTER METHODS ---

    public Integer getId() {
        return id;
    }

    // [FIX] Sesuaikan tipe data return method ini
    public Integer getBarangId() {
        return barangId;
    }

    public Integer getQty() {
        return qty;
    }

    public Integer getHarga() {
        return harga;
    }

    public String getBarangNama() {
        return namaBarang;
    }

    public Integer getTotal() {
        return (harga != null && qty != null) ? harga * qty : 0;
    }

    // --- DATABASE METHODS ---

    public boolean tambah() {
        Connection conn = null;
        PreparedStatement insertSt = null;
        PreparedStatement updateStokSt = null;
        
        String insertSql = "INSERT INTO salesd (salesId, barangId, qty, harga) VALUES (?, ?, ?, (SELECT harga FROM barang WHERE id = ?))";
        String updateStokSql = "UPDATE barang SET stok = stok - ? WHERE id = ?";

        try {
            conn = DbConnection.connect();
            conn.setAutoCommit(false);

            insertSt = conn.prepareStatement(insertSql);
            insertSt.setString(1, this.salesId);
            // [FIX] Gunakan setInt untuk kolom barangId
            insertSt.setInt(2, this.barangId); 
            insertSt.setInt(3, this.qty);
            // [FIX] Gunakan setInt untuk parameter subquery
            insertSt.setInt(4, this.barangId); 
            insertSt.executeUpdate();

            updateStokSt = conn.prepareStatement(updateStokSql);
            updateStokSt.setInt(1, this.qty);
            // [FIX] Gunakan setInt untuk kondisi WHERE
            updateStokSt.setInt(2, this.barangId); 
            updateStokSt.executeUpdate();

            conn.commit();
            return true;

        } catch (SQLException ex) {
            ex.printStackTrace();
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            return false;

        } finally {
            try {
                if (insertSt != null) insertSt.close();
                if (updateStokSt != null) updateStokSt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
    public static ArrayList<SalesDetail> getListBySalesId(String salesId) {
        ArrayList<SalesDetail> result = new ArrayList<>();
        String sql = "SELECT sd.*, b.nama AS nama_barang " +
                     "FROM salesd sd " +
                     "JOIN barang b ON sd.barangId = b.id " +
                     "WHERE sd.salesId = ?";
        
        try (Connection conn = DbConnection.connect();
             PreparedStatement st = conn.prepareStatement(sql)) {
            
            st.setString(1, salesId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    SalesDetail detail = new SalesDetail();
                    detail.id = rs.getInt("id");
                    detail.salesId = rs.getString("salesId");
                    // [FIX] Gunakan getInt untuk mengambil data barangId
                    detail.barangId = rs.getInt("barangId"); 
                    detail.qty = rs.getInt("qty");
                    detail.harga = rs.getInt("harga");
                    detail.namaBarang = rs.getString("nama_barang");
                    result.add(detail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }
}