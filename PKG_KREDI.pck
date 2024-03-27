CREATE OR REPLACE PACKAGE BNSPR.Pkg_Kredi IS
FUNCTION modul_tur_kod RETURN VARCHAR2;
FUNCTION tahakkuk RETURN VARCHAR2 ;
--
  FUNCTION kredi_hesap_ac( ps_modul_tur VARCHAR2, ps_urun_tur VARCHAR2, ps_urun_sinif VARCHAR2,
                            pn_musteri_no NUMBER, ps_doviz VARCHAR2, ps_sube VARCHAR2, pd_vade DATE,
                            ps_referans VARCHAR2,
                            p_faiz_tahakkuk_hesap_no  MUH_HESAP_KREDI.faiz_tahakkuk_hesap_no%TYPE DEFAULT NULL,
                            p_musteri_dk_no      MUH_HESAP_KREDI.MUSTERI_DK_NO%TYPE DEFAULT NULL, --DK no
                            p_tutar  MUH_HESAP_KREDI.tutar%TYPE DEFAULT 0,
                            p_extre_masrafi  MUH_HESAP_KREDI.extre_masrafi%TYPE DEFAULT 'H',
                            p_iliskili_hesap_no  MUH_HESAP_KREDI.iliskili_hesap_no%TYPE DEFAULT NULL,
                            p_kredi_teklif_satir_numara  MUH_HESAP_KREDI.kredi_teklif_satir_numara%TYPE DEFAULT NULL,
                            p_kredi_kullandirim_kodu  MUH_HESAP_KREDI.kredi_kullandirim_kodu%TYPE DEFAULT NULL,
                            p_endeks_doviz_kodu  MUH_HESAP_KREDI.endeks_doviz_kodu%TYPE DEFAULT NULL,
                            p_kullandirim_doviz_kodu  MUH_HESAP_KREDI.kullandirim_doviz_kodu%TYPE DEFAULT NULL,
                            p_son_gun_faizi  MUH_HESAP_KREDI.son_gun_faizi%TYPE DEFAULT NULL,
                            p_acilis_kuru  MUH_HESAP_KREDI.acilis_kuru%TYPE DEFAULT NULL,
                            p_faiz_orani  MUH_HESAP_KREDI.faiz_orani%TYPE DEFAULT NULL,
                            p_faiz_siklik  MUH_HESAP_KREDI.faiz_siklik%TYPE DEFAULT NULL,
                            p_faiz_siklik_tipi  MUH_HESAP_KREDI.faiz_siklik_tipi%TYPE DEFAULT NULL,
                            p_faiz_tahakkuk_tarihi  MUH_HESAP_KREDI.faiz_tahakkuk_tarihi%TYPE DEFAULT NULL,
                            p_komisyon_orani  MUH_HESAP_KREDI.komisyon_orani%TYPE DEFAULT NULL,
                            p_komisyon_tutari  MUH_HESAP_KREDI.komisyon_tutari%TYPE DEFAULT NULL,
                            p_komisyon_tahsilat_donemi  MUH_HESAP_KREDI.komisyon_tahsilat_donemi%TYPE DEFAULT NULL,
                            pn_kkdf_orani  MUH_HESAP_KREDI.kkdf_orani%TYPE DEFAULT NULL,
                            p_bsmv_orani  MUH_HESAP_KREDI.bsmv_orani%TYPE DEFAULT NULL,
                            p_alacak_hesap_no  MUH_HESAP_KREDI.alacak_hesap_no%TYPE DEFAULT NULL,
                            p_kur_farki  MUH_HESAP_KREDI.kur_farki%TYPE DEFAULT NULL,
                            p_sinirlama_kodu  MUH_HESAP_KREDI.sinirlama_kodu%TYPE DEFAULT NULL,
                            p_kaynak_kodu  MUH_HESAP_KREDI.kaynak_kodu%TYPE DEFAULT NULL,
                            p_istatistik_kodu  MUH_HESAP_KREDI.istatistik_kodu%TYPE DEFAULT NULL,
                            p_urun_grup_no  MUH_HESAP_KREDI.urun_grup_no%TYPE DEFAULT NULL,
                            pn_kom_tahakkuk_hesap_no  MUH_HESAP_KREDI.kom_tahakkuk_hesap_no%TYPE DEFAULT NULL,
                            p_birikmis_faiz_tutari  MUH_HESAP_KREDI.birikmis_faiz_tutari%TYPE DEFAULT 0,
                            p_birikmis_komisyon_tutari  MUH_HESAP_KREDI.birikmis_komisyon_tutari%TYPE DEFAULT 0 ,
                            p_esas_gun_sayisi       MUH_HESAP_KREDI.ESAS_GUN_SAYISI%TYPE DEFAULT 360,
                            p_acilis_tarihi  MUH_HESAP_KREDI.acilis_tarihi%TYPE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                            p_endeks_doviz_tutari NUMBER DEFAULT 0,
                            p_sch_faiz_orani NUMBER DEFAULT 0,
                            p_sch_faiz_orani_marjsiz     NUMBER DEFAULT 0,
                            p_odeme_turu    VARCHAR2 DEFAULT NULL,
                            p_taksit_sayisi    NUMBER DEFAULT NULL,
                            p_taksit_once_sonra  VARCHAR2 DEFAULT NULL,
                            p_artis_siklik    NUMBER DEFAULT NULL,
                            p_artis_oran    NUMBER DEFAULT NULL,
                            p_ara_odeme_siklik  NUMBER DEFAULT NULL,
                            p_ara_odeme_tutar    NUMBER DEFAULT NULL,
                            p_donem_siklik    NUMBER DEFAULT NULL,
                            p_sch_faiz_tur VARCHAR2 DEFAULT 'S',
                            p_tahakkuk_sch_faiz_tutari NUMBER DEFAULT 0,
                            p_temdit_tarihi         DATE DEFAULT NULL,
                            p_repayment_type       MUH_HESAP_KREDI.repayment_type%TYPE DEFAULT NULL,
                            p_kkdf_alinsin         VARCHAR2 DEFAULT 'E',
                            p_bsmv_alinsin         VARCHAR2 DEFAULT 'E',
                            p_taahhut_vadesi       DATE DEFAULT NULL,
                            p_belge_no           VARCHAR2 DEFAULT NULL,
                            p_belge_kodu         VARCHAR2 DEFAULT NULL,
                            p_belge_tarihi         DATE DEFAULT NULL,
                            p_basvuru_no          NUMBER DEFAULT NULL,
                            p_yakin_izleme         VARCHAR2 DEFAULT 'H'  ,
                            p_faiz_endeks_turu  MUH_HESAP_KREDI.faiz_endeks_turu%TYPE DEFAULT NULL,
                            p_faiz_endeks_kodu  MUH_HESAP_KREDI.faiz_endeks_kodu%TYPE DEFAULT NULL,
                            p_faiz_endeks_period      MUH_HESAP_KREDI.faiz_endeks_period%TYPE DEFAULT NULL,
                            p_endeks_faiz_orani          MUH_HESAP_KREDI.endeks_faiz_orani%TYPE DEFAULT NULL,
                            p_spread_tipi             MUH_HESAP_KREDI.spread_tipi  %TYPE DEFAULT NULL,
                            p_spread_orani              MUH_HESAP_KREDI.spread_orani%TYPE DEFAULT NULL,
                            p_faiz_degisim_siklik             MUH_HESAP_KREDI.faiz_degisim_siklik  %TYPE DEFAULT NULL,
                            p_faiz_degisim_siklik_tipi              MUH_HESAP_KREDI.faiz_degisim_siklik_tipi%TYPE DEFAULT NULL,
                            p_faiz_degisim_tarihi       MUH_HESAP_KREDI.faiz_degisim_tarihi%TYPE DEFAULT NULL,
                            p_min_faiz_orani       MUH_HESAP_KREDI.min_faiz_orani%TYPE DEFAULT NULL,
                            p_talep_no               MUH_HESAP_KREDI.talep_no%TYPE DEFAULT NULL,
                            p_belgelimi              VARCHAR2 DEFAULT NULL,
                            p_faiz_tipi              VARCHAR2 DEFAULT NULL,
                            p_endeks_tarihi            DATE DEFAULT NULL,
                            p_faiz_degisecekmi          VARCHAR2 DEFAULT NULL,
                            pn_wbekno                    MUH_HESAP_KREDI.Wb_Ekno%TYPE DEFAULT NULL,
                            pn_pesin_faiz_orani          NUMBER DEFAULT NULL,
                            pn_temlik_musteri            NUMBER DEFAULT NULL,
                            pn_pesin_faiz_tutari         NUMBER DEFAULT NULL,
                            pd_ortalama_vade             DATE DEFAULT NULL,
                            pd_taksit_baslangic_tarihi   DATE DEFAULT NULL,
                            pc_sigorta_sirketi           VARCHAR2 DEFAULT NULL,
                            pc_ekstre_basilsin           VARCHAR2 DEFAULT 'E',
                            pn_alacak_yp_hesap_no        NUMBER DEFAULT NULL,
                            pn_erken_kapama_faiz_tutari  NUMBER DEFAULT NULL,
                            pn_erken_kapama_faiz_orani  NUMBER DEFAULT NULL,
                            pn_islem_kanal   NUMBER DEFAULT NULL,
                            pn_sporlu   NUMBER DEFAULT 0,
                            pn_DEK_LEASING NUMBER DEFAULT 0,
                            pn_MAL_BEDELI NUMBER DEFAULT NULL,
                            pn_KDV_ORAN NUMBER DEFAULT NULL,
                            pn_KIRACIYA_SATIS_BEDELI NUMBER DEFAULT NULL,
                            pd_SATIS_VADESI DATE DEFAULT NULL,
                            pn_ODEMESIZ_SURE_DONEM NUMBER DEFAULT NULL,
                            pn_ODEME_PERIYODU NUMBER DEFAULT NULL,
                            pn_PESIN_TAKSIT_TUTARI NUMBER DEFAULT NULL,
                            pn_SATICI_HESAP_NO NUMBER DEFAULT NULL,
                            pn_DEK_URUN_NO NUMBER DEFAULT NULL
                            ) RETURN NUMBER;
-----------------------------------------------------------------------------------------------------
 FUNCTION bir_kredi_hesap_ac( ps_modul_tur VARCHAR2, ps_urun_tur VARCHAR2, ps_urun_sinif VARCHAR2,
                              pn_musteri_no NUMBER, ps_doviz VARCHAR2, ps_sube VARCHAR2,
                              pd_vade DATE,  ps_referans VARCHAR2,
                              p_musteri_dk_no MUH_HESAP_KREDI.MUSTERI_DK_NO%TYPE DEFAULT NULL,
                              p_tutar MUH_HESAP_KREDI.tutar%TYPE DEFAULT 0,
                              p_extre_masrafi  MUH_HESAP_KREDI.extre_masrafi%TYPE DEFAULT 'H',
                              p_iliskili_hesap_no  MUH_HESAP_KREDI.iliskili_hesap_no%TYPE DEFAULT NULL,
                              p_endeks_doviz_kodu  MUH_HESAP_KREDI.endeks_doviz_kodu%TYPE DEFAULT NULL,
                              p_kullandirim_doviz_kodu  MUH_HESAP_KREDI.kullandirim_doviz_kodu%TYPE DEFAULT NULL,
                              p_acilis_kuru  MUH_HESAP_KREDI.acilis_kuru%TYPE DEFAULT NULL,
                              p_faiz_orani  MUH_HESAP_KREDI.faiz_orani%TYPE DEFAULT NULL,
                              pn_kkdf_orani  MUH_HESAP_KREDI.kkdf_orani%TYPE DEFAULT NULL,
                              p_bsmv_orani  MUH_HESAP_KREDI.bsmv_orani%TYPE DEFAULT NULL,
                              p_alacak_hesap_no  MUH_HESAP_KREDI.alacak_hesap_no%TYPE DEFAULT NULL,
                              p_kur_farki  MUH_HESAP_KREDI.kur_farki%TYPE DEFAULT NULL,
                              p_sinirlama_kodu  MUH_HESAP_KREDI.sinirlama_kodu%TYPE DEFAULT NULL,
                              p_urun_grup_no  MUH_HESAP_KREDI.urun_grup_no%TYPE DEFAULT NULL,
                              p_birikmis_faiz_tutari  MUH_HESAP_KREDI.birikmis_faiz_tutari%TYPE DEFAULT 0,
                              p_acilis_tarihi  MUH_HESAP_KREDI.acilis_tarihi%TYPE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                              p_endeks_doviz_tutari NUMBER DEFAULT 0,
                              p_sch_faiz_orani NUMBER DEFAULT 0,
                              p_odeme_turu    VARCHAR2 DEFAULT NULL,
                              p_taksit_sayisi    NUMBER DEFAULT NULL,
                              p_taksit_once_sonra  VARCHAR2 DEFAULT NULL,
                              p_artis_siklik    NUMBER DEFAULT NULL,
                              p_artis_oran    NUMBER DEFAULT NULL,
                              p_ara_odeme_siklik  NUMBER DEFAULT NULL,
                              p_ara_odeme_tutar    NUMBER DEFAULT NULL,
                              p_donem_siklik    NUMBER DEFAULT NULL,
                              p_sch_faiz_tur VARCHAR2 DEFAULT  'S',
                              p_tahakkuk_sch_faiz_tutari NUMBER DEFAULT 0,
                              p_temdit_tarihi         DATE DEFAULT NULL,
                              p_repayment_type       MUH_HESAP_KREDI.repayment_type%TYPE DEFAULT NULL,
                              p_kkdf_alinsin         VARCHAR2 DEFAULT 'E',
                              p_bsmv_alinsin         VARCHAR2 DEFAULT 'E',
                              p_basvuru_no          NUMBER DEFAULT NULL,
                              p_yakin_izleme         VARCHAR2 DEFAULT 'H'  ,
                              p_faiz_endeks_turu  MUH_HESAP_KREDI.faiz_endeks_turu%TYPE DEFAULT NULL,
                              p_faiz_endeks_kodu  MUH_HESAP_KREDI.faiz_endeks_kodu%TYPE DEFAULT NULL,
                              p_faiz_endeks_period      MUH_HESAP_KREDI.faiz_endeks_period%TYPE DEFAULT NULL,
                              p_endeks_faiz_orani          MUH_HESAP_KREDI.endeks_faiz_orani%TYPE DEFAULT NULL,
                              p_spread_tipi             MUH_HESAP_KREDI.spread_tipi  %TYPE DEFAULT NULL,
                              p_spread_orani              MUH_HESAP_KREDI.spread_orani%TYPE DEFAULT NULL,
                              p_faiz_degisim_siklik  MUH_HESAP_KREDI.faiz_degisim_siklik%TYPE DEFAULT NULL,
                              p_faiz_degisim_siklik_tipi  MUH_HESAP_KREDI.faiz_degisim_siklik_tipi%TYPE DEFAULT NULL,
                              p_faiz_degisim_tarihi       MUH_HESAP_KREDI.faiz_degisim_tarihi%TYPE DEFAULT NULL,
                              p_min_faiz_orani  MUH_HESAP_KREDI.min_faiz_orani%TYPE DEFAULT NULL,
                              p_talep_no               MUH_HESAP_KREDI.talep_no%TYPE DEFAULT NULL,
                              p_belgelimi              VARCHAR2 DEFAULT NULL,
                              p_krd_tur_kod             NUMBER,
                              p_krd_alt_tur_kod             NUMBER,
                              p_krd_alt_tur_kod2             NUMBER,
                              p_faiz_tipi              VARCHAR2 DEFAULT NULL,
                              p_endeks_tarihi            DATE DEFAULT NULL,
                              p_faiz_degisecekmi          VARCHAR2 DEFAULT NULL,
                              p_kanal_kodu    MUH_HESAP_KREDI.Kanal_Kod%TYPE DEFAULT NULL
                             ) RETURN NUMBER;
-------------------------------------------------------------------------------------------------------------------
FUNCTION KrediHesap_UrunUygunmu( pc_urun_tur_kod MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                                 pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE DEFAULT NULL)
                                   RETURN VARCHAR2;
--
FUNCTION Komite_adi_al(pn_komitekod KRE_KOMITE_KOD_PR.KOD%TYPE) RETURN KRE_KOMITE_KOD_PR.ACIKLAMA%TYPE;
--
FUNCTION DK_MevcutMu(pc_subekod VARCHAR2, pc_dk VARCHAR2, pc_dov VARCHAR2 ) RETURN VARCHAR2;
--
PROCEDURE DK_MevcutMu_Kont(pc_subekod VARCHAR2, pc_dk VARCHAR2, pc_dov VARCHAR2 );
--
PROCEDURE tahakkuk_dk_tanimlimi(pc_sube_kodu  MUH_HESAP_KREDI.sube_kodu%TYPE,
                                pc_doviz_kodu MUH_HESAP_KREDI.doviz_kodu%TYPE,
                                pc_faiz_dk  OUT MUH_HP_BAKIYE.Hesap_No%TYPE,
                                pc_vergi_dk OUT MUH_HP_BAKIYE.Hesap_No%TYPE);
--
PROCEDURE faizkom_dk_tanimlimi(pn_txno NUMBER);
--
PROCEDURE MUH_HESAP_KREDI_INSERT(pn_txno Muh_Hesap_Kredi_Tx.Tx_No%TYPE);

FUNCTION hesap_ac(pn_txno NUMBER) RETURN NUMBER;

PROCEDURE faiz_kom_hesap_ac (pn_hesap_no NUMBER);

FUNCTION FaizTahakkukTarihi_Bul
( pc_faizsiklikTipi                 VARCHAR2,
  pn_faizsiklik                     NUMBER,
  pd_tarih                          DATE ,   -- Acilisda kredi acilis tarihi, digerlerinde son tahakkuk tarihidir
  pn_secim                          NUMBER ) -- 1:Acilis , 2:Tahakkuk
RETURN DATE ;

FUNCTION FaizDegisimTarihi_Bul
( pc_faizDegisimSiklikTipi                 VARCHAR2,
  pn_faizDegisimSiklik                     NUMBER,
  pd_tarih                          DATE ,   -- Acilisda kredi acilis tarihi, digerlerinde son tahakkuk tarihidir
  pn_secim                          NUMBER ) -- 1:Acilis , 2:Tahakkuk
RETURN DATE ;

PROCEDURE hesap_kapa(pn_hesapNo NUMBER);

PROCEDURE krediHesapTarihGuncelle(pn_hesapNo NUMBER, pd_date DATE);

PROCEDURE kreHesapAcilisTutarGuncelleme(pn_hesapNo NUMBER, pn_tutar NUMBER, pd_vade DATE);

--PROCEDURE TekKrediTahakkuk(pn_hesapno NUMBER );

FUNCTION Get_Brk_Faiz_Valorlu(pn_hesapno   NUMBER, pn_gunsayisi NUMBER, pc_tip       VARCHAR2)--(F(faiz), K (kom), T(tem))
  RETURN NUMBER;

PROCEDURE hesap_tutar_guncelle (pn_hesapNo NUMBER , pn_tutar NUMBER ) ;

FUNCTION TemerrutOranKatSayi ( pn_krdturkod NUMBER) RETURN NUMBER;

FUNCTION Gunluk_Valor_Bakiye_Fark(pn_hesapNo NUMBER) RETURN NUMBER;

FUNCTION hesap_tutar_al(pn_hesapNo NUMBER ) RETURN NUMBER;

FUNCTION Factoring_KrediMi( pc_urun_tur_kod MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                            pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE ) RETURN VARCHAR2;


-----------------------------------------------------------------------------------
FUNCTION Ihracat_KrediMi( pc_urun_tur_kod   MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                            pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE ) RETURN VARCHAR2;

--p_hangi_devre: 0 ise i��inde bulunulan devre
--             (-1) ise ��nceki devre  , (1) ise sonraki devre
-- (n) , (-n) seklinde b��y��k degerler de girilebilir.
FUNCTION devre_baslangic_tarihi(p_hangi_devre NUMBER DEFAULT 0) RETURN DATE;
FUNCTION devre_bitis_tarihi(p_hangi_devre NUMBER DEFAULT 0) RETURN DATE;
-----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
PROCEDURE GeriValorluOranDegisiklik( pn_hesapno NUMBER, pn_yeniOranF NUMBER,pn_yeniOranK NUMBER, pd_valor DATE, pc_faizKom VARCHAR2 DEFAULT 'F',
                                     pn_birikmisFaiz OUT NUMBER,pn_birikmisKom OUT NUMBER) ;

PROCEDURE GeriValorluOranDegisiklik_Upd( pn_hesapno NUMBER, pn_yeniOran NUMBER, pd_valor DATE, pc_faizKom VARCHAR2 DEFAULT 'F',
                                            pn_birikmis OUT NUMBER);

PROCEDURE tahakkuk_urun_sinif_getir(pc_urun_tur VARCHAR2,
                                    pc_urun_sinif VARCHAR2,
                                    pc_alt_urun_tur OUT VARCHAR2,
                                    pc_urun_sinif_faiz OUT VARCHAR2,
                                    pc_urun_sinif_kom OUT VARCHAR2);
FUNCTION Get_Brk_Faiz_Kom(pn_hesapno NUMBER, pn_anapara NUMBER, pn_gunsayisi NUMBER, pc_tip VARCHAR2) RETURN NUMBER;

FUNCTION pesin_faiz_tutar_hesapla(pn_tutar NUMBER, pn_faiz_orani NUMBER, pn_gun_sayisi NUMBER) RETURN NUMBER;
FUNCTION get_iskonto_urun_grup RETURN NUMBER;
FUNCTION get_faktoring_urun_grup RETURN NUMBER;
PROCEDURE update_sonTXNO(pn_txno NUMBER, pn_hesap_no NUMBER);
PROCEDURE hesap_acilis_gusin_kontrol(pn_grup_kod NUMBER,pc_modul_tur_kod VARCHAR2,
                                     pc_urun_tur_kod VARCHAR2, pc_urun_sinif_kod VARCHAR2);
FUNCTION get_faiz_tahakkuk_tarihi(pn_hesap_no NUMBER) RETURN DATE;
FUNCTION vadeli_mustakriz_kontrol(pn_musteri_no NUMBER) RETURN NUMBER;
FUNCTION vadeli_mustakriz_kontrol(pn_musteri_no NUMBER, pn_anapara_tutar NUMBER, pc_doviz VARCHAR2,
                                  pn_txno NUMBER) RETURN NUMBER;
