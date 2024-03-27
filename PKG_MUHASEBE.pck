create or replace package PKG_MUHASEBE is

  -- Author  : ERSINL
  -- Created : 11.10.2007 09:52:42
  -- Purpose : Hareket yaratma ve bakiye update paketi
  TYPE varchar_array IS TABLE OF VARCHAR2(2000) INDEX BY BINARY_INTEGER;
  TYPE number_array  IS TABLE OF NUMBER         INDEX BY BINARY_INTEGER;
  TYPE date_array    IS TABLE OF DATE           INDEX BY BINARY_INTEGER;
  TYPE boolean_array IS TABLE OF BOOLEAN        INDEX BY BINARY_INTEGER;

--  Yardimci Fonksiyonlar 
    FUNCTION Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE ;
    FUNCTION Onceki_Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE ;
    FUNCTION Sonraki_Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE;
    FUNCTION Fis_No_Bul (pn_fis_numara NUMBER) RETURN NUMBER;
    FUNCTION Fis_Numara_AL RETURN NUMBER;
    FUNCTION Fis_No_Getir(pd_tarih in date default null)  RETURN NUMBER;
    Procedure P_Balans_kontrol ( dfis_no  in Number );
    PROCEDURE dk_bul     ( pn_gl_group_code     IN NUMBER
                          ,ps_modul_tur_kod     IN VARCHAR2
                          ,ps_urun_tur_kod      IN VARCHAR2
                          ,ps_urun_sinif_kod    IN VARCHAR2
                          ,pn_gl_index          IN NUMBER
                          ,pb_kosul_1           IN BOOLEAN
                          ,pb_kosul_2           IN BOOLEAN
                          ,pb_kosul_3           IN BOOLEAN
                          ,ps_gl_code           OUT VARCHAR2
                          ,pb_kosul_4           IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_5           IN BOOLEAN  DEFAULT NULL
                          ,pb_kosul_6           IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_7			      IN BOOLEAN	DEFAULT NULL
                          ,pb_kosul_8			      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_9		        IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_10		      IN BOOLEAN DEFAULT NULL
                          ,pn_islem_tanim_kod	  IN NUMBER DEFAULT 0
                          ,pb_kosul_11		      IN BOOLEAN	DEFAULT NULL
                          ,pb_kosul_12		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_13		      IN BOOLEAN	DEFAULT NULL
                          ,pb_kosul_14		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_15		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_16		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_17		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_18		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_19		      IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_20		      IN BOOLEAN DEFAULT NULL
                           ) ;
    FUNCTION dk_hesap_bul  ( pn_gl_group_code     IN NUMBER
                            ,ps_modul_tur_kod     IN VARCHAR2
                            ,ps_urun_tur_kod      IN VARCHAR2
                            ,ps_urun_sinif_kod    IN VARCHAR2
                            ,pn_gl_index          IN NUMBER
                            ) RETURN VARCHAR2;                           
    FUNCTION Efektif_Tarih_Duzelt(pfis_numara NUMBER,pefektif_banka_tarih DATE ) 
             RETURN NUMBER;
    
--  Muhasebelesme
    FUNCTION fis_kes(p_ekran                VARCHAR2,           -- Par muhdaki Tanim
                     p_islem_tanim_kod      NUMBER,             -- TXxxxx  numarasi
									   p_islem_no             IN NUMBER ,         -- islem tablosu Pkey
                     p_islem_sube_kod       IN VARCHAR2,        -- islem yapan Sube
									   p_gecerli_oldugu_tarih DATE DEFAULT NULL,  -- Fisin gecerlilik tarihi
									   balans_kontrol 		    BOOLEAN DEFAULT TRUE
								     ) RETURN NUMBER ;
    PROCEDURE  Muhasebelestir ( pfis_no   NUMBER , p_tarih   DATE DEFAULT NULL);  
    FUNCTION   Ters_fis_yarat (pn_islem_numara NUMBER,p_fis_numara MUH_FIS.numara%TYPE,
                               p_banka_tarihi  DATE DEFAULT NULL) RETURN NUMBER ;
    PROCEDURE fis_iptal       (p_fis_numara    MUH_FIS.numara%TYPE ,
                               p_banka_tarihi  DATE DEFAULT NULL );                               
    PROCEDURE Gecici_Fis_iptal(p_fis_numara MUH_FIS.numara%TYPE) ;                            
 ---------------------------
    Procedure Net_Fon_Bakiye_Sil(pn_hesapNo Number);
    Procedure Net_Fon_Bakiye_Upd(pn_hesapNo Number, pn_netFon_Bakiye Number,pn_Mevcut_Fon_Pay Number);
    Function Net_Fon_Bakiye_Al(pn_hesapNo Number) Return Number;
end PKG_MUHASEBE;
/
create or replace package body PKG_MUHASEBE is

 FUNCTION Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE IS
  Begin
     RETURN PKG_TABLO.sistem_bilgi(pKod).Banka_Tarihi;
  End;
--------
 FUNCTION Onceki_Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE IS
  Begin
     RETURN PKG_TABLO.sistem_bilgi(pKod).Onceki_Banka_Tarihi;
  End;
---------
 FUNCTION Sonraki_Banka_Tarihi_Bul (pKod in VARCHAR2 DEFAULT 'CLK') RETURN DATE IS
  Begin
     RETURN PKG_TABLO.sistem_bilgi(pKod).Sonraki_Banka_Tarihi;
  End;
---------
  Procedure P_Balans_kontrol ( dfis_no  in Number ) Is
   CURSOR c1 Is
     Select v.dv_tutar_alacak-v.dv_tutar_borc,v.doviz_kod
      From v_muh_fis_satir_sum v
     Where v.fis_numara = dfis_no
       and v.dv_tutar_alacak-v.dv_tutar_borc != 0
     ;

   cursor c_islem is
     select i.islem_kod
       from muh_islem i,muh_fis f
      where f.numara=dfis_no
        and f.islem_numara=i.numara;
    vn_islem_kod number;     
         
   ddov       number;
   dtl        number;
   ddoviz_kod varchar2(10);
  Begin
    /* evaluasyon fisi asagidaki anlamda her zaman balanssiz oldugu için onu dikkate almayan bir kosul ekledim 061109 */
    Open c_islem;
    Fetch c_islem into vn_islem_kod;
    close c_islem;
    if vn_islem_kod not in (5202,8001,8002) then   /* kapama acma fislerinde de mizan dibindeki kusurat fark yaratiyordu ekledim */
       Select SUM(DECODE(a.satir_tur,'B',a.satir_dv_tutar,a.satir_dv_tutar)) ddov ,
              SUM(DECODE(a.satir_tur,'B',a.satir_lc_tutar,a.satir_lc_tutar)) dtl
         INTO ddov,dtl
         FROM v_Muh_fis_satir a
        WHERE a.fis_numara = dfis_no
       ;
       If ROUND(ddov,2) != 0 Then
           PKG_HATA.hata_yaz(673,TRUE,ROUND(ddov,2));
       elsif ROUND(dtl,2) != 0 Then
           PKG_HATA.hata_yaz(674,TRUE,ROUND(dtl,2));
       End if;
       OPEN c1;
         FETCH c1 Into ddov,ddoviz_kod;
       CLOSE c1;
       if ddoviz_kod is not null Then
           PKG_HATA.hata_yaz(675,TRUE,ddoviz_kod,ddov);
       End if;         
    end if;   
  End; 
---------  
---------------- Muhasebe Fis Numaralari -----------------------------
----------
  FUNCTION Fis_No_Bul(pn_fis_numara NUMBER) RETURN NUMBER IS
    dfis_no NUMBER;
  BEGIN
        SELECT fis_no
         INTO dfis_no
         FROM MUH_FIS
        WHERE numara=pn_fis_numara
       ;
      RETURN dfis_no;
    Exception 
      When No_Data_Found Then
         RETURN Null;
  END;
-----------Sequence den Yeni fis Numarasi alir
  FUNCTION Fis_Numara_AL RETURN NUMBER IS
    p_fis_no NUMBER;
  BEGIN
    SELECT sq_Muh_Fis.NEXTVAL
       INTO p_fis_no
       FROM dual;
     RETURN p_fis_no;
  EXCEPTION
    WHEN OTHERS THEN
      PKG_HATA.Hata_yaz(200,TRUE); 
  END;  
-----------  Gunluk 1 den baslayan fis numarasi Uretmek için
  FUNCTION Fis_No_Getir(pd_tarih in date default null) RETURN NUMBER IS
       pmax_fis_no NUMBER;
  BEGIN
      if NVL(pd_tarih,Pkg_Muhasebe.BANKA_TARIHI_BUL) < pkg_muhasebe.Banka_Tarihi_Bul then
        /* Eger geri tarihli fis kesmek istiyorsak pd_tarih g?nderecegiz ki o g?n?n max?n? alabilelim */
          SELECT MAX(fis_no)
            INTO pmax_fis_no
            FROM MUH_FIS a
           WHERE a.muh_tarih = NVL(pd_tarih,Pkg_Muhasebe.BANKA_TARIHI_BUL)
           ;
           pmax_fis_no:=NVL(pmax_fis_no,0)+1;
      else
          pmax_fis_no := pkg_genel_pr.genel_kod_al_lock('GUNLUK_FIS_NO');
      end if;    
    
    RETURN pmax_fis_no;
      EXCEPTION
    WHEN OTHERS THEN
      RETURN -1;
  END;  
