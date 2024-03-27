CREATE OR REPLACE PACKAGE Pkg_Musteri IS
  -- Author  : BILALG
  -- Created : 08.10.2007
  -- Purpose : Müsteri fonksiyonlari için hazirlandi

 v_musteri_kayit          gnl_musteri%rowtype;
 v_musteri_kimlik_kayit   gnl_musteri_kimlik%rowtype;

 Function durum(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.durum_kodu%type;

 --Function personel_mi(p_musteri_no gnl_musteri.musteri_no%type) return varchar2;
 Function tur(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.musteri_tur_kod%type;
 Function hp_grup_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.dk_grup_kod%type;
 Function unvan(p_musteri_no gnl_musteri.musteri_no%type) return varchar2;
 Function kisa_ad(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.kisa_ad%type;
 Function meslek_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.meslek_kod%type;
 Function egitim_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.egitim_kod%type;
 Function medeni_hal_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri_kimlik.medeni_hal_kod%type;
 Function hesap_ucreti_alinsinmi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.hesap_ucreti_alinsinmi%type;
 Function cek_karnesi_varmi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.cek_karnesi_varmi%type;
 Function personel_sicil_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.personel_sicil_no%type;
 Function yurt_ici_disi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.yurt_ici_disi%type;
 Function uyruk_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.uyruk_kod%type;
 Function tc_kimlik_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.tc_kimlik_no%type;
 Function ticari_sicil_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.ticari_sicil_no%type;
 Function bic_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.bic_kod%type;
 Function swift_mesaj_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.swift_mesaj_kod%type;
 Function reuters_info_page(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.reuters_info_page%type;
 Function reuters_dealing_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.reuters_dealing_kod%type;
 Function modul_tur_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.modul_tur_kod%type;
 Function urun_tur_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.urun_tur_kod%type;
 Function urun_sinif_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.urun_sinif_kod%type;
 Function sektor_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.sektor_kod%type;
 Function sektor_kod1(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.sektor_kod1%type;
 Function sektor_kod2(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.sektor_kod2%type;
 Function vergi_il_kodu(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.vergi_il_kodu%type;
 Function vergi_daire_kodu(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.vergi_daire_kodu%type;
 Function vergi_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.vergi_no%type;
 Function ticari_scl_daire_kodu(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.ticari_sicil_daire_kodu%type;
 Function ticari_scl_kayit_tar(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.ticari_sicil_kayit_tarihi%type;
 Function vergi_kayit_unvani(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.vergi_kayit_unvani%type;
 Function veli_adi(p_musteri_no gnl_musteri.musteri_no%type) return varchar2;
 Function veli_tc_kimlik_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri_velivasi.veli_tc_kimlik_no%type;
 Function veli_vergi_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri_velivasi.veli_vergi_no%type;
 /*Function veli_musteri_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri_velivasi.veli_musteri_no%type;
   artik tek veli vasi yok o yüzden calismaz MHA 151207*/
PROCEDURE musteri_grubu_guncelle(pn_musteri_no NUMBER, ps_grup_kodu gnl_grup_kodlari.kod%TYPE );

 Function dogum_tarihi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.dogum_tarihi%type;
 Function dogum_yeri(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.dogum_yeri%type;
 Function dogum_il_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.dogum_il_kod%type;
 Function dogum_ilce_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.dogum_ilce_kod%type;
 Function cinsiyet_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.cinsiyet_kod%type;
 Function baba_adi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.baba_adi%type;
 Function anne_adi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.anne_adi%type;
 Function anne_kizlik_soyadi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.anne_kizlik_soyadi%type;
 Function kizlik_soyadi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.kizlik_soyadi%type;
 Function nuf_seri_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.nuf_seri_no%type;
 Function nuf_sira_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.nuf_sira_no%type;
 Function nuf_cilt_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.nuf_cilt_no%type;
 Function nuf_aile_sira_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.nuf_aile_sira_no%type;
 Function ehliyet_belge_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.ehliyet_belge_no%type;
 Function pasaport_no(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.pasaport_no%type;


 Function Adres_extre( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
 Function Adres_extre_il_ilce_yok( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
 FUNCTION Adres_Teyitli( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
 Function adres(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 FUNCTION adres_romiz(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE ;
 Function adres_il_ilce_yok(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 Function adres_il(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 Function adres_il_kod(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 Function adres_ilce(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 Function adres_ilce_kod(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.adres%type;
 Function adres_ulke_kod(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.ulke_kod%type;
 Function adres_posta_kod(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.posta_kod%type;
 Function adres_semt(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.semt%type;
 Function isyeri_unvani(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.isyeri_unvani%type ;
 Function email_is(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.email_is%type ;
 Function email_kisisel(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.email_kisisel%type ;
 Function web_adresi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.web_adres%type ;
 Function iletisim_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_format varchar2 default '+UAT') return varchar2 ;

 --1-Ev  2-Is  3-Gsm  4-Yazlik  5-Fax
 Function telefon(p_musteri_no gnl_musteri_adres.musteri_no%type,p_tel_tip gnl_musteri_telefon.tel_tip%TYPE, p_format varchar2 default '+UAT') return varchar2 ;
 -- telefon id ile cekilmek istenirse
 Function telefon_with_sira(p_musteri_no gnl_musteri_adres.musteri_no%type,p_sirano gnl_musteri_telefon.sira_no%TYPE, p_format varchar2 default '+UAT') return varchar2;

 -- Yukaridaki functionlardan alinan formattaki telefon bilgisinin telefon tipini geri döner.
 Function Telefon_Tip(p_musteri_no gnl_musteri_adres.musteri_no%type,p_telno in varchar2, p_format varchar2 default '+UAT') return gnl_musteri_telefon.tel_tip%TYPE;
 Function otp_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_format varchar2 default '+UAT') return varchar2;
/* Function telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 ;
 Function gsm_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 ;
 Function fax_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 ;
 Function diger1_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 ;
 Function diger2_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 ;
 MHA 151207 */
 Function adr_gecerlilik_bas_tar(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.gecerlilik_bas_tarihi%type ;
 Function adr_gecerlilik_bit_tar(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres.gecerlilik_bit_tarihi%type ;


  PROCEDURE  Musteri_Adres( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ,
    		 				   ps_adres 	   OUT GNL_MUSTERI_ADRES.adres%TYPE,
							     ps_semt 	     OUT GNL_MUSTERI_ADRES.semt%TYPE,
							     ps_il_kod  	 OUT GNL_MUSTERI_ADRES.il_kod%TYPE,
                   ps_ilce_kod   OUT gnl_musteri_adres.ilce_kod%TYPE,
							     pn_posta_kod  OUT GNL_MUSTERI_ADRES.posta_kod%TYPE,
							     ps_ulke_kod	 OUT GNL_MUSTERI_ADRES.ulke_kod%TYPE);


  FUNCTION  musteri_urun_sinif_al(ps_modul_tur_kod   GNL_MUSTERI.modul_tur_kod%TYPE,
 		   						                   ps_urun_tur_kod    GNL_MUSTERI.urun_tur_kod%TYPE,
									                   ps_sinif_param_kod VARCHAR2 DEFAULT NULL ) RETURN GNL_MUSTERI.urun_sinif_kod%TYPE;


  Function TCNO_KONTROL(pn_tc_kimlik_no NUMBER) RETURN BOOLEAN;
  FUNCTION Is_Number(ps_str VARCHAR2) RETURN VARCHAR2;
  FUNCTION nufus_cuzdani_serino_gecerlimi(ps_seri_no VARCHAR2,ps_cinsiyet_kod VARCHAR2,ps_hata_mesaj_kod OUT VARCHAR2) RETURN VARCHAR2;
  FUNCTION personel_musterino_al(ps_personel_numara muh_personel.personel_numara%TYPE) RETURN gnl_musteri.musteri_no%TYPE;
  FUNCTION personel_musterikurum_al(ps_personel_numara muh_personel.personel_numara%TYPE) RETURN muh_personel.kurum_kodu%TYPE;
  PROCEDURE personel_musterino_guncelle(pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ,pn_sicil_no GNL_MUSTERI.personel_sicil_no%TYPE);

  -- 1001,1002 ekranlarda girilen musteri bilgileri ile uyumlu olan
  -- baska bir müsteri kaydi olup olmadigini arastiran function.
  -- %param ps_full_isim Bireysel icin isim||ikinci_isim||soyisim degerleri icin ticari_unvan

  Function Musteri_Mevcutmu (ps_full_isim       IN  VARCHAR2 ,
                             ps_musteri_tur     IN  VARCHAR2,
                             ps_yerlesim_kod    IN  VARCHAR2,
                             ps_baba_adi        IN  Gnl_Musteri_Kimlik.Baba_Adi%TYPE ,
                             pd_dogum_tarihi    IN  Gnl_Musteri_Kimlik.Dogum_Tarihi%TYPE ,
                             ps_dogum_yeri      IN  Gnl_Musteri_Kimlik.Dogum_Yeri%TYPE ,
                             ps_tc_kimlik_no    IN  Gnl_Musteri.Tc_Kimlik_No%TYPE ,
                             ps_ticari_sicil_no IN  GNl_Musteri.Ticari_Sicil_No%TYPE,
                             ps_vergi_no        IN  Gnl_Musteri.Vergi_No%TYPE,
                             pn_exmusteri_no    IN  Gnl_Musteri.Musteri_No%TYPE DEFAULT 0,
                             pn_musteri_no      OUT Gnl_Musteri.Musteri_No%TYPE) Return VARCHAR2;

  FUNCTION Personel_mi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2;

  FUNCTION	 Musterinin_Hesabi_Varmi(pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ) RETURN VARCHAR2;

  Function Musteri_guncel_Kaydi_Olus (pn_musteri_no number ,ps_durum VARCHAR2 DEFAULT 'A',pn_tx_no number default null ) return number;
  FUNCTION Musteri_Kapatilabilirmi (pn_musteri_no NUMBER) RETURN VARCHAR2;
  Function musteri_grup_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.musteri_grup_kod%type;

  -- Ortak hesapli musterilerde ortaklik tipini dondurur.
  Function ortaklik_turu(p_musteri_no gnl_musteri_ortaklik.musteri_no%type) return gnl_musteri_ortaklik.ortaklik_turu%type;
  -- BPM bayii tanimlama icin musteri bilgileri
/*  _BPM altina tasindi 110408
Procedure musteri_bayi_bilgileri(pn_musteri_no        in number,
                                    ps_vergi_il_kodu     out varchar2,
                                    ps_vergi_daire_kodu  out varchar2,
                                    pn_vergi_no          out number,
                                    ps_email             out varchar2,
                                    ps_web_adres         out varchar2,
                                    ps_ticari_unvan      out varchar2,
                                    ps_firma_tipi        out varchar2,
                                    pd_kurulus_tarihi    out date,
                                    ps_adres_kod         out varchar2,
                                    ps_isyeri_unvani     out varchar2,
                                    ps_adres             out varchar2,
                                    ps_semt              out varchar2,
                                    ps_il_kod            out varchar2,
                                    ps_ilce_kod          out varchar2,
                                    ps_posta_kod         out varchar2,
                                    ps_ulke_kod          out varchar2,
                                    ps_tel_tip           out varchar2,
                                    ps_alan_kod          out varchar2,
                                    ps_telefon_no        out varchar2);*/
  -- Musteriye veya musterinin bagli oldugu gruba ait marj tanimlanmissa bunu donduran function
  Function musteri_vadeli_marj_oran(pn_musteri_no in number) Return number;
  -- return boolean donen function yerine 0-1 donen function yazildi...MHA 090408
  Function TCKN_KONTROL(pn_tc_kimlik_no NUMBER) RETURN NUMBER;
  -- musterinin adinda kontrol yapilir. noktalama isaretleri ve 3 karakter pespese kontrolu
  function ad_kontrol(pn_ad in varchar2) return number;

  --------------------------------------------------
  --function AmacKod (pc_kod in varchar2) return varchar2;
  function AmacKodVarMi (pc_kod varchar2, pc_amacKod varchar2) return number;
  -- ADK useri create edildiginde bilgilendirme maili atar.
  Procedure ADK_user_creation_infomail(pn_islem_no in number,ps_username in varchar2,ps_passwd in varchar2);

  function MusteriNoVarMi (pn_musteri_no number) return number;
  Function musteri_temsilcisi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.musteri_temsilcisi%type ;
  Function ilk_iliski_tarihi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.ilk_iliski_tarihi%type ;
  Function grup_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.grup_kod%type ;
  Function rating_kodu(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.rating_kodu%type ;
  Function musteri_stat1(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.musteri_stat1%type;
  Function musteriMi_kontaktMi(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.Musteri_Kontakt%type;
  Function musteri_sube(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.sube_kodu%type;

  FUNCTION  Adres_extre_il_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_ilce_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_il_adi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_ilce_adi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_posta_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_semt( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  FUNCTION  Adres_extre_ulke_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) Return varchar2;
  Function aps_adresi(pn_musteri_no number) return varchar2;
  Function aps_yabanci_adresi(pn_musteri_no number) return varchar2 ;
  Function olum_tarihi(p_musteri_no gnl_musteri_kimlik.musteri_no%type) return gnl_musteri_kimlik.olum_tarihi%type ;
  Function iletisim_dili(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.iletisim_dili%type  ;
  Function sube_kodu(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.sube_kodu%type ;
  Function portfoy_kod(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.portfoy_kod%type ;
  Function Musteri_Varmi_TCKN(pn_tckn GNL_MUSTERI.Tc_Kimlik_No%TYPE) Return Number;
  Function Musteri_Varmi_VKN(pn_vkn GNL_MUSTERI.Vergi_No%TYPE) Return Number;
  Function getCustomerInfoFromBicCode(pc_bic_kod gnl_musteri.bic_kod%TYPE) Return pkg_types.rc_resultset;
end;
/
CREATE OR REPLACE PACKAGE BODY Pkg_Musteri IS

 FUNCTION musteri_kayit(pn_musteri_no IN NUMBER) RETURN gnl_musteri%ROWTYPE IS
    /* surekli gnl_musteriden sorgulama yerine sadece degiskendeki musteri numarası farklı ise sorgulama yapalım MHA 270310 */
 BEGIN
   IF pn_musteri_no IS NULL THEN
      v_musteri_kayit := NULL;
    ELSIF NVL(v_musteri_kayit.musteri_no,0)!=pn_musteri_no THEN
       v_musteri_kayit := pkg_tablo.musteri_kayit(pn_musteri_no);
    END IF;
      RETURN v_musteri_kayit;

 END musteri_kayit;

 FUNCTION musteri_kimlik_kayit(pn_musteri_no IN NUMBER) RETURN gnl_musteri_kimlik%ROWTYPE IS
    /* surekli gnl_musteri_kimlikden sorgulama yerine sadece degiskendeki musteri numarası farklı ise sorgulama yapalım MHA 270310 */
    vc_tur gnl_musteri.musteri_tur_kod%TYPE;
 BEGIN
    IF pn_musteri_no IS NULL THEN
       v_musteri_kimlik_kayit := NULL;
    ELSIF NVL(v_musteri_kimlik_kayit.musteri_no,0)!=pn_musteri_no THEN
       select musteri_tur_kod
         into vc_tur
         from gnl_musteri
        where musteri_no=pn_musteri_no; 
     if vc_tur = 'G' then   
        v_musteri_kimlik_kayit := pkg_tablo.musteri_kimlik_kayit(pn_musteri_no);
     else
        v_musteri_kimlik_kayit := null;
     end if;      
    END IF;

    RETURN v_musteri_kimlik_kayit;
 exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MUSTERI',pn_musteri_no);
 END musteri_kimlik_kayit;

 FUNCTION durum(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.durum_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).durum_kodu;
 END;
  --Calikbank personeli mi?
  --sicil_no dolu ise personel, degil ise personel degil  Rabia,
/*
 Function personel_mi(p_musteri_no gnl_musteri.musteri_no%type) return varchar2 is
 begin
   return musteri_kayit(p_musteri_no).personel_sicil_no;
 end;
 */

 FUNCTION tur(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.musteri_tur_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).musteri_tur_kod;
 END;

 FUNCTION hp_grup_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.dk_grup_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).dk_grup_kod;
 END;
   -----------***** Rabia
 PROCEDURE musteri_grubu_guncelle(pn_musteri_no NUMBER, ps_grup_kodu gnl_grup_kodlari.kod%TYPE )
 IS
  BEGIN

    IF pn_musteri_no  <> 0 THEN
	   UPDATE GNL_MUSTERI
		    SET grup_kod = ps_grup_kodu
		  WHERE musteri_no = pn_musteri_no ;
    END IF;

  EXCEPTION
   WHEN OTHERS THEN
	    NULL ; --RAISE_APPLICATION_ERROR(-20100,Pkg_Hata.getUCPOINTER || '1729' || Pkg_Hata.getDelimiter ||TO_CHAR(SQLCODE) || SQLERRM ||Pkg_Hata.getDelimiter|| Pkg_Hata.getUCPOINTER);
 END;
 -----------*****

 FUNCTION unvan(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN VARCHAR2 IS
   wmuskayit gnl_musteri%ROWTYPE;
	 v_musteri_bulundu NUMBER;
 BEGIN
   IF p_musteri_no IS NOT NULL THEN

		 BEGIN
		 wmuskayit := musteri_kayit(p_musteri_no);
     v_musteri_bulundu := 1;
		 EXCEPTION WHEN others THEN
		   v_musteri_bulundu:=0;
		 END;

		 IF v_musteri_bulundu=0 THEN
		    RETURN NULL;
		 ELSE
					 IF tur(p_musteri_no)='G' THEN --Kisi ise
							IF NVL(wmuskayit.musteri_stat1,1) != 4 THEN
								 IF wmuskayit.ikinci_adi IS NOT NULL THEN
										RETURN wmuskayit.adi||' '||
													 wmuskayit.ikinci_adi||' '||
													 wmuskayit.soyadi;
								 ELSE
										RETURN wmuskayit.adi||' '||
													 wmuskayit.soyadi;
								 END IF;
							ELSE
								 IF wmuskayit.ikinci_adi IS NOT NULL THEN
										RETURN wmuskayit.adi||' '||
													 wmuskayit.ikinci_adi||' '||
													 wmuskayit.soyadi||' - '||
													 wmuskayit.ticari_unvan;
								 ELSE
										RETURN wmuskayit.adi||' '||
													 wmuskayit.soyadi||' - '||
													 wmuskayit.ticari_unvan;
								 END IF;
							END IF;
					 ELSIF tur(p_musteri_no)='O' THEN --Ortak ise
							RETURN wmuskayit.kisa_ad;
					 ELSE
							RETURN wmuskayit.ticari_unvan;
					 END IF;
      END IF;

  ELSE
    RETURN NULL;
  END IF;
 END;

 FUNCTION kisa_ad(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.kisa_ad%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).kisa_ad;
 END;

 FUNCTION meslek_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.meslek_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).meslek_kod;
 END;

 FUNCTION egitim_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.egitim_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).egitim_kod;
 END;

 FUNCTION medeni_hal_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri_kimlik.medeni_hal_kod%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_kimlik_kayit(p_musteri_no).medeni_hal_kod;
 END;

 FUNCTION hesap_ucreti_alinsinmi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.hesap_ucreti_alinsinmi%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).hesap_ucreti_alinsinmi;
 END;

 FUNCTION cek_karnesi_varmi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.cek_karnesi_varmi%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).cek_karnesi_varmi;
 END;

 FUNCTION personel_sicil_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.personel_sicil_no%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).personel_sicil_no;
 END;

 FUNCTION yurt_ici_disi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.yurt_ici_disi%TYPE IS
  ln_musteri_no NUMBER;
 BEGIN
   IF p_musteri_no IS NOT NULL THEN
    IF musteri_kayit(p_musteri_no).yurt_ici_disi IS NOT NULL THEN 
      RETURN musteri_kayit(p_musteri_no).yurt_ici_disi;
    ELSE
      IF musteri_kayit(p_musteri_no).musteri_tur_kod = 'O' THEN 
        -- Ortaklarin
        -- Müsteri olaninin min musteri nolusu
        BEGIN
          SELECT MIN(bagli_musteri_no) INTO ln_musteri_no
          FROM gnl_musteri_ortaklik o, gnl_musteri M
          WHERE o.musteri_no = p_musteri_no 
            AND o.bagli_musteri_no = M.musteri_no
            AND M.musteri_kontakt = 'M' ; 
        EXCEPTION WHEN others THEN 
          -- Ortaklik kontaklardan olusuyorsa müsteri yoksa
          BEGIN
          SELECT MIN(bagli_musteri_no) INTO ln_musteri_no 
          FROM gnl_musteri_ortaklik o, gnl_musteri M
          WHERE o.musteri_no = p_musteri_no 
            AND o.bagli_musteri_no = M.musteri_no
            AND M.musteri_kontakt = 'K' ;            
          EXCEPTION WHEN others THEN 
            ln_musteri_no := NULL ; 
          END ;
        END ;
        IF ln_musteri_no IS NOT NULL THEN 
          RETURN musteri_kayit(ln_musteri_no).yurt_ici_disi;
        ELSE
          RETURN NULL ; 
        END IF; 
       
      ELSE
        RETURN musteri_kayit(p_musteri_no).yurt_ici_disi;
      END IF;
    END IF; 
   ELSE
    RETURN NULL;
   END IF;


 END;

 FUNCTION uyruk_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.uyruk_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).uyruk_kod;
 END;

 FUNCTION tc_kimlik_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.tc_kimlik_no%TYPE IS
 BEGIN
   IF p_musteri_no IS NOT NULL THEN
      RETURN musteri_kayit(p_musteri_no).tc_kimlik_no;
   ELSE
      RETURN NULL;
   END IF;
 END;

 FUNCTION ticari_sicil_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.ticari_sicil_no%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).ticari_sicil_no;
 END;

 FUNCTION bic_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.bic_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).bic_kod;
 END;

 FUNCTION swift_mesaj_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.swift_mesaj_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).swift_mesaj_kod;
 END;

 FUNCTION reuters_info_page(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.reuters_info_page%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).reuters_info_page;
 END;

 FUNCTION reuters_dealing_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.reuters_dealing_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).reuters_dealing_kod;
 END;

 FUNCTION modul_tur_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.modul_tur_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).modul_tur_kod;
 END;

 FUNCTION urun_tur_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.urun_tur_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).urun_tur_kod;
 END;

 FUNCTION urun_sinif_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.urun_sinif_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).urun_sinif_kod;
 END;

 FUNCTION sektor_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.sektor_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).sektor_kod;
 END;

 FUNCTION sektor_kod1(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.sektor_kod1%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).sektor_kod1;
 END;

 FUNCTION sektor_kod2(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.sektor_kod2%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).sektor_kod2;
 END;

 FUNCTION vergi_il_kodu(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.vergi_il_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).vergi_il_kodu;
 END;

 FUNCTION vergi_daire_kodu(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.vergi_daire_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).vergi_daire_kodu;
 END;

 FUNCTION vergi_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.vergi_no%TYPE IS
 BEGIN
   IF p_musteri_no IS NOT NULL THEN
      RETURN musteri_kayit(p_musteri_no).vergi_no;
   ELSE
      RETURN NULL;
   END IF;
 END;

 FUNCTION ticari_scl_daire_kodu(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.ticari_sicil_daire_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).ticari_sicil_daire_kodu;
 END;

 FUNCTION ticari_scl_kayit_tar(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.ticari_sicil_kayit_tarihi%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).ticari_sicil_kayit_tarihi;
 END;

 FUNCTION vergi_kayit_unvani(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.vergi_kayit_unvani%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).vergi_kayit_unvani;
 END;

 FUNCTION veli_adi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN VARCHAR2 IS
 BEGIN
   RETURN pkg_tablo.musteri_veli_kayit(p_musteri_no).veli_isim||' '||
          pkg_tablo.musteri_veli_kayit(p_musteri_no).veli_ikinci_isim||' '||
          pkg_tablo.musteri_veli_kayit(p_musteri_no).veli_soyadi;
 END;

 FUNCTION veli_tc_kimlik_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri_velivasi.veli_tc_kimlik_no%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_veli_kayit(p_musteri_no).veli_tc_kimlik_no;
 END;

 FUNCTION veli_vergi_no(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri_velivasi.veli_vergi_no%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_veli_kayit(p_musteri_no).veli_vergi_no;
 END;

/* Function veli_musteri_no(p_musteri_no gnl_musteri.musteri_no%type) return gnl_musteri.veli_musteri_no%type is
 begin
   return musteri_kayit(p_musteri_no).veli_musteri_no;
 end; artik tek veli vasi yok o yüzden bu kisim calismaz MHA 151207*/




 FUNCTION dogum_tarihi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.dogum_tarihi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).dogum_tarihi;
 END;

 FUNCTION dogum_yeri(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.dogum_yeri%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).dogum_yeri;
 END;

 FUNCTION dogum_il_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.dogum_il_kod%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).dogum_il_kod;
 END;

 FUNCTION dogum_ilce_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.dogum_ilce_kod%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).dogum_ilce_kod;
 END;

 FUNCTION cinsiyet_kod(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.cinsiyet_kod%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).cinsiyet_kod;
 END;

 FUNCTION baba_adi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.baba_adi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).baba_adi;
 END;

 FUNCTION anne_adi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.anne_adi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).anne_adi;
 END;

 FUNCTION anne_kizlik_soyadi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.anne_kizlik_soyadi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).anne_kizlik_soyadi;
 END;

 FUNCTION kizlik_soyadi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.kizlik_soyadi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).kizlik_soyadi;
 END;

 FUNCTION nuf_seri_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.nuf_seri_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).nuf_seri_no;
 END;

 FUNCTION nuf_sira_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.nuf_sira_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).nuf_sira_no;
 END;

 FUNCTION nuf_cilt_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.nuf_cilt_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).nuf_cilt_no;
 END;

 FUNCTION nuf_aile_sira_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.nuf_aile_sira_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).nuf_aile_sira_no;
 END;

 FUNCTION ehliyet_belge_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.ehliyet_belge_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).ehliyet_belge_no;
 END;

 FUNCTION pasaport_no(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.pasaport_no%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).pasaport_no;
 END;
--- Extre Adresi
  FUNCTION  Adres_extre( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod, a.ilce_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
	   ps_adres     gnl_musteri_adres.adres%TYPE;
	   ps_semt      gnl_musteri_adres.semt%TYPE;
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
     pn_posta_kod gnl_musteri_adres.posta_kod%TYPE;
   	 ps_ulke_kod  gnl_musteri_adres.ulke_kod%TYPE;
     ps_ilce_kod  gnl_musteri_adres.ilce_kod%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod, ps_ilce_kod;
 	  CLOSE cur_ekstre_adres;
   --
	  IF  ps_adres     IS NULL  THEN  ps_adres := ' ';   END IF;
	  IF  ps_semt      IS NULL  THEN  ps_semt := ' ';    END IF;
 	  IF  ps_il_kod    IS NULL  THEN  ps_il_kod := ' ';  END IF;
   	IF  ps_ulke_kod  IS NULL  THEN  ps_ulke_kod:= ' '; END IF;
    IF  ps_ilce_kod  IS NULL  THEN  ps_ilce_kod:= ' '; END IF;
  IF ps_adres != ' ' THEN
   RETURN ps_adres||' '||
          ps_semt||' '||CHR(13)||CHR(10)||
          pkg_genel_pr.ilce_adi_hatasiz(ps_il_kod,ps_ilce_kod)|| ' ' || pkg_genel_pr.il_adi_hatasiz(ps_il_kod) ||' '||
          pn_posta_kod ||' '||CHR(13)||CHR(10)||
          pkg_genel_pr.ulke_adi_hatasiz(ps_ulke_kod)
      ;
  ELSE
    RETURN NULL;
  END IF;



  EXCEPTION
	  WHEN OTHERS THEN
        Pkg_hata.hata_yaz(421,TRUE,pn_musteri_no);
  END;
--
  FUNCTION  Adres_extre_il_ilce_yok( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT adres
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
	   ps_adres     gnl_musteri_adres.adres%TYPE;
	   ps_semt      gnl_musteri_adres.semt%TYPE;
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
     pn_posta_kod gnl_musteri_adres.posta_kod%TYPE;
   	 ps_ulke_kod  gnl_musteri_adres.ulke_kod%TYPE;
     ps_ilce_kod  gnl_musteri_adres.ilce_kod%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_adres;
 	  CLOSE cur_ekstre_adres;
   --
	  RETURN ps_adres;
  END;
--
--- Teyitli Adresi
  FUNCTION  Adres_Teyitli( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS
    /* SWIFT mesajlarinda yabanci musteriler için extre adresi yerine teyitli adres kullanilmasi isteniyor MHA 290311 BNSPRPRO-5894 */
     CURSOR cur_ekstre_adres IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod, a.ilce_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.adres_teyit = 'E';
	   ps_adres     gnl_musteri_adres.adres%TYPE;
	   ps_semt      gnl_musteri_adres.semt%TYPE;
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
     pn_posta_kod gnl_musteri_adres.posta_kod%TYPE;
   	 ps_ulke_kod  gnl_musteri_adres.ulke_kod%TYPE;
     ps_ilce_kod  gnl_musteri_adres.ilce_kod%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod, ps_ilce_kod;
 	  CLOSE cur_ekstre_adres;
   --
	  IF  ps_adres     IS NULL  THEN  ps_adres := ' ';   END IF;
	  IF  ps_semt      IS NULL  THEN  ps_semt := ' ';    END IF;
 	  IF  ps_il_kod    IS NULL  THEN  ps_il_kod := ' ';  END IF;
   	IF  ps_ulke_kod  IS NULL  THEN  ps_ulke_kod:= ' '; END IF;
    IF  ps_ilce_kod  IS NULL  THEN  ps_ilce_kod:= ' '; END IF;
  IF ps_adres != ' ' THEN
   RETURN ps_adres||' '||
          ps_semt||' '||CHR(13)||CHR(10)||
          pkg_genel_pr.ilce_adi_hatasiz(ps_il_kod,ps_ilce_kod)|| ' ' || pkg_genel_pr.il_adi_hatasiz(ps_il_kod) ||' '||
          pn_posta_kod ||' '||CHR(13)||CHR(10)||
          pkg_genel_pr.ulke_adi_hatasiz(ps_ulke_kod)
      ;
  ELSE
    RETURN NULL;
  END IF;



  EXCEPTION
	  WHEN OTHERS THEN
        Pkg_hata.hata_yaz(421,TRUE,pn_musteri_no);
  END Adres_Teyitli;
 ----
 FUNCTION adres(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).adres ||' '||
    pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).semt||' '||
    pkg_genel_pr.il_adi_hatasiz( pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod) ||' '||
    pkg_genel_pr.ilce_adi_hatasiz ( pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod, pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).ilce_kod ) ;

 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;
  ------------------------------------------------
 FUNCTION adres_romiz(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).adres ||' '||
    pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).semt ||' '||
    pkg_genel_pr.ilce_adi_hatasiz ( pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod, pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).ilce_kod )||' '||
    pkg_genel_pr.il_adi_hatasiz( pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod) ;

 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

-----------------------



 FUNCTION adres_il_ilce_yok(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).adres;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

 FUNCTION adres_il(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_genel_pr.il_adi_hatasiz(pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod);
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;
 --------------------------------------------------------------------
 FUNCTION adres_il_kod(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;
 --------------------------------------------------------------------
 FUNCTION adres_ilce(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_genel_pr.ilce_adi_hatasiz(pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).il_kod, pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).ilce_kod);
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;
 --------------------------------------------------------------------
 FUNCTION adres_ilce_kod(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.adres%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).ilce_kod;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;
--------------------------------------------------------------------
 FUNCTION adres_ulke_kod(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.ulke_kod%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).ulke_kod;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

 FUNCTION adres_posta_kod(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.posta_kod%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).posta_kod;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

 FUNCTION adres_semt(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.semt%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).semt;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

 FUNCTION isyeri_unvani(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.isyeri_unvani%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).isyeri_unvani;
 EXCEPTION
    WHEN others THEN
    RETURN NULL;
 END;

 FUNCTION email_is(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.email_is%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).email_is;
 END;

 FUNCTION email_kisisel(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.email_kisisel%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).email_kisisel;
 END;

 FUNCTION web_adresi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.web_adres%TYPE  IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).web_adres;
 END;

   FUNCTION iletisim_telefon(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_format VARCHAR2 DEFAULT '+UAT') RETURN VARCHAR2 IS
     CURSOR cur_tel IS
       SELECT REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(p_format, 'U', T.ulke_kod),
                                      'A', T.alan_kod),
                                      'T', T.tel_no),
                                      'D', T.dahili_no)
       --'+'||t.ulke_kod||t.alan_kod||t.tel_no
         FROM gnl_musteri_telefon T
        WHERE T.musteri_no = p_musteri_no
          AND T.iletisim_mi='E';
     wtel VARCHAR2(50);

     CURSOR cur_tel2 IS
       SELECT REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(p_format, 'U', T.ulke_kod),
                                      'A', T.alan_kod),
                                      'T', T.tel_no),
                                      'D', T.dahili_no)
         FROM gnl_musteri_telefon T
        WHERE T.musteri_no = p_musteri_no
           AND T.tel_no IS NOT NULL;

   BEGIN
      OPEN cur_tel;
      FETCH cur_tel INTO wtel;
      CLOSE cur_tel;

      IF wtel IS NULL THEN
          OPEN cur_tel2;
          FETCH cur_tel2 INTO wtel;
          CLOSE cur_tel2;
      END IF;

      RETURN wtel;
   END iletisim_telefon;


   --1- Ev  2-Is  3-Gsm  4-Yazlik  5-Fax
   FUNCTION telefon(p_musteri_no gnl_musteri_adres.musteri_no%TYPE,p_tel_tip gnl_musteri_telefon.tel_tip%TYPE, p_format VARCHAR2 DEFAULT '+UAT') RETURN VARCHAR2 IS
     CURSOR cur_tel IS
       SELECT REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(p_format, 'U', T.ulke_kod),
                                      'A', T.alan_kod),
                                      'T', T.tel_no),
                                      'D', T.dahili_no)
  --     select '+'||t.ulke_kod||t.alan_kod||t.tel_no
         FROM gnl_musteri_telefon T
        WHERE T.musteri_no = p_musteri_no
          AND T.tel_tip= p_tel_tip
         ORDER BY NVL(T.upd_date,T.rec_date) DESC;
     wtel VARCHAR2(50);

   BEGIN
      OPEN cur_tel;
      FETCH cur_tel INTO wtel;
      CLOSE cur_tel;

      RETURN wtel;
   END telefon;

   FUNCTION telefon_with_sira(p_musteri_no gnl_musteri_adres.musteri_no%TYPE,p_sirano gnl_musteri_telefon.sira_no%TYPE, p_format VARCHAR2 DEFAULT '+UAT') RETURN VARCHAR2 IS
     CURSOR cur_tel IS
       SELECT REPLACE(
                REPLACE(
                  REPLACE(
                    REPLACE(p_format, 'U', T.ulke_kod),
                                      'A', T.alan_kod),
                                      'T', T.tel_no),
                                      'D', T.dahili_no)
  --     select '+'||t.ulke_kod||t.alan_kod||t.tel_no
         FROM gnl_musteri_telefon T
        WHERE T.musteri_no = p_musteri_no
          AND T.sira_no= p_sirano;
     wtel VARCHAR2(50);

   BEGIN
      OPEN cur_tel;
      FETCH cur_tel INTO wtel;
      CLOSE cur_tel;

      RETURN wtel;
   END telefon_with_sira;

  FUNCTION Telefon_Tip(p_musteri_no gnl_musteri_adres.musteri_no%TYPE,p_telno IN VARCHAR2, p_format VARCHAR2 DEFAULT '+UAT') RETURN gnl_musteri_telefon.tel_tip%TYPE IS
  CURSOR cur_teltip IS
   SELECT tel.tel_tip,
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(p_format, 'U', tel.ulke_kod),
                                    'A', tel.alan_kod),
                                    'T', tel.tel_no),
                                    'D', tel.dahili_no)
          AS telno
     FROM gnl_musteri_telefon tel
    WHERE tel.musteri_no = p_musteri_no;
  rec_teltip cur_teltip%ROWTYPE;
  vs_result gnl_musteri_telefon.tel_tip%TYPE;
 BEGIN
   OPEN cur_teltip;
   LOOP
      FETCH cur_teltip INTO rec_teltip;
      EXIT WHEN cur_teltip%NOTFOUND;
      IF REPLACE(p_telno,' ') = rec_teltip.telno THEN
         vs_result := rec_teltip.tel_tip;
         EXIT;
      END IF;
   END LOOP;
   CLOSE cur_teltip;
   RETURN vs_result;
 END Telefon_Tip;



 FUNCTION otp_telefon(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_format VARCHAR2 DEFAULT '+UAT') RETURN VARCHAR2 IS
   CURSOR cur_OTPtel IS
     SELECT REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(p_format, 'U', T.ulke_kod),
                                    'A', T.alan_kod),
                                    'T', T.tel_no),
                                    'D', T.dahili_no)
     --'+'||t.ulke_kod||t.alan_kod||t.tel_no
       FROM gnl_musteri_telefon T
      WHERE T.musteri_no = p_musteri_no
        AND T.otp_mi='E';
   otptel VARCHAR2(50);

   BEGIN
    OPEN cur_OTPtel;
    FETCH cur_OTPtel INTO otptel;
    CLOSE cur_OTPtel;

    IF otptel IS NULL THEN
      otptel :=  pkg_musteri.telefon(p_musteri_no,3,p_format);
    END IF;

    RETURN otptel;
 END otp_telefon;

 /*Function telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 is
 begin
   return pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).tel_alan_kod||' '||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).tel_no||'-'||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).dahili_no;
 end;

 Function gsm_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 is
 begin
   return pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).gsm_alan_kod||' '||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).gsm_no;
 end;

 Function fax_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 is
 begin
   return pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).fax_alan_kod||' '||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).fax_no;
 end;

 Function diger1_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 is
 begin
   return pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).diger1_tel_alan_kod||' '||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).diger1_tel_no;
 end;

 Function diger2_telefon(p_musteri_no gnl_musteri_adres.musteri_no%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return varchar2 is
 begin
   return pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).diger2_tel_alan_kod||' '||
          pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).diger2_tel_no;
 end;
 Birden fazla telefon tnimlandigi icin artik bu kisimlar calismaz MHA 151207 */
 FUNCTION adr_gecerlilik_bas_tar(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.gecerlilik_bas_tarihi%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).gecerlilik_bas_tarihi;
 END;

 FUNCTION adr_gecerlilik_bit_tar(p_musteri_no gnl_musteri_adres.musteri_no%TYPE, p_adres_kod gnl_musteri_adres.adres_kod%TYPE) RETURN gnl_musteri_adres.gecerlilik_bit_tarihi%TYPE IS
 BEGIN
   RETURN pkg_tablo.musteri_adres_kayit(p_musteri_no,p_adres_kod).gecerlilik_bit_tarihi;
 END;