FUNCTION get_kullanim_thslt_bildirim(pn_musteri_no NUMBER, pn_hesap_no NUMBER,pn_dilim_no NUMBER, pn_sira_no NUMBER) RETURN VARCHAR2;
END;
/
CREATE OR REPLACE PACKAGE BODY BNSPR.Pkg_Kredi IS

FUNCTION modul_tur_kod RETURN VARCHAR2 IS
BEGIN
  RETURN 'KREDI';
END;
FUNCTION tahakkuk RETURN VARCHAR2 IS
BEGIN
  RETURN 'TAHAKKUK';
END;
--asli
  FUNCTION kredi_hesap_ac(  ps_modul_tur                 VARCHAR2,
                            ps_urun_tur                  VARCHAR2,
                            ps_urun_sinif                VARCHAR2,
                            pn_musteri_no                NUMBER,
                            ps_doviz                     VARCHAR2,
                            ps_sube                      VARCHAR2,
                            pd_vade                      DATE,
                            ps_referans                  VARCHAR2,
                            p_faiz_tahakkuk_hesap_no     MUH_HESAP_KREDI.faiz_tahakkuk_hesap_no%TYPE DEFAULT NULL,
                            p_musteri_dk_no               MUH_HESAP_KREDI.MUSTERI_DK_NO%TYPE DEFAULT NULL, --DK no
                            p_tutar                       MUH_HESAP_KREDI.tutar%TYPE DEFAULT 0,
                            p_extre_masrafi               MUH_HESAP_KREDI.extre_masrafi%TYPE DEFAULT 'H',
                            p_iliskili_hesap_no           MUH_HESAP_KREDI.iliskili_hesap_no%TYPE DEFAULT NULL,
                            p_kredi_teklif_satir_numara   MUH_HESAP_KREDI.kredi_teklif_satir_numara%TYPE DEFAULT NULL,
                            p_kredi_kullandirim_kodu     MUH_HESAP_KREDI.kredi_kullandirim_kodu%TYPE DEFAULT NULL,
                            p_endeks_doviz_kodu           MUH_HESAP_KREDI.endeks_doviz_kodu%TYPE DEFAULT NULL,
                            p_kullandirim_doviz_kodu     MUH_HESAP_KREDI.kullandirim_doviz_kodu%TYPE DEFAULT NULL,
                            p_son_gun_faizi               MUH_HESAP_KREDI.son_gun_faizi%TYPE DEFAULT NULL,
                            p_acilis_kuru                 MUH_HESAP_KREDI.acilis_kuru%TYPE DEFAULT NULL,
                            p_faiz_orani                 MUH_HESAP_KREDI.faiz_orani%TYPE DEFAULT NULL,
                            p_faiz_siklik                 MUH_HESAP_KREDI.faiz_siklik%TYPE DEFAULT NULL,
                            p_faiz_siklik_tipi           MUH_HESAP_KREDI.faiz_siklik_tipi%TYPE DEFAULT NULL,
                            p_faiz_tahakkuk_tarihi       MUH_HESAP_KREDI.faiz_tahakkuk_tarihi%TYPE DEFAULT NULL,
                            p_komisyon_orani             MUH_HESAP_KREDI.komisyon_orani%TYPE DEFAULT NULL,
                            p_komisyon_tutari             MUH_HESAP_KREDI.komisyon_tutari%TYPE DEFAULT NULL,
                            p_komisyon_tahsilat_donemi   MUH_HESAP_KREDI.komisyon_tahsilat_donemi%TYPE DEFAULT NULL,
                            pn_kkdf_orani                 MUH_HESAP_KREDI.kkdf_orani%TYPE DEFAULT NULL,
                            p_bsmv_orani                 MUH_HESAP_KREDI.bsmv_orani%TYPE DEFAULT NULL,
                            p_alacak_hesap_no             MUH_HESAP_KREDI.alacak_hesap_no%TYPE DEFAULT NULL,
                            p_kur_farki                   MUH_HESAP_KREDI.kur_farki%TYPE DEFAULT NULL,
                            p_sinirlama_kodu             MUH_HESAP_KREDI.sinirlama_kodu%TYPE DEFAULT NULL,
                            p_kaynak_kodu                 MUH_HESAP_KREDI.kaynak_kodu%TYPE DEFAULT NULL,
                            p_istatistik_kodu             MUH_HESAP_KREDI.istatistik_kodu%TYPE DEFAULT NULL,
                            p_urun_grup_no               MUH_HESAP_KREDI.urun_grup_no%TYPE DEFAULT NULL,
                            pn_kom_tahakkuk_hesap_no     MUH_HESAP_KREDI.kom_tahakkuk_hesap_no%TYPE DEFAULT NULL,
                            p_birikmis_faiz_tutari       MUH_HESAP_KREDI.birikmis_faiz_tutari%TYPE DEFAULT 0,
                            p_birikmis_komisyon_tutari   MUH_HESAP_KREDI.birikmis_komisyon_tutari%TYPE DEFAULT 0 ,
                            p_esas_gun_sayisi             MUH_HESAP_KREDI.ESAS_GUN_SAYISI%TYPE DEFAULT 360,
                            p_acilis_tarihi               MUH_HESAP_KREDI.acilis_tarihi%TYPE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                            p_endeks_doviz_tutari        NUMBER DEFAULT 0,
                            p_sch_faiz_orani             NUMBER DEFAULT 0,
                            p_sch_faiz_orani_marjsiz     NUMBER DEFAULT 0,
                            p_odeme_turu                 VARCHAR2 DEFAULT NULL,
                            p_taksit_sayisi               NUMBER DEFAULT NULL,
                            p_taksit_once_sonra           VARCHAR2 DEFAULT NULL,
                            p_artis_siklik               NUMBER DEFAULT NULL,
                            p_artis_oran                 NUMBER DEFAULT NULL,
                            p_ara_odeme_siklik           NUMBER DEFAULT NULL,
                            p_ara_odeme_tutar             NUMBER DEFAULT NULL,
                            p_donem_siklik               NUMBER DEFAULT NULL,
                            p_sch_faiz_tur               VARCHAR2 DEFAULT 'S',
                            p_tahakkuk_sch_faiz_tutari   NUMBER DEFAULT 0,
                            p_temdit_tarihi               DATE DEFAULT NULL,
                            p_repayment_type             MUH_HESAP_KREDI.repayment_type%TYPE DEFAULT NULL,
                            p_kkdf_alinsin               VARCHAR2 DEFAULT 'E',
                            p_bsmv_alinsin               VARCHAR2 DEFAULT 'E',
                            p_taahhut_vadesi             DATE DEFAULT NULL,
                            p_belge_no                   VARCHAR2 DEFAULT NULL,
                            p_belge_kodu                 VARCHAR2 DEFAULT NULL,
                            p_belge_tarihi               DATE DEFAULT NULL,
                            p_basvuru_no                  NUMBER DEFAULT NULL,
                            p_yakin_izleme               VARCHAR2 DEFAULT 'H'  ,
                            p_faiz_endeks_turu           MUH_HESAP_KREDI.faiz_endeks_turu%TYPE DEFAULT NULL,
                            p_faiz_endeks_kodu           MUH_HESAP_KREDI.faiz_endeks_kodu%TYPE DEFAULT NULL,
                            p_faiz_endeks_period         MUH_HESAP_KREDI.faiz_endeks_period%TYPE DEFAULT NULL,
                            p_endeks_faiz_orani           MUH_HESAP_KREDI.endeks_faiz_orani%TYPE DEFAULT NULL,
                            p_spread_tipi                 MUH_HESAP_KREDI.spread_tipi  %TYPE DEFAULT NULL,
                            p_spread_orani               MUH_HESAP_KREDI.spread_orani%TYPE DEFAULT NULL,
                            p_faiz_degisim_siklik           MUH_HESAP_KREDI.faiz_degisim_siklik%TYPE DEFAULT NULL,
                            p_faiz_degisim_siklik_tipi           MUH_HESAP_KREDI.faiz_degisim_siklik_tipi%TYPE DEFAULT NULL,
                            p_faiz_degisim_tarihi         MUH_HESAP_KREDI.faiz_degisim_tarihi%TYPE DEFAULT NULL,
                            p_min_faiz_orani           MUH_HESAP_KREDI.min_faiz_orani%TYPE DEFAULT NULL,
                            p_talep_no                   MUH_HESAP_KREDI.talep_no%TYPE DEFAULT NULL,
                            p_belgelimi                   VARCHAR2 DEFAULT NULL,
                            p_faiz_tipi                   VARCHAR2 DEFAULT NULL,
                            p_endeks_tarihi               DATE DEFAULT NULL,
                            p_faiz_degisecekmi           VARCHAR2 DEFAULT NULL,
                            pn_wbekno                    MUH_HESAP_KREDI.Wb_Ekno%TYPE DEFAULT NULL,
                            pn_pesin_faiz_orani          NUMBER DEFAULT NULL,
                            pn_temlik_musteri            NUMBER DEFAULT NULL,
                            pn_pesin_faiz_tutari         NUMBER DEFAULT NULL,
                            pd_ortalama_vade             DATE DEFAULT NULL,
                            pd_taksit_baslangic_tarihi   DATE DEFAULT NULL,
                            pc_sigorta_sirketi           VARCHAR2 DEFAULT NULL,
                            pc_ekstre_basilsin           VARCHAR2 DEFAULT 'E',
                            pn_alacak_yp_hesap_no        NUMBER DEFAULT NULL,
                            pn_erken_kapama_faiz_tutari  NUMBER DEFAULT NULL,
                            pn_erken_kapama_faiz_orani   NUMBER DEFAULT NULL,
                            pn_islem_kanal   NUMBER DEFAULT NULL,
                            pn_sporlu   NUMBER DEFAULT 0,
                            pn_DEK_LEASING NUMBER DEFAULT 0,
                            pn_MAL_BEDELI NUMBER DEFAULT NULL,
                            pn_KDV_ORAN NUMBER DEFAULT NULL,
                            pn_KIRACIYA_SATIS_BEDELI NUMBER DEFAULT NULL,
                            pd_SATIS_VADESI DATE DEFAULT NULL,
                            pn_ODEMESIZ_SURE_DONEM NUMBER DEFAULT NULL,
                            pn_ODEME_PERIYODU NUMBER DEFAULT NULL,
                            pn_PESIN_TAKSIT_TUTARI NUMBER DEFAULT NULL,
                            pn_SATICI_HESAP_NO NUMBER DEFAULT NULL,
                            pn_DEK_URUN_NO NUMBER DEFAULT NULL
                            ) RETURN NUMBER IS
  -- gayrinakdi kredi hesabi acilir
  vn_hesap_no NUMBER;
  vc_gl_code VARCHAR2(30);
  vn_urun_grup_no NUMBER;
  vc_var VARCHAR2(200);
  vn_grup_kod  gnl_musteri.dk_grup_kod%TYPE;
  vn_gecikme_faiz_oran NUMBER;

  A NUMBER := 0;
  ln_kkdf_orani NUMBER;
  ln_bsmv_orani NUMBER;
  vc_risk_yarat VARCHAR2(1);
  v_sch_faiz_orani  NUMBER;
  v_sch_faiz_orani_marjsiz  NUMBER;
  v_sch_faiz_tur  muh_hesap_kredi.sch_faiz_tur%TYPE;
  BEGIN
    vn_hesap_no := Pkg_Genel_pr.genel_kod_al('HESAP.VDSZ');

    IF /*ps_urun_tur <> 'TAHAKKUK' And*/ p_musteri_dk_no IS NULL THEN
      vn_grup_kod := pkg_musteri.hp_grup_kod(pn_musteri_no);
      Pkg_Muhasebe.dk_bul( vn_grup_kod, ps_modul_tur, ps_urun_tur,  ps_urun_sinif,  1, FALSE, FALSE, FALSE, vc_gl_code);
    ELSE
      vc_gl_code := p_musteri_dk_no ;
    END IF;
A:=1;
   vc_var:= pkg_hp.DK_Varmi(ps_sube,vc_gl_code, ps_doviz);

   IF vc_var <> 'E' THEN
      pkg_hata.hata_yaz(696, TRUE, ps_sube, vc_gl_code, ps_doviz);
   END IF;

   pkg_kredi.hesap_acilis_gusin_kontrol(vn_grup_kod, ps_modul_tur, ps_urun_tur, ps_urun_sinif);

   v_sch_faiz_orani := p_sch_faiz_orani;
   v_sch_faiz_orani_marjsiz := p_sch_faiz_orani_marjsiz;
   v_sch_faiz_tur           := p_sch_faiz_tur;
     
   IF ps_urun_tur = 'KMH' THEN
     v_sch_faiz_tur := 'D';
     BEGIN
       pkg_scf.vadeli_toplam_sch_orani_bul(pkg_muhasebe.Banka_Tarihi_Bul,  NVL(p_endeks_doviz_kodu,ps_doviz),
                                 pkg_muhasebe.Banka_Tarihi_Bul, ps_modul_tur, ps_urun_tur, ps_urun_sinif, v_sch_faiz_tur,
                                 v_sch_faiz_orani, v_sch_faiz_orani_marjsiz,pn_islem_kanal);
      EXCEPTION WHEN no_data_found THEN
       v_sch_faiz_orani := NULL;
       v_sch_faiz_orani_marjsiz := NULL;
     END;

   ELSE
     IF NVL(v_sch_faiz_orani,0) = 0 THEN
       BEGIN
         
            pkg_scf.sch_faiz_oran_bul(pd_talep_acilis => pkg_muhasebe.Banka_Tarihi_Bul, 
                                  pc_doviz_kodu => NVL(p_endeks_doviz_kodu,ps_doviz), 
                                  pd_vade_tarihi =>pkg_muhasebe.Banka_Tarihi_Bul , 
                                  pc_urun_tur =>ps_urun_tur , 
                                  pc_urun_sinif => ps_urun_sinif, 
                                  pc_sch_faiz_tur => v_sch_faiz_tur, 
                                  pn_sch_oran => v_sch_faiz_orani, 
                                  pn_sch_oran_marjsiz => v_sch_faiz_orani_marjsiz, 
                                  pn_islem_kanal =>pn_islem_kanal , 
                                  pn_sporlu => pn_sporlu);
       
       /*  pkg_scf.vadeli_toplam_sch_orani_bul(pkg_muhasebe.Banka_Tarihi_Bul,  NVL(p_endeks_doviz_kodu,ps_doviz),
                                   pd_vade, ps_modul_tur, ps_urun_tur, ps_urun_sinif, v_sch_faiz_tur,
                                   v_sch_faiz_orani, v_sch_faiz_orani_marjsiz,pn_islem_kanal);
        */
        
        EXCEPTION WHEN no_data_found THEN
         v_sch_faiz_orani := NULL;
         v_sch_faiz_orani_marjsiz := NULL;
       END;
     END IF;
   END IF;
   
   --BNSPRPRO-7298 vadesi olmayan g.nakdi kredilerin sc oranlarini o urun grubu i��in tanimlanan ON faiz oranindan alinmasi
   IF Pkg_Genel_Pr.NAKDI_EH(ps_modul_tur,ps_urun_tur,ps_urun_sinif) = 'H' AND pd_vade IS NULL THEN
     v_sch_faiz_tur := 'S';
     BEGIN
       pkg_scf.vadeli_toplam_sch_orani_bul(pkg_muhasebe.Banka_Tarihi_Bul,  NVL(p_endeks_doviz_kodu,ps_doviz),
                                 pkg_muhasebe.Banka_Tarihi_Bul, ps_modul_tur, ps_urun_tur, ps_urun_sinif, v_sch_faiz_tur,
                                 v_sch_faiz_orani, v_sch_faiz_orani_marjsiz,pn_islem_kanal);
      EXCEPTION WHEN no_data_found THEN
       v_sch_faiz_orani := NULL;
       v_sch_faiz_orani_marjsiz := NULL;
     END;
   END IF;
   
   IF p_urun_grup_no IS NULL THEN
      vc_risk_yarat := pkg_tablo.modul_urun_sinif(ps_modul_tur, ps_urun_tur, ps_urun_sinif).risk_yarat;
      IF vc_risk_yarat = 'E' THEN
        vn_urun_grup_no := pkg_limit.urun_grup_al(ps_modul_tur, ps_urun_tur, ps_urun_sinif);
      END IF;
   ELSE
      vn_urun_grup_no := p_urun_grup_no;
   END IF;

A := 2;

  IF pn_kkdf_orani IS NULL AND p_kkdf_alinsin='E' THEN
    ln_kkdf_orani := pkg_parametre.Deger_Al_K_N('G_KKDF_ORANI');
  ELSE
    ln_kkdf_orani := pn_kkdf_orani;
  END IF;

  IF p_bsmv_orani IS NULL AND p_bsmv_alinsin='E' THEN
    ln_bsmv_orani := pkg_parametre.Deger_Al_K_N('G_BSMV_ORANI');
  ELSE
    ln_bsmv_orani := p_bsmv_orani;
  END IF;

    IF Pkg_Parametre.DEGER(ps_modul_tur , ps_urun_tur, ps_urun_sinif, 'PESIN_FAIZ') = 'E' THEN
      vn_gecikme_faiz_oran := pn_pesin_faiz_orani;
    ELSE
      vn_gecikme_faiz_oran := p_faiz_orani * TemerrutOranKatSayi(NULL);
    END IF;

    INSERT INTO MUH_HESAP_KREDI(hesap_no, musteri_no, doviz_kodu, tutar, durum_kodu,
                                sube_kodu, musteri_dk_no, urun_tur_kod, urun_sinif_kod,
                                modul_tur_kod, kredi_vade, referans,
                                kredi_teklif_satir_numara  ,kredi_kullandirim_kodu  ,
                                endeks_doviz_kodu  ,kullandirim_doviz_kodu  ,son_gun_faizi  ,
                                acilis_kuru  ,faiz_orani  ,faiz_siklik  ,faiz_siklik_tipi  ,
                                faiz_tahakkuk_tarihi  ,komisyon_orani  ,komisyon_tutari  ,
                                komisyon_tahsilat_donemi  ,kkdf_orani  ,bsmv_orani  ,alacak_hesap_no  ,            iliskili_hesap_no  ,
                                kur_farki  ,extre_masrafi  ,sinirlama_kodu  ,
                                kaynak_kodu  ,istatistik_kodu  ,urun_grup_no  ,
                                faiz_tahakkuk_hesap_no  ,kom_tahakkuk_hesap_no  ,
                                birikmis_faiz_tutari  ,birikmis_komisyon_tutari ,
                                esas_gun_sayisi,
                                acilis_tarihi,
                                endeks_doviz_tutari ,
                                son_islem_kuru,
                                sch_faiz_orani, sch_faiz_orani_marjsiz, odeme_turu, taksit_sayisi,
                                taksit_once_sonra, artis_siklik, artis_oran,
                                ara_odeme_siklik, ara_odeme_tutar, donem_siklik,
                                sch_faiz_tur ,
                                tahakkuk_sch_faiz_tutari,
                                temdit_tarihi,
                                repayment_type,
                                kkdf_alinsin,
                                bsmv_alinsin,
                                taahhut_vadesi,
                                belge_no,
                                belge_kodu,
                                belge_tarihi,
                                basvuru_no,
                                yakin_izleme   ,
                                faiz_endeks_turu,
                                faiz_endeks_kodu,
                                faiz_endeks_period,
                                endeks_faiz_orani,
                                spread_tipi      ,
                                spread_orani      ,
                                faiz_degisim_siklik,
                                faiz_degisim_siklik_tipi,
                                faiz_degisim_tarihi,
                                min_faiz_orani,
                                talep_no          ,
                                belgelimi,
                                faiz_tipi,
                                endeks_tarihi,
                                faiz_degisecekmi,
                                Wb_Ekno,
                                pesin_faiz_orani,
                                pesin_faiz_tutari,
                                temlik_borclu_musteri_no,
                                ortalama_vade,
                                taksit_baslangic_tarihi,
                                sigorta_sirketi,
                                gecikme_faiz_orani,
                                ekstre_basilsin,
                                Alacak_Yp_Hesap_No,
                                erken_kapama_faiz_tutari,
                                erken_kapama_faiz_orani,
                                DEK_LEASING,
                                MAL_BEDELI,
                                KDV_ORAN,
                                KIRACIYA_SATIS_BEDELI,
                                SATIS_VADESI,
                                ODEMESIZ_SURE_DONEM,
                                ODEME_PERIYODU,
                                PESIN_TAKSIT_TUTARI,
                                SATICI_HESAP_NO,
                                DEK_URUN_NO
                                )
            VALUES (vn_hesap_no, pn_musteri_no, ps_doviz, p_tutar, 'A',
                    ps_sube, vc_gl_code,
                    ps_urun_tur, ps_urun_sinif,
                    ps_modul_tur, pd_vade, ps_referans,
                    p_kredi_teklif_satir_numara  ,p_kredi_kullandirim_kodu  ,
                    p_endeks_doviz_kodu  ,p_kullandirim_doviz_kodu  ,p_son_gun_faizi  ,
                    p_acilis_kuru  ,p_faiz_orani  ,p_faiz_siklik  ,p_faiz_siklik_tipi  ,
                    p_faiz_tahakkuk_tarihi  ,p_komisyon_orani  ,p_komisyon_tutari  ,
                    p_komisyon_tahsilat_donemi  ,
                    ln_kkdf_orani,--pn_kkdf_orani  ,
                    ln_bsmv_orani,--p_bsmv_orani  ,
                    p_alacak_hesap_no  ,
                    p_iliskili_hesap_no  ,
                    p_kur_farki  ,
                    NVL(p_extre_masrafi,'H'),p_sinirlama_kodu  ,p_kaynak_kodu  ,
                    p_istatistik_kodu  ,
                    vn_urun_grup_no,
                    p_faiz_tahakkuk_hesap_no  ,
                    pn_kom_tahakkuk_hesap_no  ,
                    p_birikmis_faiz_tutari  ,
                    p_birikmis_komisyon_tutari,NVL(p_esas_gun_sayisi,360),
                    NVL(p_acilis_tarihi,Pkg_Muhasebe.banka_tarihi_bul),
                    DECODE(p_endeks_doviz_kodu,NULL, 0,p_tutar),
                    DECODE(p_endeks_doviz_kodu,NULL,NULL,p_acilis_kuru),
                    v_sch_faiz_orani, v_sch_faiz_orani_marjsiz, p_odeme_turu, p_taksit_sayisi,
                    p_taksit_once_sonra, p_artis_siklik, p_artis_oran,
                    p_ara_odeme_siklik, p_ara_odeme_tutar, p_donem_siklik,
                    v_sch_faiz_tur ,
                    p_tahakkuk_sch_faiz_tutari,
                    p_temdit_tarihi    ,
                    p_repayment_type,
                    p_kkdf_alinsin,
                    p_bsmv_alinsin,
                    p_taahhut_vadesi,
                    p_belge_no,
                    p_belge_kodu,
                    p_belge_tarihi,
                    p_basvuru_no,
                    NVL(p_yakin_izleme,'H'),
                    p_faiz_endeks_turu,
                    p_faiz_endeks_kodu,
                    p_faiz_endeks_period,
                    p_endeks_faiz_orani    ,
                    p_spread_tipi      ,
                    p_spread_orani      ,
                    p_faiz_degisim_siklik,
                    p_faiz_degisim_siklik_tipi,
                    p_faiz_degisim_tarihi,
                    p_min_faiz_orani,
                    p_talep_no          ,
                    p_belgelimi    ,
                    p_faiz_tipi,
                    p_endeks_tarihi,
                    p_faiz_degisecekmi,
                    pn_wbekno,
                    pn_pesin_faiz_orani,
                    pn_pesin_faiz_tutari,
                    pn_temlik_musteri,
                    pd_ortalama_vade,
                    pd_taksit_baslangic_tarihi,
                    pc_sigorta_sirketi,
                    vn_gecikme_faiz_oran,
                    pc_ekstre_basilsin,
                    pn_alacak_yp_hesap_no,
                    pn_erken_kapama_faiz_tutari,
                    pn_erken_kapama_faiz_orani,
                    pn_DEK_LEASING ,
                    pn_MAL_BEDELI ,
                    pn_KDV_ORAN ,
                            pn_KIRACIYA_SATIS_BEDELI ,
                            pd_SATIS_VADESI ,
                            pn_ODEMESIZ_SURE_DONEM ,
                            pn_ODEME_PERIYODU ,
                            pn_PESIN_TAKSIT_TUTARI,
                            pn_SATICI_HESAP_NO,
                            pn_DEK_URUN_NO
                    );
