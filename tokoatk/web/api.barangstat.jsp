<%-- 
    Document   : api.barangstat
    Created on : 26 Jun 2025, 17.41.09
    Author     : Zamzam Faqot
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="tokoatk.Barang"%>
<%
    ArrayList<Barang> list = Barang.getList();
    
    Integer banyak = list.size();
    Integer total = 0;
    double rata2 = 0.0;
    for(Barang barang : list) {
        total = total + barang.harga;
    }
    rata2 = total/banyak;
    
    out.print("{ \"banyak\": "+banyak+", \"rata2\": "+rata2+" }");    
%>