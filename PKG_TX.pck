CREATE OR REPLACE PACKAGE pkg_tx IS

  --*****************************************************************************
  --********     DURUM KODLARI  Muh_islem.Durum_kod alaninin statü kodlari
  --********
  --********   N .. Islem girildi Henuz yetki kontrolleri yapilmadi
  --********   C .. Islem girildi yetki kontrolleri yapildi (Giris durumu bu)
  --********   V .. Islem Dogrulandi
  --********   A .. Islem Onaylandi
  --********   P .. Islem Bitti , Tamamlandi
  --********   1 .. Islem Iptal edildi
  --********   2 .. Islem Iptali Onaylandi
  --********
  --********   D .. Islem Dogrulama Reddedildi  ( Dogrulama asamasinda Red )
  --********   R .. Islem Onaylama  Reddedildi  ( Onaylama  asamasinda Red )
  --********   3 .. Islem Iptal     Reddedildi  ( Iptal Onayi asamasinda Red )
  --******************************************************************************

  Type RC_REF is Ref Cursor;

  Function kalan_dogrulama_sayisi(p_islem_no muh_islem.numara%type)
    return number;
  Function kalan_onay_sayisi(p_islem_no muh_islem.numara%type) return number;
  Function kalan_iptal_onay_sayisi(p_islem_no muh_islem.numara%type)
    return number;
  Function Son_Aciklamayi_getir(p_islem_no muh_islem.numara%type)
    return varchar2;

  Function islem_no_al return number;

  Procedure Gecici_Islem_Yarat(pn_islem_numara   number,
                               pn_islem_kod      number,
                               pc_modul_tur_kod  varchar2,
                               pc_urun_tur_kod   varchar2,
                               pc_urun_sinif_kod varchar2,
                               pn_tutar          number,
                               pc_durum_kod      varchar2 default 'G',
                               pc_doviz_kod      varchar2 default null,
                               pn_musteri_numara number default null,
                               pc_hesap_numara   varchar2 default null,
                               pc_kasa_kod       varchar2 default null);

  Procedure Gecici_Islem_Sil(pn_islem_numara number);

  Procedure Islem_Yarat(pn_islem_numara   number,
                        pn_islem_kod      number,
                        pc_modul_tur_kod  varchar2,
                        pc_urun_tur_kod   varchar2,
                        pc_urun_sinif_kod varchar2,
                        pn_tutar          number,
                        pc_sube_kod       varchar2 default null,
                        pc_doviz_kod      varchar2 default null,
                        pn_musteri_numara number default null,
                        pc_hesap_numara   varchar2 default null,
                        pc_kasa_kod       varchar2 default null
                        /* cagrilan islem onaysiz olmasi isteniyorsa bu parametre E olarak set edilecek gelinmeli */,
                        pc_onaysiz_islem varchar2 default null
                        /* eger bu işlem bir başka işlemin ucunda otomatik oluşuyorsa bu parametre ile bu işlemi doguran işlemin numarası gecilmeli MHA */,
                        pn_cagiran_islem_numara number default null);

  Procedure Islem_Guncelle(pn_islem_numara   number,
                           pc_modul_tur_kod  varchar2,
                           pc_urun_tur_kod   varchar2,
                           pc_urun_sinif_kod varchar2,
                           pn_tutar          number,
                           pc_sube_kod       varchar2 default null,
                           pc_doviz_kod      varchar2 default null,
                           pn_musteri_numara number default null,
                           pc_hesap_numara   varchar2 default null,
                           pc_kasa_kod       varchar2 default null);

  Procedure Giris_Kontrol(pn_islem_no number,
                          lc_is_bpm   varchar2 default 'H');

  Function Dogrula_Kontrol(pn_islem_no number) RETURN BOOLEAN;

  Function Onay_Kontrol(pn_islem_no number) RETURN BOOLEAN;

  Function Iptal_Kontrol(pn_islem_no number) RETURN BOOLEAN;

  Procedure Dogrula_islem_yurut(pn_islem_no number,
                                pb_onay_red boolean default true,
                                ps_sebep    varchar2 default null);
  Procedure Onayla_islem_yurut(pn_islem_no number,
                               pb_onay_red boolean default true,
                               ps_sebep    varchar2 default null);
  Procedure Iptal_islem_yurut(pn_islem_no number,
                              ps_sebep    varchar2 default null);

  Procedure Dogrula(pn_islem_no number,
                    pb_onay_red boolean default true,
                    ps_sebep    varchar2 default null);

  Procedure Onay(pn_islem_no in number,
                 pb_onay_red boolean default true,
                 ps_sebep    varchar2 default null);

  Procedure Muhasebelestir(pn_islem_no number);

  Procedure iptal_muhasebelestir(pn_islem_no number);

  Procedure Tamam(pn_islem_no number);

  Procedure Iptal(pn_islem_no number, ps_sebep in varchar2 default null);

  Procedure Iptal_Onay(pn_islem_no number,
                       pb_onay_red boolean default true,
                       ps_sebep    varchar2 default null);

  Procedure Islem_Calistir(pn_islem_numara number);

  Function Islem_bitmis_mi(pn_islem_no number) return number;
  Function Islem_onaylanmis_mi(pn_islem_no number) return number;
  Function Islem_tamamlanmis_mi(pn_islem_no number) return number;
  Function islem_batch_mi(pn_islem_no number) return boolean;

  Function Islem_kod(pn_islem_no number) return number;
  Function fis_no(pn_islem_no number) return number;

  Function Dogrulanabilir_mi(pn_islem_no number) return number;
  Function Onaylanabilir_mi(pn_islem_no number) return number;

  Function Iptal_edilebilir_mi(pn_islem_no number) return number;
  Function Iptal_Onaylanabilir_mi(pn_islem_no number) return number;

  Function dogrula_guncelle(pn_islem_no number) return boolean;
  Function onay_guncelle(pn_islem_no number) return boolean;

  Procedure Dinamik_Onay_Belirle(pn_islem_no         number,
                                 pc_dogrulama        varchar2,
                                 pc_onay             varchar2,
                                 pc_iptal_onay       varchar2,
                                 pc_dogrula_guncelle varchar2,
                                 pc_onay_guncelle    varchar2);
  Procedure Harici_Kod_Cagir(pn_islem_no   number,
                             pc_cikis_yeri varchar2,
                             pb_zorunlu_mu boolean default TRUE);
  Function islem_yaratilmis_mi(pn_islem_no number) return number;
  Function Islem_SubeKodu_Al(pn_islem_no number)
    return gnl_sube_kod_pr.kod%type;

  Function gecici_girilmis_mi(pn_islem_no number) return varchar2;

  Function Amir_SubeKodu_Al(pn_islem_no number)
    return gnl_sube_kod_pr.kod%type;

  Function islem_durum(pn_islem_no number) return muh_islem.durum%type;
  Function msj_islem_durum(pn_islem_no number) return varchar2;

  Procedure Onay_Mesaj_Parametresi(ps_mesaj varchar2);
  Function Onay_Mesaj_Parametresi return varchar2;
  Procedure Dogrula_Mesaj_Parametresi(ps_mesaj varchar2);
  Function Dogrula_Mesaj_Parametresi return varchar2;
  Procedure Kaydet_Mesaj_Parametresi(ps_mesaj varchar2);
  Function Kaydet_Mesaj_Parametresi return varchar2;

  Function IslemKodOnayKont(pn_islem_kod Number) Return Number;

  procedure islem_geri_gonder(pn_islem_no number,
                              ps_sebep    varchar2 default null);
  Function geri_cevrilebilir_mi(pn_islem_no number) return number;

  Procedure islemden_mail_gonder(p_TX_NO        number,
                                 p_MAIL_TO      MUH_ISLEM_MAIL_GONDER.Mail_To%type default null,
                                 p_MAIL_SUBJECT MUH_ISLEM_MAIL_GONDER.MAIL_SUBJECT%type default null,
                                 p_MAIL_BODY    MUH_ISLEM_MAIL_GONDER.MAIL_BODY%type default null,
                                 p_MAIL_FROM    MUH_ISLEM_MAIL_GONDER.Mail_From%type default null,
                                 p_FILE_PATH    MUH_ISLEM_MAIL_GONDER.File_Path%type default null,
                                 p_FILE_NAME    MUH_ISLEM_MAIL_GONDER.FILE_NAME%type default null,
                                 p_FILE_CONTENT MUH_ISLEM_MAIL_GONDER.File_Content%type default null);
  Function son_dogrulama_saat(tx_islem_no in number) return varchar2;
  Function son_onaylama_saat(tx_islem_no in number) return varchar2;
  Function son_dogrulama_sistem_tarih(tx_islem_no in number) return date;
  Function son_onaylama_sistem_tarih(tx_islem_no in number) return date;
  Function fis_saat(tx_islem_no in number) return varchar2;
  Function islem_detay(pn_islem_no number) Return Pkg_Types.RC_ResultSet;
  Function islem_kanal_al(pn_islem_no number) return varchar2;
  Function islem_referans_al(pn_islem_no number) return varchar2;

  Procedure bekleyen_islem_kontrol(pn_tx_no     number,
                                   pn_islem_kod number,
                                   pc_hesap_no  varchar2);

  --Bu proc. muh_islem tablosunda kayit olustuktan sonra kullanilabilir.

  Function islem_baslangic_zaman(tx_islem_no number) return date;

  Function onceki_onaylanmis_tx_no(p_tx_no number) return number;
  procedure islem_mail_gonder(pn_islem_no   number,
                              pc_kull_kod   varchar2,
                              pn_body_ack   number,
                              pn_islem_ack  varchar2,
                              pn_musteri_no number,
                              p1            varchar2 default null);
  procedure islem_onaylayacak_kullanici(pn_islem_no number,
                                        pc_sube     varchar2);
  procedure islem_yaratabilecek_kullanici(pn_islem_no number);
  procedure islem_kullanici_gecmis(pn_islem_no   number,
                                   p_islem_durum varchar2);
  Function Paygate_check(pn_islem_no in number) return varchar2;
  Function bpm_check(pn_islem_no in number) return varchar2;
  Procedure bpm_task_status_update(pn_islem_no number);