A := 4;
        Pkg_Hesap.HESAP_BAKIYE_OLUSTUR(  vn_hesap_no,
                                         0,
                                         0,
                                         0,
                                         Pkg_Parametre.deger(ps_modul_tur ,ps_urun_tur,ps_urun_sinif, 'BAKIYE_KARAKTERI'));

A := 5;

   RETURN vn_hesap_no;

  END;


-----------------------------------------------------------------------------------------------------
 FUNCTION bir_kredi_hesap_ac( ps_modul_tur VARCHAR2, ps_urun_tur VARCHAR2, ps_urun_sinif VARCHAR2,
                              pn_musteri_no NUMBER, ps_doviz VARCHAR2, ps_sube VARCHAR2,
                              pd_vade DATE,  ps_referans VARCHAR2,
                              p_musteri_dk_no MUH_HESAP_KREDI.MUSTERI_DK_NO%TYPE DEFAULT NULL,
                              p_tutar MUH_HESAP_KREDI.tutar%TYPE DEFAULT 0,
                              p_extre_masrafi  MUH_HESAP_KREDI.extre_masrafi%TYPE DEFAULT 'H',
                              p_iliskili_hesap_no  MUH_HESAP_KREDI.iliskili_hesap_no%TYPE DEFAULT NULL,
                              p_endeks_doviz_kodu  MUH_HESAP_KREDI.endeks_doviz_kodu%TYPE DEFAULT NULL,
                              p_kullandirim_doviz_kodu  MUH_HESAP_KREDI.kullandirim_doviz_kodu%TYPE DEFAULT NULL,
                              p_acilis_kuru  MUH_HESAP_KREDI.acilis_kuru%TYPE DEFAULT NULL,
                              p_faiz_orani  MUH_HESAP_KREDI.faiz_orani%TYPE DEFAULT NULL,
                              pn_kkdf_orani  MUH_HESAP_KREDI.kkdf_orani%TYPE DEFAULT NULL,
                              p_bsmv_orani  MUH_HESAP_KREDI.bsmv_orani%TYPE DEFAULT NULL,
                              p_alacak_hesap_no  MUH_HESAP_KREDI.alacak_hesap_no%TYPE DEFAULT NULL,
                              p_kur_farki  MUH_HESAP_KREDI.kur_farki%TYPE DEFAULT NULL,
                              p_sinirlama_kodu  MUH_HESAP_KREDI.sinirlama_kodu%TYPE DEFAULT NULL,
                              p_urun_grup_no  MUH_HESAP_KREDI.urun_grup_no%TYPE DEFAULT NULL,
                              p_birikmis_faiz_tutari  MUH_HESAP_KREDI.birikmis_faiz_tutari%TYPE DEFAULT 0,
                              p_acilis_tarihi  MUH_HESAP_KREDI.acilis_tarihi%TYPE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                              p_endeks_doviz_tutari NUMBER DEFAULT 0,
                              p_sch_faiz_orani NUMBER DEFAULT 0,
                              p_odeme_turu    VARCHAR2 DEFAULT NULL,
                              p_taksit_sayisi    NUMBER DEFAULT NULL,
                              p_taksit_once_sonra  VARCHAR2 DEFAULT NULL,
                              p_artis_siklik    NUMBER DEFAULT NULL,
                              p_artis_oran    NUMBER DEFAULT NULL,
                              p_ara_odeme_siklik  NUMBER DEFAULT NULL,
                              p_ara_odeme_tutar    NUMBER DEFAULT NULL,
                              p_donem_siklik    NUMBER DEFAULT NULL,
                              p_sch_faiz_tur VARCHAR2 DEFAULT 'S',
                              p_tahakkuk_sch_faiz_tutari NUMBER DEFAULT 0,
                              p_temdit_tarihi         DATE DEFAULT NULL,
                              p_repayment_type       MUH_HESAP_KREDI.repayment_type%TYPE DEFAULT NULL,
                              p_kkdf_alinsin         VARCHAR2 DEFAULT 'E',
                              p_bsmv_alinsin         VARCHAR2 DEFAULT 'E',
                              p_basvuru_no          NUMBER DEFAULT NULL,
                              p_yakin_izleme         VARCHAR2 DEFAULT 'H'  ,
                              p_faiz_endeks_turu  MUH_HESAP_KREDI.faiz_endeks_turu%TYPE DEFAULT NULL,
                              p_faiz_endeks_kodu  MUH_HESAP_KREDI.faiz_endeks_kodu%TYPE DEFAULT NULL,
                              p_faiz_endeks_period      MUH_HESAP_KREDI.faiz_endeks_period%TYPE DEFAULT NULL,
                              p_endeks_faiz_orani          MUH_HESAP_KREDI.endeks_faiz_orani%TYPE DEFAULT NULL,
                              p_spread_tipi             MUH_HESAP_KREDI.spread_tipi  %TYPE DEFAULT NULL,
                              p_spread_orani              MUH_HESAP_KREDI.spread_orani%TYPE DEFAULT NULL,
                              p_faiz_degisim_siklik  MUH_HESAP_KREDI.faiz_degisim_siklik%TYPE DEFAULT NULL,
                              p_faiz_degisim_siklik_tipi  MUH_HESAP_KREDI.faiz_degisim_siklik_tipi%TYPE DEFAULT NULL,
                              p_faiz_degisim_tarihi       MUH_HESAP_KREDI.faiz_degisim_tarihi%TYPE DEFAULT NULL,
                              p_min_faiz_orani  MUH_HESAP_KREDI.min_faiz_orani%TYPE DEFAULT NULL,
                              p_talep_no               MUH_HESAP_KREDI.talep_no%TYPE DEFAULT NULL,
                              p_belgelimi              VARCHAR2 DEFAULT NULL,
                              p_krd_tur_kod             NUMBER,
                              p_krd_alt_tur_kod             NUMBER,
                              p_krd_alt_tur_kod2             NUMBER,
                              p_faiz_tipi              VARCHAR2 DEFAULT NULL,
                              p_endeks_tarihi            DATE DEFAULT NULL,
                              p_faiz_degisecekmi          VARCHAR2 DEFAULT NULL,
                              p_kanal_kodu    MUH_HESAP_KREDI.Kanal_Kod%TYPE DEFAULT NULL
                             ) RETURN NUMBER
IS
  -- gayrinakdi kredi hesabi acilir
  ln_hesap_no NUMBER;
  ls_gl_code VARCHAR2(30);
  ln_urun_grup_no NUMBER;
  ls_var VARCHAR2(200);
  dkyok   EXCEPTION;
  A NUMBER := 0;
  ln_kkdf_orani NUMBER;
  ln_bsmv_orani NUMBER;
  ln_hp_grup_kod NUMBER;

  v_sch_faiz_orani NUMBER;
  v_sch_faiz_orani_marjsiz NUMBER;

  BEGIN
    ln_hesap_no := Pkg_Genel_pr.genel_kod_al('HESAP.VDSZ');
A:=1;
   ls_gl_code := p_musteri_dk_no ;

   ls_var:= pkg_hp.DK_Varmi(ps_sube,ls_gl_code, ps_doviz);

   IF ls_var <> 'E' THEN
      RAISE dkyok;
   END IF;
   ln_hp_grup_kod := pkg_musteri.hp_grup_kod(pn_musteri_no);
   pkg_kredi.hesap_acilis_gusin_kontrol(ln_hp_grup_kod,ps_modul_tur, ps_urun_tur, ps_urun_sinif);

   v_sch_faiz_orani := p_sch_faiz_orani;

   IF NVL(v_sch_faiz_orani,0) = 0 THEN
     BEGIN
       pkg_scf.vadeli_toplam_sch_orani_bul(pkg_muhasebe.Banka_Tarihi_Bul,  NVL(p_endeks_doviz_kodu,ps_doviz),
                                 pd_vade, ps_modul_tur, ps_urun_tur, ps_urun_sinif, p_sch_faiz_tur,
                                 v_sch_faiz_orani, v_sch_faiz_orani_marjsiz,p_kanal_kodu);
      EXCEPTION WHEN no_data_found THEN
       v_sch_faiz_orani := NULL;
       v_sch_faiz_orani_marjsiz := NULL;
     END;
   END IF;


   ln_urun_grup_no := p_urun_grup_no;
A := 2;

  IF pn_kkdf_orani IS NULL AND p_kkdf_alinsin='E' THEN
     ln_kkdf_orani := pkg_parametre.Deger_Al_K_N('G_KKDF_ORANI');
  END IF;

  IF p_bsmv_orani IS NULL AND p_bsmv_alinsin='E' THEN
     ln_bsmv_orani := pkg_parametre.Deger_Al_K_N('G_BSMV_ORANI');
  END IF;

    INSERT INTO MUH_HESAP_KREDI(hesap_no, musteri_no, doviz_kodu, tutar,
                                durum_kodu, sube_kodu, musteri_dk_no, urun_tur_kod,
                                urun_sinif_kod, modul_tur_kod, kredi_vade, referans,
                                endeks_doviz_kodu, kullandirim_doviz_kodu, acilis_kuru, faiz_orani,
                                kkdf_orani  ,bsmv_orani  ,alacak_hesap_no, iliskili_hesap_no,
                                kur_farki, extre_masrafi, sinirlama_kodu, urun_grup_no,
                                birikmis_faiz_tutari, acilis_tarihi, endeks_doviz_tutari, son_islem_kuru,
                                sch_faiz_orani, odeme_turu, taksit_sayisi, taksit_once_sonra,
                                artis_siklik, artis_oran, ara_odeme_siklik, ara_odeme_tutar,
                                donem_siklik, sch_faiz_tur, tahakkuk_sch_faiz_tutari,
                                temdit_tarihi, repayment_type, kkdf_alinsin, bsmv_alinsin,
--                                ulasim_gideri, ekspertiz_masrafi, noter_masrafi,
                                basvuru_no,
                                yakin_izleme, faiz_endeks_turu,faiz_endeks_kodu, faiz_endeks_period, 
                                endeks_faiz_orani,spread_tipi, spread_orani, faiz_degisim_siklik, 
                                faiz_degisim_siklik_tipi, faiz_degisim_tarihi, min_faiz_orani,
                                  talep_no,
                                belgelimi,
                                --kredi_tipi, sigortalayan, tasit_durumu, pesinat_orani,
--                                tasit_kullanim_amaci, kampanya_kodu, rehin_ucreti,
                                KRD_TUR_KOD, KRD_TUR_ALT_KOD, KRD_TUR_ALT_KOD2,
                                faiz_tipi, endeks_tarihi, faiz_degisecekmi, Gecikme_Faiz_Orani,Kisa_Isim
                                ,Kanal_Kod, sch_faiz_orani_marjsiz )
            VALUES (ln_hesap_no, pn_musteri_no, ps_doviz, p_tutar,
                    'A', ps_sube, ls_gl_code,  ps_urun_tur,
                    ps_urun_sinif, ps_modul_tur, pd_vade, ps_referans,
                    p_endeks_doviz_kodu, p_kullandirim_doviz_kodu, p_acilis_kuru, p_faiz_orani,
                    ln_kkdf_orani,--pn_kkdf_orani,
                    ln_bsmv_orani,--p_bsmv_orani,
                    p_alacak_hesap_no, p_iliskili_hesap_no,
                    p_kur_farki, NVL(p_extre_masrafi,'H'),p_sinirlama_kodu, ln_urun_grup_no,
                    p_birikmis_faiz_tutari, NVL(p_acilis_tarihi,Pkg_Muhasebe.banka_tarihi_bul), DECODE(p_endeks_doviz_kodu,NULL,0,p_endeks_doviz_tutari),
                    DECODE(p_endeks_doviz_kodu,NULL,NULL,p_acilis_kuru), v_sch_faiz_orani, p_odeme_turu, p_taksit_sayisi,
                    p_taksit_once_sonra, p_artis_siklik, p_artis_oran,
                    p_ara_odeme_siklik, p_ara_odeme_tutar, p_donem_siklik,
                    p_sch_faiz_tur, p_tahakkuk_sch_faiz_tutari, p_temdit_tarihi,
                    p_repayment_type, p_kkdf_alinsin, p_bsmv_alinsin,
--                    p_ulasim_gideri, p_ekspertiz_masrafi, p_noter_masrafi,
                    p_basvuru_no,
                    NVL(p_yakin_izleme,'H'), p_faiz_endeks_turu, p_faiz_endeks_kodu, p_faiz_endeks_period, p_endeks_faiz_orani,p_spread_tipi, p_spread_orani,
                     p_faiz_degisim_siklik, p_faiz_degisim_siklik_tipi, p_faiz_degisim_tarihi, p_min_faiz_orani,
                     p_talep_no,
                    p_belgelimi,
--                    p_kredi_tipi, p_sigortalayan, p_tasit_durumu, p_pesinat_orani,
--                    p_tasit_kullanim_amaci, p_kampanya_kodu, p_rehin_ucreti,
                    P_KRD_TUR_KOD, p_krd_alt_tur_kod, p_krd_alt_tur_kod2,
                    p_faiz_tipi, p_endeks_tarihi, p_faiz_degisecekmi, p_faiz_orani * Pkg_Bireysel.GecikmeOranKatsayi(p_krd_tur_kod),SUBSTR(pkg_musteri.unvan(pn_musteri_no),1,30),
                    p_kanal_kodu, v_sch_faiz_orani_marjsiz );
A := 3;

        Pkg_Hesap.HESAP_BAKIYE_OLUSTUR(  ln_hesap_no,
                                         0,
                                         0,
                                         0,
                                         'N');

A := 5;
   RETURN ln_hesap_no;

   EXCEPTION
    WHEN dkyok THEN
      pkg_hata.hata_yaz(696, TRUE, ps_sube, ls_gl_code, ps_doviz);
  /*  WHEN OTHERS THEN
      pkg_hata.hata_yaz(697, true, 'a='||a||'-hesapno='||ln_hesap_no||'--'||SQLERRM);*/
  END;

-------------------------------------------------------------------------------------------------------------------

  FUNCTION KrediHesap_UrunUygunmu( pc_urun_tur_kod MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                                   pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE DEFAULT NULL)
                                   RETURN VARCHAR2 IS
  BEGIN
    /* IF  (pc_urun_tur_kod IN ( 'TAHAKKUK','AKREDITIF' ,'TEM.MEKTUP','ITH.AKR','KABULKRED','VER.GARAN',
                               'CEK KARNE','FORWARD','NOSTRO-TP','NOSTRO-YP','SWAP-FW', 'KMH',
                               'TAKIPKRED','VADELI-L/C','FAKT.FAT.','VER.GARAN','AKR TA.SIG',
                               'YURTD FRM.','LEAS.FAT.','TAZMIN-TP','TAZMIN-YP') ) THEN*/
    IF pkg_parametre.Varchar_Al(pkg_kredi.modul_tur_kod, pc_urun_tur_kod, pc_urun_sinif_kod, 'NAKDI_KREDI_URUNU') = 'H' THEN
       RETURN 'H';
    ELSE
       RETURN 'E';
    END IF;

    EXCEPTION
      WHEN OTHERS THEN RETURN 'H';
  END ;
------------------------------------------------------------------------------------------------------------------
  PROCEDURE faizkom_dk_tanimlimi(pn_txno NUMBER) IS
   vc_komreesdk         MUH_HP_TANIM.Hesap_No%TYPE;
   vc_faizreesdk        MUH_HP_TANIM.Hesap_No%TYPE;
   vc_komdk             MUH_HP_TANIM.Hesap_No%TYPE;
   vc_faizdk            MUH_HP_TANIM.Hesap_No%TYPE;

  CURSOR Cur_hesap IS
    SELECT doviz_kodu, faiz_orani, komisyon_orani, Pkg_Musteri.hp_grup_kod(musteri_no) dk_grup_kod,
           modul_tur_kod, urun_tur_kod, urun_sinif_kod, hesap_no, sube_kodu,
           NVL(M.Birikmis_Faiz_Tutari ,0) Brk_faiz_tut, NVL(M.Birikmis_Komisyon_Tutari ,0) Brk_Kom_tut
      FROM MUH_HESAP_KREDI_TX M
     WHERE tx_no = pn_txno
    ;
  BEGIN
    FOR Rec_hesap IN Cur_hesap LOOP
      IF ( NVL(Rec_hesap.Faiz_Orani,0) <> 0 OR Rec_hesap.Brk_Faiz_Tut > 0 ) THEN
        --faiz gelir dk
        Pkg_Muhasebe.DK_BUL ( Rec_hesap.Dk_Grup_Kod, Rec_hesap.Modul_Tur_Kod, Rec_hesap.Urun_Tur_Kod, Rec_hesap.Urun_Sinif_Kod,
                              2, NULL, NULL, NULL, vc_faizdk);
        IF vc_faizdk IS NULL THEN
           pkg_hata.hata_yaz(1142, TRUE, Rec_Hesap.Hesap_No, Rec_hesap.Dk_Grup_Kod, Rec_Hesap.Modul_Tur_Kod||'-'||Rec_Hesap.Urun_Tur_Kod||'-'||Rec_Hesap.Urun_Sinif_Kod);
        END IF;
        --faiz reeskont dk
        Pkg_Muhasebe.DK_BUL ( Rec_hesap.Dk_Grup_Kod, Rec_hesap.Modul_Tur_Kod, Rec_hesap.Urun_Tur_Kod, Rec_hesap.Urun_Sinif_Kod,
                              4, NULL, NULL, NULL, vc_faizreesdk);
        IF vc_faizreesdk IS NULL  THEN
          pkg_hata.hata_yaz(1143, TRUE, Rec_Hesap.Hesap_No, Rec_hesap.Dk_Grup_Kod, Rec_Hesap.Modul_Tur_Kod||'-'||Rec_Hesap.Urun_Tur_Kod||'-'||Rec_Hesap.Urun_Sinif_Kod);
        END IF;
        --faiz hesaby kontrol
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_faizdk, Rec_hesap.Doviz_Kodu);
        --faizrees
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_faizreesdk, Rec_hesap.Doviz_Kodu);
        --faiz tl
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_faizdk, Pkg_Genel_Pr.lc_al);
      END IF;
      IF NVL(Rec_hesap.komisyon_orani,0) <>0  OR NVL(Rec_hesap.Brk_Kom_Tut,0) <>0   THEN
        --komisyon dk
        Pkg_Muhasebe.DK_BUL ( Rec_hesap.Dk_Grup_Kod, Rec_hesap.Modul_Tur_Kod, Rec_hesap.Urun_Tur_Kod, Rec_hesap.Urun_Sinif_Kod,
                              5, NULL, NULL, NULL, vc_komdk);
        IF vc_komdk IS NULL THEN
          pkg_hata.hata_yaz(1144, TRUE, Rec_Hesap.Hesap_No, Rec_hesap.Dk_Grup_Kod, Rec_Hesap.Modul_Tur_Kod||'-'||Rec_Hesap.Urun_Tur_Kod||'-'||Rec_Hesap.Urun_Sinif_Kod);
        END IF;
        --komisyon reeskont dk
        Pkg_Muhasebe.DK_BUL ( Rec_hesap.Dk_Grup_Kod, Rec_hesap.Modul_Tur_Kod, Rec_hesap.Urun_Tur_Kod, Rec_hesap.Urun_Sinif_Kod,
                              6, NULL, NULL, NULL, vc_komreesdk);

        IF vc_komreesdk IS NULL   THEN
          pkg_hata.hata_yaz(1145, TRUE, Rec_Hesap.Hesap_No, Rec_hesap.Dk_Grup_Kod, Rec_Hesap.Modul_Tur_Kod||'-'||Rec_Hesap.Urun_Tur_Kod||'-'||Rec_Hesap.Urun_Sinif_Kod);
        END IF;
        --komisyon
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_komdk, Rec_hesap.Doviz_Kodu);
        --komrees
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_komreesdk, Rec_hesap.Doviz_Kodu);
        --komis tl
        Pkg_Kredi.DK_MevcutMu_Kont(Rec_hesap.Sube_Kodu, vc_komdk, pkg_genel_pr.lc_al);
      END IF;
    END LOOP;
 END;