---------------- Prosedürler
  PROCEDURE  Musteri_Adres( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ,
    		 				   ps_adres 	   OUT GNL_MUSTERI_ADRES.adres%TYPE,
							     ps_semt 	     OUT GNL_MUSTERI_ADRES.semt%TYPE,
							     ps_il_kod  	 OUT GNL_MUSTERI_ADRES.il_kod%TYPE,
                   ps_ilce_kod   OUT gnl_musteri_adres.ilce_kod%TYPE,
							     pn_posta_kod  OUT GNL_MUSTERI_ADRES.posta_kod%TYPE,
							     ps_ulke_kod	 OUT GNL_MUSTERI_ADRES.ulke_kod%TYPE)
   IS

     CURSOR cur_ekstre_adres IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod,a.ilce_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
    CURSOR cur_musteri IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod,a.ilce_kod
          FROM GNL_MUSTERI_ADRES a, GNL_MUSTERI b
         WHERE a.musteri_no = b.musteri_no
           AND adres_kod = DECODE(b.musteri_tur_kod, 'G', 'E', 'I')
           AND a.musteri_no = pn_musteri_no;
/*           -- C iletisim adresi
    CURSOR cur_musteri_contact IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod
          FROM GNL_MUSTERI_ADRES a, GNL_MUSTERI b
         WHERE a.musteri_no = b.musteri_no
           AND adres_kod = 'C'
           AND a.musteri_no = pn_musteri_no;
           -- T tebligat adresi
    CURSOR cur_musteri_tebligat IS
        SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod
          FROM GNL_MUSTERI_ADRES a, GNL_MUSTERI b
         WHERE a.musteri_no = b.musteri_no
           AND adres_kod = 'T'
           AND a.musteri_no = pn_musteri_no; Böyle kodlar artik yok bizde MHA 070708*/
   CURSOR cur_musteri_adres IS
      SELECT adres, a.semt, a.il_kod, a.posta_kod, a.ulke_kod,a.ilce_kod
        FROM GNL_MUSTERI_ADRES a
       WHERE a.musteri_no = pn_musteri_no;

  BEGIN
    IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;
    OPEN cur_ekstre_adres;
   	 LOOP
 	    	FETCH cur_ekstre_adres INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod, ps_ilce_kod;
 	      EXIT WHEN cur_ekstre_adres%NOTFOUND;
    END LOOP;
 	  CLOSE cur_ekstre_adres;
   --
     IF ps_adres IS NULL  THEN
        IF cur_musteri%isopen THEN
          CLOSE cur_musteri;
        END IF;
        OPEN cur_musteri;
         LOOP
           FETCH cur_musteri INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod, ps_ilce_kod;
           EXIT WHEN cur_musteri%NOTFOUND;
         END LOOP;
         CLOSE cur_musteri;
     END IF;
