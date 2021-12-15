package edu.sau.vys.vys1;

import java.sql.*;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        try
        {   /***** Bağlantı kurulumu *****/
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/YurtDatabase4",
                    "postgres", "");
            if (conn != null)
                System.out.println("Veritabanına bağlandı!");
            else
                System.out.println("Bağlantı girişimi başarısız!");
            String devam = "E";

            char devamMi;
            do{
                Islemler islemler = null;
                System.out.println("Hangi islemi yapmak istiyorsunuz?");
                System.out.println("1-Ogrenci Arama");
                System.out.println("2-Ogrenci Ekleme");
                System.out.println("3-Ogrenci Silme");
                System.out.println("4-Ogrenci Kurs Secimi Guncelleme");
                System.out.println("Islem (1,2,3,4):");
                Scanner scanner = new Scanner(System.in);
                int islem= scanner.nextInt();
                if(islem==1){
                    System.out.println("Aramak istediginiz ogrencinin numarasini giriniz:");
                    String ogrenciNo = scanner.next();
                    islemler.arama(ogrenciNo,conn);
                }else if(islem==2){
                    System.out.println("Eklemek istediginiz ogrencinin numarasini giriniz:");
                    String ogrenciNo = scanner.next();
                    System.out.println("Ogrenci adini giriniz:");
                    String ad = scanner.next();
                    System.out.println("Ogrenci soyadini giriniz:");
                    String soyad = scanner.next();
                    System.out.println("Oda numarasini giriniz:");
                    int odaNo = scanner.nextInt();
                    System.out.println("Kurs numarasini giriniz:");
                    int kursNo = scanner.nextInt();
                    islemler.ekle(ogrenciNo,ad,soyad,odaNo,kursNo,conn);
                }else if(islem==3) {
                    System.out.println("Silmek istediginiz ogrencinin numarasini giriniz:");
                    String ogrenciNo = scanner.next();
                    islemler.sil(ogrenciNo, conn);
                }else if(islem==4) {
                    System.out.println("Kurs bilgisini guncellemek istediginiz ogrencinin numarasini giriniz:");
                    String ogrenciNo = scanner.next();
                    System.out.println("Degistirmek istediginiz kurs numarasini giriniz:");
                    int kursNo = scanner.nextInt();
                    islemler.guncelle(ogrenciNo,kursNo, conn);
                }
                System.out.println("Baska islem yapmak istiyor musunuz? (E/H)");
                devam = scanner.next();
                devamMi = devam.charAt(0);
            }while (devamMi=='E');

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