-----------------------------------------------------------------------------------------
FUNCTION Komite_adi_al(pn_komitekod KRE_KOMITE_KOD_PR.KOD%TYPE) RETURN KRE_KOMITE_KOD_PR.ACIKLAMA%TYPE IS
 BEGIN
   IF pn_komitekod IS NULL THEN RETURN NULL;
   ELSE
     RETURN PKg_Tab_Loan.KreKomitekod(pn_komitekod).aciklama;
   END IF;
 END;
---
FUNCTION DK_MevcutMu(pc_subekod VARCHAR2, pc_dk VARCHAR2, pc_dov VARCHAR2 ) RETURN VARCHAR2 IS
  say NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO say
    FROM MUH_HP_BAKIYE M
   WHERE M.Sube_Kod = pc_subekod
     AND M.HESAP_NO = pc_dk
     AND doviz_kod  = pc_dov
   ;
   IF say = 0 THEN
     RETURN 'H';
   ELSE
     RETURN 'E';
   END IF;
END;
---
PROCEDURE DK_MevcutMu_Kont(pc_subekod VARCHAR2, pc_dk VARCHAR2, pc_dov VARCHAR2 ) IS
  say NUMBER;
BEGIN
  SELECT COUNT(*)
    INTO say
    FROM MUH_HP_BAKIYE M
   WHERE M.Sube_Kod = pc_subekod
     AND M.HESAP_NO = pc_dk
     AND doviz_kod  = pc_dov
   ;
   IF say = 0 THEN
     pkg_hata.hata_yaz(696, TRUE, pc_subekod, pc_dk, pc_dov);
   END IF;
END;
---
-------------------------------------------------------------------------------
PROCEDURE MUH_HESAP_KREDI_INSERT(pn_txno Muh_Hesap_Kredi_Tx.Tx_No%TYPE) IS
BEGIN
      INSERT INTO MUH_HESAP_KREDI(hesap_no, Musteri_No, Doviz_Kodu, Tutar, Durum_Kodu, Sube_Kodu, Musteri_Dk_No,
                                  Urun_Tur_Kod, Urun_Sinif_Kod, Modul_Tur_Kod, Kredi_Vade,Kredi_Kullandirim_Kodu,
                                  Endeks_Doviz_Kodu, Kullandirim_Doviz_Kodu, Son_Gun_Faizi,
                                  Acilis_Kuru, Faiz_Orani, Faiz_Siklik, Faiz_Siklik_Tipi, Faiz_Tahakkuk_Tarihi,
                                  Komisyon_Orani, Komisyon_Tutari, Bsmv_Orani, Alacak_Hesap_No,
                                  Iliskili_Hesap_No, Sinirlama_Kodu, Kaynak_Kodu, Istatistik_Kodu, Urun_Grup_No,
                                  Bsmv_Alinsin, Kkdf_Alinsin, Repayment_Type, Belge_No,Belge_Kodu, Belge_Tarihi,
                                  Belgelimi, Faiz_Endeks_Period, Spread_Tipi, Spread_Orani, Talep_No, Endeks_Faiz_Orani)

     SELECT                       DECODE(hesap_no, NULL, '11111', hesap_no), MUSTERI_NO, DOVIZ_KODU, TUTAR, DURUM_KODU, SUBE_KODU, MUSTERI_DK_NO,
                                  URUN_TUR_KOD, URUN_SINIF_KOD, MODUL_TUR_KOD,
                                  KREDI_VADE, KREDI_KULLANDIRIM_KODU, ENDEKS_DOVIZ_KODU, KULLANDIRIM_DOVIZ_KODU, SON_GUN_FAIZI,
                                  ACILIS_KURU, FAIZ_ORANI, FAIZ_Siklik, FAIZ_Siklik_TIPI, FAIZ_TAHAKKUK_TARIHI,
                                  KOMISYON_ORANI, KOMISYON_TUTARI, BSMV_ORANI, ALACAK_HESAP_NO, ILISKILI_HESAP_NO,
                                  SINIRLAMA_KODU, KAYNAK_KODU, ISTATISTIK_KODU, URUN_GRUP_NO, BSMV_ALINSIN, KKDF_ALINSIN,
                                  REPAYMENT_TYPE, BELGE_NO, BELGE_KODU, BELGE_TARIHI, BELGELIMI, FAIZ_ENDEKS_PERIOD,
                                  SPREAD_TIPI, SPREAD_ORANI, TALEP_NO, ENDEKS_FAIZ_ORANI

     FROM MUH_HESAP_KREDI_TX M
     WHERE tx_no = pn_txno ;

END;

FUNCTION hesap_ac(pn_txno NUMBER) RETURN NUMBER IS

     v_modultur                    VARCHAR2(30);
     v_uruntur                     VARCHAR2(10);
     v_urunsinif                   VARCHAR2(50 CHAR);
     v_musterino                   NUMBER;
     v_dovizkod                    VARCHAR2(3);
     v_subekod                     VARCHAR2(10);
     v_vadetarih                   DATE;
     v_referans                    VARCHAR2(20);
     v_musteridk                   VARCHAR2(30);
     v_tutar                       NUMBER;
     v_ekstre                      VARCHAR2(1);
     v_iliskilihesap               NUMBER;
     v_teklifsatir                 NUMBER;
     v_kullandirimkredi            NUMBER;
     v_endeksdoviz                 VARCHAR2(3);
     v_kullandirimdoviz            VARCHAR2(3);
     v_songunfaizi                 VARCHAR2(1);
     v_aciliskuru                  NUMBER;
     v_faizorani                   NUMBER;
     v_faizsiklik                  NUMBER;
     v_faizsikliktipi              VARCHAR2(20);
     v_faizTahakkukTarih           DATE;
     v_komisyon                    NUMBER;
     v_komisyontutar               NUMBER;
     v_komisyontahsilatdonemi      VARCHAR2(20);
     v_kkdforani                    NUMBER;
     v_bsmvorani                   NUMBER;
     v_alacakhesapno               NUMBER;
     v_kurfarki                    VARCHAR2(10);
     v_sinirlamakodu               VARCHAR2(20);
     v_kaynakkodu                  VARCHAR2(20);
     v_istatistikkodu              VARCHAR2(10);
     v_urungrupno                  NUMBER;
     v_faiztahakkukhesapno         NUMBER;
     v_vergitahakkukhesapno        NUMBER;
     v_birikmisfaiztutari          NUMBER;
     v_birikmiskomisyontutar       NUMBER;
     v_esasgun                     NUMBER;
     v_acilistarihi                DATE;
     v_endeksdoviztutari           NUMBER;
     v_schfaizorani                NUMBER;
     v_schfaizoranimarjsiz         NUMBER;
     v_odemeturu                   VARCHAR2(30);
     v_taksitsayisi                NUMBER;
     v_taksitoncesonra             VARCHAR2(10);
     v_artissiklik                 NUMBER;
     v_artisoran                   NUMBER;
     v_araodemesiklik              NUMBER;
     v_araodemetutar               NUMBER;
     v_donemsiklik                 NUMBER;
     v_schfaiztur                  VARCHAR2(1);
     v_tahschfaiztutar             NUMBER;
     v_temdittarihi                DATE;
     v_repaymenttype               VARCHAR2(20);
     v_kkdfalinsin                 VARCHAR2(1);
     v_bsmvalinsin                 VARCHAR2(1);
     v_taahhutvadesi               DATE;
     v_belgeno                     VARCHAR2(30);
     v_belgekodu                   VARCHAR2(10);
     v_belgetarihi                 DATE;
     v_basvuruno                   NUMBER;
     v_yakinizleme                 VARCHAR2(1);
     v_faizendeksturu              VARCHAR2(20);
     v_faizendekskodu              VARCHAR2(20);
     v_faizendeksperiod            VARCHAR2(30);
     v_faizendeksorani             NUMBER;
     v_spreadtipi                  VARCHAR2(1);
     v_spreadorani                 NUMBER;
     v_faizdegisimsiklik           NUMBER;
     v_faizdegisimsikliktipi        VARCHAR2(20);
     v_faizdegisimtarihi           DATE;
     v_minfaizorani                NUMBER;     
     v_talepno                     NUMBER;
     v_belgelimi                   VARCHAR2(1);
     v_faiztipi                    VARCHAR2(1);
     v_endekstarihi                DATE;
     v_faizdegisecek               VARCHAR2(1);
     v_hesapNo                     NUMBER;
     v_blokeeh                     VARCHAR2(1);
     v_bloketutar                  NUMBER;
     v_ekstre_basilsin             VARCHAR2(1);

     l_bloke_ref                   MUH_BLOKE.Bloke_Referans%TYPE;
     v_alacakhesapdoviz            VARCHAR2(15);
     v_aciklama                    VARCHAR2(50);
     v_pesin_faiz_orani            NUMBER;
     v_pesin_faiz_tutari           NUMBER;
     vn_temlik_musteri_no          NUMBER;
     vn_sira_no                    NUMBER := 1;

     vd_ortalama_vade               DATE;
     vd_taksit_baslangic_tarihi     DATE;
     vc_sigorta_sirketi             VARCHAR2(50);
     vn_alacak_yp_hesap_no          NUMBER;
     vn_erken_kapama_faiz_tutari    NUMBER;
     vn_erken_kapama_faiz_orani     NUMBER;
     vn_sporlu number :=0;
     
     vn_DEK_LEASING NUMBER;
     vn_MAL_BEDELI NUMBER;
     vn_KDV_ORAN  NUMBER;
     vn_KIRACIYA_SATIS_BEDELI NUMBER;
     vd_SATIS_VADESI    DATE;
     vn_ODEMESIZ_SURE_DONEM NUMBER;
     vn_ODEME_PERIYODU NUMBER;
     vn_PESIN_TAKSIT_TUTARI NUMBER;
     vn_DEK_URUN_NO NUMBER;
     vn_SATICI_HESAP_NO NUMBER;
     
     
     CURSOR c_taksit IS
      SELECT *
        FROM MUH_HESAP_KREDI_TAKSIT_TX T
       WHERE T.tx_no = pn_txno
       ORDER BY T.vade_tarih, T.sira_no;

    CURSOR c_cek IS
      SELECT *
        FROM MUH_HESAP_KREDI_CEK_TABLO_TX T
       WHERE T.tx_no = pn_txno
       ORDER BY T.Tahsil_Vadesi, T.sira_no;

    CURSOR c_fatura IS
      SELECT *
        FROM MUH_HESAP_KREDI_FATURA_TX T
       WHERE T.tx_no = pn_txno
       ORDER BY T.valor_tarihi, T.sira_no;

BEGIN
          SELECT MHK.MODUL_TUR_KOD, MHK.URUN_TUR_KOD, MHK.URUN_SINIF_KOD, MHK.MUSTERI_NO,
                 MHK.Doviz_Kodu, MHK.Sube_Kodu, MHK.KREDI_VADE, MHK.Referans, MHK.Musteri_Dk_No,
                 DECODE(PKG_GENEL_PR.DEK_EH(MHK.MODUL_TUR_KOD, MHK.URUN_TUR_KOD, MHK.URUN_SINIF_KOD),'E',MHK.ENDEKS_DOVIZ_TUTARI,MHK.Tutar),
                 MHK.Extre_Masrafi, MHK.Iliskili_Hesap_No, MHK.Kredi_Teklif_Satir_Numara,
                 MHK.Kredi_Kullandirim_Kodu, MHK.Endeks_Doviz_Kodu, MHK.Kullandirim_Doviz_Kodu,
                 MHK.Son_Gun_Faizi, MHK.Acilis_Kuru, MHK.Faiz_Orani, MHK.Faiz_Siklik, MHK.Faiz_Siklik_Tipi,
                 MHK.Faiz_Tahakkuk_Tarihi, MHK.Komisyon_Orani, MHK.Komisyon_Tutari, MHK.Komisyon_Tahsilat_Donemi,
                 MHK.Kkdf_Orani, MHK.Bsmv_Orani, MHK.Alacak_Hesap_No, MHK.Kur_Farki, MHK.Sinirlama_Kodu, MHK.Kaynak_Kodu,
                 MHK.Istatistik_Kodu, MHK.Urun_Grup_No, MHK.Faiz_Tahakkuk_Hesap_No, MHK.Kom_Tahakkuk_Hesap_No,
                 MHK.Birikmis_Faiz_Tutari, MHK.Birikmis_Komisyon_Tutari, MHK.Esas_Gun_Sayisi, MHK.Acilis_Tarihi,
                 MHK.Endeks_Doviz_Tutari, MHK.Sch_Faiz_Orani, MHK.Odeme_Turu, MHK.Taksit_Sayisi, MHK.Taksit_Once_Sonra,
                 MHK.Artis_Siklik, MHK.Artis_Oran, MHK.Ara_Odeme_Siklik, MHK.Ara_Odeme_Tutar,MHK.Donem_Siklik, MHK.Sch_Faiz_Tur,
                 MHK.Tahakkuk_Sch_Faiz_Tutari, MHK.Temdit_Tarihi, MHK.Repayment_Type, MHK.Kkdf_Alinsin, MHK.Bsmv_Alinsin,
                 MHK.Taahhut_Vadesi, MHK.Belge_No, MHK.Belge_Kodu, MHK.Belge_Tarihi, MHK.Basvuru_No, MHK.Yakin_Izleme,
                 MHK.FAIZ_ENDEKS_TURU,MHK.Faiz_Endeks_Kodu, MHK.Faiz_Endeks_Period, MHK.Endeks_Faiz_Orani, MHK.Spread_Tipi, MHK.Spread_Orani, 
                 MHK.FAIZ_DEGISIM_SIKLIK, MHK.FAIZ_DEGISIM_SIKLIK_TIPI, MHK.Faiz_Degisim_Tarihi, MHK.MIN_FAIZ_ORANI,
                 MHK.Talep_No, MHK.Belgelimi, MHK.Faiz_Tipi, MHK.Endeks_Tarihi, MHK.Faiz_Degisecekmi,
                 MHK.BLOKE_EH, MHK.BLOKE_TUTAR, PKG_HESAP.doviz_kodu(MHK.ALACAK_HESAP_NO), MHK.PESIN_FAIZ_ORANI,
                 MHK.SCH_FAIZ_ORANI_MARJSIZ, MHK.TEMLIK_BORCLU_MUSTERI_NO, MHK.pesin_faiz_tutari, mhk.ortalama_vade,
                 mhk.taksit_baslangic_tarihi, mhk.sigorta_sirketi, mhk.ekstre_basilsin, mhk.Alacak_Yp_Hesap_No, 
                 mhk.erken_kapama_faiz_tutari, mhk.erken_kapama_faiz_orani,
                 DEK_LEASING,MAL_BEDELI,KDV_ORAN,KIRACIYA_SATIS_BEDELI,SATIS_VADESI,ODEMESIZ_SURE_DONEM,ODEME_PERIYODU,
                 PESIN_TAKSIT_TUTARI,SATICI_HESAP_NO,DEK_URUN_NO
          INTO v_modultur, v_uruntur, v_urunsinif, v_musterino, v_dovizkod, v_subekod,
          v_vadetarih, v_referans, v_musteridk, v_tutar, v_ekstre, v_iliskilihesap,v_teklifsatir,
          v_kullandirimkredi,v_endeksdoviz, v_kullandirimdoviz, v_songunfaizi, v_aciliskuru, v_faizorani, v_faizsiklik,
          v_faizsikliktipi, v_faizTahakkukTarih, v_komisyon, v_komisyontutar, v_komisyontahsilatdonemi, v_kkdforani, v_bsmvorani,
          v_alacakhesapno, v_kurfarki, v_sinirlamakodu, v_kaynakkodu, v_istatistikkodu, v_urungrupno, v_faiztahakkukhesapno,
          v_vergitahakkukhesapno, v_birikmisfaiztutari, v_birikmiskomisyontutar, v_esasgun, v_acilistarihi, v_endeksdoviztutari,
          v_schfaizorani, v_odemeturu, v_taksitsayisi, v_taksitoncesonra, v_artissiklik, v_artisoran, v_araodemesiklik, v_araodemetutar,
          v_donemsiklik, v_schfaiztur, v_tahschfaiztutar, v_temdittarihi, v_repaymenttype, v_kkdfalinsin, v_bsmvalinsin,
          v_taahhutvadesi,v_belgeno, v_belgekodu, v_belgetarihi, v_basvuruno, v_yakinizleme, v_faizendeksturu, v_faizendekskodu, 
          v_faizendeksperiod, v_faizendeksorani,v_spreadtipi, v_spreadorani,v_faizdegisimsiklik, v_faizdegisimsikliktipi,v_faizdegisimtarihi,v_minfaizorani,
           v_talepno, v_belgelimi, v_faiztipi, v_endekstarihi,
          v_faizdegisecek, v_blokeeh, v_bloketutar, v_alacakhesapdoviz, v_pesin_faiz_orani, v_schfaizoranimarjsiz, vn_temlik_musteri_no,
          v_pesin_faiz_tutari,vd_ortalama_vade, vd_taksit_baslangic_tarihi, vc_sigorta_sirketi, v_ekstre_basilsin, vn_alacak_yp_hesap_no,
          vn_erken_kapama_faiz_tutari, vn_erken_kapama_faiz_orani,
          vn_DEK_LEASING,vn_MAL_BEDELI,vn_KDV_ORAN,vn_KIRACIYA_SATIS_BEDELI,vd_SATIS_VADESI,vn_ODEMESIZ_SURE_DONEM,vn_ODEME_PERIYODU,
          vn_PESIN_TAKSIT_TUTARI,vn_SATICI_HESAP_NO,vn_DEK_URUN_NO
          FROM MUH_HESAP_KREDI_TX MHK
          WHERE MHK.TX_NO = pn_txno
          AND MHK.DURUM_KODU = 'W';



      v_hesapno := kredi_hesap_ac(v_modultur, v_uruntur, v_urunsinif, v_musterino, v_dovizkod, v_subekod,
                                            v_vadetarih, v_referans,v_faiztahakkukhesapno, v_musteridk, v_tutar, v_ekstre, v_iliskilihesap,
                                            v_teklifsatir, v_kullandirimkredi,v_endeksdoviz, v_kullandirimdoviz,
                                            v_songunfaizi, v_aciliskuru, v_faizorani, v_faizsiklik,v_faizsikliktipi,
                                            v_faizTahakkukTarih, v_komisyon, v_komisyontutar, v_komisyontahsilatdonemi,
                                            v_kkdforani, v_bsmvorani, v_alacakhesapno, v_kurfarki, v_sinirlamakodu,
                                            v_kaynakkodu, v_istatistikkodu, v_urungrupno,
                                            v_vergitahakkukhesapno, v_birikmisfaiztutari, v_birikmiskomisyontutar,
                                            v_esasgun, v_acilistarihi, v_endeksdoviztutari,v_schfaizorani,v_schfaizoranimarjsiz, v_odemeturu,
                                            v_taksitsayisi, v_taksitoncesonra, v_artissiklik, v_artisoran, v_araodemesiklik,
                                            v_araodemetutar,v_donemsiklik, v_schfaiztur, v_tahschfaiztutar, v_temdittarihi,
                                            v_repaymenttype, v_kkdfalinsin, v_bsmvalinsin,v_taahhutvadesi,v_belgeno,
                                            v_belgekodu, v_belgetarihi, v_basvuruno, v_yakinizleme, v_faizendeksturu, v_faizendekskodu, v_faizendeksperiod,
                                            v_faizendeksorani, v_spreadtipi, v_spreadorani, v_faizdegisimsiklik, v_faizdegisimsikliktipi, v_faizdegisimtarihi, v_minfaizorani,
                                            v_talepno, v_belgelimi, v_faiztipi, v_endekstarihi,
                                            v_faizdegisecek, pn_pesin_faiz_orani => v_pesin_faiz_orani, pn_temlik_musteri => vn_temlik_musteri_no,
                                            pn_pesin_faiz_tutari => v_pesin_faiz_tutari, pd_ortalama_vade => vd_ortalama_vade,
                                            pd_taksit_baslangic_tarihi => vd_taksit_baslangic_tarihi, pc_sigorta_sirketi => vc_sigorta_sirketi,
                                            pc_ekstre_basilsin => v_ekstre_basilsin, pn_alacak_yp_hesap_no => vn_alacak_yp_hesap_no,
                                            pn_erken_kapama_faiz_tutari => vn_erken_kapama_faiz_tutari, pn_erken_kapama_faiz_orani => vn_erken_kapama_faiz_orani,
                                            pn_DEK_LEASING => vn_DEK_LEASING,
                                            pn_MAL_BEDELI =>vn_MAL_BEDELI,
                                            pn_KDV_ORAN =>vn_KDV_ORAN,
                                            pn_KIRACIYA_SATIS_BEDELI =>vn_KIRACIYA_SATIS_BEDELI,
                                            pd_SATIS_VADESI =>vd_SATIS_VADESI,
                                            pn_ODEMESIZ_SURE_DONEM =>vn_ODEMESIZ_SURE_DONEM,
                                            pn_ODEME_PERIYODU =>vn_ODEME_PERIYODU,
                                            pn_PESIN_TAKSIT_TUTARI =>vn_PESIN_TAKSIT_TUTARI,
                                            pn_SATICI_HESAP_NO =>vn_SATICI_HESAP_NO,
                                            pn_DEK_URUN_NO =>  vn_DEK_URUN_NO
                                            );


         Pkg_Global.wMesaj :=' Kredi Hesap No:'||TO_CHAR(v_hesapNo);

       IF v_blokeeh IN ('E', 'K') THEN

          v_aciklama := 'Kredi kullandirim' || v_alacakhesapno || 'no.lu hesap';

          PKG_BLOKE.sp_bloke_yarat(l_bloke_ref,v_musterino, v_alacakhesapno,
                                   v_alacakhesapdoviz, v_bloketutar,
                                   5 ,--Kredi Kullandirim blokesi,
                                   v_aciklama,
                                   pkg_muhasebe.Banka_Tarihi_Bul);

       END IF;

          UPDATE MUH_HESAP_KREDI_TX mx
          SET hesap_no = v_hesapNo
          WHERE  tx_no = pn_txno ;

          UPDATE MUH_HESAP_KREDI_TAKSIT_TX TX
          SET hesap_no = v_hesapNo
          WHERE  tx_no = pn_txno ;

          UPDATE muh_hesap_kredi_cek_tablo_tx T
            SET T.hesap_no = v_hesapNo
           WHERE T.tx_no = pn_txno;

          UPDATE muh_hesap_kredi_fatura_tx T
            SET T.hesap_no = v_hesapNo
           WHERE T.tx_no = pn_txno;

          UPDATE KRE_KUL_TALEP KKT
          SET KKT.HESAP_NO = v_hesapNo,
              KKT.DRM = 'C'
          WHERE KKT.TALEP_NO = v_talepno;

     --- taksit tablosu
     DELETE MUH_HESAP_KREDI_TAKSIT
      WHERE TALEP_NO = v_talepno;

     FOR r_taksit IN c_taksit LOOP
       INSERT INTO MUH_HESAP_KREDI_TAKSIT
         (sira_no, talep_no, taksit, anapara, faiz, kkdf, bsmv, vade_tarih, kalan_anapara, tahsil_edilecek_taksit,
          hesap_no, durum_kodu, odeme_tarihi, gecikme_faizi_alinsin, gecikme_faiz_tutari, islem_tip_kod, taksit_secildi,
          kur, anapara_lc, faiz_lc, kkdf_lc, bsmv_lc, kalan_faiz,kdv)
        (SELECT vn_sira_no, talep_no, taksit, anapara, faiz, kkdf, bsmv, vade_tarih, kalan_anapara, tahsil_edilecek_taksit,
                     hesap_no, durum_kodu, odeme_tarihi, gecikme_faizi_alinsin, gecikme_faiz_tutari, islem_tip_kod, taksit_secildi,
                     kur, anapara_lc, faiz_lc, kkdf_lc, bsmv_lc, kalan_faiz,kdv
              FROM MUH_HESAP_KREDI_TAKSIT_TX MKT
              WHERE MKT.TX_NO = pn_txno
                AND mkt.sira_no = r_taksit.sira_no);

        INSERT INTO Muh_Hesap_Kredi_Taksit_Baz
         (hesap_no, sira_no, taksit, anapara, faiz, kkdf, bsmv, vade_tarih, kalan_anapara)
        (SELECT hesap_no, vn_sira_no, taksit, anapara, faiz, kkdf, bsmv, vade_tarih, kalan_anapara
              FROM MUH_HESAP_KREDI_TAKSIT_TX MKT
              WHERE MKT.TX_NO = pn_txno
                AND mkt.sira_no = r_taksit.sira_no);
         vn_sira_no := vn_sira_no + 1;
     END LOOP;

     -- cek tablosu
     DELETE muh_hesap_kredi_cek_tablo
      WHERE talep_no = v_talepno;

     vn_sira_no := 1;
     FOR r_cek IN c_cek LOOP
      INSERT INTO MUH_HESAP_KREDI_CEK_TABLO(talep_no, hesap_no, sira_no, faiz_orani, tutar, doviz_kodu,
              vade_tarihi,cek_tipi,pesin_faiz_tutari, cek_no, banka_kodu, sube_kodu, cek_hesap_no, tahsil_vadesi)
       (SELECT talep_no, hesap_no, vn_sira_no, faiz_orani, tutar, doviz_kodu,
               vade_tarihi,cek_tipi,pesin_faiz_tutari, cek_no, banka_kodu, sube_kodu, cek_hesap_no, tahsil_vadesi
         FROM MUH_HESAP_KREDI_CEK_TABLO_TX
         WHERE TX_NO = pn_txno
           AND sira_no = r_cek.sira_no);

       vn_sira_no := vn_sira_no + 1;
     END LOOP;


     -- fatura tablosu
     DELETE muh_hesap_kredi_fatura
      WHERE talep_no = v_talepno;

     vn_sira_no := 1;
     FOR r_fatura IN c_fatura LOOP
       INSERT INTO muh_hesap_kredi_fatura
        (talep_no, hesap_no, sira_no, faiz_orani, tutar, doviz_kodu, vade_tarihi, pesin_faiz_tutari,
         temlik_borclu_musteri_no, temlik_borclu_hesap_no,valor_tarihi,
         fatura_tutar, fatura_no,odeyen,fatura_tarihi, pesin_faiz_tutari_yp)
         SELECT talep_no, hesap_no, vn_sira_no, faiz_orani, tutar, doviz_kodu, vade_tarihi, pesin_faiz_tutari,
                temlik_borclu_musteri_no, temlik_borclu_hesap_no, valor_tarihi,
                fatura_tutar, fatura_no,odeyen,fatura_tarihi, pesin_faiz_tutari_yp
           FROM muh_hesap_kredi_fatura_tx
          WHERE tx_no = pn_txno
            AND sira_no = r_fatura.sira_no;
       vn_sira_no := vn_sira_no + 1;
     END LOOP;


  RETURN v_hesapno;