-----------------------------------------------------------------
----------- teller ve kanal bazinda Gunluk 1 den baslayan fis numarasi Uretmek için
  FUNCTION Fis_No_Getir_Yeni(pc_teller_no in varchar2,pc_kanal_numara in varchar2,pd_tarih in date default null) RETURN NUMBER IS
       pmax_fis_no NUMBER;
       pgecis_tar date;
       vc_kanal_numara varchar2(10):= NVL(pc_kanal_numara,'1');
  BEGIN
    if pkg_parametre.Deger_Al_K('FIS_NO_GECIS_TARIH') is not null then
       pgecis_tar := to_date(pkg_parametre.Deger_Al_K('FIS_NO_GECIS_TARIH'),'ddmmyyyy');
    else
       pgecis_tar := to_date('22/03/2013','dd/mm/yyyy');
    end if;
  if NVL(pd_tarih,Pkg_Muhasebe.BANKA_TARIHI_BUL) < pgecis_tar then
     /* eski usul getirmeye devam */
     Return Fis_No_Getir(pd_tarih);
  else
      if NVL(pd_tarih,Pkg_Muhasebe.BANKA_TARIHI_BUL) < pkg_muhasebe.Banka_Tarihi_Bul then
         /* geri tarihli fis kesiyoruz */
         UPDATE muh_gunluk_fis_no_log ff
                SET ff.sira_no=ff.sira_no + 1
              where ff.tarih = pd_tarih
                and ff.kanal_numara = vc_kanal_numara
                and ff.teller_no = pc_teller_no
          RETURNING sira_no INTO pmax_fis_no;
          IF sql%rowcount=0 THEN
            INSERT INTO muh_gunluk_fis_no_log
                       (tarih,kanal_numara,teller_no,sira_no)
                 VALUES (pd_tarih,vc_kanal_numara,pc_teller_no, 1);
              pmax_fis_no := 1;
          END IF;
      else
             UPDATE muh_gunluk_fis_no f
                SET f.sira_no=f.sira_no + 1
              where f.kanal_numara = vc_kanal_numara
                and f.teller_no = pc_teller_no
          RETURNING sira_no INTO pmax_fis_no;

          IF sql%rowcount=0 THEN
            INSERT INTO muh_gunluk_fis_no
                       (kanal_numara,teller_no,sira_no)
                 VALUES (vc_kanal_numara,pc_teller_no, 1);
              pmax_fis_no := 1;
          END IF;
      end if;  
      RETURN(pmax_fis_no);
  end if;    
  EXCEPTION
    WHEN OTHERS THEN
      RETURN -1;
  END;  
--------------------------------------------------------------------------------------
  FUNCTION Efektif_Tarih_Duzelt(pfis_numara NUMBER,pefektif_banka_tarih DATE ) RETURN NUMBER IS
    --  1 : Islem basarili Duzeltildi
    -- <0 : Basarisiz
  BEGIN
      UPDATE MUH_FIS
        SET  gecerlilik_tar = pefektif_banka_tarih
      WHERE numara = pfis_numara;
     RETURN 1;
    EXCEPTION
      WHEN OTHERS THEN
        RETURN -2081;

  END;
-----------------  
 PROCEDURE dk_bul        ( pn_gl_group_code     IN NUMBER
                          ,ps_modul_tur_kod     IN VARCHAR2
                          ,ps_urun_tur_kod      IN VARCHAR2
                          ,ps_urun_sinif_kod    IN VARCHAR2
                          ,pn_gl_index          IN NUMBER
                          ,pb_kosul_1       IN BOOLEAN
                          ,pb_kosul_2       IN BOOLEAN
                          ,pb_kosul_3       IN BOOLEAN
                          ,ps_gl_code      OUT VARCHAR2
                          ,pb_kosul_4       IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_5       IN BOOLEAN  DEFAULT NULL
                          ,pb_kosul_6       IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_7       IN BOOLEAN  DEFAULT NULL
                          ,pb_kosul_8       IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_9       IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_10     IN BOOLEAN DEFAULT NULL
                          ,pn_islem_tanim_kod   IN NUMBER DEFAULT 0
                          ,pb_kosul_11     IN BOOLEAN  DEFAULT NULL
                          ,pb_kosul_12     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_13     IN BOOLEAN  DEFAULT NULL
                          ,pb_kosul_14     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_15     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_16     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_17     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_18     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_19     IN BOOLEAN DEFAULT NULL
                          ,pb_kosul_20     IN BOOLEAN DEFAULT NULL
                           ) IS
BEGIN
      SELECT DECODE(pn_gl_index,
             1, a.dk_ana          ,2, a.dk_faiz_gelir, 3,a.dk_faiz_gider, 4,a.dk_reeskont,   5 ,a.dk_kom_gelir,
             6, a.dk_kom_reeskont ,7, a.dk_ekhesap_7,  8,a.dk_ekhesap_8,  9,a.dk_ekhesap_9,  10,a.dk_ekhesap_10,
             11,a.dk_ekhesap_11   ,12,a.dk_ekhesap_12,13,a.dk_ekhesap_13, 14,a.dk_ekhesap_14,15,a.dk_ekhesap_15,
             16,a.dk_ekhesap_16   ,17,a.dk_ekhesap_17,18,a.dk_ekhesap_18, 19,a.dk_ekhesap_19,20,a.dk_ekhesap_20)
          INTO ps_gl_code
          FROM GNL_DK_GRUP_URUN_SINIF_PR a
         WHERE modul_tur_kod  = ps_modul_tur_kod
           AND urun_tur_kod   = ps_urun_tur_kod
           AND urun_sinif_kod = ps_urun_sinif_kod
           AND grup_kod       = pn_gl_group_code
           ;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PKG_HATA.hata_yaz (228,TRUE,TO_CHAR(pn_gl_group_code),ps_modul_tur_kod,ps_urun_tur_kod,ps_urun_sinif_kod);
    WHEN OTHERS THEN
        PKG_HATA.hata_yaz (228,TRUE,SQLERRM);
END;
----------------------------------------------------------------------------------
FUNCTION dk_hesap_bul  ( pn_gl_group_code     IN NUMBER
                        ,ps_modul_tur_kod     IN VARCHAR2
                        ,ps_urun_tur_kod      IN VARCHAR2
                        ,ps_urun_sinif_kod    IN VARCHAR2
                        ,pn_gl_index          IN NUMBER
                        ) RETURN VARCHAR2 IS
                        
  ps_gl_code GNL_DK_GRUP_URUN_SINIF_PR.Dk_Ana%type;
  
BEGIN

    SELECT DECODE(pn_gl_index,
           1, a.dk_ana          ,2, a.dk_faiz_gelir, 3,a.dk_faiz_gider, 4,a.dk_reeskont,   5 ,a.dk_kom_gelir,
           6, a.dk_kom_reeskont ,7, a.dk_ekhesap_7,  8,a.dk_ekhesap_8,  9,a.dk_ekhesap_9,  10,a.dk_ekhesap_10,
           11,a.dk_ekhesap_11   ,12,a.dk_ekhesap_12,13,a.dk_ekhesap_13, 14,a.dk_ekhesap_14,15,a.dk_ekhesap_15,
           16,a.dk_ekhesap_16   ,17,a.dk_ekhesap_17,18,a.dk_ekhesap_18, 19,a.dk_ekhesap_19,20,a.dk_ekhesap_20 ) 
        INTO ps_gl_code
        FROM GNL_DK_GRUP_URUN_SINIF_PR a
       WHERE modul_tur_kod  = ps_modul_tur_kod
         AND urun_tur_kod   = ps_urun_tur_kod
         AND urun_sinif_kod = ps_urun_sinif_kod
         AND grup_kod       = pn_gl_group_code
         ;
      return ps_gl_code;
      
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        PKG_HATA.hata_yaz (228,TRUE,TO_CHAR(pn_gl_group_code),ps_modul_tur_kod,ps_urun_tur_kod,ps_urun_sinif_kod);
    WHEN OTHERS THEN
        PKG_HATA.hata_yaz (228,TRUE,SQLERRM);
