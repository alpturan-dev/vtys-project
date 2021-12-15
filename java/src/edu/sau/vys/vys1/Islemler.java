package edu.sau.vys.vys1;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Scanner;

public class Islemler {
    static void arama(String ogrenciNo, Connection conn) throws SQLException {
        String sql = "SELECT * FROM ogrenciAra('" + ogrenciNo+ "');";
        /***** Sorgu çalıştırma *****/
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        String ad = null;
        String soyad = null;
        int kursNo = 0;
        int odaNo = 0;
        while(rs.next()){
            ad  = rs.getString("adi");
            soyad = rs.getString("soyadi");
            kursNo  = rs.getInt("kursNo");
            odaNo = rs.getInt("odaNo");
        }

        if(ad==null){
            System.out.println("Bu numaraya sahip ogrenci yok!");
            return;
        }
        /***** Ekrana yazdır *****/
        System.out.print("Ad:"+ ad + " ");
        System.out.print("Soyad:" + soyad + " ");
        System.out.print("Kurs No:"+ kursNo + " ");
        System.out.print("Oda No:" + odaNo + " ");
        System.out.print("Ogrenci No:"+ ogrenciNo + "\n" );
        rs.close();
        stmt.close();
    }
    static void ekle(String ogrenciNo, String ad, String soyad, int odaNo, int kursNo, Connection conn) throws SQLException {
        String sql= "SELECT * FROM ogrenciEkle('" + ogrenciNo+ "','" + ad + "','" + soyad + "','" + odaNo + "','" + kursNo + "');";
        try{
            Statement stmt = conn.createStatement();
            stmt.executeQuery(sql);
            System.out.println(ogrenciNo + " numarali ogrenci eklendi!!");
        }catch(Exception e){
            System.out.println("Hatali veri girisi yaptiniz, tekrar deneyiniz:\n" + e.getMessage() );
        }
    }
    static void sil(String ogrenciNo, Connection conn) throws SQLException {
        String sql = "SELECT * FROM ogrenciSil('" + ogrenciNo+ "');";
        try{
            Statement stmt = conn.createStatement();
            stmt.executeQuery(sql);
            System.out.println(ogrenciNo + " numarali ogrenci silindi!!");
        }catch(Exception e){
            System.out.println("Hatali veri girisi yaptiniz, tekrar deneyiniz:\n" + e.getMessage() );
        }
    }
    static void guncelle(String ogrenciNo,int kursNo, Connection conn) throws SQLException {
        String sql = "SELECT * FROM ogrenciGuncelle('" + ogrenciNo+ "','" + kursNo+ "');";
        try{
            Statement stmt = conn.createStatement();
            stmt.executeQuery(sql);
            System.out.println(ogrenciNo + " numarali ogrencinin kurs bilgisi guncellendi!!");
        }catch(Exception e){
            System.out.println("Hatali veri girisi yaptiniz, tekrar deneyiniz:\n" + e.getMessage() );
        }
    }
}