EXCEPTION WHEN No_data_found THEN NULL;
END;

 ------------------------------------------------------------------------------------------------------------------------------

  PROCEDURE faiz_kom_hesap_ac (pn_hesap_no NUMBER) IS
  ln_hesap_no      MUH_HESAP_KREDI.hesap_no%TYPE;
  v_faizhesapNo                     NUMBER;

  v_komhesapNo                     NUMBER;
  lc_urunTur            VARCHAR2(50);
  lc_urunSinifFaiz      VARCHAR2(50);
  lc_urunSinifKom       VARCHAR2(50);
  ln_faizhesaporan      NUMBER;
  ln_komhesaporan       NUMBER;

  CURSOR cursor_hesap IS
       SELECT
          Pkg_Kredi.modul_tur_kod modul_tur_kod,
          urun_tur_kod,
          urun_sinif_kod,
          hesap_no,
          MUSTERI_NO,
          DOVIZ_KODU,
          0  tutar,
          DURUM_KODU,
          SUBE_KODU,
          ILISKILI_HESAP_NO,
          KREDI_VADE,
          EXTRE_MASRAFI ,
          faiz_tahakkuk_hesap_no,
          KOM_TAHAKKUK_HESAP_NO,
          KREDI_TEKLIF_SATIR_NUMARA,
          faiz_orani,
          kredi_kullandirim_kodu,
          FAIZ_TAHAKKUK_TARIHI,
          FAIZ_Siklik_TIPI,
          endeks_doviz_kodu,
          acilis_kuru,
          Kullandirim_Doviz_Kodu,
          bsmv_alinsin,
          bsmv_orani,
          kkdf_alinsin,
          kkdf_orani,
          M.repayment_type,
          M.faiz_siklik,
          M.son_gun_faizi,
          M.sinirlama_kodu,
          M.kaynak_kodu,
          M.alacak_hesap_no
     FROM  MUH_HESAP_KREDI M
     WHERE hesap_no = pn_hesap_no ;



   BEGIN
   FOR cur_hesap IN cursor_hesap LOOP

     pkg_kredi.tahakkuk_urun_sinif_getir(cur_hesap.urun_tur_kod, cur_hesap.urun_sinif_kod,
                                         lc_urunTur, lc_urunSinifFaiz,lc_urunSinifKom);

     IF lc_urunSinifFaiz IS NOT NULL THEN
      ln_faizhesaporan := ROUND(cur_hesap.faiz_orani * (TemerrutOranKatSayi(NULL)), 2);
      v_faizhesapNo := PKG_KREDI.kredi_hesap_ac(cur_hesap.modul_tur_kod, lc_urunTur,
                                  lc_urunSinifFaiz, cur_hesap.musteri_no,
                                  cur_hesap.doviz_kodu, cur_hesap.sube_kodu, cur_hesap.kredi_vade,
                                  NULL, NULL, NULL, 0, 'E', cur_hesap.iliskili_hesap_no,
                                  cur_hesap.kredi_teklif_satir_numara, cur_hesap.kredi_kullandirim_kodu,
                                  cur_hesap.endeks_doviz_kodu,cur_hesap.Kullandirim_Doviz_Kodu,cur_hesap.son_gun_faizi,
                                  cur_hesap.acilis_kuru,
                                  ln_faizhesaporan, cur_hesap.faiz_siklik, cur_hesap.faiz_siklik_tipi,
                                  cur_hesap.faiz_tahakkuk_tarihi,
                                  p_bsmv_alinsin => cur_hesap.bsmv_alinsin, p_bsmv_orani => cur_hesap.bsmv_orani,
                                  p_kkdf_alinsin => cur_hesap.kkdf_alinsin, pn_kkdf_orani => cur_hesap.kkdf_orani,
                                  p_repayment_type => cur_hesap.repayment_type, p_sinirlama_kodu => cur_hesap.sinirlama_kodu,
                                  p_kaynak_kodu => cur_hesap.kaynak_kodu, p_alacak_hesap_no => cur_hesap.alacak_hesap_no
                                   );


      END IF;

      IF lc_urunSinifKom IS NOT NULL THEN
       ln_komhesaporan := ROUND(cur_hesap.faiz_orani * (TemerrutOranKatSayi(NULL)), 2);

       v_komhesapNo :=  Pkg_Kredi.kredi_hesap_ac ( cur_hesap.MODUL_TUR_kod,
                       lc_urunTur,
                       lc_urunSinifKom,
                       cur_hesap.MUSTERI_NO,
                       cur_hesap.DOVIZ_kodu,
                       cur_hesap.SUBE_KODU,
                       cur_hesap.KREDI_VADE,
                       NULL, --Referans
                       NULL,
                       NULL,  --musteri_dk_no
                       0 , --tutar
                       'E',--  extre_masrafi
                       cur_hesap.iliskili_hesap_no,
                       p_kredi_teklif_satir_numara => cur_hesap.KREDI_TEKLIF_SATIR_NUMARA,
                      p_kredi_kullandirim_kodu=>cur_hesap.kredi_kullandirim_kodu,
                      p_endeks_doviz_kodu =>cur_hesap.endeks_doviz_kodu,
                      p_kullandirim_doviz_kodu=>cur_hesap.kullandirim_doviz_kodu,
                      p_son_gun_faizi=>cur_hesap.son_gun_faizi,p_acilis_kuru=>cur_hesap.acilis_kuru,
                      p_faiz_orani=>ln_komhesaporan,
                      p_faiz_siklik=>cur_hesap.faiz_siklik, p_faiz_siklik_tipi=>cur_hesap.faiz_siklik_tipi,
                      p_faiz_tahakkuk_tarihi=>cur_hesap.faiz_tahakkuk_tarihi,
                      p_bsmv_alinsin => cur_hesap.bsmv_alinsin, p_bsmv_orani => cur_hesap.bsmv_orani,
                      p_kkdf_alinsin => cur_hesap.kkdf_alinsin, pn_kkdf_orani => cur_hesap.kkdf_orani,
                      p_repayment_type => cur_hesap.repayment_type,
                      p_sinirlama_kodu => cur_hesap.sinirlama_kodu,
                      p_kaynak_kodu => cur_hesap.kaynak_kodu, p_alacak_hesap_no => cur_hesap.alacak_hesap_no
                      ) ;
         END IF;

         ln_hesap_no :=cur_hesap.hesap_no;
  END LOOP;


/*    UPDATE MUH_HESAP_KREDI_TX mx
    SET faiz_tahakkuk_hesap_no = v_faizhesapNo,
      kom_tahakkuk_hesap_no =v_komhesapNo
    WHERE  tx_no = pn_txno ;

*/
    UPDATE MUH_HESAP_KREDI
    SET faiz_tahakkuk_hesap_no = v_faizhesapNo,
      kom_tahakkuk_hesap_no = v_komhesapNo
    WHERE hesap_no =ln_hesap_no ;

   END;


PROCEDURE tahakkuk_dk_tanimlimi(pc_sube_kodu  MUH_HESAP_KREDI.sube_kodu%TYPE,
                                 pc_doviz_kodu MUH_HESAP_KREDI.doviz_kodu%TYPE,
                                 pc_faiz_dk  OUT MUH_HP_BAKIYE.Hesap_No%TYPE,
                                 pc_vergi_dk OUT MUH_HP_BAKIYE.Hesap_No%TYPE) IS
  vn_ret          NUMBER;

 BEGIN
 -- DK hesap mevcut mu
  IF pc_doviz_kodu = Pkg_Genel_Pr.lc_al THEN
     vn_ret :=  Pkg_Parametre.AL ( 'FAIZ_TP', pc_faiz_dk );
     vn_ret :=  Pkg_Parametre.AL ( 'DIGER_TP', pc_vergi_dk );
  ELSE
     vn_ret :=  Pkg_Parametre.AL ( 'FAIZ_YP', pc_faiz_dk );
     vn_ret :=  Pkg_Parametre.AL ( 'DIGER_YP', pc_vergi_dk );
  END IF;

  PKG_KREDI.DK_MevcutMu_Kont (pc_sube_kodu, pc_faiz_dk, pc_doviz_kodu);
  PKG_KREDI.DK_MevcutMu_Kont (pc_sube_kodu, pc_vergi_dk, pc_doviz_kodu);
END;

----------------------------------------------------------------------------------------------------------------------------
FUNCTION FaizTahakkukTarihi_Bul
( pc_faizsiklikTipi                 VARCHAR2,
  pn_faizsiklik                     NUMBER,
  pd_tarih                          DATE ,   -- Acilisda kredi acilis tarihi, digerlerinde son tahakkuk tarihidir
  pn_secim                          NUMBER ) -- 1:Acilis , 2:Tahakkuk
RETURN DATE
IS
  ln_yenitarih                      DATE;
  vd_Tarih                          DATE;
  ln_gunozellik                     NUMBER;
  vn_eskiTarih                      DATE;
  vn_month                          VARCHAR2(5);
  vn_mod                            NUMBER;
  vn_sonuc                          NUMBER;
  pn_secimIn                        NUMBER;
  pd_tarihIn                        DATE;
BEGIN
  IF pd_tarih IS NULL THEN pkg_hata.hata_yaz ( 330 , TRUE, 'Tarih' ) ; END IF ;
  pn_secimIn := pn_secim;
  pd_tarihIn := pd_tarih;

  IF pd_tarih IS NOT NULL AND pc_faizsiklikTipi IN ('GN','AY','YIL','AS','DS','YS') THEN -- in that case
   LOOP
     IF pc_faizsiklikTipi IN ( 'GN' , 'AY' , 'YIL' ) THEN

        IF pc_faizsiklikTipi    = 'GN' THEN
           vd_Tarih :=  pd_tarihIn + pn_faizsiklik;
        ELSIF pc_faizsiklikTipi = 'AY' THEN
           vd_Tarih :=PKG_TARIH.ay_sonra(pd_tarihIn, pn_faizsiklik);
        ELSIF pc_faizsiklikTipi = 'YIL' THEN
           vd_Tarih := TO_DATE(TO_CHAR(pd_tarihIn,'DDMM') || (TO_NUMBER(TO_CHAR(pd_tarihIn, 'YYYY'))+pn_faizsiklik ),'DDMMYYYY');
        END IF;

        ln_gunozellik := PKG_TARIH.gun_ozellik ( vd_Tarih ); -- 1: Tatil gunu , 0: Is gunu

        IF ln_gunozellik = 1 THEN -- tatil gunu
           vd_Tarih := pkg_tarih.ileri_is_gunu(vd_Tarih);
        END IF;

        IF vd_tarih <= pd_tarihIn THEN
           vd_tarih := PKG_TARIH.tarihten_sonraki_isgunu(vd_Tarih);
           ln_gunozellik := PKG_TARIH.gun_ozellik ( vd_Tarih ); -- 1: Tatil gunu , 0: Is gunu

           IF ln_gunozellik = 1 THEN -- tatil gunu
              vd_Tarih := pkg_tarih.ileri_is_gunu(vd_Tarih);
           END IF;
        END IF ;
      ----
      ELSIF pc_faizsiklikTipi IN ( 'AS' , 'DS' , 'YS' ) THEN
      ----
        IF pc_faizsiklikTipi = 'AS' THEN
           IF pn_secimIn = 1 THEN
              vd_Tarih := Pkg_Tarih.ayin_son_is_gunu(pd_tarihIn);
           ELSE
              vd_Tarih := PKG_TARIH.ayin_son_is_gunu(ADD_MONTHS(pd_tarihIn,1));
           END IF ;
        ELSIF pc_faizsiklikTipi = 'DS' THEN
           vn_sonuc := ( 3 - MOD ( TO_NUMBER(TO_CHAR( pd_tarihIn,'MM')) ,3 ) );
           IF vn_sonuc = 3 THEN
             vn_sonuc := 0; --eyl��l ayinda vn_sonuc = 3 d��n��yor ama eyl��l sonu d��nmeliyim is��gs��
           END IF;
           IF pn_secimIn = 1 THEN
              vd_Tarih := Pkg_Tarih.ayin_son_is_gunu(ADD_MONTHS( pd_tarihIn ,vn_sonuc ) );
           ELSE
              vn_sonuc := vn_sonuc + 3;
              vd_Tarih := PKG_TARIH.ayin_son_is_gunu(ADD_MONTHS( pd_tarihIn, vn_sonuc ) );
           END IF ;

        ELSIF pc_faizsiklikTipi = 'YS' THEN
           IF pn_secimIn = 1 THEN
             vd_Tarih := PKG_TARIH.yilin_son_is_gunu( pd_tarihIn );
           ELSE
             vd_Tarih  := PKG_TARIH.yilin_son_is_gunu(ADD_MONTHS( pd_tarihIn , 1 ) );
           END IF;
        END IF ;
      END IF ;

      EXIT WHEN vd_Tarih >= pkg_muhasebe.Banka_Tarihi_Bul ;
      pn_secimIn := 2;
      pd_tarihIn := vd_tarih;
   END LOOP;
  END IF ;

  RETURN ( vd_Tarih ) ;
END;
----------------------------------------------------------------------------------------------------------------------------

FUNCTION FaizDegisimTarihi_Bul
( pc_faizDegisimSiklikTipi                 VARCHAR2,
  pn_faizDegisimSiklik                     NUMBER,
  pd_tarih                          DATE ,   -- Acilisda kredi acilis tarihi, digerlerinde son tahakkuk tarihidir
  pn_secim                          NUMBER ) -- 1:Acilis , 2:Tahakkuk
RETURN DATE
IS
  ln_yenitarih                      DATE;
  vd_Tarih                          DATE;
  ln_gunozellik                     NUMBER;
  vn_eskiTarih                      DATE;
  vn_month                          VARCHAR2(5);
  vn_mod                            NUMBER;
  vn_sonuc                          NUMBER;
  pn_secimIn                        NUMBER;
  pd_tarihIn                        DATE;
BEGIN
  IF pd_tarih IS NULL THEN pkg_hata.hata_yaz ( 330 , TRUE, 'Tarih' ) ; END IF ;
  pn_secimIn := pn_secim;
  pd_tarihIn := pd_tarih;

  IF pd_tarih IS NOT NULL AND pc_faizDegisimSiklikTipi IN ('GN','AY','YIL','AS','DS','YS') THEN -- in that case
   LOOP
     IF pc_faizDegisimSiklikTipi IN ( 'GN' , 'AY' , 'YIL' ) THEN

        IF pc_faizDegisimSiklikTipi    = 'GN' THEN
           vd_Tarih :=  pd_tarihIn + pn_faizDegisimSiklik;
        ELSIF pc_faizDegisimSiklikTipi = 'AY' THEN
           vd_Tarih :=PKG_TARIH.ay_sonra(pd_tarihIn, pn_faizDegisimSiklik);
        ELSIF pc_faizDegisimSiklikTipi = 'YIL' THEN
           vd_Tarih := TO_DATE(TO_CHAR(pd_tarihIn,'DDMM') || (TO_NUMBER(TO_CHAR(pd_tarihIn, 'YYYY'))+pn_faizDegisimSiklik ),'DDMMYYYY');
        END IF;

        ln_gunozellik := PKG_TARIH.gun_ozellik ( vd_Tarih ); -- 1: Tatil gunu , 0: Is gunu

        IF ln_gunozellik = 1 THEN -- tatil gunu
           vd_Tarih := pkg_tarih.ileri_is_gunu(vd_Tarih);
        END IF;

        IF vd_tarih <= pd_tarihIn THEN
           vd_tarih := PKG_TARIH.tarihten_sonraki_isgunu(vd_Tarih);
           ln_gunozellik := PKG_TARIH.gun_ozellik ( vd_Tarih ); -- 1: Tatil gunu , 0: Is gunu

           IF ln_gunozellik = 1 THEN -- tatil gunu
              vd_Tarih := pkg_tarih.ileri_is_gunu(vd_Tarih);
           END IF;
        END IF ;
      ----
      ELSIF pc_faizDegisimSiklikTipi IN ( 'AS' , 'DS' , 'YS' ) THEN
      ----
        IF pc_faizDegisimSiklikTipi = 'AS' THEN
           IF pn_secimIn = 1 THEN
              vd_Tarih := Pkg_Tarih.ayin_son_is_gunu(pd_tarihIn);
           ELSE
              vd_Tarih := PKG_TARIH.ayin_son_is_gunu(ADD_MONTHS(pd_tarihIn,1));
           END IF ;
        ELSIF pc_faizDegisimSiklikTipi = 'DS' THEN
           vn_sonuc := ( 3 - MOD ( TO_NUMBER(TO_CHAR( pd_tarihIn,'MM')) ,3 ) );
           IF vn_sonuc = 3 THEN
             vn_sonuc := 0; --eyl��l ayinda vn_sonuc = 3 d��n��yor ama eyl��l sonu d��nmeliyim is��gs��
           END IF;
           IF pn_secimIn = 1 THEN
              vd_Tarih := Pkg_Tarih.ayin_son_is_gunu(ADD_MONTHS( pd_tarihIn ,vn_sonuc ) );
           ELSE
              vn_sonuc := vn_sonuc + 3;
              vd_Tarih := PKG_TARIH.ayin_son_is_gunu(ADD_MONTHS( pd_tarihIn, vn_sonuc ) );
           END IF ;

        ELSIF pc_faizDegisimSiklikTipi = 'YS' THEN
           IF pn_secimIn = 1 THEN
             vd_Tarih := PKG_TARIH.yilin_son_is_gunu( pd_tarihIn );
           ELSE
             vd_Tarih  := PKG_TARIH.yilin_son_is_gunu(ADD_MONTHS( pd_tarihIn , 1 ) );
           END IF;
        END IF ;
      END IF ;

      EXIT WHEN vd_Tarih >= pkg_muhasebe.Banka_Tarihi_Bul ;
      pn_secimIn := 2;
      pd_tarihIn := vd_tarih;
   END LOOP;
  END IF ;

  RETURN ( vd_Tarih ) ;