--
/*     IF ps_adres IS NULL  THEN
         IF cur_musteri_contact%isopen THEN
           CLOSE cur_musteri_contact;
         END IF;
         OPEN cur_musteri_contact;
         LOOP
            FETCH cur_musteri_contact INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod;
            EXIT WHEN cur_musteri_contact%NOTFOUND;
         END LOOP;
         CLOSE cur_musteri_contact;
      END IF;
--
     IF ps_adres IS NULL  THEN
         IF cur_musteri_tebligat%isopen THEN
           CLOSE cur_musteri_tebligat;
         END IF;
         OPEN cur_musteri_tebligat;
         LOOP
            FETCH cur_musteri_tebligat INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod;
            EXIT WHEN cur_musteri_tebligat%NOTFOUND;
         END LOOP;
         CLOSE cur_musteri_tebligat;
      END IF;*/
     IF ps_adres IS NULL  THEN
         IF cur_musteri_adres%isopen THEN
           CLOSE cur_musteri_adres;
         END IF;
         OPEN cur_musteri_adres;
         LOOP
            FETCH cur_musteri_adres INTO 	ps_adres 	, ps_semt, ps_il_kod, pn_posta_kod, ps_ulke_kod, ps_ilce_kod;
            EXIT WHEN cur_musteri_adres%NOTFOUND;
         END LOOP;
         CLOSE cur_musteri_adres;
     END IF; /* hicbirsey bulamamissak buldugumuz herhangi bibr adresini alalim MHA 070708 */

	  IF  ps_adres     IS NULL  THEN  ps_adres := ' ';   END IF;
	  IF  ps_semt      IS NULL  THEN  ps_semt := ' ';    END IF;
 	  IF  ps_il_kod    IS NULL  THEN  ps_il_kod := ' ';  END IF;
 	  IF  pn_posta_kod IS NULL  THEN  pn_posta_kod := 0; END IF;
   	IF  ps_ulke_kod  IS NULL  THEN  ps_ulke_kod:= ' '; END IF;
    IF  ps_ilce_kod  IS NULL  THEN  ps_ilce_kod:= ' '; END IF;
  EXCEPTION
	  WHEN OTHERS THEN
        Pkg_hata.hata_yaz(421,TRUE,pn_musteri_no);
  END;
