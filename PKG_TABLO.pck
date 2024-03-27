CREATE OR REPLACE PACKAGE PKG_TABLO IS

   -- @Date     08.10.2007
   -- @Author   Bilal G�L
   -- @Purpose  Kod Tablolarindan bilgi almak i�in hazirlandi.
   -- @Version  1.0

 -- Adres Kodlari Tanim Tablosu Verilerini �eker
 Function adres_kod(p_kod v_ml_gnl_adres_kod_pr.kod%type) return v_ml_gnl_adres_kod_pr%rowtype;

 -- Bloke Durum Kodlari Tanim Tablosu Verilerini �eker Verilerini �eker
 Function bloke_durum_kod(p_kod v_ml_gnl_bloke_durum_kod_pr.kod%type) return v_ml_gnl_bloke_durum_kod_pr%rowtype;

 -- Bloke Sebep Kodlari Tanim Tablosu Verilerini �eker
 Function bloke_sebep_kod(p_kod v_ml_gnl_bloke_sebep_kod_pr.kod%type) return v_ml_gnl_bloke_sebep_kod_pr%rowtype;

 -- Banka i�i Bolum Kodlari Tanim Tablosu Verilerini �eker
 Function bolum_kod(p_kod v_ml_gnl_bolum_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_bolum_kod_pr%rowtype;

 -- Cinsiyet Kodlari Tanim Tablosu Verilerini �eker
 Function cinsiyet_kod(p_kod v_ml_gnl_cinsiyet_kod_pr.kod%type) return v_ml_gnl_cinsiyet_kod_pr%rowtype;

 -- Dealer Kodlari Tanim Tablosu Verilerini �eker
 Function dealer_kod(p_kod v_ml_gnl_dealer_kod_pr.kod%type) return v_ml_gnl_dealer_kod_pr%rowtype;

 -- Dil Kodlari Tanim Tablosu Verilerini �eker
 Function dil_kod(p_kod v_ml_gnl_dil_kod_pr.kod%type) return v_ml_gnl_dil_kod_pr%rowtype;

 -- Sistemde tanimli D�viz Kodlari Tanim Tablosu Verilerini �eker
 Function doviz_kod(p_kod v_ml_gnl_doviz_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_doviz_kod_pr%rowtype;

 -- Egitgm Kodlari Tanim Tablosu Verilerini �eker
 Function egitim_kod(p_kod v_ml_gnl_egitim_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_egitim_kod_pr%rowtype;

 -- Istatistik Kodlari Tanim Tablosu Verilerini �eker
 Function istatistik_kod(p_kod v_ml_gnl_istatistik_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_istatistik_kod_pr%rowtype;

 -- Sistem Kanal Grup Kodlari Tanim Tablosu Verilerini �eker
 Function kanal_kod(p_kod v_ml_gnl_kanal_grup_kod_pr.kod%type) return v_ml_gnl_kanal_grup_kod_pr%rowtype;
 Function kanal_Alt_kod(p_kod     v_kanal_alt_kod_pr.KANAL_kod%type ,
                        p_alt_kod v_kanal_alt_kod_pr.KOD%type) return v_kanal_alt_kod_pr%rowtype;

 -- M�steri Kimlik Kodlari Tanim Tablosu Verilerini �eker
 Function kimlik_kod(p_kod v_ml_gnl_kimlik_kod_pr.kod%type) return v_ml_gnl_kimlik_kod_pr%rowtype;

 -- Sistemde Tanimli Kullanici Kodlari Tanim Tablosu Verilerini �eker
 Function kullanici (p_kod gnl_kullanici.kod%type) return gnl_kullanici%rowtype ;

 -- Kullanici G�rev Kodlari Tanim Tablosu Verilerini �eker
 Function kullanici_gorev_kod(p_kod v_ml_gnl_kul_gorev_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_kul_gorev_kod_pr%rowtype;

 -- Meslek Kodlari Tanim Tablosu Verilerini �eker
 Function meslek_kod(p_kod v_ml_gnl_meslek_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_meslek_kod_pr%rowtype;

 -- �nvan Kodlari Tanim Tablosu Verilerini �eker
 Function unvan_kod(p_kod v_ml_gnl_unvan_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_unvan_kod_pr%rowtype;

 -- M�steri Uyruk Kodlari Tanim Tablosu Verilerini �eker
 Function uyruk_kod(p_kod v_ml_gnl_uyruk_kod_pr.kod%type) return v_ml_gnl_uyruk_kod_pr%rowtype;

 -- Hesap Plani Statik Verilerini �eker
 Function hesap_plani_tanim(p_hesap_no muh_hp_tanim.HESAP_NO%type) return muh_hp_tanim%rowtype;

 -- Bankamiz hakkinda statik Verileri �eker
 Function bankamiz_bilgi return gnl_bankamiz_bilgi_pr%rowtype;

 -- Il Kodlari Tanim Tablosu Verilerini �eker
 Function il_kod(p_kod gnl_il_kod_pr.kod%type) return gnl_il_kod_pr%rowtype;

 -- Il�e Kodlari Tanim Tablosu Verilerini �eker
 Function ilce_kod(p_il_kod gnl_ilce_kod_pr.il_kod%type, p_ilce_kod gnl_ilce_kod_pr.ilce_kod%type ) return gnl_ilce_kod_pr%rowtype;

 -- Sistemde tanimli Sube Kodlari  Verilerini �eker
 Function sube_kod(p_kod gnl_sube_kod_pr.kod%type) return gnl_sube_kod_pr%rowtype;

 -- �lke Kodlari Tanim Tablosu Verilerini �eker
 Function ulke_kod(p_kod gnl_ulke_kod_pr.kod%type) return gnl_ulke_kod_pr%rowtype;

 -- Vergi Dairesi Kodlari Tanim Tablosu Verilerini �eker
 Function vergi_daire_kod(p_il_kod gnl_vergi_daire_kod_pr.il_kod%type, p_vergi_d_kod gnl_vergi_daire_kod_pr.vergi_d_kod%type) return gnl_vergi_daire_kod_pr%rowtype;

 -- Sistemde Tanimli M�steri Verilerini �eker
 Function musteri_kayit(p_musteri_no gnl_musteri.MUSTERI_NO%type) return gnl_musteri%rowtype;

 -- M�sterinin Adres Kayitlari Verilerini �eker
 Function musteri_adres_kayit(p_musteri_no gnl_musteri_adres.MUSTERI_NO%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres%rowtype;

 -- M�sterinin Kimlik Kayitlari Verilerini �eker
 Function musteri_kimlik_kayit(p_musteri_no gnl_musteri_kimlik.MUSTERI_NO%type) return gnl_musteri_kimlik%rowtype;

 -- M�sterinin Veli Kayitlarini �eker
 Function musteri_veli_kayit(p_musteri_no gnl_musteri_velivasi.MUSTERI_NO%type) return gnl_musteri_velivasi%rowtype;

 -- Sistem Tanim Tablosu Verilerini �eker
 Function sistem_bilgi(p_kod GNL_SISTEM_BILGI_PR.KOD%type) return GNL_SISTEM_BILGI_PR%rowtype;

 -- Sistemde tanimli Vadesiz Hesaplari  �eker
 Function hesap_kayit(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap%rowtype;
 -- Sistemde tanimli Vadeli Hesaplari  �eker
 Function hesap_kayit_vadeli(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap_vadeli%rowtype;
 -- Sistemde tanimli T�m Hesaplari izleme_tum view'i tipinde �eker
 Function hesap_kayit_izleme(p_hesap_no muh_hesap.hesap_no%type) return v_muh_hesap_izleme_tum%rowtype;
 -- Sistemde tanimli T�m Hesaplari izleme view'i tipinde �eker MHA fislerde hakki olmayan hesabi goremesin diye 100708
 Function hesap_kayit_izleme_kisitli(p_hesap_no muh_hesap.hesap_no%type) return v_muh_hesap_izleme%rowtype;


 -- Sistemde Kayitli Hesaplarin Statik Kayitlarini �eker
 Function hesap_tanim_kayit(p_hesap_no muh_hesap_tanim.hesap_no%type, pb_Kes Boolean Default TRUE) return muh_hesap_tanim%rowtype;

 -- Sistemde Kayitli Hesaplarin Bakiye Kayitlarini �eker
 Function hesap_bakiye_kayit(p_hesap_no muh_hesap_bakiye.hesap_no%type) return muh_hesap_bakiye%rowtype;




 -- M�steri I�in Extre siklik Kodlari Tanim Tablosu Verilerini �eker
 Function ekstre_siklik_kod(p_kod v_ml_gnl_ekstre_siklik_kod_pr.kod%type) return v_ml_gnl_ekstre_siklik_kod_pr%rowtype;
 -- M�steri I�in Extre T�r Kodlari Tanim Tablosu Verilerini �eker
 Function ekstre_tur_kod(p_kod v_ml_gnl_ekstre_tur_kod_pr.kod%type) return v_ml_gnl_ekstre_tur_kod_pr%rowtype;
 -- M�steri Kategori Kodlari Tanim Tablosu Verilerini �eker
 Function must_kategori_kod(p_kod v_ml_gnl_must_kategori_kod_pr.kod%type) return v_ml_gnl_must_kategori_kod_pr%rowtype;
 -- M�steri T�r� Kodlari Tanim Tablosu Verilerini �eker
 Function musteri_tur_kod(p_kod v_ml_gnl_must_tur_kod_pr.kod%type) return v_ml_gnl_must_tur_kod_pr%rowtype;
 -- T�zel kisi Sekt�r Kodlari Tanim Tablosu Verilerini �eker
 Function sektor_kod(p_kod v_ml_gnl_sektor_kod_pr.kod%type) return v_ml_gnl_sektor_kod_pr%rowtype;
 -- Sekt�r Alt-1 Kodlari Tanim Tablosu Verilerini �eker
 Function sektor_kod1(p_sektor_kod v_ml_gnl_sektor_kod1_pr.sektor_kod%type,
                      p_sektor_kod1 v_ml_gnl_sektor_kod1_pr.sektor_kod1%type) return v_ml_gnl_sektor_kod1_pr%rowtype ;
 -- Sekt�r Alt-2 Kodlari Tanim Tablosu Verilerini �eker
 Function sektor_kod2(p_sektor_kod v_ml_gnl_sektor_kod2_pr.sektor_kod%type,
                      p_sektor_kod1 v_ml_gnl_sektor_kod2_pr.sektor_kod1%type,
                      p_sektor_kod2 v_ml_gnl_sektor_kod2_pr.sektor_kod2%type) return v_ml_gnl_sektor_kod2_pr%rowtype ;
 -- S�zlesme Alt Kodlari Tanim Tablosu Verilerini �eker
 Function sozlesme_alt_kod(p_SOZLESME_KOD v_ml_gnl_sozlesme_alt_kod_pr.SOZLESME_KOD%type,
                      p_SOZLESME_ALT_KOD v_ml_gnl_sozlesme_alt_kod_pr.SOZLESME_ALT_KOD%type) return v_ml_gnl_sozlesme_alt_kod_pr%rowtype ;
 -- S�zlesme  Kodlari Tanim Tablosu Verilerini �eker
 Function sozlesme_kod(p_kod v_ml_gnl_sozlesme_kod_pr.kod%type) return v_ml_gnl_sozlesme_kod_pr%rowtype;


 -- Islem Tablosu Kayit Deseninde Verilerini �eker
 Function muh_islem_tablo(p_numara MUH_ISLEM.numara%type) return MUH_ISLEM%rowtype;
 -- Islem Tanim T�r Kodlari Tanim Tablosu Verilerini �eker
 Function muh_islem_tanim_tablo(p_kod v_ml_muh_islem_tanim_pr.kod%type) return v_ml_muh_islem_tanim_pr%rowtype;

 -- Sistemde Tanimli Kasa Kodlari Tanim Tablosu Verilerini �eker
 Function kasa_kod( p_sube_kod v_ml_gnl_kasa_kodlari_pr.sube_kodu%type, p_kasa_kod v_ml_gnl_kasa_kodlari_pr.KOD%type) return v_ml_gnl_kasa_kodlari_pr%rowtype;
 -- kasa Kup�r Kodlari Tanim Tablosu Verilerini �eker
 Function kasa_kupur_islem_kod_tablo(p_kod V_ML_GNL_KASA_KUPUR_ISL_KOD_PR.kod%type) return V_ML_GNL_KASA_KUPUR_ISL_KOD_PR%rowtype;

 -- Masraf Komisyon Faiz Gelir tipleri
 Function MasKom_FAIZGelTip(p_kod  v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr.KOD%type) return v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr%rowtype ;

 Function modul_urun_sinif(p_modul gnl_modul_urun_sinif_kod_pr.modul_tur_kod%type, p_urun gnl_modul_urun_sinif_kod_pr.urun_tur_kod%type, p_urun_sinif gnl_modul_urun_sinif_kod_pr.kod%type) return v_Ml_Modul_Urun_Sinif_Kod_Pr%rowtype;

 Function musteri_grup_kod_kayit( p_musteri_grup_kod V_ML_GNL_MUSTERI_GRUP_KOD_PR.KOD %type) return V_ML_GNL_MUSTERI_GRUP_KOD_PR%rowtype;
-- Personel Maas
 Function maas_izleyecek_personel( p_personel_no MAAS_HESAPIZLE.PERSONEL_NO %type) return MAAS_HESAPIZLE%rowtype;
 Function Personel( p_personel_no GNL_PERSONEL.PERSONEL_NUMARA%type) return GNL_PERSONEL%rowtype;
--Bireysel Kredi T�rleri
 Function birkrdtur(p_kod v_ml_bir_krd_tur.kod%type) return v_ml_bir_krd_tur%rowtype;
--Bireysel Kredi alt T�rleri
 Function BirKrdAltTur(p_krd_tur_kod v_ml_bir_krd_alt_tur.krd_tur_kod%Type,
                       p_kod         v_ml_bir_krd_alt_tur.kod%type) return v_ml_bir_krd_alt_tur%rowtype;
--Bireysel Kredi alt2 T�rleri
 Function BirKrdAltTur2(p_krd_tur_kod     v_ml_bir_krd_alt_tur2.krd_tur_kod%Type,
                        p_krd_tur_alt_kod v_ml_bir_krd_alt_tur2.krd_tur_alt_kod%Type,
                        p_kod             v_ml_bir_krd_alt_tur2.kod%type) return v_ml_bir_krd_alt_tur2%rowtype;
--Bireysel �deme
 Function Birodmgrppr(p_kod v_ml_bir_odm_grp_pr.kod%type) return v_ml_bir_odm_grp_pr%rowtype;
--
--Grup Kodlari
  Function GrupKodlari(p_kod v_ml_gnl_grup_kodlari.KOD%type) return v_ml_gnl_grup_kodlari%rowtype;
--
 Function BazFaizOran(pn_krdturkod Number, pn_krdturaltkod Number, pc_dov Varchar2) Return bir_faiz_baz_oran_pr%ROWTYPE;
--
 Function FaizOran(pn_krdturkod Number, pn_krdturaltkod Number, pn_krdturaltkod2 Number, pc_dov Varchar2, pc_kanal Varchar2) Return bir_faiz_oran_pr%ROWTYPE;
--
 Function BirTemTanim(pn_krd_tur_kod Number, pn_krd_tur_alt_kod Number, pn_krd_tur_alt_kod2 Number,
                      pn_kanal_kod Number, pc_dov Varchar2, pn_tem_kod Number) Return bir_tem_tanim%ROWTYPE;
--
 Function ParamText(pkod In Varchar2, pkey1 In Varchar2, pkey2 In Varchar2 Default Null, pkey3 In Varchar2 Default Null)
                    Return V_ML_GNL_PARAM_TEXT%ROWTYPE;
 --
 Function KMH_Faiz_oranF (pkod In Number)  Return kmh_faiz_oran%ROWTYPE;
 --
 Function BirSatici (pkod In Number, pb_Kes Boolean Default TRUE)  Return Bir_Satici%ROWTYPE;
 -- 
 Function BirSaticiCalisan (pkod In Number, pb_Kes Boolean Default TRUE)  Return Bir_Satici_Calisan%ROWTYPE;
 --
 Function firma_detay(p_musteri_no gnl_firmadetay_bilgi.MUSTERI_NO%type) return gnl_firmadetay_bilgi%rowtype;
 --
 Function BirSaticiIliski (pn_saticikod In Number, pn_satBagliKod In Number)  Return Bir_Satici_Iliski%ROWTYPE;
 --
 Function BirSaticiTahsis (pn_saticikod In Bir_Satici_Tahsis.Kod%Type, pb_raise Boolean Default TRUE)  Return Bir_Satici_Tahsis%ROWTYPE;
 --
 Function AdkSaticiTanim (pn_saticikod In adk_stand_tanim.Kod%Type, pb_raise Boolean Default TRUE)  Return adk_stand_tanim%ROWTYPE;
 --
 Function TesvikTip(p_kod v_ml_bir_bayi_tesvik_tip_pr.kod%type) return v_ml_bir_bayi_tesvik_tip_pr%ROWTYPE;
 --
 Function BirKrdTurKnl(p_krd_tur_kod      bir_krd_tur_knl.krd_tur_kod%Type,
                       p_krd_tur_alt_kod  bir_krd_tur_knl.krd_tur_alt_kod%Type,
                       p_krd_tur_alt_kod2 bir_krd_tur_knl.krd_tur_alt_kod2%type,
                       p_kanal_kod        bir_krd_tur_knl.kanal_kod%Type,
                       p_doviz_kod        bir_krd_tur_knl.doviz_kod%Type) return bir_krd_tur_knl%rowtype;
 --
  Function BirOdmTipPr (pkod In Number)  Return Bir_Odm_Tip_Pr%ROWTYPE;
 --
  Function BirKullandirim (p_basvuruno In Number)  Return Bir_Kullandirim%ROWTYPE;
 --
  Function BirKrdTaksit (pn_basvuruno In Number,pn_sirano Number)  Return Bir_Kredi_Taksit%ROWTYPE;
 --
  Function BirKrdTaksitAraOdemeLog (pn_basvuruno In Number,pn_sirano Number,pn_araodemeno Number)  Return Bir_Kredi_Taksit_Ara_Odeme_Log%ROWTYPE;
 --
  Function TeminatKod(pc_kod In V_Ml_Tem_Teminat_Kodlari_Pr.Kod%Type) Return V_Ml_Tem_Teminat_Kodlari_Pr%RowType;
 --
  Function TeminatAltKod(pc_kod In v_Ml_Tem_Tem_Alt_Kodlari_Pr.Kod%Type, pc_altkod In v_Ml_Tem_Tem_Alt_Kodlari_Pr.ALT_KOD%Type) Return v_Ml_Tem_Tem_Alt_Kodlari_Pr%RowType;
 --
  Function DokumanKod(pn_kod In v_ml_gnl_dokuman_kod_pr.Kod%Type) Return v_ml_gnl_dokuman_kod_pr%RowType;
 --
-- Function BirKrediBasvuru(pn_basvuruno In Bir_Kredi_Basvuru.Basvuru_No%Type) Return Bir_Kredi_Basvuru%RowType;
 --
 Function BirBasvuru(pn_basvuruno In Bir_Basvuru.Basvuru_No%Type) Return Bir_Basvuru%RowType;
 --
 Function GnlTelAlanKod(pc_ilkod In GNL_TEL_ALAN_KOD_PR.IL_KOD%Type) Return GNL_TEL_ALAN_KOD_PR%RowType;
 --
 Function KmhTanim( pn_kmh_sira_no In kmh_tanim.kmh_sira_no%Type) Return kmh_tanim%RowType;
 --
 Function GnlCekDurumKod(pc_kod In GNL_CEK_DURUM_KOD_PR.KOD%Type) Return GNL_CEK_DURUM_KOD_PR%RowType ;
 --
 Function BirKampanya(pn_kod BIR_KAMPANYA.kod%type) return BIR_KAMPANYA%rowtype;
--
 Function BirKampKnl(pn_kod BIR_KAMP_KNL.Kod%type ) return BIR_KAMP_KNL%rowtype;
--
 Function GnlBankaSubeKodPr(pc_bankakod GNL_BANKA_SUBE_KOD_PR.BANKA_KOD%type,pc_subekod GNL_BANKA_SUBE_KOD_PR.Sube_Kod%type )
          return GNL_BANKA_SUBE_KOD_PR%rowtype;
--
 Function KreTeklif(pn_teklifno KRE_TEKLIF.Teklif_No%TYPE) Return KRE_TEKLIF%RowType;
--
 Function KreUrunGrupPr(pn_kod KRE_URUN_GRUP_PR.KOD%TYPE, pb_Kes Boolean Default TRUE) Return KRE_URUN_GRUP_PR%RowType;
--
 Function KreMusLimit(pn_musteri_no KRE_MUSTERI_LIMIT.MUSTERI_NO%TYPE, pb_Kes Boolean Default TRUE) Return KRE_MUSTERI_LIMIT%RowType;
--
 Function FonTanim(pc_fonKod fon_tanim.kod%TYPE) Return fon_tanim%RowType;
--
END;
/
CREATE OR REPLACE PACKAGE BODY PKG_TABLO IS

 Function adres_kod(p_kod v_ml_gnl_adres_kod_pr.kod%type) return v_ml_gnl_adres_kod_pr%rowtype is
  r v_ml_gnl_adres_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_adres_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_ADRES_KOD_PR',p_kod);    
 end;


 Function bloke_durum_kod(p_kod v_ml_gnl_bloke_durum_kod_pr.kod%type) return v_ml_gnl_bloke_durum_kod_pr%rowtype is
  r v_ml_gnl_bloke_durum_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_bloke_durum_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_BLOKE_DURUM_KOD_PR',p_kod);    
    
 end;


 Function bloke_sebep_kod(p_kod v_ml_gnl_bloke_sebep_kod_pr.kod%type) return v_ml_gnl_bloke_sebep_kod_pr%rowtype is
  r v_ml_gnl_bloke_sebep_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_bloke_sebep_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_BLOKE_SEBEP_KOD_PR',p_kod);    
    
 end;


 Function bolum_kod(p_kod v_ml_gnl_bolum_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_bolum_kod_pr%rowtype is
  r v_ml_gnl_bolum_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_bolum_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_BOLUM_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end bolum_kod;


 Function cinsiyet_kod(p_kod v_ml_gnl_cinsiyet_kod_pr.kod%type) return v_ml_gnl_cinsiyet_kod_pr%rowtype is
  r v_ml_gnl_cinsiyet_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_cinsiyet_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_CINSIYET_KOD_PR',p_kod);    
    
 end;
 

 Function dealer_kod(p_kod v_ml_gnl_dealer_kod_pr.kod%type) return v_ml_gnl_dealer_kod_pr%rowtype is
  r v_ml_gnl_dealer_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_dealer_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_DEALER_KOD_PR',p_kod);    
    
 end;


 Function dil_kod(p_kod v_ml_gnl_dil_kod_pr.kod%type) return v_ml_gnl_dil_kod_pr%rowtype is
  r v_ml_gnl_dil_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_dil_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_DIL_KOD_PR',p_kod);    
    
 end;


 Function doviz_kod(p_kod v_ml_gnl_doviz_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_doviz_kod_pr%rowtype is
  r v_ml_gnl_doviz_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_doviz_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_DOVIZ_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end doviz_kod;


 Function egitim_kod(p_kod v_ml_gnl_egitim_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_egitim_kod_pr%rowtype is
  r v_ml_gnl_egitim_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_egitim_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_EGITIM_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end egitim_kod;


 Function istatistik_kod(p_kod v_ml_gnl_istatistik_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_istatistik_kod_pr%rowtype is
  r v_ml_gnl_istatistik_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_istatistik_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_ISTATISTIK_KOD_PR',p_kod);    
   else
      return NULL;
   end if;      
 end istatistik_kod;

 -----------------------
 Function kanal_kod(p_kod v_ml_gnl_kanal_grup_kod_pr.kod%type) return v_ml_gnl_kanal_grup_kod_pr%rowtype is
  r v_ml_gnl_kanal_grup_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_kanal_grup_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_KANAL_GRUP_KOD_PR',p_kod);    
 end;

 Function kanal_Alt_kod(p_kod     v_kanal_alt_kod_pr.KANAL_kod%type ,
                        p_alt_kod v_kanal_alt_kod_pr.KOD%type) return v_kanal_alt_kod_pr%rowtype is
  r v_kanal_alt_kod_pr%rowtype;
 begin
    select *
    into r
    from v_kanal_alt_kod_pr t
    where t.KANAL_KOD =p_kod
      And t.KOD        =p_alt_kod ;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'v_kanal_alt_kod_pr',p_kod||'-'||p_alt_kod);    
 end;

-----------------
 Function kimlik_kod(p_kod v_ml_gnl_kimlik_kod_pr.kod%type) return v_ml_gnl_kimlik_kod_pr%rowtype is
  r v_ml_gnl_kimlik_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_kimlik_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_KIMLIK_KOD_PR',p_kod);    
 end;
--
 Function kullanici (p_kod gnl_kullanici.kod%type) return gnl_kullanici%rowtype is
  r gnl_kullanici%rowtype;
 begin
    select *
    into r
    from gnl_kullanici t
    where t.kod=p_kod;

    return r;
    
 exception when others then 
    pkg_hata.hata_yaz(2,true,'GNL_KULLANICI',p_kod);    
 end;


 Function kullanici_gorev_kod(p_kod v_ml_gnl_kul_gorev_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_kul_gorev_kod_pr%rowtype is
  r v_ml_gnl_kul_gorev_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_kul_gorev_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_Kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_KUL_GOREV_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end kullanici_gorev_kod;


 Function meslek_kod(p_kod v_ml_gnl_meslek_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_meslek_kod_pr%rowtype is
  r v_ml_gnl_meslek_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_meslek_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_MESLEK_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end meslek_kod;


 Function unvan_kod(p_kod v_ml_gnl_unvan_kod_pr.kod%type, pb_Kes Boolean Default TRUE) return v_ml_gnl_unvan_kod_pr%rowtype is
  r v_ml_gnl_unvan_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_unvan_kod_pr t
    where t.kod=p_kod;

    return r;
    
 exception when others then
   if pb_kes then
      pkg_hata.hata_yaz(2,true,'V_ML_GNL_UNVAN_KOD_PR',p_kod);    
   else
      return null;
   end if;      
 end unvan_kod;


 Function uyruk_kod(p_kod v_ml_gnl_uyruk_kod_pr.kod%type) return v_ml_gnl_uyruk_kod_pr%rowtype is
  r v_ml_gnl_uyruk_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_uyruk_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_UYRUK_KOD_PR',p_kod);    
 end;


 Function hesap_plani_tanim(p_hesap_no muh_hp_tanim.HESAP_NO%type) return muh_hp_tanim%rowtype is
  r muh_hp_tanim%rowtype;
 begin
    select *
    into r
    from muh_hp_tanim t
    where t.hesap_no =p_hesap_no;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'MUH_HP_TANIM',p_hesap_no);    
 end; 


 Function bankamiz_bilgi return gnl_bankamiz_bilgi_pr%rowtype is
  r gnl_bankamiz_bilgi_pr%rowtype;
 begin
    select *
    into r
    from gnl_bankamiz_bilgi_pr;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_BANKAMIZ_BILGI_PR');    
 end; 


 Function il_kod(p_kod gnl_il_kod_pr.kod%type) return gnl_il_kod_pr%rowtype is
  r gnl_il_kod_pr%rowtype;
 begin
    select *
    into r
    from gnl_il_kod_pr t
    where t.kod =p_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_IL_KOD_PR',p_kod);    
 end; 
 
 
 Function ilce_kod(p_il_kod gnl_ilce_kod_pr.il_kod%type, p_ilce_kod gnl_ilce_kod_pr.ilce_kod%type ) return gnl_ilce_kod_pr%rowtype is
  r gnl_ilce_kod_pr%rowtype;
 begin
    select *
    into r
    from gnl_ilce_kod_pr t
    where t.il_kod =p_il_kod
    and t.ilce_kod =p_ilce_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_ILCE_KOD_PR', p_il_kod||','||p_ilce_kod);    
 end; 
 

 Function sube_kod(p_kod gnl_sube_kod_pr.kod%type) return gnl_sube_kod_pr%rowtype is
  r gnl_sube_kod_pr%rowtype;
 begin
    select *
    into r
    from gnl_sube_kod_pr t
    where t.kod =p_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_SUBE_KOD_PR',p_kod);    
 end; 


 Function ulke_kod(p_kod gnl_ulke_kod_pr.kod%type) return gnl_ulke_kod_pr%rowtype is
  r gnl_ulke_kod_pr%rowtype;
 begin
    select *
    into r
    from gnl_ulke_kod_pr t
    where t.kod =p_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_ULKE_KOD_PR',p_kod);    
 end; 
 
 
 Function vergi_daire_kod(p_il_kod gnl_vergi_daire_kod_pr.il_kod%type, p_vergi_d_kod gnl_vergi_daire_kod_pr.vergi_d_kod%type) return gnl_vergi_daire_kod_pr%rowtype is
  r gnl_vergi_daire_kod_pr%rowtype;
 begin
    select *
    into r
    from gnl_vergi_daire_kod_pr t
    where t.il_kod =p_il_kod
    and t.vergi_d_kod=p_vergi_d_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_VERGI_DAIRE_KOD_PR',p_il_kod||','||p_vergi_d_kod);    
 end; 
  


 Function musteri_kayit(p_musteri_no gnl_musteri.MUSTERI_NO%type) return gnl_musteri%rowtype is
  r gnl_musteri%rowtype;
 begin
    select *
    into r
    from gnl_musteri t
    where t.MUSTERI_NO =p_musteri_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MUSTERI',p_musteri_no);    
 end;


 Function musteri_adres_kayit(p_musteri_no gnl_musteri_adres.MUSTERI_NO%type, p_adres_kod gnl_musteri_adres.adres_kod%type) return gnl_musteri_adres%rowtype is
  r gnl_musteri_adres%rowtype;
 begin
    select *
    into r
    from gnl_musteri_adres t
    where t.MUSTERI_NO =p_musteri_no
    and t.adres_kod=p_adres_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MUSTERI_ADRES',p_musteri_no||','||p_adres_kod);    
 end;
  
 
 Function musteri_kimlik_kayit(p_musteri_no gnl_musteri_kimlik.MUSTERI_NO%type) return gnl_musteri_kimlik%rowtype is
  r gnl_musteri_kimlik%rowtype;
 begin
    select *
    into r
    from gnl_musteri_kimlik t
    where t.MUSTERI_NO =p_musteri_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MUSTERI_KIMLIK',p_musteri_no);    
 end;
 
 Function musteri_veli_kayit(p_musteri_no gnl_musteri_velivasi.MUSTERI_NO%type) return gnl_musteri_velivasi%rowtype is
  r gnl_musteri_velivasi%rowtype;
 begin
    select *
    into r
    from gnl_musteri_velivasi t
    where t.veli_musteri_no =p_musteri_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MUSTERI_VELIVASI',p_musteri_no);    
 end;

 
 Function sistem_bilgi(p_kod GNL_SISTEM_BILGI_PR.KOD%type) return GNL_SISTEM_BILGI_PR%rowtype is
  r GNL_SISTEM_BILGI_PR%rowtype;
 begin
    select *
    into r
    from GNL_SISTEM_BILGI_PR t
    where t.kod =p_kod;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_SISTEM_BILGI_PR',p_kod);    
 end;   


 Function hesap_kayit(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap%rowtype is
  r muh_hesap%rowtype;
 begin
    select *
    into r
    from muh_hesap t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'MUH_HESAP',p_hesap_no);    
 end hesap_kayit;
 
 Function hesap_kayit_vadeli(p_hesap_no muh_hesap.hesap_no%type) return muh_hesap_vadeli%rowtype is
  r muh_hesap_vadeli%rowtype;
 begin
    select *
    into r
    from muh_hesap_vadeli t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'MUH_HESAP_VADELI',p_hesap_no);    
 end hesap_kayit_vadeli;
 
 Function hesap_kayit_izleme(p_hesap_no muh_hesap.hesap_no%type) return v_muh_hesap_izleme_tum%rowtype is
  r v_muh_hesap_izleme_tum%rowtype;
 begin
    select *
    into r
    from v_muh_hesap_izleme_tum t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'V_MUH_HESAP_IZLEME_TUM',p_hesap_no);    
 end hesap_kayit_izleme;
 
 Function hesap_kayit_izleme_kisitli(p_hesap_no muh_hesap.hesap_no%type) return v_muh_hesap_izleme%rowtype is
  r v_muh_hesap_izleme%rowtype;
 begin
    select *
    into r
    from v_muh_hesap_izleme t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'V_MUH_HESAP_IZLEME',p_hesap_no);    
 end hesap_kayit_izleme_kisitli;

 Function hesap_tanim_kayit(p_hesap_no muh_hesap_tanim.hesap_no%type, pb_Kes Boolean Default TRUE) return muh_hesap_tanim%rowtype is
  r muh_hesap_tanim%rowtype;
 begin
    select *
    into r
    from muh_hesap_tanim t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    If pb_Kes Then
      pkg_hata.hata_yaz(2,true,'MUH_HESAP_TANIM',p_hesap_no);    
    Else
      Return Null;
    End If;
 end;
 
 Function hesap_bakiye_kayit(p_hesap_no muh_hesap_bakiye.hesap_no%type) return muh_hesap_bakiye%rowtype is
  r muh_hesap_bakiye%rowtype;
 begin
    select *
    into r
    from muh_hesap_bakiye t
    where t.hesap_no =p_hesap_no;

    return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'MUH_HESAP_BAKIYE',p_hesap_no);    
 end;

-----------------------------------

 Function ekstre_siklik_kod(p_kod v_ml_gnl_ekstre_siklik_kod_pr.kod%type) return v_ml_gnl_ekstre_siklik_kod_pr%rowtype is
  r v_ml_gnl_ekstre_siklik_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_ekstre_siklik_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_EKSTRE_SIKLIK_KOD_PR',p_kod);    
 end;


 Function ekstre_tur_kod(p_kod v_ml_gnl_ekstre_tur_kod_pr.kod%type) return v_ml_gnl_ekstre_tur_kod_pr%rowtype is
  r v_ml_gnl_ekstre_tur_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_ekstre_tur_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_EKSTRE_TUR_KOD_PR',p_kod);    
 end;

 Function must_kategori_kod(p_kod v_ml_gnl_must_kategori_kod_pr.kod%type) return v_ml_gnl_must_kategori_kod_pr%rowtype is
  r v_ml_gnl_must_kategori_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_must_kategori_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_MUST_KATEGORI_KOD_PR',p_kod);    
 end;
 
 Function musteri_tur_kod(p_kod v_ml_gnl_must_tur_kod_pr.kod%type) return v_ml_gnl_must_tur_kod_pr%rowtype is
  r v_ml_gnl_must_tur_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_must_tur_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_MUST_TUR_KOD_PR',p_kod);    
 end; 

 Function sektor_kod(p_kod v_ml_gnl_sektor_kod_pr.kod%type) return v_ml_gnl_sektor_kod_pr%rowtype is
  r v_ml_gnl_sektor_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_sektor_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_SEKTOR_KOD_PR',p_kod);    
 end; 

 Function sektor_kod1(p_sektor_kod v_ml_gnl_sektor_kod1_pr.sektor_kod%type, 
                      p_sektor_kod1 v_ml_gnl_sektor_kod1_pr.sektor_kod1%type) return v_ml_gnl_sektor_kod1_pr%rowtype is
  r v_ml_gnl_sektor_kod1_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_sektor_kod1_pr t
    where t.SEKTOR_KOD=p_sektor_kod
    and t.SEKTOR_KOD1=p_sektor_kod1;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_SEKTOR_KOD1_PR',p_sektor_kod||','||p_sektor_kod1);    
 end; 

 Function sektor_kod2(p_sektor_kod v_ml_gnl_sektor_kod2_pr.sektor_kod%type, 
                      p_sektor_kod1 v_ml_gnl_sektor_kod2_pr.sektor_kod1%type,
                      p_sektor_kod2 v_ml_gnl_sektor_kod2_pr.sektor_kod2%type) return v_ml_gnl_sektor_kod2_pr%rowtype is
  r v_ml_gnl_sektor_kod2_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_sektor_kod2_pr t
    where t.SEKTOR_KOD=p_sektor_kod
    and t.SEKTOR_KOD1=p_sektor_kod1
    and t.SEKTOR_KOD2=p_sektor_kod2;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_SEKTOR_KOD2_PR',p_sektor_kod||','||p_sektor_kod1||','||p_sektor_kod1);    
 end; 

 Function sozlesme_alt_kod(p_SOZLESME_KOD v_ml_gnl_sozlesme_alt_kod_pr.SOZLESME_KOD%type, 
                      p_SOZLESME_ALT_KOD v_ml_gnl_sozlesme_alt_kod_pr.SOZLESME_ALT_KOD%type) return v_ml_gnl_sozlesme_alt_kod_pr%rowtype is
  r v_ml_gnl_sozlesme_alt_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_sozlesme_alt_kod_pr t
    where t.SOZLESME_KOD=p_SOZLESME_KOD
    and t.SOZLESME_ALT_KOD=p_SOZLESME_ALT_KOD;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_SOZLESME_ALT_KOD_PR',p_SOZLESME_KOD||','||p_SOZLESME_ALT_KOD);    
 end; 

 Function sozlesme_kod(p_kod v_ml_gnl_sozlesme_kod_pr.kod%type) return v_ml_gnl_sozlesme_kod_pr%rowtype is
  r v_ml_gnl_sozlesme_kod_pr%rowtype;
 begin
    select *
    into r
    from v_ml_gnl_sozlesme_kod_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_SOZLESME_KOD_PR',p_kod);    
 end;   


 Function muh_islem_tablo(p_numara MUH_ISLEM.numara%type) return MUH_ISLEM%rowtype is
  r MUH_ISLEM%rowtype;
 begin
    select *
    into r
    from MUH_ISLEM t
    where t.numara=p_numara;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'MUH_ISLEM',p_numara);    
 end;   

 
 
 Function muh_islem_tanim_tablo(p_kod v_ml_muh_islem_tanim_pr.kod%type) return v_ml_muh_islem_tanim_pr%rowtype is
  r v_ml_muh_islem_tanim_pr%rowtype;
 begin
    select *
    into r
    from v_ml_muh_islem_tanim_pr t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_MUH_ISLEM_TANIM_PR',p_kod);    
 end;   
 

 Function kasa_kod( p_sube_kod v_ml_gnl_kasa_kodlari_pr.sube_kodu%type, p_kasa_kod v_ml_gnl_kasa_kodlari_pr.KOD%type) return v_ml_gnl_kasa_kodlari_pr%rowtype is
 r v_ml_gnl_kasa_kodlari_pr%rowtype;

 begin
 
    select *
    into r
    from v_ml_gnl_kasa_kodlari_pr t
    where t.SUBE_KODU=p_sube_kod
    and t.KOD=p_kasa_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_KASA_KODLARI_PR',p_sube_kod||p_kasa_kod);    
 
 end;
  
 Function kasa_kupur_islem_kod_tablo(p_kod V_ML_GNL_KASA_KUPUR_ISL_KOD_PR.kod%type) return V_ML_GNL_KASA_KUPUR_ISL_KOD_PR%rowtype is
  r V_ML_GNL_KASA_KUPUR_ISL_KOD_PR%rowtype;
 begin
    select *
    into r
    from V_ML_GNL_KASA_KUPUR_ISL_KOD_PR t
    where t.kod=p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_KASA_KUPUR_ISL_KOD_PR',p_kod);    
 end;   
 
--
 Function MasKom_FAIZGelTip(p_kod  v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr.KOD%type) return v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr%rowtype is
  r v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr%rowtype;
 begin
    select *
    into r
    from v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr t
    where t.KOD =p_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'v_Ml_Gnl_Mas_Kom_Faiz_Tip_Pr',p_kod);    
 end; 
--


 Function modul_urun_sinif(p_modul gnl_modul_urun_sinif_kod_pr.modul_tur_kod%type, p_urun gnl_modul_urun_sinif_kod_pr.urun_tur_kod%type, p_urun_sinif gnl_modul_urun_sinif_kod_pr.kod%type) return v_Ml_Modul_Urun_Sinif_Kod_Pr%rowtype is
  r v_Ml_Modul_Urun_Sinif_Kod_Pr%rowtype;
 begin
    select *
    into r
    from v_Ml_Modul_Urun_Sinif_Kod_Pr t
    where t.modul_tur_kod=p_modul
    and t.urun_tur_kod=p_urun
    and t.kod=p_urun_sinif;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_MODUL_URUN_SINIF_KOD_PR',p_modul||'-'||p_urun||'-'||p_urun_sinif);    
 end;   

--
 Function musteri_grup_kod_kayit( p_musteri_grup_kod V_ML_GNL_MUSTERI_GRUP_KOD_PR.KOD %type) return V_ML_GNL_MUSTERI_GRUP_KOD_PR%rowtype is
  r V_ML_GNL_MUSTERI_GRUP_KOD_PR%rowtype;

 begin
 
    select *
    into r
    from V_ML_GNL_MUSTERI_GRUP_KOD_PR t
    where t.KOD=p_musteri_grup_kod;

    return r;
    
   exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_MUSTERI_GRUP_KOD_PR',p_musteri_grup_kod);    
 
 end;
--
 Function maas_izleyecek_personel( p_personel_no MAAS_HESAPIZLE.PERSONEL_NO %type) return MAAS_HESAPIZLE%rowtype is
  r MAAS_HESAPIZLE%rowtype;

 begin
    select *
    into r
    from MAAS_HESAPIZLE t
    where t.personel_no = p_personel_no;
    return r;
   exception when others then
    pkg_hata.hata_yaz(2,true,'MAAS_HESAP_IZLE',p_personel_no);    
 end;
--
 Function Personel( p_personel_no GNL_PERSONEL.PERSONEL_NUMARA%type) return GNL_PERSONEL%rowtype is
  r GNL_PERSONEL%rowtype;

 begin
    select *
    into r
    from GNL_PERSONEL t
    where t.personel_numara = p_personel_no;
    return r;
   exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_PERSONEL',p_personel_no);    
 end;
--
 Function BirKrdTur(p_kod v_ml_bir_krd_tur.kod%type) return v_ml_bir_krd_tur%rowtype is
  r v_ml_bir_krd_tur%rowtype;
 begin
   select *
     into r
     from v_ml_bir_krd_tur t
    where t.kod = p_kod;

   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KRD_TUR',p_kod);    
 end; 
--
 Function BirKrdAltTur(p_krd_tur_kod v_ml_bir_krd_alt_tur.krd_tur_kod%Type,
                       p_kod         v_ml_bir_krd_alt_tur.kod%type) return v_ml_bir_krd_alt_tur%rowtype is
  r v_ml_bir_krd_alt_tur%rowtype;
 begin
   select *
     into r
     from v_ml_bir_krd_alt_tur t
    where t.krd_tur_kod = p_krd_tur_kod
      And t.kod = p_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KRD_ALT_TUR',p_krd_tur_kod, p_kod);    
 end;
--
 Function BirKrdAltTur2(p_krd_tur_kod     v_ml_bir_krd_alt_tur2.krd_tur_kod%Type,
                        p_krd_tur_alt_kod v_ml_bir_krd_alt_tur2.krd_tur_alt_kod%Type,
                        p_kod             v_ml_bir_krd_alt_tur2.kod%type) return v_ml_bir_krd_alt_tur2%rowtype is
  r v_ml_bir_krd_alt_tur2%rowtype;
 begin
   select *
     into r
     from v_ml_bir_krd_alt_tur2 t
    where t.krd_tur_kod     = p_krd_tur_kod
      And t.krd_tur_alt_kod = p_krd_tur_alt_kod
      And t.kod             = p_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KRD_ALT_TUR2',p_krd_tur_kod, p_krd_tur_alt_kod, p_kod);    
 end; 
--
 Function Birodmgrppr(p_kod v_ml_bir_odm_grp_pr.kod%type) return v_ml_bir_odm_grp_pr%rowtype is
  r v_ml_bir_odm_grp_pr%rowtype;
 begin
   select *
     into r
     from v_ml_bir_odm_grp_pr t
    where t.kod             = p_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_ODM_GRP_PR',p_kod);    
 end; 
----

 Function GrupKodlari(p_kod v_ml_gnl_grup_kodlari.kod%type) return v_ml_gnl_grup_kodlari%rowtype is
  r v_ml_gnl_grup_kodlari%rowtype;
 begin
   select *
     into r
     from v_ml_gnl_grup_kodlari t
    where t.kod             = p_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_GRUP_KODLARI',p_kod);    
 end;  
--
 Function BazFaizOran(pn_krdturkod Number, pn_krdturaltkod Number, pc_dov Varchar2) Return bir_faiz_baz_oran_pr%ROWTYPE Is
 r bir_faiz_baz_oran_pr%rowtype;
 begin
   select *
     into r
     from bir_faiz_baz_oran_pr t
    where t.krd_tur_kod     = pn_krdturkod
      And t.krd_tur_alt_kod = pn_krdturaltkod
      And t.doviz_kod       = pc_dov
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_FAIZ_BAZ_ORAN_PR',pn_krdturkod||'-'||pn_krdturaltkod||'-'||pc_dov);    
 end;   
--
 Function FaizOran(pn_krdturkod Number, pn_krdturaltkod Number, pn_krdturaltkod2 Number, pc_dov Varchar2, pc_kanal Varchar2) Return bir_faiz_oran_pr%ROWTYPE Is
 r bir_faiz_oran_pr%rowtype;
 begin
   select *
     into r
     from bir_faiz_oran_pr t
    where t.krd_tur_kod     = pn_krdturkod
      And t.krd_tur_alt_kod = pn_krdturaltkod
      And t.krd_tur_alt_kod2= pn_krdturaltkod2      
      And t.doviz_kod       = pc_dov
      And t.kanal_kod       = pc_kanal
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_FAIZ_ORAN_PR',pn_krdturkod||'-'||pn_krdturaltkod||'-'||pn_krdturaltkod2||'-'||pc_dov);    
 end; 
--
 Function BirTemTanim(pn_krd_tur_kod Number, pn_krd_tur_alt_kod Number, pn_krd_tur_alt_kod2 Number, 
                      pn_kanal_kod Number, pc_dov Varchar2, pn_tem_kod Number) Return bir_tem_tanim%ROWTYPE Is
 r bir_tem_tanim%rowtype;
 begin
   select *
     into r
     from BIR_TEM_TANIM t
    where t.krd_tur_kod     = pn_krd_tur_kod
      And t.krd_tur_alt_kod = pn_krd_tur_alt_kod
      And t.krd_tur_alt_kod2= pn_krd_tur_alt_kod2
      And t.kanal_kod       = pn_kanal_kod
      And t.doviz_kod       = pc_dov
      And t.teminat_kod     = pn_tem_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_TEM_TANIM',pn_krd_tur_kod||'-'||pn_krd_tur_alt_kod||'-'||pn_krd_tur_alt_kod2||'-'||
                              pn_kanal_kod||'-'|| pc_dov ||'-'||pn_tem_kod);    
 end;   
----
 Function ParamText(pkod In Varchar2, pkey1 In Varchar2, pkey2 In Varchar2 Default Null, pkey3 In Varchar2 Default Null) 
                    Return V_ML_GNL_PARAM_TEXT%ROWTYPE Is
 r V_ML_GNL_PARAM_TEXT%ROWTYPE;
 Begin
   Select *
     Into r
     From V_ML_GNL_PARAM_TEXT t
    Where t.kod  = upper(pkod)
      And t.KEY1 = pkey1
      And ( pkey2 Is Null Or t.Key2 = pkey2 )
      And ( pkey3 Is Null Or t.Key3 = pkey3 )
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_PARAM_TEXT',pkod||'-'||pkey1||'-'||pkey2||'-'||pkey3);    
   
 End;
----
 Function KMH_Faiz_oranF (pkod In Number)  Return kmh_faiz_oran%ROWTYPE Is
 r kmh_faiz_oran%ROWTYPE;
 Begin
   Select *
     Into r
     From kmh_faiz_oran t
    Where t.kmh_tur_kod = pKod
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'KMH_FAIZ_ORAN',pkod);       
 End; 
----
 Function BirSatici (pkod In Number, pb_Kes Boolean Default TRUE)  Return Bir_Satici%ROWTYPE Is
 r Bir_Satici%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Satici t
    Where t.kod = pKod
   ;
   Return r;
  exception when others then
    If pb_kes Then
      pkg_hata.hata_yaz(2,true,'BIR_SATICI',pkod);       
    Else 
      Return NULL;
    End If;
 End; 
----
 Function BirSaticiCalisan (pkod In Number, pb_Kes Boolean Default TRUE)  Return Bir_Satici_Calisan%ROWTYPE Is
 r Bir_Satici_Calisan%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Satici_Calisan t
    Where t.kod = pKod
   ;
   Return r;
  exception when others then
    If pb_kes Then
      pkg_hata.hata_yaz(2,true,'BIR_SATICI_CALISAN',pkod);       
    Else 
      Return NULL;
    End If;
 End;  
----
 Function BirSaticiIliski (pn_saticikod In Number, pn_satBagliKod In Number)  Return Bir_Satici_Iliski%ROWTYPE Is
 r Bir_Satici_Iliski%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Satici_Iliski t
    Where t.satici_kod        = pn_saticikod
      And t.bagli_old_sat_kod = pn_satBagliKod 
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_SATICI_ILISKI',pn_saticikod||'-'||pn_satBagliKod);      
 End; 
----
 Function BirSaticiTahsis (pn_saticikod In Bir_Satici_Tahsis.Kod%Type, pb_raise Boolean Default TRUE)  Return Bir_Satici_Tahsis%ROWTYPE Is
 r Bir_Satici_Tahsis%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Satici_Tahsis t
    Where t.kod        = pn_saticikod
   ;
   Return r;
 Exception when No_Data_Found then
   If pb_raise then
     pkg_hata.hata_yaz(2,TRUE,'BIR_SATICI_TAHSIS');
   Else
     Return r;
   End If;
 End;
----
Function AdkSaticiTanim (pn_saticikod In adk_stand_tanim.Kod%Type, pb_raise Boolean Default TRUE)  Return adk_stand_tanim%ROWTYPE Is
 r adk_stand_tanim%ROWTYPE;
 Begin
   Select *
     Into r
     From adk_stand_tanim t
    Where t.kod        = pn_saticikod
   ;
   Return r;
 Exception when No_Data_Found then
   If pb_raise then
     pkg_hata.hata_yaz(2,TRUE,'ADK_SATICI_TANIM');
   Else
     Return r;
   End If;
 End;
----
 Function firma_detay(p_musteri_no gnl_firmadetay_bilgi.MUSTERI_NO%type) return gnl_firmadetay_bilgi%ROWTYPE IS
    r gnl_firmadetay_bilgi%ROWTYPE;
 BEGIN
    Select *
      Into r
      From gnl_firmadetay_bilgi b
     where b.musteri_no = p_musteri_no;
     
     Return r; 
 Exception when no_data_found then
    Return r;
 END firma_detay;   
----
 Function TesvikTip(p_kod v_ml_bir_bayi_tesvik_tip_pr.kod%type) return v_ml_bir_bayi_tesvik_tip_pr%ROWTYPE IS
    r v_ml_bir_bayi_tesvik_tip_pr%ROWTYPE;
 BEGIN
    Select *
      Into r
      From v_ml_bir_bayi_tesvik_tip_pr b
     where b.KOD = p_kod;
     
     Return r; 
 Exception when no_data_found then
    Return r;
 END;
---
 Function BirKrdTurKnl(p_krd_tur_kod      bir_krd_tur_knl.krd_tur_kod%Type,
                       p_krd_tur_alt_kod  bir_krd_tur_knl.krd_tur_alt_kod%Type,
                       p_krd_tur_alt_kod2 bir_krd_tur_knl.krd_tur_alt_kod2%type,
                       p_kanal_kod        bir_krd_tur_knl.kanal_kod%Type,
                       p_doviz_kod        bir_krd_tur_knl.doviz_kod%Type) return bir_krd_tur_knl%rowtype is
  r bir_krd_tur_knl%rowtype;
 begin
   select *
     into r
     from bir_krd_tur_knl t
    where t.krd_tur_kod      = p_krd_tur_kod
      And t.krd_tur_alt_kod  = p_krd_tur_alt_kod
      And t.krd_tur_alt_kod2 = p_krd_tur_alt_kod2
      And t.kanal_kod        = p_kanal_kod
      And t.doviz_kod        = p_doviz_kod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KRD_TUR_KNL',p_krd_tur_kod, p_krd_tur_alt_kod, p_krd_tur_alt_kod2||'-'|| p_kanal_kod||'-'||p_doviz_kod);    
 end;
--
 Function BirOdmTipPr (pkod In Number)  Return Bir_Odm_Tip_Pr%ROWTYPE Is
 r bir_odm_tip_pr%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Odm_Tip_Pr t
    Where t.kod = pKod
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_ODM_TIP_PR',pkod);       
 End; 
--
 Function BirKullandirim (p_basvuruno In Number)  Return Bir_Kullandirim%ROWTYPE Is
 r bir_kullandirim%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Kullandirim t
    Where t.basvuru_no = p_basvuruno;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KULLANDIRIM',p_basvuruno );       
 End; 
--
 Function BirKrdTaksit (pn_basvuruno In Number,pn_sirano Number)  Return Bir_Kredi_Taksit%ROWTYPE Is
 r Bir_Kredi_Taksit%ROWTYPE;
 Begin
   Select *
     Into r
     From Bir_Kredi_Taksit t
    Where t.basvuru_no   = pn_basvuruno
      And t.sira_no      = pn_sirano;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KREDI_TAKSIT',pn_basvuruno||'-'||pn_sirano);       
 End; 
--
 Function BirKrdTaksitAraOdemeLog (pn_basvuruno In Number,pn_sirano Number,pn_araodemeno Number)  Return Bir_Kredi_Taksit_Ara_Odeme_Log%ROWTYPE Is
 r BIR_KREDI_TAKSIT_ARA_ODEME_LOG%ROWTYPE;
 Begin
   Select *
     Into r
     From BIR_KREDI_TAKSIT_ARA_ODEME_LOG t
    Where t.basvuru_no   = pn_basvuruno
      And t.sira_no      = pn_sirano
      And t.ara_odeme_no = pn_araodemeno;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KREDI_TAKSIT_ARA_ODEME_LOG',pn_basvuruno||'-'||pn_sirano||'-'||pn_araodemeno);    
 End;  
--
 Function TeminatKod(pc_kod In V_Ml_Tem_Teminat_Kodlari_Pr.Kod%Type) Return V_Ml_Tem_Teminat_Kodlari_Pr%RowType Is
 r V_Ml_Tem_Teminat_Kodlari_Pr%Rowtype;
 Begin 
   Select * 
     Into r
     From V_ML_TEM_TEMINAT_KODLARI_PR t
    Where t.kod = pc_kod
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_TEM_TEMINAT_KODLARI_PR', pc_kod);    
 End;
--
 Function TeminatAltKod(pc_kod In v_Ml_Tem_Tem_Alt_Kodlari_Pr.Kod%Type, 
                        pc_altkod In v_Ml_Tem_Tem_Alt_Kodlari_Pr.ALT_KOD%Type) Return v_Ml_Tem_Tem_Alt_Kodlari_Pr%RowType Is
 r v_Ml_Tem_Tem_Alt_Kodlari_Pr%Rowtype;
 Begin 
   Select * 
     Into r
     From V_ML_TEM_TEM_ALT_KODLARI_PR t
    Where t.kod = pc_kod
      And t.ALT_KOD = pc_altkod
   ;
   Return r;
  exception when others then
     Return r;
    --pkg_hata.hata_yaz(2,true,'V_ML_TEM_TEM_ALT_KODLARI_PR',pc_kod||'-'||pc_altkod);    
 End;
--
 Function DokumanKod(pn_kod In v_ml_gnl_dokuman_kod_pr.Kod%Type) Return v_ml_gnl_dokuman_kod_pr%RowType Is
 r v_ml_gnl_dokuman_kod_pr%Rowtype;
 Begin 
   Select * 
     Into r
     From V_ML_GNL_DOKUMAN_KOD_PR t
    Where t.kod = pn_kod
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'V_ML_GNL_DOKUMAN_KOD_PR',pn_kod);       
 End;
--
/*
 Function BirKrediBasvuru(pn_basvuruno In Bir_Kredi_Basvuru.Basvuru_No%Type) Return Bir_Kredi_Basvuru%RowType Is
 r Bir_Kredi_Basvuru%Rowtype;
 Begin --tablo kullanilmiyor
   Select * 
     Into r
     From Bir_Kredi_Basvuru t
    Where t.basvuru_no = pn_basvuruno
   ;
   Return r;   
 End; 
*/ 
 --
 Function BirBasvuru(pn_basvuruno In Bir_Basvuru.Basvuru_No%Type) Return Bir_Basvuru%RowType Is
 r Bir_Basvuru%Rowtype;
 Begin 
   Select * 
     Into r
     From BIR_BASVURU t
    Where t.basvuru_no = pn_basvuruno
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_BASVURU',pn_basvuruno);     
 End; 
-- 
 Function GnlTelAlanKod(pc_ilkod In GNL_TEL_ALAN_KOD_PR.IL_KOD%Type) Return GNL_TEL_ALAN_KOD_PR%RowType Is
 r GNL_TEL_ALAN_KOD_PR%Rowtype;
 Begin 
   Select * 
     Into r
     From GNL_TEL_ALAN_KOD_PR t
    Where t.il_kod =  lpad(pc_ilkod,3,'0')
   ;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_TEL_ALAN_KOD_PR',pc_ilkod);     
 End;  

--
 Function KmhTanim( pn_kmh_sira_no In kmh_tanim.kmh_sira_no%Type) Return kmh_tanim%RowType Is
 r kmh_tanim%Rowtype;
 Begin 
   Select * 
     Into r
     From KMH_TANIM t
    Where t.kmh_sira_no = pn_kmh_sira_no;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'KMH_TANIM',pn_kmh_sira_no);      
 End; 
-- 
 Function GnlCekDurumKod(pc_kod In GNL_CEK_DURUM_KOD_PR.KOD%Type) Return GNL_CEK_DURUM_KOD_PR%RowType Is
 r GNL_CEK_DURUM_KOD_PR%Rowtype;
 Begin 
   Select * 
     Into r
     From GNL_CEK_DURUM_KOD_PR t
    Where t.kod =  pc_kod;
   Return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_CEK_DURUM_KOD_PR',pc_kod);   
 End;  
--
 Function BirKampanya(pn_kod BIR_KAMPANYA.kod%type) return BIR_KAMPANYA%rowtype is
  r BIR_KAMPANYA%rowtype;
 begin
   select *
     into r
     from BIR_KAMPANYA t
    where t.kod = pn_kod;
   return r;    
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KAMPANYA',pn_kod);    
 end; 
--
 Function BirKampKnl(pn_kod BIR_KAMP_KNL.Kod%type ) return BIR_KAMP_KNL%rowtype is
  r BIR_KAMP_KNL%rowtype;
 begin
   select *
     into r
     from BIR_KAMP_KNL t
    where t.kod = pn_kod;
   return r;
  exception when others then
    pkg_hata.hata_yaz(2,true,'BIR_KAMP_KNL',pn_kod);    
 end; 
--
 Function GnlBankaSubeKodPr(pc_bankakod GNL_BANKA_SUBE_KOD_PR.BANKA_KOD%type,pc_subekod GNL_BANKA_SUBE_KOD_PR.Sube_Kod%type ) 
          return GNL_BANKA_SUBE_KOD_PR%rowtype is
  r GNL_BANKA_SUBE_KOD_PR%rowtype;
 begin
   select *
     into r
     from GNL_BANKA_SUBE_KOD_PR t
    where t.banka_kod = pc_bankakod
      and t.sube_kod  = pc_subekod
   ;
   return r;
    
  exception when others then
    pkg_hata.hata_yaz(2,true,'GNL_BANKA_SUBE_KOD_PR',pc_bankakod||'-'||pc_subekod);    
 end; 
--
 Function KreTeklif(pn_teklifno KRE_TEKLIF.Teklif_No%TYPE) Return KRE_TEKLIF%RowType Is
   Rec_KreTeklif KRE_TEKLIF%rowtype;
 Begin
   Select * Into Rec_KreTeklif
     From KRE_TEKLIF
    Where teklif_no = pn_teklifno
   ;
   Return Rec_KreTeklif;

  exception when others then
    pkg_hata.hata_yaz(2,true,'KRE_TEKLIF',pn_teklifno);    
 End;    
--
 Function KreUrunGrupPr(pn_kod KRE_URUN_GRUP_PR.KOD%TYPE, pb_Kes Boolean Default TRUE) Return KRE_URUN_GRUP_PR%RowType Is
   Rec KRE_URUN_GRUP_PR%rowtype;
 Begin
   Select * Into Rec
     From KRE_URUN_GRUP_PR
    Where kod = pn_kod
   ;
   Return Rec;

  exception when others then
    If pb_Kes Then
      pkg_hata.hata_yaz(2,true,'KRE_URUN_GRUP_PR',pn_kod);    
    Else
      Return Null;
    End If;
 End;    
--
 Function KreMusLimit(pn_musteri_no KRE_MUSTERI_LIMIT.MUSTERI_NO%TYPE, pb_Kes Boolean Default TRUE) Return KRE_MUSTERI_LIMIT%RowType Is
   Rec KRE_MUSTERI_LIMIT%rowtype;
 Begin
   Select * Into Rec
     From KRE_MUSTERI_LIMIT
    Where musteri_no = pn_musteri_no
   ;
   Return Rec;

  exception when others then
    If pb_Kes Then
      pkg_hata.hata_yaz(2,true,'KRE_MUSTERI_LIMIT',pn_musteri_no);    
    Else
      Return Null;
    End If;
 End;    
--
 Function FonTanim(pc_fonKod fon_tanim.kod%TYPE) Return fon_tanim%RowType Is
   Rec_FonTanim fon_tanim%rowtype;
 Begin
   Select * Into Rec_FonTanim
     From fon_tanim
    Where kod = pc_fonKod
   ;
   Return Rec_FonTanim;

  exception when others then
    pkg_hata.hata_yaz(2,true,'FON_TANIM',pc_fonKod);    
 End;
--
END;
/