END;
----------------------------------------------------------------------------------
------------------- FIS Kesme  ( fis ve satir tablolarina insert  ----------------
FUNCTION fis_kes ( p_ekran                VARCHAR2,           -- Par muhdaki Tanim
                   p_islem_tanim_kod      NUMBER,             -- TXxxxx  numarasi
                   p_islem_no             IN NUMBER ,         -- islem tablosu Pkey
                   p_islem_sube_kod       IN VARCHAR2,        -- islem yapan Sube
                   p_gecerli_oldugu_tarih DATE DEFAULT NULL,  -- Fisin gecerlilik tarihi
                   balans_kontrol         BOOLEAN DEFAULT TRUE
                 ) RETURN NUMBER IS

 dFis_no   Number;
Begin

 dFis_no :=  PKG_PAR_BOOK_AP.Fis_Yarat (p_ekran      , p_islem_no    , p_islem_sube_kod ,       
                                              PKG_GLOBAL.GET_KULLANICIKOD  , 
                                              p_gecerli_oldugu_tarih ) ;

--asli
--balans_kontrol herzaman olmali FALSE da gönderilse ben yapiyorum
--  If balans_kontrol Then  
    P_balans_kontrol(dFis_no); 
--  End if;
   
  update muh_islem t
    Set t.fis_numara = dfis_no
   Where t.numara = p_islem_no
   ;

  return dFis_no;
End;
----------------------------------------------------------------------------------
------  Muhabelelestirme kismi ----------------------------------
PROCEDURE  Muhasebelestir ( pfis_no   NUMBER ,            
                            p_tarih   DATE DEFAULT NULL
                           ) IS

vn_novaFis Number;
    CURSOR c0 IS
   select rownum satir_isleme_numara, h.* 
     from (
           SELECT A.*,
                DECODE(bakiye_karakteri, 'P', DECODE(b_a, 'A',1,2),DECODE(b_a, 'A',2,1) ) karakter,
                bakiye_karakteri b_karakter 
             FROM MUH_FIS_SATIR a , MUH_HESAP_BAKIYE hb
            WHERE a.fis_numara     In( pfis_no  , vn_novaFis)
              AND a.hesap_tur_kodu != 'DK'
              AND TO_NUMBER(a.hesap_numara)    = hb.hesap_no (+) 
        UNION
           SELECT b.*,DECODE(dh.BA_KOD,'A',DECODE(b.b_a, 'A',1,2),DECODE(b.b_a, 'A',2,1)) karakter,
                dh.BA_KOD b_karakter
             FROM MUH_FIS_SATIR b, V_MUH_HP_HESAP dh
            WHERE b.fis_numara     In( pfis_no  , vn_novaFis)
              AND b.hesap_tur_kodu  =  'DK'
              AND b.HESAP_NUMARA    =  dh.Hesap_No  (+)
              AND b.hesap_sube_kod  =  dh.Sube_Kod  (+)
              AND b.doviz_kod       =  dh.doviz_kod (+)
        ORDER BY 4,1,5 desc,6,karakter,2 -- hesap_bolum_kodu,fis_numara,hesap_numara,bakiye_karakteri -- 2 fis satir numarasi ekledim MHA 050708
        ) h;

    r_satir                      c0%ROWTYPE;

    CURSOR c1 IS
       SELECT f.numara
             ,f.islem_numara
             ,i.islem_kod
             ,NVL(i.kanal_numara,'1') as kanal
         FROM MUH_FIS f, MUH_ISLEM i
        WHERE f.islem_numara  = i.numara
         AND  f.numara        = pfis_no;

    Cursor C_Fon_iliski Is
      Select Distinct Hesap_No
        From Fon_Cati_Islem_Iliski_Pr F, MUH_FIS_SATIR S, MUH_ISLEM I, MUH_HESAP_TANIM H, MUH_FIS fis
       Where TO_CHAR(F.Cati_Hesap_No) = S.Hesap_Numara
         And F.Islem_Kodu             = I.Islem_Kod
         And I.Fis_Numara             = S.Fis_Numara
         And S.Fis_Numara             = pfis_no
         And H.Hesap_No               = F.Cati_Hesap_No
         And H.Otomatik_Fon           = 'E'
         And fis.numara               = s.fis_numara
         And I.NUMARA                 = fis.islem_numara
      ;
    p_muh_tarih                  MUH_FIS.Muh_Tarih%TYPE;
    p_gecerli_oldugu_tarih       MUH_FIS.Muh_Tarih%TYPE;
    p_islem_numara               MUH_FIS.islem_numara%TYPE;
    p_islem_kod                  muh_islem.islem_kod%TYPE;
    p_max_fis_no                 MUH_FIS.fis_no%TYPE;        -- max fis no'yu tutmakta kullanildi
    p2_tarih                     DATE;
    p_fis_numara                 MUH_FIS.numara%TYPE;
    p_kanal_numara               muh_islem.kanal_numara%TYPE;
    p_teller_no                  varchar2(20);
    p_banka_tarihi               DATE;
    p_sonraki_banka_tarihi       DATE;
    p_eod                        GNL_SISTEM_BILGI_PR.end_of_day%TYPE;

    p_kayit_kullanici_kodu       MUH_ISLEM.kayit_kullanici_kodu%TYPE;
    p_kayit_kullanici_rol_numara MUH_ISLEM.kayit_kullanici_rol_numara%TYPE;
    p_kayit_kullanici_bolum_kodu MUH_ISLEM.kayit_kullanici_bolum_kodu%TYPE;
    p_yaratildigi_tarih          MUH_FIS.yarat_tar%TYPE;
    vn_tx_code                   NUMBER;
    ln_eod_lc_tutar              number;
    ln_eod_fc_tutar              number;
    l_initial_bakiye             number;
    ln_bloke_tutari              number;
    l_last_bakiye                number;
    bakiye_yetersiz_exception    exception;
    bakiye_negatif_olamaz        exception;
    bakiye_pozitif_olamaz        exception;
    kapali_hesap_hareket_yaratma exception;
    hesap_bulunamadi_exception   exception;
      Borc_hareket_girilemez         EXCEPTION;
      Alacak_hareket_girilemez       EXCEPTION;
      hareket_girilemez              EXCEPTION;
    ls_durum_kodu                varchar2(1);
    ln_destek                    number;
    ln_temp                      number;
    ln_hareket_sonrasi_bakiye    number;
    vn_top_har_tutar             Number;
    vn_oto_fon_tutar             Number;
    vn_net_fon_bakiye            Number;
    vn_mevcut_fon_pay            Number;
    vn_kmh_eksi_bakiye_toplam    Number := 0;
    ln_islem_kod                 Number;
    ln_islem_numara              Number;
    cursor hesap_cursor (p_hesapno number) is
       select nvl(b.bakiye,0) bakiye, nvl(b.bloke_tutari,0) bloke, B.Net_Fon_Bakiye, B.Mevcut_Fon_Pay
         from muh_hesap_bakiye b
        where b.hesap_no=p_hesapno for update;

    cursor hesap_acikmi (p_hesap_no number) is
       select h.durum_kodu, pkg_kmh.kmh_limit_al_vadeli(p_hesap_no)  --bilalg   --nvl(destek_hesap_limiti,0)
         from v_muh_hesap_izleme_tum h
        where h.hesap_no = p_hesap_no;
        
     son_bakiye number;
     vn_har_top    number;   
     vn_har_adet    number;   
     hesap_numara varchar2(9);
     vc_sqlErr varchar2(1000 char);
     vb_fonAlimSatim boolean := false;
     
     cursor c_fon_satim(pn_islemNo number) is
     select * 
       from fon_alim_satim_tx t
      where t.yaratan_txno = pn_islemNo;
      
      vn_tarih_set number;
      vn_eod_tutar_initial number;
      vc_sim_hesap_no      varchar2(20);
      vd_rec_date date;
      vc_batch_kontrol       varchar2(10);
      vn_fis_lc_once         number;
      vn_fis_fc_once         number;
      vn_hareket_kodu        NUMBER;
      vn_musteri_no          Number;
      vn_kmh_kredi_bakiye    Number;
      vn_hesaptaki_bloke_adet Number;
  BEGIN

    if  pfis_no is Null then return; end if;
    
    p_banka_tarihi         :=  Banka_Tarihi_Bul;
    p_sonraki_banka_tarihi :=  Sonraki_Banka_Tarihi_Bul;
    IF p_tarih IS NULL THEN
      p2_tarih:=p_banka_tarihi;
    ELSE
      p2_tarih:=p_tarih;
    END IF;

    BEGIN
      SELECT  f.gecerlilik_tar             ,f.Muh_Tarih                   ,f.yarat_tar
             ,f.islem_numara               ,i.kayit_kullanici_kodu        ,i.kayit_kullanici_rol_numara
             ,i.kayit_kullanici_bolum_kodu ,i.islem_kod
        INTO  p_gecerli_oldugu_tarih       ,p_Muh_Tarih                   ,p_yaratildigi_tarih
             ,p_islem_numara               ,p_kayit_kullanici_kodu        ,p_kayit_kullanici_rol_numara
             ,p_kayit_kullanici_bolum_kodu ,vn_tx_code
        FROM MUH_FIS f, MUH_ISLEM i
       WHERE f.numara = pfis_no
         AND i.numara = f.islem_numara;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
                PKG_HATA.hata_yaz(211,TRUE,SQLERRM);
       WHEN OTHERS THEN
                PKG_HATA.hata_yaz(210,TRUE,SQLERRM);
    END;
    --
    if NVL(pkg_parametre.Deger_Al_K('BATCH_MUHASEBE_DEVREDEMI'),'H')='E' then
       vc_batch_kontrol := pkg_parametre.ParamTextDegerVarMi('BATCH_MUHASEBE_ISLEM',vn_tx_code);
    else
       vc_batch_kontrol := 'H';
    end if;   

    if p_kayit_kullanici_bolum_kodu <> '999' then
      begin
         select eod_muhasebe
           into p_eod
           from gnl_sistem_bilgi_pr;
      exception
        when others then
                PKG_HATA.hata_yaz(212,TRUE,SQLERRM);
      end;
    else  
       p_eod := 'H';
    end if;
    
    IF p_Muh_Tarih IS NOT NULL THEN
      select count(*)
        into ln_temp
        from muh_eod_fis_no
       where fis_numara = pfis_no
      ;
        if nvl(ln_temp,0) = 0 then
            PKG_HATA.hata_yaz(209,TRUE); 
        end if;
    END IF;
    
    IF TO_CHAR(p_gecerli_oldugu_tarih,'YYYYMMDD') > TO_CHAR(p2_tarih,'YYYYMMDD') THEN
            PKG_HATA.hata_yaz(208,FALSE); 
    END IF;
-------------------------
--otomatik fon parçasi     AsliK 03/10
    For rec_sim In C_Fon_iliski Loop
      vn_top_har_tutar := 0;
      vn_oto_fon_tutar := 0;
      vc_sim_hesap_no  := to_chaR(rec_sim.Hesap_No);
        SELECT NVL(SUM(DECODE( A.b_a,'B',-1,1) * A.Dv_Tutar),0) 
          Into vn_top_har_tutar 
          FROM MUH_FIS_SATIR a
         WHERE a.fis_numara     = pfis_no  
           AND a.hesap_tur_kodu != 'DK'
           AND a.hesap_numara    = vc_sim_hesap_no;
      If vn_top_har_tutar < 0 Then

       if p_eod = 'E' then  -- Initial EOD Bakiyelerini bulalim 13042015 MHA 
          SELECT /*+ INDEX(S PK_MUH_HAREKET_SATIR) */ SUM( DECODE(s.b_a,'A', NVL(dv_tutar,0), -1 * NVL(dv_tutar,0)))
            INTO vn_eod_tutar_initial
            FROM MUH_FIS_SATIR s, MUH_EOD_FIS_NO ef
           WHERE s.fis_numara   = ef.fis_numara
             AND ef.durum       = 'A'
             AND s.hesap_numara = vc_sim_hesap_no
             AND s.hesap_tur_kodu <> 'DK'
             and s.fis_numara!=pfis_no;
        end if;
        For rec_hesap_cursor In hesap_cursor ( rec_sim.Hesap_No ) Loop
          vn_oto_fon_tutar := rec_hesap_cursor.bakiye +NVL(vn_eod_tutar_initial,0) - rec_hesap_cursor.bloke + vn_top_har_tutar;
          If vn_oto_fon_tutar < 0 And rec_hesap_cursor.Net_Fon_Bakiye > 0 Then
            If abs(vn_oto_fon_tutar) <=rec_hesap_cursor.Net_Fon_Bakiye Then
              Pkg_Trn2107.OTO_Fon_AlSat_Baslat ( rec_sim.Hesap_No, 'A', 1, Pkg_Parametre.Deger_Al_K('CATI_FON_KODU'), abs(vn_oto_fon_tutar),
                                                 p_islem_numara, vn_novaFis, null, 'E');
            Else --tutar gönderilmeyecek, tutari fon pay adedinden NOVA hesaplayacak.
              Pkg_Trn2107.OTO_Fon_AlSat_Baslat ( rec_sim.Hesap_No, 'A', 1, Pkg_Parametre.Deger_Al_K('CATI_FON_KODU'), rec_hesap_cursor.Net_Fon_Bakiye,
                                                 p_islem_numara, vn_novaFis, null, 'E');
            End If;
            vb_fonAlimSatim := true;
          End If;
        End Loop;
      End If;
    End Loop;
----------------------------------    
    --
    if p_eod = 'E' then  -- Gunsonunda Bakiyeleri Update etme fisleri burda sakla
      if vb_fonAlimSatim then
         /* saat ayarı yapmamız lazım MHA 13042015 */ 
        begin   
           select rec_date 
             into vd_rec_date
             from FON_ALIM_SATIM_ISLEM_DETAY f
            where f.yaratan_txno = p_islem_numara;
        exception when no_data_found then
           vd_rec_date := sysdate;
        end;    
          vd_rec_date := vd_rec_date + 1/86400;
      else
          vd_rec_date := sysdate;
      end if;         
      insert into Muh_eod_fis_no(fis_numara, fis_tarih, durum, rec_owner, rec_date)
                         values (pfis_no, p_tarih, 'A', user, vd_rec_date);
    end if;
    
    --
    --
    Pkg_Limit.Limit_Kontrol(pfis_no, FALSE, p_eod);
    --                                 

    OPEN c0;
    LOOP
      FETCH c0 INTO r_satir;  

      EXIT WHEN c0%NOTFOUND;
    -- Sube Musteri hesap doviz uyumlu mu?  - ERSIN   21.04.2008
      If r_satir.hesap_tur_kodu != 'DK'  Then
        PKG_HESAP.Customer_Account_Control(r_satir.hesap_Sube_kod, 
                                           PKG_HESAP.musteri_no(r_satir.musteri_hesap_numara),
                                           r_satir.hesap_numara,
                                           r_satir.doviz_kod);
      End If;        
      if p_eod = 'E' then
        -- EOD is bakiyeleri guncelleme sadece kontrolleri yap..
       ln_eod_lc_tutar := 0;
       ln_eod_fc_tutar := 0;
        if r_satir.hesap_tur_kodu in ('VD', 'VS', 'KR') then   
            /* burada sadece müşteri hesapları için EOD bakiyesini alıp kontrol yapmalıyız */
             begin
               /* once bu hesaba EOD de yapılmış diğer işlemleri alalım */
                select sum(decode(s.b_a,'A', nvl(lc_tutar,0), -1*nvl(lc_tutar,0))),
                       sum(decode(s.b_a,'A', nvl(dv_tutar,0), -1*nvl(dv_tutar,0)))
                  into ln_eod_lc_tutar, ln_eod_fc_tutar
                  from muh_fis_satir s 
                 where s.hesap_numara   = r_satir.hesap_numara
                   and s.hesap_tur_kodu = r_satir.hesap_tur_kodu
                   and exists (select 1 from Muh_eod_fis_no ef where ef.durum='A' and ef.fis_numara=s.fis_numara)
                   and (s.fis_numara<>r_satir.fis_numara);  
             exception 
               when no_data_found then
                 ln_eod_lc_tutar := 0;
                 ln_eod_fc_tutar := 0;
             end;
            begin      
                select sum(decode(s.b_a,'A', nvl(lc_tutar,0), -1*nvl(lc_tutar,0))),
                       sum(decode(s.b_a,'A', nvl(dv_tutar,0), -1*nvl(dv_tutar,0)))
                  into vn_fis_lc_once, vn_fis_fc_once
                  from (select rownum satir_isleme_numara, a.* 
                         from 
                        ( SELECT a.*,DECODE(bakiye_karakteri, 'P', DECODE(a.b_a, 'A',1,2),DECODE(a.b_a, 'A',2,1) ) karakter,
                                bakiye_karakteri b_karakter 
                           FROM MUH_FIS_SATIR a, MUH_HESAP_BAKIYE hb
                          WHERE /*a.fis_numara     in (select fis_numara from Muh_eod_fis_no ef
                                                      where ef.durum = 'A') */ 
                                a.fis_numara = r_satir.fis_numara                          
                            AND exists (select 1 from   Muh_eod_fis_no ef where ef.durum='A' and ef.fis_numara=a.fis_numara)                                                       
                            AND hesap_tur_kodu  != 'DK'
                            AND TO_NUMBER(a.HESAP_NUMARA)   = hb.hesap_no (+) 
                           -- AND a.hesap_numara = r_satir.hesap_numara
                            AND fis_numara=r_satir.fis_numara
                          UNION
                         SELECT b.*,DECODE(dh.BA_KOD,'A',DECODE(b.b_a, 'A',1,2),DECODE(b.b_a, 'A',2,1)) karakter,
                                dh.BA_KOD b_karakter
                           FROM MUH_FIS_SATIR b, V_MUH_HP_HESAP dh
                          WHERE /*fis_numara        in (select fis_numara from Muh_eod_fis_no ef
                                                       where ef.durum = 'A') */
                                b.fis_numara = r_satir.fis_numara                          
                            AND exists (select 1 from   Muh_eod_fis_no ef where ef.durum='A' and ef.fis_numara=b.fis_numara) 
                            AND hesap_tur_kodu    =  'DK'
                            AND b.HESAP_NUMARA    =  dh.HESAP_NO (+)
                            AND b.HESAP_SUBE_KOD  =  dh.SUBE_KOD (+)
                            AND b.DOVIZ_KOD       =  dh.DOVIZ_KOD(+)
                            --AND b.hesap_numara    = r_satir.hesap_numara
                            ORDER BY 4,1,5 desc,6,karakter,2
                        ) a
                      ) s
               where /* s.fis_numara in (select fis_numara from Muh_eod_fis_no ef
                                       where ef.durum = 'A')
               and Yukariya aldik zaten bu kismi MHA 120912 */s.hesap_numara   = r_satir.hesap_numara
               and s.hesap_tur_kodu = r_satir.hesap_tur_kodu
               and (s.fis_numara=r_satir.fis_numara
                         and s.satir_isleme_numara<r_satir.satir_isleme_numara);
            exception 
             when no_data_found then
               vn_fis_lc_once := 0;
               vn_fis_fc_once := 0;
           end;
       end if;    
       ln_eod_lc_tutar := nvl(ln_eod_lc_tutar, 0) + NVL(vn_fis_lc_once,0);
       ln_eod_fc_tutar := nvl(ln_eod_fc_tutar, 0) + NVL(vn_fis_fc_once,0);
       if r_satir.hesap_tur_kodu='DK' then
          null; --burada son kullanma tarihi kontrolu yapiliyor.
               -- bu kontrolu yapmak gerekebilir....
       elsif r_satir.hesap_tur_kodu in ('VD', 'VS', 'KR') then         
        /*   open hesap_acikmi(to_number(r_satir.hesap_numara));
           fetch hesap_acikmi into ls_durum_kodu, ln_destek;
           if hesap_acikmi%notfound then
              close hesap_acikmi;
              raise Hesap_Bulunamadi_Exception;
           else
              close hesap_acikmi;
           end if; cursordan almak yerine direkt function kullanamalim MHA 02032015 */
           ls_durum_kodu := pkg_hesap.durum_kodu(r_satir.hesap_numara);

           if ls_durum_kodu='K' then
               raise kapali_hesap_hareket_yaratma;
           end if;
           
           vn_hareket_kodu := pkg_hesap.hesap_hareket_kodu(r_satir.hesap_numara);
           vn_musteri_no := pkg_hesap.musteri_no(r_satir.hesap_numara);

           If vn_hareket_kodu = 2 And ((r_satir.b_a = 'B' and r_satir.dv_tutar>=0) OR (r_satir.b_a='A' and r_satir.dv_tutar<0))  Then
              if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_tx_code) = 'E' then
                 RAISE Borc_hareket_girilemez;
              end if;   
           ElsIf vn_hareket_kodu = 3 And ((r_satir.b_a = 'A' and r_satir.dv_tutar>=0) OR (r_satir.b_a='B' and r_satir.dv_tutar<0)) Then
               RAISE Alacak_hareket_girilemez;
           ElsIf vn_hareket_kodu = 4 Then
              --if NOT (pv_tur='B' and pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_kod) = 'H') then
              if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_tx_code) = 'E' then
                 RAISE Hareket_girilemez;
              end if;   
           End if; 

           if r_satir.hesap_tur_kodu = 'VS' and pkg_hesap.urun_sinif_kod(r_satir.hesap_numara)='KKART FON' then
                  /* KKART FON hesabı sadece belli işlemlerde kullanılabiliyor olmalı MHA 16062014 */
                  if pkg_parametre.ParamTextDegerVarMi('KKART_FON_ISLEM',vn_tx_code)= 'H' then
                     pkg_hata.hata_yaz(4312,true,r_satir.hesap_numara);
                  end if;
           end if;   
           
           ln_destek := pkg_kmh.kmh_limit_al_vadeli(to_number(r_satir.hesap_numara),null,vn_tx_code);

           open hesap_cursor(r_satir.hesap_numara);
           fetch hesap_cursor into l_initial_bakiye,ln_bloke_tutari, vn_net_fon_bakiye, vn_mevcut_fon_pay;

            --TY-23
           --Kurumsal KDH tanımlı bir hesap ise tüm hesaplara ortak limit tanımlandığından diğer hesaptaki eksi bakiyeler de dikkate alınır.
           vn_kmh_eksi_bakiye_toplam := PKG_HESAP.TuzelKurumsalKdhEksiBakiyeTop(to_number(r_satir.hesap_numara), 'H');
           
           vn_kmh_kredi_bakiye := pkg_kmh.kmh_kredi_hesap_bakiye_al(to_number(r_satir.hesap_numara)); 
           /* EOD esnasında kredi hesabına devredilen bakiye varsa bunu da dikkate alalım yoksa EOD esnasında
              para yatıran borçlu bir müşteriye fazla limiti varmış gibi davranıyoruz MHA 15012018 */
               if ln_bloke_tutari>0 and ln_destek >0 then
                  /* bloke kmh kullanmamıza engel oluyor mu kontrol edelim MHA 01122020 */
                  select /*+ index(B X01_MUH_BLOKE) */ count(*)
                  into vn_hesaptaki_bloke_adet
                  from muh_bloke b
                  where b.hesap_no = to_number(r_satir.hesap_numara)
                  and b.durum_kodu = 'A'
                  and b.bloke_neden_kodu not in (select key1 from bnspr.gnl_param_text where kod='KMH_ETKILEMEYEN_BLOKELER'); 
                  if vn_hesaptaki_bloke_adet > 0 then
                     ln_destek := 0;
                  end if;                    
               end if;   
           
        if ln_destek > 0 then
            /* Sadece kmh var ise tuzel eksi toplami dikkate alalim (ekent 2275604 hesapta 118 bin olmasina 
              rağmen vizeleme yapamaması örneği)   MHA 17102016 */
            l_initial_bakiye := nvl(l_initial_bakiye,0)+ln_destek + NVL(vn_kmh_eksi_bakiye_toplam,0);
         else
            l_initial_bakiye := nvl(l_initial_bakiye,0)+ln_destek;
         end if;            
          
      if  NVL(vn_kmh_kredi_bakiye,0) < 0 and ln_destek = 0 then
          /* Demekki günsonunda KMH bakiyesi kredi hesabına aktarılmış */
          /* bu durumda 1141201 in 12.01 daki gibi Gecikmede ama bakiyesi - ve Akbanktan para yatırmış ise MHA 21032018 */
          l_initial_bakiye := nvl(l_initial_bakiye,0)+NVL(vn_kmh_kredi_bakiye,0);
      end if;    
      if r_satir.hesap_tur_kodu = 'VS' then
         if not NVL(pkg_global.get_rolkod,0) = '999' then   --EOD degil ise calisacak...
            l_initial_bakiye :=  l_initial_bakiye - pkg_kmh.kmh_faiz_tahakkuk_tutar(r_satir.hesap_numara);
         end if;
      end if;
         
           if r_satir.doviz_kod = PKG_GLOBAL.WLocCurr then
             if r_satir.b_a='A' then
                   l_last_bakiye:=l_initial_bakiye+ln_eod_lc_tutar+r_satir.lc_tutar;
             else
                   l_last_bakiye:=l_initial_bakiye+ln_eod_lc_tutar-r_satir.lc_tutar;
             end if;
             if r_satir.b_karakter='P' and (l_last_bakiye-ln_bloke_tutari)<0 AND (r_satir.b_a='B' OR ln_eod_lc_tutar<0) then
                   raise bakiye_negatif_olamaz;
             end if;
             if r_satir.b_karakter='N' and (l_last_bakiye-ln_bloke_tutari)>0  AND (r_satir.b_a='A' OR ln_eod_lc_tutar>0) then
                   raise bakiye_pozitif_olamaz;
             end if;
           else
             if r_satir.b_a='A' then
                   l_last_bakiye:=l_initial_bakiye+ln_eod_fc_tutar+r_satir.dv_tutar;
             else
                   l_last_bakiye:=l_initial_bakiye+ln_eod_fc_tutar-r_satir.dv_tutar;
             end if;
             if r_satir.b_karakter='P' and (l_last_bakiye-ln_bloke_tutari)<0 AND (r_satir.b_a='B' OR ln_eod_fc_tutar<0) then
                   raise bakiye_negatif_olamaz;
             end if;
             if r_satir.b_karakter='N' and (l_last_bakiye-ln_bloke_tutari)>0 AND (r_satir.b_a='A' OR ln_eod_fc_tutar>0) then
                   raise bakiye_pozitif_olamaz;
             end if;
           end if;
           close hesap_cursor;
        end if;
      else
        if vc_batch_kontrol='E' AND pkg_parametre.ParamTextDegerVarMi('BATCH_MUHASEBE_ISLEM',vn_tx_code,r_satir.hesap_tur_kodu,r_satir.b_a) = 'E' then
              /* batch tablomuza insert edip cikalim MHA 30072015 */
              Insert into MUH_BATCH_FIS_SATIR
                         (FIS_NUMARA,NUMARA,B_A,HESAP_SUBE_KOD,HESAP_TUR_KODU,HESAP_NUMARA,LC_TUTAR,DV_TUTAR,DOVIZ_KOD,DURUM)
              Values(r_satir.fis_numara,r_satir.numara,r_satir.b_a,r_satir.hesap_sube_kod,r_satir.hesap_tur_kodu,
                     r_satir.hesap_numara,r_satir.lc_tutar,r_satir.dv_tutar,r_satir.doviz_kod,'A');
        else            
            -- Hesap turune gore ilgili hesap bakiyesini guncelle
            IF r_satir.hesap_tur_kodu='DK' THEN
                Pkg_HP.bakiye_guncelle(r_satir.hesap_Sube_kod,r_satir.hesap_numara,r_satir.doviz_kod,r_satir.b_a,r_satir.dv_tutar,r_satir.lc_tutar,TRUE);
            ELSIF r_satir.hesap_tur_kodu='VD' THEN
            
                Pkg_Hesap.bakiye_guncelle('VD',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,r_satir.dv_tutar,
                                               r_satir.lc_tutar, pfis_no,ln_hareket_sonrasi_bakiye);
            ELSIF r_satir.hesap_tur_kodu='VS' THEN
              /*SELECT i.islem_kod, i.numara into ln_islem_kod, ln_islem_numara
             FROM MUH_FIS f, MUH_ISLEM i
            WHERE f.islem_numara  = i.numara
             AND  f.numara        = pfis_no; gerek yok zaten alınmışı var MHA 02032015 */
             ln_islem_kod := vn_tx_code;
             ln_islem_numara := p_islem_numara;
             
                if nvl(Pkg_Parametre.ParamTextDegerVarMi('EMV_KREDI_ODEMESI',ln_islem_kod),'H')='E' and r_satir.b_a='B' then
                   Pkg_Dcard.EMV_HESAP_GUNCELLE(ln_islem_numara||'-'||r_satir.numara,r_satir.lc_tutar,r_satir.hesap_numara,r_satir.b_a);  
                end if;
                Pkg_Hesap.bakiye_guncelle('VS',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,r_satir.dv_tutar,
                                               r_satir.lc_tutar, pfis_no,ln_hareket_sonrasi_bakiye);
            ELSIF r_satir.hesap_tur_kodu='KR' THEN
                Pkg_Hesap.bakiye_guncelle('KR',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,r_satir.dv_tutar,
                                               r_satir.lc_tutar, pfis_no,ln_hareket_sonrasi_bakiye);
                                               
            END IF;
    -------------------
       
            IF r_satir.hesap_tur_kodu != 'DK' Then     -- Musteri hesaplarinin hareket sonrasi bakiyelerini yaratir
               if p2_tarih = p_banka_tarihi then
                   Update Muh_fis_satir d
                      Set d.sonraki_bakiye = ln_hareket_sonrasi_bakiye,
                          d.balance_after  = ln_hareket_sonrasi_bakiye,
                          d.balance_flag   = 'E'
                    Where d.fis_numara = r_satir.fis_numara 
                      And d.numara     = r_satir.numara
                   ;
               else
                 if hesap_numara is not null and hesap_numara != r_satir.hesap_numara then
                    son_bakiye := null; /* demekki ayni fiste farkli bir hesap soz konusu olmus MHA 090210 */
                 end if;   
                 if son_bakiye is null then
                   hesap_numara := r_satir.hesap_numara;
                   begin
                    /*  select -- sss.fis_numara, sss.numara, fff.muh_tarih, sss.sonraki_bakiye
                             max(sss.sonraki_bakiye) keep(dense_rank last order by muh_tarih, fis_numara,  DECODE(bakiye_karakteri, 'P', DECODE(b_a, 'A',1,2),DECODE(b_a, 'A',2,1) ),sss.numara)
                        into son_bakiye
                        from muh_fis_satir sss, muh_fis fff, muh_hesap_bakiye hb
                       where sss.fis_numara = fff.numara
                         and sss.hesap_numara = r_satir.hesap_numara
                         and sss.hesap_tur_kodu = r_satir.hesap_tur_kodu
                         and fff.muh_tarih <= p2_tarih
                         and fff.tur = 'G'
                         and sss.fis_numara < r_satir.fis_numara
                         and hb.hesap_no = r_satir.hesap_numara;
                     Son harekete gitmek yerine Bugünden sonraki hareketleri toplamaya gidecegiz MHA 09112015 */

                 if pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_HESAP',r_satir.hesap_numara) = 'E' OR p2_tarih >= pkg_muhasebe.Onceki_Banka_Tarihi_Bul-1 then
                     /* cok hareketli veya kisa tarih ise bu yoldan gidebiliriz MHA 20022017 */
                     select /*+ index(sss,PK_MUH_HAREKET_SATIR) */  sum(decode(b_a,'B',-sss.dv_tutar,sss.dv_tutar)) hartop, count(*) haradet
                       into vn_har_top, vn_har_adet
                       from bnspr.muh_fis_satir sss,bnspr.muh_fis fff
                      where sss.fis_numara = fff.numara
                        and sss.hesap_numara = r_satir.hesap_numara
                        and sss.hesap_tur_kodu = 'VS'
                        and fff.tur = 'G'
                        and fff.muh_tarih>p2_tarih;
                 else
                     select /*+ index(sss,IND_HESAPNO) */  sum(decode(b_a,'B',-sss.dv_tutar,sss.dv_tutar)) hartop, count(*) haradet
                       into vn_har_top, vn_har_adet
                       from bnspr.muh_fis_satir sss,bnspr.muh_fis fff
                      where sss.fis_numara = fff.numara
                        and sss.hesap_numara = r_satir.hesap_numara
                        and sss.hesap_tur_kodu = 'VS'
                        and fff.tur = 'G'
                        and fff.muh_tarih>p2_tarih;
                 end if;                          
                                                
                     /*select s.sonraki_bakiye
                       into son_bakiye
                       from muh_fis_satir s,muh_fis f
                      where s.fis_numara=f.numara
                        and s.hesap_numara=r_satir.hesap_numara
                        and s.hesap_tur_kodu=r_satir.hesap_tur_kodu
                        \*and f.muh_tarih=p2_tarih burada tarih olmasi o tarihte baska bir islem olmadiginda hataya yol aciyor MHA 261110 *\
                        and f.numara = (select max(fis_numara)
                                          from muh_fis_satir s,muh_fis f
                                         where s.fis_numara=f.numara
                                           and s.hesap_numara=r_satir.hesap_numara
                                           and s.hesap_tur_kodu=r_satir.hesap_tur_kodu
                                           and f.muh_tarih<=p2_tarih
                                           and f.tur='G'
                                           and fis_numara<r_satir.fis_numara)
                        and s.numara=(select max(sss.numara) from muh_fis_satir sss where sss.fis_numara=s.fis_numara and sss.hesap_numara=r_satir.hesap_numara);*/
                                           
                   exception when no_data_found then
                      vn_har_top := 0;
                      vn_har_adet := 0;
                   end;  
                   --son_bakiye :=    NVL(son_bakiye,0)+((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar);  
                   son_bakiye := ln_hareket_sonrasi_bakiye-NVL(vn_har_top,0);    
                     Update Muh_fis_satir d
                        Set d.sonraki_bakiye = son_bakiye,
                            d.balance_after  = son_bakiye,
                            d.balance_flag   = 'E'
                      Where d.fis_numara = r_satir.fis_numara
                        and d.numara =  r_satir.numara;
                   
                 else
                   /* ayni fiste 2. bir bacakta daha hesap geçiyorsa */
                    son_bakiye :=    NVL(son_bakiye,0)+((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar);
                     Update Muh_fis_satir d
                        Set d.sonraki_bakiye = son_bakiye,
                            d.balance_after  = son_bakiye,
                            d.balance_flag = 'E'
                      Where d.fis_numara = r_satir.fis_numara
                        and d.numara =  r_satir.numara;
                 end if;
                  if vn_har_adet > 0 then
                     /* geri tarihli fisi kestigimiz tarihten sonra bir hareket var ise Update gecelim MHA 22042016 */
                     IF pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_HESAP',r_satir.hesap_numara) = 'E' then       
                            /* geri tarihli fis kestigimizde bugünden sonraki günler için kesilmis tüm fislerin sonraki bakiyelerini güncelleyelim */
                            update /*+ index(sa,PK_MUH_HAREKET_SATIR) */ MUH_FIS_satir sa
                                     set sa.balance_after = nvl(sa.balance_after,0) + ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar),
                                         sa.sonraki_bakiye = nvl(sa.sonraki_bakiye,0) + ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar)
                                   where sa.fis_numara IN (select /*+ index(s,PK_MUH_HAREKET_SATIR) full(f) */ f.numara 
                                                             from muh_fis f,muh_fis_satir s 
                                                            where f.muh_tarih>p2_tarih
                                                              and s.fis_numara=f.numara
                                                              and s.hesap_numara=r_satir.hesap_numara
                                                              and s.hesap_tur_kodu=r_satir.hesap_tur_kodu
                                                              and f.tur='G')
                                     and sa.hesap_numara = r_satir.hesap_numara;
                     ELSE
                            update /*+ index (sa,IND_HESAPNO) */ MUH_FIS_satir sa
                                     set sa.balance_after = nvl(sa.balance_after,0) + ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar),
                                         sa.sonraki_bakiye = nvl(sa.sonraki_bakiye,0) + ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar)
                                   where sa.fis_numara IN (select /*+ INDEX(s IND_HESAPNO) INDEX(f PK_MUH_HAREKET) */f.numara 
                                                             from muh_fis f,muh_fis_satir s 
                                                            where f.muh_tarih>p2_tarih
                                                              and s.fis_numara=f.numara
                                                              and s.hesap_numara=r_satir.hesap_numara
                                                              and s.hesap_tur_kodu=r_satir.hesap_tur_kodu
                                                              and f.tur='G')
                                     and sa.hesap_numara = r_satir.hesap_numara;
                   END IF;                                  
                 end if; /* vn_har_adet > 0 */
               end if;   /* p2_tarih != p_banka_tarihi */
            END IF; 
          end if;     
                                  
         
      end if;
    END LOOP; -- satir
     CLOSE c0;
                                       
    
    --
    OPEN c1;
     LOOP
       FETCH c1 INTO p_fis_numara, p_islem_numara, p_islem_kod, p_kanal_numara;
       EXIT WHEN c1%NOTFOUND;
      if p_eod = 'E' then
          update MUH_FIS
             set Muh_Tarih=p_sonraki_banka_tarihi
           where numara=p_fis_numara;
      else

            if p_kanal_numara != '1' then
               /* sube kanalindan degilse Teller No define etmemiz lazım MHA 130313*/
               select NVL(f.teller_id,'DG')||p_islem_kod
                 into p_teller_no
                 from gnl_kanal_grup_kod_pr f
                where f.kod = p_kanal_numara; 
            else 
               p_teller_no := pkg_global.GET_KULLANICIKOD;
            end if; 
    
          p_max_fis_no := Fis_No_Getir_Yeni(p_teller_no, p_kanal_numara, p2_tarih);
 
          IF p_max_fis_no < 0 THEN
              PKG_HATA.hata_yaz(207,TRUE );
          END IF;
         Begin
          if vb_fonAlimSatim then
             /* eger otomatik fon almış isek muhasebeşlerilen fişimiz 2107 fişinden sonra yaratılmış gibi güncelleyelim MHA 070413 */
             vn_tarih_set := 1;
          else
             vn_tarih_set := 0;
          end if;      

            UPDATE MUH_FIS f
               SET Muh_Tarih=p2_tarih,
                  fis_no=p_max_fis_no,
                  teller_no=p_teller_no,
                  f.yarat_tar=decode(vn_tarih_set,1,SYSDATE + 1/86400,sysdate)
             WHERE numara=p_fis_numara;

           EXCEPTION
             WHEN OTHERS THEN
               PKG_HATA.hata_yaz(205,TRUE,SQLERRM);
         End;
       end if;
      END LOOP;
      CLOSE c1;    --fis
    --
    
    EXCEPTION
      WHEN Hesap_Bulunamadi_Exception THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
                                 PKG_HATA.hata_yaz(201,TRUE,r_satir.hesap_numara);
      WHEN Bakiye_Negatif_Olamaz THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
                                 PKG_HATA.hata_yaz(202,TRUE,r_satir.hesap_numara);
      WHEN Bakiye_Pozitif_Olamaz THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
                                 PKG_HATA.hata_yaz(203,TRUE,r_satir.hesap_numara);
      WHEN Kapali_Hesap_Hareket_Yaratma THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
                                 PKG_HATA.hata_yaz(204,TRUE,r_satir.hesap_numara);
      WHEN Borc_hareket_girilemez THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
             PKG_HATA.hata_yaz (273,TRUE,r_satir.hesap_numara);
      WHEN Alacak_hareket_girilemez THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
             PKG_HATA.hata_yaz (274,TRUE,r_satir.hesap_numara);
      WHEN Hareket_girilemez THEN
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
             PKG_HATA.hata_yaz (275,TRUE,r_satir.hesap_numara);
      WHEN OTHERS THEN
            vc_sqlErr := substr(replace(replace(SQLERRM,'||'),'ORA-20001:'),1,1024);
            if vb_fonAlimSatim then 
               for r_fon_satim in c_fon_satim(p_islem_numara) loop
                   pkg_trn2107.After_Canceling_Approval(r_fon_satim.tx_no);
               end loop;
            end if;
            PKG_HATA.hata_yaz(660,TRUE, vc_sqlErr);                   
  END;