-------------------------

  FUNCTION  musteri_urun_sinif_al(ps_modul_tur_kod   GNL_MUSTERI.modul_tur_kod%TYPE,
 		   						                   ps_urun_tur_kod    GNL_MUSTERI.urun_tur_kod%TYPE,
									                   ps_sinif_param_kod VARCHAR2 DEFAULT NULL ) RETURN GNL_MUSTERI.urun_sinif_kod%TYPE
  IS
     ls_kod GNL_MODUL_URUN_SINIF_KOD_PR.kod%TYPE ;
   BEGIN

	  SELECT DISTINCT U.kod
	  INTO   ls_kod FROM  GNL_MODUL_URUN_SINIF_KOD_PR U
	  WHERE  U.MODUL_TUR_KOD = ps_modul_tur_kod AND
	  		   U.URUN_TUR_KOD = ps_urun_tur_kod ;

	  RETURN ls_kod;

	EXCEPTION
	  WHEN OTHERS THEN
	    PKG_HATA.hata_yaz(445,TRUE,SQLERRM);
   END musteri_urun_sinif_al;
 /***********************************************************/
  FUNCTION tcno_kontrol(pn_tc_kimlik_no NUMBER) RETURN BOOLEAN IS
	  TYPE d_arr IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
      tmp1 NUMBER(11);
      tmp NUMBER(11);
      odd_sum		   NUMBER;
      even_sum 	   NUMBER;
      total		   NUMBER;
      chkdigit1	   NUMBER;
      chkdigit2	   NUMBER;
      d			   d_Arr;
  BEGIN

	 IF LENGTH(TO_CHAR(pn_tc_kimlik_no)) <> 11  OR pn_tc_kimlik_no IS NULL THEN
	 	RETURN FALSE;
	 END IF;

	 IF pn_tc_kimlik_no  >0 THEN
	  	tmp  := FLOOR(pn_tc_kimlik_no /100);
		tmp1 := FLOOR(pn_tc_kimlik_no /100);
		FOR n IN REVERSE 1..9 LOOP
			d(n) :=tmp1 MOD 10;
			tmp1 :=FLOOR(tmp1/10);
		END LOOP;
		odd_sum  	:= d(9) + d(7) + d(5) +d(3) + d(1);
		even_sum 	:= d(8) + d(6) + d(4) + d(2);
		total 	    := odd_sum * 3 + even_sum ;
		chkdigit1   := (10-(total MOD 10)) MOD 10;
		odd_sum    	:= chkdigit1 + d(8) +d(6) + d(4) +d(2);
		even_sum   	:=  d(9) + d(7) + d(5) + d(3) + d(1);
		total 	   	:= odd_sum *3 +even_sum ;
		chkdigit2 	:= (10 -(total MOD 10 )) MOD 10;
		tmp 	   	:= tmp * 100 + chkdigit1 *10 +chkdigit2;

		IF tmp <> pn_tc_kimlik_no  THEN
		   RETURN FALSE;
		END IF;
		RETURN TRUE;
	 ELSE
			RETURN FALSE;
	 END IF;
 END tcno_kontrol;
/**********************************************************************************/
 FUNCTION Is_Number(ps_str VARCHAR2) RETURN VARCHAR2 IS
   ln_len NUMBER;
   ln_ret NUMBER := 1;
    LS_UYGUN VARCHAR2(1) := 'E';
 BEGIN
  ln_len := LENGTH(ps_str);
  FOR i IN 1..ln_len LOOP
     IF SUBSTR(ps_str,i,1) NOT IN ('0', '1','2', '3', '4', '5', '6', '7', '8', '9') THEN
	     ls_uygun := 'H';
	     EXIT;
	   END IF;
  END LOOP;

  RETURN ls_uygun;

 EXCEPTION WHEN OTHERS THEN RETURN 'H';
 END;
/**********************************************************************************/
  FUNCTION nufus_cuzdani_serino_gecerlimi(ps_seri_no VARCHAR2,ps_cinsiyet_kod VARCHAR2,ps_hata_mesaj_kod OUT VARCHAR2) RETURN VARCHAR2 IS
  	ls_uygun VARCHAR2(1) := 'E';
  BEGIN

  	IF  LENGTH(TRIM(ps_seri_no )) NOT IN (9,10) THEN
		 	 ps_hata_mesaj_kod := '458';
			 ls_uygun := 'H';
			 RETURN  ls_uygun;
		END IF;

		IF ps_cinsiyet_kod = 'K' THEN
			IF	MOD(SUBSTR(ps_seri_no,3,1),2) <> 0 THEN  -- cift sayi olmali
	 	 	   ps_hata_mesaj_kod := '459';
			   ls_uygun := 'H';
			   RETURN  ls_uygun;
			 END IF;
		ELSIF ps_cinsiyet_kod  = 'E' THEN
			IF	MOD(SUBSTR(ps_seri_no,3,1),2) = 0 THEN  -- tek sayi olmali
	 	 	   ps_hata_mesaj_kod := '460';
			   ls_uygun := 'H';
			END IF;
		END IF;

		IF  Pkg_Musteri.Is_Number(SUBSTR(ps_seri_no ,1,1)) = 'E'  THEN
		 	 ps_hata_mesaj_kod := '461';
			 ls_uygun := 'H';
			 RETURN  ls_uygun;
		END IF;

    IF  Pkg_Musteri.Is_Number(SUBSTR(ps_seri_no ,4)) = 'H'  THEN
		 	 ps_hata_mesaj_kod := '462';
			 ls_uygun := 'H';
			 RETURN  ls_uygun;
		END IF;

	RETURN ls_uygun;
	EXCEPTION WHEN OTHERS THEN
    ps_hata_mesaj_kod := 506;
    RETURN 'H';

  END nufus_cuzdani_serino_gecerlimi;
/**********************************************************************************/
  FUNCTION personel_musterino_al(ps_personel_numara muh_personel.personel_numara%TYPE) RETURN gnl_musteri.musteri_no%TYPE IS
   	ln_musteri_no gnl_MUSTERI.musteri_no%TYPE;
  BEGIN
 	IF ps_personel_numara IS NOT NULL THEN
     SELECT musteri_no
        INTO ln_musteri_no
        FROM muh_personel
      WHERE personel_numara = ps_personel_numara ;
  END IF;
	  RETURN ln_musteri_no;

	EXCEPTION
	 WHEN NO_DATA_FOUND THEN RETURN 0 ;
	 WHEN OTHERS THEN
	    Pkg_Hata.hata_yaz(463,TRUE, TO_CHAR(SQLCODE)|| ' ' || SQLERRM);
  END personel_musterino_al;
/**********************************************************************************/
  FUNCTION personel_musterikurum_al(ps_personel_numara muh_personel.personel_numara%TYPE) RETURN muh_personel.kurum_kodu%TYPE IS
   	ls_kurum_kodu muh_personel.kurum_kodu%TYPE;
  BEGIN
   IF ps_personel_numara IS NOT NULL THEN
      SELECT kurum_kodu
        INTO ls_kurum_kodu
        FROM muh_personel
       WHERE personel_numara = ps_personel_numara ;
   END IF;

	  RETURN ls_kurum_kodu;

	EXCEPTION
	 WHEN NO_DATA_FOUND THEN RETURN NULL;
	 WHEN OTHERS THEN
	    Pkg_Hata.hata_yaz(463,TRUE, TO_CHAR(SQLCODE)|| ' ' || SQLERRM);
  END personel_musterikurum_al;
/**********************************************************************************/
 PROCEDURE personel_musterino_guncelle(pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ,pn_sicil_no GNL_MUSTERI.personel_sicil_no%TYPE) IS
   	ln_musteri_no 		  GNL_MUSTERI.musteri_no%TYPE;
 BEGIN
		  UPDATE MUH_PERSONEL
    		 SET musteri_no = pn_musteri_no
		  WHERE personel_numara = pn_sicil_no;
 EXCEPTION
	  WHEN OTHERS THEN NULL ;
 END personel_musterino_guncelle;
/**********************************************************************************/
  FUNCTION Musteri_Mevcutmu (ps_full_isim       IN  VARCHAR2 ,
                             ps_musteri_tur     IN  VARCHAR2,
                             ps_yerlesim_kod    IN  VARCHAR2,
                             ps_baba_adi        IN  Gnl_Musteri_Kimlik.Baba_Adi%TYPE ,
                             pd_dogum_tarihi    IN  Gnl_Musteri_Kimlik.Dogum_Tarihi%TYPE ,
                             ps_dogum_yeri      IN  Gnl_Musteri_Kimlik.Dogum_Yeri%TYPE ,
                             ps_tc_kimlik_no    IN  Gnl_Musteri.Tc_Kimlik_No%TYPE ,
                             ps_ticari_sicil_no IN  GNl_Musteri.Ticari_Sicil_No%TYPE,
                             ps_vergi_no        IN  Gnl_Musteri.Vergi_No%TYPE,
                             pn_exmusteri_no    IN  Gnl_Musteri.Musteri_No%TYPE DEFAULT 0,
                             pn_musteri_no      OUT Gnl_Musteri.Musteri_No%TYPE) RETURN VARCHAR2 IS

  	ln_musteri_no Gnl_Musteri.Musteri_No%TYPE ;
/* cursor for  yurtici bireysel musteriler */
/* tc kimlik no zorunlu arama kriteridir. */
    wmevcut_eh  VARCHAR2(1);

	CURSOR cur_musteri_yurtici_bireysel1 IS
	  SELECT musteri_no
		  FROM Gnl_Musteri
		 WHERE (vergi_no = ps_vergi_no OR
			       tc_kimlik_no = ps_tc_kimlik_no)
   		 AND durum_kodu = 'A'
			 AND musteri_no <> pn_exmusteri_no ;

	CURSOR cur_musteri_yurtici_bireysel2 IS
	  SELECT musteri_no
		  FROM Gnl_Musteri G
		 WHERE arama_isim = Pkg_Genel_Pr.turkce_char_sil(ps_full_isim)
       AND NVL(Pkg_Genel_Pr.turkce_char_sil(Pkg_Musteri.baba_adi(G.musteri_no)),' ') = NVL(Pkg_Genel_Pr.turkce_char_sil(ps_baba_adi),' ')
       AND TRUNC(Pkg_Musteri.dogum_tarihi(G.musteri_no)) = TRUNC(pd_dogum_tarihi)
       AND NVL(Pkg_Genel_Pr.turkce_char_sil(Pkg_Musteri.dogum_yeri(G.musteri_no)),' ')= NVL(Pkg_Genel_Pr.turkce_char_sil(ps_dogum_yeri),' ')
   		 AND durum_kodu = 'A'
			 AND musteri_no <> pn_exmusteri_no ;

/* cursor for  yurt disi bireysel musteriler */
/* tc kimlik no aranmayacaktir */
	CURSOR cur_musteri_yurtdisi_bireysel IS
	  SELECT musteri_no
		  FROM Gnl_Musteri G
		 WHERE arama_isim = Pkg_Genel_Pr.turkce_char_sil(ps_full_isim)
       AND NVL(Pkg_Genel_Pr.turkce_char_sil(Pkg_Musteri.baba_adi(G.musteri_no)),' ') = NVL(Pkg_Genel_Pr.turkce_char_sil(ps_baba_adi),' ')
       AND TRUNC(Pkg_Musteri.dogum_tarihi(G.musteri_no)) = TRUNC(pd_dogum_tarihi)
       AND NVL(Pkg_Genel_Pr.turkce_char_sil(Pkg_Musteri.dogum_yeri(G.musteri_no)),' ')= NVL(Pkg_Genel_Pr.turkce_char_sil(ps_dogum_yeri),' ')
			 AND durum_kodu = 'A'
			 AND vergi_no = ps_vergi_no
	   	 AND musteri_no <> pn_exmusteri_no ;

/* cursor for  yurt ici kurumsal ve ticari musteriler -1*/
	CURSOR cur_musteri_yurtici_kurumsal1 IS
    SELECT musteri_no
		  FROM Gnl_Musteri
		 WHERE (ticari_sicil_no = ps_ticari_sicil_no OR
			       vergi_no =ps_vergi_no)
   		 AND durum_kodu = 'A'
		   AND musteri_no <> pn_exmusteri_no ;

/* cursor for  (yurt disi kurumsal ve ticari ) musteriler */
	CURSOR cur_musteri_yurtdisi_kurumsal IS
	  SELECT musteri_no
   		FROM Gnl_Musteri
		 WHERE (arama_isim = Pkg_Genel_Pr.turkce_char_sil(ps_full_isim) OR
			       vergi_no =ps_vergi_no )
			 AND durum_kodu = 'A'
			 AND musteri_no <> pn_exmusteri_no ;

/* cursor for ve yurt ici yurt disi tum banka  musteriler */
	CURSOR cur_musteri_banka IS
	  SELECT musteri_no
		  FROM Gnl_Musteri
		 WHERE (arama_isim = Pkg_Genel_Pr.turkce_char_sil(ps_full_isim) OR
			  	   vergi_no =ps_vergi_no)
			 AND durum_kodu = 'A'
	   	 AND musteri_no <> pn_exmusteri_no;

BEGIN
  IF ps_musteri_tur  = 'G' THEN --bireysel
    IF ps_yerlesim_kod = 'I'  THEN  --yurtici
     /* cursor for  yurt ici bireysel musteriler 1*/
         OPEN cur_musteri_yurtici_bireysel1;
         FETCH cur_musteri_yurtici_bireysel1 INTO pn_musteri_no;
         CLOSE cur_musteri_yurtici_bireysel1;

      IF NVL(pn_musteri_no,0 ) = 0 THEN
           /* cursor for  yurt ici bireysel musteriler 1*/
              OPEN cur_musteri_yurtici_bireysel2;
              FETCH cur_musteri_yurtici_bireysel2 INTO pn_musteri_no;
              CLOSE cur_musteri_yurtici_bireysel2;
      END IF;
    ELSE
    /* cursor for  yurt disi bireysel musteriler */
         OPEN cur_musteri_yurtdisi_bireysel;
         FETCH cur_musteri_yurtdisi_bireysel INTO pn_musteri_no;
         CLOSE cur_musteri_yurtdisi_bireysel;
         IF NVL(pn_musteri_no,0 ) <> 0 THEN
               wmevcut_eh := 'E';
         END IF;
    END IF;
  ELSE
    IF ps_musteri_tur  IN ('T','K') THEN -- kurumsal - ticari ise
      IF ps_yerlesim_kod = 'I'  THEN  --yurtici
            OPEN cur_musteri_yurtici_kurumsal1;
            FETCH cur_musteri_yurtici_kurumsal1 INTO pn_musteri_no;
            CLOSE cur_musteri_yurtici_kurumsal1;
      ELSE
            OPEN cur_musteri_yurtdisi_kurumsal;
            FETCH cur_musteri_yurtdisi_kurumsal INTO pn_musteri_no;
            CLOSE cur_musteri_yurtdisi_kurumsal;
      END IF;
    ELSIF ps_musteri_tur  IN ('B') THEN -- banka musterileri
          OPEN cur_musteri_banka;
          FETCH cur_musteri_banka INTO pn_musteri_no;
          CLOSE cur_musteri_banka;
    END IF;
  END IF;
  IF NVL(pn_musteri_no,0 ) <> 0 THEN
     wmevcut_eh := 'E';
  ELSE
     wmevcut_eh := 'H';
  END IF;

   RETURN wmevcut_eh;

 END Musteri_Mevcutmu;
