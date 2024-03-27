CREATE OR REPLACE PACKAGE Pkg_Hesap IS
  -- Author  : BILALG 
  -- Created : 15.10.2007 
  -- Purpose : Hesap fonksiyonlary i?in hazyrlandy

 Function iban(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.iban%type;
 Function iban_formatli(p_hesap_no muh_hesap.hesap_no%type) return varchar2;
 Function musteri_no(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.musteri_no%type;
 Function musteri_dk_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.musteri_dk_no%type;
 Function sube_kodu(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.sube_kodu%type;
 Function modul_tur_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.modul_tur_kod%type;
 Function urun_tur_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.urun_tur_kod%type;
 Function urun_sinif_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.urun_sinif_kod%type;
 Function kisa_isim(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kisa_isim%type;
 Function doviz_kodu(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.doviz_kodu%type;
 Function muhabir_hesap_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.muhabir_hesap_no%type;
 Function borclu_hesap_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.borclu_hesap_no%type;
 Function hesap_hareket_kodu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.hesap_hareket_kodu%type;
 Function esas_gun_sayisi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.esas_gun_sayisi%type;
 Function faiz_orani(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.faiz_orani%type;
 Function faiz_indikatoru(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.faiz_indikatoru%type;
 Function bakiye_turu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.bakiye_turu%type;
 Function acilis_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.acilis_tarihi%type;
 Function kapama_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kapama_tarihi%type;
 Function endeks_kodu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.endeks_kodu%type;
 Function kmh_dk_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kmh_dk_no%type;
 Function gecikme_donem_sayisi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.gecikme_donem_sayisi%type;
 Function takip_hesabi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.takip_hesabi%type;
 Function takip_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.takip_tarihi%type;


 Function cek_karnesi_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.cek_karnesi%type;
 Function dekont_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.dekont%type;
 Function durum_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.durum_kodu%type;
 Function acik_mi(p_hesap_no muh_hesap_tanim.hesap_no%type) return varchar2;
 Function badlist_flag(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.badlist_flag%type;
 Function maas_hesabi_mi(p_hesap_no muh_hesap_tanim.hesap_no%type, pb_Kes Boolean Default TRUE) return muh_hesap_tanim.maas_hesap_flag%type;
 Function otomatik_fon_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.otomatik_fon%type;
 Function of_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.of_kodu%type;
 Function otomatik_fatura_tahsilat_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.otomatik_fatura_tahsilat%type;
 Function mkk_durumu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_durumu%type;
 Function mkk_sicil_no(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_sicil_no%type;
 Function mkk_mernis_onay_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_mernis_onay%type;
 Function mkk_vkn_onay_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_vkn_onay%type;
 Function mkk_kimlik_eslesme_durumu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_kimlik_eslesme_durumu%type;
 Function destek_faiz_tahsil_period(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_faiz_tahsil_period%type;
 Function destek_faiz_gun(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_faiz_gun%type;
 Function destek_hesap_limiti(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_hesap_limiti%type;
 Function hesap_ucreti_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.hesap_ucreti_f%type;
 Function ortak_hesap_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ortak_hesap_f%type;
 Function ekstre_basim_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_basim_kodu%type;
 Function ekstre_sikligi(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_sikligi%type;
 Function min_imza_adedi(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.min_imza_adedi%type;
 Function ekstre_noterden(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_noterden%type;
 Function muhabirdeki_hesabimiz(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.muhabirdeki_hesabimiz%type;
 FUNCTION GeriDonusHesapNo(pn_hesap_no MUH_HESAP_VADELI.HESAP_NO%TYPE) RETURN NUMBER;

-----
 Function bloke_tutari_al(pn_hesap_no muh_hesap.hesap_no%type) return muh_hesap_bakiye.bloke_tutari%type;

 PROCEDURE BakiyeBilgiAl(pn_hesap_no muh_HESAP.HESAP_NO%TYPE,
  		 			             pn_bakiye OUT muh_HESAP_BAKIYE.bakiye%TYPE,
					               pn_birikmis_faiz_neg OUT muh_HESAP.BIRIKMIS_FAIZ_NEG%TYPE,
    				             pn_birikmis_faiz_poz OUT muh_HESAP.BIRIKMIS_FAIZ_POZ%TYPE) ;
---
 FUNCTION DevirBakiyeAl(pn_hesapno NUMBER,pn_yil NUMBER,pn_ay NUMBER, pn_gun NUMBER) RETURN NUMBER;
---
 FUNCTION HesapBakiyeAl(pc_hesap_no VARCHAR2) RETURN NUMBER;
 --
 FUNCTION ValorluBakiyeAl(pn_hesap_no varchar2) RETURN NUMBER;
---
 FUNCTION KMH_ValorluBakiyeAl(pn_hesap_no varchar2, pd_tarih date default null) RETURN NUMBER;
---
 PROCEDURE Bakiye_Guncelle(pv_hesap_turu   IN VARCHAR2,
 							            pv_hesap_no     IN MUH_FIS_SATIR.HESAP_NUMARA%TYPE,
						              pv_doviz_kod    IN MUH_FIS_SATIR.DOVIZ_KOD%TYPE,
						              pv_tur          IN MUH_FIS_SATIR.B_A%TYPE,
						              pv_fc_tutar     IN MUH_FIS_SATIR.DV_TUTAR%TYPE,
						              pv_lc_tutar     IN MUH_FIS_SATIR.LC_TUTAR%TYPE,
						              pn_fis_numara   IN MUH_FIS_SATIR.fis_numara%TYPE,
                          pn_sonraki_bakiye OUT MUH_FIS_SATIR.DV_TUTAR%TYPE) ;

 PROCEDURE BlokeTutariGuncelle(pn_hesap_no MUH_HESAP_BAKIYE.HESAP_NO%TYPE,pn_bloke_tutari	MUH_HESAP_BAKIYE.BLOKE_TUTARI%TYPE, pc_bloke_neden_kod muh_bloke.bloke_neden_kodu%type default null);
  
 FUNCTION GecerliDKHesap(ps_dkhesap VARCHAR2,ps_sube_kodu VARCHAR2, ps_doviz_kodu VARCHAR2) RETURN BOOLEAN;

 PROCEDURE hesap_bakiye_olustur( pn_hesap_no MUH_HESAP_BAKIYE.hesap_no%TYPE,
 		   						               pn_bakiye MUH_HESAP_BAKIYE.hesap_no%TYPE,
								                 pn_bloke_tutari MUH_HESAP_BAKIYE.bloke_tutari%TYPE,
								                 pn_valorlu_bakiye MUH_HESAP_BAKIYE.bloke_tutari%TYPE,
								                 pn_bakiye_karakteri  MUH_HESAP_BAKIYE.bakiye_karakteri%TYPE DEFAULT NULL) ;

  PROCEDURE VadesizBilgiAktar(pn_hesap_no IN VARCHAR2,p_txno IN NUMBER);
  PROCEDURE VadeliBilgiAktar(pn_hesap_no IN VARCHAR2,p_txno IN NUMBER);

	FUNCTION HesapUzerindeBlokeKayitli(pn_hesap_no VARCHAR2) RETURN BOOLEAN;
 
  FUNCTION Hesap_hacizli_mi(p_hesap_no MUH_HESAP.hesap_no%TYPE ) RETURN VARCHAR2;

  Procedure Personel_Hesap_Sorgulama_Log(pn_hesap_no in number,pn_sorgu_sonucu in number);
  FUNCTION Personel_Hesap_Mi(pn_hesap_no Muh_HESAP.HESAP_NO%TYPE) RETURN NUMBER;  --1 yes personel, else no
  FUNCTION Personel_Bakiye_Gosterilsin(pn_hesap_no MUH_HESAP.HESAP_NO%TYPE) RETURN NUMBER;  --1 yes show, else no
  FUNCTION Kullanilabilir_Bakiye_Al( pn_hesap_no MUH_HESAP_BAKIYE.hesap_no%TYPE, 
                                     pn_islem_kod MUH_ISLEM_TANIM_PR.KOD%TYPE Default Null,
                                     pc_kmh_grup_kod kmh_tanim.kmh_grup_kod%type default null,
																		 pc_fon_kmh_haric Varchar2 Default Null,
                                     pc_bakiye_sifirlama varchar2 default Null) RETURN MUH_HESAP_BAKIYE.bakiye%TYPE;

  Function Kullanici_kendi_hesabi_mi(pn_hesap_no number) return varchar;

  -- Vadeli hesap acilisda doviz ve gun farkindan urun sinifi bulur
  FUNCTION Vadeli_Urun_Sinif_Bul(ps_doviz  varchar2,
	                						   pd_muhasebe_tarihi date,
							                   pd_vade_tarihi date) RETURN varchar2;
  
  -- Vadeli hesap uzerindeki bakiye+gecen yil ve birikmis faizleri alir
  -- %param pn_hesap_no vadeli hesap numarasi                               
  PROCEDURE FaizBilgiAl(pn_hesap_no Muh_Hesap_Vadeli.HESAP_NO%TYPE,
                        pn_bakiye OUT Muh_Hesap_Bakiye.bakiye%TYPE,
                        pn_gecen_yil_faizi OUT Muh_Hesap_Vadeli.Gecen_Yil_Faiz_Toplami%TYPE,
                        pn_birikmis_faiz OUT Muh_Hesap.Birikmis_Faiz_Poz%TYPE);
  -- Musteriye ait vadeli faiz oranyny bulan function.
  -- Marj tanymly ise onu da dikkate alyr
  -- Ayni function ile max ne faiz girilebilir cekmek icin Gec_Max 'M' gonderilir.
  -- %param pn_hesap_no vadeli hesap numarasi
  -- %param pn_gun_sayisi vadeli hesap gun sayysy
  -- %param ps_doviz_kodu vadeli hesap doviz kodu
  -- %param pn_tutar vadeli hesap tutary
  -- %param ps_gec_Max 'G' ise musteri icin gecerli faiz orani,'X' ise verilebilecek max faiz orani doner,'N' ise min faizi 
  FUNCTION Vadeli_Faiz_Oran_Al(pn_musteri_no in number,
                               pn_gun_sayisi NUMBER,
                               ps_doviz_kodu VARCHAR2,
                               pn_tutar NUMBER,
                               ps_Gec_Max VARCHAR2 DEFAULT 'G') RETURN NUMBER;
  -- Musteriye ait vadeli faiz oranyny bulan function.
  -- Marj tanymly ise onu da dikkate alyr
  -- Ayni function ile max ne faiz girilebilir cekmek icin Gec_Max 'M' gonderilir.
  -- %param pn_hesap_no vadeli hesap numarasi
  -- %param pn_gun_sayisi vadeli hesap gun sayysy
  -- %param ps_doviz_kodu vadeli hesap doviz kodu
  -- %param pn_tutar vadeli hesap tutary
  -- %param ps_gec_Max 'G' ise musteri icin gecerli faiz orani,'X' ise verilebilecek max faiz orani doner,'N' ise min faizi 
  -- %param ps_overnight 'E' ise ON vade kodlu faiz oranlaryny alyr.
  FUNCTION Vadeli_Mevduat_Faiz_Oran_Al
                              (pn_musteri_no in number,
                               pn_gun_sayisi NUMBER,
                               ps_doviz_kodu VARCHAR2,
                               pn_tutar NUMBER,
                               ps_Gec_Max VARCHAR2 DEFAULT 'G',
                               ps_overnight VARCHAR2 DEFAULT 'H') RETURN NUMBER; 
                               
                               
  FUNCTION VadesizHesapVar(pn_hesap_no MUH_HESAP.HESAP_NO%TYPE, ls_doviz MUH_HESAP.DOVIZ_KODU%TYPE) RETURN BOOLEAN;
  FUNCTION IBAN_VadesizHesapVar(ps_IBAN MUH_HESAP.iban%TYPE) RETURN number;
  FUNCTION IBANdan_HesapNoAl(ps_IBAN MUH_HESAP.iban%TYPE) RETURN number;
  
	FUNCTION Modul_tur_Vadesiz RETURN VARCHAR2; 
  -- Sube Kodu,M??teri No,Hesap no ve D?viz Kodu uyumunu check eder.
  -- %param pn_sube ekranda hesap i?in girilen ?ube,yoksa global sube
  -- %param pn_musteri_no i?lem yapylacak m??teri numarasy
  -- %param pn_hesap_no i?lem yapylacak hesap numarasy
  -- %param ps_doviz ekranda girilen doviz kodu,yoksa lc
  Procedure Customer_Account_Control(ps_sube in varchar2,pn_musteri_no in number,pn_hesap_no in number,ps_doviz in varchar2);                              
    -- Hesap bakiyesini islem tutari ile karsilastirir.
  -- uygun ise 1 yetersiz ise 0 doner.
  -- %param pn_hesap_no islem yapilan hesap numarasi
  -- %param pn_islem_tutar islem yapilacak tutar
  -- %param pn_mesaj bakiye yetersiz ise donecek mesaj
  Function account_balance_control(pn_hesap_no in number,pn_islem_tutar in number,pn_mesaj out varchar2) return varchar2;
  Function gonderen_bul(pn_islem_kod in number,pn_islem_no in number) return varchar2;
  Function HesapHareket( pn_hesapno Number, pd_bastar Date, pd_bittar Date, pc_IslemTip Varchar2, pc_KanalTip Varchar2,
                         pn_Mintutar Number Default Null,  pn_Maxtutar Number Default Null, pc_dil_kod  varchar2 Default 'TR') Return Pkg_Types.RC_ResultSet;
  Function HesapHareket( pn_islem_no Number) Return Pkg_Types.RC_ResultSet; 
  -- Hesabin islemin borc/alacak olmasi acisindan uygunlugunu kontrol eder.
  -- %param pn_hesap_no   islem yapilan hesap numarasi
  -- %param ps_b_a        B / A
  Procedure account_trntype_control(pn_hesap_no in number,ps_b_a in varchar2);
  Function HesapListe( pn_musterino Number, pc_dov Varchar2 Default Null, pn_hesapno Number Default Null, 
                       pc_kredilerDahilMi Varchar2 Default Null,ps_kisit_kod in varchar2 default null,
                       pc_goruntule_kontrol Varchar2 default 'E',pc_durum_kod varchar2 default 'A') Return Pkg_Types.RC_ResultSet;
  FUNCTION DevirBakiye(pn_hesapno NUMBER,pd_tar DATE) RETURN NUMBER;          

 Procedure vadesiz_hesap_acilis(pn_musteri_no in number,
                                ps_modul_tur_kod in varchar2,
																ps_urun_tur_kod in varchar2,
																ps_urun_sinif_kod in varchar2,
																ps_sube_kodu in varchar2 default pkg_global.GET_SUBEKOD,
																ps_doviz_kod in varchar2 default pkg_genel_pr.lc_al,
																ps_hesap_ucreti_f in varchar2 default 'H',
                                pn_hesap_no in out number);

  FUNCTION VadeliHesapAcilis(pn_MUSTERI_NO	   NUMBER,
                ps_MODUL_TUR_KOD VARCHAR2,
                ps_URUN_TUR_KOD VARCHAR2,
                ps_URUN_SINIF_KOD VARCHAR2,
                ps_KISA_ISIM VARCHAR2,
                ps_DOVIZ_KODU VARCHAR2,
                ps_SUBE_KODU VARCHAR2,
                pn_TUTAR NUMBER,
                pd_VALOR_TARIHI DATE,
                pn_VADE_ISLEM_BILGISI NUMBER,
                pn_ARA_ODEME_BILGISI NUMBER,
                ps_OTOMATIK_TEMDIT VARCHAR2,
                pn_PERIOD_SURE NUMBER,
                ps_PERIOD_CINS VARCHAR2,
                pd_SONRAKI_BASLANGIC_TARIHI DATE,
                pn_ARA_ODEME_ISLEM_BILGISI NUMBER,
                pd_VADE_TARIHI DATE,
                pn_GERI_DONUS_HESAPNO NUMBER,
                pn_ESAS_GUN_SAYISI NUMBER,
                pn_FAIZ_ORANI NUMBER,
                ps_ACIKLAMA VARCHAR2,
                ps_REFERANS	VARCHAR2,
                ps_EKSTRE_BASIM_KODU VARCHAR2 DEFAULT 'X',
                ps_EKSTRE_SIKLIGI VARCHAR2 DEFAULT NULL,
                ps_DEKONT VARCHAR2 DEFAULT 'X',
                pd_acilis_tarihi DATE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                ps_islemturu		VARCHAR2 DEFAULT NULL,
                pn_negatif_faiz		NUMBER DEFAULT 0) RETURN NUMBER;                                

  PROCEDURE HesapDurumGuncelle(ps_tur VARCHAR2,pn_hesap_no NUMBER,ps_durum_kodu VARCHAR2);	
  
	FUNCTION GecenYilFaizToplami(pn_hesap_no NUMBER) RETURN NUMBER;
	FUNCTION BirikmisFaizPoz(pn_hesap_no NUMBER) RETURN NUMBER;
	FUNCTION BirikmisFaizNeg(pn_hesap_no NUMBER) RETURN NUMBER;
	PROCEDURE FaizBakiyeGuncelle(pn_islem_no NUMBER,ps_tur VARCHAR2,ps_islem_tur VARCHAR2,pn_hesap_no NUMBER,pn_tutar NUMBER);

  FUNCTION HesapTuru(pn_hesap_no NUMBER) RETURN varchar2;
  
  function VadesizHesapNo(pn_musteriNo number, pc_subeKodu varchar2, pc_dovizKodu varchar2) return number;								         
  function esas_gun_sayisi_kr return number;
  function esas_gun_sayisi_vd return number;
  Function Gercek_Ticari_Diger_Musteri(pn_musteri_no in number) Return number;

  Procedure Rezerv_Vadesiz_Hesap_Acilis(pn_musteri_no number, 
                                        pc_doviz_kodu varchar2 default pkg_genel_pr.lc_al,
                                        pc_aciklama varchar2 default null
                                        );

  Function Aktif_Fon_Hesap(pn_musteriNo number) return number;
  
  Function TuzelKurumsalKdhEksiBakiyeTop(pn_hesap_no muh_hesap.hesap_no%type, pc_kendi_dahil VARCHAR2 DEFAULT 'E') return number;
 Function BeyazListeWsKontrol(pn_hesap_no gnl_beyaz_liste_hesap_ws.hesap_no%type,pn_kanal_kod gnl_beyaz_liste_hesap_ws.kanal_kod%type := null) return number;

end;
/
CREATE OR REPLACE PACKAGE BODY Pkg_Hesap IS

 Function iban(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.iban%type is
    vc_iban varchar2(30);
 begin
   IF p_hesap_no is not null then 
       select h.iban
         into vc_iban
         from muh_hesap h  
        where h.hesap_no = p_hesap_no
        union
       select k.iban
         from muh_hesap_kredi k  
        where k.hesap_no = p_hesap_no
        union
       select v.iban
         from muh_hesap_vadeli v  
        where v.hesap_no = p_hesap_no;
       return vc_iban; 
      --return pkg_tablo.hesap_kayit_izleme(p_hesap_no).iban;
   ELSE
      return null;
   ENd IF;      
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;  
 
 Function iban_formatli(p_hesap_no muh_hesap.hesap_no%type) return varchar2 is
 vn_iban   muh_hesap.iban%type;
-- vn_formatted varchar2(25) := null;
 begin
   IF p_hesap_no is not null then 
      /*select f.IBAN
        into vn_iban
        from v_muh_hesap_izleme_tum f
       where f.hesap_no=p_hesap_no; */
    --  vn_iban := pkg_tablo.hesap_kayit_izleme(p_hesap_no).iban;
       vn_iban := iban(p_hesap_no);
       return substr(vn_iban,1,4) || ' ' ||
              substr(vn_iban,5,4) || ' ' ||
              substr(vn_iban,9,4) || ' ' ||
              substr(vn_iban,13,4) || ' ' ||
              substr(vn_iban,17,4) || ' ' ||
              substr(vn_iban,21,4) || ' ' ||
              substr(vn_iban,25,2);
         
   ELSE
      return null;
   ENd IF;        
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end iban_formatli;  

 Function musteri_no(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.musteri_no%type is
    vn_musteri_no number;
 begin
   if p_hesap_no is not null then
      if NVL(p_tum_kisitli,'T') = 'T' then
         select h.musteri_no
           into vn_musteri_no
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.musteri_no
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.musteri_no
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

         return vn_musteri_no;
      else
         return pkg_tablo.hesap_kayit_izleme_kisitli(p_hesap_no).musteri_no;   
      end if;   
   else
      return null;
   end if;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;  
 
 Function musteri_dk_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.musteri_dk_no%type is
    vc_musteri_dk_no  varchar2(30);
 begin
         select h.musteri_dk_no
           into vc_musteri_dk_no
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.musteri_dk_no
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.musteri_dk_no
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vc_musteri_dk_no;

 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;  
 
 Function sube_kodu(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.sube_kodu%type is
    vc_sube_kodu varchar2(10);
 begin
    if NVL(p_tum_kisitli,'T') = 'T' then
         select h.sube_kodu
           into vc_sube_kodu
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.sube_kodu
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.sube_kodu
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;
        return vc_sube_kodu;
    else    
        return pkg_tablo.hesap_kayit_izleme_kisitli(p_hesap_no).sube_kodu;
     end if;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;   

 Function modul_tur_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.modul_tur_kod%type is
   vc_modul_tur_kod varchar2(30);
 begin
         select h.modul_tur_kod
           into vc_modul_tur_kod
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.modul_tur_kod
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.modul_tur_kod
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;
   return vc_modul_tur_kod;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;

 Function urun_tur_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.urun_tur_kod%type is
   vc_urun_tur_kod varchar2(30);
 begin
         select h.urun_tur_kod
           into vc_urun_tur_kod
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.urun_tur_kod
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.urun_tur_kod
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;
   return vc_urun_tur_kod;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;
 
 Function urun_sinif_kod(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.urun_sinif_kod%type is
   vc_urun_sinif_kod varchar2(30);
 begin
         select h.urun_sinif_kod
           into vc_urun_sinif_kod
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.urun_sinif_kod
           from muh_hesap_kredi k
          where k.hesap_no = p_hesap_no
          union
         select v.urun_sinif_kod
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vc_urun_sinif_kod;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;
 
 Function kisa_isim(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kisa_isim%type is
    vc_kisa_isim varchar2(200);
 begin
         select h.kisa_isim
           into vc_kisa_isim
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.kisa_isim
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.kisa_isim
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;
   return vc_kisa_isim;
  exception when others then
   return null;
 end;
 
 Function doviz_kodu(p_hesap_no muh_hesap.hesap_no%type,p_tum_kisitli in varchar2 default 'T') return muh_hesap.doviz_kodu%type is
    vc_doviz_kodu varchar2(10);
 begin
    if NVL(p_tum_kisitli,'T')='T' then
         select h.doviz_kodu
           into vc_doviz_kodu
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.doviz_kodu
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.doviz_kodu
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

       return vc_doviz_kodu;
    else
       return pkg_tablo.hesap_kayit_izleme_kisitli(p_hesap_no).doviz_kodu;
    end if;   
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end; 
  
 Function muhabir_hesap_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.muhabir_hesap_no%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).muhabir_hesap_no;
 end;
 
 Function borclu_hesap_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.borclu_hesap_no%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).borclu_hesap_no;
 end; 

 Function hesap_hareket_kodu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.hesap_hareket_kodu%type is
   vn_hareket_kodu number;
 begin
         select h.hesap_hareket_kodu
           into vn_hareket_kodu
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vn_hareket_kodu;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;
 
 Function esas_gun_sayisi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.esas_gun_sayisi%type is
   vn_esas_gun_sayisi number;
 begin
         select h.esas_gun_sayisi
           into vn_esas_gun_sayisi
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.esas_gun_sayisi
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.esas_gun_sayisi
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vn_esas_gun_sayisi;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end; 

 Function faiz_orani(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.faiz_orani%type is
   vn_faiz_orani number;
 begin
         select h.faiz_orani
           into vn_faiz_orani
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.faiz_orani
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.faiz_orani
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vn_faiz_orani;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;

 Function faiz_indikatoru(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.faiz_indikatoru%type is
    vn_faiz_indikatoru number;
 begin
         select h.faiz_indikatoru
           into vn_faiz_indikatoru
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vn_faiz_indikatoru;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end; 

 Function bakiye_turu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.bakiye_turu%type is
   vn_bakiye_turu muh_hesap.bakiye_turu%type;
 begin
         select h.bakiye_turu
           into vn_bakiye_turu
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select null
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vn_bakiye_turu;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;

 Function acilis_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.acilis_tarihi%type is
   vd_acilis_tarihi date;
 begin
         select h.acilis_tarihi
           into vd_acilis_tarihi
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.acilis_tarihi
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.acilis_tarihi
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vd_acilis_tarihi;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end; 

 Function kapama_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kapama_tarihi%type is
   vd_kapama_tarihi date;
 begin
         select h.kapama_tarihi
           into vd_kapama_tarihi
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.kapanis_tarihi
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.kapama_tarihi
           from muh_hesap_vadeli v  
          where v.hesap_no = p_hesap_no;

   return vd_kapama_tarihi;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end;

 Function endeks_kodu(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.endeks_kodu%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).endeks_kodu;
 end; 

 Function kmh_dk_no(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.kmh_dk_no%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).kmh_dk_no;
 end;

 Function gecikme_donem_sayisi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.gecikme_donem_sayisi%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).gecikme_donem_sayisi;
 end; 

 Function takip_hesabi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.takip_hesabi%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).takip_hesabi;
 end;

 Function takip_tarihi(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap.takip_tarihi%type is
 begin
   return pkg_tablo.hesap_kayit(p_hesap_no).takip_tarihi;
 end; 


 Function cek_karnesi_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.cek_karnesi%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).cek_karnesi;
 end; 

 Function dekont_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.dekont%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).dekont;
 end; 
 
 Function durum_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.durum_kodu%type is
   vc_durum_kodu varchar2(30);
 begin
         select h.durum_kodu
           into vc_durum_kodu
           from muh_hesap h  
          where h.hesap_no = p_hesap_no
          union
         select k.durum_kodu
           from muh_hesap_kredi k  
          where k.hesap_no = p_hesap_no
          union
         select v.durum_kodu
           from muh_hesap_vadeli v
          where v.hesap_no = p_hesap_no;

   return vc_durum_kodu;
 exception when no_data_found then
   pkg_hata.hata_yaz(201,true,p_hesap_no);
 end; 

 Function acik_mi(p_hesap_no muh_hesap_tanim.hesap_no%type) return varchar2 is
 begin
   if pkg_tablo.hesap_tanim_kayit(p_hesap_no).durum_kodu ='A' then
      return 'E';
   else
      return 'H';
   end if;
      
 end; 

 Function badlist_flag(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.badlist_flag%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).badlist_flag;
 end; 

 Function maas_hesabi_mi(p_hesap_no muh_hesap_tanim.hesap_no%type, pb_Kes Boolean Default TRUE) return muh_hesap_tanim.maas_hesap_flag%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no, pb_Kes).maas_hesap_flag;
 end; 
 
 Function otomatik_fon_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.otomatik_fon%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).otomatik_fon;
 end; 
 
 Function of_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.of_kodu%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).of_kodu;
 end; 

 Function otomatik_fatura_tahsilat_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.otomatik_fatura_tahsilat%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).otomatik_fatura_tahsilat;
 end; 

 Function mkk_durumu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_durumu%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).mkk_durumu;
 end; 

 Function mkk_sicil_no(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_sicil_no%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).mkk_sicil_no;
 end; 

 Function mkk_mernis_onay_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_mernis_onay%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).mkk_mernis_onay;
 end; 

 Function mkk_vkn_onay_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_vkn_onay%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).mkk_vkn_onay;
 end; 

 Function mkk_kimlik_eslesme_durumu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.mkk_kimlik_eslesme_durumu%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).mkk_kimlik_eslesme_durumu;
 end; 

 Function destek_faiz_tahsil_period(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_faiz_tahsil_period%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).destek_faiz_tahsil_period;
 end; 

 Function destek_faiz_gun(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_faiz_gun%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).destek_faiz_gun;
 end; 

 Function destek_hesap_limiti(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.destek_hesap_limiti%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).destek_hesap_limiti;
 end; 
 
 Function hesap_ucreti_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.hesap_ucreti_f%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).hesap_ucreti_f;
 end; 
 
 Function ortak_hesap_f(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ortak_hesap_f%type is
 begin
   --return pkg_tablo.hesap_tanim_kayit(p_hesap_no).ortak_hesap_f; MHA 160108 artyk ortak hesap hesap acarken tanimlanmiyor.
   IF pkg_musteri.tur(pkg_hesap.musteri_no(p_hesap_no)) = 'O' THEN
      return 'E';
   ELSE
      return 'H';
   END If;      
 end; 
  
 Function ekstre_basim_kodu(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_basim_kodu%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).ekstre_basim_kodu;
 end; 
      
 Function ekstre_sikligi(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_sikligi%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).ekstre_sikligi;
 end; 

 Function min_imza_adedi(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.min_imza_adedi%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).min_imza_adedi;
 end; 

 Function ekstre_noterden(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.ekstre_noterden%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).ekstre_noterden;
 end; 

 Function muhabirdeki_hesabimiz(p_hesap_no muh_hesap_tanim.hesap_no%type) return muh_hesap_tanim.muhabirdeki_hesabimiz%type is
 begin
   return pkg_tablo.hesap_tanim_kayit(p_hesap_no).muhabirdeki_hesabimiz;
 end; 

  FUNCTION GeriDonusHesapNo(pn_hesap_no MUH_HESAP_VADELI.HESAP_NO%TYPE) RETURN NUMBER IS
       vn_geridonus_hesapno      NUMBER;
  BEGIN
     vn_geridonus_hesapno := Pkg_Tablo.hesap_kayit_vadeli(pn_hesap_no).geri_donus_hesapno;
     RETURN vn_geridonus_hesapno;
  EXCEPTION
      WHEN OTHERS THEN
         RETURN NULL;
  END;
------------------ Bloke Tutary Alma ------------------------------ 
 Function bloke_tutari_al(pn_hesap_no muh_hesap.hesap_no%type) return muh_hesap_bakiye.bloke_tutari%type is
     vn_bloke           NUMBER;
 BEGIN
/*   SELECT b.bloke_tutari
     INTO vn_bloke
     FROM V_MUH_HESAP_IZLEME_tum b
    WHERE hesap_no=pn_hesap_no;*/

     if pkg_parametre.ParamTextDegerVarMi('BLOKE_TUTAR_ISTISNA_HESAP',pn_HESAP_NO)='E' THEN
        vn_bloke := pkg_bloke.Hesap_bloke_tutari(pn_hesap_no);
     else
        select bloke_tutari
          into vn_bloke
          from MUH_HESAP_BAKIYE
         where hesap_no=pn_hesap_no;
     end if;   
     
   RETURN vn_bloke;

 end; 
------------------ BAkiye izleme ------------------------------
PROCEDURE BakiyeBilgiAl(pn_hesap_no muh_HESAP.HESAP_NO%TYPE,
                         pn_bakiye OUT muh_HESAP_BAKIYE.bakiye%TYPE,
                        pn_birikmis_faiz_neg OUT muh_HESAP.BIRIKMIS_FAIZ_NEG%TYPE,
                        pn_birikmis_faiz_poz OUT muh_HESAP.BIRIKMIS_FAIZ_POZ%TYPE) IS
     --ln_bakiye cbs_hes_bak.bakiye%TYPE;
     Hesap_Bulunamadi_Exception EXCEPTION;
       CURSOR hesap_cursor (p_hesapno muh_HESAP.HESAP_NO%TYPE) IS
       SELECT bakiye,BIRIKMIS_FAIZ_NEG,BIRIKMIS_FAIZ_POZ
        FROM  v_muh_hesap_izleme_tum
        WHERE hesap_no=p_hesapno;

  BEGIN
       OPEN hesap_cursor(pn_hesap_no);
     FETCH hesap_cursor INTO pn_bakiye,pn_birikmis_faiz_neg, pn_birikmis_faiz_poz;
     IF hesap_cursor%NOTFOUND THEN
          CLOSE hesap_cursor;
          RAISE Hesap_Bulunamadi_Exception;
       END IF;

       CLOSE hesap_cursor;

   EXCEPTION
         WHEN Hesap_Bulunamadi_Exception THEN
             PKG_HATA.hata_yaz(201,TRUE,pn_hesap_no);
  END;
 -----------------------------------------------------------------
  FUNCTION DevirBakiyeAl(pn_hesapno NUMBER,pn_yil NUMBER,pn_ay NUMBER, pn_gun NUMBER) RETURN NUMBER IS
     vn_bakiye            NUMBER;
     vd_date            DATE;
  BEGIN
   
   vd_date:=TO_DATE(TO_CHAR(pn_yil) || '/'|| TO_CHAR(pn_ay) ||'/' || TO_CHAR(pn_gun),'YYYY/MM/DD');
   If vd_date = pkg_muhasebe.Banka_Tarihi_Bul Then
     Return pkg_hesap.HesapBakiyeAl(pn_hesapno );
   Else
     SELECT b.BAKIYE
       INTO vn_bakiye
       FROM MUH_HESAP_GUNLUK_BAKIYE b
      WHERE b.hesap_no = pn_hesapno
        AND yil        = pn_yil 
        AND ay         = pn_ay 
        AND gun        = pn_gun;
      RETURN vn_bakiye;
   End If;
   
EXCEPTION
   WHEN OTHERS THEN
       RETURN NULL;
    
END;  
---------------------------------------------------------------------
  FUNCTION DevirBakiye(pn_hesapno NUMBER,pd_tar DATE) RETURN NUMBER IS
     vn_bakiye          NUMBER;
     vd_date            DATE;
  BEGIN
   If pkg_tarih.gun_ozellik(pd_tar) = 0 Then --isg?n?
     vd_date := pd_tar;
   Else --tatil
   --  vd_date := pkg_tarih.ileri_is_gunu(pd_tar);
     vd_date := pkg_tarih.geri_is_gunu(pd_tar);     
   End If;
   
   If vd_date = pkg_muhasebe.Banka_Tarihi_Bul Then
     vn_bakiye := pkg_hesap.HesapBakiyeAl(pn_hesapno );
   else
     SELECT b.BAKIYE
       INTO vn_bakiye
       FROM MUH_HESAP_GUNLUK_BAKIYE b
      WHERE b.hesap_no = pn_hesapno
        AND yil        = TO_NUMBER(TO_CHAR(vd_date,'YYYY')) 
        AND ay         = TO_NUMBER(TO_CHAR(vd_date,'MM')) 
        AND gun        = TO_NUMBER(TO_CHAR(vd_date,'DD'));
   end if;
   
   RETURN vn_bakiye;
   
EXCEPTION
   WHEN OTHERS THEN
       RETURN NULL;
    
END;
  
  
------------------------ bakiye alma -----------------------------
FUNCTION HesapBakiyeAl(pc_hesap_no varchar2) RETURN NUMBER IS
     vn_bakiye           NUMBER;
     vn_eod_tutar        Number;
BEGIN
   Select BAKIYE
     Into vn_bakiye
     From MUH_HESAP_BAKIYE
    Where hesap_no = to_number(pc_hesap_no)
   ;
   If Pkg_Batch.Gun_sonu_mu OR Pkg_Batch.Gun_sonu_sonrasi_mi Then
    SELECT /*+ INDEX(S PK_MUH_HAREKET_SATIR) */ SUM( DECODE(s.b_a,'A', NVL(dv_tutar,0), -1 * NVL(dv_tutar,0)))
      INTO vn_eod_tutar
      FROM MUH_FIS_SATIR s, MUH_EOD_FIS_NO ef
     WHERE s.fis_numara   = ef.fis_numara
       AND ef.durum       = 'A'
       AND s.hesap_numara = pc_hesap_no
       AND s.hesap_tur_kodu <> 'DK';
    End If; 
   RETURN nvl(vn_bakiye,0) + NVL(vn_eod_tutar,0);
   
  EXCEPTION
   WHEN OTHERS THEN
       RETURN NULL;
END;
------------------------ bakiye alma -----------------------------
FUNCTION ValorluBakiyeAl(pn_hesap_no varchar2) RETURN NUMBER IS
     vn_bakiye           NUMBER;
BEGIN
   SELECT a.valorlu_bakiye
     INTO vn_bakiye
     FROM MUH_HESAP_Bakiye a
    WHERE hesap_no=pn_hesap_no;

   RETURN vn_bakiye;
END; 
------------------------ KMH Faize Esas bakiye alma -----------------------------
FUNCTION KMH_ValorluBakiyeAl(pn_hesap_no varchar2, pd_tarih date default null) RETURN NUMBER IS
     vn_bakiye           NUMBER;
     vd_bankatarihi date:=pkg_muhasebe.Banka_Tarihi_Bul;
BEGIN
   SELECT faiz_bakiye
     INTO vn_bakiye
     FROM KMH_HAREKET a
    WHERE hesap_no=pn_hesap_no
      AND tarih = nvl(pd_tarih, vd_bankatarihi)
      AND sira_no = ( SELECT max(sira_no)
                        FROM KMH_HAREKET
                       WHERE hesap_no=pn_hesap_no
                         AND tarih = nvl(pd_tarih, vd_bankatarihi)
                      );

    RETURN vn_bakiye;
  Exception When No_Data_Found Or Too_Many_Rows Then
/*      Begin
           SELECT faiz_bakiye
             INTO ln_bakiye
             FROM KMH_HAREKET a
            WHERE hesap_no=pn_hesap_no
              AND tarih = ( SELECT max(tarih)
                                FROM KMH_HAREKET
                               WHERE hesap_no=pn_hesap_no
                           )
              AND sira_no = ( SELECT max(sira_no)
                                FROM KMH_HAREKET
                               WHERE hesap_no=pn_hesap_no
                                 AND Tarih = ( SELECT max(tarih)
                                                  FROM KMH_HAREKET
                                                 WHERE hesap_no=pn_hesap_no
                                               )
                              );
                RETURN ln_bakiye;
          Exception When No_Data_Found Or Too_Many_Rows Then
            RETURN  HesapBakiyeAl(pn_hesap_no);
      End;*/
      Return HesapBakiyeAl(pn_hesap_no);
END; 
----------------------------  BAKIYE GUNCELLE ------------------
  PROCEDURE Bakiye_Guncelle(pv_hesap_turu   IN VARCHAR2,
                            pv_hesap_no     IN MUH_FIS_SATIR.HESAP_NUMARA%TYPE,
                            pv_doviz_kod    IN MUH_FIS_SATIR.DOVIZ_KOD%TYPE,
                            pv_tur          IN MUH_FIS_SATIR.B_A%TYPE,
                            pv_fc_tutar     IN MUH_FIS_SATIR.DV_TUTAR%TYPE,
                            pv_lc_tutar     IN MUH_FIS_SATIR.LC_TUTAR%TYPE,
                            pn_fis_numara   IN MUH_FIS_SATIR.fis_numara%TYPE,
                            pn_sonraki_bakiye OUT MUH_FIS_SATIR.DV_TUTAR%TYPE) IS

      vn_initial_bakiye        NUMBER;
      vn_bloke_tutari          NUMBER;
      vn_last_bakiye          NUMBER;
      vs_modul_tur_kod        varchar2(25); --muh_islem.Modul_Tur_Kod%Type;
      vs_bakiye_karakteri      VARCHAR(1);
      vs_urun_tur_kod          varchar2(50);--muh_islem.Urun_Tur_Kod%Type;
      vs_urun_sinif_kod        varchar2(50);--Muh_Islem.Urun_Sinif_Kod%Type;
      vs_durum_kodu            VARCHAR2(1);
      vn_destek_orj           Number;

      Hesap_Bulunamadi_Exception      EXCEPTION;
      Bakiye_Yetersiz_Exception       EXCEPTION;
      Bakiye_Negatif_Olamaz            EXCEPTION;
      Bakiye_Pozitif_Olamaz            EXCEPTION;
      Kapali_Hesap_Hareket_Yaratma   EXCEPTION;
      Borc_hareket_girilemez         EXCEPTION;
      Alacak_hareket_girilemez       EXCEPTION;
      hareket_girilemez              EXCEPTION;
      Kmh_Bu_islemde_kullanilamaz    EXCEPTION;
      Kmh_vadesi_dolmus              EXCEPTION;
      Kmh_Limiti_Asildi              EXCEPTION;
      Kmh_Statu_Uygun_Degil          EXCEPTION;     
      
      vn_eod_tutar            NUMBER;
      vn_update_tutar         NUMBER;

      vn_destek               NUMBER := 0;
      vn_eod_fisi             NUMBER;
      vn_hareket_kodu        NUMBER;
      
      vs_isleme_kmh_tanimli VARCHAR2(100);
      vn_islem_kod            number;
      vn_musteri_no          number;

      vd_banka_tarihi        date;
      vc_kmh_istisna_islem char:='H';
      vn_emv_bakiye        number;
      
      vn_islem_numara      number;
      vc_req_type          varchar2(10);
      vc_urun_tur_kod      varchar2(50);
      vn_hesaptaki_bloke_adet number:=0;
  BEGIN

     vd_banka_tarihi := pkg_muhasebe.Banka_Tarihi_Bul;
 
    if pkg_parametre.ParamTextDegerVarMi('BLOKE_TUTAR_ISTISNA_HESAP',TO_NUMBER(pv_hesap_no))= 'E' then        
       vn_bloke_tutari := pkg_bloke.Hesap_bloke_tutari(pn_hesap_no => TO_NUMBER(pv_hesap_no));
    end if;   
    
       
     SELECT h.durum_kodu,h.modul_tur_kod,h.urun_tur_kod,h.urun_sinif_kod,
            case when nvl(h.bloke_tutari,0) > 0 then 0
               else pkg_kmh.kmh_limit_al(h.hesap_no)  --bilalg   --nvl(destek_hesap_limiti,0)
              end case ,
            h.hesap_hareket_kodu,h.musteri_no
       INTO vs_durum_kodu,vs_modul_tur_kod,vs_urun_tur_kod,vs_urun_sinif_kod,  
            vn_destek_orj ,vn_hareket_kodu,vn_musteri_no
       FROM v_muh_hesap_izleme_tum h
      WHERE h.hesap_no=TO_NUMBER(pv_hesap_no);

     IF vs_durum_kodu='K' THEN
         RAISE Kapali_Hesap_Hareket_Yaratma;
     END IF;

   select /*pkg_tx.Islem_kod(f.islem_numara),*/ i.islem_kod, f.islem_numara,i.urun_tur_kod
     Into vn_islem_kod, vn_islem_numara, vc_urun_tur_kod
     from muh_fis f,muh_islem i
    where f.numara = pn_fis_numara
      and i.numara=f.islem_numara;

    vc_kmh_istisna_islem := pkg_parametre.ParamTextDegerVarMi('KMH_KONTROL_ISTISNA_ISLEM',vn_islem_kod);   

   if vs_urun_sinif_kod = 'KKART FON' then
      /* KKART FON hesabý sadece belli iþlemlerde kullanýlabiliyor olmalý MHA 16062014 */
      if pkg_parametre.ParamTextDegerVarMi('KKART_FON_ISLEM',vn_islem_kod)= 'H' then      
         pkg_hata.hata_yaz(4312,true,pv_hesap_no);
      end if;
   end if;  
   
  SELECT NVL(b.bakiye,0),NVL(b.bloke_tutari,0),bakiye_karakteri
    INTO vn_initial_bakiye,vn_bloke_tutari,vs_bakiye_karakteri
    FROM MUH_HESAP_BAKIYE b
   WHERE b.hesap_no=TO_NUMBER(pv_hesap_no) 
  FOR UPDATE;   -- Kaydy Kilitle

  if vn_bloke_tutari > 0 then

      select /*+ index(B X01_MUH_BLOKE) */  count(*)
        into vn_hesaptaki_bloke_adet
        from muh_bloke b
       where b.hesap_no = TO_NUMBER(pv_hesap_no)
         and b.durum_kodu = 'A'
         and b.bloke_neden_kodu not in (select key1 from bnspr.gnl_param_text where kod='KMH_ETKILEMEYEN_BLOKELER');
         -- and b.bloke_neden_kodu Not in ('17','74','76'); 
        
        if vn_hesaptaki_bloke_adet > 0 and vn_islem_kod = 3133 then
            select /*+ index(B X01_MUH_BLOKE) */ count(*)
            into vn_hesaptaki_bloke_adet
            from muh_bloke b
            where b.hesap_no = TO_NUMBER(pv_hesap_no)
            and b.durum_kodu = 'A'
            and b.bloke_neden_kodu not in (select key1 from bnspr.gnl_param_text where kod='KMH_ETKILEMEYEN_BLOKELER'
                                            union select '15' from dual);  /* Bu islem icin Bireysel Kredi Gecikme Blokesini de dikkate almayalim MHA 07062017 */
        end if; 
   end if;
   
    select count(*) 
      into vn_eod_fisi
      from muh_eod_fis_no efn
     where efn.fis_numara != pn_fis_numara /* su andaki fis disinda EOD fisleri varmi 20102010*/
       and efn.durum='A'
       and not exists (select 1 from muh_eod_fis_no m where m.fis_numara = pn_fis_numara and m.durum = 'A') /* EOD muhasebeleştirden gelmiyorsak saysın */
     ;
  
    if vn_eod_fisi>0 then
        SELECT /*+ INDEX(S PK_MUH_HAREKET_SATIR) */ SUM(DECODE(s.b_a,'A', NVL(dv_tutar,0), -1*NVL(dv_tutar,0)))
          INTO vn_eod_tutar
          FROM MUH_FIS_SATIR s, MUH_EOD_FIS_NO ef
         WHERE s.fis_numara = ef.fis_numara
           AND ef.durum = 'A'
           AND s.hesap_numara = pv_hesap_no
           AND s.hesap_tur_kodu = pv_hesap_turu
           AND ef.fis_numara != pn_fis_numara; /* bizim muhasebelestirmeye calistigimiz fisi dikkate almayalim MHA 20102010*/
    else  
       vn_eod_tutar := 0;
    end if;
    
--------bilal
    
    -- hesap uzerindeki kmh grubuna gore, islem icin tanimli olduguna bak   BNSPRPRO-4987: eda
    select MIN(kmh.kmh_grup),  nvl(SUM(kkm.kmh_limit),0)  
      into vs_isleme_kmh_tanimli, vn_destek
    from kmh_grup_islem kmh, kmh_tanim kkm
    where kmh.islem_kodu = vn_islem_kod
      and kkm.hesap_no     = TO_NUMBER(pv_hesap_no)
       And kkm.kmh_grup_kod = kmh.kmh_grup
--     kmh limiti provizyona acik mi       
       and (substr(kkm.durum,1,1) = 'A' or
           (substr(kkm.durum,1,1) = 'G' and nvl(kkm.provizyon_kapama_tarihi,vd_banka_tarihi-1) > vd_banka_tarihi) or
           vc_kmh_istisna_islem = 'E')       
--       and pkg_kmh.kmh_provizyona_acik_eh (kkm.kmh_sira_no) = 'E'
       And (kkm.vade_tarihi is null or 
            kkm.vade_tarihi >= vd_banka_tarihi)
    ;
    /*Select nvl(SUM(kkm.kmh_limit),0)          -- KMH turune gore limitini al
      into vn_destek
      From c
     Where kkm.hesap_no     = TO_NUMBER(pv_hesap_no)
       And kkm.kmh_grup_kod = nvl(vs_isleme_kmh_tanimli,'xx')
     ;*/
    if vs_isleme_kmh_tanimli is null 
       or pkg_kmh.kmh_limit_al_vadeli(pv_hesap_no)=0  --**----bilalg.or eklendi. --islem kmh limiti kullanamaz...
       or  (vn_bloke_tutari > 0 and vn_hesaptaki_bloke_adet>0)  then   -- bilalg BNSPRPRO-1814
      vn_destek:=0;  
    End if;
    If vn_islem_kod in (5555,5556,5302,2008,2086,4403) And vs_bakiye_karakteri = 'P' And pkg_kmh.hesaba_tanimli_kmh(pv_hesap_no)>0 Then    
      vn_destek := 99999999999;   -- KMH faiz tahakkukta limiti gecebilir , limiti sonnsuz yapyyoruz
    Elsif vn_islem_kod=4401 and vc_urun_tur_kod='YATIRMA' then
         vn_destek := 99999999999;   -- ATM den para yatırmada geçikmede ise limiti sonnsuz yapyyoruz
    End if;
--------     

    if pkg_parametre.ParamTextDegerVarMi('EMV_BAKIYE_KULLANILAMAYACAK_ISLEM',vn_islem_kod)='E' then
       vn_emv_bakiye := pkg_dcard.TOPUP_BAKIYE_AL(pv_hesap_no);
    end if;   

     vn_update_tutar := vn_initial_bakiye;
     vn_initial_bakiye := vn_initial_bakiye + NVL(vn_eod_tutar,0) + vn_destek-NVL(vn_emv_bakiye,0);
     
     If vn_hareket_kodu = 2 And ((pv_tur = 'B' and pv_fc_tutar>=0) OR (pv_tur='A' and pv_fc_tutar<0))  Then
        if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_kod) = 'E' then
           RAISE Borc_hareket_girilemez;
        end if;   
     ElsIf vn_hareket_kodu = 3 And ((pv_tur = 'A' and pv_fc_tutar>=0) OR (pv_tur='B' and pv_fc_tutar<0)) Then
         RAISE Alacak_hareket_girilemez;
     ElsIf vn_hareket_kodu = 4 Then
        --if NOT (pv_tur='B' and pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_kod) = 'H') then
        if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_kod) = 'E' then
           RAISE Hareket_girilemez;
        end if;   
     End if;         
       
     IF pv_doviz_kod=Pkg_GLOBAL.WLocCurr THEN
         IF pv_tur='A' THEN
            vn_last_bakiye   := vn_initial_bakiye + pv_lc_tutar;
            vn_update_tutar := vn_update_tutar + pv_lc_tutar;
         ELSE
            vn_last_bakiye   := vn_initial_bakiye-pv_lc_tutar;
            vn_update_tutar := vn_update_tutar - pv_lc_tutar;
         END IF;
         IF vs_bakiye_karakteri='P' AND (vn_last_bakiye-vn_bloke_tutari) < 0 AND 
             ( ( pv_tur='B' And pv_lc_tutar > 0 ) Or --borç islemi
               ( pv_tur='A' And pv_lc_tutar < 0 ) --alacak islemin iptali 
             ) Then
         --AsliK 310839 
              If  ABS(vn_destek_orj)>0 Then
                 
                 if pkg_kmh.kmh_limit_al_vadeli(pv_hesap_no)=0 then --vadeli limit, 0 ise ya kmh durumu uygun degildir ya da vadesi dolmustur.
                    if pkg_kmh.kmh_statu_uygun_degil(pv_hesap_no) = 'E' then
                      RAISE Kmh_Statu_Uygun_Degil;
                    else
                      RAISE Kmh_vadesi_dolmus;
                    end if;
                 elsif vn_last_bakiye < 0 and vs_isleme_kmh_tanimli is not null then
                    RAISE Kmh_Limiti_Asildi;
                 else
                    RAISE Kmh_Bu_islemde_kullanilamaz;
                 end if;
                               
              Else 
                 RAISE Bakiye_Negatif_Olamaz;
              End if;
         END IF;
         IF vs_bakiye_karakteri='N' AND (vn_last_bakiye-vn_bloke_tutari)>0 AND (pv_tur='A' OR pv_lc_tutar<0) THEN
               RAISE Bakiye_Pozitif_Olamaz;
         END IF;
      ---
       UPDATE MUH_HESAP_BAKIYE a
          SET a.bakiye             = vn_update_tutar,
              a.son_hareket_tarihi = PKG_GLOBAL.GET_BANKATARIH
        WHERE hesap_no=TO_NUMBER(pv_hesap_no);
      ELSE 
        IF pv_tur='A' THEN
          vn_last_bakiye   := vn_initial_bakiye+pv_fc_tutar;
          vn_update_tutar := vn_update_tutar + pv_fc_tutar;
        ELSE
          vn_last_bakiye   := vn_initial_bakiye-pv_fc_tutar;
          vn_update_tutar := vn_update_tutar - pv_fc_tutar;
        END IF;
        IF vs_bakiye_karakteri='P' AND (vn_last_bakiye-vn_bloke_tutari)<0 AND (pv_tur='B' OR pv_fc_tutar<0) THEN
            RAISE Bakiye_Negatif_Olamaz;
        END IF;
        IF vs_bakiye_karakteri='N' AND (vn_last_bakiye-vn_bloke_tutari)>0 AND (pv_tur='A' OR pv_fc_tutar<0) THEN
            RAISE Bakiye_Pozitif_Olamaz;
        END IF;
         ---
         UPDATE MUH_HESAP_BAKIYE a
            SET a.bakiye             = vn_update_tutar ,
                a.son_hareket_tarihi = vd_banka_tarihi   
          WHERE hesap_no=TO_NUMBER(pv_hesap_no);
    END IF;
    pn_sonraki_bakiye := vn_update_tutar;
    -----
   EXCEPTION
     WHEN Hesap_Bulunamadi_Exception THEN
           PKG_HATA.hata_yaz (201,TRUE,pv_hesap_no);
     WHEN Bakiye_Yetersiz_Exception THEN
           PKG_HATA.hata_yaz (202,TRUE,pv_hesap_no);
    WHEN Bakiye_Negatif_Olamaz THEN
           PKG_HATA.hata_yaz (230,TRUE,pv_hesap_no);
    WHEN Kmh_Bu_islemde_kullanilamaz THEN
           PKG_HATA.hata_yaz (834,TRUE,pv_hesap_no);
    WHEN Bakiye_Pozitif_Olamaz THEN
           PKG_HATA.hata_yaz (203,TRUE,pv_hesap_no);
    WHEN Kapali_Hesap_Hareket_Yaratma THEN
           PKG_HATA.hata_yaz (204,TRUE,pv_hesap_no);
    WHEN Borc_hareket_girilemez THEN
           PKG_HATA.hata_yaz (273,TRUE,pv_hesap_no);
    WHEN Alacak_hareket_girilemez THEN
           PKG_HATA.hata_yaz (274,TRUE,pv_hesap_no);
    WHEN Hareket_girilemez THEN
           PKG_HATA.hata_yaz (275,TRUE,pv_hesap_no);
    WHEN Kmh_vadesi_dolmus THEN
           PKG_HATA.hata_yaz (1024,TRUE,pv_hesap_no);
    WHEN Kmh_Statu_Uygun_Degil THEN
           PKG_HATA.hata_yaz (1052,TRUE,pv_hesap_no,pkg_kmh.hesaptan_kmh_statu(pv_hesap_no));       
    WHEN Kmh_Limiti_Asildi THEN
           PKG_HATA.hata_yaz (1025,TRUE,pv_hesap_no);           
    WHEN OTHERS THEN
           log_at (pid1 => 'PKG_HESAP.BAKIYE_GUNCELLE', pid2 => pv_hesap_no, pid3 => pv_fc_tutar||'*'||pv_lc_tutar, pid4 => pn_fis_numara, pid5 => dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
           PKG_HATA.hata_yaz (231,TRUE,'...'||pv_hesap_no||'...'||SQLERRM);
  END;
------------------------------------
   PROCEDURE BlokeTutariGuncelle(pn_hesap_no MUH_HESAP_BAKIYE.HESAP_NO%TYPE,pn_bloke_tutari  MUH_HESAP_BAKIYE.BLOKE_TUTARI%TYPE, pc_bloke_neden_kod muh_bloke.bloke_neden_kodu%type default null) IS
       blokenegatifdeger EXCEPTION;
     vn_tutar  NUMBER :=0 ;
   BEGIN

    if pkg_parametre.ParamTextDegerVarMi('BLOKE_TUTAR_ISTISNA_HESAP',pn_HESAP_NO)= 'H' then
       /* Istisna tanimli bir hesap ise bloke_tutar alaný hiç güncellenmeyecek hep sum ile kontrol edilecek MHA 27112012 */    
       SELECT NVL(bloke_tutari,0)+ pn_bloke_tutari
         INTO vn_tutar 
         FROM MUH_HESAP_BAKIYE
        WHERE hesap_no=pn_hesap_no;
      
      IF  vn_tutar < 0  THEN
          RAISE  blokenegatifdeger;
      ELSE
       
        UPDATE MUH_HESAP_BAKIYE
           SET bloke_tutari=NVL(bloke_tutari,0)+ pn_bloke_tutari 
         WHERE hesap_no=pn_hesap_no
         returning bloke_tutari into vn_tutar;
      
        --bilalg
        if vn_tutar=0 and pc_bloke_neden_kod is not null then
           Update muh_bloke bl
              set durum_kodu  = 'K',
                 coz_kayit_tarih = pkg_muhasebe.Banka_Tarihi_Bul,
                 coz_kayit_sistem_tarih = sysdate,
                 coz_kayit_kullanici_kodu = pkg_global.GET_KULLANICIKOD,
                 coz_kayit_kullanici_bolum_kodu = pkg_global.GET_SUBEKOD
             where bl.hesap_no = pn_hesap_no
               and bl.durum_kodu = 'A'
               and bl.bloke_neden_kodu = nvl(pc_bloke_neden_kod, bl.bloke_neden_kodu);
        end if;
      END IF;
    end if;     
   EXCEPTION
     WHEN blokenegatifdeger THEN
          pkg_hata.hata_yaz(347,true,pn_hesap_no);
       WHEN OTHERS THEN
       pkg_hata.hata_yaz(348,true,pn_hesap_no);
   END;
-------
 FUNCTION GecerliDKHesap(ps_dkhesap VARCHAR2,ps_sube_kodu VARCHAR2, ps_doviz_kodu VARCHAR2) RETURN BOOLEAN IS
   CURSOR dk_cursor IS
      SELECT * FROM muh_hp_bakiye t
   WHERE t.doviz_kod=ps_doviz_kodu
   AND t.hesap_no=ps_dkhesap
   AND t.sube_kod=ps_sube_kodu;

  dk_row   dk_cursor%ROWTYPE;
 BEGIN
        OPEN dk_cursor;
     FETCH dk_cursor INTO dk_row;
     IF dk_cursor%NOTFOUND THEN
            RETURN FALSE;
     ELSE
          RETURN TRUE;
       END IF;
       CLOSE dk_cursor;
 END;
-------
 PROCEDURE hesap_bakiye_olustur( pn_hesap_no MUH_HESAP_BAKIYE.hesap_no%TYPE,
                                   pn_bakiye MUH_HESAP_BAKIYE.hesap_no%TYPE,
                                 pn_bloke_tutari MUH_HESAP_BAKIYE.bloke_tutari%TYPE,
                                 pn_valorlu_bakiye MUH_HESAP_BAKIYE.bloke_tutari%TYPE,
                                 pn_bakiye_karakteri  MUH_HESAP_BAKIYE.bakiye_karakteri%TYPE DEFAULT NULL) IS


  BEGIN
  
      

        INSERT INTO MUH_HESAP_BAKIYE (hesap_no,
                           bakiye,
                    bloke_tutari,
                    valorlu_bakiye,
                    bakiye_karakteri)
                   VALUES           (pn_hesap_no,
                       pn_bakiye,
                    pn_bloke_tutari,
                    pn_valorlu_bakiye,
                    pn_bakiye_karakteri
                    );
        
   PKG_KIB.Hesap_Kisit_Kontrolu(pn_hesap_no);   
        
  EXCEPTION
    WHEN OTHERS THEN
       pkg_hata.hata_yaz(361,true,dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);


    
  END;
-------
  PROCEDURE VadesizBilgiAktar(pn_hesap_no IN  varchar2,p_txno IN NUMBER) IS
  BEGIN
        INSERT INTO MUH_HESAP_BASVURU_GUN_TX
      (TX_NO, MUSTERI_NO, HESAP_NUMARASI, MODUL_TUR_KOD, URUN_TUR_KOD, URUN_SINIF_KOD, KISA_ISIM, DOVIZ_KODU, CEK_KARNESI, HESAP_HAREKET_KODU, MIN_PARA_TUTARI, ACIKLAMA, ESAS_GUN_SAYISI, FAIZ_ORANI, FAIZ_INDIKATORU, BAKIYE_TURU, MIN_FAIZ_TUTARI, EKSTRE_BASIM_KODU, EKSTRE_SIKLIGI, DEKONT, SUBE_KODU, MIN_IMZA_ADEDI, DURUM_KODU, BIRIKMIS_FAIZ_POZ, MUHABIRDEKI_HESABIMIZ,
      HESAP_UCRETI_F,EKSTRE_NOTERDEN,INTERNET_BANK_GORUNTULENSIN_F,WB_EKNO,extre_gonderim_eposta_adresi,tahakkuk_periyodu,sahte_flag)
      SELECT p_txno,MUSTERI_NO, HESAP_NO, MODUL_TUR_KOD, URUN_TUR_KOD, URUN_SINIF_KOD, KISA_ISIM, DOVIZ_KODU, CEK_KARNESI, HESAP_HAREKET_KODU, MIN_PARA_TUTARI, ACIKLAMA, ESAS_GUN_SAYISI, FAIZ_ORANI, FAIZ_INDIKATORU, BAKIYE_TURU, MIN_FAIZ_TUTARI, EKSTRE_BASIM_KODU, EKSTRE_SIKLIGI, 
             DEKONT, SUBE_KODU, MIN_IMZA_ADEDI, DURUM_KODU, ROUND(BIRIKMIS_FAIZ_POZ,2), MUHABIRDEKI_HESABIMIZ,
             NVL(HESAP_UCRETI_F,'H'),EKSTRE_NOTERDEN,INTERNET_BANK_GORUNTULENSIN_F ,WB_EKNO,extre_gonderim_eposta_adresi,tahakkuk_periyodu,K.sahte_flag    
             FROM v_muh_hesap_tum K
      WHERE HESAP_NO=pn_hesap_no;

    INSERT INTO muh_hesap_ortak_bilgi_tx
      (tx_no,ana_hesap_no,ortak_musteri_no,ortak_adi_soyadi,ortaklik_tipi)
      SELECT p_txno,ana_hesap_no,ortak_musteri_no,ortak_adi_soyadi,ortaklik_tipi
      FROM muh_hesap_ortak_bilgi
      WHERE ana_hesap_no=pn_hesap_no;
  EXCEPTION
       WHEN OTHERS THEN
            pkg_hata.hata_yaz(409,true,dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
  END;
----
  PROCEDURE VadeliBilgiAktar(pn_hesap_no IN  varchar2,p_txno IN NUMBER) IS
  BEGIN
    INSERT INTO MUH_HESAP_VADELI_GUN_TX
    (TX_NO,ACIKLAMA, ACILIS_TARIHI, ARA_ODEME_BILGISI, ARA_ODEME_ISLEM_BILGISI, BIRIKMIS_FAIZ_NEG, 
     BIRIKMIS_FAIZ_POZ, BORC_KAYDI, BORCLU_HESAP_NO, DEKONT, DK_NO, DOVIZ_KODU, DURUM_KODU, 
     EKSTRE_BASIM_KODU, EKSTRE_SIKLIGI, ESAS_GUN_SAYISI, FAIZ_ORANI, GECEN_YIL_FAIZ_TOPLAMI, 
     GERI_DONUS_HESAPNO, HESAP_NO, KAPAMA_TARIHI, KISA_ISIM, MIN_IMZA_ADEDI, MODUL_TUR_KOD, 
     MUHABIR_HESAP_NO, MUHASEBE_TARIHI, MUSTERI_DK_NO, MUSTERI_NO, ODENMIS_FAIZ_TOPLAMI, OTOMATIK_TEMDIT, 
     PERIOD_CINS, PERIOD_SURE, REFERANS, SONRAKI_BASLANGIC_TARIHI, SUBE_KODU, TUTAR, URUN_SINIF_KOD, 
     URUN_TUR_KOD, VADE_ISLEM_BILGISI, VADE_TARIHI, VALOR_TARIHI, TEMDIT_TARIHI,SCH_FAIZ_ORANI,VADE_GUN,MAX_FAIZ,MIN_FAIZ,F_ON)
      SELECT p_txno,ACIKLAMA, ACILIS_TARIHI, ARA_ODEME_BILGISI, ARA_ODEME_ISLEM_BILGISI, BIRIKMIS_FAIZ_NEG, 
             ROUND(BIRIKMIS_FAIZ_POZ,2), BORC_KAYDI, BORCLU_HESAP_NO, DEKONT, DK_NO, DOVIZ_KODU, DURUM_KODU, 
             EKSTRE_BASIM_KODU, EKSTRE_SIKLIGI, ESAS_GUN_SAYISI, FAIZ_ORANI, GECEN_YIL_FAIZ_TOPLAMI, 
             GERI_DONUS_HESAPNO, HESAP_NO, KAPAMA_TARIHI, KISA_ISIM, MIN_IMZA_ADEDI, MODUL_TUR_KOD, 
             MUHABIR_HESAP_NO, MUHASEBE_TARIHI, MUSTERI_DK_NO, MUSTERI_NO, ODENMIS_FAIZ_TOPLAMI, 
             OTOMATIK_TEMDIT, PERIOD_CINS, PERIOD_SURE, REFERANS, SONRAKI_BASLANGIC_TARIHI, SUBE_KODU, TUTAR, 
             URUN_SINIF_KOD, URUN_TUR_KOD, VADE_ISLEM_BILGISI, VADE_TARIHI, VALOR_TARIHI, TEMDIT_TARIHI,SCH_FAIZ_ORANI,
             VADE_GUN,MAX_FAIZ,MIN_FAIZ,NVL(F_ON,'H')
      FROM Muh_Hesap_Vadeli
      WHERE HESAP_NO=pn_hesap_no;

    INSERT INTO MUH_HESAP_ORTAK_BILGI_TX
      (tx_no,ana_hesap_no,ortak_musteri_no,ortak_adi_soyadi,ortaklik_tipi)
      SELECT p_txno,ana_hesap_no,ortak_musteri_no,ortak_adi_soyadi,ortaklik_tipi
      FROM MUH_HESAP_ORTAK_BILGI
      WHERE ana_hesap_no=pn_hesap_no;
  EXCEPTION
       WHEN OTHERS THEN
           pkg_hata.hata_yaz(409,true,dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
  END;
----
  FUNCTION HesapUzerindeBlokeKayitli(pn_hesap_no  varchar2) RETURN BOOLEAN IS
       vn_bloke_tutar      NUMBER;
       Hesap_Bulunamadi_Exception EXCEPTION;
  BEGIN

   SELECT NVL(bloke_tutari,0) INTO vn_bloke_tutar
   FROM v_muh_hesap_izleme_tum 
   WHERE HESAP_NO=pn_hesap_no;

   IF vn_bloke_tutar>0 THEN
     RETURN TRUE;
   ELSE
    RETURN FALSE;
   END IF;
   EXCEPTION
         WHEN Hesap_Bulunamadi_Exception THEN
   pkg_hata.hata_yaz(412,true,pn_hesap_no);
  END;
--------------------------------------------------------------
  FUNCTION Hesap_hacizli_mi(p_hesap_no MUH_HESAP.hesap_no%TYPE ) RETURN VARCHAR2
   IS
   vs_sonuc  VARCHAR2(1) := 'H';
  BEGIN
  SELECT NVL(badlist_flag,'H') 
  INTO   vs_sonuc
  FROM   v_muh_hesap_izleme_tum 
  WHERE  hesap_no = p_hesap_no ;

   RETURN vs_sonuc;
   
    EXCEPTION
    WHEN OTHERS THEN RETURN 'H';

  END  Hesap_hacizli_mi;    
/*******************************************************************************/
  Procedure Personel_Hesap_Sorgulama_Log(pn_hesap_no in number,pn_sorgu_sonucu in number) IS
     pragma AUTONOMOUS_TRANSACTION;  
  Begin
     Insert Into MAAS_HESAP_SORGULAMA_LOG(KULLANICI_KOD,BANKA_TARIHI,HESAP_NO,SORGU_SONUCU)
     Values (pkg_global.GET_KULLANICIKOD,pkg_muhasebe.Banka_Tarihi_Bul,pn_hesap_no,pn_sorgu_sonucu);
     
     commit;
 End Personel_Hesap_Sorgulama_Log;    
/*******************************************************************************/
  FUNCTION Personel_Hesap_Mi(pn_hesap_no Muh_HESAP.HESAP_NO%TYPE) RETURN NUMBER IS  --1 yes personel, else no
    vn_temp NUMBER;
    CURSOR c_0 IS
      SELECT 1 FROM maas_odemeleri/*muh_maas_odemeleri*/
     WHERE hesap_no = pn_hesap_no;
  BEGIN
    OPEN c_0;
    FETCH c_0 INTO vn_temp;
    IF c_0%NOTFOUND THEN
       CLOSE c_0;
       if maas_hesabi_mi(pn_hesap_no) = 'H' then       
          RETURN 0;
       else
          RETURN 1;
       end if;      
    ELSE
     CLOSE c_0;
     RETURN 1;
    END IF;
  EXCEPTION
    WHEN OTHERS THEN
       RETURN 0;
  END Personel_Hesap_Mi;
/*******************************************************************************/
  FUNCTION Personel_Bakiye_Gosterilsin(pn_hesap_no MUH_HESAP.HESAP_NO%TYPE) RETURN NUMBER IS  --1 yes show, else no
    vn_temp NUMBER;
    vn_mus_per_sicil NUMBER;
    vn_kul_per_sicil NUMBER;
    CURSOR c_1 IS 
      SELECT 1 
        FROM maas_hesapizle/* muh_maas_hesap_izleyebilir*/
       WHERE personel_no = vn_kul_per_sicil;
    vs_kurum gnl_musteri.musteri_grup_kod%TYPE;   
    vs_izlenebilir maas_odemeleri_master.genel_izleme%TYPE;
    Cursor c_2 IS
     Select 1
       From maas_odemeleri_kul_pr p
      where p.kullanici_kodu = pkg_global.GET_KULLANICIKOD
        and p.kurum_kodu = vs_kurum; 
  BEGIN
    IF Pkg_Hesap.personel_hesap_mi(pn_hesap_no) = 1 THEN
      /* Kullanici maaslari izleyebiliyor ise hi? kasmadan izletelim MHA 120808 */
      If PKG_GENEL_PR.Kullanici_maas_izleyebilirmi = 'E' then
         Personel_Hesap_Sorgulama_Log(pn_hesap_no,1); -- Authorized user
         Return 1;
      End If;
      SELECT NVL(personel_sicil_no, -1)
        INTO vn_mus_per_sicil  
        FROM gnl_musteri
       WHERE musteri_no = Pkg_Hesap.musteri_no(pn_hesap_no);         
      SELECT NVL(personel_numara,-2)
        INTO vn_kul_per_sicil
        FROM gnl_kullanici
       WHERE kod = NVL(Pkg_global.GET_KULLANICIKOD,USER);
     
   IF vn_mus_per_sicil = vn_kul_per_sicil THEN
      Personel_Hesap_Sorgulama_Log(pn_hesap_no,1);
      RETURN 1;   -- his own account show it 
   ELSE
    IF vn_mus_per_sicil = -1 then 
       /* demekki personel hesabi degil,kurum hesabi olabilir */
     vs_kurum := pkg_musteri.musteri_grup_kod(musteri_no(pn_hesap_no));
     if vs_kurum is not null then
       select m.genel_izleme
         into vs_izlenebilir
         from maas_odemeleri_master m
        where m.kurum_kodu=vs_kurum; 
       if vs_izlenebilir = 'E' then 
          /* bu kurum icin kisitlama yokmus herkese acik demekki */
          Personel_Hesap_Sorgulama_Log(pn_hesap_no,1);
          RETURN 1; 
       else
          open c_2;
          Fetch c_2 into vn_temp;
          If c_2%notfound then
             close c_2;
             Personel_Hesap_Sorgulama_Log(pn_hesap_no,0);
             RETURN 0; /* bu kuruma ait hesaplari izleme hakkimiz yok */
          Else              
             close c_2;
             Personel_Hesap_Sorgulama_Log(pn_hesap_no,1);
             RETURN 1; /* izleyebiliyoruz */
          End if;   
       end if;
     else
       /* kurum ?zelligi olmayan maas hesabi ancak isten ayrilmis pesonel ise buraya d?ser MHA 100908 */
        Personel_Hesap_Sorgulama_Log(pn_hesap_no,0);
        RETURN 0; /* personel maaslarindan silinene kadar izleyemeyiz */
     end if;
    ELSE
       OPEN c_1;
       FETCH c_1 INTO vn_temp;
       IF c_1%NOTFOUND THEN
         CLOSE c_1;
       Personel_Hesap_Sorgulama_Log(pn_hesap_no,0);
       RETURN 0;  -- does not have right to see
       ELSE
         CLOSE c_1;
        Personel_Hesap_Sorgulama_Log(pn_hesap_no,1);
        RETURN 1;  -- has right to see show it
       END IF;
     END IF;
    END IF; 
   ELSE
      /*Personel_Hesap_Sorgulama_Log(pn_hesap_no,1); burada log tutmak manasiz olmus MHA 280910 */
      RETURN 1;     -- is not salary account  show it
   END IF;
  EXCEPTION
    WHEN OTHERS THEN
       Personel_Hesap_Sorgulama_Log(pn_hesap_no,0); 
       RETURN 0;  -- any error occured in case don't show 
  END;
/*******************************************************************************/
  FUNCTION Kullanilabilir_Bakiye_Al( pn_hesap_no MUH_HESAP_BAKIYE.hesap_no%TYPE, 
                                     pn_islem_kod MUH_ISLEM_TANIM_PR.KOD%TYPE Default Null,
                                     pc_kmh_grup_kod kmh_tanim.kmh_grup_kod%type default null,
                                     pc_fon_kmh_haric Varchar2 Default Null,
                                     pc_bakiye_sifirlama varchar2 default Null) RETURN MUH_HESAP_BAKIYE.bakiye%TYPE IS
--pc_fon_kmh_haric NULL >> hersey dahil Bakiye
--                 F    >> Fonsuz
--                 K    >> KMH'siz
--                 X    >> Fonsuz+KMH'siz
     vn_bakiye MUH_HESAP_BAKIYE.bakiye%TYPE;
     vn_eod_tutar   NUMBER;

     vn_bloke_tutar number;
     vn_destek    NUMBER; 
     vn_Net_Fon_Bakiye Number;
     vc_ptt_kredi_blokesi muh_bloke.bloke_neden_kodu%type;     
     vn_hesaptaki_bloke_adet number;
     vc_bloke_tutar_istisna_hesap VARCHAR2(50);
     vc_hesap_turu VARCHAR2(50);
     vn_kmh_eksi_bakiye_toplam NUMBER := 0;
     
    cursor c_kmh_kullan is
     select 1
       from kmh_grup_islem g
      where g.islem_kodu = pn_islem_kod;
     cursor c_fon_kullan is
     select 1
       from Fon_Cati_Islem_Iliski_Pr p
      Where p.Islem_Kodu = pn_islem_kod
        And p.Cati_Hesap_No = pn_hesap_no
     ;      
      vn_kmh_kullan    number:=0;
      vn_ot_fon_kullan number:=0;
      vc_otomatik_fon  Muh_Hesap_Tanim.Otomatik_Fon%Type;
      vc_hesap_no varchar2(20);
      vd_banka_tarih date:=pkg_muhasebe.Banka_Tarihi_Bul;
      vc_kmh_istisna_islem char:='H';

   Begin
    vc_hesap_no := to_char(pn_hesap_no); 
    vc_hesap_turu := pkg_hesap.HesapTuru(pn_hesap_no);
   
    If pc_fon_kmh_haric In('X', 'F') Then--Fon Bakiye dahil olmayacak
       vc_otomatik_fon := 'H';
       vn_ot_fon_kullan := 0;
    Else 
     Begin
      Select NVL(otomatik_fon,'H') 
        Into vc_otomatik_fon
        From MUH_HESAP_TANIM T
       Where t.Hesap_No = pn_hesap_no
      ;
      Exception When No_data_found Then
      vc_otomatik_fon := 'H';
     End;   
    End If;
    
    If pn_islem_kod Is Null then
      if vc_hesap_turu = 'VS' then
         /* KMH sadece Vadesiz hesaplarda olabilir */
         vn_kmh_kullan    := 1;
      end if;   
      If vc_otomatik_fon = 'E' Then
        vn_ot_fon_kullan := 1;
      End If;
    Else
      --asliK islem bazinda KMH kullanilabiliyor mu
       open c_kmh_kullan;
       Fetch c_kmh_kullan into vn_kmh_kullan;
       close c_kmh_kullan;    
      --
        --asliK islem bazinda FON kullanilabiliyor mu
        If vc_otomatik_fon = 'E' Then
           open c_fon_kullan;
           Fetch c_fon_kullan into vn_ot_fon_kullan;
           close c_fon_kullan;    
        End If;
         vc_kmh_istisna_islem := pkg_parametre.ParamTextDegerVarMi('KMH_KONTROL_ISTISNA_ISLEM',pn_islem_kod);   
     End If;
    If pc_fon_kmh_haric In( 'K','X') Then --KMH Bakiye dahil olmayacak
      vn_kmh_kullan := 0;
    End If;
    
    vc_bloke_tutar_istisna_hesap := pkg_parametre.ParamTextDegerVarMi('BLOKE_TUTAR_ISTISNA_HESAP',pn_HESAP_NO);

    if vc_bloke_tutar_istisna_hesap = 'H' then
       /* Istisna tanimli bir hesap ise bloke_tutar alaný hiç güncellenmeyecek hep sum ile kontrol edilecek MHA 27112012 */    
        SELECT NVL(bakiye,0) - NVL(bloke_tutari,0), NVL(bloke_tutari,0), NVL(B.Net_Fon_Bakiye,0) Net_Fon_Bakiye
          INTO vn_bakiye , vn_bloke_tutar, vn_Net_Fon_Bakiye
          FROM MUH_HESAP_BAKIYE B
         WHERE hesap_no = pn_hesap_no;
    else
       -- SELECT NVL(bakiye,0) - pkg_bloke.Hesap_bloke_tutari(pn_hesap_no), pkg_bloke.Hesap_bloke_tutari(pn_hesap_no), NVL(B.Net_Fon_Bakiye,0) Net_Fon_Bakiye
        SELECT NVL(bakiye,0) , (select sum(b.bloke_tutari) from muh_bloke_istisna b where b.hesap_no = pn_hesap_no and b.durum_kodu = 'A') as bloke_tutari,
               NVL(B.Net_Fon_Bakiye,0) Net_Fon_Bakiye
          INTO vn_bakiye , vn_bloke_tutar, vn_Net_Fon_Bakiye
          FROM MUH_HESAP_BAKIYE B
         WHERE hesap_no = pn_hesap_no;
         vn_bakiye := vn_bakiye - NVL(vn_bloke_tutar,0);
    end if;         
    
   If Pkg_Batch.Gun_sonu_mu OR Pkg_Batch.Gun_sonu_sonrasi_mi Then
    SELECT /*+ INDEX(S PK_MUH_HAREKET_SATIR) */  SUM(DECODE(s.b_a,'A', NVL(dv_tutar,0), -1*NVL(dv_tutar,0)))
      INTO vn_eod_tutar
      FROM MUH_FIS_SATIR s, MUH_EOD_FIS_NO ef
     WHERE s.fis_numara = ef.fis_numara
       AND ef.durum = 'A'
       AND s.hesap_numara = vc_hesap_no
       AND s.hesap_tur_kodu <> 'DK';
    End If;
    
     If vn_ot_fon_kullan = 0 Then
       vn_Net_Fon_Bakiye := 0;
     End If;
     
/*     SELECT NVL(destek_hesap_limiti,0)    ERSIN 22.4.2008
       INTO ln_destek
       FROM v_muh_hesap_izleme h
      WHERE h.hesap_no=pn_hesap_no;*/
      
      
      --PY-755: Ptt kredi blokesi disinda bloke varsa kmh kullanamasin kontrolu . sadece ptt kredi blokesi varsa kmh kullanabilir 
 if vn_kmh_kullan = 1 Then      
    if vc_bloke_tutar_istisna_hesap = 'H' then
        vc_ptt_kredi_blokesi := pkg_parametre.Deger_Al_K('PTT_KREDI_BLOKE_KOD') ;
        select /*+ index(B X01_MUH_BLOKE) */ count(*)
        into vn_hesaptaki_bloke_adet
        from muh_bloke b
        where b.hesap_no = pn_hesap_no
        and b.durum_kodu = 'A'
        and b.bloke_neden_kodu not in (select key1 from bnspr.gnl_param_text where kod='KMH_ETKILEMEYEN_BLOKELER');
    --   and b.bloke_neden_kodu Not in (vc_ptt_kredi_blokesi,'74','76'); /* Debit işlem blokesini dikkate almasın KMH kullanımını engellemesin MHA 18092017 */ 
        
        if vn_hesaptaki_bloke_adet > 0 and pn_islem_kod = 3133 then
            select /*+ index(B X01_MUH_BLOKE) */ count(*)
            into vn_hesaptaki_bloke_adet
            from muh_bloke b
            where b.hesap_no = pn_hesap_no
            and b.durum_kodu = 'A'
            and b.bloke_neden_kodu not in (select key1 from bnspr.gnl_param_text where kod='KMH_ETKILEMEYEN_BLOKELER'
                                            union select '15' from dual);             
--            and b.bloke_neden_kodu not in (vc_ptt_kredi_blokesi,'15');  /* Bu islem icin Bireysel Kredi Gecikme Blokesini de dikkate almayalim MHA 07062017 */
        end if;       
    else
         /*select count(*)
           into vn_hesaptaki_bloke_adet
           from dual
          where exists (select 1 
                         from muh_bloke_istisna i
                        where i.hesap_no = pn_hesap_no
                          and i.durum_kodu='A'); */ 
                          
        -- istisna hesap zaten belli YIM havuz hesabı. Orada boşuna count almayalım. MHA 18092017
         vn_hesaptaki_bloke_adet := 0;
    end if;  /* Buradaki ifade tüm hesaplar için gereksiz count alýyor,o yüzden sadece kmh_kullanilanlar için gitmesi daha dogru MHA 11122012 */      
 end if;       
      
   begin      
      if vn_kmh_kullan = 1 
         and (vn_bloke_tutar = 0 or vn_hesaptaki_bloke_adet = 0)  then  --BNSPRPRO-1814   : Bloke olan bir hesaptan islem yapilmak istenmesi durumunda sadece "bakiye-bloke bakiye" kadar bir tutarda isleme izin verilmesi, kmh limitinin kullanimina izin verilmemesi 
         
        SELECT SUM(NVL(s.kmh_limit,0))
         INTO vn_destek
         FROM kmh_tanim s
        WHERE s.hesap_no =pn_hesap_no 
--          AND pkg_kmh.kmh_provizyona_acik_eh (s.kmh_sira_no) = 'E'
          AND (substr(s.durum,1,1) = 'A' or
              (substr(s.durum,1,1) = 'G' and nvl(s.provizyon_kapama_tarihi,vd_banka_tarih-1) > vd_banka_tarih) or 
              vc_kmh_istisna_islem = 'E')       
          AND ( s.vade_tarihi is null or 
                s.vade_tarihi >= vd_banka_tarih)
          AND s.kmh_grup_kod = nvl(pc_kmh_grup_kod, s.kmh_grup_kod)
          AND exists (select 1
                        from kmh_grup_islem g
                       where g.kmh_grup = s.kmh_grup_kod
                         and g.islem_kodu = NVL(pn_islem_kod,g.islem_kodu)) ;
         
         --TY-23
         --Kurumsal KDH tanýmlý bir hesap ise tüm hesaplara ortak limit tanýmlandýðýndan diðer hesaptaki eksi bakiyeler de dikkate alýnýr.
         IF vn_destek > 0 THEN
            vn_kmh_eksi_bakiye_toplam := TuzelKurumsalKdhEksiBakiyeTop(pn_hesap_no, 'H');
         ELSE
            vn_kmh_eksi_bakiye_toplam := 0;
         END IF;
      Else
        vn_destek := 0 ;
      End If;
   exception when others then 
      vn_destek := 0;
   end;
  -----     
      vn_bakiye :=  vn_bakiye + NVL(vn_eod_tutar,0) + nvl(vn_destek,0) + NVL(vn_kmh_eksi_bakiye_toplam,0);
      If NVL(vn_ot_fon_kullan,0) = 1 Then

        vn_bakiye :=  vn_bakiye + nvl(vn_Net_Fon_Bakiye,0) ;
      End If;
      
      if vc_hesap_turu = 'VS' then
         if not (Pkg_Batch.Gun_sonu_mu AND NVL(pkg_global.get_rolkod,0) = '999') then   --EOD degil ise calisacak...
            vn_bakiye :=  vn_bakiye - pkg_kmh.kmh_faiz_tahakkuk_tutar(pn_hesap_no);
         end if;
      end if;
 
      if nvl(pc_bakiye_sifirlama, 'H') = 'H' and NVL( vn_bakiye, 0) < 0 Then 
        vn_bakiye := 0;
      End if;

      RETURN NVL(vn_bakiye,0);
  EXCEPTION
   WHEN NO_DATA_FOUND THEN RETURN 0 ;
    WHEN OTHERS THEN
      log_at('Kullanilabilir_Bakiye_Al',pn_hesap_no,pn_islem_kod,pc_kmh_grup_kod,dbms_utility.format_error_stack||dbms_utility.format_error_backtrace); 
      Pkg_Hata.hata_yaz(491,true,TO_CHAR(pn_hesap_no),TO_CHAR(SQLCODE) || ' ' ||SUBSTR(SQLERRM,1,50));      
   END Kullanilabilir_Bakiye_Al;

--*******************************************************************
  Function Kullanici_kendi_hesabi_mi(pn_hesap_no number) return varchar is
   vn_musteri_no number;
  begin
    vn_musteri_no := pkg_hesap.musteri_no(pn_hesap_no);
    if pkg_tablo.kullanici(pkg_global.GET_KULLANICIKOD).sicil_no=pkg_musteri.personel_sicil_no(vn_musteri_no) then
      return 'E';  
    else
      return 'H';
    end if;
  end Kullanici_kendi_hesabi_mi;
--*******************************************************************
/*  FUNCTION hesap_bakiye(pn_hesap_no v_muh_hesap_tum.hesap_no%type) return number is
       vn_bakiye  number;
  BEGIN
     select v. bakiye
     into vn_bakiye
     from v_muh_hesap_izleme_tum v 
     where v.hesap_no=pn_hesap_no;

     return vn_bakiye;
  END hesap_bakiye; BNSPRPRO-354 Zaten HesapBakiyeAl ayni isi yaptigi icin silindi MHA 251208*/

--*******************************************************************
  FUNCTION Vadeli_Urun_Sinif_Bul(ps_doviz  VARCHAR2,
                                 pd_muhasebe_tarihi DATE,
                                 pd_vade_tarihi DATE) RETURN VARCHAR2 IS 
    vs_ret   VARCHAR2(100);
    vn_gun_fark  NUMBER;
    CURSOR c1 IS
    SELECT *
    FROM VAD_VADELI_LCFC_SINIF
    WHERE lc_fc = DECODE(ps_doviz,Pkg_Genel_Pr.LC_al,'LC','FC');

    R1   c1%ROWTYPE;
  BEGIN
    vs_ret := NULL;
    vn_gun_fark := pd_vade_tarihi - pd_muhasebe_tarihi ;

    OPEN c1;
    FETCH c1 INTO R1;
    WHILE NOT c1%NOTFOUND
    LOOP
      BEGIN
        IF  R1.bas_gun <= vn_gun_fark AND 
            vn_gun_fark <= R1.son_gun
        THEN
          vs_ret := R1.urun_sinif_kodu;
        END IF; 
      END ;
      FETCH c1 INTO R1;
    END LOOP;
    CLOSE c1;

    RETURN vs_ret;
  END Vadeli_Urun_Sinif_Bul;
--*******************************************************************
  PROCEDURE FaizBilgiAl(pn_hesap_no Muh_Hesap_Vadeli.HESAP_NO%TYPE,
                        pn_bakiye OUT Muh_Hesap_Bakiye.bakiye%TYPE,
                        pn_gecen_yil_faizi OUT Muh_Hesap_Vadeli.Gecen_Yil_Faiz_Toplami%TYPE,
                        pn_birikmis_faiz OUT Muh_Hesap.Birikmis_Faiz_Poz%TYPE) IS

      CURSOR cur_hesap IS
        SELECT b.bakiye,v.GECEN_YIL_FAIZ_TOPLAMI,v.BIRIKMIS_FAIZ_POZ
          FROM Muh_Hesap_Bakiye b,Muh_Hesap_Vadeli v
          WHERE v.hesap_no=b.hesap_no
            AND v.hesap_no=pn_hesap_no;

  BEGIN
       OPEN cur_hesap; 
       FETCH cur_hesap INTO pn_bakiye,pn_gecen_yil_faizi,pn_birikmis_faiz;
       IF cur_hesap%NOTFOUND THEN
            CLOSE cur_hesap;
            Pkg_Hata.hata_yaz(412,true);
       END IF;
       CLOSE cur_hesap;
  END FaizBilgiAl;
--*******************************************************************
  FUNCTION Vadeli_Faiz_Oran_Al(pn_musteri_no in number,
                               pn_gun_sayisi NUMBER,
                               ps_doviz_kodu VARCHAR2,
                               pn_tutar NUMBER,
                               ps_Gec_Max VARCHAR2 DEFAULT 'G') RETURN NUMBER IS 
    vn_ret   NUMBER;
    vn_rate  NUMBER;
    vn_max   NUMBER;
    vn_min   NUMBER;
    vn_cnt   NUMBER;
    vn_marj_oran NUMBER;
    vs_ifade varchar2(1000);
    vs_kanalkod varchar2(50) := pkg_global.Get_KanalKod; --'SUBE' kanal kodu bir globale atylana kadar b?yle alalym. MHA
    vd_banka_tarihi date:= Pkg_Muhasebe.Banka_Tarihi_Bul;
 BEGIN
    vn_ret := 0;
    vn_marj_oran := pkg_musteri.musteri_vadeli_marj_oran(pn_musteri_no);
    SELECT COUNT(*)
    INTO vn_cnt
    FROM vad_cari_vadeli_mevduat_fo f
    WHERE tarih = vd_banka_tarihi
      AND f.kanal_kod = vs_kanalkod 
      AND pn_gun_sayisi >= VADE_1 
      AND pn_gun_sayisi <= VADE_2 
      AND pn_tutar >= TUTAR_1
      AND pn_tutar <= TUTAR_2
       ;
       
    IF vn_cnt > 0 THEN
       IF ps_doviz_kodu=pkg_genel_pr.lc_al THEN
           vs_ifade := 'select TRL ,MAX_TRL,MIN_TRL'||
                     ' from vad_cari_vadeli_mevduat_fo f '||
                     'where tarih=:tarihim and kanal_kod=:kanalim and '||to_char(pn_gun_sayisi)||' between VADE_1 and VADE_2'||
                     ' and '||Replace(to_char(pn_tutar),',','.')||' between TUTAR_1 and TUTAR_2';
                     --dbms_output.put_line(wifade);
             execute immediate vs_ifade INTO vn_rate,vn_max,vn_min
             using vd_banka_tarihi,vs_kanalkod;
       ELSE
           vs_ifade := 'select '||ps_doviz_kodu||',MAX_'||ps_doviz_kodu||',MIN_'||ps_doviz_kodu||
                     ' from vad_cari_vadeli_mevduat_fo f '||
                     'where  tarih=:tarihim and kanal_kod=:kanalim and '||to_char(pn_gun_sayisi)||' between VADE_1 and VADE_2'||
                     ' and '||Replace(to_char(pn_tutar),',','.')||' between TUTAR_1 and TUTAR_2';
                   --  dbms_output.put_line(wifade);
             execute immediate vs_ifade INTO vn_rate,vn_max,vn_min
             using vd_banka_tarihi,vs_kanalkod;
      END IF;            
    END IF; 
  IF ps_Gec_Max = 'G' THEN
     IF NVL(vn_max,0) != 0 then
        IF vn_rate+vn_marj_oran > vn_max then
           vn_ret := vn_max;
        ELSE
           vn_ret := vn_rate+vn_marj_oran;
        END IF;
     ELSE      
           vn_ret := vn_rate+vn_marj_oran;
     END IF;      
  ELSIF ps_Gec_Max = 'N' then
     IF NVL(vn_min,0) != 0 THEN
        -- max oran tanymlanmys
         vn_ret := vn_min;
     ELSE
         vn_ret := vn_rate;
     END IF;        
  ELSE
     IF NVL(vn_max,0) != 0 THEN
        -- max oran tanymlanmys
         vn_ret := vn_max;
     ELSE
         vn_ret := vn_rate;
     END IF;        
  END IF;   
     
     RETURN vn_ret;
  EXCEPTION WHEN OTHERS THEN
     Pkg_Hata.hata_yaz(775,true,ps_doviz_kodu);  
  END;
--*******************************************************************
  FUNCTION Vadeli_Mevduat_Faiz_Oran_Al
                              (pn_musteri_no in number,
                               pn_gun_sayisi NUMBER,
                               ps_doviz_kodu VARCHAR2,
                               pn_tutar NUMBER,
                               ps_Gec_Max VARCHAR2 DEFAULT 'G',
                               ps_overnight VARCHAR2 DEFAULT 'H') RETURN NUMBER IS 
    vn_ret   NUMBER;
    vn_rate  NUMBER;
    vn_max   NUMBER;
    vn_min   NUMBER;
    vn_cnt   NUMBER;
    vn_marj_oran NUMBER;
--    wifade varchar2(1000);
    wkanalkod varchar2(50) := pkg_global.Get_KanalKod; --'SUBE' kanal kodu bir globale atylana kadar b?yle alalym. MHA
    vd_banka_tarihi date:=pkg_muhasebe.Banka_Tarihi_Bul;
  BEGIN
    vn_ret := 0;
    vn_marj_oran := pkg_musteri.musteri_vadeli_marj_oran(pn_musteri_no);

  IF ps_overnight = 'H' THEN
      SELECT COUNT(*)
      INTO vn_cnt
      FROM vad_vadeli_mevduat_oran_pr f,gnl_vade_araliklari a
      WHERE tarih = vd_banka_tarihi
        AND f.kanal_kod = wkanalkod 
        AND f.doviz_kod = ps_doviz_kodu
        AND a.kod = f.vade_kod
        AND f.vade_kod != 'ON' 
        AND pn_gun_sayisi >= a.baslangic 
        AND pn_gun_sayisi <= a.bitis 
        AND pn_tutar >= TUTAR_1
        AND pn_tutar <= TUTAR_2
        And pkg_trn2201.oranTipiAl(pn_musteri_no) = f.oran_tipi
         ;
       
    IF vn_cnt > 0 THEN
         SELECT f.min_faiz_orani,f.faiz_orani,f.max_faiz_orani
           INTO vn_min,vn_rate,vn_max
           FROM vad_vadeli_mevduat_oran_pr f,gnl_vade_araliklari a
          WHERE tarih = vd_banka_tarihi
            AND f.kanal_kod = wkanalkod 
            AND f.doviz_kod = ps_doviz_kodu
            AND f.vade_kod != 'ON' 
            AND a.kod = f.vade_kod
            AND pn_gun_sayisi >= a.baslangic 
            AND pn_gun_sayisi <= a.bitis 
            AND pn_tutar >= TUTAR_1
            AND pn_tutar <= TUTAR_2
            And pkg_trn2201.oranTipiAl(pn_musteri_no) = f.oran_tipi
         ;
    END IF; 
  ELSE
    SELECT COUNT(*)
      INTO vn_cnt
      FROM vad_vadeli_mevduat_oran_pr f
     WHERE tarih = vd_banka_tarihi
       AND f.kanal_kod = wkanalkod 
       AND f.doviz_kod = ps_doviz_kodu
       AND f.vade_kod = 'ON' 
       AND pn_tutar >= TUTAR_1
       AND pn_tutar <= TUTAR_2
       And pkg_trn2201.oranTipiAl(pn_musteri_no) = f.oran_tipi
         ;
       
    IF vn_cnt > 0 THEN
          SELECT f.min_faiz_orani,f.faiz_orani,f.max_faiz_orani
          INTO vn_min,vn_rate,vn_max
          FROM vad_vadeli_mevduat_oran_pr f
          WHERE tarih = vd_banka_tarihi
            AND f.kanal_kod = wkanalkod 
            AND f.doviz_kod = ps_doviz_kodu
            AND f.vade_kod = 'ON' 
            AND pn_tutar >= TUTAR_1
            AND pn_tutar <= TUTAR_2
            And pkg_trn2201.oranTipiAl(pn_musteri_no) = f.oran_tipi
             ;
    END IF; 
  END IF;
  IF ps_Gec_Max = 'G' THEN
     IF NVL(vn_max,0) != 0 then
        IF vn_rate+vn_marj_oran > vn_max then
           vn_ret := vn_max;
        ELSE
           vn_ret := vn_rate+vn_marj_oran;
        END IF;
     ELSE      
           vn_ret := vn_rate+vn_marj_oran;
     END IF;      
  ELSIF ps_Gec_Max = 'N' then
     IF NVL(vn_min,0) != 0 THEN
        -- max oran tanymlanmys
         vn_ret := vn_min;
     ELSE
         vn_ret := vn_rate;
     END IF;        
  ELSE
     IF NVL(vn_max,0) != 0 THEN
        -- max oran tanymlanmys
         vn_ret := vn_max;
     ELSE
         vn_ret := vn_rate;
     END IF;        
  END IF;   
     
     RETURN vn_ret;
  EXCEPTION WHEN OTHERS THEN
     Pkg_Hata.hata_yaz(775,true,ps_doviz_kodu);  
  END Vadeli_Mevduat_Faiz_Oran_Al;
------------------------------------------------------------------------------------------------- 
FUNCTION temdit_guncelleme_vade_kontrol(pd_vade DATE, ps_islem_sekli VARCHAR2) RETURN VARCHAR2 
IS 
  vs_ret   VARCHAR2(1);
BEGIN
  vs_ret := 'H';

  IF ps_islem_sekli = 'TEMDIT' AND pd_vade <= Pkg_Muhasebe.banka_tarihi_bul
  THEN
    vs_ret := 'E';
  END IF;
  
  IF ps_islem_sekli = 'GUNCELLEME' AND pd_vade > Pkg_Muhasebe.banka_tarihi_bul
  THEN
    vs_ret := 'E';
  END IF;

  RETURN vs_ret;
END;

--*******************************************************************
  FUNCTION VadesizHesapVar(pn_hesap_no MUH_HESAP.HESAP_NO%TYPE, ls_doviz MUH_HESAP.DOVIZ_KODU%TYPE) RETURN BOOLEAN IS
       vn_temp NUMBER;
  BEGIN
      SELECT 1
      INTO vn_temp
    FROM muh_hesap
     WHERE hesap_no = pn_hesap_no
       AND doviz_kodu = ls_doviz;
     RETURN TRUE;   --problemsiz, buldu..
   EXCEPTION
         WHEN OTHERS THEN
                   RETURN FALSE;   --bulamadi yada problem var....
  END VadesizHesapVar;
--*******************************************************************
  FUNCTION IBAN_VadesizHesapVar(ps_IBAN MUH_HESAP.iban%TYPE) RETURN number is
        vn_temp NUMBER;
  BEGIN
      SELECT 1
      INTO vn_temp
    FROM muh_hesap
     WHERE iban = ps_IBAN;
     RETURN 1;   --problemsiz, buldu..
   EXCEPTION
         WHEN OTHERS THEN
                   RETURN 0;   --bulamadi yada problem var....
  END IBAN_VadesizHesapVar;
--*******************************************************************
  FUNCTION IBANdan_HesapNoAl(ps_IBAN MUH_HESAP.iban%TYPE) RETURN number is
       vn_temp NUMBER;
  BEGIN
      SELECT hesap_no
      INTO vn_temp
    FROM v_muh_hesap_izleme_tum
     WHERE iban = ps_IBAN;
     RETURN vn_temp;   --problemsiz, buldu..
   EXCEPTION
         WHEN OTHERS THEN
                   RETURN 0;   --bulamadi yada problem var....
  END IBANdan_HesapNoAl;
--*******************************************************************
  FUNCTION Modul_tur_Vadesiz RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'VADESIZ' ;
  END;
--
  FUNCTION Modul_tur_Vadeli RETURN VARCHAR2
  IS
  BEGIN
     RETURN 'VADELI';
  END;  
--*******************************************************************
  Procedure Customer_Account_Control(ps_sube in varchar2,pn_musteri_no in number,pn_hesap_no in number,ps_doviz in varchar2) IS
    vn_diger_musterino number;       
     cursor c_hesap is
       select v.isim_unvan
         from v_muh_hesap_izleme_tum v
        where v.sube_kodu = ps_sube
          and v.musteri_no = pn_musteri_no
          and v.hesap_no = pn_hesap_no
          and v.doviz_kodu = ps_doviz
        union
       select v.isim_unvan
         from v_muh_hesap_izleme_tum v
        where v.sube_kodu = ps_sube
          and v.musteri_no = vn_diger_musterino
          and v.hesap_no = pn_hesap_no
          and v.doviz_kodu = ps_doviz
          ;
    vs_unvan v_muh_hesap_izleme.isim_unvan%TYPE;  
    vn_musteri  number; 
     cursor c_ortak_kontrol is 
      select count(*)
        from gnl_musteri_ortaklik o
       where o.musteri_no=vn_musteri
         and o.bagli_musteri_no=pn_musteri_no;
    vn_var number;   
  Begin
     
     vn_diger_musterino := Gercek_Ticari_Diger_Musteri(pn_musteri_no);
  
     OPEN c_hesap;
     FETCH c_hesap INTO vs_unvan;
     IF c_hesap%notfound THEN
        vn_musteri := pkg_hesap.musteri_no(pn_hesap_no);
       if vn_musteri = pn_musteri_no then
          /* hata zaten doviz ya da subeden dolayi gelmis */
           pkg_hata.hata_yaz(701,true,ps_sube||' '||pn_musteri_no||' '||pn_hesap_no||' '||ps_doviz);
       elsif pkg_musteri.tur(vn_musteri) != 'O' then
          /* musteri numarasi ortak bile degil */
          pkg_hata.hata_yaz(701,true,ps_sube||' '||pn_musteri_no||' '||pn_hesap_no||' '||ps_doviz);
       else               
         if NVL(pkg_musteri.ortaklik_turu(vn_musteri),0) = 1 /* m?sterek */ then
            /* m?sterek ortak hesaba farkli m?steri ile islem yapilamaz */
            pkg_hata.hata_yaz(701,true,ps_sube||' '||pn_musteri_no||' '||pn_hesap_no||' '||ps_doviz);
         else
            /* ger?ekten ortaklardan birisi bizim m?steri mi kontrol edelim */
            open c_ortak_kontrol;
            Fetch c_ortak_kontrol into vn_var;
            close c_ortak_kontrol;
            if vn_var = 0 then 
               pkg_hata.hata_yaz(701,true,ps_sube||' '||pn_musteri_no||' '||pn_hesap_no||' '||ps_doviz);
            end if;   
         end if;
       end if;    
         
     END IF;   
     CLOSE c_hesap;
 End Customer_Account_Control;    
--*******************************************************************
 Function account_balance_control(pn_hesap_no in number,pn_islem_tutar in number,pn_mesaj out varchar2) return varchar2 IS
 Begin
   IF Kullanilabilir_Bakiye_Al(pn_hesap_no) < pn_islem_tutar then
      pn_mesaj := Pkg_Hata.mesajOlustur(202,pn_hesap_no);
      return '0';
   ELSE
      return '1';
   END IF;      
 End account_balance_control; 
 --*******************************************************************
 Function gonderen_bul(pn_islem_kod in number,pn_islem_no in number) return varchar2 is
   -- MHA IB-815
   vs_gonderen varchar2(500);
 Begin
   if pn_islem_kod = 2317 then
      Begin
          /* EFT gelen */
          select e.gonderen
            into vs_gonderen
            from eft_eft_tx e
           where e.odeme_tx_no = pn_islem_no;
       exception when others then
          null;
       end;
   elsif pn_islem_kod = 2030 then
      Begin
         select c.gonderen_isim_unvan
           into vs_gonderen
           from cari_subelerarasi_hav_giris_tx c
          where c.tx_no = pn_islem_no;           
      exception when others then
           null;
      end;
   elsif pn_islem_kod = 2032 then
      Begin
         select g.gonderen_isim_unvan
           into vs_gonderen
           from cari_subelerarasi_hav_odeme_tx c,cari_subelerarasi_hav_giris_tx g
          where c.tx_no = pn_islem_no
            and g.referans=c.referans;           
      exception when others then
           null;
      end;
   end if;           
   return vs_gonderen;    
 End gonderen_bul;   
 --*******************************************************************
 Function HesapHareket( pn_hesapno Number, pd_bastar Date, pd_bittar Date, pc_IslemTip Varchar2, pc_KanalTip Varchar2,
                        pn_Mintutar Number Default Null,  pn_Maxtutar Number Default Null, pc_dil_kod varchar2 Default 'TR' ) Return Pkg_Types.RC_ResultSet Is

  RC_Hareket PKG_Types.RC_ResultSet;   
--AsliK,100608
-- MHA IB-815 gonderen eklendi.

 vs_bakiye_karakteri muh_hesap_bakiye.bakiye_karakteri%type;
 vs_dil_kod muh_fis_satir_aciklama.dil_kod%type;
 vc_hesapno varchar2(20);
 ls_krt varchar2(2000):= 'pn_hesapno:'||pn_hesapno||',pd_bastar:'||pd_bastar||',pd_bittar:'||pd_bittar||
      ',pc_IslemTip:'||pc_IslemTip||',pc_KanalTip:'||pc_KanalTip||',pn_Mintutar:'||pn_Mintutar||
      ',pn_Maxtutar:'||pn_Maxtutar||',pc_dil_kod:'||pc_dil_kod;
 vd_bittar date;  
 vd_onceki_bankatar date;
 vd_sonraki_bankatar date;   
 Begin
  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'pkg_hesap.HesapHareket');
  vd_bittar := to_date(to_char(pd_bittar,'DDMMYYYY')||'235959','DDMMYYYYHH24MISS'); 
  
  
  begin
     SELECT bakiye_karakteri
      INTO vs_bakiye_karakteri
      FROM MUH_HESAP_BAKIYE b
     WHERE b.hesap_no=pn_hesapno;
  
  exception when others then
    vs_bakiye_karakteri := 'P';
  end;
  
  vs_dil_kod := upper(pc_dil_kod);
  vc_hesapno := to_char(pn_hesapno);       
  
   IF pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_HESAP',vc_hesapno) = 'E' then   
                    
       if pd_bittar - pd_bastar > 7 then
          /* Cok hareketli hesaplar 1 haftadan fazla cekilemesin MHA 12042016 */
          pkg_hata.hata_yaz(5322,true,vc_hesapno);
       end if;    
   
        vd_onceki_bankatar := pkg_tarih.geri_is_gunu(pd_bastar);
        vd_sonraki_bankatar := pkg_tarih.ileri_is_gunu(pd_bittar);
                     
         Open RC_Hareket For
          select /*+ INDEX(S PK_MUH_HAREKET_SATIR) */ trunc(yaratildigi_tarih) as islem_tarihi, valor_tarihi, 
                 decode(vs_dil_kod, 'TR', s.aciklama_musteri, nvl(a.aciklama_musteri, s.aciklama_musteri)) as islem_aciklama, 
                 --aciklama_musteri as islem_aciklama, 
                 dv_tutar as hareket_tutari, 
                 b_a as islem_tipi, balance_after as islem_sonrasi_bakiye,  /*balance_flag ,*/
                 decode(i.islem_kod,2317,gonderen_bul(i.islem_kod,i.numara),2032,gonderen_bul(i.islem_kod,i.numara),
                          2030,decode(b_a,'A',gonderen_bul(i.islem_kod,i.numara),null),null) as gonderen,
                          i.numara as islem_no,i.islem_kod, f.numara as fis_no, 
                          DECODE(vs_bakiye_karakteri, 'P', DECODE(b_a, 'A',1,2),DECODE(b_a, 'A',2,1) ) karakter,
                          to_char(f.yarat_tar, 'YYYYMMDDHH24MISS') yarat_tar,
                          f.muh_tarih MUHASEBE_TARIHI        
            from muh_fis_satir s,muh_fis f,muh_islem i, muh_fis_satir_aciklama a
           where f.numara = s.fis_numara
             and i.numara= f.islem_numara
             and s.fis_numara = a.fis_numara(+) --BNSPRPRO-5927 
             and s.numara = a.numara(+)
             and vs_dil_kod = a.dil_kod(+) 
             and s.hesap_numara = vc_hesapno
             and f.yarat_tar Between pd_bastar And vd_bittar /* MHA     IB-2181 */
             and f.muh_tarih Between vd_onceki_bankatar And vd_sonraki_bankatar /* MHA DSKNL-46  */
             and dv_tutar Between Nvl(pn_Mintutar, 0) And Nvl(pn_Maxtutar,99999999999) 
             and ( b_a = pc_IslemTip Or pc_IslemTip = 'H')
             and i.kanal_numara=NVL(pc_KanalTip,i.kanal_numara) --kanaltipi eklenecek
             and f.tur='G' /* sadece ge?erli islemler gelsin MHA 111008 */
             and i.islem_kod not in (5301,5302,5303) /* MHA KMH fisleri gorunmeyecekmis IB-2088 */
           order by f.muh_tarih,
                    f.yarat_tar,
                    s.fis_numara,
                    karakter,/*DECODE(vs_bakiye_karakteri, 'P', DECODE(islem_tipi, 'A',1,2),DECODE(islem_tipi, 'A',2,1) ), */--WNSPRC-1039
                    s.numara /*fon bozum isleminden kaynakli hareket sonrasi bakiye hatali gorunme problemi yasaniyordu MHA 080710*/; /* MHA 190808 DSKNL-121 */
           --order by yaratildigi_tarih;
          Return RC_Hareket;
          
          
     ELSE
     
          Open RC_Hareket For
          select /*+ORDERED INDEX(S IND_HESAPNO) INDEX(F PK_MUH_HAREKET) */ trunc(yaratildigi_tarih) as islem_tarihi, valor_tarihi, 
                 decode(vs_dil_kod, 'TR', s.aciklama_musteri, nvl(a.aciklama_musteri, s.aciklama_musteri)) as islem_aciklama, 
                 --aciklama_musteri as islem_aciklama, 
                 dv_tutar as hareket_tutari, 
                 b_a as islem_tipi, balance_after as islem_sonrasi_bakiye,  /*balance_flag ,*/
                 decode(i.islem_kod,2317,gonderen_bul(i.islem_kod,i.numara),2032,gonderen_bul(i.islem_kod,i.numara),
                          2030,decode(b_a,'A',gonderen_bul(i.islem_kod,i.numara),null),null) as gonderen,
                          i.numara as islem_no,i.islem_kod,f.numara as fis_no, 
                          DECODE(vs_bakiye_karakteri, 'P', DECODE(b_a, 'A',1,2),DECODE(b_a, 'A',2,1) ) karakter ,
                          to_char(f.yarat_tar, 'YYYYMMDDHH24MISS') yarat_tar,
                          f.muh_tarih MUHASEBE_TARIHI              
            from muh_fis_satir s,muh_fis f,muh_islem i, muh_fis_satir_aciklama a
           where f.numara = s.fis_numara
             and i.numara= f.islem_numara
             and s.fis_numara = a.fis_numara(+) --BNSPRPRO-5927 
             and s.numara = a.numara(+)
             and vs_dil_kod = a.dil_kod(+) 
             and s.hesap_numara = vc_hesapno
             and f.yarat_tar Between pd_bastar And vd_bittar /* MHA     IB-2181 */
             --and f.muh_tarih Between pd_bastar And pd_bittar /* MHA DSKNL-46  */
             and dv_tutar Between Nvl(pn_Mintutar, 0) And Nvl(pn_Maxtutar,99999999999) 
             and ( b_a = pc_IslemTip Or pc_IslemTip = 'H')
             and i.kanal_numara=NVL(pc_KanalTip,i.kanal_numara) --kanaltipi eklenecek
             and f.tur='G' /* sadece ge?erli islemler gelsin MHA 111008 */
             and i.islem_kod not in (5301,5302,5303) /* MHA KMH fisleri gorunmeyecekmis IB-2088 */
           order by f.muh_tarih,
                    f.yarat_tar,
                    s.fis_numara,
                    karakter,/*DECODE(vs_bakiye_karakteri, 'P', DECODE(islem_tipi, 'A',1,2),DECODE(islem_tipi, 'A',2,1) )*/ --WNSPRC-1039
                    s.numara /*fon bozum isleminden kaynakli hareket sonrasi bakiye hatali gorunme problemi yasaniyordu MHA 080710*/; /* MHA 190808 DSKNL-121 */
           --order by yaratildigi_tarih;
          Return RC_Hareket;    
     
     END IF;   
          
  End;
 --******************************************************************* 
  Function HesapHareket( pn_islem_no Number) Return Pkg_Types.RC_ResultSet Is

  RC_Hareket PKG_Types.RC_ResultSet;
--AsliK,100608
-- MHA IB-815 gonderen eklendi.
 Begin
   Open RC_Hareket For
    select s.hesap_numara, yaratildigi_tarih as islem_tarihi, valor_tarihi, aciklama_musteri as islem_aciklama, dv_tutar as hareket_tutari,
           b_a as islem_tipi, balance_after as islem_sonrasi_bakiye, /*balance_flag ,*/
           decode(i.islem_kod,2317,pkg_hesap.gonderen_bul(i.islem_kod,i.numara),2032,pkg_hesap.gonderen_bul(i.islem_kod,i.numara),
                    2030,decode(b_a,'A',pkg_hesap.gonderen_bul(i.islem_kod,i.numara),null),null) as gonderen,
                    i.numara as islem_no,f.numara as fis_no, sk.sube_adi
      from muh_fis_satir s,muh_fis f,muh_islem i, gnl_sube_kod_pr sk
     where f.numara = s.fis_numara
       and i.numara= f.islem_numara
       and sk.kod = f.islem_sube_kod
       and s.hesap_numara = i.hesap_numara
       and f.tur='G' /* sadece ge?erli islemler gelsin MHA 111008 */
       and i.islem_kod not in (5301,5302,5303) /* MHA KMH fisleri gorunmeyecekmis IB-2088 */
       and i.numara = pn_islem_no
     order by s.fis_numara,s.numara; /* MHA 190808 DSKNL-121 */ --order by yaratildigi_tarih;
    Return RC_Hareket;
  End; 
  /****************************************************************/
  
  Procedure account_trntype_control(pn_hesap_no in number,ps_b_a in varchar2) IS
    vn_hareket_kodu  v_muh_hesap_izleme.hesap_hareket_kodu%TYPE;
    vs_durum_kodu    v_muh_hesap_izleme.durum_kodu%TYPE;
  BEGIN
     SELECT h.durum_kodu,h.hesap_hareket_kodu
       INTO vs_durum_kodu,vn_hareket_kodu
       FROM v_muh_hesap_izleme_tum h
      WHERE h.hesap_no=TO_NUMBER(pn_hesap_no);
   
     IF vs_durum_kodu='K' THEN
        PKG_HATA.hata_yaz (204,TRUE,pn_hesap_no);
     END IF;
     
     If vn_hareket_kodu = 2 And ps_b_a = 'B' Then
        PKG_HATA.hata_yaz (273,TRUE,pn_hesap_no);
     ElsIf vn_hareket_kodu = 3 And ps_b_a = 'A' Then
        PKG_HATA.hata_yaz (274,TRUE,pn_hesap_no);
     ElsIf vn_hareket_kodu = 4 Then
        PKG_HATA.hata_yaz (275,TRUE,pn_hesap_no);
     End if;         
  End account_trntype_control;   
 --*******************************************************************
 Function HesapListe( pn_musterino Number, pc_dov Varchar2 Default Null, pn_hesapno Number Default Null, 
                      pc_kredilerDahilMi Varchar2 Default Null,ps_kisit_kod in varchar2 default null,
                      pc_goruntule_kontrol Varchar2 default 'E',pc_durum_kod varchar2 default 'A') Return Pkg_Types.RC_ResultSet Is 
  RC_HesListe PKG_Types.RC_ResultSet;   
--AsliK,180608
--MHA 031208 IB-600 ortak hesaplar eklendi...
  vn_kisit_kod varchar2(3);
  vn_goruntule_kontrol char;
  vn_diger_musterino number;
  vc_sube_kod varchar2(10);
  vn_ortakli number;
  vn_diger_ortakli number;
 Begin         
   vn_kisit_kod := NVL(ps_kisit_kod,'111');
   vn_goruntule_kontrol := NVL(pc_goruntule_kontrol,'E'); /* ne hikmetse default u g?rm?yor MHA */
   if pkg_global.Get_KanalKod = '93' then
      /* open api sadece keni subesindeki hesapları listeleyebilecek MHA 18.04.2022 */
      vc_sube_kod := pkg_global.GET_SUBEKOD;
   end if;   
   If pn_musterino Is Not Null Then               
     if pkg_musteri.tur(pn_musterino) = 'G' then
        vn_diger_musterino := pkg_hesap.Gercek_Ticari_Diger_Musteri(pn_musteri_no => pn_musterino);
     end if;   
     select count(*) into vn_ortakli from gnl_musteri_ortaklik o where o.bagli_musteri_no=pn_musterino and ortaklik_turu=2;
     
     if vn_diger_musterino is null then 
         if vn_ortakli = 0 then
           Open RC_HesListe For
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN (select key1 from bnspr.gnl_param_text where kod='ADC_HESAP_LISTE_URUN_TURLERI')) or  hesap_tur != 'VS') 
               -- and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             Order by 1  ;
         else
           Open RC_HesListe For
            select /*+ Duz Ortakli*/ H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN (select key1 from bnspr.gnl_param_text where kod='ADC_HESAP_LISTE_URUN_TURLERI')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,o.ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b, gnl_musteri_ortaklik o
             where o.bagli_musteri_no=pn_musterino
               and h.musteri_no = o.musteri_no
               and o.ortaklik_turu=2 /* simdilik eskisi gibi sadece münferid hesapları döneceğiz */
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri(+kredileri 200309) almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN (select key1 from bnspr.gnl_param_text where kod='ADC_HESAP_LISTE_URUN_TURLERI')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             order by 1;   
          end if;       
     else
       select count(*) into vn_diger_ortakli from gnl_musteri_ortaklik o where o.bagli_musteri_no=vn_diger_musterino and ortaklik_turu=2;
       if vn_ortakli=0 and vn_diger_ortakli=0 then
           Open RC_HesListe For
            select /* Ortaksiz GT */ H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b 
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
            union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = vn_diger_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             order by 1;       
       elsif vn_ortakli>0 and vn_diger_ortakli=0 then
           Open RC_HesListe For
            select /* GT Ortakli */ H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b 
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,o.ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b,gnl_musteri_ortaklik o
             where o.bagli_musteri_no = pn_musterino
               and H.musteri_no = o.musteri_no --IN (select musteri_no from gnl_musteri_ortaklik o where o.bagli_musteri_no=pn_musterino and ortaklik_turu=2)
               and o.ortaklik_turu=2 /* simdilik eskisi gibi sadece münferid hesapları döneceğiz */
               and b.hesap_no(+) = h.hesap_no
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri(+kredileri 200309) almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod         
               And urun_sinif_kod != 'KKART FON'
            union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = vn_diger_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             order by 1;          
       elsif vn_ortakli=0 and vn_diger_ortakli>0 then
           Open RC_HesListe For
            select /* GT ortaksiz diger ortakli */H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b 
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
            union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = vn_diger_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,o.ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b,gnl_musteri_ortaklik o
             where o.bagli_musteri_no=vn_diger_musterino
               and H.musteri_no = o.musteri_no --IN (select musteri_no from gnl_musteri_ortaklik o where o.bagli_musteri_no=vn_diger_musterino and ortaklik_turu=2)
               and o.ortaklik_turu=2 /* simdilik eskisi gibi sadece münferid hesapları döneceğiz */
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri(+kredileri 200309) almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod         
               And urun_sinif_kod != 'KKART FON'
             order by 1;            
       else  
           Open RC_HesListe For
            select /* ortakli ve GT ortakli */H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b 
             where H.musteri_no = pn_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,o.ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b,gnl_musteri_ortaklik o
             where o.bagli_musteri_no = pn_musterino
               and H.musteri_no = o.musteri_no --IN (select musteri_no from gnl_musteri_ortaklik o where o.bagli_musteri_no=pn_musterino and ortaklik_turu=2)
               and o.ortaklik_turu=2 /* simdilik eskisi gibi sadece münferid hesapları döneceğiz */
               and b.hesap_no(+) = h.hesap_no
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri(+kredileri 200309) almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod         
               And urun_sinif_kod != 'KKART FON'
            union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,0 ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
             where H.musteri_no = vn_diger_musterino
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu= NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod
               And urun_sinif_kod != 'KKART FON'
             union all
            select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
                   pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
                   pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
                   h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
                   h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
                   decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
                   h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit,o.ortaklik_turu
              from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b,gnl_musteri_ortaklik o
             where o.bagli_musteri_no=vn_diger_musterino
               and H.musteri_no = o.musteri_no --IN (select musteri_no from gnl_musteri_ortaklik o where o.bagli_musteri_no=vn_diger_musterino and ortaklik_turu=2)
               and o.ortaklik_turu=2 /* simdilik eskisi gibi sadece münferid hesapları döneceğiz */
               and b.hesap_no(+) = h.hesap_no
               and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
               and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
               and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )
               and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
               and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
               and h.hesap_tur not in ('VD') /* vadelileri(+kredileri 200309) almayacagiz MHA 031208 */
               and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
               and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
               And M.KOD = H.modul_tur_kod         
               And urun_sinif_kod != 'KKART FON'
             order by 1;       
       end if; 
      end if;          
   Else
   -- Elsif pn_hesapno Is Not Null Then  -- JIRA IB-214 
     Open RC_HesListe For
/*      select H.hesap_no, H.kisa_isim RUMUZ, H.hesap_tur HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, */
      select H.hesap_no, H.kisa_isim RUMUZ, M.ACIKLAMA||'-'||pkg_genel_pr.Basim_Doviz_Kodu(H.doviz_kodu) HESAP_TIPI, H.doviz_kodu, H.sube_kodu SUBE, Pkg_Genel_Pr.sube_adi(H.sube_kodu) SUBE_ADI, 
             pkg_hesap.HesapBakiyeAl(H.hesap_no) Bakiye, pkg_hesap.Kullanilabilir_Bakiye_Al(H.hesap_no) KULLANILABILIR_BAKIYE, 
             pkg_kmh.kmh_limit_al_vadeli(H.hesap_no,'GENEL') KMH_LIMIT,h.musteri_no,pkg_genel_pr.Basim_Doviz_Kodu(h.doviz_kodu) as basim_doviz_kodu,
             h.hesap_kisit_kodu,h.IBAN,h.hesap_hareket_kodu,h.durum_kodu,decode(pkg_kmh.hesaba_tanimli_kmh(h.hesap_no),0,'H','E') KMH_EH, nvl(b.bakiye,0) as topupBakiye,
             h.internet_bank_goruntulensin_f as internet_goruntule, nvl(h.otomatik_fon, 'H') otomatik_fon,
             decode(h.f_musteri_bloke,1,'E','H') as F_MUSTERI_BLOKE,
             h.bloke_tutari,pkg_kmh.kmh_limit_al(H.hesap_no) genel_kmh_limit, 0 ortaklik_turu
        from v_muh_hesap_izleme_tum H, v_Ml_Gnl_Modul_Kod_Pr M, crd_debit_transfer_bakiye b
       where H.hesap_no   = pn_hesapno
         and b.hesap_no(+) = h.hesap_no
         and h.sube_kodu = NVL(vc_sube_kod, h.sube_kodu)
         and H.doviz_kodu = Nvl(pc_dov, H.doviz_kodu)
         and ( ( Nvl( pc_kredilerDahilMi, 'H') = 'H' And H.hesap_tur Not In ('KR')) Or ( Nvl( pc_kredilerDahilMi, 'H') = 'E' ) )         
         and h.durum_kodu=NVL(pc_durum_kod,h.durum_kodu)
         and h.hesap_kisit_kodu in (to_number(substr(vn_kisit_kod,1,1))*1,to_number(substr(vn_kisit_kod,2,1))*2,to_number(substr(vn_kisit_kod,3,1))*3)
         and ((h.internet_bank_goruntulensin_f = 'E' and vn_goruntule_kontrol='E') or vn_goruntule_kontrol='H' or hesap_tur != 'VS') 
         and ((hesap_tur ='VS' and urun_tur_kod IN (select key1 from bnspr.gnl_param_text where kod='ADC_HESAP_LISTE_URUN_TURLERI')) or  hesap_tur != 'VS') 
      --   and ((hesap_tur ='VS' and urun_tur_kod IN ('MUSTAK-TP','MUSTAK-YP','TASARRF-TP','TASARRF-YP','ODEME-TP','ODEME-YP')) or  hesap_tur != 'VS') 
         And M.KOD = H.modul_tur_kod         
         And urun_sinif_kod != 'KKART FON'
       order by 1;
     End If;    
     
      
     
     
    Return RC_HesListe;
  End;  
 --******************************************************************* 
 
 Procedure vadesiz_hesap_acilis(pn_musteri_no in number,
                                ps_modul_tur_kod in varchar2,
                                ps_urun_tur_kod in varchar2,
                                ps_urun_sinif_kod in varchar2,
                                ps_sube_kodu in varchar2 default pkg_global.GET_SUBEKOD,
                                ps_doviz_kod in varchar2 default pkg_genel_pr.lc_al,
                                ps_hesap_ucreti_f in varchar2 default 'H',
                                pn_hesap_no in out number) is
   lc_hesap_no number;
   ln_tutar                     number;
   lv_musteri_dkno              MUH_HESAP.MUSTERI_DK_NO%TYPE;
   lc_hesap_sayisi              number;

vn_xau_hesap number;

Begin
    pkg_musteri.v_musteri_kayit := NULL;
    if pkg_trn1072.vadesiz_hesap_acma_kontrol(pn_musteri_no) = 1 then
       pkg_hata.hata_yaz(1798);
    end if;
    lc_hesap_sayisi :=0;
    if ps_doviz_kod ='XAU' and ps_urun_tur_kod in ('ODEME-YP','MUSTAK-YP') then
       select max(hesap_no) into vn_xau_hesap from muh_hesap where musteri_no = pn_musteri_no and doviz_kodu ='XAU' and durum_kodu='A';
       if vn_xau_hesap is not null then
          pn_hesap_no := vn_xau_hesap;
          return;
       end if;
    end if;

 
    if pn_hesap_no is null then
      lc_hesap_no := PKG_GENEL_PR.genel_kod_al('HESAP.VDSZ');
    else
      lc_hesap_no := pn_hesap_no;
      
      update muh_hesap_rezerv set durum_kodu = 'K' where hesap_no = pn_hesap_no;
      
    end if;
    
    ln_tutar          := 0;
    
    Pkg_Muhasebe.DK_BUL( pkg_musteri.hp_grup_kod(pn_musteri_no), ps_modul_tur_kod, ps_urun_tur_kod,ps_urun_sinif_kod, 1, NULL, NULL, NULL, lv_musteri_dkno);

    
   INSERT INTO MUH_HESAP
              (HESAP_NO, DURUM_KODU,  MUSTERI_NO,MODUL_TUR_KOD, URUN_TUR_KOD, URUN_SINIF_KOD, KISA_ISIM,
               DOVIZ_KODU, TUTAR, BORC_KAYDI,  
               HESAP_HAREKET_KODU, MIN_PARA_TUTARI, ACIKLAMA, ESAS_GUN_SAYISI, FAIZ_ORANI,
               FAIZ_INDIKATORU, BAKIYE_TURU, MIN_FAIZ_TUTARI,   
               SUBE_KODU,MUSTERI_DK_NO,ACILIS_TARIHI, KMH_DK_NO    )
   VALUES (lc_hesap_no, 'A', pn_musteri_no, ps_modul_tur_kod, ps_urun_tur_kod, ps_urun_sinif_kod,
           Substr(NVL(pkg_musteri.kisa_ad(pn_musteri_no),'xxx'),1,30),ps_doviz_kod,ln_tutar, 1, 1, 0, null /* otomatik Vadesiz hesap acilis */,
           365, null, null, 1, 0, ps_sube_kodu,lv_musteri_dkno, pkg_muhasebe.Banka_Tarihi_Bul,null);  
           
  insert into muh_hesap_tanim 
             (HESAP_NO,ORTAK_HESAP_F,EKSTRE_NOTERDEN, HESAP_UCRETI_F, 
              MIN_IMZA_ADEDI, DEKONT, EKSTRE_SIKLIGI, EKSTRE_BASIM_KODU, CEK_KARNESI,INTERNET_BANK_GORUNTULENSIN_F)
  values (lc_hesap_no,'H','HAYIR', ps_hesap_ucreti_f, 0, 'X', null, 'X', 'H', 'E');   
  
  ---bakiye tablosuna ekle
  Pkg_Hesap.HESAP_BAKIYE_OLUSTUR(lc_hesap_no,0, 0, 0,Pkg_Parametre.DEGER(ps_modul_tur_kod, ps_urun_tur_kod,ps_urun_sinif_kod,'BAKIYE_KARAKTERI'));

  pn_hesap_no := lc_hesap_no;       

 End vadesiz_hesap_acilis;  
/***********************************************************************************************************/
  FUNCTION VadeliHesapAcilis(pn_MUSTERI_NO     NUMBER,
                ps_MODUL_TUR_KOD VARCHAR2,
                ps_URUN_TUR_KOD VARCHAR2,
                ps_URUN_SINIF_KOD VARCHAR2,
                ps_KISA_ISIM VARCHAR2,
                ps_DOVIZ_KODU VARCHAR2,
                ps_SUBE_KODU VARCHAR2,
                pn_TUTAR NUMBER,
                pd_VALOR_TARIHI DATE,
                pn_VADE_ISLEM_BILGISI NUMBER,
                pn_ARA_ODEME_BILGISI NUMBER,
                ps_OTOMATIK_TEMDIT VARCHAR2,
                pn_PERIOD_SURE NUMBER,
                ps_PERIOD_CINS VARCHAR2,
                pd_SONRAKI_BASLANGIC_TARIHI DATE,
                pn_ARA_ODEME_ISLEM_BILGISI NUMBER,
                pd_VADE_TARIHI DATE,
                pn_GERI_DONUS_HESAPNO NUMBER,
                pn_ESAS_GUN_SAYISI NUMBER,
                pn_FAIZ_ORANI NUMBER,
                ps_ACIKLAMA VARCHAR2,
                ps_REFERANS  VARCHAR2,
                ps_EKSTRE_BASIM_KODU VARCHAR2 DEFAULT 'X',
                ps_EKSTRE_SIKLIGI VARCHAR2 DEFAULT NULL,
                ps_DEKONT VARCHAR2 DEFAULT 'X',
                pd_acilis_tarihi DATE DEFAULT Pkg_Muhasebe.Banka_Tarihi_Bul,
                ps_islemturu    VARCHAR2 DEFAULT NULL,
                pn_negatif_faiz    NUMBER DEFAULT 0) RETURN NUMBER IS

    ls_dkgrup_kodu      gnl_musteri.dk_grup_kod%TYPE;
    lv_musteri_dkno      muh_hesap.musteri_dk_no%TYPE;
    ln_hesap_no        NUMBER;

    GecerliDKHesap_Bulunamadi      EXCEPTION;
    GecerliTRLDKHesap_Bulunamadi    EXCEPTION;
  BEGIN

    if pkg_trn1072.vadesiz_hesap_acma_kontrol(pn_MUSTERI_NO) = 1 then 
       pkg_hata.hata_yaz(1798); 
    end if; 
    
  
    ls_dkgrup_kodu := pkg_musteri.hp_grup_kod(p_musteri_no => pn_MUSTERI_NO);

    --3-faiz Gider DK
    Pkg_Muhasebe.DK_BUL( ls_dkgrup_kodu, 'VADELI', ps_urun_tur_kod,ps_urun_sinif_kod, 3, NULL, NULL, NULL, lv_musteri_dkno);
    IF NOT Pkg_Hesap.GECERLIDKHESAP(lv_musteri_dkno,ps_SUBE_KODU,ps_doviz_kodu ) THEN
       RAISE GecerliDKHesap_Bulunamadi;
    END IF;
    /*IF NOT Pkg_Hesap.GECERLIDKHESAP(lv_musteri_dkno,ps_SUBE_kodu,Pkg_Genel_Pr.LC_AL) THEN
       RAISE GecerliTRLDKHesap_Bulunamadi;
    END IF; ne TL si yaw?MHA 120209 */

    --4-reeskont DK
    Pkg_Muhasebe.DK_BUL( ls_dkgrup_kodu, 'VADELI', ps_urun_tur_kod,ps_urun_sinif_kod, 4, NULL, NULL, NULL, lv_musteri_dkno);
    IF NOT Pkg_Hesap.GECERLIDKHESAP(lv_musteri_dkno,ps_SUBE_kodu,ps_doviz_kodu ) THEN
       RAISE GecerliDKHesap_Bulunamadi;
    END IF;
    --ANA DK
    Pkg_Muhasebe.DK_BUL( ls_dkgrup_kodu, 'VADELI', ps_urun_tur_kod,ps_urun_sinif_kod, 1, NULL, NULL, NULL, lv_musteri_dkno);

    ln_hesap_no:=Pkg_Genel_Pr.genel_kod_al('HESAP.VDSZ');

  INSERT INTO Muh_Hesap_Vadeli
  (HESAP_NO, MUSTERI_NO, MODUL_TUR_KOD, URUN_TUR_KOD, URUN_SINIF_KOD, KISA_ISIM, DOVIZ_KODU, SUBE_KODU,
   TUTAR, VALOR_TARIHI, BORC_KAYDI, VADE_ISLEM_BILGISI, 
   ARA_ODEME_BILGISI , OTOMATIK_TEMDIT, PERIOD_SURE, PERIOD_CINS, SONRAKI_BASLANGIC_TARIHI, 
   ARA_ODEME_ISLEM_BILGISI, VADE_TARIHI, GERI_DONUS_HESAPNO, ESAS_GUN_SAYISI, FAIZ_ORANI, ACIKLAMA,REFERANS, 
   EKSTRE_BASIM_KODU, EKSTRE_SIKLIGI, DEKONT, ACILIS_TARIHI,DURUM_KODU, MUSTERI_DK_NO,ISLEM_TURU,NEGATIF_FAIZ)
  VALUES 
  (ln_hesap_no,pn_MUSTERI_NO,'VADELI',ps_URUN_TUR_KOD,ps_URUN_SINIF_KOD,ps_KISA_ISIM,ps_DOVIZ_KODU,ps_SUBE_KODU,
   pn_TUTAR,pd_VALOR_TARIHI,1,pn_VADE_ISLEM_BILGISI,pn_ARA_ODEME_BILGISI,ps_OTOMATIK_TEMDIT,pn_PERIOD_SURE,ps_PERIOD_CINS,
   pd_SONRAKI_BASLANGIC_TARIHI,pn_ARA_ODEME_ISLEM_BILGISI,pd_VADE_TARIHI,pn_GERI_DONUS_HESAPNO,pn_ESAS_GUN_SAYISI,pn_FAIZ_ORANI,
   ps_ACIKLAMA,ps_REFERANS,ps_EKSTRE_BASIM_KODU,ps_EKSTRE_SIKLIGI,ps_DEKONT,pd_acilis_tarihi,'A',lv_musteri_dkno,ps_islemturu,pn_negatif_faiz);

    Pkg_Hesap.HESAP_BAKIYE_OLUSTUR(ln_hesap_no,0, 0, 0,Pkg_Parametre.DEGER('VADELI', ps_urun_tur_kod,ps_urun_sinif_kod,'BAKIYE_KARAKTERI'));

    RETURN ln_hesap_no;
  EXCEPTION
       WHEN GecerliDKHesap_Bulunamadi THEN
            pkg_hata.hata_yaz(360,true,ls_dkgrup_kodu,'VADELI-'||ps_urun_tur_kod||'-'||ps_urun_sinif_kod||' '||ps_DOVIZ_KODU);
         WHEN GecerliTRLDKHesap_Bulunamadi THEN
            pkg_hata.hata_yaz(360,true,ls_dkgrup_kodu,'VADELI-'||ps_urun_tur_kod||'-'||ps_urun_sinif_kod||' '||pkg_genel_pr.lc_al);

  END VadeliHesapAcilis; 
/***********************************************************************************************************/
  PROCEDURE HesapDurumGuncelle(ps_tur VARCHAR2,pn_hesap_no NUMBER,ps_durum_kodu VARCHAR2) IS
  BEGIN
   IF ps_tur='VADELI' THEN
     UPDATE Muh_Hesap_Vadeli
        SET DURUM_KODU=ps_durum_kodu,
            KAPAMA_TARIHI =NULL
      WHERE hesap_no=pn_hesap_no ;
     IF ps_durum_kodu='K' THEN
        UPDATE Muh_Hesap_Vadeli
           SET KAPAMA_TARIHI=Pkg_Muhasebe.Banka_Tarihi_Bul
         WHERE hesap_no=pn_hesap_no ;
     END IF;
    ELSIF ps_tur='VADESIZ' THEN
     UPDATE Muh_Hesap
        SET DURUM_KODU=ps_durum_kodu,
            KAPAMA_TARIHI =NULL
      WHERE hesap_no=pn_hesap_no ;
     IF ps_durum_kodu='K' THEN
       UPDATE Muh_Hesap
          SET KAPAMA_TARIHI=Pkg_Muhasebe.Banka_Tarihi_Bul
        WHERE hesap_no=pn_hesap_no ;
     END IF;
    ELSIF ps_tur='KREDI' THEN
     UPDATE Muh_Hesap_Kredi
        SET DURUM_KODU=ps_durum_kodu,
            KAPANIS_TARIHI =NULL
      WHERE hesap_no=pn_hesap_no ;
     IF ps_durum_kodu='K' THEN
       UPDATE Muh_Hesap_Kredi
          SET KAPANIS_TARIHI=Pkg_Muhasebe.Banka_Tarihi_Bul
        WHERE hesap_no=pn_hesap_no ;
     END IF;
    END IF;
  END HesapDurumGuncelle;
/***********************************************************************************************************/
  FUNCTION GecenYilFaizToplami(pn_hesap_no NUMBER) RETURN NUMBER IS
   vn_gecen_yil_faiz number;
  begin
         select null
           into vn_gecen_yil_faiz
           from muh_hesap h  
          where h.hesap_no = pn_hesap_no
          union
         select k.gecenyil_faiz_tutari
           from muh_hesap_kredi k  
          where k.hesap_no = pn_hesap_no
          union
         select v.gecen_yil_faiz_toplami
           from muh_hesap_vadeli v  
          where v.hesap_no = pn_hesap_no;

     return vn_gecen_yil_faiz;
  END GecenYilFaizToplami;
/***********************************************************************************************************/
  FUNCTION BirikmisFaizPoz(pn_hesap_no NUMBER) RETURN NUMBER IS
--    ln_birikmis           NUMBER;
    vn_birikmis_faiz_poz number;
  BEGIN
         select h.birikmis_faiz_poz
           into vn_birikmis_faiz_poz
           from muh_hesap h  
          where h.hesap_no = pn_hesap_no
          union
         select null
           from muh_hesap_kredi k  
          where k.hesap_no = pn_hesap_no
          union
         select v.birikmis_faiz_poz
           from muh_hesap_vadeli v  
          where v.hesap_no = pn_hesap_no;

     return vn_birikmis_faiz_poz;
  END BirikmisFaizPoz;
/***********************************************************************************************************/
  FUNCTION BirikmisFaizNeg(pn_hesap_no NUMBER) RETURN NUMBER IS
--    ln_birikmis           NUMBER;
    vn_birikmis_faiz_neg number;
  BEGIN
         select h.birikmis_faiz_neg
           into vn_birikmis_faiz_neg
           from muh_hesap h  
          where h.hesap_no = pn_hesap_no
          union
         select NVL(k.birikmis_faiz_tutari,0) - NVL(Brk_Faiz_Tahsil_Tutari,0)
           from muh_hesap_kredi k  
          where k.hesap_no = pn_hesap_no
          union
         select null
           from muh_hesap_vadeli v  
          where v.hesap_no = pn_hesap_no;

     return vn_birikmis_faiz_neg;
  END BirikmisFaizNeg;
/***********************************************************************************************************/
  PROCEDURE FaizBakiyeGuncelle(pn_islem_no NUMBER,ps_tur VARCHAR2,ps_islem_tur VARCHAR2,pn_hesap_no NUMBER,pn_tutar NUMBER) IS
        ln_last_tutar         NUMBER;
  BEGIN
     IF ps_tur='A' THEN
      ln_last_tutar:=NVL(pn_tutar,0);
     ELSE--'B'
      ln_last_tutar:= -1*NVL(pn_tutar,0);
     END IF;

     IF ps_islem_tur = 'BIRIKMISFAIZPOZ' THEN
      UPDATE Muh_Hesap_Vadeli a
         SET BIRIKMIS_FAIZ_POZ = NVL(BIRIKMIS_FAIZ_POZ,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     ELSIF ps_islem_tur = 'GECENYILFAIZI' THEN
      UPDATE Muh_Hesap_Vadeli a
         SET GECEN_YIL_FAIZ_TOPLAMI = NVL(GECEN_YIL_FAIZ_TOPLAMI,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     ELSIF ps_islem_tur = 'ODENMISFAIZTOPLAMI' THEN
      UPDATE Muh_Hesap_Vadeli a
         SET ODENMIS_FAIZ_TOPLAMI = NVL(ODENMIS_FAIZ_TOPLAMI,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     ELSIF ps_islem_tur = 'KREDI-BIRIKMISFAIZNEG' THEN
      UPDATE Muh_Hesap_Kredi a
         SET BIRIKMIS_FAIZ_TUTARI= NVL(BIRIKMIS_FAIZ_TUTARI,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     ELSIF ps_islem_tur = 'KREDI-GECENYILFAIZI' THEN
      UPDATE Muh_Hesap_Kredi a
         SET GECENYIL_FAIZ_TUTARI = NVL(GECENYIL_FAIZ_TUTARI,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     ELSIF ps_islem_tur = 'KREDI-ODENMISFAIZTOPLAMI' THEN
      UPDATE Muh_Hesap_Kredi a
         SET TAHSILEDILEN_FAIZ_TUTARI = NVL(TAHSILEDILEN_FAIZ_TUTARI,0)+NVL(ln_last_tutar,0)
       WHERE a.HESAP_NO = pn_hesap_no;
     END IF;

     INSERT INTO MUH_HESAP_FAIZ_LOG
     (ISLEM_NO, TUR, ISLEM_TIPI, HESAP_NO, TUTAR)
     VALUES
     (pn_islem_no,ps_tur ,ps_islem_tur ,pn_hesap_no ,pn_tutar);
  END FaizBakiyeGuncelle;
/***********************************************************************************************************/   

  FUNCTION HesapTuru(pn_hesap_no NUMBER) RETURN varchar2 is
    lc_hesap_turu           varchar2(10);
  BEGIN
  -- select h.hesap_tur into lc_hesap_turu from v_muh_hesap_izleme_tum h where h.hesap_no =  pn_hesap_no;
     select 'VS'
       into lc_hesap_turu
       from muh_hesap h  
      where h.hesap_no = pn_hesap_no
      union
     select 'KR'
       from muh_hesap_kredi h  
      where h.hesap_no = pn_hesap_no
      union
     select 'VD'
       from muh_hesap_vadeli h  
      where h.hesap_no = pn_hesap_no;
  
     return lc_hesap_turu;
  END HesapTuru;
/***********************************************************************************************************/   
function VadesizHesapNo(pn_musteriNo number, pc_subeKodu varchar2, pc_dovizKodu varchar2) return number is
  cursor c_hesap is
    SELECT B.HESAP_NO, B.KISA_ISIM
      FROM V_MUH_HESAP_VDSZ B
     WHERE B.MUSTERI_NO = pn_musteriNo
       AND B.HESAP_SUBE_KODU  = nvl(pc_subeKodu, B.HESAP_SUBE_KODU)
       AND B.DOVIZ_KODU = pc_dovizKodu
     ORDER BY 1;
  r_hesap c_hesap%rowtype;
begin
  open c_hesap;
  fetch c_hesap into r_hesap;
  close c_hesap;
  
  return r_hesap.hesap_no;
end;
/***********************************************************************************************************/
function esas_gun_sayisi_kr return number is 
begin
  return 360;
end;                                
/***********************************************************************************************************/
function esas_gun_sayisi_vd return number is 
  vn_yil number;
begin
  vn_yil := to_number(to_char(pkg_muhasebe.Banka_Tarihi_Bul, 'yyyy'));
  if mod(vn_yil, 4) = 0 then 
    return 366;
  else
    return 365;
  end if;
end;                                
/***********************************************************************************************************/
 Function Gercek_Ticari_Diger_Musteri(pn_musteri_no in number) Return number IS
    /* bu function ile gonderilen musteri numarasi gercek kisi ise ve ayni kisiye ait gercek ticari bir baska musteri/kontakt numarasi varsa onu döner
       gelen musteri no gercek ticari bir musteriye ait ve bir baska gercek kisi musteri/kontakt tanimi varsa da onu doner */
  vn_diger_musterino number;
   cursor c_mus is
     select g.musteri_stat1,g.tc_kimlik_no,g.vergi_no
       from gnl_musteri g
      where g.musteri_no=pn_musteri_no; 
    r_mus c_mus%rowtype;  
 Begin         
   If pn_musteri_no Is Not Null Then               
     if pkg_musteri.tur(pn_musteri_no) = 'G' then
        Open c_mus;
        Fetch c_mus into r_mus;
        close c_mus;
       
        Begin  
           select g.musteri_no
             into vn_diger_musterino
             from bnspr.gnl_musteri g
            where g.musteri_tur_kod = 'G'
              and g.musteri_no != pn_musteri_no
              and g.musteri_stat1 = decode(r_mus.musteri_stat1,1,4,4,1)
              and (g.tc_kimlik_no = r_mus.tc_kimlik_no OR vergi_no = DECODE(r_mus.vergi_no,'9999999994','-',r_mus.vergi_no))
              and g.durum_kodu='A'; 
        exception when no_data_found then
           null;
        end;        
     end if;
  end if;
  return vn_diger_musterino;   
 End Gercek_Ticari_Diger_Musteri;     



Procedure Rezerv_Vadesiz_Hesap_Acilis(pn_musteri_no number, 
                                      pc_doviz_kodu varchar2 default pkg_genel_pr.lc_al,
                                      pc_aciklama varchar2 default null
                                      ) is

 vn_hesap_no number;
 vs_iban muh_hesap.iban%type;

begin

   vn_hesap_no := PKG_GENEL_PR.genel_kod_al('HESAP.VDSZ');
   
   vs_iban := Pkg_Iban.sp_IBAN_al(vn_hesap_no);
   
insert into muh_hesap_rezerv
  (musteri_no, hesap_no, iban, doviz_kodu, durum_kodu, aciklama)
values
  (pn_musteri_no, vn_hesap_no, vs_iban, pc_doviz_kodu, 'A', pc_aciklama);

end;
/*********************************************************************************************************/
 Function Aktif_Fon_Hesap(pn_musteriNo number) return number IS
    cursor c_fon is
     select t.hesap_no
       from muh_hesap_tanim t, muh_hesap h
      where t.hesap_no = h.hesap_no
        and h.musteri_no = pn_musteriNo
        and nvl(t.otomatik_fon, 'H') = 'E';
    vn_fon_hesap number;        
 Begin
    open c_fon;
    Fetch c_fon into vn_fon_hesap;
    close c_fon;
    
    return vn_fon_hesap;
 End Aktif_Fon_Hesap;   

/*********************************************************************************************************/
 Function TuzelKurumsalKdhEksiBakiyeTop(pn_hesap_no muh_hesap.hesap_no%type, pc_kendi_dahil VARCHAR2 DEFAULT 'E') 
  return number is
    vn_eksi_bakiye_toplam number;
    vn_musteri_no gnl_musteri.musteri_no%type;
    vn_kmh number;
 Begin
    vn_musteri_no := musteri_no(pn_hesap_no);
    
    IF pkg_musteri.tur(vn_musteri_no) = 'T' THEN
        
       select count(*) into vn_kmh from bnspr.kmh_tanim tt
        where tt.musteri_no=vn_musteri_no
          and NVL(tt.durum, 'A') NOT IN ('KAPALI', 'T')
          and tt.musteri_tipi = 'T'
          and tt.kmh_grup_kod = 'KURUMSAL'
          and tt.doviz_kodu = 'TRY';
          
      if vn_kmh>0 then    
           select nvl(sum(b.bakiye), 0)
             into vn_eksi_bakiye_toplam
             from bnspr.muh_hesap h, bnspr.kmh_tanim tt, bnspr.muh_hesap_bakiye b
            where tt.musteri_no = vn_musteri_no
              and h.HESAP_NO = tt.hesap_no
              and NVL(tt.durum, 'A') NOT IN ('KAPALI', 'T')
              and tt.musteri_tipi = 'T'
              and tt.kmh_grup_kod = 'KURUMSAL'
              and tt.doviz_kodu = 'TRY'
              and b.hesap_no = h.hesap_no
              and b.bakiye < 0
              and h.HESAP_NO <> decode(pc_kendi_dahil, 'E', 0, pn_hesap_no);
      else
            vn_eksi_bakiye_toplam := 0; 
      end if;         
    ELSE
       vn_eksi_bakiye_toplam := 0;
    END IF; 
       
    return vn_eksi_bakiye_toplam;
 Exception When NO_DATA_FOUND Then
    return 0;
 End TuzelKurumsalKdhEksiBakiyeTop;
/*********************************************************************************************************/
 Function BeyazListeWsKontrol(pn_hesap_no gnl_beyaz_liste_hesap_ws.hesap_no%type,pn_kanal_kod gnl_beyaz_liste_hesap_ws.kanal_kod%type := null) return number is
    vn_temp number;
  Begin
    select count(*)
      into vn_temp
      from gnl_beyaz_liste_hesap_ws
     where hesap_no = pn_hesap_no
       and kanal_kod = nvl(pn_kanal_kod,pkg_global.Get_KanalKod);
    
    if vn_temp > 0 then
      return 1;
    else
      return 0;
    end if;
    
    exception when others then
      return 0;
  
  End BeyazListeWsKontrol;
end;
/