----------------------------------------------------------------------------  
  FUNCTION Ters_fis_yarat(pn_islem_numara NUMBER,p_fis_numara MUH_FIS.numara%TYPE,
                          p_banka_tarihi  DATE DEFAULT NULL) RETURN NUMBER IS
    -- <0 anything abnormal
    -- >0 normal complete...

    CURSOR cur_muhasebe(p_fisno MUH_FIS.numara%TYPE) IS
     SELECT muh_tarih
       FROM MUH_FIS
      WHERE numara = p_fisno;

    p_ters_fis_numara     MUH_FIS.numara%TYPE;
    p_ters_fis_no         MUH_FIS.fis_no%TYPE;
    p_muhasebe_tarih      MUH_FIS.muh_tarih%TYPE;
    p_banking_date        DATE;
    p_sonuc               NUMBER;

    ps_kullanici_kodu     VARCHAR2(30);
    ps_bolum_kodu         VARCHAR2(10);
    vn_degismis_dk        number;
    vn_devir_var          number;
    p_ters_fis_count      number;
    vn_degismis_sube      number;
    vn_kapanmis_sube      number;

    BEGIN

      ps_kullanici_kodu :=Pkg_GLOBAL.GET_KULLANICIKOD;
      ps_bolum_kodu     :=Pkg_GLOBAL.GET_SUBEKOD;
      select count(*) into p_ters_fis_count from muh_fis m where m.numara = p_fis_numara and m.ters_fis_no is not null;
      
      if p_ters_fis_count >0 THEN
          PKG_HATA.hata_yaz(5312,TRUE );
          RETURN -1;        
      end if;
      
       IF p_banka_tarihi IS NULL THEN
         p_banking_date := Banka_Tarihi_Bul;
       ELSE
         p_banking_date := p_banka_tarihi;
       END IF;

       p_ters_fis_numara := fis_numara_AL;
       p_ters_fis_no     := null;/*fis_no_getir(p_banking_date); bunu almasina gerek yok muhaebelestirde tekrar aliyor numara MHA 170909*/
       IF p_ters_fis_no < 0 THEN    
          CLOSE cur_muhasebe;
              PKG_HATA.hata_yaz(207,TRUE );
          RETURN -1;
       END IF;
       
        select count(*)
          into vn_degismis_dk 
          from bnspr.muh_fis_satir s,bnspr.v_muh_hesap_izleme_tum tum
         where s.fis_numara=p_fis_numara
           and s.hesap_tur_kodu='DK'
           and s.musteri_hesap_numara is not null
           and tum.hesap_no=s.musteri_hesap_numara
           and s.hesap_numara!=tum.musteri_dk_no;

        select count(*)
          into vn_degismis_sube
          from bnspr.muh_fis_satir s,bnspr.v_muh_hesap_izleme_tum tum
         where s.fis_numara=p_fis_numara
           and s.musteri_hesap_numara is not null
           and tum.hesap_no=s.musteri_hesap_numara
           and s.hesap_sube_kod!=tum.sube_kodu;
           
        select count(*)
          into vn_kapanmis_sube
          from bnspr.muh_fis_satir s,bnspr.sube_devir_pr pr
         where s.fis_numara=p_fis_numara
           and s.musteri_hesap_numara is null
           and s.hesap_tur_kodu='DK'
           and s.hesap_sube_kod=pr.from_sube
           and exists (select 1 from bnspr.gnl_sube_kod_pr ss where ss.kod=s.hesap_sube_kod and ss.durumu='K');

           --and not exists (select 1 from bnspr.muh_dk_devir_pr p where p.from_dk=s.hesap_numara and p.durum='K');
           /* yeni devir ile devredilen iþlemin tersinin kesilmesine izin verelim,zira elimizde from to var MHA 22012015 */
           
 /*      if vn_degismis_dk > 0 then
          pkg_hata.hata_yaz(2337,true,p_fis_numara);
       end if;  */     
           
       INSERT INTO MUH_FIS (numara,      aciklama,   islem_numara,  yarat_tar,      gecerlilik_tar,
                           muh_tarih,    yaratan_kullanici_kodu,    fis_no,         yaratildigi_banka_tarih,
                           iptal_edilebilir,ISLEM_SUBE_KOD)
                        (SELECT p_ters_fis_numara, TO_CHAR(p_fis_numara) || ' numarali fisin ters fisi', pn_islem_numara, SYSDATE, p_banking_date,
                                NULL, ps_kullanici_kodu, p_ters_fis_no, p_banking_date,iptal_edilebilir, ISLEM_SUBE_KOD
                           FROM MUH_FIS S
                           WHERE S.numara = p_fis_numara);

       INSERT INTO MUH_FIS_SATIR (fis_numara,     numara,          b_a,               hesap_sube_kod, 
                                  hesap_tur_kodu, hesap_numara,    valor_tarihi,      lc_tutar, 
                                  dv_tutar,       base_tutar,      doviz_kod,         aciklama_banka,    aciklama_musteri,
                                  istatistik_kodu,referans,        yaratildigi_tarih, yaratan_kullanici_kodu,
                                  kur,            kasa_nakit_kod , musteri_hesap_tur, musteri_hesap_numara,
                                  temel_hesap)
                         (SELECT p_ters_fis_numara, numara, DECODE(b_a,'B','A','B'),  hesap_sube_kod, 
                                 hesap_tur_kodu,    hesap_numara,  Pkg_Muhasebe.Banka_Tarihi_Bul /*valor_tarihi*/,      
                                 lc_tutar, 
                                 dv_tutar,         base_tutar,      doviz_kod,         aciklama_banka||' (Ters Fiş Kesilmesi)',    aciklama_musteri,
                                 istatistik_kodu, referans,        sysdate, ps_kullanici_kodu,
                                 kur,             kasa_nakit_kod,  musteri_hesap_tur, musteri_hesap_numara,
                                 temel_hesap
                           FROM MUH_FIS_SATIR S
                            WHERE S.fis_numara = p_fis_numara);

      INSERT INTO muh_fis_satir_aciklama (fis_numara,numara,dil_kod,aciklama_banka,aciklama_musteri)
      select p_ters_fis_numara,a.numara,a.dil_kod,a.aciklama_banka||DEcode(a.dil_kod,'EN',' Reverse'),a.aciklama_musteri
        from muh_fis_satir_aciklama a       
       where a.fis_numara = p_fis_numara; 