/*********************************************************************************/

  FUNCTION Personel_mi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
  IS
     ls_personel VARCHAR2(1) := 'H';
   BEGIN

    IF pn_musteri_no IS NULL THEN
       RETURN ls_personel;
    END IF;

	  SELECT DECODE(musteri_tur_kod,'G', decode(NVL (musteri_stat1, '1'), '2', 'E', 'H'),'H')
	  INTO  ls_personel
	  FROM   GNL_MUSTERI
	  WHERE musteri_no = pn_musteri_no ;

	  RETURN ls_personel;

	EXCEPTION
	  WHEN OTHERS THEN
	    pkg_hata.hata_yaz(496,TRUE,SQLERRM);
   END Personel_mi;

/*********************************************************************************/

   FUNCTION	 Musterinin_Hesabi_Varmi(pn_musteri_no GNL_MUSTERI.musteri_no%TYPE ) RETURN VARCHAR2
   IS
     ln_adet NUMBER := 0;
   BEGIN

	  SELECT COUNT(*)
	  INTO  ln_adet
	  FROM  v_muh_hesap_tum
	  WHERE musteri_no = pn_musteri_no;

    IF NVL(ln_adet,0)>0 THEN
      RETURN 'E';
    ELSE
      RETURN 'H';
    END IF;

   END Musterinin_Hesabi_Varmi;
/*********************************************************************************/
  FUNCTION Musteri_guncel_Kaydi_Olus( pn_musteri_no NUMBER ,ps_durum VARCHAR2 DEFAULT 'A',pn_tx_no NUMBER DEFAULT NULL ) RETURN NUMBER IS
       ln_tutar           muh_islem.tutar%TYPE;
       ls_doviz_kod       muh_islem.doviz_kod%TYPE;
       ls_durum_kodu      gnl_musteri.durum_kodu%TYPE;
       ls_musteri_tur_kod gnl_musteri.musteri_tur_kod%TYPE;
       vn_tx_no           NUMBER;
       ln_tx_no           NUMBER;
       wextreadreskod     gnl_musteri_adres.adres_kod%TYPE;
       wkurumkodu         muh_personel.kurum_kodu%TYPE;
       wkapat             VARCHAR2(500);
       wortaktur          gnl_musteri_ortaklik.ortaklik_turu%TYPE;
    CURSOR c_ortak IS
      SELECT *
        FROM gnl_musteri_ortaklik o
       WHERE o.musteri_no=pn_musteri_no;

     r_ortak  c_ortak%ROWTYPE;
     m_k VARCHAR2(1);
     K NUMBER;
     wsontxno NUMBER;
  BEGIN
-- Musteri durum kodu guncellenmeden fakli ise islem kaydi olusturulur.

    SELECT durum_kodu , musteri_tur_kod, musteri_kontakt
      INTO ls_durum_kodu ,ls_musteri_tur_kod,m_k
      FROM gnl_musteri
     WHERE musteri_no = pn_musteri_no ;

    IF ps_durum = 'K' THEN
       wkapat := Musteri_kapatilabilirmi(pn_musteri_no);
    END IF;

   IF pn_tx_no IS NULL THEN
      vn_tx_no  := Pkg_Tx.islem_no_al;
   ELSE
      vn_tx_no  := pn_tx_no;
   END IF;

    IF ls_musteri_tur_kod = 'G' THEN
       ln_tx_no := Pkg_TRN10011.Onay_Bekleyen_Varmi(vn_tx_no,pn_musteri_no,10041);
       IF m_k = 'K' THEN
          Pkg_TRN10011.kontakt_onay_kontrol(pn_kontakt_no => pn_musteri_no); /* kontakt to customer trn. awaitng approval check */
       END IF;
    ELSIF ls_musteri_tur_kod = 'T' THEN
       ln_tx_no := Pkg_TRN10011.Onay_Bekleyen_Varmi(vn_tx_no,pn_musteri_no,10042);
       IF m_k = 'K' THEN
          Pkg_TRN10011.kontakt_onay_kontrol(pn_kontakt_no => pn_musteri_no); /* kontakt to customer trn. awaitng approval check */
       END IF;
    ELSIF ls_musteri_tur_kod IN ('A','B','F') THEN
       ln_tx_no := Pkg_TRN10011.Onay_Bekleyen_Varmi(vn_tx_no,pn_musteri_no,10043);
    ELSE
       ln_tx_no := Pkg_TRN10011.Onay_Bekleyen_Varmi(vn_tx_no,pn_musteri_no,10044);
    END IF;
   IF ls_musteri_tur_kod != 'O' THEN
       wsontxno := pkg_trn10041.son_txno_bul(pn_musteri_no);
      --3.Basvuru musteri bilgilerinin musteri tablosuna aktarilmasi */
        INSERT INTO GNL_MUSTERI_BASVURU_TX(
        tx_no ,musteri_no, musteri_tipi_kod ,musteri_kontakt,musteri_stat1,MUSTERI_STAT2,MUSTERI_STAT3,
        ilk_iliski_tarihi,musteri_segmenti,musteri_temsilcisi, musteri_kazandiran,dk_grup_kod , isim,
        ikinci_isim , soyadi ,kisa_ad, dogum_tarihi , dogum_yeri , dogum_il_kod,
        cinsiyet_kod , baba_adi , anne_adi , anne_kizlik_soyadi , meslek_kod,
        egitim_kod , medeni_hal_kod , ticari_unvan , hesap_ucreti_f , cek_karnesi_f,
        personel_sicil_no, yerlesim_kod, vergi_no , uyruk_kod ,  tc_kimlik_no,
        nufus_cuzdani_seri_no , pasaport_no , ehliyet_belge_no , il_kod , ilce_kod,
        mahalle_koy , cilt_no , aile_sira_no , sira_no , verildigi_yer,
        verildigi_tarih ,nuf_verilis_nedeni,f_nuf,f_ehliyet,f_pasaport,f_ikametgah,
        ehl_verildigi_yer,ehl_verildigi_tarih,pas_verildigi_yer,pas_verildigi_tarih,
        ikametgah_belge_no,ikm_verildigi_yer,ikm_verildigi_tarih,
        sektor_kod , ticari_sicil_no ,
        bic_kod , swift_mesaj_kod , reuters_info_page , reuters_dealing_kod ,
        modul_tur_kod, urun_tur_kod, urun_sinif_kod,
        sektor_alt1_kodu,sektor_alt2_kodu,durum_kodu,
        vergi_il_kodu,vergi_daire_kodu,
        ticari_sicil_daire_kodu, ticari_sicil_kayit_tarihi,DOGUM_ILCE_KOD,KIZLIK_SOYADI,
           vergi_kayit_unvani  ,email_is,email_kisisel,web_adres,bolum_kodu,rating_kodu,
         rating_quarter,rating_year,resit_mi,kisitli_mi,yurtdisi_belge_adi,yurtdisi_belge_tarihi,mukimlik_no,kontakt_no,
        bagli_kanal_kod,bagli_kanal_grup,calisma_sekli,isyeri_adi,mkk_sicilno,yatirim_extresi_gonderilsinmi,yerlesik_ulke_kod,
        Uye_Kodu,EFT_KODU,DAIMI_TEMSILCILIK_VARMI,TICARET_SANAYI_ODASI,Grup_Kod,Unvani,/*Musteri_Grup_Kod,*/Unvan_Kod,
        Adk_Musterisimi,Orijinal_Evraklimi,TELEFON_TEYIT,EPOSTA_TEYIT,TCKNO_IN,Tckno_Out,Son_Txno,f_Istege_Bagli_Sigortali,Ulasim_Kart_No,
        kazanim_kanali,kazanim_urunu,F_SAHTE,ACK_SAHTE,f_Musteriye_Cevrilebilir,/*musteri_grup_detay_kod,*/f_Musteri_Bloke,
        ykps_uyruk_kod, ikm_suresi,olum_tarihi, Iletisim_Dili, Platform_Grubu, Platform_Kodu,EXTRE_EMAIL_TIP,oto_Musteri,Portfoy_Kod,f_Nitelikli,
        DOGUM_ULKE_KOD,F_GREEN_CARD,F_CIFTE_VATANDASLIK,Ikm_Bitis_Tarihi,Email_Kep,MERSISNO,Engelli_Tipi,Engelli_Yuzdesi,Engelli_Durumu,Engelli_Gecerlilik_Suresi,
        F_MAVIKART,MK_SERI_NO,MK_VERILIS_NEDENI,MK_VERILDIGI_TARIH,MK_YENI_UYRUK_KOD,F_CRS,CRS_KATEGORI,NACE_KODU,Is_Eposta_Teyit,KUTUK_NUMARASI
        )
      SELECT
         vn_tx_no , G.musteri_no, musteri_tur_kod , G.musteri_kontakt,G.musteri_stat1,G.musteri_stat2,G.musteri_stat3,
         G.ilk_iliski_tarihi,G.musteri_segmenti,G.musteri_temsilcisi,G.musteri_kazandiran,
         dk_grup_kod , G.adi,
        ikinci_adi , soyadi , G.kisa_ad,dogum_tarihi , dogum_yeri , dogum_il_kod,
        cinsiyet_kod , baba_adi , anne_adi , anne_kizlik_soyadi , meslek_kod,
        egitim_kod , medeni_hal_kod , ticari_unvan , G.hesap_ucreti_alinsinmi , G.cek_karnesi_varmi,
        personel_sicil_no ,G.yurt_ici_disi, vergi_no , uyruk_kod ,
        tc_kimlik_no,
        K.nuf_seri_no , pasaport_no , ehliyet_belge_no , K.nuf_il_kod , K.nuf_ilce_kod,
        K.nuf_mahalle_koy , K.nuf_cilt_no , K.nuf_aile_sira_no , K.nuf_sira_no ,
        K.nuf_verildigi_yer,K.nuf_verildigi_tarih,
        K.nuf_verilis_nedeni,NVL(K.f_nuf,'H'),NVL(K.f_ehliyet,'H'),NVL(K.f_pasaport,'H'),NVL(K.f_ikametgah,'H'),
        K.ehl_verildigi_yer,K.ehl_verildigi_tarih,K.pas_verildigi_yer,K.pas_verildigi_tarih,
        K.ikametgah_belge_no,K.ikm_verildigi_yer,K.ikm_verildigi_tarih,
        sektor_kod , ticari_sicil_no ,
        bic_kod , swift_mesaj_kod , reuters_info_page , reuters_dealing_kod,
        modul_tur_kod, urun_tur_kod, urun_sinif_kod  ,
        sektor_kod1,sektor_kod2,G.durum_kodu, --NVL(ps_durum,'A'),
        vergi_il_kodu,vergi_daire_kodu,
        ticari_sicil_daire_kodu, ticari_sicil_kayit_tarihi,
        dogum_ilce_kod,kizlik_soyadi,
        vergi_kayit_unvani,G.email_is,G.email_kisisel,G.web_adres,
        /*Pkg_Musteri.personel_musterikurum_al(g.personel_sicil_no),*/G.sube_kodu,
        rating_kodu,rating_quarter,rating_year,NVL(K.resit_mi,'H'),NVL(K.kisitli_mi,'H'),
        G.yurtdisi_belge_adi,G.yurtdisi_belge_tarihi,G.mukimlik_no,G.musteri_no,
        G.bagli_kanal_kod,G.bagli_kanal_grup,
        G.calisma_sekli,G.isyeri_adi,G.mkk_sicilno,NVL(G.yatirim_extresi_gonderilsinmi,'H'),G.yerlesik_ulke_kod,
        Uye_Kodu,EFT_KODU,DAIMI_TEMSILCILIK_VARMI,TICARET_SANAYI_ODASI,G.grup_kod,G.unvani,/*g.musteri_grup_kod,*/G.unvan_kod,
        G.adk_musterisimi,G.orijinal_evraklimi,G.telefon_teyit,G.eposta_teyit,G.tc_kimlik_no,
        DECODE(K.kps_check,'E',G.tc_kimlik_no,NULL),wsontxno,NVL(G.f_istege_bagli_sigortali,'H'),G.ulasim_kart_no,
        kazanim_kanali,kazanim_urunu,F_SAHTE,ACK_SAHTE,f_Musteriye_Cevrilebilir,/*g.musteri_grup_detay_kod,*/G.f_musteri_bloke,
        DECODE(G.uyruk_kod,'TR',NULL,(SELECT ykps_kod FROM gnl_ulke_kod_pr WHERE kod = G.uyruk_kod)), K.ikm_suresi,
        K.olum_tarihi , Iletisim_Dili, Platform_Grubu, Platform_Kodu,EXTRE_EMAIL_TIP,NVL(oto_Musteri,'H'),Portfoy_Kod,G.f_nitelikli,
        K.DOGUM_ULKE_KOD,K.F_GREEN_CARD,K.F_CIFTE_VATANDASLIK,K.ikm_bitis_tarihi, g.email_kep,g.mersisno, g.engelli_tipi,g.engelli_yuzdesi,g.engelli_durumu,g.engelli_gecerlilik_suresi,
        k.F_MAVIKART,k.MK_SERI_NO,k.MK_VERILIS_NEDENI,k.MK_VERILDIGI_TARIH,k.MK_YENI_UYRUK_KOD,g.f_crs,g.crs_kategori,g.nace_kodu,g.is_eposta_teyit,g.kutuk_numarasi
      FROM   gnl_musteri G,gnl_musteri_kimlik K
      WHERE G.musteri_no =pn_musteri_no
        AND K.musteri_no(+) = G.musteri_no;

    /* Basvuru adres bilgilerinin musteri adres tablosuna aktarilmasi */
      INSERT INTO gnl_musteri_basvuru_adres_tx
       (  tx_no , adres_kod , adres , semt , il_kod
       , posta_kod , ulke_kod , ilk_gecerlilik_tarihi
       , son_gecerlilik_tarihi , ilce_kod  ,
         extre_adres_kod_f, ISYERI_UNVANI ,Upd_date , adres_teyit
        )
      SELECT
         vn_tx_no , adres_kod , adres , semt , il_kod
       , posta_kod , ulke_kod ,  a.gecerlilik_bas_tarihi,
        a.gecerlilik_bit_tarihi , ilce_kod ,
         extre_adresi_mi,  ISYERI_UNVANI, NVL(a.upd_date,TRUNC(a.rec_date)),NVL(adres_teyit,'H')

      FROM gnl_musteri_adres a
      WHERE musteri_no =pn_musteri_no ;

     INSERT INTO Gnl_Musteri_Basvuru_Telefon_Tx
                (Tx_No,Sira_No,Tel_Tip,Alan_Kod,Tel_No,Dahili_No,Bagli_Adres_Kod,Iletisim_Mi,ulke_kod,Upd_date,Telefon_Teyit,Otp_Mi)
      SELECT  vn_tx_no,Sira_No,Tel_Tip,Alan_Kod,Tel_No,Dahili_No,Bagli_Adres_Kod,Iletisim_Mi,ULKE_KOD,NVL(upd_date,TRUNC(rec_date)),NVL(Telefon_Teyit,'H'),Otp_Mi
        FROM Gnl_Musteri_Telefon
       WHERE musteri_no =pn_musteri_no ;

     INSERT INTO Gnl_Musteri_grup_Tx(Tx_No,musteri_no,Musteri_Grup_Kod,Musteri_Grup_Detay_Kod)
      SELECT  vn_tx_no,musteri_no,Musteri_Grup_Kod,Musteri_Grup_Detay_Kod
        FROM Gnl_Musteri_grup
       WHERE musteri_no =pn_musteri_no ;


     /* veli vasi bilgilerini de gomelim */
      INSERT INTO Gnl_Musteri_Velivasi_Bsv_Tx
      (Tx_No,Sira_No,Veli_Vasi_Tur,Veli_Uyruk_Kod,Veli_Isim,
       Veli_Ikinci_Isim,Veli_Soyadi,Veli_Tc_Kimlik_No,Veli_Vergi_No,Veli_Musteri_No,Unvan,bas_Tarih,bit_tarih)
      SELECT vn_tx_no,Sira_No,Veli_Vasi_Tur,Veli_Uyruk_Kod,Veli_Isim,
       Veli_Ikinci_Isim,Veli_Soyadi,Veli_Tc_Kimlik_No,Veli_Vergi_No,Veli_Musteri_No,G.unvan,g.bas_tarih,g.bit_tarih
        FROM Gnl_Musteri_Velivasi G
       WHERE G.musteri_no = pn_musteri_no;


    /* Basvuru dokuman bilgilerinin musteri dokuman tablosuna aktarilmasi */

