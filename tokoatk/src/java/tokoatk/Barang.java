/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package tokoatk;

import java.sql.*;
import java.util.ArrayList;

public class Barang {

    public String id;
    public String nama;
    public String jenis;
    public Integer harga;
    public Integer stok;
    
    public boolean baca(String id) {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;

        try {
            conn = DbConnection.connect();

            String sql = "SELECT * from barang where id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);
            rs = st.executeQuery();

            if (rs.next()) {
                this.id = rs.getString("id");
                this.nama = rs.getString("nama");
                this.jenis = rs.getString("jenis");
                this.harga = rs.getInt("harga");
                this.stok = rs.getInt("stok"); // [FIX] Baris ini ditambahkan
                conn.close();
                return true;
            }
            conn.close();
            return false;
        } catch (Exception ex) {
            return false;
        }
    }

    public String getId() {
        return id;
    }

    public String getNama() {
        return nama;
    }

    public String getJenis() {
        return jenis;
    }

    public Integer getHarga() {
        return harga;
    }
    
    public Integer getStok() {
        return stok;
    }

    public boolean update() {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();

            String sql = "UPDATE barang SET nama = ?, harga = ? WHERE id = ?";
            st = conn.prepareStatement(sql);
            
            st.setString(1, this.nama);
            st.setInt(2, this.harga);
            st.setString(3, this.id);

            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean hapus() {
        Connection conn = null;
        PreparedStatement st;
        
        try {
            conn = DbConnection.connect();

            String sql = "DELETE FROM barang where id=?";
            st = conn.prepareStatement(sql);
            st.setString(1, id);

            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    public boolean tambah() {
        Connection conn = null;
        PreparedStatement st;
        try {
            conn = DbConnection.connect();
            // [FIX] Menambahkan kolom 'stok' ke dalam query
            String sql = "INSERT INTO barang (nama, jenis, harga, stok) VALUES (?, ?, ?, ?)";
            st = conn.prepareStatement(sql);
            st.setString(1, this.nama);
            st.setString(2, this.jenis);
            st.setInt(3, this.harga);
            st.setInt(4, this.stok); // [FIX] Menambahkan nilai untuk stok
            st.executeUpdate();
            conn.close();
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
    
    public static ArrayList<Barang> getList() {
        Connection conn = null;
        PreparedStatement st;
        ResultSet rs;
        ArrayList<Barang> result = new ArrayList<Barang>();

        try {
            conn = DbConnection.connect();

            String sql = "SELECT * from barang";
            st = conn.prepareStatement(sql);
            rs = st.executeQuery();

            while(rs.next()) {
                Barang entry = new Barang();
                entry.baca(rs.getString("id"));
                result.add(entry);
            }
            conn.close();
            return result;
        } catch (Exception ex) {
            return null;
        }
    }
}