/*AsliK17/02/10*/
         BEGIN
            UPDATE MUH_ISLEM 
               SET fis_numara= p_ters_fis_numara
             WHERE numara    = pn_islem_numara
               AND fis_numara is null;/*Kosul eklenerek update acildi.OO.24/08/2011*/
         EXCEPTION
          WHEN OTHERS THEN
              PKG_HATA.hata_yaz(232,TRUE,SQLERRM);
              return -1;
         END;
/**/
          /* Toplu DK devir ile devir görmüş bir hesap varsa düzenleme yapalım fis satırlarında MHA 14012015 */
 /*         select count(*)
            into vn_devir_var
            from muh_fis_satir s,muh_dk_devir_pr p
           where s.fis_numara=p_ters_fis_numara
             and s.hesap_tur_kodu='DK'
             and s.hesap_numara=p.from_dk
             and p.durum='K'; */
             
          if vn_degismis_dk >0 then
              for c1 in (select s.*,tum.musteri_dk_no
                           from muh_fis_satir s,v_muh_hesap_izleme_tum tum
                          where s.fis_numara=p_ters_fis_numara
                            and s.hesap_tur_kodu='DK'
                            and s.musteri_hesap_numara is not null
                            and tum.hesap_no=s.musteri_hesap_numara
                            and s.hesap_numara!=tum.musteri_dk_no)
               Loop
                    Update muh_fis_satir ss
                       set ss.hesap_numara=c1.musteri_dk_no
                     where ss.fis_numara=p_ters_fis_numara
                       and ss.hesap_numara=c1.hesap_numara
                       and ss.numara=c1.numara;  
               End Loop; 
          end if;    
           
          if vn_degismis_sube > 0 then
              for c1 in (select s.*,tum.sube_kodu
                           from bnspr.muh_fis_satir s,bnspr.v_muh_hesap_izleme_tum tum
                          where s.fis_numara=p_ters_fis_numara
                            and s.musteri_hesap_numara is not null
                            and tum.hesap_no=s.musteri_hesap_numara
                            and s.hesap_sube_kod!=tum.sube_kodu)
               Loop
                    Update bnspr.muh_fis_satir ss
                       set ss.hesap_sube_kod=c1.sube_kodu
                     where ss.fis_numara=p_ters_fis_numara
                       and ss.hesap_numara=c1.hesap_numara
                       and ss.numara=c1.numara;
               End Loop;
          end if;  
          
          if vn_kapanmis_sube > 0 then
              for c1 in (select s.*,pr.to_sube
                           from bnspr.muh_fis_satir s,bnspr.sube_devir_pr pr
                          where s.fis_numara=p_fis_numara
                            and s.musteri_hesap_numara is null
                            and s.hesap_tur_kodu='DK'
                            and s.hesap_sube_kod=pr.from_sube
                            and exists (select 1 from bnspr.gnl_sube_kod_pr ss where ss.kod=s.hesap_sube_kod and ss.durumu='K'))
               Loop
                    Update bnspr.muh_fis_satir ss
                       set ss.hesap_sube_kod=c1.to_sube
                     where ss.fis_numara=p_ters_fis_numara
                       and ss.hesap_numara=c1.hesap_numara
                       and ss.numara=c1.numara;
               End Loop;
          end if;  
           

        OPEN cur_muhasebe(p_fis_numara);
            FETCH cur_muhasebe INTO p_muhasebe_tarih;      
        CLOSE cur_muhasebe;
        IF p_muhasebe_tarih IS NOT NULL THEN
          pkg_muhasebe.muhasebelestir(p_ters_fis_numara, p_banking_date);
        ELSE
            NULL;   -- Muhasebelesmeye gerek yok
        END IF;
       update muh_fis f set f.ters_fis_no = p_ters_fis_numara where f.numara=p_fis_numara;
       
       RETURN p_ters_fis_numara;

       
  EXCEPTION
      WHEN OTHERS THEN
              PKG_HATA.hata_yaz(233,TRUE,TO_CHAR(p_fis_numara),SQLERRM);      
              return -1;
  END;