/*      INSERT INTO GNL_MUSTERI_BSVR_DOKUMAN_TX (
        tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
      , gecerlilik_tarihi,sureli_mi,Aciklama)
      SELECT
        pn_tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
        , gecerlilik_tarihi,sureli_mi,aciklama
      FROM  Gnl_Musteri_Dokuman d,v_ml_gnl_dokuman_grup_pr p,gnl_musteri g
      WHERE d.musteri_no = pn_musteri_no
        and g.musteri_no = pn_musteri_no
        and p.GRUP_KOD   = g.dk_grup_kod
        and p.DOKUMAN_KOD= d.dokuman_adi; */

      INSERT INTO GNL_MUSTERI_BSVR_DOKUMAN_TX (
        tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
      , gecerlilik_tarihi,sureli_mi,Aciklama,ALINMA_TARIHI,ALAN_KULLANICI)
      SELECT
        vn_tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
        , gecerlilik_tarihi,sureli_mi,P.aciklama,ALINMA_TARIHI,ALAN_KULLANICI
      FROM  Gnl_Musteri_Dokuman d,v_ml_gnl_dokuman_kod_pr P
      WHERE d.musteri_no = pn_musteri_no
      AND P.kod= d.dokuman_adi
      UNION ALL        -- nd. 16.06.2010 bt-1050
      SELECT vn_tx_no ,NVL((SELECT MAX(sira_no) FROM Gnl_Musteri_Dokuman d WHERE d.musteri_no = pn_musteri_no),0) + ROWNUM sira_no, T.DOKUMAN_KOD dokuman_adi, 'H' alindi_kutusu_f, NULL duzenlenme_tarihi ,
        NULL gecerlilik_tarihi,NULL sureli_mi, T.aciklama,null,null
      FROM v_ml_gnl_dokuman_grup_pr T
      WHERE T.musteri_tur_kod=  pkg_musteri.tur(pn_musteri_no)
      AND T.yurt_ici_disi= pkg_musteri.yurt_ici_disi(pn_musteri_no)
      AND T.dokuman_kod NOT IN(SELECT G.dokuman_adi
                               FROM gnl_musteri_dokuman G
                               WHERE G.musteri_no=pn_musteri_no ) ;




    /* Basvuru not bilgilerinin musteri not tablosuna aktarilmasi */
        INSERT INTO GNL_MUSTERI_BSVR_NOTLAR_TX(
        tx_no , sira_no , alinan_notlar , giris_tarihi , kullanici_kodu
      , gorusme_bilgileri , gorusme_notu , katilanlar , gorusme_tarihi , baslangic_saati
      , bitis_saati ,not_tipi,F_NOT_GORUNTULE )
      SELECT
        vn_tx_no , sira_no , alinan_notlar , giris_tarihi , kullanici_kodu,
        gorusme_bilgileri , gorusme_notu , katilanlar , gorusme_tarihi ,
       baslangic_saati, bitis_saati ,not_tipi,NVL(n.f_not_goruntule,'H')
      FROM  GNL_MUSTERI_NOTLAR n
      WHERE musteri_no =pn_musteri_no ;

    /* cifte vatandaşlık ülke bilgilerini alalım MHA 10062014 */
      INSERt INTO Gnl_Musteri_Bsvr_Ciftevtnds_Tx
                 (Tx_No,Ulke_Kod)
      SELECT  vn_tx_no,v.ulke_kod
         FRoM Gnl_Musteri_Ciftevtnds v           
        WHERE v.musteri_no=pn_musteri_no;
        
    /* CRS bilgileri */
    INSERT INTO Gnl_Musteri_Basvuru_Crs_Tx 
               (Tx_No,Ulke_Kod,Vergi_No)
    SELECT vn_tx_no,c.ulke_kod,c.vergi_no
      FROM gnl_musteri_crs c           
     WHERE c.musteri_no=pn_musteri_no; 
 
    /*Basvuru Adi ortaklik bilgilerinin musteri ortak tablosuna aktarilmasi */

      INSERT INTO GNL_MUSTERI_ADI_ORTAKLIK_TX(
        tx_no , sira_no , isim , orani , tutari
      , doviz_kod , tarih , ulke_kod,ORTAK_MUSTERI_NO )
      SELECT
        vn_tx_no , sira_no , isim , orani , tutari
      , doviz_kod , tarih , ulke_kod, ortak_musteri_no
      FROM Gnl_Musteri_Adi_Ortaklik
      WHERE musteri_no =pn_musteri_no ;

      INSERT INTO Gnl_Musteri_Ext_Rating_Tx
        (tx_no,ext_rating_no, musteri_no, durum_kodu,
        rating_kodu, agency_kodu, individual, outlook,
        lt_fx, rating_quarter, rating_year,
        limit_revizyon_periyod_tip, limit_revizyon_periyodu,
        islem_tarihi, yaratan_tx_no  )
      SELECT
        vn_tx_no ,ext_rating_no, NVL(musteri_no,pn_musteri_no),
        NVL(durum_kodu,'A'),
        rating_kodu, agency_kodu,
        individual, outlook,
        lt_fx, rating_quarter, rating_year,
        limit_revizyon_periyod_tip, limit_revizyon_periyodu,
        NVL(islem_tarihi,Pkg_Muhasebe.banka_tarihi_bul),
        NVL(yaratan_tx_no,vn_tx_no)
      FROM GNL_MUSTERI_EXT_RATING
      WHERE musteri_no =pn_musteri_no AND
          agency_kodu IS NOT NULL;

       INSERT INTO Gnl_Firmadetay_Bilgi_Tx
                  (Tx_No,Faaliyet_Yeri,Son_5yillik_Hakedis,Devam_Eden_Isler,
                   Sermaye_Yapisi,Halka_Arz_Orani,Calisan_Personel_Sayisi,Firma_Tipi,Isyeri_Ssk_No,Risk_Santno,Kurulus_Tarihi,
                   Kredi_Iliski_Tarihi,Mali_Donem_Bitis_Ayi,Sektore_Giris_Yili,Pazar_Payi,Sendikali_Mi,Sendika_Adi,Sermaye,
                   Takasbank_No,f_Us_Firma,Sandik_Kurulus_Sekli,f_Kurumlar_Vergisi)
       SELECT vn_tx_no, Faaliyet_Yeri,Son_5yillik_Hakedis,Devam_Eden_Isler,
              Sermaye_Yapisi,Halka_Arz_Orani,Calisan_Personel_Sayisi,Firma_Tipi,Isyeri_Ssk_No,
              Risk_Santno,Kurulus_Tarihi,Kredi_Iliski_Tarihi,Mali_Donem_Bitis_Ayi,Sektore_Giris_Yili,
              Pazar_Payi,NVL(Sendikali_Mi,'H'),Sendika_Adi,Sermaye,takasbank_no,f_Us_Firma,Sandik_Kurulus_Sekli,f_Kurumlar_Vergisi
         FROM Gnl_Firmadetay_Bilgi
        WHERE musteri_no = pn_musteri_no;

       INSERT INTO Gnl_Firma_Kalite_Belge_Tx
                    (Tx_No,Belge_No,Belgeyi_Veren)
        SELECT vn_tx_no,BELGE_NO,BELGEYI_VEREN
          FROM Gnl_Firma_Kalite_Belge
        WHERE musteri_no =pn_musteri_no;

       INSERT INTO Gnl_Firmadetay_Ciro_Tx
                  (Tx_No,Yil,Doviz_Kod,Ciro,Ithalat,Ihracat)
       SELECT vn_tx_no,Yil,Doviz_Kod,Ciro,Ithalat,Ihracat
         FROM Gnl_Firmadetay_Ciro
        WHERE musteri_no=pn_musteri_no;


      INSERT INTO gnl_musteri_aps_tx
            (tx_no,musteri_no,aps_adres_no,aps_bucak,aps_bucak_kod,aps_csbm,aps_csbm_kodu,aps_dis_kapi_no,aps_ic_kapi_no,
             aps_il,aps_ilce,aps_ilce_kodu,aps_il_kodu,aps_koy,aps_koy_kayit_no,aps_koy_kod,aps_mahalle,aps_mahalle_kod,f_aps_teyit,
             aps_yabanci_adres, aps_yabanci_sehir, aps_yabanci_ulke, aps_yabanci_ulke_kod)
      SELECT vn_tx_no,a.musteri_no,a.aps_adres_no,a.aps_bucak,a.aps_bucak_kod,a.aps_csbm,a.aps_csbm_kodu,a.aps_dis_kapi_no,a.aps_ic_kapi_no,
             a.aps_il,a.aps_ilce,a.aps_ilce_kodu,a.aps_il_kodu,a.aps_koy,a.aps_koy_kayit_no,a.aps_koy_kod,a.aps_mahalle,a.aps_mahalle_kod,a.f_aps_teyit,
             aps_yabanci_adres, aps_yabanci_sehir, aps_yabanci_ulke, aps_yabanci_ulke_kod
        FROM gnl_musteri_aps a
       WHERE a.musteri_no = pn_musteri_no ;


   ELSE
     wsontxno := pkg_trn10044.son_txno_bul(pn_musteri_no);
    /* ortak hesaplar */
     SELECT DISTINCT o.ortaklik_turu
       INTO wortaktur
       FROM gnl_musteri_ortaklik o
      WHERE o.musteri_no=pn_musteri_no;

     INSERT INTO Gnl_Musteri_Bsvr_Ortak_Tnm_Tx
          (Tx_No,Kisa_Ad,Ortaklik_Turu,Musteri_No,Email_Is,Email_Kisisel,Web_Adres,Orijinal_Evraklimi,Son_Txno,bolum_kodu,kazanim_urunu,yatirim_extresi_gonderilsinmi,portfoy_kod,MUSTERI_KAZANDIRAN,musteri_segmenti,Eposta_Teyit,Is_Eposta_Teyit,extre_email_tip)
     SELECT vn_tx_no,G.kisa_ad,wortaktur,pn_musteri_no,G.email_is,G.email_kisisel,G.web_adres,G.orijinal_evraklimi,wsontxno,G.sube_kodu, kazanim_urunu,yatirim_extresi_gonderilsinmi,portfoy_kod,MUSTERI_KAZANDIRAN,musteri_segmenti,eposta_teyit,is_eposta_teyit,extre_email_tip
      FROM gnl_musteri G
     WHERE G.musteri_no = pn_musteri_no;
    K:=1;

    OPEN c_ortak;
    LOOP
      FETCH c_ortak INTO r_ortak;
      EXIT WHEN c_ortak%NOTFOUND;

     INSERT INTO Gnl_Musteri_Basvuru_Ortak_Tx
                (Tx_No,Sira_No,Bagli_Musteri_No,Musteri_Kontakt,Orani,Ortaklik_Turu)
     VALUES (vn_tx_no,K,r_ortak.bagli_musteri_no,r_ortak.musteri_kontakt,r_ortak.orani,r_ortak.ortaklik_turu);
     K := K+1;
    END LOOP;

     INSERT INTO Gnl_Musteri_Ortak_Adres_Tx
           (Tx_No,Adres_Kod,Adres,Semt,Il_Kod,Posta_Kod,Ulke_Kod,Ilk_Gecerlilik_Tarihi,Son_Gecerlilik_Tarihi,
           Ilce_Kod,Extre_Adres_Kod_f,Isyeri_Unvani,Upd_date,Adres_Teyit)
     SELECT vn_tx_no,a.adres_kod,a.adres,a.semt,a.il_kod,a.posta_kod,a.ulke_kod,
               a.gecerlilik_bas_tarihi,a.gecerlilik_bit_tarihi,a.ilce_kod,
               a.extre_adresi_mi,a.isyeri_unvani,NVL(a.upd_date,TRUNC(a.rec_date)),NVL(Adres_Teyit,'H')
       FROM gnl_musteri_adres a
      WHERE a.musteri_no = pn_musteri_no;

     INSERT INTO Gnl_Musteri_Ortak_Telefon_Tx
                (Tx_No,Sira_No,Tel_Tip,Alan_Kod,Tel_No,Dahili_No,Bagli_Adres_Kod,Iletisim_Mi,ulke_kod,upd_date,Telefon_Teyit)
      SELECT  vn_tx_no,Sira_No,Tel_Tip,Alan_Kod,Tel_No,Dahili_No,Bagli_Adres_Kod,Iletisim_Mi,ULKE_KOD,NVL(upd_date,TRUNC(rec_date)),NVL(Telefon_Teyit,'H')
        FROM Gnl_Musteri_Telefon
       WHERE musteri_no =pn_musteri_no ;

      INSERT INTO Gnl_Musteri_Ortak_Dokuman_Tx (
        tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
      , gecerlilik_tarihi,sureli_mi,Aciklama,Alinma_Tarihi,Alan_Kullanici)
      SELECT
        vn_tx_no , sira_no , dokuman_adi , alindi_kutusu_f , duzenlenme_tarihi
        , gecerlilik_tarihi,sureli_mi,NVL(d.dokuman_detay,aciklama),d.alinma_tarihi,d.alan_kullanici
      FROM  Gnl_Musteri_Dokuman d,v_ml_gnl_dokuman_kod_pr P
      WHERE d.musteri_no = pn_musteri_no
        AND P.kod= d.dokuman_adi
      UNION ALL       
      SELECT vn_tx_no ,NVL((SELECT MAX(sira_no) FROM Gnl_Musteri_Dokuman d WHERE d.musteri_no = pn_musteri_no),0) + ROWNUM sira_no, T.DOKUMAN_KOD dokuman_adi, 'H' alindi_kutusu_f, NULL duzenlenme_tarihi ,
        NULL gecerlilik_tarihi,NULL sureli_mi, T.aciklama,null,null
      FROM v_ml_gnl_dokuman_grup_pr T
      WHERE T.musteri_tur_kod=  pkg_musteri.tur(pn_musteri_no)
      AND T.yurt_ici_disi= pkg_musteri.yurt_ici_disi(pn_musteri_no)
      AND T.dokuman_kod NOT IN(SELECT G.dokuman_adi
                               FROM gnl_musteri_dokuman G
                               WHERE G.musteri_no=pn_musteri_no ) ;        
        
        

    /* Basvuru not bilgilerinin musteri not tablosuna aktarilmasi */
        INSERT INTO Gnl_Musteri_Ortak_Notlar_Tx(
        tx_no , sira_no , alinan_notlar , giris_tarihi , kullanici_kodu
      , gorusme_bilgileri , gorusme_notu , katilanlar , gorusme_tarihi , baslangic_saati
      , bitis_saati ,not_tipi,F_NOT_GORUNTULE )
      SELECT
        vn_tx_no , sira_no , alinan_notlar , giris_tarihi , kullanici_kodu,
        gorusme_bilgileri , gorusme_notu , katilanlar , gorusme_tarihi ,
       baslangic_saati, bitis_saati ,not_tipi,NVL(n.f_not_goruntule,'H')
      FROM  GNL_MUSTERI_NOTLAR n
      WHERE musteri_no =pn_musteri_no ;
      
      INSERT INTO Gnl_Musteri_grup_Tx(Tx_No,musteri_no,Musteri_Grup_Kod,Musteri_Grup_Detay_Kod)
      SELECT  vn_tx_no,musteri_no,Musteri_Grup_Kod,Musteri_Grup_Detay_Kod
        FROM Gnl_Musteri_grup
       WHERE musteri_no =pn_musteri_no ;
       
   END IF;
   RETURN vn_tx_no;
  END Musteri_guncel_Kaydi_Olus;