END;
/
CREATE OR REPLACE PACKAGE BODY pkg_tx IS

  Onay_mesaj    varchar2(2000);
  Dogrula_mesaj varchar2(2000);
  Kaydet_mesaj  varchar2(2000);

  Function kalan_dogrulama_sayisi(p_islem_no muh_islem.numara%type)
    return number is
  begin
    return pkg_tablo.muh_islem_tablo(p_islem_no).DOGRULANMA_KALAN_ADET;
  end;
  ------------------------------------------------
  Function kalan_onay_sayisi(p_islem_no muh_islem.numara%type) return number is
  begin
    return pkg_tablo.muh_islem_tablo(p_islem_no).ONAYLANMA_KALAN_ADET;
  end;
  ------------------------------------------------
  Function kalan_iptal_onay_sayisi(p_islem_no muh_islem.numara%type)
    return number is
  begin
    return pkg_tablo.muh_islem_tablo(p_islem_no).IPTAL_ONAY_KALAN_ADET;
  end;
  ------------------------------------------------
  Function Son_Aciklamayi_getir(p_islem_no muh_islem.numara%type)
    return varchar2 is
    Cursor c1 is
      Select NVL(a.gcevir_aciklama,
                 NVL(a.iptal_onay_aciklama,
                     NVL(a.iptal_aciklama,
                         NVL(a.onay_aciklama, a.dogrula_aciklama)))) -- Hangi açiklama doluysa onu al
        From muh_islem_onay a
       Where a.numara = p_islem_no
         and NVL(a.gcevir_aciklama,
                 NVL(a.iptal_onay_aciklama,
                     NVL(a.iptal_aciklama,
                         NVL(a.onay_aciklama, a.dogrula_aciklama)))) is not null
       Order by a.sira DESC; -- ERS.... Son aciklamayi al
  
    vs_aciklama VARCHAR2(1000);
  begin
    OPEN c1;
    FETCH c1
      INTO vs_aciklama;
    CLOSE c1;
    RETURN vs_aciklama;
  
  end;
  /************************************************************************************ */
  procedure Islem_Hareket_Log(pn_txNo number) is
  begin
    insert into muh_islem_hareket_log
      (id, numara, durum, session_id)
      (select pkg_genel_pr.Genel_Sira_No_Al,
              i.numara,
              i.durum,
              pkg_global.Get_SessionID
         from muh_islem i
        where i.numara = pn_txNo
       Union
       select pkg_genel_pr.Genel_Sira_No_Al,
              gi.numara,
              gi.durum,
              pkg_global.Get_SessionID
         from muh_islem_gecici gi
        where gi.numara = pn_txNo);
  end Islem_Hareket_Log;
  /************************************************************************************ */
  Function islem_no_al return number is
    vn_islem_no number;
  Begin
    Select sq_islem_no.nextval into vn_islem_no from dual;
    insert /*+ append */
    into tx_baslangic_log
      (tx_no)
    values
      (vn_islem_no);
    Return vn_islem_no;
  Exception
    When Others Then
      pkg_hata.hata_yaz(5, true, 'ISLEM_NO_AL' || SQLERRM);
  End;
  /***************************************************************************************/
  Function bpm_check(pn_islem_no in number) return varchar2 is
    sayi number;
  begin
    sayi := 0;
    select count(1)
      into sayi
      from bpm.bpm_task t
     where t.trx_no = pn_islem_no;
    if sayi > 0 then
      return 'E';
    else
      return 'H';
    end if;
  Exception
    When Others Then
      return 'H';
  end bpm_check;
  ------------------------------------------------
  Function Paygate_check(pn_islem_no in number) return varchar2 is
    cursor c1 is
      select *
        from muh_islem_paygate p
       where p.numara = pn_islem_no
         and p.durum = 'A';
    r1 c1%rowtype;
  Begin
    open c1;
    Fetch c1
      into r1;
    close c1;
  
    if r1.numara is null then
      return 'H';
    else
      return 'E';
    end if;
  Exception
    When Others Then
      pkg_hata.hata_yaz(5, true, 'PAYGATE_CHECK - ' || sqlerrm);
  End Paygate_check;
  ------------------------------------------------
  Procedure kilit_test(pn_islem_no number) is
    vn_dummy_for_lock number;
  Begin
    select 1
      into vn_dummy_for_lock
      from muh_islem
     where numara = pn_islem_no
       for update nowait;
  End;
  ------------------------------------------------
  Procedure Islem_Calistir(pn_islem_numara number) is
  Begin
    If pkg_tx.Dogrula_Kontrol(pn_islem_numara) Then
      Null;
    end if;
  
    if pkg_tx.Onay_Kontrol(pn_islem_numara) Then
      Null;
    end if;
  
    if Islem_onaylanmis_mi(pn_islem_numara) = 0 then
      pkg_tx.muhasebelestir(pn_islem_numara);
      ----log_at('PERF','TXOK-3',pkg_global.GET_KULLANICIKOD,pn_islem_numara);
    
      if pkg_global.Get_KanalKod != '1' then
        /* sube degilse islem uzerindeki amir sube kod alanini fisteki islem_sube_koda atalim */
        Update muh_fis i
           set i.islem_sube_kod =
               (select amir_sube_kod
                  from muh_islem
                 where numara = pn_islem_numara)
         where i.islem_numara = pn_islem_numara;
      
      end if;
      islem_yaratabilecek_kullanici(pn_islem_numara);
    else
      /* dogrulama veya onaya düşmüş işlem ise duruma göre mail onayı göndermemiz gerekebilir */
      if pkg_tx.kalan_dogrulama_sayisi(pn_islem_numara) = 0 then
        pkg_mailonay.Onay_mail_durum_guncelle(pn_islem_numara);
      end if;
    End If;
  
  End;
  --************************************************************************
  Procedure Gecici_Islem_Yarat(pn_islem_numara   number,
                               pn_islem_kod      number,
                               pc_modul_tur_kod  varchar2,
                               pc_urun_tur_kod   varchar2,
                               pc_urun_sinif_kod varchar2,
                               pn_tutar          number,
                               pc_durum_kod      varchar2 default 'G',
                               pc_doviz_kod      varchar2 default null,
                               pn_musteri_numara number default null,
                               pc_hesap_numara   varchar2 default null,
                               pc_kasa_kod       varchar2 default null) is
    vn_islem_var number;
  
  Begin
    select count(*)
      into vn_islem_var
      from muh_islem_gecici
     where numara = pn_islem_numara
       and durum = pc_durum_kod;
  
    if vn_islem_var = 0 then
      Insert into muh_islem_gecici
        (NUMARA,
         ISLEM_KOD,
         DURUM,
         AMIR_SUBE_KOD,
         KAYIT_KULLANICI_KODU,
         KAYIT_KULLANICI_ROL_NUMARA,
         KAYIT_KULLANICI_BOLUM_KODU,
         KAYIT_TARIH,
         KAYIT_SISTEM_TARIHI,
         MODUL_TUR_KOD,
         URUN_TUR_KOD,
         URUN_SINIF_KOD,
         MUSTERI_NUMARA,
         HESAP_NUMARA,
         TUTAR,
         KASA_KOD,
         DOVIZ_KOD,
         kanal_numara,
         kanal_alt_kod,
         KAYIT_KULLANICI_BOLUM)
      values
        (pn_islem_numara,
         pn_islem_kod,
         NVL(pc_durum_kod, 'G'),
         pkg_global.GET_SUBEKOD,
         pkg_global.GET_KULLANICIKOD,
         pkg_global.GET_ROLKOD,
         pkg_global.GET_SUBEKOD,
         pkg_muhasebe.banka_tarihi_bul,
         sysdate,
         pc_modul_tur_kod,
         pc_urun_tur_kod,
         pc_urun_sinif_kod,
         pn_musteri_numara,
         pc_hesap_numara,
         pn_tutar,
         pc_kasa_kod,
         pc_doviz_kod,
         pkg_global.Get_KanalKod,
         pkg_global.Get_KanalAltKod,
         pkg_global.Get_BolumKod);
    else
      update muh_islem_gecici
         set ISLEM_KOD                  = pn_islem_kod,
             AMIR_SUBE_KOD              = pkg_global.GET_SUBEKOD,
             KAYIT_KULLANICI_KODU       = pkg_global.GET_KULLANICIKOD,
             KAYIT_KULLANICI_ROL_NUMARA = pkg_global.get_rolkod,
             KAYIT_KULLANICI_BOLUM_KODU = pkg_global.GET_SUBEKOD,
             KAYIT_TARIH                = pkg_muhasebe.banka_tarihi_bul,
             KAYIT_SISTEM_TARIHI        = sysdate,
             MODUL_TUR_KOD              = pc_modul_tur_kod,
             URUN_TUR_KOD               = pc_urun_tur_kod,
             URUN_SINIF_KOD             = pc_urun_sinif_kod,
             MUSTERI_NUMARA             = pn_musteri_numara,
             HESAP_NUMARA               = pc_hesap_numara,
             TUTAR                      = pn_tutar,
             KASA_KOD                   = pc_kasa_kod,
             DOVIZ_KOD                  = pc_doviz_kod,
             kanal_numara               = pkg_global.Get_KanalKod,
             kanal_alt_kod              = pkg_global.Get_KanalAltKod,
             KAYIT_KULLANICI_BOLUM      = pkg_global.Get_BolumKod
      
       where NUMARA = pn_islem_numara;
    end if;
  
  EXCEPTION
    WHEN OTHERS THEN
      PKG_HATA.hata_yaz(245, TRUE, SQLERRM);
  End;
  --************************************************************************
  Procedure Gecici_Islem_Sil(pn_islem_numara number) is
  Begin
    update muh_islem_gecici set durum = 'X' where NUMARA = pn_islem_numara;
  
  End;
  --************************************************************************
  Procedure Client_Info_Ekle(pn_islem_numara number) is
     -- l_list JSON_OBJECT_T;
      i number;
     -- keys        JSON_KEY_LIST;
      vc_ip_adres  VARCHAR2(20);
      vc_port      VARCHAR2(10);
      vc_latitude  VARCHAR2(50);
      vc_longitude VARCHAR2(50);
      vc_country   VARCHAR2(50);
      vc_state     VARCHAR2(50);
      vc_city      VARCHAR2(50);      
      vc_key       VARCHAR2(50);  
      vc_info      varchar2(500);  
      vc_deger     VARCHAR2(50);  
      vc_otp_device VARCHAR2(50);
      vc_device_brand VARCHAR2(50);
      vc_device_model VARCHAR2(50);
  Begin
    /* l_list := json_object_t.parse(pkg_global.Get_ClientUserInfo);
     keys  := l_list.get_keys;
     FOR i IN 1..keys.count
     LOOP   
       -- dbms_output.put_line(keys(i));
       -- dbms_output.put_line(l_list.get_string(keys(i)));
       vc_key := Upper(keys(i));
       if vc_key = 'USER_IP' then
          vc_ip_adres := l_list.get_string(keys(i));
       elsif vc_key = 'USER_PORT' then
          vc_port := l_list.get_string(keys(i));
       elsif vc_key = 'LATITUDE' then
          vc_latitude := l_list.get_string(keys(i));
       elsif vc_key = 'LONGITUDE' then
          vc_longitude := l_list.get_string(keys(i));
       elsif vc_key = 'COUNTRY' then
          vc_country := l_list.get_string(keys(i));
       elsif vc_key = 'STATE' then
          vc_state := l_list.get_string(keys(i));
       elsif vc_key = 'CITY' then
          vc_city := l_list.get_string(keys(i));
       end if;   
     END LOOP;*/     
  vc_info := pkg_global.Get_ClientUserInfo;
  while vc_info is not null 
  Loop    
    if vc_info like '{"%' or vc_info like ',"%' then
       vc_info := substr(vc_info,3);
    end if;   
      vc_key := f_dizin_ayristir(vc_info,'":"');
     -- dbms_output.put_line(vc_key);
      vc_info  := substr(vc_info,3);
      vc_deger := replace(f_dizin_ayristir(vc_info,'","'),'"}');
     -- dbms_output.put_line(vc_deger);
       if vc_key = 'USER_IP' then
          vc_ip_adres := vc_deger;
       elsif vc_key = 'USER_PORT' then
          vc_port := vc_deger;
       elsif vc_key = 'LATITUDE' then
          vc_latitude := vc_deger;
       elsif vc_key = 'LONGITUDE' then
          vc_longitude := vc_deger;
       elsif vc_key = 'COUNTRY' then
          vc_country := vc_deger;
       elsif vc_key = 'STATE' then
          vc_state := vc_deger;
       elsif vc_key = 'CITY' then
          vc_city := vc_deger;
       elsif vc_key = 'OTP_DEVICE_ID' then
          vc_otp_device := vc_deger;  
       elsif vc_key = 'DEVICE_BRAND' then
          vc_device_brand := vc_deger;
       elsif vc_key = 'DEVICE_MODEL' then
          vc_device_model := vc_deger;      
       end if;      
  End Loop;     
     insert into muh_islem_client_info(numara,ip_adres,port,latitude,longitude,country,state,city,otp_device_id,device_brand,device_model)
     values(pn_islem_numara,vc_ip_adres,vc_port,vc_latitude,vc_longitude,vc_country,vc_state,vc_city,vc_otp_device,vc_device_brand,vc_device_model);
  exception when others then
     log_at('ClientInfo',pkg_global.Get_ClientUserInfo,sqlerrm);   
  End Client_Info_Ekle;  
  --************************************************************************
  Procedure Islem_Yarat(pn_islem_numara         number,
                        pn_islem_kod            number,
                        pc_modul_tur_kod        varchar2,
                        pc_urun_tur_kod         varchar2,
                        pc_urun_sinif_kod       varchar2,
                        pn_tutar                number,
                        pc_sube_kod             varchar2 default null,
                        pc_doviz_kod            varchar2 default null,
                        pn_musteri_numara       number default null,
                        pc_hesap_numara         varchar2 default null,
                        pc_kasa_kod             varchar2 default null,
                        pc_onaysiz_islem        varchar2 default null,
                        pn_cagiran_islem_numara number default null) is
    vn_islem_var              number;
    vn_hesap_sube             gnl_sube_kod_pr.kod%TYPE;
    vs_bekleyen_islem_kontrol muh_islem_tanim_pr.bekleyen_islem_kontrol%type;
    vd_baslangic_tar          date;
    lc_onaysiz_islem          varchar2(10);
    lc_is_bpm                 varchar2(2);
    cursor c_bas_tar is
      select l.rec_date baslangic_tar
        from tx_baslangic_log l
       where l.tx_no = pn_islem_numara;
  
  Begin
    lc_onaysiz_islem := nvl(pc_onaysiz_islem, 'H');
    if lc_onaysiz_islem = 'B' then
      lc_is_bpm := 'E';
    else
      lc_is_bpm := 'H';
    end if;
    bekleyen_islem_kontrol(pn_islem_numara, pn_islem_kod, pc_hesap_numara);
  
    -- Fis ile ilgili kontroller ( giris asamasinda yapiliyor )
    If pkg_tablo.muh_islem_tanim_tablo(pn_islem_kod).TX_MUH_KONTROL = 'E' Then
      pkg_par_book_control.fis_yarat('TRN' || to_char(pn_islem_kod),
                                     pn_islem_numara);
      /*pkg_par_book_control.KONTROLLERI_YAP; pkg_par_book_control icine tasidim MHA 081009 */
    End If;
    --
    select /*+ index(islem PK_MUH_ISLEM) */
     count(*)
      into vn_islem_var
      from muh_islem islem
     where numara = pn_islem_numara
       and durum = 'N';
  
    if vn_islem_var = 0 then
      Begin
        open c_bas_tar;
        fetch c_bas_tar
          into vd_baslangic_tar;
        close c_bas_tar;
      
        insert into muh_islem
          (numara,
           islem_kod,
           durum,
           amir_sube_kod,
           kayit_kullanici_kodu,
           kayit_kullanici_rol_numara,
           kayit_kullanici_bolum_kodu,
           kayit_tarih,
           kayit_sistem_tarihi,
           modul_tur_kod,
           urun_tur_kod,
           urun_sinif_kod,
           musteri_numara,
           hesap_numara,
           tutar,
           kasa_kod,
           doviz_kod,
           dogrulanma_kalan_adet,
           onaylanma_kalan_adet,
           dogrulanmali_mi,
           onaylanmali_mi,
           kanal_numara,
           kanal_alt_kod,
           BASLANGIC_TARIHI,
           KAYIT_KULLANICI_BOLUM)
        values
          (pn_islem_numara,
           pn_islem_kod,
           'N',
           pkg_global.GET_SUBEKOD,
           pkg_global.GET_KULLANICIKOD,
           pkg_global.GET_ROLKOD,
           pkg_global.GET_SUBEKOD,
           pkg_muhasebe.banka_tarihi_bul,
           sysdate,
           pc_modul_tur_kod,
           pc_urun_tur_kod,
           pc_urun_sinif_kod,
           pn_musteri_numara,
           pc_hesap_numara,
           pn_tutar,
           pc_kasa_kod,
           pc_doviz_kod,
           0,
           0,
           'H',
           'H',
           pkg_global.Get_KanalKod,
           pkg_global.Get_KanalAltKod,
           vd_baslangic_tar,
           pkg_global.Get_BolumKod);
           
           if pkg_global.Get_ClientUserInfo is not null then
              client_info_ekle(pn_islem_numara);
           end if;   
      Exception
        When Others Then
          --log_at('IBRAHIMT',dbms_utility.format_error_stack||dbms_utility.format_error_backtrace);
          pkg_hata.hata_yaz(244, true, SQLERRM);
      End;
    
    else
      begin
        islem_guncelle(pn_islem_numara,
                       pc_modul_tur_kod,
                       pc_urun_tur_kod,
                       pc_urun_sinif_kod,
                       pn_tutar,
                       pc_sube_kod,
                       pc_doviz_kod,
                       pn_musteri_numara,
                       pc_hesap_numara,
                       pc_kasa_kod);
      Exception
        When Others Then
          pkg_hata.hata_yaz(244, true, SQLERRM);
      End;
    end if;
  
    if pkg_global.Get_KanalKod != '1' and pc_hesap_numara is not null then
      /* sube degilse islem uzerindeki hesabin subesini amir sube kod yapalim */
      begin
        vn_hesap_sube := pkg_hesap.sube_kodu(pc_hesap_numara);
      exception
        when others then
          vn_hesap_sube := pkg_global.GET_SUBEKOD;
      end;
      Update muh_islem i
         set i.amir_sube_kod = vn_hesap_sube
       where i.numara = pn_islem_numara
         and i.hesap_numara is not null;
    
      update muh_dekont d
         set d.sube_kodu = vn_hesap_sube
       where d.tx_no = pn_islem_numara
         and d.sube_kodu is null; /* sadece sube kodu boş olursa update etmesi dogru olan MHA 03072018 */
    
    end if;
  
    Delete From muh_islem_gecici where numara = pn_islem_numara;
    Giris_Kontrol(pn_islem_numara, lc_is_bpm);
  
    If Paygate_check(pn_islem_numara) = 'H' then
      /* Paygate'e düsen islem */
      if NVL(lc_onaysiz_islem, '#') = 'E' or
         NVL(lc_onaysiz_islem, '#') = 'B' then
        update muh_islem a
           set dogrulanmali_mi         = 'H',
               a.dogrulanma_adet       = 0,
               a.dogrulanma_kalan_adet = 0,
               onaylanmali_mi          = 'H',
               a.onaylanma_adet        = 0,
               a.onaylanma_kalan_adet  = 0
         where a.numara = pn_islem_numara;
      end if;
    End if;
  
    if pn_cagiran_islem_numara is not null then
      insert into muh_islem_cagrilan
        (numara, cagiran_numara)
      values
        (pn_islem_numara, pn_cagiran_islem_numara);
    end if;
  
  End;
  --*************************************************************************************
  Procedure Islem_Guncelle(pn_islem_numara   number,
                           pc_modul_tur_kod  varchar2,
                           pc_urun_tur_kod   varchar2,
                           pc_urun_sinif_kod varchar2,
                           pn_tutar          number,
                           pc_sube_kod       varchar2 default null,
                           pc_doviz_kod      varchar2 default null,
                           pn_musteri_numara number default null,
                           pc_hesap_numara   varchar2 default null,
                           pc_kasa_kod       varchar2 default null) is
  Begin
  
    Kilit_Test(pn_islem_numara);
  
    Update muh_islem
       set AMIR_SUBE_KOD  = pc_sube_kod,
           MODUL_TUR_KOD  = pc_modul_tur_kod,
           URUN_TUR_KOD   = pc_urun_tur_kod,
           URUN_SINIF_KOD = pc_urun_sinif_kod,
           MUSTERI_NUMARA = pn_musteri_numara,
           HESAP_NUMARA   = pc_hesap_numara,
           TUTAR          = pn_tutar,
           KASA_KOD       = pc_kasa_kod,
           DOVIZ_KOD      = pc_doviz_kod
     where numara = pn_islem_numara;
  
  Exception
    When Others Then
      pkg_hata.hata_yaz(249, true, SQLERRM);
  End;
  --************************************************************************
  Procedure Giris_Kontrol(pn_islem_no number,
                          lc_is_bpm   varchar2 default 'H') is
    Cursor C1 is
      select rui.dogrulama,
             rui.onay,
             rui.iptal_onay,
             rui.dogrula_guncelle,
             rui.onayla_guncelle,
             i.numara,
             i.amir_sube_kod
        from gnl_rol_islem rui, muh_islem i, gnl_zaman_pr z, gnl_limit_pr l
       where i.numara = pn_islem_no
         and i.durum IN ('N')
         and i.islem_kod = rui.islem_tanim_kod
         and rui.rol_numara = PKG_GLOBAL.GET_ROLKOD
         and rui.zaman_numara = z.numara
         and to_number(to_char(sysdate, 'HH24')) between baslangic and
             bitis
         and rui.limit_numara = l.kod
         and ((l.tum_dovizler = 'H' and l.karsilik = 'F' and
             nvl(i.doviz_kod, pkg_genel_pr.lc_al) = l.doviz_kod and
             nvl(i.tutar, 0) between Alt And Ust) OR
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,alt) and
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,ust) ) or
             (l.tum_dovizler = 'E' and l.karsilik = 'F' and
             nvl(i.tutar, 0) between
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al MHA 250608*/,
                                   nvl(i.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   alt) and
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al*/,
                                   nvl(i.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   ust)) or (l.karsilik = 'N'));
    rc_rui c1%rowtype;
  
    vc_kul gnl_kullanici.kod%type;
  
  Begin
    Begin
      OPEN C1;
      FETCH c1
        INTO rc_rui;
      CLOSE C1;
      Kilit_Test(pn_islem_no); -- islem tablosunu kilitle
      if lc_is_bpm = 'H' then
        If rc_rui.dogrulama is null AND pkg_global.GET_ROLKOD = '999' then
          -- Rol tablounda bu islem yok
          update muh_islem a
             set durum                   = 'C',
                 dogrulanmali_mi         = 'H',
                 a.dogrulanma_adet       = 0,
                 a.dogrulanma_kalan_adet = 0,
                 onaylanmali_mi          = 'H',
                 a.onaylanma_adet        = 0,
                 a.onaylanma_kalan_adet  = 0,
                 iptal_onaylanmali_mi    = 'H',
                 a.iptal_onay_adet       = 0,
                 a.iptal_onay_kalan_adet = 0,
                 dogrula_guncelle        = 'H',
                 onay_guncelle           = 'H'
           where numara = pn_islem_no;
        
          Islem_Hareket_Log(pn_islem_no);
        
        ElsIf rc_rui.dogrulama is null then
          -- Burasi sonra kalkacak
          /*
          update muh_islem a
             set durum                = 'C',
                 dogrulanmali_mi      = 'E', --lc_dogrulama,
                 a.dogrulanma_adet          = 1,
                 a.dogrulanma_kalan_adet    = 1,
                 onaylanmali_mi       = 'H', --lc_onay,
                 a.onaylanma_adet           = 0,
                 a.onaylanma_kalan_adet     = 0,
                 iptal_onaylanmali_mi = 'H', --lc_iptal_onay,
                 a.iptal_onay_adet          = 0,
                 a.iptal_onay_kalan_adet    = 0,
                 dogrula_guncelle     = 'H', --lc_dogrula_guncelle,
                 onay_guncelle        = 'H'  --lc_onay_guncelle
           where numara = pn_islem_no;
          
               pkg_hata.hata_yaz(251,FALSE,SQLERRM);
            */
          pkg_hata.hata_yaz(251,
                            TRUE,
                            'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                            ' ROL:' || pkg_global.GET_ROLKOD ||
                            ' ISLEM KOD:' || islem_kod(pn_islem_no));
        
        Else
          /* if NVL(Onaysiz_islem,'#')='E' then
             rc_rui.dogrulama := 0;
             rc_rui.onay := 0;
             Onaysiz_islem := null;
          end if;  tamamen bu kismi islem yaratta hallediyoruz MHA 150613 */
        
          if rc_rui.dogrulama > 0 or rc_rui.onay > 0 then
            islem_onaylayacak_kullanici(rc_rui.numara,
                                        rc_rui.amir_sube_kod);
          end if;
        
          update muh_islem a
             set durum                   = 'C',
                 dogrulanmali_mi         = DECODE(rc_rui.dogrulama,
                                                  0,
                                                  'H',
                                                  'E'),
                 a.dogrulanma_adet       = rc_rui.dogrulama,
                 a.dogrulanma_kalan_adet = rc_rui.dogrulama,
                 onaylanmali_mi          = DECODE(rc_rui.onay, 0, 'H', 'E'),
                 a.onaylanma_adet        = rc_rui.onay,
                 a.onaylanma_kalan_adet  = rc_rui.onay,
                 iptal_onaylanmali_mi    = DECODE(rc_rui.iptal_onay,
                                                  0,
                                                  'H',
                                                  'E'),
                 a.iptal_onay_adet       = rc_rui.iptal_onay,
                 a.iptal_onay_kalan_adet = rc_rui.iptal_onay,
                 dogrula_guncelle        = rc_rui.dogrula_guncelle,
                 onay_guncelle           = rc_rui.onayla_guncelle
           where numara = pn_islem_no;
        
          Islem_Hareket_Log(pn_islem_no);
        
        End if;
        If Paygate_check(pn_islem_no) = 'E' then
          /* Paygate Inspectorda bir match oldugu ise Dinamik dogrulama ilave edelim */
          Dinamik_Onay_Belirle(pn_islem_no         => pn_islem_no,
                               pc_dogrulama        => 'E',
                               pc_onay             => null,
                               pc_iptal_onay       => null,
                               pc_dogrula_guncelle => null,
                               pc_onay_guncelle    => null);
        end if;
        if pkg_mailonay.MailOnay_Varmi(pn_islem_no) = 'E' then
          pkg_mailonay.Onay_mail_hazirla(pn_islem_no);
        end if;
      else
        if rc_rui.dogrulama is null then
          pkg_hata.hata_yaz(251,
                            TRUE,
                            'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                            ' ROL:' || pkg_global.GET_ROLKOD ||
                            ' ISLEM KOD:' || islem_kod(pn_islem_no));
        end if;
        update muh_islem a set durum = '5' where numara = pn_islem_no;
      
        Islem_Hareket_Log(pn_islem_no);
      end if;
    
      /*     Exception
      When Others Then
       pkg_hata.hata_yaz(250,true,SQLERRM);24.06.09 hakan uçurtmadi,AsliK*/
    End;
  
  End;
  --************************************************************************
  Function Dogrula_Kontrol(pn_islem_no number) return boolean is
    cursor c1 is
      select muh_islem.dogrulanmali_mi,
             muh_islem.durum,
             muh_islem.amir_sube_kod
        from muh_islem
       where muh_islem.numara = pn_islem_no
         and muh_islem.durum = 'C'
         and muh_islem.dogrulanma_kalan_adet >= 0;
  
    vc_dogrulama muh_islem.dogrulanmali_mi%type;
    vc_durum     muh_islem.durum%type;
    vc_sube      muh_islem.amir_sube_kod%type;
  Begin
    open c1;
    loop
      fetch c1
        into vc_dogrulama, vc_durum, vc_sube;
      exit when c1%notfound;
      if vc_dogrulama = 'H' then
        close c1;
        -- update muh_islem t  set t.durum = 'V' where t.numara = pn_islem_no;
        Harici_Kod_Cagir(pn_islem_no, 'After_Verify');
        return FALSE; -- Gerek yok
      else
        close c1;
        return TRUE; -- Gerek var
      end if;
    end loop;
    close c1;
    RETURN FALSE;
    pkg_hata.hata_yaz(246, FALSE, SQLERRM);
  End;
  --************************************************************************
  Function Onay_Kontrol(pn_islem_no number) return boolean is
    cursor c1 is
      select muh_islem.onaylanmali_mi, muh_islem.durum
        from muh_islem
       where muh_islem.numara = pn_islem_no
         and ((muh_islem.durum = 'C' and dogrulanmali_mi = 'H') or
             (muh_islem.durum = 'V' and dogrulanmali_mi = 'E'))
         and muh_islem.onaylanma_kalan_adet >= 0;
  
    vc_onaylama muh_islem.onaylanmali_mi%type;
    vc_durum    muh_islem.durum%type;
  Begin
    open c1;
    loop
      fetch c1
        into vc_onaylama, vc_durum;
      exit when c1%notfound;
    
      if vc_onaylama = 'H' then
        close c1;
        update muh_islem t set t.durum = 'A' where t.numara = pn_islem_no;
        --log_at('PERF','TXOK-1',pkg_global.GET_KULLANICIKOD,pn_islem_no);
        Harici_Kod_Cagir(pn_islem_no, 'After_approval');
        --log_at('PERF','TXOK-2',pkg_global.GET_KULLANICIKOD,pn_islem_no);
        return FALSE;
      else
        close c1;
        return TRUE;
      end if;
    
    end loop;
    close c1;
    RETURN FALSE;
    pkg_hata.hata_yaz(247, FALSE, SQLERRM);
  End;
  ------------------------------------------------------
  Function Iptal_Kontrol(pn_islem_no number) return boolean is
    cursor c1 is
      select muh_islem.iptal_onaylanmali_mi
        from muh_islem
       where muh_islem.numara = pn_islem_no
         and muh_islem.durum = '1';
  
    vc_onaylama muh_islem.onaylanmali_mi%type;
  Begin
    open c1;
    loop
      fetch c1
        into vc_onaylama;
      exit when c1%notfound;
      if vc_onaylama = 'E' then
        close c1;
        return TRUE;
      else
        close c1;
        Harici_Kod_Cagir(pn_islem_no, 'After_Canceling_Approval');
        return FALSE;
      end if;
    
    end loop;
    close c1;
    RETURN FALSE;
    pkg_hata.hata_yaz(248, FALSE, SQLERRM);
  End;
  ----------------------------------------------------
  Function Onaylanabilir_mi(pn_islem_no number) return number is
    cursor c1 is
      select muh_islem.onaylanmali_mi, muh_islem.durum
        from muh_islem
       where muh_islem.numara = pn_islem_no
         and ((muh_islem.durum = 'C' and dogrulanmali_mi = 'H') or
             (muh_islem.durum = 'V' and dogrulanmali_mi = 'E') or
             muh_islem.durum = '5');
    vd_banka_tarih date := pkg_muhasebe.Banka_Tarihi_Bul;
    Cursor C2 is
      select 1
        from gnl_rol_islem_onay rui,
             muh_islem          islem,
             gnl_zaman_pr       zaman,
             gnl_limit_pr       l
       where islem.numara = pn_islem_no
         and ((islem.durum = 'C' and dogrulanmali_mi = 'H') or
             (islem.durum = 'V' and dogrulanmali_mi = 'E') or
             islem.durum = '5')
         and islem.islem_kod = rui.islem_tanim_kod
         And (islem.amir_sube_kod = PKG_GLOBAL.GET_SUBEKOD OR exists
              (select 1
                 from gnl_kull_gm_sube_pr f
                where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD
                  and f.sube_kodu = islem.amir_sube_kod
                  and NVL(f.baslangic_tarihi, vd_banka_tarih) <=
                      vd_banka_tarih
                  and NVL(f.bitis_tarihi, vd_banka_tarih) >= vd_banka_tarih)
             /*islem.amir_sube_kod IN ( select f.sube_kodu
              From gnl_kull_gm_sube_pr f
             Where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD )*/
             )
            
         and rui.rol_numara = pkg_GLOBAL.GET_ROLKOD
         and ((nvl(rui.ayni_bolum, 'H') = 'H') or
             (nvl(rui.ayni_bolum, 'H') = 'E' and
             PKG_PERSONEL.kullanici_departmani(islem.kayit_kullanici_kodu) =
             PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD)))
         and ((rui.ayni_kullanici = 'H' and /*islem.kayit_kullanici_kodu != PKG_GLOBAL.GET_KULLANICIKOD*/
             PKG_GLOBAL.GET_KULLANICIKOD not in
             (select o.onay_kullanici_kodu
                  from muh_islem_onay o
                 where o.numara = pn_islem_no
                   and o.onay_kullanici_kodu is not null
                union
                select o1.dogru_kullanici_kodu
                  from muh_islem_onay o1
                 where o1.numara = pn_islem_no
                   and o1.dogru_kullanici_kodu is not null) and
             PKG_GLOBAL.GET_KULLANICIKOD != islem.kayit_kullanici_kodu) or
             (rui.ayni_kullanici = 'E'))
         and rui.zaman_numara = zaman.numara
         and to_number(to_char(sysdate, 'HH24')) between baslangic and
             bitis
         and rui.limit_numara = l.kod
         and ((l.tum_dovizler = 'H' and l.karsilik = 'F' and
             nvl(islem.doviz_kod, pkg_genel_pr.lc_al) = l.doviz_kod and
             nvl(islem.tutar, 0) between Alt And Ust) OR
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,alt) and
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,ust) ) or
             (l.tum_dovizler = 'E' and l.karsilik = 'F' and
             nvl(islem.tutar, 0) between
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al MHA 250608*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   alt) and
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   ust)) or (l.karsilik = 'N'))
         and ((rui.ayni_rol = 'H' and /*nvl(islem.onay_kull_rol_numara,0) != PKG_GLOBAL.GET_ROLKOD bu kadari yeterli degil MHA 010708*/
             PKG_GLOBAL.GET_ROLKOD not in
             (select o.onay_kullanici_rol_numara
                  from muh_islem_onay o
                 where o.numara = pn_islem_no
                   and o.onay_kullanici_kodu is not null) and
             pkg_global.GET_ROLKOD != islem.kayit_kullanici_rol_numara) or
             (rui.ayni_rol = 'E'));
  
    vc_onay  muh_islem.onaylanmali_mi%type;
    vc_durum muh_islem.durum%type;
    vn_dummy number;
  Begin
    open c1;
    fetch c1
      into vc_onay, vc_durum;
    close c1;
    if (vc_onay = 'H' and vc_durum != '5') then
      -- Dogrulanmaya gerek yok
      return 0;
    end if;
    open c2;
    fetch c2
      into vn_dummy;
    if c2%notfound then
      close c2;
      return 0; -- Dogrulama yetkisi yok
    end if;
    close c2;
    return 1;
  End;
  -----------------------------------
  Procedure Dogrula_islem_yurut(pn_islem_no number,
                                pb_onay_red boolean default true,
                                ps_sebep    varchar2 default null) is
    cursor c1 is
      select muh_islem.amir_sube_kod
        from muh_islem
       where numara = pn_islem_no;
    vc_sube muh_islem.amir_sube_kod%type;
  
  Begin
    --log_at('PERF','TXDY-1',pkg_global.GET_KULLANICIKOD,pn_islem_no);
    Pkg_Tx.dogrula(pn_islem_no, pb_onay_red, ps_sebep);
    if pb_onay_red then
      if pkg_tx.Onay_Kontrol(pn_islem_no) Then
        Null;
      end if;
    else
      --- islemi yaratan - dogrulayan - onaylayan kisilere mail atar
      islem_kullanici_gecmis(pn_islem_no, 'R');
    end if;
  
    if Islem_onaylanmis_mi(pn_islem_no) = 0 then
      pkg_tx.muhasebelestir(pn_islem_no);
      if pkg_global.Get_KanalKod != '1' then
        /* sube degilse islem uzerindeki amir sube kod alanini fisteki islem_sube_koda atalim */
        Update muh_fis i
           set i.islem_sube_kod =
               (select amir_sube_kod
                  from muh_islem
                 where numara = pn_islem_no)
         where i.islem_numara = pn_islem_no;
      
      end if;
      --- islemi yaratan - dogrulayan  -onaylayan kisilere mail atar
      islem_kullanici_gecmis(pn_islem_no, 'A');
    else
      --- islemi onaylayabilecek kisilere mail atar
      islem_onaylayacak_kullanici(pn_islem_no, vc_sube);
    End If;
    --log_at('PERF','TXDY-2',pkg_global.GET_KULLANICIKOD,pn_islem_no);
  End;
  -----------------------------------
  Procedure Onayla_islem_yurut(pn_islem_no number,
                               pb_onay_red boolean default true,
                               ps_sebep    varchar2 default null) is
    is_bpm varchar2(1);
  Begin
    --log_at('PERF','TXOY-1',pkg_global.GET_KULLANICIKOD,pn_islem_no);
    Pkg_Tx.Onay(pn_islem_no, pb_onay_red, ps_sebep);
    --log_at('PERF','TXOY-2',pkg_global.GET_KULLANICIKOD,pn_islem_no);
    is_bpm := bpm_check(pn_islem_no);
    if Islem_onaylanmis_mi(pn_islem_no) = 0 or is_bpm = 'E' then
      if is_bpm = 'E' then
        If PKG_TX.Onaylanabilir_mi(pn_islem_no) = 0 Then
          pkg_hata.hata_yaz(253,
                            true,
                            'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                            ' ROL:' || pkg_global.GET_ROLKOD); -- Onaylama yetkisi yok
        End if;
        Harici_Kod_Cagir(pn_islem_no, 'After_Approval');
      end if;
      pkg_tx.muhasebelestir(pn_islem_no);
      --log_at('PERF','TXOY-3',pkg_global.GET_KULLANICIKOD,pn_islem_no);
      if pkg_global.Get_KanalKod != '1' then
        /* sube degilse islem uzerindeki amir sube kod alanini fisteki islem_sube_koda atalim */
        Update muh_fis i
           set i.islem_sube_kod =
               (select amir_sube_kod
                  from muh_islem
                 where numara = pn_islem_no)
         where i.islem_numara = pn_islem_no;
      
      end if;
    
    End If;
    --log_at('PERF','TXOY-4',pkg_global.GET_KULLANICIKOD,pn_islem_no);
  End;
  -----------------------------------
  Procedure Iptal_islem_yurut(pn_islem_no number,
                              ps_sebep    varchar2 default null) is
  Begin
    Pkg_Tx.Iptal(pn_islem_no, ps_sebep);
  
    if pkg_tx.Iptal_Kontrol(pn_islem_no) Then
      Null;
    else
      pkg_tx.Iptal_muhasebelestir(pn_islem_no);
      -- islemi yaratan - dogrulayan - onaylayan kisilere mail atar
      islem_kullanici_gecmis(pn_islem_no, '1');
    end if;
  
  End;
  -----------------------------------
  Procedure Dogrula(pn_islem_no number,
                    pb_onay_red boolean default true,
                    ps_sebep    varchar2 default null) is
    cursor c1 is
      select muh_islem.dogrulanmali_mi, muh_islem.durum
        from muh_islem
       where numara = pn_islem_no
         and durum = 'C';
  
    vc_dogrulama muh_islem.dogrulanmali_mi%type;
    vc_durum     muh_islem.durum%type;
    vn_sira      number;
  Begin
    open c1;
    fetch c1
      into vc_dogrulama, vc_durum;
    close c1;
    if vc_dogrulama = 'H' then
      -- Dogrulanmaya gerek yok
      return;
    end if;
    if pkg_global.GET_SUBEKOD != '999' then
      -- Gunsonu ise yetki kontrolu yapma...
      If PKG_TX.Dogrulanabilir_mi(pn_islem_no) = 0 Then
        pkg_hata.hata_yaz(252,
                          true,
                          'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                          ' ROL:' || pkg_global.GET_ROLKOD); -- Dogrulama yetkisi yok
      End if;
    end if;
    --
    Kilit_Test(pn_islem_no);
    begin
      select max(t.sira) + 1
        into vn_sira
        from muh_islem_onay t
       where t.numara = pn_islem_no;
    Exception
      when no_data_found then
        vn_sira := 1;
    end;
    if nvl(vn_sira, 0) = 0 Then
      vn_sira := 1;
    end if;
    if pb_onay_red then
      if pkg_global.GET_KULLANICIKOD = 'PAYGATE' then
        Update muh_islem_paygate p
           set p.durum = 'K', p.aciklama = ps_sebep
         where p.numara = pn_islem_no;
      end if;
    
      if pkg_tx.kalan_dogrulama_sayisi(pn_islem_no) > 0 then
        insert into muh_islem_onay
          (numara,
           sira,
           dogru_kullanici_kodu,
           dogru_kullanici_rol_numara,
           dogru_kullanici_bolum_kodu,
           dogru_tarih,
           dogrulama_sistem_tarihi,
           dogrula_aciklama,
           dogru_kull_bolum)
        values
          (pn_islem_no,
           vn_sira,
           pkg_global.GET_KULLANICIKOD,
           pkg_global.GET_ROLKOD,
           pkg_global.GET_SUBEKOD,
           pkg_muhasebe.banka_tarihi_bul,
           sysdate,
           ps_sebep,
           pkg_global.Get_BolumKod);
        update muh_islem t
           set t.dogrulanma_kalan_adet = t.dogrulanma_kalan_adet - 1, /* her adimdaki dogrulayan bilgileri de update olsun MHA 010708 */
               dogru_kull_kodu         = pkg_global.GET_KULLANICIKOD,
               dogru_kull_rol_numara   = pkg_global.GET_ROLKOD,
               dogru_kull_bolum_kodu   = pkg_global.GET_SUBEKOD,
               dogru_tarih             = pkg_muhasebe.banka_tarihi_bul,
               dogru_kull_bolum        = pkg_global.Get_BolumKod
         where t.numara = pn_islem_no;
      end if;
      if pkg_tx.kalan_dogrulama_sayisi(pn_islem_no) = 0 then
        update muh_islem t
           set t.durum               = 'V',
               dogru_kull_kodu       = pkg_global.GET_KULLANICIKOD,
               dogru_kull_rol_numara = pkg_global.GET_ROLKOD,
               dogru_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
               dogru_tarih           = pkg_muhasebe.banka_tarihi_bul,
               dogru_kull_bolum      = pkg_global.Get_BolumKod
         where t.numara = pn_islem_no;
        Harici_Kod_Cagir(pn_islem_no, 'After_Verify');
        Islem_Hareket_Log(pn_islem_no);
        if pkg_tx.kalan_onay_sayisi(pn_islem_no) > 0 then
          /* Doğrulama bitti işlem onaya düşecekmiş mail onayı varsa gönderilsin mail MHA 16052018 */
          pkg_mailonay.Onay_mail_durum_guncelle(pn_islem_no);
        end if;
      end if;
    else
      -- pb_onay_red
      if pkg_global.GET_KULLANICIKOD = 'PAYGATE' then
        Update muh_islem_paygate p
           set p.durum = 'R', p.aciklama = ps_sebep
         where p.numara = pn_islem_no;
      end if;
      insert into muh_islem_onay
        (numara,
         sira,
         dogru_kullanici_kodu,
         dogru_kullanici_rol_numara,
         dogru_kullanici_bolum_kodu,
         dogru_tarih,
         dogrulama_sistem_tarihi,
         dogrula_aciklama,
         red_flag,
         dogru_kull_bolum)
      values
        (pn_islem_no,
         vn_sira,
         pkg_global.GET_KULLANICIKOD,
         pkg_global.GET_ROLKOD,
         pkg_global.GET_SUBEKOD,
         pkg_muhasebe.banka_tarihi_bul,
         sysdate,
         ps_sebep,
         'E',
         pkg_global.get_bolumkod);
    
      update muh_islem t
         set t.durum               = 'D',
             dogru_kull_kodu       = pkg_global.GET_KULLANICIKOD,
             dogru_kull_rol_numara = pkg_global.GET_ROLKOD,
             dogru_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
             dogru_tarih           = pkg_muhasebe.banka_tarihi_bul,
             dogru_kull_bolum      = pkg_global.get_bolumkod
       where t.numara = pn_islem_no;
    
      Harici_Kod_Cagir(pn_islem_no, 'After_Verify_Canceling');
    
      Islem_Hareket_Log(pn_islem_no);
    
      pkg_dekont.Dekont_sil(pn_islem_no); -- BNSPRPRO-4483
    
    end if;
  End;
  -------------------------------------------------
  Procedure Onay(pn_islem_no number,
                 pb_onay_red boolean default true,
                 ps_sebep    varchar2 default null) is
    cursor c1 is
      select muh_islem.onaylanmali_mi,
             muh_islem.durum,
             muh_islem.amir_sube_kod,
             muh_islem.kayit_kullanici_kodu
        from muh_islem
       where muh_islem.numara = pn_islem_no
         and ((muh_islem.durum = 'C' and dogrulanmali_mi = 'H') or
             (muh_islem.durum = 'V' and dogrulanmali_mi = 'E') or
             muh_islem.durum = '5');
  
    vc_onay  muh_islem.onaylanmali_mi%type;
    vc_durum muh_islem.durum%type;
    vn_sira  number;
  
    vc_sube muh_islem.amir_sube_kod%type;
    vc_kul  gnl_kullanici.kod%type;
  Begin
    open c1;
    fetch c1
      into vc_onay, vc_durum, vc_sube, vc_kul;
    close c1;
    if vc_onay = 'H' then
      return;
    end if;
    if pkg_global.GET_SUBEKOD != '999' then
      -- --log_at('hates',pkg_global.GET_KULLANICIKOD,PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD));
      -- --log_at('hates',vc_kul,PKG_PERSONEL.Kullanici_Departmani(vc_kul));
      If PKG_TX.Onaylanabilir_mi(pn_islem_no) = 0 Then
        pkg_hata.hata_yaz(253,
                          true,
                          'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                          ' ROL:' || pkg_global.GET_ROLKOD); -- Onaylama yetkisi yok
      End if;
      -- --log_at('hates',pkg_global.GET_KULLANICIKOD,pkg_personel.SAP_gorev_deger(PKG_GLOBAL.GET_KULLANICIKOD));
      -- --log_at('hates',vc_kul,pkg_personel.SAP_gorev_deger(vc_kul));
      if vc_kul != PKG_GLOBAL.GET_KULLANICIKOD then
        /* aynı kllanıcı onaylamıyorsa */
        if PKG_PERSONEL.kullanici_departmani(vc_kul) =
           PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD) then
          /* aynı departmandan birisi onaylıyorsa görev agırlık kontrolü yapalım */
          if pkg_personel.SAP_gorev_deger(vc_kul) >
             pkg_personel.SAP_gorev_deger(PKG_GLOBAL.GET_KULLANICIKOD) then
            pkg_hata.hata_yaz(5723, true);
          end if;
        end if;
      end if;
    end if;
    Kilit_Test(pn_islem_no);
    begin
      select max(t.sira) + 1
        into vn_sira
        from muh_islem_onay t
       where t.numara = pn_islem_no;
    Exception
      when no_data_found then
        vn_sira := 1;
    end;
    if nvl(vn_sira, 0) = 0 Then
      vn_sira := 1;
    end if;
    if pb_onay_red then
      if pkg_tx.kalan_onay_sayisi(pn_islem_no) > 0 then
        insert into muh_islem_onay
          (numara,
           sira,
           onay_kullanici_kodu,
           onay_kullanici_rol_numara,
           onay_kullanici_bolum_kodu,
           onay_tarih,
           onay_sistem_tarihi,
           onay_aciklama,
           onay_kull_bolum)
        values
          (pn_islem_no,
           vn_sira,
           pkg_global.GET_KULLANICIKOD,
           pkg_global.GET_ROLKOD,
           pkg_global.GET_SUBEKOD,
           pkg_muhasebe.banka_tarihi_bul,
           sysdate,
           ps_sebep,
           pkg_global.get_bolumkod);
        update muh_islem t
           set t.onaylanma_kalan_adet = t.onaylanma_kalan_adet - 1, /* her adimdaki onaylayan bilgileri de update olsun MHA 010708 */
               onay_kull_kodu         = pkg_global.GET_KULLANICIKOD,
               onay_kull_rol_numara   = pkg_global.GET_ROLKOD,
               onay_kull_bolum_kodu   = pkg_global.GET_SUBEKOD,
               onay_tarih             = pkg_muhasebe.banka_tarihi_bul,
               onay_kull_bolum        = pkg_global.get_bolumkod
         where t.numara = pn_islem_no;
      end if;
      if pkg_tx.kalan_onay_sayisi(pn_islem_no) = 0 then
        update muh_islem t
           set t.durum              = 'A',
               onay_kull_kodu       = pkg_global.GET_KULLANICIKOD,
               onay_kull_rol_numara = pkg_global.GET_ROLKOD,
               onay_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
               onay_tarih           = pkg_muhasebe.banka_tarihi_bul,
               onay_kull_bolum      = pkg_global.get_bolumkod
         where t.numara = pn_islem_no;
        Harici_Kod_Cagir(pn_islem_no, 'After_Approval'); -- Ýþlem Paketi Çaðýrýr
      
        Islem_Hareket_Log(pn_islem_no);
      
        --- islemi yaratan - dogrulayan - onaylayan kisilere mail atar
        islem_kullanici_gecmis(pn_islem_no, 'A');
      else
        --- islemi onaylayabilecek kisilere mail atar
        islem_onaylayacak_kullanici(pn_islem_no, vc_sube);
      
      end if;
    else
      insert into muh_islem_onay
        (numara,
         sira,
         onay_kullanici_kodu,
         onay_kullanici_rol_numara,
         onay_kullanici_bolum_kodu,
         onay_tarih,
         onay_sistem_tarihi,
         onay_aciklama,
         red_flag,
         onay_kull_bolum)
      values
        (pn_islem_no,
         vn_sira,
         pkg_global.GET_KULLANICIKOD,
         pkg_global.GET_ROLKOD,
         pkg_global.GET_SUBEKOD,
         pkg_muhasebe.banka_tarihi_bul,
         sysdate,
         ps_sebep,
         'E',
         pkg_global.get_bolumkod);
      update muh_islem t
         set t.durum              = 'R',
             onay_kull_kodu       = pkg_global.GET_KULLANICIKOD,
             onay_kull_rol_numara = pkg_global.GET_ROLKOD,
             onay_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
             onay_tarih           = pkg_muhasebe.banka_tarihi_bul,
             onay_kull_bolum      = pkg_global.get_bolumkod
       where t.numara = pn_islem_no;
      Harici_Kod_Cagir(pn_islem_no, 'After_Refuse'); -- Ýþlem Paketi Çaðýrýr
    
      Islem_Hareket_Log(pn_islem_no);
    
      -- islemi yaratan - dogrulayan - onaylayan kisilere mail atar
      islem_kullanici_gecmis(pn_islem_no, 'R');
    
      pkg_dekont.Dekont_sil(pn_islem_no); -- BNSPRPRO-4483
    
    end if;
  End;
  -------------------------------------------
  Procedure Iptal(pn_islem_no number, ps_sebep in varchar2 default null) is
    vn_sira      number;
    vn_islem_kod number;
    vc_hesap_no  varchar2(34);
  Begin
    If PKG_TX.Iptal_edilebilir_mi(pn_islem_no) = 0 Then
      pkg_hata.hata_yaz(254,
                        true,
                        'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                        ' ROL:' || pkg_global.GET_ROLKOD); -- Iptal yetkisi yok
    End if;
  
    Kilit_Test(pn_islem_no);
    update muh_islem
       set -- nd.09.06.2010 iptal->red-> iptal edilen iþlemler
                iptal_onay_kull_kodu = decode(durum,
                                              '3',
                                              null,
                                              iptal_onay_kull_kodu),
           iptal_onay_kull_rol_numara = decode(durum,
                                               '3',
                                               null,
                                               iptal_onay_kull_rol_numara),
           iptal_onay_kull_bolum_kodu = decode(durum,
                                               '3',
                                               null,
                                               iptal_onay_kull_bolum_kodu),
           iptal_onay_tarih           = decode(durum,
                                               '3',
                                               null,
                                               iptal_onay_tarih),
           -----------------------------------------------------
           durum                      = '1',
           iptal_kullanici_kodu       = pkg_global.GET_KULLANICIKOD,
           iptal_kullanici_rol_numara = pkg_global.GET_ROLKOD,
           iptal_kullanici_bolum_kodu = pkg_global.GET_SUBEKOD,
           iptal_tarih                = pkg_muhasebe.banka_tarihi_bul,
           iptal_sistem_tarihi        = sysdate,
           iptal_tamamlanma_tarihi    = pkg_muhasebe.banka_tarihi_bul,
           iptal_kullanici_bolum      = pkg_global.Get_BolumKod
     where numara = pn_islem_no;
  
    Islem_Hareket_Log(pn_islem_no);
  
    /* iptal islemi ile de ilgili detaylari tutmamiz gerekti MHA 200109 */
    begin
      select max(t.sira) + 1
        into vn_sira
        from muh_islem_onay t
       where t.numara = pn_islem_no;
    Exception
      when no_data_found then
        vn_sira := 1;
    end;
    if nvl(vn_sira, 0) = 0 Then
      vn_sira := 1;
    end if;
  
    insert into muh_islem_onay
      (numara,
       sira,
       iptal_kullanici_kodu,
       iptal_rol_numara,
       iptal_bolum_kodu,
       iptal_tarih,
       iptal_sistem_tarihi,
       iptal_aciklama,
       iptal_kullanici_bolum)
    values
      (pn_islem_no,
       vn_sira,
       pkg_global.GET_KULLANICIKOD,
       pkg_global.GET_ROLKOD,
       pkg_global.GET_SUBEKOD,
       pkg_muhasebe.banka_tarihi_bul,
       sysdate,
       ps_sebep,
       pkg_global.Get_BolumKod);
  
    select m.islem_kod, m.hesap_numara
      into vn_islem_kod, vc_hesap_no
      from muh_islem m
     where m.numara = pn_islem_no;
  
    bekleyen_islem_kontrol(pn_islem_no, vn_islem_kod, vc_hesap_no); --BNSPRPRO-3024
  
    Harici_Kod_Cagir(pn_islem_no, 'After_Canceling'); -- Ýþlem Paketi Çaðýrýr
  
  End;
  ---------------------------------------------
  Procedure P_EVENT_YARAT(pn_islem_no NUMBER) is
    vn_Islem_Kod MUH_ISLEM.ISLEM_KOD%TYPE;
    vs_Sql_Block VARCHAR2(1024);
  BEGIN
    -- FB. Asenkron Altyapı.03.02.2012
    vn_Islem_Kod := Pkg_Tx.Islem_kod(pn_islem_no);
    --
    PKG_EVENT.P_CREATE_EVENT(ps_Event_Kaynak_Sistem => 'AKUSTIK',
                             ps_Kaynak_tablo        => 'MUH_ISLEM',
                             ps_Kaynak_Islem_Tip    => vn_Islem_Kod,
                             ps_Kaynak_Refno        => pn_islem_no,
                             ps_Kaynak_Kanal        => Pkg_Global.wKanalKod);
  
  END;
  ------------------------------------------------------
  Procedure iptal_muhasebelestir(pn_islem_no number) is
    cursor c1 is
      select fis_numara
        from muh_fis_satir
       where fis_numara in
             (select NUMARA from muh_fis where islem_numara = pn_islem_no);
    vn_fis_numara number;
  Begin
    open c1;
    loop
      fetch c1
        into vn_fis_numara;
      if c1%notfound then
        exit;
      end if;
      pkg_muhasebe.fis_iptal(vn_fis_numara);
    end loop;
    close c1;
  
    -- Asenkron Altyapı. iptal islemleri icin
    P_EVENT_YARAT(pn_islem_no);
  
    Harici_Kod_Cagir(pn_islem_no, 'After_Canceling_Booking');
  
    pkg_dekont.Dekont_sil(pn_islem_no); -- BNSPRPRO-4483
  
    Kilit_Test(pn_islem_no);
    update muh_islem
       set durum                   = '2',
           iptal_tamamlanma_tarihi = pkg_muhasebe.banka_tarihi_bul
     where numara = pn_islem_no;
  
    Islem_Hareket_Log(pn_islem_no);
  
  Exception
    When no_data_found Then
      Rollback;
      pkg_hata.hata_yaz(255, true);
    When Others Then
      Rollback;
      Raise_application_error(-20100, SQLERRM);
  End;
  --------------------------------------------
  Procedure Iptal_Onay(pn_islem_no number,
                       pb_onay_red boolean default true,
                       ps_sebep    varchar2 default null) is
  
    vn_sira number;
  Begin
    if pkg_global.GET_SUBEKOD != '999' then
      If PKG_TX.Iptal_Onaylanabilir_mi(pn_islem_no) = 0 Then
        pkg_hata.hata_yaz(257,
                          true,
                          'KULLANICI:' || pkg_global.GET_KULLANICIKOD ||
                          ' ROL:' || pkg_global.GET_ROLKOD); -- Dogrulama yetkisi yok
      End if;
    end if;
    Kilit_Test(pn_islem_no);
    begin
      select max(t.sira) + 1
        into vn_sira
        from muh_islem_onay t
       where t.numara = pn_islem_no;
    Exception
      when no_data_found then
        vn_sira := 1;
    end;
    if nvl(vn_sira, 0) = 0 Then
      vn_sira := 1;
    end if;
    if pb_onay_red then
      if pkg_tx.kalan_iptal_onay_sayisi(pn_islem_no) > 0 then
        insert into muh_islem_onay
          (numara,
           sira,
           iptal_onay_kullanici_kodu,
           iptal_onay_rol_numara,
           iptal_onay_bolum_kodu,
           iptal_onay_tarih,
           iptal_onay_sistem_tarihi,
           iptal_onay_aciklama,
           iptal_onay_kull_bolum)
        values
          (pn_islem_no,
           vn_sira,
           pkg_global.GET_KULLANICIKOD,
           pkg_global.GET_ROLKOD,
           pkg_global.GET_SUBEKOD,
           pkg_muhasebe.banka_tarihi_bul,
           sysdate,
           ps_sebep,
           pkg_global.Get_BolumKod);
      
        update muh_islem m
           set m.iptal_onay_kalan_adet    = m.iptal_onay_kalan_adet - 1, /* her adimdaki iptal onaylayan bilgileri update olsun MHA 010708 */
               iptal_onay_kull_kodu       = pkg_global.GET_KULLANICIKOD,
               iptal_onay_kull_rol_numara = pkg_global.GET_ROLKOD,
               iptal_onay_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
               iptal_onay_tarih           = pkg_muhasebe.banka_tarihi_bul,
               iptal_onay_kull_bolum      = pkg_global.Get_BolumKod
         where m.numara = pn_islem_no;
      end if;
      if pkg_tx.kalan_iptal_onay_sayisi(pn_islem_no) = 0 then
        update muh_islem t
           set t.durum                    = '2',
               iptal_onay_kull_kodu       = pkg_global.GET_KULLANICIKOD,
               iptal_onay_kull_rol_numara = pkg_global.GET_ROLKOD,
               iptal_onay_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
               iptal_onay_tarih           = pkg_muhasebe.banka_tarihi_bul,
               iptal_onay_kull_bolum      = pkg_global.get_bolumkod
         where t.numara = pn_islem_no;
        Harici_Kod_Cagir(pn_islem_no, 'After_Canceling_Approval'); -- Ýþlem Paketi Çaðýrýr
      
        Islem_Hareket_Log(pn_islem_no);
      
        pkg_dekont.Dekont_sil(pn_islem_no); -- BNSPRPRO-4483
      
        iptal_muhasebelestir(pn_islem_no);
        delete from muh_islem_mail_gonder t where t.tx_no = pn_islem_no;
      
      end if;
    else
      insert into muh_islem_onay
        (numara,
         sira,
         iptal_onay_kullanici_kodu,
         iptal_onay_rol_numara,
         iptal_onay_bolum_kodu,
         iptal_onay_tarih,
         iptal_onay_sistem_tarihi,
         iptal_onay_aciklama,
         red_flag,
         iptal_onay_kull_bolum)
      values
        (pn_islem_no,
         vn_sira,
         pkg_global.GET_KULLANICIKOD,
         pkg_global.GET_ROLKOD,
         pkg_global.GET_SUBEKOD,
         pkg_muhasebe.banka_tarihi_bul,
         sysdate,
         ps_sebep,
         'E',
         pkg_global.get_bolumkod);
      update muh_islem t
         set t.durum                    = '3',
             iptal_onay_kull_kodu       = pkg_global.GET_KULLANICIKOD,
             iptal_onay_kull_rol_numara = pkg_global.GET_ROLKOD,
             iptal_onay_kull_bolum_kodu = pkg_global.GET_SUBEKOD,
             iptal_onay_tarih           = pkg_muhasebe.banka_tarihi_bul,
             iptal_onay_kull_bolum      = pkg_global.get_bolumkod
       where t.numara = pn_islem_no;
      Harici_Kod_Cagir(pn_islem_no, 'After_Canceling_Refuse'); -- Ýþlem Paketi Çaðýrýr
    
      Islem_Hareket_Log(pn_islem_no);
    
    end if;
  End;
  ---------------------------  Yardýmcý Fonksiyonlar
  Function Dogrulanabilir_mi(pn_islem_no number) return number is
    cursor c1 is
      select muh_islem.dogrulanmali_mi, muh_islem.durum
        from muh_islem
       where numara = pn_islem_no
         and durum = 'C';
    vd_banka_tarih date := pkg_muhasebe.Banka_Tarihi_Bul;
    Cursor C2 Is
      select 1
        from gnl_rol_islem_dogru rui,
             muh_islem           islem,
             gnl_zaman_pr        zaman,
             gnl_limit_pr        l
       where islem.numara = pn_islem_no
         and islem.durum in ('C')
         and islem.islem_kod = rui.islem_tanim_kod
         And (islem.amir_sube_kod = PKG_GLOBAL.GET_SUBEKOD OR exists
              (select 1
                 from gnl_kull_gm_sube_pr f
                where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD
                  and f.sube_kodu = islem.amir_sube_kod
                  and NVL(f.baslangic_tarihi, vd_banka_tarih) <=
                      vd_banka_tarih
                  and NVL(f.bitis_tarihi, vd_banka_tarih) >= vd_banka_tarih)
             /*islem.amir_sube_kod IN ( select f.sube_kodu
              From gnl_kull_gm_sube_pr f
             Where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD )*/
             )
         and rui.rol_numara = pkg_GLOBAL.GET_ROLKOD
         and ((nvl(rui.ayni_bolum, 'H') = 'H') or
             (nvl(rui.ayni_bolum, 'H') = 'E' and
             PKG_PERSONEL.kullanici_departmani(islem.kayit_kullanici_kodu) =
             PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD)))
         and ((rui.ayni_kullanici = 'H' and /*islem.kayit_kullanici_kodu != PKG_GLOBAL.GET_KULLANICIKOD MHA 151210*/
             PKG_GLOBAL.GET_KULLANICIKOD not in
             (select o.dogru_kullanici_kodu
                  from muh_islem_onay o
                 where o.numara = pn_islem_no
                   and o.dogru_kullanici_kodu is not null) and
             pkg_global.GET_KULLANICIKOD != islem.kayit_kullanici_kodu) or
             (rui.ayni_kullanici = 'E'))
         and rui.zaman_numara = zaman.numara
         and to_number(to_char(sysdate, 'HH24')) between baslangic and
             bitis
         and rui.limit_numara = l.kod
         and ((l.tum_dovizler = 'H' and l.karsilik = 'F' and
             nvl(islem.doviz_kod, pkg_genel_pr.lc_al) = l.doviz_kod and
             nvl(islem.tutar, 0) between Alt And Ust) OR
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,alt) and
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,ust) ) or
             (l.tum_dovizler = 'E' and l.karsilik = 'F' and
             nvl(islem.tutar, 0) between
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al MHA 250608*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   alt) and
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   ust)) or (l.karsilik = 'N'))
         and ((rui.ayni_rol = 'H' and /*nvl(islem.dogru_kull_rol_numara,0) != PKG_GLOBAL.GET_ROLKOD Bu kadari yeterli degil MHA 010708*/
             PKG_GLOBAL.GET_ROLKOD not in
             (select o.dogru_kullanici_rol_numara
                  from muh_islem_onay o
                 where o.numara = pn_islem_no
                   and o.dogru_kullanici_kodu is not null) and
             pkg_global.GET_ROLKOD != islem.kayit_kullanici_rol_numara) or
             (rui.ayni_rol = 'E'))
         and ((pkg_global.GET_KULLANICIKOD = 'PAYGATE' and exists
              (select 1
                  from muh_islem_paygate
                 where numarA = pn_islem_no
                   and durum = 'A')) OR
             (pkg_global.GET_KULLANICIKOD != 'PAYGATE' and not exists
              (select 1
                  from muh_islem_paygate
                 where numarA = pn_islem_no
                   and durum = 'A')));
  
    vc_dogrulama muh_islem.dogrulanmali_mi%type;
    vc_durum     muh_islem.durum%type;
    --ln_sira      number;
    vn_dummy number;
  
  Begin
    open c1;
    fetch c1
      into vc_dogrulama, vc_durum;
    close c1;
    if vc_dogrulama = 'H' then
      -- Dogrulanmaya gerek yok
      return 0;
    end if;
    open c2;
    fetch c2
      into vn_dummy;
    if c2%notfound then
      close c2;
      return 0; -- Dogrulama yetkisi yok
    end if;
    close c2;
    return 1;
  End;

  --*************************************
  Function Iptal_edilebilir_mi(pn_islem_no number) return number is
    vd_banka_tarih date := pkg_muhasebe.Banka_Tarihi_Bul;
    Cursor C2 is
      select 1
        from gnl_rol_islem_iptal rui,
             muh_islem           islem,
             gnl_zaman_pr        zaman,
             gnl_limit_pr        l,
             muh_islem_tanim_pr  islpr
       where islem.numara = pn_islem_no
         and islem.durum in ( /*'C','V','A',*/ 'P', '3') -- sadece tamamlanmis veya iptali reddedilmis islem iptal edilebilir
         and islem.islem_kod = islpr.kod -- sadece yetki olmasi yetmez
         and nvl(islpr.iptal_edilebilir_mi, 'H') = 'E' -- islemin taniminda iptal edilebilir olmasi gerekir
         and islem.islem_kod = rui.islem_tanim_kod
         And (islem.amir_sube_kod = PKG_GLOBAL.GET_SUBEKOD OR exists
              (select 1
                 from gnl_kull_gm_sube_pr f
                where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD
                  and f.sube_kodu = islem.amir_sube_kod
                  and NVL(f.baslangic_tarihi, vd_banka_tarih) <=
                      vd_banka_tarih
                  and NVL(f.bitis_tarihi, vd_banka_tarih) >= vd_banka_tarih)
             /*islem.amir_sube_kod IN ( select f.sube_kodu
              From gnl_kull_gm_sube_pr f
             Where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD )*/
             )
         and rui.rol_numara = pkg_GLOBAL.GET_ROLKOD
         and ((nvl(rui.ayni_bolum, 'H') = 'H') or
             (nvl(rui.ayni_bolum, 'H') = 'E' and
             PKG_PERSONEL.kullanici_departmani(islem.kayit_kullanici_kodu) =
             PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD)))
         and ((rui.ayni_kullanici = 'H' and
             islem.kayit_kullanici_kodu != PKG_GLOBAL.GET_KULLANICIKOD) or
             (rui.ayni_kullanici = 'E'))
         and rui.zaman_numara = zaman.numara
         and to_number(to_char(sysdate, 'HH24')) between baslangic and
             bitis
         and rui.limit_numara = l.kod
         and ((l.tum_dovizler = 'H' and l.karsilik = 'F' and
             nvl(islem.doviz_kod, pkg_genel_pr.lc_al) = l.doviz_kod and
             nvl(islem.tutar, 0) between Alt And Ust) OR
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,alt) and
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,ust) ) or
             (l.tum_dovizler = 'E' and l.karsilik = 'F' and
             nvl(islem.tutar, 0) between
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al MHA 250608*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   alt) and
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   ust)) or (l.karsilik = 'N'))
         and ((rui.ayni_rol = 'H' and
             ((islem.durum = 'P' AND
             nvl(islem.iptal_kullanici_rol_numara, 0) !=
             PKG_GLOBAL.GET_ROLKOD) or islem.durum = '3')) or
             (rui.ayni_rol = 'E'));
    vn_dummy number;
  Begin
  
    open c2;
    fetch c2
      into vn_dummy;
    if c2%notfound then
      close c2;
      return 0; -- Iptal yetkisi yok
    end if;
    close c2;
    return 1;
  End;
  -- *************************
  Function Iptal_Onaylanabilir_mi(pn_islem_no number) return number is
    vd_banka_tarih date := pkg_muhasebe.Banka_Tarihi_Bul;
    Cursor c2 is
      select 1
        from gnl_rol_islem_iptal_onay rui,
             muh_islem                islem,
             gnl_zaman_pr             zaman,
             gnl_limit_pr             l
       where islem.numara = pn_islem_no
         and islem.durum in ('1')
         and islem.islem_kod = rui.islem_tanim_kod
         And (islem.amir_sube_kod = PKG_GLOBAL.GET_SUBEKOD OR exists
              (select 1
                 from gnl_kull_gm_sube_pr f
                where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD
                  and f.sube_kodu = islem.amir_sube_kod
                  and NVL(f.baslangic_tarihi, vd_banka_tarih) <=
                      vd_banka_tarih
                  and NVL(f.bitis_tarihi, vd_banka_tarih) >= vd_banka_tarih)
             /*islem.amir_sube_kod IN ( select f.sube_kodu
              From gnl_kull_gm_sube_pr f
             Where f.kullanici_kodu = PKG_GLOBAL.GET_KULLANICIKOD )*/
             )
            
         and rui.rol_numara = pkg_GLOBAL.GET_ROLKOD
         and ((nvl(rui.ayni_bolum, 'H') = 'H') or
             (nvl(rui.ayni_bolum, 'H') = 'E' and
             PKG_PERSONEL.kullanici_departmani(islem.kayit_kullanici_kodu) =
             PKG_PERSONEL.Kullanici_Departmani(PKG_GLOBAL.GET_KULLANICIKOD)))
         and ((rui.ayni_kullanici = 'H' and
             islem.iptal_kullanici_kodu != PKG_GLOBAL.GET_KULLANICIKOD) or
             (rui.ayni_kullanici = 'E'))
         and rui.zaman_numara = zaman.numara
         and to_number(to_char(sysdate, 'HH24')) between baslangic and
             bitis
         and rui.limit_numara = l.kod
         and ((l.tum_dovizler = 'H' and l.karsilik = 'F' and
             nvl(islem.doviz_kod, pkg_genel_pr.lc_al) = l.doviz_kod and
             nvl(islem.tutar, 0) between Alt And Ust) OR
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,alt) and
             --                                           pkg_kur.doviz_cevir(pkg_genel_pr.fc_al,l.doviz_kod,null,ust) ) or
             (l.tum_dovizler = 'E' and l.karsilik = 'F' and
             nvl(islem.tutar, 0) between
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al MHA 250608*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   alt) and
             pkg_kur.doviz_cevir(l.doviz_kod /*pkg_genel_pr.fc_al*/,
                                   nvl(islem.doviz_kod, pkg_genel_pr.lc_al),
                                   null,
                                   ust)) or (l.karsilik = 'N'))
         and ((rui.ayni_rol = 'H' and
             nvl(islem.iptal_onay_kull_rol_numara, 0) !=
             PKG_GLOBAL.GET_ROLKOD) or (rui.ayni_rol = 'E'));
  
    vn_dummy number;
  Begin
    open c2;
    fetch c2
      into vn_dummy;
    if c2%notfound then
      close c2;
      return 0; -- Iptal Onay yetkisi yok
    end if;
    close c2;
    return 1;
  End;
  ------------------------------------------------------
  Procedure Muhasebelestir(pn_islem_no number) is
    ln_islem_kod number;
    ln_bpm_flag  varchar2(2);
  Begin
    -- FB. Asenkron Altyapı.03.02.2012
    P_EVENT_YARAT(pn_islem_no);
    --
    Harici_Kod_Cagir(pn_islem_no, 'Booking'); -- Ýþlem Paketi Çaðýrýr
    Kilit_Test(pn_islem_no);
    ln_bpm_flag := 'H';
    select islem_kod
      into ln_islem_kod
      from muh_islem
     where numara = pn_islem_no;
    if ln_islem_kod = 4001 then
      select nvl(t.bpm_flag, 'H')
        into ln_bpm_flag
        from gon_islem_tx t
       where t.tx_no = pn_islem_no;
    end if;
    if ln_bpm_flag = 'E' then
      update muh_islem
         set durum = '4', tamamlanma_tarihi = pkg_muhasebe.banka_tarihi_bul
       where numara = pn_islem_no;
    else
      update muh_islem
         set durum = 'P', tamamlanma_tarihi = pkg_muhasebe.banka_tarihi_bul
       where numara = pn_islem_no;
    end if;
    Islem_Hareket_Log(pn_islem_no);
  
  Exception
    When Others then
      /* local mesaj degerlerini nulllayalim ki baska islemcilerin onayinda patlatmasin MHA 150409*/
      -- dbms_output.put_line(dbms_utility.format_error_backtrace);
      Onay_mesaj        := null;
      Dogrula_mesaj     := null;
      Kaydet_mesaj      := null;
      pkg_global.wMesaj := null;
      Rollback;
      Raise_application_error(-20100, SQLERRM);
  End;
  ------------------------------------------------------
  Procedure Tamam(pn_islem_no number) is
  Begin
    null;
  End;
  ------------------------------------------------------
  Procedure Harici_Kod_Cagir(pn_islem_no   number,
                             pc_cikis_yeri varchar2,
                             pb_zorunlu_mu boolean default TRUE) is
    Cursor c1 is
      Select ci.islem_kod
        from user_procedures up, muh_islem ci
       where ci.numara = pn_islem_no
         and object_name = 'PKG_TRN' || to_char(ci.islem_kod)
         and procedure_name = upper(pc_cikis_yeri)
      UNION -- ERSIN baska semalardanda kod cagirabilsin diye
      Select ci.islem_kod
        from dba_procedures up2, muh_islem ci
       where ci.numara = pn_islem_no
         and object_name = 'PKG_TRN' || to_char(ci.islem_kod)
         and procedure_name = upper(pc_cikis_yeri)
         And up2.owner in ('WINSPIRE');
  
    vn_islem_kod   number;
    vs_plsql_block varchar2(2000);
  Begin
    if pkg_genel_pr.islem_batch_islem_mi(Islem_kod(pn_islem_no)) = 'E' then
      --Batch islemlerde callback fonksiyonlar cagrilmaz.
      return;
    end if;
    open c1;
    fetch c1
      into vn_islem_kod;
    if c1%notfound then
      close c1;
      If pb_zorunlu_mu Then
        -- Zorunlu degil varligini kontrol etme
        pkg_hata.hata_yaz(258, true, pc_cikis_yeri);
      End if;
      Return;
    end if;
    close c1;
    vs_plsql_block := 'BEGIN ' || 'PKG_TRN' || to_char(vn_islem_kod) || '.' ||
                      pc_cikis_yeri || '(' || to_char(pn_islem_no) || ');' ||
                      ' END;';
    EXECUTE IMMEDIATE vs_plsql_block;
  End;
  ------------------------------------------------
  Function Islem_kod(pn_islem_no number) return number is
    vn_islem_kod number;
  begin
    select islem_kod
      into vn_islem_kod
      from muh_islem
     where numara = pn_islem_no;
    return vn_islem_kod;
  end;
  ------------------------------------------------
  Function fis_no(pn_islem_no number) return number is
    vn_fis_no number;
  begin
    select max(numara)
      into vn_fis_no
      from muh_fis
     where muh_fis.islem_numara = pn_islem_no;
  
    return vn_fis_no;
  exception
    when no_data_found Or Too_Many_rows then
      return 0;
  end;
  ------------------------------------------------
  Function dogrula_guncelle(pn_islem_no number) return boolean is
    vc_dogrula_guncelle varchar2(1);
  begin
    select dogrula_guncelle
      into vc_dogrula_guncelle
      from muh_islem
     where numara = pn_islem_no;
    if vc_dogrula_guncelle = 'E' then
      return true;
    else
      return false;
    end if;
  end;
  ------------------------------------------------
  Function onay_guncelle(pn_islem_no number) return boolean is
    vc_onay_guncelle varchar2(1);
  begin
    select onay_guncelle
      into vc_onay_guncelle
      from muh_islem
     where numara = pn_islem_no;
    if vc_onay_guncelle = 'E' then
      return true;
    else
      return false;
    end if;
  end;
  ------------------------------------------------
  Function Islem_bitmis_mi(pn_islem_no number) return number is
    vn_dummy number;
  Begin
    select 1
      into vn_dummy
      from muh_islem
     where numara = pn_islem_no
       and durum in ('C', 'V', '1', 'A');
    return 0; -- hayir bitmemis
  Exception
    When no_data_found then
      return 1; -- evet bitmis veya yok
  End;
  ------------------------------------------------
  Function Islem_onaylanmis_mi(pn_islem_no number) return number is
    vn_dummy number;
  Begin
    select 1
      into vn_dummy
      from muh_islem
     where numara = pn_islem_no
       and durum in ('A', '3');
    return 0; -- onaylanmis
  Exception
    When no_data_found then
      return 1; -- onaylanmamis veya yok
  End;
  ------------------------------------------------
  Function islem_yaratilmis_mi(pn_islem_no number) return number is
    vn_dummy number;
  Begin
    select 1 into vn_dummy from muh_islem where numara = pn_islem_no;
    return 1; -- yaratilmis
  Exception
    When no_data_found then
      return 0; -- yaratilmamis
  End;
  ------------------------------------------------
  Function Islem_tamamlanmis_mi(pn_islem_no number) return number is
    /* statusu P ve 3 olan islemleri yakalamak icin yazildi. 221008 MHA */
    vn_dummy number;
  Begin
    select 1
      into vn_dummy
      from muh_islem
     where numara = pn_islem_no
       and durum in ('P', '3');
    return 0; -- onaylanmis
  Exception
    When no_data_found then
      return 1; -- onaylanmamis veya yok
  End;
  ------------------------------------------------
  Function Islem_SubeKodu_Al(pn_islem_no number)
    return gnl_sube_kod_pr.kod%type is
    vs_bolum_kodu gnl_sube_kod_pr.kod%type;
  begin
    select KAYIT_KULLANICI_BOLUM_KODU
      into vs_bolum_kodu
      from muh_islem
     where numara = pn_islem_no;
  
    return vs_bolum_kodu;
  end;
  ------------------------------------------------
  Function Amir_SubeKodu_Al(pn_islem_no number)
    return gnl_sube_kod_pr.kod%type is
    ls_bolum_kodu gnl_sube_kod_pr.kod%type;
  begin
    select AMIR_SUBE_KOD
      into ls_bolum_kodu
      from muh_islem
     where numara = pn_islem_no;
  
    return ls_bolum_kodu;
  end;
  ------------------------------------------------
  Function gecici_girilmis_mi(pn_islem_no number) return varchar2 is
    ln_satir_sayi number;
  begin
    select count(*)
      into ln_satir_sayi
      from muh_fis_satir s, muh_fis f
     where s.fis_numara = f.numara
       and f.islem_numara = pn_islem_no
       and f.TUR = 'T';
    if ln_satir_sayi > 0 then
      return 'E';
    else
      return 'H';
    end if;
  end;
  ------------------------------------------------
  Function islem_batch_mi(pn_islem_no number) return boolean is
    ps_dummy varchar2(1);
  Begin
    select batch_islem_mi
      into ps_dummy
      from muh_islem_tanim_pr cit, muh_islem ci
     where ci.islem_kod = cit.kod
       and numara = pn_islem_no;
    if ps_dummy = 'E' then
      return TRUE;
    else
      return FALSE;
    end if;
  End;
  ------------------------------------------------
  Procedure Dinamik_Onay_Belirle(pn_islem_no         number,
                                 pc_dogrulama        varchar2,
                                 pc_onay             varchar2,
                                 pc_iptal_onay       varchar2,
                                 pc_dogrula_guncelle varchar2,
                                 pc_onay_guncelle    varchar2) is
  Begin
    Kilit_Test(pn_islem_no);
    update muh_islem m
       set durum                   = 'C',
           dogrulanmali_mi         = nvl(pc_dogrulama, dogrulanmali_mi),
           m.dogrulanma_adet       = m.dogrulanma_adet +
                                     decode(pc_dogrulama, 'E', 1, 0),
           m.dogrulanma_kalan_adet = m.dogrulanma_kalan_adet +
                                     decode(pc_dogrulama, 'E', 1, 0),
           onaylanmali_mi          = nvl(pc_onay, onaylanmali_mi),
           m.onaylanma_adet        = m.onaylanma_adet +
                                     decode(pc_onay, 'E', 1, 0),
           m.onaylanma_kalan_adet  = m.onaylanma_kalan_adet +
                                     decode(pc_onay, 'E', 1, 0),
           iptal_onaylanmali_mi    = nvl(pc_iptal_onay, iptal_onaylanmali_mi),
           m.iptal_onay_adet       = m.iptal_onay_adet +
                                     decode(pc_iptal_onay, 'E', 1, 0),
           m.iptal_onay_kalan_adet = m.iptal_onay_kalan_adet +
                                     decode(pc_iptal_onay, 'E', 1, 0),
           dogrula_guncelle        = nvl(pc_dogrula_guncelle,
                                         dogrula_guncelle),
           onay_guncelle           = nvl(pc_onay_guncelle, onay_guncelle)
     where numara = pn_islem_no;
  
    Islem_Hareket_Log(pn_islem_no);
  
  End;
  ------------------------------------------------
  Function islem_durum(pn_islem_no number) return muh_islem.durum%type is
    ls_durum muh_islem.durum%type;
  begin
    select t.durum
      into ls_durum
      from muh_islem t
     where t.numara = pn_islem_no;
    return ls_durum;
  exception
    when no_data_found then
      select g.durum
        into ls_durum
        from muh_islem_gecici g
       where g.numara = pn_islem_no;
      return ls_durum;
  end;
  ------------------------------------------------
  Function msj_islem_durum(pn_islem_no number) return varchar2 is
    wfis_no      number;
    wglobalmesaj pkg_global.wMesaj%TYPE;
  begin
    wglobalmesaj      := Pkg_Global.wMesaj;
    Pkg_Global.wMesaj := null;
    case islem_durum(pn_islem_no)
      when 'C' then
        If Paygate_check(pn_islem_no) = 'E' then
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 5247,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Kaydet_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          else
            return pkg_hata.mesajOlustur(pmesaj_no => 5247,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Kaydet_Mesaj_Parametresi;
          end if;
        Else
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 300,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 303,
                                                                                                                  p1        => kalan_dogrulama_sayisi(pn_islem_no),
                                                                                                                  p2        => kalan_onay_sayisi(pn_islem_no)) || chr(10) || chr(13) || Kaydet_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 300,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 303,
                                                                                                                  p1        => kalan_dogrulama_sayisi(pn_islem_no),
                                                                                                                  p2        => kalan_onay_sayisi(pn_islem_no)) || chr(10) || chr(13) || Kaydet_Mesaj_Parametresi;
          End If;
        End if;
      when 'V' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 309, p1 => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 302,
                                                                                                                           p1        => kalan_onay_sayisi(pn_islem_no)) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 309, p1 => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 302,
                                                                                                                           p1        => kalan_onay_sayisi(pn_islem_no)) || chr(10) || chr(13);
        End If;
      
      when 'A' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 310, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 310, p1 => pn_islem_no);
        End If;
      
      when 'P' then
        -- Eger fis kesilmiþse fis numarasýnýda yazsýn
        wfis_no := PKG_TX.fis_no(pn_islem_no);
      
        If wfis_no is null Then
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        Else
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        End if;
      when 'D' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 307, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 307, p1 => pn_islem_no);
        End If;
      when 'R' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 307, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 307, p1 => pn_islem_no);
        End If;
      when '1' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 306, p1 => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 302,
                                                                                                                           p1        => kalan_iptal_onay_sayisi(pn_islem_no)) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 306, p1 => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 302,
                                                                                                                           p1        => kalan_iptal_onay_sayisi(pn_islem_no));
        End If;
      when '2' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 313, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 313, p1 => pn_islem_no);
        End If;
      when '3' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 1028,
                                       p1        => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 1028,
                                       p1        => pn_islem_no);
        End If;
      when 'G' then
        /* Geri Cevrilme veya Taslak durumunda artik No_data_found olmayacak MHA 150908 */
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 314, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 314, p1 => pn_islem_no);
        End If;
      when 'G' then
        /* Geri Cevrilme veya Taslak durumunda artik No_data_found olmayacak MHA 150908 */
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 314, p1 => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 314, p1 => pn_islem_no);
        End If;
      when 'T' then
        If wglobalmesaj is not null then
          return pkg_hata.mesajOlustur(pmesaj_no => 1056,
                                       p1        => pn_islem_no) || chr(10) || chr(13) || wglobalmesaj;
        Else
          return pkg_hata.mesajOlustur(pmesaj_no => 1056,
                                       p1        => pn_islem_no);
        End If;
      when '4' then
        -- Eger fis kesilmiþse fis numarasýnýda yazsýn
        wfis_no := PKG_TX.fis_no(pn_islem_no);
      
        If wfis_no is null Then
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        Else
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        End if;
      when '5' then
        -- Eger fis kesilmiþse fis numarasýnýda yazsýn
        wfis_no := PKG_TX.fis_no(pn_islem_no);
      
        If wfis_no is null Then
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        Else
          If wglobalmesaj is not null then
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi || chr(10) || chr(13) || wglobalmesaj;
          Else
            return pkg_hata.mesajOlustur(pmesaj_no => 308,
                                         p1        => pn_islem_no) || chr(10) || chr(13) || pkg_hata.mesajOlustur(pmesaj_no => 312,
                                                                                                                  p1        => wfis_no) || chr(10) || chr(13) || Onay_Mesaj_Parametresi;
          End If;
        End if;
    end case;
  Exception
    When No_Data_Found Then
      Return pkg_hata.mesajOlustur(pmesaj_no => 314, p1 => pn_islem_no);
    
  end;

  --********************************************
  --bilalg
  Procedure Onay_Mesaj_Parametresi(ps_mesaj varchar2) is
  begin
    Onay_mesaj := ps_mesaj;
  end;

  Function Onay_Mesaj_Parametresi return varchar2 is
    ls_mesaj varchar2(2000);
  begin
    ls_mesaj   := Onay_mesaj;
    Onay_mesaj := '';
    return ls_mesaj;
  end;
  --********************************************
  --bilalg
  Procedure Dogrula_Mesaj_Parametresi(ps_mesaj varchar2) is
  begin
    Dogrula_mesaj := ps_mesaj;
  end;

  Function Dogrula_Mesaj_Parametresi return varchar2 is
    ls_mesaj varchar2(2000);
  begin
    ls_mesaj      := Dogrula_mesaj;
    Dogrula_mesaj := '';
    return ls_mesaj;
  end;

  --********************************************
  --bilalg
  Procedure Kaydet_Mesaj_Parametresi(ps_mesaj varchar2) is
  begin
    Kaydet_mesaj := ps_mesaj;
  end;

  Function Kaydet_Mesaj_Parametresi return varchar2 is
    ls_mesaj varchar2(2000);
  begin
    ls_mesaj     := Kaydet_mesaj;
    Kaydet_mesaj := '';
    return ls_mesaj;
  end;

  --********************************************

  Function IslemKodOnayKont(pn_islem_kod Number) Return Number Is
    OnaysizTx Number;
  Begin
    Select Nvl(Max(numara), 0)
      Into OnaysizTx
      From muh_islem m
     Where islem_kod = pn_islem_kod
       And kayit_tarih = pkg_muhasebe.banka_tarihi_bul
       And durum in ('C', 'V', '1', 'A');
    Return OnaysizTx;
    --Sıfır döndüğünde onaysız yok
  End;
  -- *********************************Geri cevirme kýsýmlarý
  procedure islem_geri_gonder(pn_islem_no number,
                              ps_sebep    varchar2 default null) is
    /*     cursor c1 is
      select numara
        from Muh_fis
       where islem_numara = pn_islem_no;
    ln_fis_numara number;*/
    vn_sira number;
  Begin
    if geri_cevrilebilir_mi(pn_islem_no) = 0 then
      pkg_hata.hata_yaz(1683, true);
    end if;
  
    Kilit_Test(pn_islem_no);
  
    insert into MUH_ISLEM_durum_log
      (Numara,
       Islem_Kod,
       Geric_Kullanici_Kodu,
       Geric_Kullanici_Rol_Numara,
       Geric_Kullanici_Bolum_Kodu,
       Geric_Tarih,
       GERIC_SISTEM_TARIH,
       Geric_Aciklama,
       Durum,
       Amir_Sube_Kod,
       Kayit_Kullanici_Kodu,
       Kayit_Kullanici_Rol_Numara,
       Kayit_Kullanici_Bolum_Kodu,
       Kayit_Tarih,
       Efektif_Banka_Tarih,
       MODUL_TUR_KOD,
       URUN_TUR_KOD,
       URUN_SINIF_KOD,
       MUSTERI_NUMARA,
       HESAP_NUMARA,
       TUTAR,
       DOVIZ_KOD,
       KANAL_NUMARA,
       KASA_KOD,
       FIS_NUMARA,
       DOGRULANMALI_MI,
       DOGRULANMA_ADET,
       ONAYLANMALI_MI,
       ONAYLANMA_ADET,
       DOGRULA_GUNCELLE,
       ONAY_GUNCELLE,
       IPTAL_KULLANICI_KODU,
       IPTAL_KULLANICI_ROL_NUMARA,
       IPTAL_KULLANICI_BOLUM_KODU,
       IPTAL_TARIH,
       IPTAL_ONAYLANMALI_MI,
       IPTAL_ONAY_ADET,
       IPTAL_ONAY_TARIH,
       KAYIT_SISTEM_TARIHI,
       IPTAL_SISTEM_TARIHI,
       TAMAMLANMA_TARIHI,
       IPTAL_TAMAMLANMA_TARIHI,
       Kanal_Alt_kod,
       KAYIT_KULLANICI_BOLUM,
       IPTAL_KULLANICI_BOLUM,
       DOGRU_KULL_BOLUM,
       ONAY_KULL_BOLUM,
       IPTAL_ONAY_KULL_BOLUM)
      (select NUMARA,
              ISLEM_KOD,
              pkg_global.GET_KULLANICIKOD,
              pkg_global.GET_ROLKOD,
              pkg_global.GET_SUBEKOD,
              pkg_muhasebe.banka_tarihi_bul,
              sysdate,
              ps_sebep,
              DURUM,
              AMIR_SUBE_KOD,
              KAYIT_KULLANICI_KODU,
              KAYIT_KULLANICI_ROL_NUMARA,
              KAYIT_KULLANICI_BOLUM_KODU,
              KAYIT_TARIH,
              EFEKTIF_BANKA_TARIH,
              MODUL_TUR_KOD,
              URUN_TUR_KOD,
              URUN_SINIF_KOD,
              MUSTERI_NUMARA,
              HESAP_NUMARA,
              TUTAR,
              DOVIZ_KOD,
              KANAL_NUMARA,
              KASA_KOD,
              FIS_NUMARA,
              DOGRULANMALI_MI,
              DOGRULANMA_ADET,
              ONAYLANMALI_MI,
              ONAYLANMA_ADET,
              DOGRULA_GUNCELLE,
              ONAY_GUNCELLE,
              IPTAL_KULLANICI_KODU,
              IPTAL_KULLANICI_ROL_NUMARA,
              IPTAL_KULLANICI_BOLUM_KODU,
              IPTAL_TARIH,
              IPTAL_ONAYLANMALI_MI,
              IPTAL_ONAY_ADET,
              IPTAL_ONAY_TARIH,
              KAYIT_SISTEM_TARIHI,
              IPTAL_SISTEM_TARIHI,
              TAMAMLANMA_TARIHI,
              IPTAL_TAMAMLANMA_TARIHI,
              Kanal_Alt_kod,
              KAYIT_KULLANICI_BOLUM,
              IPTAL_KULLANICI_BOLUM,
              DOGRU_KULL_BOLUM,
              ONAY_KULL_BOLUM,
              IPTAL_ONAY_KULL_BOLUM
         from muh_islem
        Where numara = pn_islem_no);
  
    Insert Into Muh_Islem_Gecici
      (NUMARA,
       ISLEM_KOD,
       DURUM,
       AMIR_SUBE_KOD,
       KAYIT_KULLANICI_KODU,
       KAYIT_KULLANICI_ROL_NUMARA,
       KAYIT_KULLANICI_BOLUM_KODU,
       KAYIT_TARIH,
       EFEKTIF_BANKA_TARIH,
       MODUL_TUR_KOD,
       URUN_TUR_KOD,
       URUN_SINIF_KOD,
       MUSTERI_NUMARA,
       HESAP_NUMARA,
       TUTAR,
       DOVIZ_KOD,
       KANAL_NUMARA,
       KASA_KOD,
       FIS_NUMARA,
       DOGRULANMALI_MI,
       DOGRULANMA_ADET,
       ONAYLANMALI_MI,
       ONAYLANMA_ADET,
       DOGRULA_GUNCELLE,
       ONAY_GUNCELLE,
       IPTAL_KULLANICI_KODU,
       IPTAL_KULLANICI_ROL_NUMARA,
       IPTAL_KULLANICI_BOLUM_KODU,
       IPTAL_TARIH,
       IPTAL_ONAYLANMALI_MI,
       IPTAL_ONAY_ADET,
       IPTAL_ONAY_TARIH,
       KAYIT_SISTEM_TARIHI,
       IPTAL_SISTEM_TARIHI,
       TAMAMLANMA_TARIHI,
       IPTAL_TAMAMLANMA_TARIHI,
       Kanal_Alt_kod,
       Aciklama,
       KAYIT_KULLANICI_BOLUM,
       IPTAL_KULLANICI_BOLUM,
       DOGRU_KULL_BOLUM,
       ONAY_KULL_BOLUM,
       IPTAL_ONAY_KULL_BOLUM)
      (select NUMARA,
              ISLEM_KOD,
              DURUM,
              AMIR_SUBE_KOD,
              KAYIT_KULLANICI_KODU,
              KAYIT_KULLANICI_ROL_NUMARA,
              KAYIT_KULLANICI_BOLUM_KODU,
              KAYIT_TARIH,
              EFEKTIF_BANKA_TARIH,
              MODUL_TUR_KOD,
              URUN_TUR_KOD,
              URUN_SINIF_KOD,
              MUSTERI_NUMARA,
              HESAP_NUMARA,
              TUTAR,
              DOVIZ_KOD,
              KANAL_NUMARA,
              KASA_KOD,
              FIS_NUMARA,
              DOGRULANMALI_MI,
              DOGRULANMA_ADET,
              ONAYLANMALI_MI,
              ONAYLANMA_ADET,
              DOGRULA_GUNCELLE,
              ONAY_GUNCELLE,
              IPTAL_KULLANICI_KODU,
              IPTAL_KULLANICI_ROL_NUMARA,
              IPTAL_KULLANICI_BOLUM_KODU,
              IPTAL_TARIH,
              IPTAL_ONAYLANMALI_MI,
              IPTAL_ONAY_ADET,
              IPTAL_ONAY_TARIH,
              KAYIT_SISTEM_TARIHI,
              IPTAL_SISTEM_TARIHI,
              TAMAMLANMA_TARIHI,
              IPTAL_TAMAMLANMA_TARIHI,
              Kanal_Alt_kod,
              ps_sebep,
              KAYIT_KULLANICI_BOLUM,
              IPTAL_KULLANICI_BOLUM,
              DOGRU_KULL_BOLUM,
              ONAY_KULL_BOLUM,
              IPTAL_ONAY_KULL_BOLUM
         from muh_islem
        Where numara = pn_islem_no);
  
    pkg_kur_rezervasyon.rezervasyon_kullanim_iptal(pn_islem_no);
  
    update muh_islem_gecici set durum = 'G' where numara = pn_islem_no;
  
    /*    Geri cevirmede henuz fis yok. Silinmesi mantiksiz.
       Eger ihtiyac varsa After_REVERT içine yazilabilir
    open c1;
      loop
        fetch c1 into ln_fis_numara;
        exit when c1%notfound;
        pkg_muhasebe.fis_iptal(ln_fis_numara);
      end loop;
      close c1;
    */
  
    Harici_Kod_Cagir(pn_islem_no, 'After_Revert', FALSE); -- Pakette Varsa calistir yoksa bisey yapma
  
    --- islemi yaratan kullaniciya mail gider
    islem_kullanici_gecmis(pn_islem_no, 'G');
  
    delete from muh_islem where numara = pn_islem_no;
  
    delete from muh_islem_cagrilan where numara = pn_islem_no;
    
    delete from muh_islem_client_info where numara = pn_islem_no;
  
    Delete From muh_islem_onay where numara = pn_islem_no; /* tüm islem gecmis adimlarini kaybediyor,silinmesin MHA 030212 Silinmesi lazim 2. bir daha geri cevrilirse dogrulayanlar tekrar dogrulama yapamiyor  MHA 230312 */
  
    begin
      select max(t.sira) + 1
        into vn_sira
        from muh_islem_onay t
       where t.numara = pn_islem_no;
    Exception
      when no_data_found then
        vn_sira := 1;
    end;
    if nvl(vn_sira, 0) = 0 Then
      vn_sira := 1;
    end if;
  
    /* Geri cevirme islemi için bir kayit yaratalým MHA 290310 */
    insert into muh_islem_onay
      (numara,
       sira,
       gcevir_kullanici_kodu,
       gcevir_kullanici_rol_numara,
       gcevir_kullanici_bolum_kodu,
       gcevir_tarih,
       gcevir_sistem_tarih,
       gcevir_aciklama)
    values
      (pn_islem_no,
       vn_sira,
       pkg_global.GET_KULLANICIKOD,
       pkg_global.GET_ROLKOD,
       pkg_global.GET_SUBEKOD,
       pkg_muhasebe.banka_tarihi_bul,
       sysdate,
       ps_sebep);
  
    pkg_dekont.Dekont_sil(pn_islem_no); -- BNSPRPRO-4483  -- islem geri cevrilirse dekontu Kapalý duruma getirilsin.
  
    Islem_Hareket_Log(pn_islem_no);
  
    /*    Exception
    When Others Then
    PKG_HATA.hata_yaz(44,TRUE,SQLERRM); alttaki hatalari kamufle ediyor MHA 030609 */
  end;
  ----------------------------
  Function geri_cevrilebilir_mi(pn_islem_no number) return number is
  
    vn_yetkili_user number := pkg_tx.Dogrulanabilir_mi(pn_islem_no) +
                              pkg_tx.Onaylanabilir_mi(pn_islem_no);
    cursor c_1 is
      select 1
        from muh_islem_tanim_pr
       where geri_cevrilebilir = 'E'
         and kod =
             (select islem_kod from muh_islem where numara = pn_islem_no)
         and exists
       (select 1
                from muh_islem p
               where numara = pn_islem_no
                 and durum in ('C', 'V')
                 and kanal_numara in ('1')
                 and (p.kayit_kullanici_kodu != pkg_global.GET_KULLANICIKOD OR
                     (p.kayit_kullanici_kodu = pkg_global.GET_KULLANICIKOD and
                     vn_yetkili_user >= 1)));
    ln_temp number;
  begin
    open c_1;
    fetch c_1
      into ln_temp;
    if c_1%notfound then
      ln_temp := 0;
    else
      ln_temp := 1;
    end if;
    close c_1;
    return ln_temp;
  end;
  ----------------------------
  Procedure islemden_mail_gonder(p_TX_NO        number,
                                 p_MAIL_TO      MUH_ISLEM_MAIL_GONDER.MAIL_TO%type default null,
                                 p_MAIL_SUBJECT MUH_ISLEM_MAIL_GONDER.MAIL_SUBJECT%type default null,
                                 p_MAIL_BODY    MUH_ISLEM_MAIL_GONDER.MAIL_BODY%type default null,
                                 p_MAIL_FROM    MUH_ISLEM_MAIL_GONDER.MAIL_FROM%type default null,
                                 p_FILE_PATH    MUH_ISLEM_MAIL_GONDER.File_Path%type default null,
                                 p_FILE_NAME    MUH_ISLEM_MAIL_GONDER.FILE_NAME%type default null,
                                 p_FILE_CONTENT MUH_ISLEM_MAIL_GONDER.File_Content%type default null) is
    vs_mail_to MUH_ISLEM_MAIL_GONDER.MAIL_TO%type;
  
  begin
    if p_MAIL_TO is null then
      vs_mail_to := pkg_tablo.kullanici(pkg_global.GET_KULLANICIKOD).email;
    else
      vs_mail_to := p_MAIL_TO;
    end if;
  
    /*    insert into muh_islem_mail_gonder    (tx_no, mail_from, mail_to, mail_subject, mail_body, file_path, file_name, file_content)
       values (p_TX_NO, nvl(p_MAIL_FROM,'bnspr@calikbank.com.tr'), l_mail_to, p_mail_subject, p_mail_body, p_file_path, p_file_name, p_file_content);
    artik maillar tek bir yerden gonderilecek ID numarasi alacak MHA 150908 */
  
    pkg_mail.send_mail(ps_mail_from    => NVL(p_MAIL_FROM,
                                              'Akustik@aktifbank.com.tr'),
                       ps_mail_to      => vs_mail_to,
                       ps_mail_cc      => null,
                       ps_mail_bcc     => null,
                       ps_mail_subject => p_MAIL_SUBJECT,
                       ps_mail_body    => p_MAIL_BODY,
                       pn_tx_no        => p_TX_NO,
                       ps_html_eh      => 'H',
                       ps_FILE_PATH    => p_FILE_PATH,
                       ps_FILE_NAME    => p_FILE_NAME,
                       ps_FILE_CONTENT => p_FILE_CONTENT);
  
  end;
  --*************************************
  Function son_dogrulama_saat(tx_islem_no in number) return varchar2 is
    cursor c_isldogru is
      select to_char(o.dogrulama_sistem_tarihi, 'HH24:MI:SS')
        from muh_islem_onay o
       where o.numara = tx_islem_no
         and o.dogru_kullanici_kodu is not null
       order by o.sira desc;
    vs_islsaat varchar2(8);
  Begin
    open c_isldogru;
    Fetch c_isldogru
      into vs_islsaat;
    close c_isldogru;
  
    return vs_islsaat;
  End son_dogrulama_saat;
  --*************************************
  Function son_onaylama_saat(tx_islem_no in number) return varchar2 is
    cursor c_islonay is
      select to_char(o.onay_sistem_tarihi, 'HH24:MI:SS')
        from muh_islem_onay o
       where o.numara = tx_islem_no
         and o.onay_kullanici_kodu is not null
       order by o.sira desc;
    vs_islsaat varchar2(8);
  Begin
    open c_islonay;
    Fetch c_islonay
      into vs_islsaat;
    close c_islonay;
  
    return vs_islsaat;
  End son_onaylama_saat;
  --*************************************
  Function son_dogrulama_sistem_tarih(tx_islem_no in number) return date is
    cursor c_isldogru is
      select o.dogrulama_sistem_tarihi
        from muh_islem_onay o
       where o.numara = tx_islem_no
         and o.dogru_kullanici_kodu is not null
       order by o.sira desc;
    vs_isltar date;
  Begin
    open c_isldogru;
    Fetch c_isldogru
      into vs_isltar;
    close c_isldogru;
  
    return vs_isltar;
  End son_dogrulama_sistem_tarih;
  --*************************************
  Function son_onaylama_sistem_tarih(tx_islem_no in number) return date is
    cursor c_islonay is
      select o.onay_sistem_tarihi
        from muh_islem_onay o
       where o.numara = tx_islem_no
         and o.onay_kullanici_kodu is not null
       order by o.sira desc;
    vs_isldate date;
  Begin
    open c_islonay;
    Fetch c_islonay
      into vs_isldate;
    close c_islonay;
  
    return vs_isldate;
  End son_onaylama_sistem_tarih;
  --*************************************
  Function fis_saat(tx_islem_no in number) return varchar2 is
    cursor c_islonay is
      select to_char(f.yarat_tar, 'HH24:MI:SS')
        from muh_fis f
       where f.islem_numara = tx_islem_no;
    vs_islsaat varchar2(8);
  Begin
    open c_islonay;
    Fetch c_islonay
      into vs_islsaat;
    close c_islonay;
  
    return vs_islsaat;
  End fis_saat;
  /********************************************************/
  Function islem_detay(pn_islem_no number) Return Pkg_Types.RC_ResultSet Is
    RC_islemDetay PKG_Types.RC_ResultSet;
  Begin
    open RC_islemDetay for
      Select * from muh_islem m where m.numara = pn_islem_no;
    Return RC_islemDetay;
  Exception
    when no_data_found then
      return null;
  End islem_detay;
  /********************************************************/
  Function islem_kanal_al(pn_islem_no number) return varchar2 is
    vc_kanal_numara gnl_kanal_grup_kod_pr.kod%type;
  begin
    select kanal_numara
      into vc_kanal_numara
      from muh_islem
     where numara = pn_islem_no;
  
    return vc_kanal_numara;
  End islem_kanal_al;
  /********************************************************/
  Function islem_referans_al(pn_islem_no number) return varchar2 is
    cursor c_ref is
      select s.referans
        from muh_fis_satir s
       where s.fis_numara IN
             (select f.numara
                from muh_fis f
               where f.islem_numara = pn_islem_no)
         and s.referans is not null;
    r_ref muh_fis_satir.referans%TYPE;
  Begin
    open c_ref;
    Fetch c_ref
      into r_ref;
    close c_ref;
  
    return r_ref;
  End islem_referans_al;

  /********************************************************/

  Procedure bekleyen_islem_kontrol(pn_tx_no     number,
                                   pn_islem_kod number,
                                   pc_hesap_no  varchar2) is
    --Bu proc. muh_islem tablosunda kayit olustuktan sonra kullanilabilir.
  
    cursor c_bekleyen_kontrol(p_kontrol_tip varchar2, p_hesap_no varchar2) is
      select i.numara
        from muh_islem i
       where p_kontrol_tip = 'HESAP_NO'
         and i.numara <> pn_tx_no
         and i.hesap_numara = p_hesap_no
         and i.durum in ('C', 'V', '1', 'A') --bitmemis islemler
       order by i.numara desc;
    --Referans ile ilgili kontroller baslayinca burasi acilacak...
    /*union
    select tx_no
    from muh_islem i
    where p_kontrol_tip='REFERANS'
    and p_hesap_no <>pn_tx_no
    and i.referans=pc_referans
    and pkg_tx.Islem_bitmis_mi(i.numara)= 0*/ --bitmemis islemler
  
    r_bekleyen_kontrol        c_bekleyen_kontrol%rowtype;
    vs_bekleyen_islem_kontrol muh_islem_tanim_pr.bekleyen_islem_kontrol%type;
    vn_hesap_no               number;
  begin
  
    --BNSPRPRO-3024
  
    select it.bekleyen_islem_kontrol
      into vs_bekleyen_islem_kontrol
      from muh_islem_tanim_pr it
     where it.kod = pn_islem_kod;
  
    --BNSPRPRO-3024
    if vs_bekleyen_islem_kontrol is not null then
    
      open c_bekleyen_kontrol(vs_bekleyen_islem_kontrol, pc_hesap_no);
      fetch c_bekleyen_kontrol
        into r_bekleyen_kontrol;
    
      if c_bekleyen_kontrol%FOUND then
        --bekleyen islem var
        if vs_bekleyen_islem_kontrol = 'HESAP_NO' then
          pkg_hata.hata_yaz(337, true, r_bekleyen_kontrol.numara);
        elsif vs_bekleyen_islem_kontrol = 'REFERANS' then
          pkg_hata.hata_yaz(1377, true, r_bekleyen_kontrol.numara);
        end if;
      end if;
    
      close c_bekleyen_kontrol;
    
    end if;
  exception
    when no_data_found then
      null;
  end;

  /********************************************************/
  Function islem_baslangic_zaman(tx_islem_no number) return date is
    vd_zaman date;
  begin
    select l.baslangic_tarihi
      into vd_zaman
      from muh_islem l
     where l.numara = tx_islem_no;
  
    return vd_zaman;
  
  exception
    when no_data_found then
      return null;
  end;
  /********************************************************/

  Function onceki_onaylanmis_tx_no(p_tx_no number) return number is
    v_tx_no       number;
    v_islem_tablo muh_islem_tanim_pr.tx_tablo_adi%type;
    query_str     VARCHAR2(1000);
  
  begin
  
    --bu func. tekrar düzenlenecek. çok saçma oldu.
  
    begin
      select it.tx_tablo_adi
        into v_islem_tablo
        from muh_islem_tanim_pr it
       where it.kod = pkg_tx.Islem_kod(p_tx_no)
         and exists
       (select 1
                from all_tables t
               where t.owner = 'BNSPR'
                 and upper(t.table_name) = upper(it.tx_tablo_adi));
    exception
      when no_data_found then
        null;
    end;
  
    if v_islem_tablo is not null then
    
      select max(i.numara)
        into v_tx_no
        from muh_islem i, muh_islem_tanim_pr p
       where i.numara < p_tx_no
         and i.islem_kod = p.kod
         and upper(p.tx_tablo_adi) = upper(v_islem_tablo) --ayný iþlem grubu.  Giriþ - Güncelleme
         and pkg_tx.Islem_tamamlanmis_mi(i.numara) = 0; -- Onaylanmýþ
    
    else
    
      select max(i.numara)
        into v_tx_no
        from muh_islem i
       where i.numara < p_tx_no
         and i.islem_kod = pkg_tx.Islem_kod(p_tx_no) --ayný iþlem
         and pkg_tx.Islem_tamamlanmis_mi(i.numara) = 0; -- Onaylanmýþ
    end if;
  
    return v_tx_no;
  
  exception
    when no_data_found then
      return null;
  end;

  /********************************************************/

  procedure islem_mail_gonder(pn_islem_no   number,
                              pc_kull_kod   varchar2,
                              pn_body_ack   number,
                              pn_islem_ack  varchar2,
                              pn_musteri_no number,
                              p1            varchar2 default null) is
    vc_mail_subject varchar2(1200);
    vc_mail_body    varchar2(2000);
    vc_mail_to      varchar2(2000);
  
    cursor c1 is
      select c.email from gnl_kullanici c where c.kod = pc_kull_kod;
    vc_mail gnl_kullanici.email%type;
  
    vn_basvuru_no bir_basvuru.basvuru_no%type;
  
  begin
    open c1;
    fetch c1
      into vc_mail;
    close c1;
  
    vc_mail_subject := pn_islem_ack;
    if pn_body_ack = 255 then
      --#1 ekranından tamamlanan #2 müşteri no'lu #3 isimli #4 no'lu işlem için #5 ekranından işlem yapabilirsiniz. (#6 ortamında)
      vc_mail_body := pkg_dekont.AciklamaOlustur(pn_body_ack,
                                                 pn_islem_ack,
                                                 pn_musteri_no,
                                                 pkg_musteri.unvan(pn_musteri_no),
                                                 pn_islem_no,
                                                 p1,
                                                 pkg_genel_pr.database_adi);
    elsif pn_body_ack = 250 then
      -- #1 müşteri no'lu #2 için #3 no'lu #4 işlemi onayınıza sunulmuştur. (#5 ortamında)
      vc_mail_body := pkg_dekont.AciklamaOlustur(pn_body_ack,
                                                 pn_musteri_no,
                                                 pkg_musteri.unvan(pn_musteri_no),
                                                 pn_islem_no,
                                                 pn_islem_ack,
                                                 pkg_genel_pr.database_adi);
    else
      --#1 müşteri no'lu #2 için #3 no'lu #4 işlemi #5 tarafından tamamlanmıştır. (#6 ortamında)
      vc_mail_body := pkg_dekont.AciklamaOlustur(pn_body_ack,
                                                 pn_musteri_no,
                                                 pkg_musteri.unvan(pn_musteri_no),
                                                 pn_islem_no,
                                                 pn_islem_ack,
                                                 p1,
                                                 pkg_genel_pr.database_adi);
    end if;
  
    vc_mail_to := vc_mail;
    pkg_mail.send_mail_nocommit(ps_mail_from    => 'aktifbank@aktifbank.com.tr',
                                ps_mail_to      => vc_mail_to,
                                ps_mail_cc      => null,
                                ps_mail_bcc     => null,
                                ps_mail_subject => vc_mail_subject,
                                ps_mail_body    => vc_mail_body,
                                ps_html_eh      => 'E',
                                pn_tx_no        => pn_islem_no);
  
    --Bono satislarinda gonderilen standart mail icerigini update etmek için eklendi
    Begin
      Harici_Kod_Cagir(pn_islem_no, 'Mail_Body_Update');
    exception
      when others then
        null;
    end;
  
  end;

  /********************************************************/
  procedure islem_onaylayacak_kullanici(pn_islem_no number,
                                        pc_sube     varchar2) is
    p_rec         RC_REF;
    vc_kul        gnl_kullanici.kod%type;
    vn_musteri_no number;
    cursor c1 is
      select m.musteri_numara, m.islem_kod, p.aciklama, p.mail_gonder
        from muh_islem m, muh_islem_tanim_pr p
       where m.numara = pn_islem_no
         and m.islem_kod = p.kod;
    vn_islem_kod   muh_islem.islem_kod%type;
    vc_islem_ack   muh_islem_tanim_pr.aciklama%type;
    vc_mail_gonder muh_islem_tanim_pr.mail_gonder%type;
  begin
    open c1;
    fetch c1
      into vn_musteri_no, vn_islem_kod, vc_islem_ack, vc_mail_gonder;
    close c1;
  
    if vc_mail_gonder = 'E' then
      open p_rec for
      --- islemi onaylayabilecek kullanicilar
        select distinct kul.erisim_kullanici_kodu
          from gnl_erisim_rol kul
         where (kul.sube_kodu = pkg_global.get_genelmudurluk or
               kul.sube_kodu = pc_sube)
           and kul.rol_numara in
               (select ro.rol_numara
                  from gnl_rol_islem_onay ro
                 where ro.islem_tanim_kod = vn_islem_kod)
        union
        --- islemi dogrulayabilecek kullanicilar
        select distinct kul.erisim_kullanici_kodu
          from gnl_erisim_rol kul
         where (kul.sube_kodu = pkg_global.get_genelmudurluk or
               kul.sube_kodu = pc_sube)
           and kul.rol_numara in
               (select ro.rol_numara
                  from gnl_rol_islem_dogru ro
                 where ro.islem_tanim_kod = vn_islem_kod)
        minus
        --- bu islemi onaylayan ve dogrulayan kullanicilari cikar
        select distinct nvl(o.dogru_kullanici_kodu, o.onay_kullanici_kodu)
          from muh_islem_onay o
         where o.numara = pn_islem_no
           and nvl(o.dogru_kullanici_kodu, o.onay_kullanici_kodu) is not null
        minus
        --- bu islemi yaratan kullaniciyi cikar
        select distinct m.kayit_kullanici_kodu
          from muh_islem m
         where m.numara = pn_islem_no;
    
      loop
        fetch p_rec
          into vc_kul;
        exit when p_rec%notfound;
      
        --#1 müşteri no'lu #2 için #3 no'lu #4 işlemi onayınıza sunulmuştur. (#5 ortamında)
        islem_mail_gonder(pn_islem_no,
                          vc_kul,
                          250,
                          vc_islem_ack,
                          vn_musteri_no);
      end loop;
      close p_rec;
    end if;
  
  end;
  /********************************************************/
  procedure islem_yaratabilecek_kullanici(pn_islem_no number) is
    p_rec         RC_REF;
    vc_kul        gnl_kullanici.kod%type;
    vn_musteri_no number;
  
    cursor c1 is
      select m.musteri_numara, m.islem_kod, p.aciklama
        from muh_islem m, muh_islem_tanim_pr p
       where m.numara = pn_islem_no
         and m.islem_kod = p.kod;
    vc_islem_kod      muh_islem_tanim_pr.kod%type;
    vc_islem_ack      muh_islem_tanim_pr.aciklama%type;
    vc_mail_gonder    muh_islem_tanim_pr.mail_gonder%type;
    vc_onay_islem_kod muh_islem_tanim_pr.kod%type;
  
    cursor c2(pc_kod varchar2) is
      select p.aciklama, p.mail_gonder
        from muh_islem_tanim_pr p
       where p.kod = pc_kod;
    vc_son_islem_ack muh_islem_tanim_pr.aciklama%type;
  begin
  
    open c1;
    fetch c1
      into vn_musteri_no, vc_islem_kod, vc_islem_ack;
    close c1;
  
    vc_onay_islem_kod := pkg_parametre.ParamTextAl('MAIL_GONDER_ONAY_ISLEM',
                                                   vc_islem_kod);
  
    if vc_onay_islem_kod is not null then
    
      open c2(vc_onay_islem_kod);
      fetch c2
        into vc_son_islem_ack, vc_mail_gonder;
      close c2;
    
      if vc_mail_gonder = 'E' then
        open p_rec for
          select distinct kul.erisim_kullanici_kodu
            from gnl_erisim_rol kul
           where (kul.sube_kodu = pkg_global.get_genelmudurluk or
                 kul.sube_kodu = pkg_global.get_subekod)
             and kul.rol_numara in
                 (select ro.rol_numara
                    from gnl_rol_islem ro
                   where ro.islem_tanim_kod = vc_onay_islem_kod);
        loop
          fetch p_rec
            into vc_kul;
          exit when p_rec%notfound;
          --#1 ekranından tamamlanan #2 müşteri no'lu #3 isimli #4 no'lu işlem için #5 ekranından işlem yapabilirsiniz. (#6 ortamında)
          islem_mail_gonder(pn_islem_no,
                            vc_kul,
                            255,
                            vc_islem_ack,
                            vn_musteri_no,
                            vc_son_islem_ack);
        end loop;
        close p_rec;
      end if;
    end if;
  exception
    when others then
      null;
  end;
  /********************************************************/
  procedure islem_kullanici_gecmis(pn_islem_no   number,
                                   p_islem_durum varchar2) is
    p_rec         RC_REF;
    vc_kul        gnl_kullanici.kod%type;
    vc_kul_isim   varchar2(60);
    vn_musteri_no number;
  
    cursor c1 is
      select m.musteri_numara, m.islem_kod, p.aciklama, p.mail_gonder
        from muh_islem m, muh_islem_tanim_pr p
       where m.numara = pn_islem_no
         and m.islem_kod = p.kod;
    vn_islem_kod      muh_islem.islem_kod%type;
    vc_islem_ack      muh_islem_tanim_pr.aciklama%type;
    vc_mail_gonder    muh_islem_tanim_pr.mail_gonder%type;
    vc_onay_islem_kod muh_islem.islem_kod%type;
  
    cursor c2 is
      select c.ad || ' ' || c.soyad
        from gnl_kullanici c
       where c.kod = pkg_global.GET_KULLANICIKOD;
  begin
    open c1;
    fetch c1
      into vn_musteri_no, vn_islem_kod, vc_islem_ack, vc_mail_gonder;
    close c1;
  
    if vc_mail_gonder = 'E' then
      open p_rec for
        select distinct nvl(nvl(nvl(o.dogru_kullanici_kodu,
                                    o.onay_kullanici_kodu),
                                nvl(o.iptal_onay_kullanici_kodu,
                                    o.iptal_kullanici_kodu)),
                            o.gcevir_kullanici_kodu)
          from muh_islem_onay o
         where o.numara = pn_islem_no
        union
        select m.kayit_kullanici_kodu
          from muh_islem m
         where m.numara = pn_islem_no;
    
      open c2;
      fetch c2
        into vc_kul_isim;
      close c2;
    
      loop
        fetch p_rec
          into vc_kul;
        exit when p_rec%notfound;
      
        if p_islem_durum = 'A' then
          ---#1 müşteri no'lu #2 için #3 no'lu #4 işlemi #5 tarafından tamamlanmıştır. (#6 ortamında)
          islem_mail_gonder(pn_islem_no,
                            vc_kul,
                            251,
                            vc_islem_ack,
                            vn_musteri_no,
                            vc_kul_isim);
        elsif p_islem_durum = 'R' then
          ---#1 müşteri no'lu #2 için #3 no'lu #4 işlemi #5 tarafından red edilmiştir. (#6 ortamında)
          islem_mail_gonder(pn_islem_no,
                            vc_kul,
                            253,
                            vc_islem_ack,
                            vn_musteri_no,
                            vc_kul_isim);
        elsif p_islem_durum = '1' then
          ---#1 müşteri no'lu #2 için #3 no'lu #4 işlemi #5 tarafından iptal edilmiştir. (#6 ortamında)
          islem_mail_gonder(pn_islem_no,
                            vc_kul,
                            252,
                            vc_islem_ack,
                            vn_musteri_no,
                            vc_kul_isim);
        elsif p_islem_durum = 'G' then
          ---#1 müşteri no'lu #2 için #3 no'lu #4 işlemi #5 tarafından geri çevrilmiştir. (#6 ortamında)
          islem_mail_gonder(pn_islem_no,
                            vc_kul,
                            254,
                            vc_islem_ack,
                            vn_musteri_no,
                            vc_kul_isim);
        end if;
      end loop;
      close p_rec;
    
      if p_islem_durum = 'A' then
        islem_yaratabilecek_kullanici(pn_islem_no);
      end if;
    end if;
  
  end;
  /********************************************************/
  Procedure bpm_task_status_update(pn_islem_no number) is
  begin
    update muh_islem i set i.durum = 'P' where i.numara = pn_islem_no;
  end bpm_task_status_update;
  /********************************************************/

END;
/