END;
----------------------------------------------------------------------------------------------------------------------------

PROCEDURE hesap_kapa(pn_hesapNo NUMBER) IS
  vn_hesap_no NUMBER;
  vn_faiz_tah NUMBER;
  vn_kom_tah  NUMBER;
  vc_modul    muh_hesap_kredi.modul_tur_kod%TYPE;
  vc_urun     muh_hesap_kredi.urun_tur_kod%TYPE;

BEGIN

  BEGIN

    SELECT d.hesap_no, d.faiz_tahakkuk_hesap_no, d.kom_tahakkuk_hesap_no,
           d.modul_tur_kod, d.urun_tur_kod
      INTO vn_hesap_no, vn_faiz_tah, vn_kom_tah, vc_modul, vc_urun
      FROM muh_hesap_kredi d
     WHERE d.hesap_no = pn_hesapNo
        ;

    IF vc_modul = 'KREDI' AND vc_urun IN ('TAHAKKUK','PESIN-FAIZ') THEN
      SELECT d.hesap_no, d.faiz_tahakkuk_hesap_no, d.kom_tahakkuk_hesap_no
        INTO vn_hesap_no, vn_faiz_tah, vn_kom_tah
        FROM muh_hesap_kredi d
       WHERE d.faiz_tahakkuk_hesap_no = pn_hesapNo
          OR d.kom_tahakkuk_hesap_no = pn_hesapNo
          ;
    END IF;

  EXCEPTION WHEN no_data_found THEN
     Pkg_Hata.hata_yaz(201, TRUE, pn_hesapNo);

  END;

  IF Pkg_Hesap.HesapBakiyeAl(vn_hesap_no) <> 0  THEN
    Pkg_Hata.hata_yaz(534);
  END IF;

  IF vn_faiz_tah IS NOT NULL THEN
    IF Pkg_Hesap.HesapBakiyeAl(vn_faiz_tah) <> 0 THEN
      Pkg_Hata.hata_yaz(534);
    END IF;
  END IF;

  IF vn_kom_tah IS NOT NULL THEN
   IF Pkg_Hesap.HesapBakiyeAl(vn_kom_tah) <> 0 THEN
      Pkg_Hata.hata_yaz(534);
   END IF;
  END IF;

  UPDATE MUH_HESAP_KREDI MHK
     SET MHK.DURUM_KODU = 'K',
         MHK.KAPANIS_TARIHI = PKG_MUHASEBE.Banka_Tarihi_Bul
   WHERE MHK.HESAP_NO IN (vn_hesap_no, vn_faiz_tah, vn_kom_tah) ;

END;

PROCEDURE krediHesapTarihGuncelle(pn_hesapNo NUMBER, pd_date DATE) IS

    --vd_date    DATE;

BEGIN

    UPDATE MUH_HESAP_KREDI MHK
    SET MHK.KREDI_VADE = pd_date
    WHERE MHK.HESAP_NO = pn_hesapNo;

END;

PROCEDURE kreHesapAcilisTutarGuncelleme(pn_hesapNo NUMBER, pn_tutar NUMBER, pd_vade DATE) IS

   vn_eskibakiye   NUMBER;
   vn_yenibakiye   NUMBER;
BEGIN

    UPDATE MUH_HESAP_KREDI MHK
       SET MHK.TUTAR = pn_tutar,
           mhk.kredi_vade = pd_vade
    WHERE MHK.HESAP_NO = pn_hesapNo;

    EXCEPTION
    WHEN  OTHERS THEN
     pkg_hata.hata_yaz(5,TRUE,'PKG_KREDI.kreHesapAcilisTutarGuncelleme');

END;
/* asliK
PROCEDURE TekKrediTahakkuk(pn_hesapno NUMBER ) IS
  vn_faiz                           Number;
  vn_kom                            Number;
  vn_faizkkdf                       Number;
  vn_faizbsmv                       Number;
  vn_komkkdf                        Number;
  vn_kombsmv                        Number;
  vc_lc                             GNL_DOVIZ_KOD_PR.Kod%TYPE := pkg_genel_pr.lc_al;
  vc_dk_grup_kod                    gnl_muSTERi.Dk_Grup_Kod%TYPE;
  vc_faizgelirDK                    MUH_HP_TANIM.Hesap_No%TYPE;
  vc_komgelirDK                     MUH_HP_TANIM.Hesap_No%TYPE;
  vb_hata                           Boolean := FALSE;
  vn_istisna_faiz_bsmv              Number;
  vn_istisna_kom_bsmv               Number;
  vn_kur                            Number;
  vn_txno                           Number;

  vb_DEK                            Boolean;
  vn_kurfarki                       Number;
  vn_kurfarkiKKDF                   Number;
  vn_kurfarkiBSMV                   Number;

  vn_faiz_temerrut                  Number;
  vn_faiz_kkdf                      Number;
  vn_faiz_bsmv                      Number;
  vn_kom_temerrut                   Number;
  vn_kom_kkdf                       Number;
  vn_kom_bsmv                       Number;

  vn_islemkod                       NUMBER := 5230;
  vn_fis_numara                     NUMBER;

  CURSOR cur_kredi IS
    SELECT faiz_tahakkuk_hesap_no ,
           kom_tahakkuk_hesap_no,
           sube_kodu, doviz_kodu, musteri_dk_no,
           hesap_no, M.Faiz_Orani, M.Komisyon_Orani,
           M.Kkdf_Alinsin, M.Kkdf_Orani / 100 Kkdf_Orani,
           M.Bsmv_Alinsin, M.Bsmv_Orani / 100 Bsmv_Orani,
           NVL(birikmis_faiz_tutari_round,0)     birikmis_faiz,
           NVL(birikmis_komisyon_tutari_round,0) birikmis_kom,
           M.Endeks_Doviz_Tutari,
           acilis_kuru,
           faiz_siklik_tipi,
           faiz_siklik,
           faiz_tahakkuk_tarihi,
           kredi_vade, M.Acilis_Tarihi,
           Pkg_Musteri.hp_grup_kod(musteri_no) dk,
           modul_tur_kod, urun_tur_kod, urun_sinif_kod,
           endeks_doviz_kodu,
           istatistik_kodu, musteri_no,
           belge_no, belge_kodu,
           belge_tarihi, durum_kodu
      FROM MUH_HESAP_KREDI M
     WHERE M.Hesap_No = pn_hesapno
       AND durum_kodu = 'A'
--       AND faiz_tahakkuk_tarihi = Pkg_Muhasebe.banka_tarihi_bul
       AND modul_tur_kod = pkg_kredi.modul_tur_kod
       AND M.Urun_Tur_Kod NOT IN ( 'KMH', 'TAHAKKUK')
       AND pkg_genel_pr.NAKDI_EH(p_modul => M.Modul_Tur_Kod, p_urun => M.Urun_Tur_Kod, p_urun_sinif => M.Urun_Sinif_Kod) = 'E'
       AND pkg_kredi.KrediHesap_UrunUygunmu(pc_urun_tur_kod => M.Urun_Tur_Kod) = 'E'
       FOR UPDATE OF birikmis_faiz_tutari,
                     birikmis_komisyon_tutari,
                     birikmis_faiz_tutari_round,
                     birikmis_komisyon_tutari_round,
--                     gecenyil_faiz_tutari,
--                     gecenyil_komisyon_tutari,
                     birikmis_sch_faizi,
--                     gecenyil_sch_faizi,
                     faiz_tahakkuk_tarihi
       ORDER BY hesap_no  ;
----------------------------
  CURSOR cur_faizkom(cn_hesapno Number) IS
    SELECT M.Kkdf_Alinsin, M.Kkdf_Orani / 100 Kkdf_Orani, M.Bsmv_Alinsin, M.Bsmv_Orani / 100 Bsmv_Orani,
           NVL(birikmis_faiz_tutari_round,0) birikmis_faiz
      FROM MUH_HESAP_KREDI M
     WHERE durum_kodu = 'A'
       AND faiz_tahakkuk_tarihi = Pkg_Muhasebe.banka_tarihi_bul
       AND modul_tur_kod = pkg_kredi.modul_tur_kod
       AND M.Urun_Tur_Kod IN ('TAHAKKUK')
       AND hesap_no = cn_hesapno
       AND ( NVL(birikmis_faiz_tutari_round,0) != 0 Or NVL(birikmis_komisyon_tutari_round,0) != 0 )
       FOR UPDATE OF birikmis_faiz_tutari,
                     birikmis_komisyon_tutari,
                     birikmis_faiz_tutari_round,
                     birikmis_komisyon_tutari_round,
                     faiz_tahakkuk_tarihi
      ;

  BEGIN
  FOR Rec_Kredi In Cur_Kredi Loop
      vn_txno := Pkg_Batch.islem_yarat(vn_islemkod, Rec_Kredi.sube_kodu); --pkg_tx.islem_no_al;
      vn_faiz := 0;
      vn_kom  := 0;
      vn_faizkkdf := 0;
      vn_faizbsmv := 0;
      vn_komkkdf  := 0;
      vn_kombsmv  := 0;
      vb_hata     := FALSE;

      If Rec_Kredi.Endeks_Doviz_Kodu Is Not Null And Nvl(Rec_Kredi.Acilis_Kuru,0) != 0 Then--DEK
        vb_DEK := TRUE;
        vn_kur := pkg_kur.DOVIZ_CEVIR( Rec_kredi.Endeks_Doviz_Kodu, vc_lc, NULL, 1, 1, --Gise
                                       NULL, NULL, 'O','A');
        vn_faiz := pkg_kur.YUVARLA( Rec_kredi.Endeks_Doviz_Kodu, NVL(Rec_Kredi.Birikmis_Faiz * vn_kur ,0));
        vn_kom  := pkg_kur.YUVARLA( Rec_kredi.Endeks_Doviz_Kodu, NVL(Rec_Kredi.Birikmis_Kom * vn_kur ,0));
        vn_kurfarki := pkg_kur.YUVARLA( Rec_kredi.Endeks_Doviz_Kodu, NVL(Rec_Kredi.Birikmis_faiz * (vn_kur - Rec_Kredi.Acilis_Kuru) ,0));
        If vn_kurfarki != 0 Then
          If Rec_Kredi.Kkdf_Alinsin = 'E' And Rec_Kredi.Kkdf_Orani != 0 Then
            vn_kurfarkiKKDF := pkg_kur.YUVARLA( vc_lc, vn_kurfarki * Rec_Kredi.Kkdf_Orani);
          End If;
          If Rec_Kredi.Bsmv_Alinsin = 'E' And Rec_Kredi.Bsmv_Orani != 0 Then
            vn_kurfarkiBSMV := pkg_kur.YUVARLA( vc_lc, vn_kurfarki * Rec_Kredi.BSMV_Orani);
          End If;
        End If;
      Else
        vb_DEK  := FALSE;
        vn_faiz := NVL(Rec_Kredi.Birikmis_Faiz, 0);
        vn_kom  := NVL(Rec_Kredi.Birikmis_Kom ,0);
      End If;
      Begin
        If vn_faiz != 0 then
          If Rec_Kredi.Kkdf_Alinsin = 'E' And Rec_Kredi.Kkdf_Orani != 0 Then
            vn_faizkkdf:= Round( vn_faiz * Rec_Kredi.Kkdf_Orani ,2);
          End If;
          If Rec_Kredi.Bsmv_Alinsin = 'E' And Rec_Kredi.bsmv_Orani != 0 Then
            vn_faizbsmv:= Round( vn_faiz * Rec_Kredi.bsmv_Orani ,2);
          End If;
        End If;
        If vn_kom != 0 then
          If Rec_Kredi.Kkdf_Alinsin = 'E' And Rec_Kredi.Kkdf_Orani != 0 Then
            vn_komkkdf:= Round( vn_kom * Rec_Kredi.Kkdf_Orani ,2);
          End If;
          If Rec_Kredi.Bsmv_Alinsin = 'E' And Rec_Kredi.bsmv_Orani != 0 Then
            vn_kombsmv:= Round( vn_kom * Rec_Kredi.bsmv_Orani ,2);
          End If;
        End If;
        vc_dk_grup_kod := PKG_MUSTERI.hp_grup_kod(Rec_Kredi.Musteri_No);
        -------Faiz gelir DK BUL
        IF  vn_faiz != 0 THEN
           Pkg_Muhasebe.DK_BUL ( vc_dk_grup_kod, Rec_Kredi.Modul_Tur_Kod, Rec_Kredi.Urun_Tur_Kod, Rec_Kredi.Urun_Sinif_Kod,
                                 2, NULL, NULL, NULL, vc_faizgelirDK);
            IF vc_faizgelirDK IS NULL THEN
              vb_hata := TRUE;
              --Insert edilesi
            END IF;
        END IF;
        ------Kom gelir DK BUL
        IF vn_kom != 0 THEN
          Pkg_Muhasebe.DK_BUL ( vc_dk_grup_kod,Rec_Kredi.Modul_Tur_Kod, Rec_Kredi.Urun_Tur_Kod, Rec_Kredi.Urun_Sinif_Kod,
                                5, NULL, NULL, NULL, vc_komgelirDK );
            IF vc_komgelirDK IS NULL THEN
              vb_hata := TRUE;
              --Insert edilesi
            END IF;
        END IF;
      EXCEPTION
        WHEN OTHERS THEN
         vb_hata := TRUE;
      END;
      vn_faiz_temerrut := 0;
      vn_faiz_kkdf := 0;
      vn_faiz_bsmv := 0;
      vn_kom_temerrut := 0;
      vn_kom_kkdf := 0;
      vn_kom_bsmv := 0;
      ----FaizHesabinda birik. Birik faiz var ise
      For Rec_Faiz In cur_faizkom(Rec_Kredi.Faiz_Tahakkuk_Hesap_No) Loop
        vn_faiz_temerrut := Rec_Faiz.Birikmis_Faiz;
        If Rec_Faiz.Kkdf_Alinsin = 'E' And Nvl(Rec_Faiz.Kkdf_Orani,0) != 0 Then
          vn_faiz_kkdf := pkg_kur.YUVARLA(vc_lc, (vn_faiz_temerrut * Rec_Faiz.Kkdf_Orani ));
        End If;
        If Rec_Faiz.Bsmv_Alinsin = 'E' And Nvl(Rec_Faiz.Bsmv_Orani,0) != 0 Then
          vn_faiz_bsmv := pkg_kur.YUVARLA(vc_lc, (vn_faiz_temerrut * Rec_Faiz.Bsmv_Orani ));
        End IF;
         UPDATE MUH_HESAP_KREDI
            SET birikmis_faiz_tutari = 0,
                birikmis_faiz_tutari_round = 0,
                faiz_tahakkuk_tarihi = Pkg_Kredi.FaizTahakkukTarihi_Bul( pc_faizsiklikTipi => Rec_Kredi.Faiz_Siklik_Tipi,
                                                                         pn_faizsiklik     => Rec_Kredi.Faiz_Siklik,
                                                                         pn_tahakkuktarihi => Rec_Kredi.Faiz_Tahakkuk_Tarihi,
                                                                         pc_secim          => 2) --tahakkuk
          WHERE hesap_no = Rec_Kredi.Faiz_Tahakkuk_Hesap_No;
      End Loop;
      ----Kom Hesabinda birik. Birik faiz var ise
      For Rec_Kom In cur_faizkom(Rec_Kredi.Kom_Tahakkuk_Hesap_No) Loop
        vn_kom_temerrut := Rec_Kom.Birikmis_Faiz;
        If Rec_Kom.Kkdf_Alinsin = 'E' And Nvl(Rec_Kom.Kkdf_Orani,0) != 0 Then
          vn_kom_kkdf := pkg_kur.YUVARLA(vc_lc, (vn_kom_temerrut * Rec_Kom.Bsmv_Orani ));
        End If;
        If Rec_Kom.Bsmv_Alinsin = 'E' And Nvl(Rec_Kom.Bsmv_Orani,0) != 0 Then
          vn_kom_bsmv := pkg_kur.YUVARLA(vc_lc, (vn_kom_temerrut * Rec_Kom.Bsmv_Orani ));
        End IF;
         UPDATE MUH_HESAP_KREDI
            SET birikmis_faiz_tutari = 0,
                birikmis_faiz_tutari_round = 0,
                faiz_tahakkuk_tarihi = Pkg_Kredi.FaizTahakkukTarihi_Bul( pc_faizsiklikTipi => Rec_Kredi.Faiz_Siklik_Tipi,
                                                                         pn_faizsiklik     => Rec_Kredi.Faiz_Siklik,
                                                                         pn_tahakkuktarihi => Rec_Kredi.Faiz_Tahakkuk_Tarihi,
                                                                         pc_secim          => 2) --tahakkuk
          WHERE hesap_no = Rec_Kredi.Kom_Tahakkuk_Hesap_No;
      End Loop;
      IF Not vb_hata THEN
--fis kesmek i?in tabloyu doldur.
         INSERT INTO KRE_TAHAKKUK_TX
         ( tx_no, islem_tar, musteri_no, kredi_hesap_no, faiz_hesap_no,
           kom_hesap_no,  faiz_gelir_dk, kom_gelir_dk, doviz_kodu, tahakkuk_faiz,
           tahakkuk_faiz_kkdf, tahakkuk_faiz_bsmv, tahakkuk_komisyon, tahakkuk_kom_kkdf, tahakkuk_kom_bsmv, istatistik_kodu,
           kur,
           --faiz_temerrut, faiz_kkdf, faiz_bsmv, kom_temerrut, kom_kkdf, kom_bsmv,
           dek_kur_farki, dek_kurfark_kkdf, dek_kurfark_bsmv, modul_tur_kod, urun_tur_kod, urun_sinif_kod,
           faiz_orani, kom_orani)--, bakiye, endeks_bakiye)
         VALUES
         ( vn_txno, pkg_muhasebe.Banka_Tarihi_Bul, Rec_Kredi.Musteri_No, Rec_Kredi.Hesap_No, Rec_Kredi.Faiz_Tahakkuk_Hesap_No,
           Rec_Kredi.Kom_Tahakkuk_Hesap_No, vc_faizgelirDK, vc_komgelirDK, Rec_Kredi.Doviz_Kodu, vn_faiz,
           vn_faizkkdf, vn_faizbsmv, vn_kom, vn_komkkdf, vn_kombsmv, Rec_Kredi.Istatistik_Kodu,
           vn_kur,
           vn_kurfarki, vn_kurfarkiKKDF, vn_kurfarkiBSMV, Rec_Kredi.Modul_Tur_Kod, Rec_Kredi.Urun_Tur_Kod, Rec_Kredi.Urun_Sinif_Kod,
           Rec_Kredi.Faiz_Orani, Rec_Kredi.Komisyon_Orani)
          ;
         UPDATE MUH_HESAP_KREDI
            SET birikmis_faiz_tutari = 0,
                birikmis_komisyon_tutari = 0,
                birikmis_faiz_tutari_round = 0,
                birikmis_komisyon_tutari_round = 0,
                gecenyil_faiz_tutari = 0,
                gecenyil_komisyon_tutari = 0,
                birikmis_sch_faizi = 0,
                gecenyil_sch_faizi = 0,
                faiz_tahakkuk_tarihi = Pkg_Kredi.FaizTahakkukTarihi_Bul( pc_faizsiklikTipi => Rec_Kredi.Faiz_Siklik_Tipi,
                                                                         pn_faizsiklik     => Rec_Kredi.Faiz_Siklik,
                                                                         pn_tahakkuktarihi => Rec_Kredi.Faiz_Tahakkuk_Tarihi,
                                                                         pc_secim          => 2), --tahakkuk
                ays_birikmis_faiz_tutari_round =0,
                ays_birikmis_komisyon_tutari_r =0
          WHERE CURRENT OF cur_kredi;

           -- Muhasebelestirme kismi burda
          vn_fis_numara := pkg_muhasebe.fis_kes(
                                   p_ekran => 'KRETAH',
                                   p_islem_tanim_kod => vn_islemkod,
                                   p_islem_no        => vn_txno    ,
                                   p_islem_sube_kod  => Rec_Kredi.Sube_Kodu,
                                   p_gecerli_oldugu_tarih => PKG_MUHASEBE.Banka_Tarihi_Bul,
                                   balans_kontrol => FALSE);

          Pkg_Muhasebe.MUHASEBELESTIR(vn_fis_numara);
          -- islemin muhasebelesme numarasini at..
          Update KRE_TAHAKKUK_TX a
             Set a.fis_no = vn_fis_numara
           Where a.tx_no  = vn_txno
           ;

          IF Rec_kredi.Bsmv_Alinsin = 'E' THEN
            IF Rec_kredi.Endeks_Doviz_Kodu IS NOT NULL THEN
                IF NVL(Rec_kredi.Acilis_Kuru,0) = 0 THEN
                  vn_istisna_faiz_bsmv :=0;
                  vn_istisna_kom_bsmv :=0;
                ELSE
                  vn_istisna_faiz_bsmv:= Pkg_Kur.yuvarla( vc_lc,(( Rec_Kredi.Bsmv_Orani * Rec_Kredi.Birikmis_Faiz / Rec_Kredi.Acilis_Kuru * vn_kur )/ 100));
                  vn_istisna_kom_bsmv:=  Pkg_Kur.yuvarla( vc_lc,(( Rec_Kredi.Bsmv_Orani * Rec_Kredi.Birikmis_Kom / Rec_Kredi.Acilis_Kuru * vn_kur )/ 100));
                END IF;
            ELSE
              vn_kur := pkg_kur.DOVIZ_CEVIR( Rec_kredi.Doviz_Kodu, vc_lc, NULL, 1, 1, --Gise
                                             NULL, NULL, 'O','S');
              vn_istisna_faiz_bsmv:= Pkg_Kur.yuvarla( vc_lc,(( Rec_Kredi.Bsmv_Orani * Rec_Kredi.Birikmis_Faiz * vn_kur ) / 100));
              vn_istisna_kom_bsmv:=  Pkg_Kur.yuvarla( vc_lc,(( Rec_Kredi.Bsmv_Orani * Rec_Kredi.Birikmis_Kom * vn_kur ) / 100));

            END IF;

            IF NVL(vn_istisna_faiz_bsmv,0) <> 0 THEN
              Pkg_Vergi.VERGI_FON_MUSTERI_MUAFIYET_INS( Rec_Kredi.musteri_no, Rec_Kredi.belge_kodu, Rec_Kredi.belge_no, Rec_Kredi.belge_tarihi,
                                                        Rec_Kredi.Sube_Kodu, vn_istisna_faiz_bsmv, vn_txno, vn_islemkod);
            END IF;

            IF NVL(vn_istisna_kom_bsmv,0) <> 0 THEN
              Pkg_Vergi.VERGI_FON_MUSTERI_MUAFIYET_INS( Rec_Kredi.musteri_no, Rec_Kredi.belge_kodu, Rec_Kredi.belge_no, Rec_Kredi.belge_tarihi,
                                                        Rec_Kredi.Sube_Kodu, vn_istisna_kom_bsmv, vn_txno, vn_islemkod);
            END IF;

          END IF;
        --vergi dosya insert eklemeler
        IF Rec_Kredi.bsmv_alinsin = 'E'  THEN
          --DEK i?in d?zeltilecek asli
          IF vn_faiz <> 0 THEN
            Pkg_Vergi.Onay_Sonrasi( vn_txno, NULL, Rec_Kredi.Musteri_no, Pkg_Muhasebe.Banka_Tarihi_Bul, Rec_Kredi.Hesap_No, NULL,
                                    Rec_Kredi.bsmv_orani, Rec_Kredi.Doviz_Kodu, vn_kur, Rec_Kredi.Birikmis_Faiz,
                                    Round(Rec_Kredi.Birikmis_Faiz * vn_kur ,2 ), vn_faizbsmv, vn_islemkod,Rec_Kredi.Sube_Kodu, Rec_Kredi.Hesap_No,
                                    pkg_parametre.Deger_Al_K('G_BSMV'), NULL, Round(Rec_Kredi.Birikmis_Faiz * vn_kur ,2 ));
          END IF;

          IF NVL(Rec_Kredi.Birikmis_Kom,0) <> 0 THEN
            Pkg_Vergi.Onay_Sonrasi( vn_txno, NULL, Rec_Kredi.Musteri_no, Pkg_Muhasebe.Banka_Tarihi_Bul, Rec_Kredi.Hesap_No, NULL,
                                    Rec_Kredi.bsmv_Orani, Rec_Kredi.Doviz_Kodu, vn_kur, Rec_Kredi.Birikmis_Kom,
                                    Round(Rec_Kredi.Birikmis_Kom * vn_kur ,2 ), vn_faizbsmv, vn_islemkod,Rec_Kredi.Sube_Kodu, Rec_Kredi.Hesap_No,
                                    pkg_parametre.Deger_Al_K('G_BSMV'), NULL, Round(Rec_Kredi.Birikmis_Kom * vn_kur ,2 ));
          END IF;
        END IF;
     END IF;
   END LOOP;
END;*/
-------------------------------------------------------------
FUNCTION Get_Brk_Faiz_Valorlu(pn_hesapno NUMBER, pn_gunsayisi NUMBER, pc_tip VARCHAR2)
--(tip => F(faiz), K (kom), TF(faiz tem), TK(kom tem))
  RETURN NUMBER IS