/*********************************************************************************/
  FUNCTION Musteri_Kapatilabilirmi(pn_musteri_no NUMBER) RETURN VARCHAR2 IS

      ln_count NUMBER;
      ls_kisa_kod VARCHAR2(20);
      my_exception EXCEPTION;
      my_exception_fark EXCEPTION;
      cursor c_veli is
        select v.musteri_no ,m.musteri_tur_kod,k.aciklama,decode(m.musteri_tur_kod,'G','Gerçek','T','Tüzel') as turu
          from bnspr.gnl_musteri_velivasi v,bnspr.gnl_iliski_kod_pr k,bnspr.gnl_musteri m  
         where m.musteri_no=v.musteri_no
           and k.kod=v.veli_vasi_tur
           and v.veli_musteri_no=pn_musteri_no
           and v.veli_vasi_tur not in ('27','28','29','30','31'); /* anne,baba,eş,çocuk dışında kalanlar */      
       r_veli c_veli%rowtype;
       
  BEGIN

    SELECT COUNT(*) INTO ln_count
    FROM krl_kasa_musteri_tanim
    WHERE durum='A' and  (musteri_no1=pn_musteri_no or musteri_no2=pn_musteri_no or musteri_no3=pn_musteri_no or musteri_no4=pn_musteri_no);
    IF ln_count!=0 THEN ls_kisa_kod:='Kiralık Kasa';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM muh_HESAP
    WHERE musteri_no=pn_musteri_no and durum_kodu='A';
    IF ln_count!=0 THEN ls_kisa_kod:='Hesap';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM muh_hesap_vadeli
    WHERE musteri_no=pn_musteri_no and durum_kodu='A';
    IF ln_count!=0 THEN ls_kisa_kod:='Vadeli Hesap';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM gnl_musteri_velivasi b
    WHERE b.veli_musteri_no=pn_musteri_no and veli_vasi_tur not in ('27','28','29','30','31'); /* anne,baba,eş,çocuk dışında kalanlar */
--    IF ln_count!=0 THEN ls_kisa_kod:='Veli/Vasi';RAISE my_exception; END IF;
    IF ln_count>0 then
        open c_veli;
        Fetch c_veli into r_veli;
        close c_veli;
        
        pkg_hata.hata_yaz(6044,true,r_veli.musteri_no,r_veli.turu,r_veli.aciklama);
        return 'H';
    END IF;    

    SELECT COUNT(*) INTO ln_count
    FROM gnl_musteri_ortaklik b
    WHERE b.bagli_musteri_no=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Ortak Musteri';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM bnspr.FRK_GIRIS f
    WHERE f.musteri_no =pn_musteri_no
    AND   NVL(f.statu,'-' )  != 'T';
    IF ln_count!=0 THEN RAISE my_exception_fark; END IF;
    
    
    SELECT COUNT(*) INTO ln_count
    FROM gnl_musteri_adi_ortaklik ao
    WHERE ao.ortak_musteri_no=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Tüzel Kişi Ortaklık';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM kib_kullanici_tanim kk
    WHERE kk.kullanici_no=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Kurumsal İnternet Bankacılığı Kullanıcı';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM muh_hesap_kredi
    WHERE musteri_no=pn_musteri_no and durum_kodu='A';
    IF ln_count!=0 THEN ls_kisa_kod:='Kredi Hesap';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM bnspr.bir_basvuru b 
    where b.musteri_no =pn_musteri_no and durum_kodu NOT IN ('IPTAL','KAPANDI');
    IF ln_count!=0 THEN ls_kisa_kod:='Bir Başvuru';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM bnspr.bir_basvuru_tx b 
    where b.musteri_no =pn_musteri_no and durum_kodu = 'ON_ONAY';
    IF ln_count!=0 THEN ls_kisa_kod:='Bir Başvuru Ön Onay';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM bnspr.tff_basvuru tf
    where tf.musteri_no =pn_musteri_no and tf.durum_kod NOT IN ('IPTAL','RED');
    IF ln_count!=0 THEN ls_kisa_kod:='TFF Başvuru';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM bnspr.kk_basvuru kf
    where kf.musteri_no =pn_musteri_no and kf.durum_kod NOT IN ('IPTAL','RED');
    IF ln_count!=0 THEN ls_kisa_kod:='KK Başvuru';RAISE my_exception; END IF;

/*    SELECT COUNT(*) INTO ln_count
    FROM CBS_GB
    WHERE musteri_no=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Gumruk Beyannamesi';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_VW_ITHALAT
    WHERE ITHALATCI_MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='?thalat';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_VW_IHRACAT
    WHERE IHRACATCI_MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='?hracat';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_MUSTERI_LIMIT
    WHERE MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Limit';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_SOZLESME
    WHERE MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Sozlesme';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_LEASING_SOZLESME
    WHERE MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Leasing Sozlesme';RAISE my_exception; END IF;


    SELECT COUNT(*) INTO ln_count
    FROM  cbs_sozlesme a,
        CBS_SOZLESME_kefil b
    WHERE  a.musteri_no = b.musteri_No and
         a.sozlesme_no = b.sozlesme_no and
       a.ek_sozlesme_no = b.ek_sozlesme_no and
       a.durum_kodu = 'ACIK' and
       b.KEFIL_MUSTERI_NO=pn_musteri_no;

    IF ln_count!=0 THEN ls_kisa_kod:='Kefil';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_AVANS
    WHERE MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Avans';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_KREDI_TEMINAT_TANIM
    WHERE MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Teminat Tan?m';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_TM_ALINAN_GARANTI
    WHERE LEHDAR_MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Al?nan Garanti';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_TM_VERILEN_GARANTI
    WHERE LEHDAR_MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Verilen Garanti';RAISE my_exception; END IF;

    SELECT COUNT(*) INTO ln_count
    FROM CBS_YPHAVALE_GELEN
    WHERE ALICI_MUSTERI_NO=pn_musteri_no;
    IF ln_count!=0 THEN ls_kisa_kod:='Gelen Havale Al?c?';RAISE my_exception; END IF;
 MHA ana tablolar oldukca bu kisim duzenlenmelidir.*/
    RETURN 'E';

  EXCEPTION
  WHEN my_exception THEN
       Pkg_Hata.hata_yaz(465,TRUE,ls_kisa_kod);
       RETURN 'H';
  WHEN my_exception_fark THEN
       RETURN 'O'/*Pkg_Hata.mesajOlustur(2438)*/;
  END Musteri_Kapatilabilirmi;




 FUNCTION musteri_grup_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.musteri_grup_kod%TYPE IS

 ls_grup_kod gnl_musteri_grup.musteri_grup_kod%TYPE ;


 BEGIN

    SELECT musteri_grup_kod  INTO ls_grup_kod FROM (
     SELECT M.musteri_grup_kod
     FROM  gnl_musteri_grup M
     WHERE M.musteri_no = p_musteri_no
     ORDER BY rec_date )
     WHERE ROWNUM = 1  ;

   RETURN ls_grup_kod ;
 EXCEPTION WHEN others THEN
   RETURN musteri_kayit(p_musteri_no).musteri_grup_kod;
 END;

 FUNCTION ortaklik_turu(p_musteri_no gnl_musteri_ortaklik.musteri_no%TYPE) RETURN gnl_musteri_ortaklik.ortaklik_turu%TYPE IS
  CURSOR c_ortak IS
   SELECT o.ortaklik_turu
     FROM gnl_musteri_ortaklik o
    WHERE o.musteri_no=p_musteri_no;
  wtur gnl_musteri_ortaklik.ortaklik_turu%TYPE;
 BEGIN
    OPEN c_ortak;
    FETCH c_ortak INTO wtur;
    CLOSE c_ortak;

    RETURN wtur;
 END ortaklik_turu;
/********************************************************************************************************************/
/* _BPM altina tasindi MHA 110408
Procedure musteri_bayi_bilgileri(pn_musteri_no        in number,
                                   ps_vergi_il_kodu     out varchar2,
                                   ps_vergi_daire_kodu  out varchar2,
                                   pn_vergi_no          out number,
                                   ps_email             out varchar2,
                                   ps_web_adres         out varchar2,
                                   ps_ticari_unvan      out varchar2,
                                   ps_firma_tipi        out varchar2,
                                   pd_kurulus_tarihi    out date,
                                   ps_adres_kod         out varchar2,
                                   ps_isyeri_unvani     out varchar2,
                                   ps_adres             out varchar2,
                                   ps_semt              out varchar2,
                                   ps_il_kod            out varchar2,
                                   ps_ilce_kod          out varchar2,
                                   ps_posta_kod         out varchar2,
                                   ps_ulke_kod          out varchar2,
                                   ps_tel_tip           out varchar2,
                                   ps_alan_kod          out varchar2,
                                   ps_telefon_no        out varchar2) IS
    cursor c_musteri is
     select musteri_no,g.musteri_tur_kod
       from gnl_musteri g
      where musteri_no=pn_musteri_no;
    wmusteri_no number;
    wtur        varchar2(10);

   CURSOR cur_ekstre_adres IS
    SELECT a.adres_kod,a.isyeri_unvani,adres, a.semt, a.il_kod,a.ilce_kod, a.posta_kod, a.ulke_kod
      FROM GNL_MUSTERI_ADRES a
     WHERE a.musteri_no = pn_musteri_no
       AND a.extre_adresi_mi = 'E';
   r_extre_adres cur_ekstre_adres%rowtype;

   cursor cur_tel is
     select t.tel_tip,t.alan_kod,t.tel_no,t.dahili_no
       from gnl_musteri_telefon t
      where t.musteri_no = pn_musteri_no
        and t.iletisim_mi='E';
   r_tel cur_tel%rowtype;

 Begin
   open c_musteri;
   fetch c_musteri into wmusteri_no,wtur;
   close c_musteri;

   if wmusteri_no is not null then
      ps_vergi_daire_kodu := pkg_musteri.vergi_daire_kodu(pn_musteri_no);
      ps_vergi_il_kodu    := pkg_musteri.vergi_il_kodu(pn_musteri_no);
      pn_vergi_no         := pkg_musteri.vergi_no(pn_musteri_no);
      ps_email            := NVL(pkg_musteri.email_is(pn_musteri_no),pkg_musteri.email_kisisel(pn_musteri_no));
      ps_web_adres        := pkg_musteri.web_adresi(pn_musteri_no);
      ps_ticari_unvan     := pkg_musteri.unvan(pn_musteri_no);

     IF wtur = 'T' then
        ps_firma_tipi       := pkg_tablo.firma_detay(pn_musteri_no).firma_tipi;
        pd_kurulus_tarihi   := pkg_tablo.firma_detay(pn_musteri_no).kurulus_tarihi;
     END IF;

      open cur_ekstre_adres;
      Fetch cur_ekstre_adres into r_extre_adres;
      close cur_ekstre_adres;

      ps_adres_kod        := r_extre_adres.adres_kod;
      ps_isyeri_unvani    := r_extre_adres.isyeri_unvani;
      ps_adres            := r_extre_adres.adres;
      ps_semt             := r_extre_adres.semt;
      ps_il_kod           := r_extre_adres.il_kod;
      ps_ilce_kod         := r_extre_adres.ilce_kod;
      ps_posta_kod        := r_extre_adres.posta_kod;
      ps_ulke_kod         := r_extre_adres.ulke_kod;

      open cur_tel;
      Fetch cur_tel into r_tel;
      close cur_tel;

      ps_tel_tip          := r_tel.tel_tip;
      ps_alan_kod         := r_tel.alan_kod;
      ps_telefon_no       := r_tel.tel_no;

   end if;
 End musteri_bayi_bilgileri;*/