-----------------------------------------------------------  
  PROCEDURE fis_iptal( p_fis_numara    MUH_FIS.numara%TYPE ,
                       p_banka_tarihi  DATE DEFAULT NULL ) IS

    p_islem_numara                MUH_ISLEM.numara%TYPE;
    p_kayit_kullanici_kodu        MUH_ISLEM.kayit_kullanici_kodu%TYPE;
    p_kayit_kullanici_rol_numara  MUH_ISLEM.kayit_kullanici_rol_numara%TYPE;
    p_kayit_kullanici_bolum_kodu  MUH_ISLEM.kayit_kullanici_bolum_kodu%TYPE;
    p_islem_kodu                  MUH_ISLEM.islem_kod%TYPE;

    p_banking_date                 DATE;
    ln_hareket_sonrasi_bakiye     number;

    CURSOR lc_fis  IS
     SELECT numara, muh_tarih
       FROM MUH_FIS
      WHERE numara          = p_fis_numara
       AND nvl(iptal_edilebilir,'E') ='E'
       AND iptal_edildigi_tarih is null
      ORDER BY tur ASC;

    p_muhasebe_tarih         MUH_FIS.muh_tarih%TYPE;
    p2_fis_numara            NUMBER;
    vn_degismis_dk        number;
    vc_batch_islem_var    char(1);
    vc_batch_muhasebe     char(1); 
    CURSOR lc_satir IS
           SELECT MUH_FIS_SATIR.*,
                  DECODE(bakiye_karakteri, 'P', DECODE(b_a, 'A',2,1),DECODE(b_a, 'A',1,2) ) karakter
             FROM MUH_FIS_SATIR,MUH_HESAP_BAKIYE hb
            WHERE fis_numara      =   p_fis_numara  
              AND hesap_tur_kodu != 'DK'
              AND TO_NUMBER(MUH_FIS_SATIR.HESAP_NUMARA)= hb.hesap_no
        UNION
           SELECT FS.*,DECODE(dh.BA_KOD,'A',DECODE(b_a, 'A',2,1),DECODE(b_a, 'A',1,2)) karakter
             FROM MUH_FIS_SATIR FS,V_MUH_HP_HESAP dh
            WHERE fis_numara      =p_fis_numara 
              AND hesap_tur_kodu  ='DK'
              AND FS.HESAP_NUMARA =dh.HESAP_NO
              AND FS.HESAP_SUBE_KOD =dh.SUBE_KOD
              AND FS.DOVIZ_KOD    =dh.DOVIZ_KOD
        ORDER BY 1,6,karakter; 

    r_satir     lc_satir%ROWTYPE;

     cursor c_eod_fisi(pfis_no number) is
        select *  
          from Muh_eod_fis_no efn
         where efn.fis_numara = pfis_no
           and efn.durum='A'
           for update;
      r_eod_fisi c_eod_fisi%rowtype;     
      ln_iptal_tutar       number := 0;
    BEGIN

      p_banking_date := banka_tarihi_bul;

      BEGIN
        SELECT f.islem_numara,i.kayit_kullanici_kodu,i.kayit_kullanici_rol_numara,
              i.kayit_kullanici_bolum_kodu,i.islem_kod
          INTO p_islem_numara,p_kayit_kullanici_kodu,p_kayit_kullanici_rol_numara,
               p_kayit_kullanici_bolum_kodu,p_islem_kodu
          FROM MUH_FIS f, MUH_ISLEM i
         WHERE f.numara = p_fis_numara
           AND i.numara = f.islem_numara;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
            PKG_HATA.hata_yaz(234,TRUE);
        WHEN OTHERS THEN
            PKG_HATA.hata_yaz(235,TRUE,SQLERRM);
      END;
       
      begin
         select 'E'
           into vc_batch_islem_var
           from MUH_BATCH_FIS_SATIR i
          where i.fis_numara = p_fis_numara
            and i.durum='A';
      exception when no_data_found then
          vc_batch_islem_var := 'H';
      end;          
 
        select count(*)
          into vn_degismis_dk 
          from bnspr.muh_fis_satir s,bnspr.v_muh_hesap_izleme_tum tum
         where s.fis_numara=p_fis_numara
           and s.hesap_tur_kodu='DK'
           and s.musteri_hesap_numara is not null
           and tum.hesap_no=s.musteri_hesap_numara
           and s.hesap_numara!=tum.musteri_dk_no;

          if vn_degismis_dk >0 then
              for c1 in (select s.*,tum.musteri_dk_no
                           from muh_fis_satir s,v_muh_hesap_izleme_tum tum
                          where s.fis_numara=p_fis_numara
                            and s.hesap_tur_kodu='DK'
                            and s.musteri_hesap_numara is not null
                            and tum.hesap_no=s.musteri_hesap_numara
                            and s.hesap_numara!=tum.musteri_dk_no)
               Loop
                    Update muh_fis_satir ss
                       set ss.hesap_numara=c1.musteri_dk_no
                     where ss.fis_numara=p_fis_numara
                       and ss.hesap_numara=c1.hesap_numara
                       and ss.numara=c1.numara;  
               End Loop; 
           end if; 

      OPEN lc_fis;
      LOOP
        FETCH lc_fis INTO p2_fis_numara, p_muhasebe_tarih;        
        EXIT WHEN lc_fis%NOTFOUND ;

      open c_eod_fisi(p2_fis_numara);
      fetch c_eod_fisi into r_eod_fisi;
      if c_eod_fisi%found then 
          update muh_eod_fis_no
           set durum = 'I'
           where current of c_eod_fisi;

           UPDATE MUH_FIS
              SET muh_tarih = p_banking_date
            WHERE numara = p2_fis_numara;     
      else  
          IF p_muhasebe_tarih IS NOT NULL THEN
             IF TO_CHAR(p_muhasebe_tarih,'ddmmyyyy') <> TO_CHAR(p_banking_date,'ddmmyyyy') THEN
                CLOSE lc_fis;  
                PKG_HATA.hata_yaz(236,TRUE);
             END IF;
      
           Pkg_Limit.Risk_Iptal(p_fis_numara);
      
             OPEN lc_satir;
             LOOP
                FETCH lc_satir INTO r_satir;
                EXIT WHEN lc_satir%NOTFOUND;  
              IF vc_batch_islem_var ='E' then
                  begin
                     select 'E'
                       into vc_batch_muhasebe
                       from MUH_BATCH_FIS_SATIR i
                      where i.fis_numara = p_fis_numara
                        and i.numara=r_satir.numara
                        and i.durum='A';
                  exception when no_data_found then
                      vc_batch_muhasebe := 'H';
                  end; 
               else
                  vc_batch_muhasebe := 'H';
               end if; 
               if vc_batch_muhasebe = 'H' then                           
                    -- Hesap turune gore ilgili hesap bakiyesini guncelle  
                    IF r_satir.hesap_tur_kodu='DK' THEN
                      Pkg_HP.bakiye_guncelle(r_satir.hesap_sube_kod,r_satir.hesap_numara,r_satir.doviz_kod,r_satir.b_a,-r_satir.dv_tutar,-r_satir.lc_tutar);
                    ELSIF r_satir.hesap_tur_kodu='VD' THEN
                      Pkg_Hesap.bakiye_guncelle('VD',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,
                                                     -r_satir.dv_tutar,-r_satir.lc_tutar, p_fis_numara,ln_hareket_sonrasi_bakiye);
                    ELSIF r_satir.hesap_tur_kodu='VS' THEN
                      Pkg_Hesap.bakiye_guncelle('VS',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,
                                                    -r_satir.dv_tutar,-r_satir.lc_tutar, p_fis_numara,ln_hareket_sonrasi_bakiye);
                    ELSIF r_satir.hesap_tur_kodu='KR' THEN
                      Pkg_Hesap.bakiye_guncelle('KR',r_satir.hesap_numara, r_satir.doviz_kod, r_satir.b_a,
                                                    -r_satir.dv_tutar,-r_satir.lc_tutar, p_fis_numara,ln_hareket_sonrasi_bakiye);
                    END IF;
                    ln_iptal_tutar := nvl(ln_iptal_tutar,0) + (-r_satir.dv_tutar); 
                    
                    IF r_satir.hesap_tur_kodu != 'DK' Then
                      /* kendisinden büyük fis numarali geri tarihli kesilmis fislerin bakiyeleri update edilmemeli MHA 070411 BNSPRPRO-5937 */
                       --IF pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_HESAP',r_satir.hesap_numara) = 'E' then
                          update /*+ index(sa PK_MUH_HAREKET_SATIR) */ MUH_FIS_satir sa
                             set sa.balance_flag  = decode(sa.fis_numara,p2_fis_numara,'X',sa.balance_flag),
                                 sa.balance_after = nvl(sa.balance_after,0) - ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar),
                                 sa.sonraki_bakiye = nvl(sa.sonraki_bakiye,0) -((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar)
                           where sa.fis_numara >= p2_fis_numara
                             and sa.hesap_numara = r_satir.hesap_numara
                           --  and not exists (select 1 from muh_fis fis where fis.numara=sa.fis_numara and fis.muh_tarih < p_banking_date)
                             and exists (select 1 from muh_fis fs where fs.numara=sa.fis_numara and fs.tur='G' and fs.muh_tarih>= p_banking_date)
                             ;
                       /*ELSE
                          update \*+ index(sa IND_HESAPNO) *\ MUH_FIS_satir sa
                             set sa.balance_flag  = decode(sa.fis_numara,p2_fis_numara,'X',sa.balance_flag),
                                 sa.balance_after = nvl(sa.balance_after,0) - ((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar),
                                 sa.sonraki_bakiye = nvl(sa.sonraki_bakiye,0) -((case when r_satir.b_a='B' then -1 else 1 end)* r_satir.dv_tutar)
                           where sa.fis_numara >= p2_fis_numara
                             and sa.hesap_numara = r_satir.hesap_numara
                             and not exists (select 1 from muh_fis fis where fis.numara=sa.fis_numara and fis.muh_tarih < p_banking_date)
                             and exists (select 1 from muh_fis fs where fs.numara=sa.fis_numara and fs.tur='G')
                             ;
                       END IF;  denedik bu index zaten calismadi MHA 29052015 */
                     End if;
                 END IF;    
               END LOOP; -- satir  
              CLOSE lc_satir;
              if vc_batch_islem_var = 'E' then
                 Update MUH_BATCH_FIS_SATIR s
                    set s.durum='I'
                  where s.fis_numara=p_fis_numara
                    and s.durum='A';
              end if;        
          ELSE
            NULL;
          END IF;
        end if; --eod fisi
           -- fisin iptal tarihi set edilir
        UPDATE MUH_FIS
           SET iptal_edildigi_tarih = Pkg_Muhasebe.banka_tarihi_bul,
               tur='X'
         WHERE numara = p2_fis_numara
         ;
/*         begin
           update MUH_FIS_satir sa
               set sa.balance_flag= '0',
             where sa.fis_numara >= p2_fis_numara
               and sa.hesap_numara in (select s.hesap_numara from MUH_FIS_satir s
                                        where s.fis_numara=p2_fis_numara
                                          and s.hesap_tur_kodu in ('VS','VD','KR')
                                      );
            exception when others then 
                 null;
         end;*/
         
        close c_eod_fisi;
        
       END LOOP;
       CLOSE lc_fis;
    EXCEPTION
        WHEN OTHERS THEN
              Raise_application_error(-20100,SQLERRM);
    END;
-----------------------------------------------------------------------------------  
    PROCEDURE Gecici_Fis_iptal(p_fis_numara MUH_FIS.numara%TYPE) IS
    BEGIN
      UPDATE MUH_FIS                                
         SET iptal_edildigi_tarih = Pkg_Muhasebe.banka_tarihi_bul,
             tur='I'
       WHERE numara = p_fis_numara 
         AND tur='T';  
    EXCEPTION
    WHEN OTHERS THEN
       PKG_HATA.hata_yaz(238,TRUE,SQLERRM);
    END;
-----------------------------------------------------------------------------------

Procedure Net_Fon_Bakiye_Sil(pn_hesapNo Number) Is
Begin
  Update MUH_HESAP_bakiye  M
     Set M.Net_Fon_Bakiye = 0
   Where M.Hesap_No = pn_hesapNo
  ;
End;
-----------------------------------------------------------------------------------
Procedure Net_Fon_Bakiye_Upd(pn_hesapNo Number, pn_netFon_Bakiye Number, pn_Mevcut_Fon_Pay Number) Is
vn_fonhesapno Number;
vc_otofon     Varchar2(1);
vn_musteriNo  Number;
Begin
  Begin
    Select NVL(T.Otomatik_Fon,'H') Into vc_otofon
      From Muh_Hesap_Tanim T
     Where t.Hesap_No = pn_hesapNo
    ;
  Exception When Others Then
    vc_otofon := 'H';
  End ;
  If vc_otofon = 'E' Then
    vn_fonhesapno := pn_hesapNo;

    Update MUH_HESAP_bakiye  M
       Set M.Net_Fon_Bakiye = Round(pn_netFon_Bakiye,2),
           M.Mevcut_Fon_Pay = pn_Mevcut_Fon_Pay
     Where M.Hesap_No = vn_fonhesapno
    ;

  Elsif vc_otofon = 'H' Then
    /*vn_musteriNo := pkg_hesap.musteri_no(p_hesap_no => pn_hesapNo);
    Begin
      Select H.hesap_no Into vn_fonhesapno
        From muh_hesap_tanim T, Muh_Hesap H
       Where H.Musteri_No = vn_musteriNo
         And T.Otomatik_Fon = 'E'
         And T.Hesap_No     = H.Hesap_No
      ;
    Exception 
      When No_Data_Found Then
        Null;
      When Others Then
        Pkg_Hata.hata_yaz(1830);
    End;*/
    Null; /* Otomatik fon hesabını boşu boşuna bulup update etmesin MHA 10072014 */
  End If;
End;
--------------------------------------------------------------------------------  
Function Net_Fon_Bakiye_Al(pn_hesapNo Number) Return Number Is
vn_netfonbakiye  Number;
Begin
  Select NVL(net_fon_bakiye,0) Into vn_netfonbakiye
    From MUH_HESAP_bakiye  M
   Where M.Hesap_No = pn_hesapNo
  ;
  Return vn_netfonbakiye;
Exception When Others Then
  Return 0;
End;
end PKG_MUHASEBE;
/