CURSOR cur_hesap IS
SELECT B.Valorlu_Bakiye Valorlu_Bakiye,
       b.bakiye bakiye,
       NVL(K.Birikmis_Faiz_Tutari_Round,0) brk_faiz,
       NVL(K.Birikmis_Faiz_Tutari,0) brk_faiz_yp,
       NVL(K.Birikmis_Komisyon_Tutari_Round,0) brk_kom,
       NVL(K.Birikmis_Komisyon_Tutari,0) brk_kom_yp,
       K.Faiz_Orani, K.Komisyon_Orani, K.Esas_Gun_Sayisi, K.Faiz_Baslangic_Tarihi,
       K.Endeks_Doviz_Kodu, K.Acilis_Kuru, K.faiz_siklik_tipi
  FROM muh_hesap_kredi K, MUH_HESAP_BAKIYE B
 WHERE K.Hesap_No = B.Hesap_No
   AND K.Hesap_No = pn_hesapno
   AND K.Durum_Kodu = 'A'
;
CURSOR cur_faizkom IS
SELECT B.Valorlu_Bakiye Valorlu_Bakiye,b.bakiye bakiye, FK.Faiz_Orani, FK.Esas_Gun_Sayisi, B.Hesap_No,
       NVL(FK.Birikmis_Faiz_Tutari_Round,0) brk_tem, NVL(FK.Birikmis_Faiz_Tutari,0) brk_tem_yp,
       FK.faiz_baslangic_tarihi,
       K.Acilis_Kuru,K.Endeks_Doviz_Kodu, fk.acilis_kuru tahakkuk_acilis_kuru
  FROM muh_hesap_kredi K, MUH_HESAP_BAKIYE B, muh_hesap_kredi FK
 WHERE FK.Hesap_No = B.Hesap_No
   AND K.Hesap_No  = pn_hesapno
   AND ((pc_tip = 'TF' AND FK.Hesap_No = K.Faiz_Tahakkuk_Hesap_No) OR (pc_tip = 'TK' AND FK.Hesap_No = K.Kom_Tahakkuk_Hesap_No))
   AND FK.Durum_Kodu = 'A'
;
vn_temfaiz      NUMBER := 0;
vn_gunsayisi    NUMBER := 0;
vn_valor_bakiye NUMBER := 0;
vn_faiz         NUMBER := 0;
vn_kom          NUMBER := 0;
vd_bugun        DATE   := pkg_muhasebe.Banka_Tarihi_Bul;
vn_ret          NUMBER;
BEGIN
  IF pn_gunsayisi < 0 THEN
    vn_gunsayisi := 0;
  ELSE
    vn_gunsayisi := pn_gunsayisi;
  END IF;

  IF pc_tip IN ('F','K') THEN
    FOR rec_hesap IN cur_hesap LOOP
      IF pc_tip = 'F' AND rec_hesap.faiz_siklik_tipi = 'TT' THEN
         BEGIN
           SELECT DECODE(T.durum_kodu, 'ACIK', T.faiz, T.kalan_faiz)
              INTO vn_ret
              FROM muh_hesap_kredi_taksit T
             WHERE T.hesap_no = pn_hesapno
               AND T.sira_no IN (SELECT MIN(M.sira_no)
                                  FROM muh_hesap_kredi_taksit M
                                 WHERE M.hesap_no = T.hesap_no
                                   AND M.durum_kodu IN ('ACIK', 'KISMI'));
           EXCEPTION WHEN no_data_found THEN
             vn_ret := NULL;
         END;
         IF vn_ret IS NOT NULL THEN
           RETURN vn_ret;
         END IF;
      END IF;
      IF rec_hesap.faiz_baslangic_tarihi >= vd_bugun THEN
        vn_gunsayisi := vn_gunsayisi - ( rec_hesap.faiz_baslangic_tarihi - vd_bugun ) ;
      END IF;
      IF vn_gunsayisi < 0 THEN
         vn_gunsayisi := 0;
      END IF;
      IF Rec_hesap.Acilis_Kuru IS NOT NULL AND Rec_hesap.Endeks_Doviz_Kodu IS NOT NULL THEN --DEK
        vn_valor_bakiye := pkg_kur.YUVARLA( rec_hesap.Endeks_Doviz_Kodu,
                         ( NVL(Rec_hesap.Valorlu_Bakiye,0) + Gunluk_Valor_Bakiye_Fark(pn_hesapno)) / rec_hesap.acilis_kuru);
        vn_faiz := pkg_kur.YUVARLA(Rec_hesap.Endeks_Doviz_Kodu, Rec_hesap.Brk_Faiz_Yp);
        vn_kom  := pkg_kur.YUVARLA(Rec_hesap.Endeks_Doviz_Kodu, Rec_hesap.Brk_Kom_Yp);
      ELSE
        vn_valor_bakiye := NVL(Rec_hesap.Valorlu_Bakiye,0) + Gunluk_Valor_Bakiye_Fark(pn_hesapno);
    --   pkg_hata.hata_yaz(330,true,Rec_hesap.Valorlu_Bakiye);  
        vn_faiz := Rec_hesap.Brk_Faiz;
        vn_kom  := Rec_hesap.Brk_Kom;
      END IF;
      --  ayni gun acilan kredilerde gun sonu olmadigindan valorlu bakiye 0 oluyor o nedenle hesaplama icin normal bakiye alin��r
       -- ozgur arslan 
       ----HD-684
      IF (vn_valor_bakiye IS NULL OR vn_valor_bakiye=0) THEN
         vn_valor_bakiye:=rec_hesap.bakiye;
      END IF;

      IF pc_tip = 'F' THEN
        vn_ret := vn_faiz + ABS(NVL(ROUND(vn_gunsayisi * vn_valor_bakiye / rec_hesap.esas_gun_sayisi / 100 * rec_hesap.faiz_orani, 2) ,0));
      ELSE
        vn_ret := vn_kom + ABS(NVL(ROUND(vn_gunsayisi * vn_valor_bakiye / rec_hesap.esas_gun_sayisi / 100 * rec_hesap.komisyon_orani, 2),0));
      END IF;
      IF vn_ret < 0 THEN
        vn_ret := 0;
      END IF;
     -- log_at('OZGUR','F K son donen',vn_ret);
      RETURN vn_ret;
    END LOOP;
    --temerrut DEK 'ler degistiginde burasi da DEK gibi olmali
  ELSIF pc_tip IN ('TF', 'TK') THEN
    FOR rec_faizkom IN cur_faizkom LOOP
      IF rec_faizkom.faiz_baslangic_tarihi >= vd_bugun THEN
        vn_gunsayisi := vn_gunsayisi - ( rec_faizkom.faiz_baslangic_tarihi - vd_bugun );
      END IF;
      IF rec_faizkom.tahakkuk_acilis_kuru IS NOT NULL AND rec_faizkom.Endeks_Doviz_Kodu IS NOT NULL THEN --DEK
        vn_valor_bakiye := pkg_kur.YUVARLA( rec_faizkom.Endeks_Doviz_Kodu,
                         ( NVL(rec_faizkom.Valorlu_Bakiye,0) + Gunluk_Valor_Bakiye_Fark(Rec_faizkom.hesap_no)) / rec_faizkom.tahakkuk_acilis_kuru);
      
       --  ayni gun acilan kredilerde gun sonu olmadigindan valorlu bakiye 0 oluyor o nedenle hesaplama icin normal bakiye alin��r
       -- ozgur arslan  ----HD-684
      IF (vn_valor_bakiye IS NULL OR vn_valor_bakiye=0) THEN
         vn_valor_bakiye:=Rec_faizkom.bakiye;
      END IF;
 
       vn_temfaiz := pkg_kur.YUVARLA(rec_faizkom.Endeks_Doviz_Kodu, rec_faizkom.brk_tem_yp + ABS(NVL(ROUND(vn_gunsayisi * vn_valor_bakiye /rec_faizkom.esas_gun_sayisi / 100 * rec_faizkom.faiz_orani, 2),0)));
      ELSE
        vn_valor_bakiye := NVL(rec_faizkom.Valorlu_Bakiye,0) + Gunluk_Valor_Bakiye_Fark(Rec_faizkom.hesap_no);
       --  ayni gun acilan kredilerde gun sonu olmadigindan valorlu bakiye 0 oluyor o nedenle hesaplama icin normal bakiye alin��r
       -- ozgur arslan    
       IF (vn_valor_bakiye IS NULL OR vn_valor_bakiye=0) THEN
         vn_valor_bakiye:=Rec_faizkom.bakiye;
       END IF;
       ----HD-684
        vn_temfaiz := rec_faizkom.brk_tem + ABS(NVL(ROUND(vn_gunsayisi * vn_valor_bakiye /rec_faizkom.esas_gun_sayisi / 100 * rec_faizkom.faiz_orani, 2),0));
      END IF;
    END LOOP;
      IF vn_temfaiz < 0 THEN
        vn_temfaiz := 0;
      END IF;
   --   log_at('OZGUR','Tip TF FK',vn_temfaiz);
    RETURN vn_temfaiz;
  END IF;
  RETURN 0;
END;
-------------------------------------------------------------------------------
PROCEDURE hesap_tutar_guncelle (pn_hesapNo NUMBER , pn_tutar NUMBER ) IS
BEGIN
     UPDATE MUH_HESAP_KREDI MHK
        SET MHK.TUTAR = NVL ( pn_tutar , 0 )
      WHERE MHK.HESAP_NO = pn_hesapNo;

END;
----------------------------------------------------------------------------------
FUNCTION TemerrutOranKatSayi ( pn_krdturkod NUMBER) RETURN NUMBER IS
BEGIN
  RETURN 1.5;
END;
----------------------------------------------------------------------------------
FUNCTION Gunluk_Valor_Bakiye_Fark(pn_hesapNo NUMBER) RETURN NUMBER IS
 vc_hesap_no MUH_FIS_SATIR.Hesap_Numara%TYPE;
CURSOR Cur_Valor_Bakiye_Fark IS
SELECT SUM(satir_dv_tutar) tutar
  FROM V_MUH_FIS_SATIR_TUM T
 WHERE T.SATIR_HESAP_NUMARA = vc_hesap_no
   AND fis_tur = 'G'
   AND fis_muhasebelestigi_tarih IS NOT NULL
   AND satir_hesap_tur_kodu IN ('KR', 'VD', 'VS')
   AND ((TRUNC(fis_muhasebelestigi_tarih) = Pkg_Muhasebe.Banka_Tarihi_Bul AND
         TRUNC(satir_valor_tarihi) <= Pkg_Muhasebe.Banka_Tarihi_Bul) OR
        (TRUNC(fis_muhasebelestigi_tarih) < Pkg_Muhasebe.Banka_Tarihi_Bul) AND
         TRUNC(satir_valor_tarihi) = Pkg_Muhasebe.Banka_Tarihi_Bul)
   AND T.fis_islem_kod NOT IN (5302,5301)    --KMH aktarimlari alma
   ;

BEGIN
  vc_hesap_no := TO_CHAR(pn_hesapNo);
  FOR Rec_Valor_Bakiye_Fark IN Cur_Valor_Bakiye_Fark LOOP
    RETURN NVL(Rec_Valor_Bakiye_Fark.Tutar,0);
  END LOOP;
  RETURN 0;
END;

FUNCTION hesap_tutar_al(pn_hesapNo NUMBER ) RETURN NUMBER IS
 ln_hesap_tutar NUMBER;
BEGIN

     SELECT MHK.Tutar INTO ln_hesap_tutar FROM MUH_HESAP_KREDI MHK
     WHERE  MHK.Hesap_No = pn_hesapNo;

     RETURN ln_hesap_tutar;

EXCEPTION WHEN OTHERS THEN RETURN NULL;
END;
----------------------------------------------------------------------------------
PROCEDURE GeriValorluOranDegisiklik( pn_hesapno NUMBER, pn_yeniOranF NUMBER,pn_yeniOranK NUMBER, pd_valor DATE, pc_faizKom VARCHAR2 DEFAULT 'F',
                                     pn_birikmisFaiz OUT NUMBER,pn_birikmisKom OUT NUMBER) IS
--UPDATE yapmaz.
vd_onceki_faiz_tah_tar DATE;
CURSOR c_sonBirikmis IS
  SELECT A.Birikmis_Faiz, A.Birikmis_Kom,A.Tahakkuk_Tarih
    FROM KRE_ADAT A
   WHERE A.Hesap_No = pn_hesapno
     AND A.Tarih = pd_valor -1
     AND ( A.tarih > vd_onceki_faiz_tah_tar OR vd_onceki_faiz_tah_tar IS NULL)
  ;

CURSOR c_adat IS
  SELECT A.tarih, ABS(A.Valor_Bakiye) valor_bakiye, A.Faiz_Orani, A.Komisyon_Orani,
         A.Brk_Faiz_Tahsil_Tutari, A.Brk_Kom_Tahsil_Tutari,
         A.Birikmisfaiz_Arteksitutar, A.Birikmiskom_Arteksitutar
    FROM KRE_ADAT A
   WHERE A.Hesap_No = pn_hesapno
     AND A.Tarih >= pd_valor
     AND ( A.Tahakkuk_Tarih IS NULL OR A.Tahakkuk_Tarih > pd_valor )
  ORDER BY tarih --order ��ok ��nemli
;

vn_esas_gun_sayisi NUMBER;
vn_gunlukFaiz          NUMBER := 0;
vn_gunlukKom          NUMBER := 0;
vn_birikmisKom        NUMBER := 0;
vn_birikmisFaiz        NUMBER := 0;
vn_sonuc           NUMBER := 0;
BEGIN
  IF pn_hesapno IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_hesapno ', 'NULL');
  END IF;
  IF pc_faizKom = 'F' AND pn_yeniOranF IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_yeniOran ', 'NULL');
  END IF;
  IF pc_faizKom = 'K' AND pn_yeniOranK IS NULL THEN

    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_yeniOran ', 'NULL');
  END IF;
  
  IF pc_faizKom = 'FK' AND (pn_yeniOranK IS NULL OR pn_yeniOranF IS NULL) THEN

    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_yeniOran ', 'NULL');
  END IF;
  
  IF pd_valor IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', 'NULL');
  END IF;
  IF pc_faizKom IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', 'NULL');
  END IF;
  IF pc_faizKom NOT IN ('F','K','FK') THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', pc_faizKom);
  END IF;

  SELECT d.onc_faiz_tahakkuk_tarihi , esas_gun_sayisi
    INTO vd_onceki_faiz_tah_tar, vn_esas_gun_sayisi
    FROM muh_hesap_kredi d
   WHERE d.hesap_no = pn_hesapno;

  FOR r_sonBirikmis IN c_sonBirikmis LOOP
     IF pc_faizkom = 'F' THEN
       IF r_sonBirikmis.Tahakkuk_Tarih IS NULL THEN
           vn_birikmisFaiz := r_sonBirikmis.Birikmis_Faiz;
       ELSE
           vn_birikmisFaiz := 0;
       END IF;
    ELSIF pc_faizKom = 'K' THEN
       IF r_sonBirikmis.Tahakkuk_Tarih IS NULL THEN
          vn_birikmisKom := r_sonBirikmis.Birikmis_Kom;
        ELSE
           vn_birikmisKom := 0;
        END IF;
    ELSE    
       IF r_sonBirikmis.Tahakkuk_Tarih IS NULL THEN
           vn_birikmisFaiz := r_sonBirikmis.Birikmis_Faiz;
       ELSE
           vn_birikmisFaiz := 0;
       END IF;
       
       IF r_sonBirikmis.Tahakkuk_Tarih IS NULL THEN
          vn_birikmisKom := r_sonBirikmis.Birikmis_Kom;
        ELSE
           vn_birikmisKom := 0;
        END IF;
    END IF;
  END LOOP;
  FOR r_adat IN c_adat LOOP
    vn_gunlukFaiz   :=  r_adat.Valor_Bakiye * pn_yeniOranF / vn_esas_gun_sayisi / 100 ;
    vn_gunlukKom   :=  r_adat.Valor_Bakiye * pn_yeniOranK / vn_esas_gun_sayisi / 100 ;
    IF pc_faizKom = 'F' THEN
      vn_birikmisFaiz := NVL(vn_birikmisFaiz,0) + NVL(vn_gunlukFaiz,0) - NVL(r_adat.Brk_Faiz_Tahsil_Tutari,0) + NVL(r_adat.Birikmisfaiz_Arteksitutar,0) ;
         IF vn_birikmisFaiz < 0 THEN
           Pkg_Hata.hata_yaz(1664);
         END IF;
    ELSIF pc_faizKom = 'K' THEN
      vn_birikmisKom := NVL(vn_birikmisKom,0) + NVL(vn_gunlukKom,0) - NVL(r_adat.Brk_Kom_Tahsil_Tutari,0) + NVL(r_adat.Birikmiskom_Arteksitutar,0) ;
        IF vn_birikmisKom < 0 THEN
          Pkg_Hata.hata_yaz(1664);
        END IF;
    ELSE
       vn_birikmisFaiz := NVL(vn_birikmisFaiz,0) + NVL(vn_gunlukFaiz,0) - NVL(r_adat.Brk_Faiz_Tahsil_Tutari,0) + NVL(r_adat.Birikmisfaiz_Arteksitutar,0) ;
       vn_birikmisKom := NVL(vn_birikmisKom,0) + NVL(vn_gunlukKom,0) - NVL(r_adat.Brk_Kom_Tahsil_Tutari,0) + NVL(r_adat.Birikmiskom_Arteksitutar,0) ;
        IF vn_birikmisKom < 0 OR vn_birikmisFaiz < 0  THEN
          Pkg_Hata.hata_yaz(1664);
        END IF;
       
    END IF;
    
  END LOOP;
  pn_birikmisFaiz := vn_birikmisFaiz;
  pn_birikmisKom := vn_birikmisKom;
END;
----------------------------------------------------------------------------------
PROCEDURE GeriValorluOranDegisiklik_Upd( pn_hesapno NUMBER, pn_yeniOran NUMBER, pd_valor DATE, pc_faizKom VARCHAR2 DEFAULT 'F',
                                         pn_birikmis OUT NUMBER) IS
--KRE_ADAT UPDATE eder.
vd_onceki_faiz_tah_tar DATE;
CURSOR c_sonBirikmis IS
  SELECT A.Birikmis_Faiz, A.Birikmis_Kom
    FROM KRE_ADAT A
   WHERE A.Hesap_No = pn_hesapno
     AND A.Tarih = pd_valor -1
     AND ( A.tarih > vd_onceki_faiz_tah_tar OR vd_onceki_faiz_tah_tar IS NULL)
  ;

CURSOR c_adat IS
  SELECT A.tarih, ABS(A.Valor_Bakiye) valor_bakiye, A.Faiz_Orani, A.Komisyon_Orani,
         A.Brk_Faiz_Tahsil_Tutari, A.Brk_Kom_Tahsil_Tutari,
         A.Birikmisfaiz_Arteksitutar, A.Birikmiskom_Arteksitutar, ROWID
    FROM KRE_ADAT A
   WHERE A.Hesap_No = pn_hesapno
     AND A.Tarih >= pd_valor
     AND ( A.Tahakkuk_Tarih IS NULL OR A.Tahakkuk_Tarih > pd_valor )
  ORDER BY tarih --order ��ok ��nemli
;