/********************************************************************************************************************/
 FUNCTION musteri_vadeli_marj_oran(pn_musteri_no IN NUMBER) RETURN NUMBER IS
   CURSOR c_mus_marj IS
    SELECT M.marj_orani
      FROM vad_musteri_marj M
     WHERE M.musteri_no = pn_musteri_no;

   wgrup gnl_musteri.musteri_grup_kod%TYPE;
   CURSOR c_grup_marj IS
    SELECT G.marj_orani
      FROM vad_musteri_grup_marj G
     WHERE G.grup_kod IN (SELECT gr.musteri_grup_kod FROM gnl_musteri_grup gr WHERE gr.musteri_no=pn_musteri_no)
     ORDER BY 1 DESC;

   wmarj NUMBER;

 BEGIN
    OPEN c_mus_marj;
    FETCH c_mus_marj INTO wmarj;
    IF c_mus_marj%NOTFOUND OR wmarj=0 THEN
       /* bagli oldugu grup varsa onun marjini alalim */
       wgrup := musteri_kayit(pn_musteri_no).musteri_grup_kod;
       OPEN c_grup_marj;
       FETCH c_grup_marj INTO wmarj;
       CLOSE c_grup_marj;
    END IF;
    CLOSE c_mus_marj;
    RETURN NVL(wmarj,0);
 END musteri_vadeli_marj_oran;
/**********************************************************************************************************************/
  FUNCTION TCKN_KONTROL(pn_tc_kimlik_no NUMBER) RETURN NUMBER IS
  BEGIN
     IF tcno_kontrol(pn_tc_kimlik_no) THEN
        RETURN 1;
     ELSE
        RETURN 0;
     END IF;
 END TCKN_KONTROL;
/**********************************************************************************************************************/
 FUNCTION ad_kontrol(pn_ad IN VARCHAR2) RETURN NUMBER IS
    org_word VARCHAR2(70) := pn_ad;
    new_word VARCHAR2(70);
    len      NUMBER;
    i        NUMBER := 1;
 BEGIN
    IF LENGTH(TRIM(org_word)) <= 1 THEN
       RETURN 1; --tek ya da daha az char icerir
    END IF;

    new_word := TRIM(TRANSLATE(UPPER(org_word),pkg_parametre.paramtextal ('CHARSETS', 'TR'),'                                '));
    IF LENGTH(new_word) != 0 THEN
       RETURN 2; --harften baska char var
    END IF;

    len := LENGTH(TRIM(org_word));
    WHILE i < len - 2 LOOP
       IF SUBSTR(org_word, i, 1) = SUBSTR(org_word, i + 1, 1) THEN
          IF SUBSTR(org_word, i + 1, 1) = SUBSTR(org_word, i + 2, 1) THEN
             RETURN 3; -- 3 tane yan yana ayni char var
          END IF;
       END IF;
       i := i+1 ;
    END LOOP;

    RETURN 0;
 END ad_kontrol;

 --------------------------------------------------------------------


/* function AmacKod (pc_kod varchar2) return varchar2 is
  vc_amackod gnl_must_grup_amac_iliski_pr.amac_kod%type;
  begin
   Select amac_kod
    into vc_amackod
    from gnl_must_grup_amac_iliski_pr a,gnl_musteri_grup_kod_pr b
    where a.grup_kod = b.kod and kod = pc_kod;
    Return vc_amackod;
  exception WHEN NO_DATA_FOUND THEN RETURN 0 ;
  end AmacKod;*/
 --------------------------------------------------------------------
  FUNCTION AmacKodVarMi (pc_kod VARCHAR2, pc_amacKod VARCHAR2) RETURN NUMBER IS
  vn_count NUMBER;
  BEGIN
   SELECT COUNT(*)
    INTO vn_count
    FROM gnl_must_grup_amac_iliski_pr a,gnl_musteri_grup_kod_pr b
    WHERE a.grup_kod = b.kod AND kod = pc_kod AND amac_kod = pc_amacKod;
    RETURN vn_count;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0 ;
  END AmacKodVarMi;
 --------------------------------------------------------------------
 PROCEDURE ADK_user_creation_infomail(pn_islem_no IN NUMBER,ps_username IN VARCHAR2,ps_passwd IN VARCHAR2) IS
   CURSOR c_tx_tablo IS
   SELECT T.musteri_numara
     FROM muh_islem T
    WHERE T.numara = pn_islem_no;

   r_tx_tablo c_tx_tablo%ROWTYPE;
   vs_body  VARCHAR2(400);
 BEGIN
    OPEN c_tx_tablo;
    FETCH c_tx_tablo INTO r_tx_tablo;
    CLOSE c_tx_tablo;

       /* ADK user'i acilmistir mail atalim MHA 260908 */
       vs_body := r_tx_tablo.musteri_numara||' nolu müsteri için ADK kullanicisi açilmistir.'||CHR(10)||
                '     username='||ps_username||CHR(10)||
                '     password='||ps_passwd||CHR(10);
       pkg_mail.send_mail(ps_mail_from => 'Akustik@aktifbank.com.tr',
                          ps_mail_subject => 'Info',
                          ps_mail_body => vs_body,
                          pn_tx_no => pn_islem_no,
                          ps_mail_cc => pkg_parametre.Deger_Al_K('ADK_USER_INFOMAIL_CC'),--'eylem.gunduz@aktifbank.com.tr;hale.tuncer@aktifbank.com.tr;nur.yaman@aktifbank.com.tr',
                          ps_mail_bcc => NULL,
                          ps_mail_to => pkg_parametre.Deger_Al_K('ADK_USER_INFOMAIL_TO')/* 'neslihan.ozsevim@aktifbank.com.tr'*/); --NVL(r_islem.email_is,r_islem.email_kisisel),
 END ADK_user_creation_infomail;

 --------------------------------------------------------------------
  FUNCTION MusteriNoVarMi (pn_musteri_no NUMBER) RETURN NUMBER IS
  vn_count NUMBER;
  BEGIN
   SELECT COUNT(*)
    INTO vn_count
    FROM gnl_musteri M
    WHERE M.musteri_no=pn_musteri_no;
    RETURN vn_count;
  EXCEPTION WHEN NO_DATA_FOUND THEN RETURN 0 ;
  END MusteriNoVarMi;
 --------------------------------------------------------------------
 FUNCTION musteri_temsilcisi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.musteri_temsilcisi%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).musteri_temsilcisi;
   EXCEPTION WHEN others THEN RETURN NULL;
 END;
--------------------------------------------------------------------
 FUNCTION ilk_iliski_tarihi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.ilk_iliski_tarihi%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).ilk_iliski_tarihi;
 END;
 --------------------------------------------------------------------
 FUNCTION grup_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.grup_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).grup_kod;
 END;
 --------------------------------------------------------------------
 FUNCTION rating_kodu(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.rating_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).rating_kodu;
 END;
 --------------------------------------------------------------------
 FUNCTION musteri_stat1(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.musteri_stat1%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).musteri_stat1;
 END;
 --------------------------------------------------------------------
 FUNCTION musteriMi_kontaktMi(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.Musteri_Kontakt%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).musteri_kontakt;
   EXCEPTION WHEN others THEN RETURN NULL;
  END;
 --------------------------------------------------------------------
 FUNCTION musteri_sube(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.sube_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).sube_kodu;
   EXCEPTION WHEN others THEN RETURN NULL;
  END;

 --------------------------------------------------------------------
  FUNCTION  Adres_extre_il_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT a.il_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO ps_il_kod;
 	  CLOSE cur_ekstre_adres;
   --
    RETURN ps_il_kod;

  END;
 --------------------------------------------------------------------
  FUNCTION  Adres_extre_ilce_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT a.ilce_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
	   ps_adres     gnl_musteri_adres.adres%TYPE;
	   ps_semt      gnl_musteri_adres.semt%TYPE;
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
     pn_posta_kod gnl_musteri_adres.posta_kod%TYPE;
   	 ps_ulke_kod  gnl_musteri_adres.ulke_kod%TYPE;
     ps_ilce_kod  gnl_musteri_adres.ilce_kod%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_ilce_kod;
 	  CLOSE cur_ekstre_adres;
   --
    RETURN ps_ilce_kod;

  END;
 --------------------------------------------------------------------
  FUNCTION  Adres_extre_semt( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT a.semt
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
	   ps_adres     gnl_musteri_adres.adres%TYPE;
	   ps_semt      gnl_musteri_adres.semt%TYPE;
 	   ps_il_kod    gnl_musteri_adres.il_kod%TYPE;
     pn_posta_kod gnl_musteri_adres.posta_kod%TYPE;
   	 ps_ulke_kod  gnl_musteri_adres.ulke_kod%TYPE;
     ps_ilce_kod  gnl_musteri_adres.ilce_kod%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_semt;
 	  CLOSE cur_ekstre_adres;
   --
    RETURN ps_semt;

  END;
 --------------------------------------------------------------------
  FUNCTION  Adres_extre_il_adi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT pkg_genel_pr.il_adi_hatasiz( a.il_kod)
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
 	   ps_il_adi    gnl_il_kod_pr.il_adi%TYPE;
  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO ps_il_adi;
 	  CLOSE cur_ekstre_adres;
   --
    RETURN ps_il_adi;

  END;
 --------------------------------------------------------------------
  FUNCTION  Adres_extre_ilce_adi( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT pkg_genel_pr.ilce_adi_hatasiz( a.il_kod ,a.ilce_kod)
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
     ps_ilce_adi  gnl_ilce_kod_pr.ilce_adi%TYPE;

  BEGIN
    /*IF cur_ekstre_adres%isopen THEN
 	   CLOSE cur_ekstre_adres;
    END IF;*/
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO 	ps_ilce_adi;
 	  CLOSE cur_ekstre_adres;
   --
    RETURN ps_ilce_adi;

  END;
------------------------------------------------------------------------------------
  FUNCTION  Adres_extre_posta_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT a.posta_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
 	   ps_posta_kod    gnl_musteri_adres.posta_kod%TYPE;
  BEGIN
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO ps_posta_kod;
 	  CLOSE cur_ekstre_adres;
    RETURN ps_posta_kod;
    EXCEPTION WHEN no_data_found THEN
    RETURN NULL;
  END;
------------------------------------------------------------------------------------
  FUNCTION  Adres_extre_ulke_kod( pn_musteri_no GNL_MUSTERI.musteri_no%TYPE) RETURN VARCHAR2
   IS

     CURSOR cur_ekstre_adres IS
        SELECT a.ulke_kod
          FROM GNL_MUSTERI_ADRES a
         WHERE a.musteri_no = pn_musteri_no
           AND a.extre_adresi_mi = 'E';
 	   ps_ulke_kod    gnl_musteri_adres.ulke_kod%TYPE;
  BEGIN
    OPEN cur_ekstre_adres;
   	FETCH cur_ekstre_adres INTO ps_ulke_kod;
 	  CLOSE cur_ekstre_adres;
    RETURN ps_ulke_kod;
    EXCEPTION WHEN no_data_found THEN
    RETURN NULL;
  END;
---------------------------------------------------------------------------------------
FUNCTION aps_adresi(pn_musteri_no NUMBER) RETURN VARCHAR2 IS
  vc_adres VARCHAR2(550);
BEGIN
  SELECT TRIM(aps_koy||' '||aps_mahalle||' '||aps_csbm||' '||aps_dis_kapi_no||' '||aps_ic_kapi_no||' '||aps_ilce||' '||aps_il)
  INTO vc_adres
  FROM gnl_musteri_aps
  WHERE musteri_no = pn_musteri_no;

  RETURN vc_adres;
EXCEPTION WHEN others THEN
  RETURN '';
END;

FUNCTION aps_yabanci_adresi(pn_musteri_no NUMBER) RETURN VARCHAR2 IS
  vc_adres VARCHAR2(550);
BEGIN
  SELECT TRIM(a.aps_yabanci_adres||' '||a.aps_yabanci_sehir||' '||a.aps_yabanci_ulke_kod||' '||a.aps_yabanci_ulke)
  INTO vc_adres
  FROM gnl_musteri_aps a
  WHERE musteri_no = pn_musteri_no;

  RETURN vc_adres;
EXCEPTION WHEN others THEN
  RETURN '';
END;



 FUNCTION olum_tarihi(p_musteri_no gnl_musteri_kimlik.musteri_no%TYPE) RETURN gnl_musteri_kimlik.olum_tarihi%TYPE IS
 BEGIN
   RETURN musteri_kimlik_kayit(p_musteri_no).olum_tarihi ;
 END;

  FUNCTION iletisim_dili(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.iletisim_dili%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).iletisim_dili;
 END;



  FUNCTION sube_kodu(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.sube_kodu%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).sube_kodu;
 END;
 
  FUNCTION Musteri_Varmi_TCKN(pn_tckn gnl_musteri.Tc_Kimlik_No%TYPE)
    RETURN NUMBER IS
    vn_musteri_no gnl_musteri.musteri_no%TYPE;
  BEGIN
    SELECT M.musteri_no INTO vn_musteri_no FROM gnl_musteri M 
    WHERE M.tc_kimlik_no = pn_tckn
    AND ROWNUM < 2; --gerçek ve tüzel olarak 2 kayit geldiginde ilk gelenin alinmasi istendi
    RETURN vn_musteri_no;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END Musteri_Varmi_TCKN;

  FUNCTION Musteri_Varmi_VKN(pn_vkn gnl_musteri.Vergi_No%TYPE) RETURN NUMBER IS
    vn_musteri_no gnl_musteri.musteri_no%TYPE;
  BEGIN
    SELECT M.musteri_no INTO vn_musteri_no FROM gnl_musteri M 
    WHERE M.vergi_no = pn_vkn
    AND ROWNUM < 2; --gerçek ve tüzel olarak 2 kayit geldiginde ilk gelenin alinmasi istendi
    RETURN vn_musteri_no;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      RETURN NULL;
  END Musteri_Varmi_VKN;
  
  FUNCTION portfoy_kod(p_musteri_no gnl_musteri.musteri_no%TYPE) RETURN gnl_musteri.portfoy_kod%TYPE IS
 BEGIN
   RETURN musteri_kayit(p_musteri_no).portfoy_kod;
 END;
 
 FUNCTION getCustomerInfoFromBicCode(pc_bic_kod gnl_musteri.bic_kod%TYPE) Return pkg_types.rc_resultset IS
    vrc_query pkg_types.rc_resultset;
  BEGIN
    OPEN vrc_query FOR
      SELECT m.musteri_no,
             unvan(m.musteri_no) musteri_unvan,
             mt.kod musteri_tur_kod,
             mt.aciklama musteri_tur   
      FROM gnl_musteri m
           LEFT JOIN gnl_must_tur_kod_pr mt ON mt.kod = m.musteri_tur_kod  
      WHERE m.bic_kod = pc_bic_kod;                                           
    
    RETURN vrc_query;
 END getCustomerInfoFromBicCode;

  
END Pkg_Musteri;
/