vn_esas_gun_sayisi NUMBER;
vn_gunluk          NUMBER := 0;
vn_birikmis        NUMBER := 0;
vn_sonuc           NUMBER := 0;
BEGIN
  IF pn_hesapno IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_hesapno ', 'NULL');
  END IF;
  IF pn_yeniOran IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pn_yeniOran ', 'NULL');
  END IF;
  IF pd_valor IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', 'NULL');
  END IF;
  IF pc_faizKom IS NULL THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', 'NULL');
  END IF;
  IF pc_faizKom NOT IN ('F','K') THEN
    Pkg_Hata.hata_yaz(3, TRUE, 'PKG_KREDI.GeriValorluOranDegisiklik pd_valor ', pc_faizKom);
  END IF;

  SELECT d.onc_faiz_tahakkuk_tarihi , esas_gun_sayisi
    INTO vd_onceki_faiz_tah_tar, vn_esas_gun_sayisi
    FROM muh_hesap_kredi d
   WHERE d.hesap_no = pn_hesapno;

  FOR r_sonBirikmis IN c_sonBirikmis LOOP
     IF pc_faizkom = 'F' THEN
      vn_birikmis := r_sonBirikmis.Birikmis_Faiz;
    ELSE
      vn_birikmis := r_sonBirikmis.Birikmis_Kom;
    END IF;
  END LOOP;
  FOR r_adat IN c_adat LOOP
    vn_gunluk   := r_adat.Valor_Bakiye * pn_yeniOran / vn_esas_gun_sayisi / 100 ;
    IF pc_faizKom = 'F' THEN
      vn_birikmis := NVL(vn_birikmis,0) + NVL(vn_gunluk,0) - NVL(r_adat.Brk_Faiz_Tahsil_Tutari,0) + NVL(r_adat.Birikmisfaiz_Arteksitutar,0) ;
      UPDATE KRE_ADAT K
         SET K.Faiz_Orani   = pn_yeniOran,
             K.Gunluk_Faiz  = vn_gunluk,
             K.Birikmis_Faiz= vn_birikmis
       WHERE K.tarih        = r_adat.tarih
         AND K.hesap_no     = pn_hesapno
      ;
    ELSE
      vn_birikmis := NVL(vn_birikmis,0) + NVL(vn_gunluk,0) - NVL(r_adat.Brk_Kom_Tahsil_Tutari,0) + NVL(r_adat.Birikmiskom_Arteksitutar,0) ;
      UPDATE KRE_ADAT K
         SET K.Komisyon_Orani   = pn_yeniOran,
             K.Gunluk_Komisyon  = vn_gunluk,
             K.Birikmis_Kom     = vn_birikmis
       WHERE K.tarih        = r_adat.tarih
         AND K.hesap_no     = pn_hesapno
      ;
    END IF;
    IF vn_birikmis < 0 THEN
      Pkg_Hata.hata_yaz(1664);
    END IF;
  END LOOP;
  pn_birikmis := vn_birikmis;
END;
--------------------------------------------------------------------------------------------
FUNCTION Factoring_KrediMi( pc_urun_tur_kod   MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                            pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE ) RETURN VARCHAR2 IS
  BEGIN
     IF pc_urun_tur_kod IN ('FAKT ALC','FAKT.FAT.')  OR
        (pc_urun_tur_kod = 'KVACIK' AND pc_urun_sinif_kod IN ('IHR/OPS.SPOT(FAKT)YP','DEK OPS.SPOT(FAKT)TP')) OR
        (pc_urun_tur_kod = 'KVTEM.LI' AND pc_urun_sinif_kod IN ('DEK OPS.SPOT(FAKT)TP','IHR/OPS.SPOT(FAKT)YP')) THEN
       RETURN 'E';
    ELSE
       RETURN 'H';
    END IF;

    EXCEPTION
      WHEN OTHERS THEN RETURN 'H';
  END ;

 --------------------------------------------------------------------------------------------
FUNCTION Ihracat_KrediMi(pc_urun_tur_kod   MUH_HESAP_KREDI.Urun_Tur_Kod%TYPE,
                         pc_urun_sinif_kod MUH_HESAP_KREDI.Urun_Sinif_Kod%TYPE) RETURN VARCHAR2 IS
  BEGIN
    IF pc_urun_sinif_kod IN ('IHRACAT-TP', 'IHRACAT-YP',
                             'IHR/OPS.SPOT-TP', 'IHR/OPS.SPOT-YP',
                             'SPOT IHRACAT-TP', 'SPOT IHRACAT-YP',
                             'IHRACAT/ROTATIF-YP',
                             'ROTATIF IHRACAT-TP', 'ROTATIF IHRACAT-YP',
                             'IHR/OPS.SPOT(GC)YP', 'IHR/OPS.SPOT(FAKT)YP',
                             'IHRACATTAKSITLI-YP', 'IHRACATTAKSITLI-TP'
                             ) THEN
       RETURN 'E';
    ELSE
       RETURN 'H';
    END IF;

    EXCEPTION
      WHEN OTHERS THEN RETURN 'H';
  END ;

----------------------------------------------------------------------------------

FUNCTION devre_baslangic_tarihi(p_hangi_devre NUMBER DEFAULT 0) RETURN DATE IS
--p_hangi_devre: 0 ise i��inde bulunulan devre
--             (-1) ise ��nceki devre
--             (1) ise sonraki devre
-- (n) , (-n) seklinde b��y��k degerler de girilebilir.

d_tarih DATE;
n_donem NUMBER;
n_ay NUMBER;
n_yil NUMBER;

BEGIN
d_tarih:=ADD_MONTHS(pkg_muhasebe.Banka_Tarihi_Bul, p_hangi_devre*3);

n_yil :=TO_CHAR(d_tarih,'yyyy');
n_donem := FLOOR ( (TO_CHAR(d_tarih,'mm')-1) / 3)+1 ;
n_ay :=   (n_donem -1)*3 + 1; --donemin ilk ayi

RETURN pkg_tarih.Tatilse_ilk_isgunu_bul( TO_DATE('01'||LPAD(n_ay,2,'0')||n_yil,'ddmmyyyy'));

END;

----------------------------------------------------------------------------------

FUNCTION devre_bitis_tarihi(p_hangi_devre NUMBER DEFAULT 0) RETURN DATE IS
--p_hangi_devre: 0 ise i��inde bulunulan devre
--             (-1) ise ��nceki devre
--             (1) ise sonraki devre
-- (n) , (-n) seklinde b��y��k degerler de girilebilir.
BEGIN
  RETURN pkg_tarih.ayin_son_is_gunu( ADD_MONTHS( devre_baslangic_tarihi(p_hangi_devre),2));
END;

----------------------------------------------------------------------------------

PROCEDURE tahakkuk_urun_sinif_getir(pc_urun_tur VARCHAR2,
                                    pc_urun_sinif VARCHAR2,
                                    pc_alt_urun_tur OUT VARCHAR2,
                                    pc_urun_sinif_faiz OUT VARCHAR2,
                                    pc_urun_sinif_kom OUT VARCHAR2) IS

 CURSOR c_alt_hesap IS
   SELECT P.tahakkuk_urun_tur_kod, P.faiz_tahakkuk_urun_sinif, P.kom_tahakkuk_urun_sinif
     FROM gnl_urun_sinif_alt_hesap_pr P
    WHERE P.modul_tur_kod = pkg_kredi.modul_tur_kod
      AND P.urun_tur_kod = pc_urun_tur
      AND P.urun_sinif_kod = pc_urun_sinif
      ;
BEGIN

    OPEN c_alt_hesap;
    FETCH c_alt_hesap INTO pc_alt_urun_tur, pc_urun_sinif_faiz, pc_urun_sinif_kom;
    CLOSE c_alt_hesap;

END;

----------------------------------------------------------------------------------

FUNCTION Get_Brk_Faiz_Kom(pn_hesapno NUMBER, pn_anapara NUMBER, pn_gunsayisi NUMBER, pc_tip VARCHAR2)
--(tip => F(faiz), K (kom))
  RETURN NUMBER IS
CURSOR cur_hesap IS
SELECT K.Faiz_Orani, K.Komisyon_Orani, K.Esas_Gun_Sayisi,
       K.Endeks_Doviz_Kodu, K.Acilis_Kuru
  FROM muh_hesap_kredi K
 WHERE K.Hesap_No = pn_hesapno
;

vn_gunsayisi    NUMBER := 0;
vn_bakiye       NUMBER := 0;
vn_ret          NUMBER;
BEGIN
  IF pn_gunsayisi < 0 THEN
    vn_gunsayisi := 0;
  ELSE
    vn_gunsayisi := pn_gunsayisi;
  END IF;

  FOR rec_hesap IN cur_hesap LOOP

    IF Rec_hesap.Acilis_Kuru IS NOT NULL AND Rec_hesap.Endeks_Doviz_Kodu IS NOT NULL THEN --DEK
      vn_bakiye := pkg_kur.YUVARLA( rec_hesap.Endeks_Doviz_Kodu,
                       ( NVL(pn_anapara,0) ) / rec_hesap.acilis_kuru);
    ELSE
      vn_bakiye := NVL(pn_anapara,0);
    END IF;
    IF pc_tip = 'F' THEN
      vn_ret := ABS(NVL(ROUND(vn_gunsayisi * vn_bakiye / rec_hesap.esas_gun_sayisi / 100 * rec_hesap.faiz_orani, 2) ,0));
    ELSE
      vn_ret := ABS(NVL(ROUND(vn_gunsayisi * vn_bakiye / rec_hesap.esas_gun_sayisi / 100 * rec_hesap.komisyon_orani, 2),0));
    END IF;
    IF vn_ret < 0 THEN
      vn_ret := 0;
    END IF;
    RETURN vn_ret;
  END LOOP;


  RETURN 0;
END;

----------------------------------------------------------------------------------
FUNCTION pesin_faiz_tutar_hesapla(pn_tutar NUMBER, pn_faiz_orani NUMBER, pn_gun_sayisi NUMBER) RETURN NUMBER IS
BEGIN

   RETURN ABS(NVL(ROUND(pn_tutar / 360 / 100 * pn_faiz_orani * pn_gun_sayisi, 2),0));

END;
----------------------------------------------------------------------------------
FUNCTION get_iskonto_urun_grup RETURN NUMBER IS
BEGIN
  RETURN pkg_parametre.Deger_Al_K_N('ISKONTO_URUN_GRUBU');
END;
----------------------------------------------------------------------------------
FUNCTION get_faktoring_urun_grup RETURN NUMBER IS
BEGIN
  RETURN pkg_parametre.Deger_Al_K_N('FAKTORING_URUN_GRUBU');
END;
----------------------------------------------------------------------------------
PROCEDURE update_sonTXNO(pn_txno NUMBER, pn_hesap_no NUMBER) IS
 BEGIN
  UPDATE muh_hesap_kredi d
     SET d.son_txno = pn_txno
   WHERE d.hesap_no = pn_hesap_no;
 END;
----------------------------------------------------------------------------------
PROCEDURE hesap_acilis_gusin_kontrol(pn_grup_kod NUMBER, pc_modul_tur_kod VARCHAR2,
                                     pc_urun_tur_kod VARCHAR2, pc_urun_sinif_kod VARCHAR2) IS
 CURSOR c IS
  SELECT A.dk_faiz_gelir, A.dk_reeskont, A.dk_kom_gelir, A.dk_kom_reeskont,
         A.dk_ekhesap_7, A.dk_ekhesap_8, A.dk_ekhesap_9, A.dk_ekhesap_10, -- dek kur farki
         A.dk_ekhesap_11, A.dk_ekhesap_12, -- bireysel gecikme
         A.dk_ekhesap_13, -- bireysel katki payi reeskont
         P.nakdi, P.dek
      FROM GNL_DK_GRUP_URUN_SINIF_PR A, gnl_modul_urun_sinif_kod_pr P
     WHERE A.grup_kod = pn_grup_kod
       AND A.modul_tur_kod = pc_modul_tur_kod
       AND A.urun_tur_kod = pc_urun_tur_kod
       AND A.urun_sinif_kod = pc_urun_sinif_kod
       AND A.modul_tur_kod = P.modul_tur_kod
       AND A.urun_tur_kod = P.urun_tur_kod
       AND A.urun_sinif_kod = P.kod;

  CURSOR c_istisna IS
     SELECT 1
       FROM gnl_param_text T
      WHERE T.kod = 'KREDI_HESAP_ACILIS_KONTROL'
        AND T.key1 = pc_modul_tur_kod
        AND T.key2 = pc_urun_tur_kod
        AND NVL(T.key3, pc_urun_sinif_kod) = pc_urun_sinif_kod;

  vb_kont BOOLEAN := TRUE;

BEGIN
  FOR r_dk IN c LOOP
    vb_kont := TRUE;

    FOR rec IN c_istisna LOOP
      vb_kont := FALSE;
    END LOOP;

    IF vb_kont THEN
      IF pc_modul_tur_kod = pkg_kredi.modul_tur_kod AND r_dk.nakdi = 'E' THEN -- kurumsal ve nakdi
        IF Pkg_Parametre.DEGER(pc_modul_tur_kod, pc_urun_tur_kod, pc_urun_sinif_kod,'ISKONTO') = 'E' OR
            Pkg_Parametre.DEGER(pc_modul_tur_kod, pc_urun_tur_kod, pc_urun_sinif_kod,'FAKTORING') = 'E' OR
            pc_urun_tur_kod = 'PESIN-FAIZ'  THEN
          IF r_dk.dk_faiz_gelir IS NULL THEN
             pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod ||'-'|| pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Faiz Gelir');
          END IF;
        ELSE
          IF r_dk.dk_faiz_gelir IS NULL THEN
             pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod ||'-'|| pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Faiz Gelir');
          END IF;
          IF r_dk.dk_reeskont IS NULL THEN
             pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Reeskont');
          END IF;
          IF r_dk.dk_kom_gelir IS NULL THEN
             pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Komisyon Gelir');
          END IF;
          IF r_dk.dk_kom_reeskont IS NULL THEN
             pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Komisyon Reeskont');
          END IF;
          IF r_dk.dek = 'E' THEN
             IF r_dk.dk_ekhesap_7 IS NULL OR r_dk.dk_ekhesap_8 IS NULL OR
                r_dk.dk_ekhesap_9 IS NULL OR r_dk.dk_ekhesap_10 IS NULL THEN
                pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK DEK Kur Farki Reeskont');
             END IF;
          END IF;
        END IF;
      END IF;

      IF pc_modul_tur_kod = pkg_bireysel.modul_tur_kod THEN  -- bireysel
         IF r_dk.dk_ekhesap_11 IS NULL OR r_dk.dk_ekhesap_12 IS NULL THEN
            pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod,pn_grup_kod, 'DK Bireysel Gecikme Faiz Reeskont');
         END IF;
         IF r_dk.dk_ekhesap_13 IS NULL THEN
            pkg_hata.hata_yaz(2019, TRUE, pc_modul_tur_kod||'-'||pc_urun_tur_kod||'-'||pc_urun_sinif_kod, pn_grup_kod, 'DK Bireysel Katki Payi Reeskont');
         END IF;
      END IF;
    END IF;
  END LOOP;

END;
----------------------------------------------------------------------------------
 FUNCTION get_faiz_tahakkuk_tarihi(pn_hesap_no NUMBER) RETURN DATE IS
   vd_tarih DATE;
 BEGIN
   SELECT K.faiz_tahakkuk_tarihi
     INTO vd_tarih
     FROM muh_hesap_kredi K
    WHERE K.faiz_tahakkuk_hesap_no = pn_hesap_no
      OR K.kom_tahakkuk_hesap_no = pn_hesap_no ;
   RETURN vd_tarih;
 END;
----------------------------------------------------------------------------------
 FUNCTION vadeli_mustakriz_kontrol(pn_musteri_no NUMBER) RETURN NUMBER IS
 -- 1: bakiyesi var, 0: bakiyesi yok
   vn_kontrol NUMBER;
 BEGIN

   SELECT DISTINCT 1
    INTO vn_kontrol
    FROM Bnspr.Muh_Hesap_Vadeli P, Bnspr.Muh_Hesap_Bakiye b
   WHERE P.Hesap_No = b.Hesap_No
     AND P.Modul_Tur_Kod = 'VADELI'
     AND P.Urun_Tur_Kod IN ('MUSTAK-TP', 'MUSTAK-YP','ODEME-TP','ODEME-YP')
     AND P.musteri_no = pn_musteri_no
     AND b.Bakiye <> 0;

     RETURN vn_kontrol;

  EXCEPTION WHEN no_data_found THEN
    vn_kontrol := 0;
    RETURN vn_kontrol;
 END;
----------------------------------------------------------------------------------
FUNCTION vadeli_mustakriz_kontrol(pn_musteri_no NUMBER, pn_anapara_tutar NUMBER, pc_doviz VARCHAR2,
                                  pn_txno NUMBER) RETURN NUMBER IS
  vn_risk NUMBER;
  vn_vadeli_bakiye NUMBER;
  vn_anapara_tutar NUMBER;

BEGIN
  IF pkg_tx.Islem_tamamlanmis_mi(pn_txno) = 1 THEN

    SELECT l.lc_nakdi_risk
      INTO vn_risk
      FROM kre_musteri_limit l
     WHERE l.musteri_no = pn_musteri_no;

     SELECT NVL(SUM(NVL(DECODE(P.doviz_kodu, pkg_genel_pr.lc_al, bakiye,
        pkg_limit.kurdan_cevir(P.doviz_kodu, pkg_genel_pr.lc_al, bakiye)),0)),0)
      INTO vn_vadeli_bakiye
      FROM Bnspr.Muh_Hesap_Vadeli P, Bnspr.Muh_Hesap_Bakiye b
     WHERE P.Hesap_No = b.Hesap_No
       AND P.Modul_Tur_Kod = 'VADELI'
       AND P.Urun_Tur_Kod IN ('MUSTAK-TP', 'MUSTAK-YP','ODEME-TP','ODEME-YP')
       AND P.musteri_no = pn_musteri_no
       AND b.Bakiye <> 0;

     IF pc_doviz != pkg_genel_pr.lc_al THEN
       vn_anapara_tutar := NVL(pkg_limit.kurdan_cevir(pc_doviz, pkg_genel_pr.lc_al, pn_anapara_tutar),0);
     ELSE
       vn_anapara_tutar := NVL(pn_anapara_tutar,0);
     END IF ;

     vn_risk := vn_risk - vn_anapara_tutar;

     IF vn_vadeli_bakiye = 0 OR vn_vadeli_bakiye <= vn_risk THEN
       RETURN 0;
     ELSE
       RETURN 1; -- mesaj ver
     END IF;
   ELSE
     RETURN 0;
   END IF;
END;
----------------------------------------------------------------------------------
FUNCTION get_kullanim_thslt_bildirim(pn_musteri_no NUMBER,
                                     pn_hesap_no   NUMBER,
                                     pn_dilim_no   NUMBER,
                                     pn_sira_no    NUMBER) RETURN VARCHAR2 IS

  CURSOR c_kredi IS
    SELECT NVL(kt.anapara, 0) anapara, NVL(kt.faiz, 0) faiz
      FROM muh_hesap_kredi_taksit kt
     WHERE kt.hesap_no = pn_hesap_no
       AND kt.sira_no = pn_sira_no
       AND kt.durum_kodu IN ('ODENDI','KISMI');

  vn_anapara_txt VARCHAR2(500);
  vn_faiz_txt    VARCHAR2(500);

BEGIN
IF NVL(pn_hesap_no,0) <> 0 THEN --parametre bos gelme ihtimaline karsi
  FOR r_kredi IN c_kredi LOOP
    -- Eger anapara odemesi yapildiysa
    IF r_kredi.anapara > 0 THEN
      SELECT d.belge_no || ';' || pn_dilim_no || ';' ||
             1 || ';' || --alt_dilim_no
             6 || ';' || --islem_tipi_grubu Anapara Odemesi
             57 || ';' || --islem_tipi Anapara Odemesi
             1 || ';' || --kosul_sira_no
             T.sira_no || ';' ||
             1 || ';' || --odeme_sira_no
             T.odeme_tarihi || ';' || T.anapara || ';' ||
             d.doviz_kodu || ';' || d.doviz_kodu || ';' ||
             (SELECT COUNT(*)
                FROM muh_hesap_kredi_taksit mh
               WHERE mh.hesap_no = T.hesap_no) --taksit_sayisi
        INTO vn_anapara_txt
        FROM muh_hesap_kredi d, muh_hesap_kredi_taksit T
       WHERE d.hesap_no = T.hesap_no
         AND T.durum_kodu IN ('ODENDI','KISMI')
         AND d.hesap_no = pn_hesap_no
         AND T.sira_no = pn_sira_no;
    END IF;
    
    --eger faiz odemesi yapildiysa
    IF r_kredi.faiz > 0 THEN
      SELECT d.belge_no || ';' || pn_dilim_no || ';' ||
             1 || ';' || --alt_dilim_no
             5 || ';' || --islem_tipi_grubu Faiz Odemesi
             47 || ';' || -- islem_tipi Faiz Odemesi
             1 || ';' || --kosul_sira_no
             T.sira_no || ';' ||
             1 || ';' || --odeme_sira_no
             T.odeme_tarihi || ';' || T.faiz || ';' ||
             d.doviz_kodu || ';' || d.doviz_kodu || ';' ||
             (SELECT COUNT(*)
                FROM muh_hesap_kredi_taksit mh
               WHERE mh.hesap_no = T.hesap_no) --taksit_sayisi
        INTO vn_faiz_txt
        FROM muh_hesap_kredi d, muh_hesap_kredi_taksit T
       WHERE d.hesap_no = T.hesap_no
         AND T.durum_kodu IN ('ODENDI','KISMI')
         AND d.hesap_no = pn_hesap_no
         AND T.sira_no = pn_sira_no;
    END IF;

    IF vn_anapara_txt IS NOT NULL AND vn_faiz_txt IS NOT NULL THEN
    RETURN vn_anapara_txt || '\\*n\\*' || vn_faiz_txt; --graymound yeni satira gecsin diye 
    ELSIF vn_anapara_txt IS NOT NULL AND vn_faiz_txt IS NULL THEN
      RETURN vn_anapara_txt;
    ELSIF vn_anapara_txt IS NULL AND vn_faiz_txt IS NOT NULL THEN
      RETURN vn_faiz_txt;
    ELSE
      RETURN NULL;
    END IF;
  END LOOP;
    RETURN NULL;
ELSE
    RETURN NULL;
END IF;
END;
----------------------------------------------------------------------------------
END;
/
