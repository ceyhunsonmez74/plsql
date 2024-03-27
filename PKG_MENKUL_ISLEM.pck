CREATE OR REPLACE PACKAGE PKG_MENKUL_ISLEM IS

  Type Rc_Menkul Is Ref Cursor;

  Function RC_MenkulKuponList(pc_isin          varchar2,
                              pd_ihrac_tarihi  date,
                              pd_menkul_vadesi date,
                              pn_periyot       number) return rc_menkul;

  procedure MenkulFaizMarjKontrolveOnay(pn_Transaction_No     number,
                                        pn_Talep_Edilen_Tutar in number,
                                        pn_Vade_gun_sayisi    in number,
                                        ps_Doviz_Kodu         in varchar2,
                                        ps_menkul_cinsi       varchar2,
                                        ps_islem_yonu         varchar2,
                                        pn_faiz               number);

  Procedure Menkul_Ihrac_Hareket_Yarat(pn_tx_no      number,
                                       pn_islem_kodu number,
                                       pn_portfoy_id number,
                                       pn_nominal    number,
                                       ps_islem_yonu varchar2);

  Procedure Menkul_Ihrac_Hareket_Iptal(pn_tx_no number);

  Procedure BBSatis(pn_tx_no number);

  Procedure BBGeriAlis(pn_tx_no number);

  Procedure BBIslemIptal(pn_tx_no number);

  Procedure BBSCHGuncelle(pn_tx_no number);

  Procedure MusteriPortfoyuGuncelle(pn_musteri_no number,
                                    ps_isin       varchar2,
                                    ps_islemyonu  varchar2, --ARTI / EKSI
                                    pn_nominal    number,
                                    pn_fiyat      number);

  Procedure Portfoy_Rezerv_Artir(pn_tx_no          number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number);

  Procedure Portfoy_Rezerv_Azalt(pn_tx_no          number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number);

  Function bekleyen_islem_kontrol(p_islem_kod number) return number;
  Function bekleyen_islem_kontrol_tx(p_islem_no number) return number;

  Procedure Skor_Kaydet(pn_musteri_no number,
                        pd_tarih      date,
                        pn_skor       number);

  Procedure Skor_Sil(pn_musteri_no number, pd_tarih date);

  -- tarih gelirse o tarihli skor, gelmezse son skor doner
  Function Skor_Al(pn_musteri_no number, pd_tarih date default null)
    return number;

  Procedure BankaPortfoyuKontrol(pn_portfoy_id number);

  Function getOrtalamaMaliyetBB(p_musteri_no number, p_isin varchar2)
    return number;
  Procedure Gecici_Rezerv_Artir(pn_musteri_no      number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number);
  function Gecici_Rezerv_Bul(pn_musteri_no number) return number;
  Procedure Gecici_Rezerv_Azalt(pn_musteri_no     number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number);
  function Gecici_Rezerv_Nominal_Al(pn_tx_no number) return number;
END;
/
CREATE OR REPLACE PACKAGE BODY PKG_MENKUL_ISLEM IS

  Procedure RC_MenkulKuponList(pn_tx_no         number,
                               pc_isin          varchar2,
                               pd_ihrac_tarihi  date,
                               pd_menkul_vadesi date,
                               pn_periyot       number) is
    pragma autonomous_transaction;
    ln_gun          number;
    ln_kupon_sayisi number;
    ld_kupon_vadesi date;
  
  begin
  
    ln_gun          := trunc(trunc(pd_menkul_vadesi) -
                             trunc(pd_ihrac_tarihi));
    ln_kupon_sayisi := trunc(ln_gun / pn_periyot);
  
    ld_kupon_vadesi := trunc(pd_ihrac_tarihi) + pn_periyot;
  
    delete from men_kupon_tx k where k.tx_no = pn_tx_no;
  
    for i in 1 .. ln_kupon_sayisi ---1 
     loop
    
      insert into men_kupon_tx
        (tx_no, isin, vade, kupon_faizi)
      values
        (pn_tx_no, pc_isin, ld_kupon_vadesi, 0);
    
      ld_kupon_vadesi := ld_kupon_vadesi + pn_periyot;
    
    end loop;
  
    begin
      insert into men_kupon_tx
        (tx_no, isin, vade, kupon_faizi)
      values
        (pn_tx_no, pc_isin, pd_menkul_vadesi, 0);
    exception
      when DUP_VAL_ON_INDEX then
        null;
    end;
  
    commit;
  
  end;
  --***************************************************************************
  Function RC_MenkulKuponList(pc_isin          varchar2,
                              pd_ihrac_tarihi  date,
                              pd_menkul_vadesi date,
                              pn_periyot       number) return rc_menkul is
    rc_menkullist rc_menkul;
  
  begin
  
    RC_MenkulKuponList(-1,
                       pc_isin,
                       pd_ihrac_tarihi,
                       pd_menkul_vadesi,
                       pn_periyot);
  
    open rc_menkullist for
      select k.isin, to_char(k.vade, 'yyyymmdd') vade, k.kupon_faizi
        from men_kupon_tx k
       where k.tx_no = -1;
    return rc_menkullist;
  
  end;

  --********************************************************************************************---     
  procedure MenkulFaizMarjKontrolveOnay(pn_Transaction_No     number,
                                        pn_Talep_Edilen_Tutar in number,
                                        pn_Vade_gun_sayisi    in number,
                                        ps_Doviz_Kodu         in varchar2,
                                        ps_menkul_cinsi       varchar2,
                                        ps_islem_yonu         varchar2,
                                        pn_faiz               number) is
  
    vn_faiz_orani number;
    vn_marj_sube  number;
    vn_marj_gmy   number;
  begin
  
    PKG_MENKUL_HESAPLA.TanimliUygunFaiziBul(pn_Talep_Edilen_Tutar,
                                            pn_Vade_gun_sayisi,
                                            ps_Doviz_Kodu,
                                            ps_menkul_cinsi,
                                            ps_islem_yonu,
                                            vn_faiz_orani,
                                            vn_marj_sube,
                                            vn_marj_gmy);
    if nvl(vn_faiz_orani, -1) < 0 then
      pkg_hata.hata_yaz(660,
                        true,
                        'Uygun faiz orani sistemde tanimli degil. 1803 ekranindan tanim yapiniz');
    end if;
  
    if ps_islem_yonu = 'S' then
      if pn_faiz > vn_faiz_orani then
      
        pkg_tx.Dinamik_Onay_Belirle(pn_islem_no         => pn_Transaction_No,
                                    pc_dogrulama        => 'E',
                                    pc_onay             => null,
                                    pc_iptal_onay       => null,
                                    pc_dogrula_guncelle => null,
                                    pc_onay_guncelle    => null);
      end if;
    else
      if pn_faiz > vn_faiz_orani then
      
        pkg_tx.Dinamik_Onay_Belirle(pn_islem_no         => pn_Transaction_No,
                                    pc_dogrulama        => 'E',
                                    pc_onay             => null,
                                    pc_iptal_onay       => null,
                                    pc_dogrula_guncelle => null,
                                    pc_onay_guncelle    => null);
      end if;
    end if;
  end;

  --********************************************************************************************---     

  Procedure Menkul_Ihrac_Hareket_Yarat(pn_tx_no      number,
                                       pn_islem_kodu number,
                                       pn_portfoy_id number,
                                       pn_nominal    number,
                                       ps_islem_yonu varchar2 -- ARTI / EKSI
                                       ) is
  
  begin
  
    insert into MEN_IHRAC_HAREKET
      (REFERANS, PORTFOY_ID, ISLEM_KODU, NOMINAL, ISLEM_YONU, DURUM)
    values
      (pn_tx_no,
       pn_portfoy_id,
       pn_islem_kodu,
       pn_nominal,
       ps_islem_yonu,
       'ONAY');
  
  end;

  --********************************************************************************************---     

  Procedure Menkul_Ihrac_Hareket_Iptal(pn_tx_no number) is
  
  begin
  
    update MEN_IHRAC_HAREKET t
       set t.durum = 'IPTAL'
     where t.referans = pn_tx_no;
  
  end;

  --********************************************************************************************---     
  --********************************************************************************************---     

  Procedure BankaPortfoyuGuncelle(pn_islemno   number,
                                  pn_portfoyid number,
                                  ps_islemyonu varchar2, --ARTI / EKSI
                                  pn_nominal   number) is
    ln_banka_stok number;
    ls_isin       men_ihrac_portfoy.isin%type;
    ls_depo_turu  men_ihrac_portfoy.depo_turu%type;
  
  begin
  
    if ps_islemyonu = 'EKSI' then
    
      select (p.kalan_naminal - p.rezerv_nominal), p.isin, p.depo_turu
        into ln_banka_stok, ls_isin, ls_depo_turu
        from men_ihrac_portfoy p
       where p.id = pn_portfoyid;
    
      if ln_banka_stok < pn_nominal then
        --stoktan fazla cikis yapmaya calisiliyor..
        pkg_hata.hata_yaz(4967, true, pn_portfoyid, ls_isin, ls_depo_turu);
      end if;
    
    end if;
  
    update men_ihrac_portfoy p
       set p.kalan_naminal = p.kalan_naminal +
                             decode(ps_islemyonu,
                                    'ARTI',
                                    pn_nominal,
                                    -1 * pn_nominal)
     where p.id = pn_portfoyid;
  
    Menkul_Ihrac_Hareket_Yarat(pn_islemno,
                               pkg_tx.Islem_kod(pn_islemno),
                               pn_portfoyid,
                               pn_nominal,
                               ps_islemyonu);
  end;

  --********************************************************************************************---     

   Procedure BankaPortfoyuKontrol(pn_portfoy_id number) is
    vc_body varchar2(32000) := null;
  begin
  
    for r_liste in (select a.ISIN,
                           a.IHRAC_NOMINAL,
                           a.KALAN_NAMINAL,
                           a.IHRAC_NOMINAL - a.kalan_naminal bildirim_nomimal,
                           a.SPK_SIRA_NO,
                           a.ID PORTFOY_ID,
                           t.ihrac_tarihi,
                           t.vade,
                           il.spk_izin_tarihi,
                           il.bagli_olunan_ana_limit ana_limit,
                           il.yk_karar_tarihi,
                           /*il.ihrac_tavani_turu,
                           il.satis_turu*/
                           (SELECT PA.TEXT
                              FROM BNSPR.GNL_PARAM_TEXT PA
                             WHERE PA.KOD IN ('IHRAC_TAVANI_TURLERI')
                               AND PA.KEY1 = NVL(il.ihrac_tavani_turu, -11)) ihrac_tavani_turu,
                           (SELECT PA.TEXT
                              FROM BNSPR.GNL_PARAM_TEXT PA
                             WHERE PA.KOD IN ('SATIS_TURU')
                               AND PA.KEY1 = NVL(il.satis_turu, -11)) satis_turu,
                           
                           t.ihrac_fiyat,
                           
                           (trunc(t.vade) - trunc(t.ihrac_tarihi)) vade_gun_sayisi,
                          
                            CASE  
                             WHEN (t.bist_kote= 'E') THEN 'Evet'
                             ELSE 'Hayır'
                           END borsada_islem_gorme_durumu,  
                           
                           (
                             trunc( ((100 /t.ihrac_fiyat)-1) * (365 /(trunc(t.vade) - trunc(t.ihrac_tarihi))), 4) *100                                      
                           )  basit_faiz,
                           
                           (
                            trunc(  power((1+(((100 /t.ihrac_fiyat)-1) * (365 /(trunc(t.vade) - trunc(t.ihrac_tarihi)))/(365/ (trunc(t.vade) - trunc(t.ihrac_tarihi))))) ,(365/(trunc(t.vade) - trunc(t.ihrac_tarihi))))-1 , 4) * 100
                           ) bilesik_faiz,
                           
                           (
                             trunc(  ( (((100 /t.ihrac_fiyat)-1) * (365 /(trunc(t.vade) - trunc(t.ihrac_tarihi))) ) /365 )
                               * (trunc(t.vade) - trunc(t.ihrac_tarihi)) , 4) *100    
                           ) donemsel_faiz
                                          
                      from men_ihrac_portfoy     a,
                           bb_bonosu_ihrac_limit il,
                           men_tanim             t
                     where a.DEPO_TURU = 'I'
                       and a.id = pn_portfoy_id
                       and a.isin = t.isin
                       and a.kalan_naminal = 0
                       and a.spk_sira_no = il.sira_no
                       AND NOT EXISTS
                     (SELECT *
                              FROM BB_KAP_ACIKLAMA_LOG LG
                             where LG.PORTFOY_ID = a.ID)) loop
    
      vc_body := vc_body || '<table border="1" cellpadding="2" cellspacing="0">
                       <tr>
                         <td >ISIN</td>
                         <td >' || r_liste.isin ||
                 '</td>
                       </tr>
                       <tr>
                         <td >İhraç Miktarı</td>
                         <td >' ||
                 to_char(r_liste.ihrac_nominal, 'FM999,999,999,999') ||
                 '</td>
                       </tr>
                       <tr>
                         <td >İhraç Depo Kalan</td>
                         <td >' ||
                 to_char(r_liste.kalan_naminal, 'FM999,999,999,999') ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Satılan Miktar</td>
                         <td >' ||
                 to_char(r_liste.Bildirim_Nomimal, 'FM999,999,999,999') ||
                 '</td>
                       </tr>
                       <tr>
                         <td >İhraç Tarihi</td>
                         <td >' || r_liste.ihrac_tarihi ||
                 '</td>
                       </tr>
                       <tr>
                         <td >İtfa Tarihi</td>
                         <td >' || r_liste.vade ||
                 '</td>
                       </tr>
                       <tr>
                         <td >SPK İzin Tarihi</td>
                         <td >' || r_liste.Spk_Izin_Tarihi ||
                 '</td>
                       </tr>
                       <tr>
                         <td >SPK İzin Ana Limit Miktarı</td>
                         <td >' ||
                 to_char(r_liste.ana_limit, 'FM999,999,999,999') ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Yk Karar Tarihi</td>
                         <td >' || r_liste.yk_karar_tarihi ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Ihrac Tavani Turu</td>
                         <td >' ||
                 r_liste.ihrac_tavani_turu ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Satis Turu</td>
                         <td >' || r_liste.satis_turu ||
                 '</td>
                       </tr>
                       <tr>
                         <td >İhraç Fiyatı</td>
                         <td >' || r_liste.ihrac_fiyat ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Vade Gün Sayısı</td>
                         <td >' || r_liste.vade_gun_sayisi ||
                 '</td>
                       </tr>
                        <tr>
                         <td >Borsada İşlem Görme Durumu</td>
                         <td >' || r_liste.borsada_islem_gorme_durumu ||
                 '</td>
                       </tr>
                       <tr>
                         <td >Basit Faiz</td>
                         <td >' || r_liste.basit_faiz ||
                 ' % </td>
                       </tr>
                       <tr>
                         <td >Bileşik Faiz</td>
                         <td >' || r_liste.bilesik_faiz ||
                 ' % </td>
                       </tr>
                       <tr>
                         <td >Dönemsel Faiz</td>
                         <td >' || r_liste.donemsel_faiz ||
                 ' % </td>
                       </tr>
                     </table><br>';
    
      insert into bnspr.bb_kap_aciklama_log
        (portfoy_id)
      values
        (r_liste.portfoy_id);
    end loop;
  
    if vc_body is not null then
      pkg_mail.send_mail(ps_mail_from    => 'Aktifbank@aktifbank.com.tr',
                         ps_mail_to      => pkg_parametre.Deger_Al_K('KAP_ACIKLAMA_MAIL_TO'),
                         ps_mail_cc      => null,
                         ps_mail_bcc     => null,
                         ps_mail_subject => pkg_parametre.Deger_Al_K('KAP_ACIKLAMA_MAIL_SUBJECT'),
                         ps_mail_body    => vc_body,
                         ps_html_eh      => 'E');
    end if;
  end;

  --********************************************************************************************---     

  Procedure MusteriPortfoyuGuncelle(pn_musteri_no number,
                                    ps_isin       varchar2,
                                    ps_islemyonu  varchar2, --ARTI / EKSI
                                    pn_nominal    number,
                                    pn_fiyat      number) is
  
    ln_say     number;
    ln_stok    number;
    ln_maliyet number;
  
  begin
  
    --TYHAZ-1162
    -- Serbest fonlardan sonra Men musteri portfoy tablosuna DOVIZ_KODU eklendi.
    -- dibslerde döviz kodu ISIN dan alınıyor. Bu procedürün fon için yeni versiyon
    -- OTC Fon işlem paketi altına da yazıldı.
    
    --deprecated
    if pkg_menkul_dibs_hesapla.ISINGrupKodu(ps_isin) = 'FON' then
      --Serbest fonlar farklı döviz koduyla işlem yapabildiğinden,
      --portföy güncellemeye fon kodu eklendi.
      
       pkg_hata.hata_yaz(660,
                          true,
                          'Fon işlemlerinde PKG_MENKUL_OTC_FON_ISLEM.MusteriFonPortfoyuGuncelle prosedürü kullanılmalıdır.');    
    end if;
    
    if ps_islemyonu = 'ARTI' then
    
      select count(*)
        into ln_say
        from men_musteri_portfoy p
       where p.musteri_no = pn_musteri_no
         and p.isin = ps_isin;
    
      if ln_say = 0 then
        insert into men_musteri_portfoy
          (musteri_no, isin, nominal, maliyet, ortalama_fiyat, doviz_kodu)
        values
          (pn_musteri_no,
           ps_isin,
           pn_nominal,
           round(pn_nominal * pn_fiyat / 100, 2),
           pn_fiyat,
           pkg_menkul_hesapla.ISINDovizCinsi(ps_isin));
      
      else
        update men_musteri_portfoy p
           set p.nominal        = p.nominal + pn_nominal,
               p.maliyet        = p.maliyet +
                                  round(pn_nominal * pn_fiyat / 100, 2),
               p.ortalama_fiyat = pkg_menkul_finansal_hesaplama.Fiyat_Yuvarla((p.maliyet +
                                                                              round(pn_nominal *
                                                                                     pn_fiyat / 100,
                                                                                     2)) /
                                                                              (p.nominal +
                                                                              pn_nominal) * 100,
                                                                              ps_isin)
         where p.musteri_no = pn_musteri_no
           and p.isin = ps_isin;
      end if;
    
    elsif ps_islemyonu = 'EKSI' then
    
      begin
        select p.nominal, p.maliyet
          into ln_stok, ln_maliyet
          from men_musteri_portfoy p
         where p.musteri_no = pn_musteri_no
           and p.isin = ps_isin;
      exception
        when no_data_found then
          ln_stok := 0;
      end;
    
      if ln_stok < pn_nominal then
        --mevcuttan fazla cikis yapilmak isteniyor
        pkg_hata.hata_yaz(4966, true, pn_musteri_no, pn_musteri_no);
      end if;
    
      --25.04.2019 Erkan Çalışkan TY-10506
      if ln_stok - pn_nominal = 0 then
        --stokun tamamı çıkılıyor.
        --ortalama maliyet son yaşayan parçanın ortalamasını göstermesi için
        --stok sıfırlandığından ortalama fiyat ta sıfırlanıyor.
        update men_musteri_portfoy p
           set p.nominal        = p.nominal - pn_nominal,
               p.maliyet        = 0,
               p.ortalama_fiyat = 0
         where p.musteri_no = pn_musteri_no
           and p.isin = ps_isin;
      else
        update men_musteri_portfoy p
           set p.nominal = p.nominal - pn_nominal,
               p.maliyet = p.maliyet -
                           round(p.maliyet / p.nominal * pn_nominal, 2)
         where p.musteri_no = pn_musteri_no
           and p.isin = ps_isin;
      end if;
    
    end if;
  
  end;

  --********************************************************************************************---     

  Procedure BBSatis(pn_tx_no number) is
    cursor c_bono is
      select * from bb_satis_tx bb where bb.tx_no = pn_tx_no;
  
    r_bono c_bono%rowtype;
  
    ln_ortalama_maliyet number;
  begin
  
    open c_bono;
    fetch c_bono
      into r_bono;
    close c_bono;
  
    --Banka Portfoy u azalt
    BankaPortfoyuGuncelle(pn_tx_no,
                          r_bono.portfoy_id,
                          'EKSI',
                          r_bono.satis_nominal);
  
    --Musteri Portfoy u artir
    IF r_bono.emanet_Eh = 'E' THEN
      MusteriPortfoyuGuncelle(r_bono.musteri_no,
                              trim(r_bono.isin),
                              'ARTI',
                              r_bono.satis_nominal,
                              r_bono.satis_birim_fiyat);
    
      --agirlik ortalama fiyat ve maliyeti günceller
      ln_ortalama_maliyet := getOrtalamaMaliyetBB(r_bono.musteri_no,
                                                  r_bono.isin);
      
      update men_musteri_portfoy p
         set p.ortalama_fiyat = ln_ortalama_maliyet,
             p.maliyet        = pkg_menkul_dibs_hesapla.TutarHesapla(p.isin,
                                                                     p.nominal,
                                                                     ln_ortalama_maliyet)
       where p.musteri_no = r_bono.musteri_no
         and p.isin = r_bono.isin;
    END IF;
    BBSCHGuncelle(pn_tx_no);
  
    BankaPortfoyuKontrol(r_bono.portfoy_id);
  end;

  --********************************************************************************************---     

  Procedure BBGeriAlis(pn_tx_no number) is
    cursor c_bono_gerialis is
      select * from bb_geri_alis_tx bb where bb.tx_no = pn_tx_no;
  
    r_bono_gerialis c_bono_gerialis%rowtype;
  
    cursor c_bono_satis(p_satis_referans number) is
      select * from bb_satis_tx bb where bb.tx_no = p_satis_referans;
  
    r_bono_satis c_bono_satis%rowtype;
  
    ln_serb_depo_id number;
    ln_spk_sira_no  number;
    ln_ortalama_maliyet number;
  begin
  
    open c_bono_gerialis;
    fetch c_bono_gerialis
      into r_bono_gerialis;
    close c_bono_gerialis;
  
    open c_bono_satis(r_bono_gerialis.satis_referans);
    fetch c_bono_satis
      into r_bono_satis;
    close c_bono_satis;
  
    begin
      select ip.id
        into ln_serb_depo_id
        from MEN_IHRAC_PORTFOY ip
       where ip.isin = r_bono_gerialis.isin
         and ip.depo_turu = 'S';
    exception
      when no_data_found then
      
        --Ýhraç deposundan spk sýra numarasý bulunuyor
        select ip.spk_sira_no
          into ln_spk_sira_no
          from MEN_IHRAC_PORTFOY ip
         where ip.isin = r_bono_gerialis.isin
           and ip.depo_turu = 'I';
      
        ln_serb_depo_id := pkg_genel_pr.genel_kod_al('MEN_PORTFOY_ID');
      
        insert into MEN_IHRAC_PORTFOY
          (ID,
           ISIN,
           DEPO_TURU,
           IHRAC_NOMINAL,
           KALAN_NAMINAL,
           REZERV_NOMINAL,
           ILK_IHRAC_TARIHI,
           SPK_SIRA_NO)
        values
          (ln_serb_depo_id,
           r_bono_gerialis.isin,
           'S', --Serbest Depoya doner..
           0,
           0,
           0,
           pkg_muhasebe.Banka_Tarihi_Bul,
           ln_spk_sira_no);
    end;
  
    --Banka Portfoy u artir
    BankaPortfoyuGuncelle(pn_tx_no,
                          ln_serb_depo_id,
                          'ARTI',
                          r_bono_gerialis.nominal);
    --Musteri Portfoy u azalt.
    if r_bono_gerialis.Emanet_Eh = 'E' THEN
      MusteriPortfoyuGuncelle(r_bono_gerialis.musteri_no,
                              trim(r_bono_gerialis.isin),
                              'EKSI',
                              r_bono_gerialis.nominal,
                              r_bono_gerialis.brim_fiyat);
    
      --agirlik ortalama fiyat ve maliyeti günceller
      ln_ortalama_maliyet := getOrtalamaMaliyetBB(r_bono_gerialis.musteri_no,
                                                  r_bono_gerialis.isin);
      
      update men_musteri_portfoy p
         set p.ortalama_fiyat = ln_ortalama_maliyet,
             p.maliyet        = pkg_menkul_dibs_hesapla.TutarHesapla(p.isin,
                                                                     p.nominal,
                                                                     ln_ortalama_maliyet)
       where p.musteri_no = r_bono_gerialis.musteri_no
         and p.isin = r_bono_gerialis.isin;
    end if;
  
  end;

  --********************************************************************************************---     

  Procedure BBIslemIptal(pn_tx_no number) is
  
    cursor c_bono_satis(p_txno number) is
      select * from bb_satis_tx bb where bb.tx_no = p_txno;
  
    r_bono_satis c_bono_satis%rowtype;
  
    cursor c_bono_gerialis(p_txno number) is
      select * from bb_geri_alis_tx bb where bb.tx_no = p_txno;
  
    r_bono_gerialis c_bono_gerialis%rowtype;
  
    ln_geri_alis_portfoy_id number;
  
    ln_ortalama_maliyet number;
  begin
  
    open c_bono_satis(pn_tx_no);
    fetch c_bono_satis
      into r_bono_satis;
    close c_bono_satis;
  
    if r_bono_satis.tx_no is not null then
      --bono satis islemi iptal ediliyor
    
      --Banka Portfoy u artir
      BankaPortfoyuGuncelle(pn_tx_no,
                            r_bono_satis.portfoy_id,
                            'ARTI',
                            r_bono_satis.satis_nominal);
    
      --Musteri Portfoy u azalt
      if r_bono_satis.Emanet_Eh = 'E' THEN
        MusteriPortfoyuGuncelle(r_bono_satis.musteri_no,
                                trim(r_bono_satis.isin),
                                'EKSI',
                                r_bono_satis.satis_nominal,
                                r_bono_satis.satis_birim_fiyat);
      
        --25.04.2019 Erkan Çalýþkan
        --agirlik ortalama fiyat ve maliyeti günceller
        ln_ortalama_maliyet := getOrtalamaMaliyetBB(r_bono_satis.musteri_no,
                                                    r_bono_satis.isin);
      
        update men_musteri_portfoy p
           set p.ortalama_fiyat = ln_ortalama_maliyet,
               p.maliyet        = pkg_menkul_dibs_hesapla.TutarHesapla(p.isin,
                                                                       p.nominal,
                                                                       ln_ortalama_maliyet)
         where p.musteri_no = r_bono_satis.musteri_no
           and p.isin = r_bono_satis.isin;
      
      end if;
    
    else
      -- bono geri alis islemi iptal ediliyor
    
      open c_bono_gerialis(pn_tx_no);
      fetch c_bono_gerialis
        into r_bono_gerialis;
      close c_bono_gerialis;
    
      open c_bono_satis(r_bono_gerialis.satis_referans);
      fetch c_bono_satis
        into r_bono_satis;
      close c_bono_satis;
    
      select max(ih.portfoy_id)
        into ln_geri_alis_portfoy_id
        from MEN_IHRAC_HAREKET ih
       where ih.referans = pn_tx_no;
    
      --Banka Portfoy u azalt
      BankaPortfoyuGuncelle(pn_tx_no,
                            ln_geri_alis_portfoy_id, --r_bono_satis.portfoy_id, 
                            'EKSI',
                            r_bono_gerialis.nominal);
      --Musteri Portfoy u artir
      if r_bono_gerialis.emanet_Eh = 'E' THEN
        MusteriPortfoyuGuncelle(r_bono_gerialis.musteri_no,
                                trim(r_bono_gerialis.isin),
                                'ARTI',
                                r_bono_gerialis.nominal,
                                r_bono_gerialis.brim_fiyat);
      
        --25.04.2019 Erkan Çalýþkan
        --agirlik ortalama fiyat ve maliyeti günceller
        ln_ortalama_maliyet := getOrtalamaMaliyetBB(r_bono_gerialis.musteri_no,
                                                    r_bono_gerialis.isin);
      
        update men_musteri_portfoy p
           set p.ortalama_fiyat = ln_ortalama_maliyet,
               p.maliyet        = pkg_menkul_dibs_hesapla.TutarHesapla(p.isin,
                                                                       p.nominal,
                                                                       ln_ortalama_maliyet)
         where p.musteri_no = r_bono_gerialis.musteri_no
           and p.isin = r_bono_gerialis.isin;
      
      END IF;
    
    end if;
  
  end;

  --**************************************************************************************-

  Procedure BBSCHGuncelle(pn_tx_no number) is
    vn_faiz_orani number;
    vn_marj_sube  number;
    vn_marj_gmy   number;
    vs_tur        varchar2(15);
    cursor c_bono is
      select bb.*, t.cinsi
        from bb_satis_tx bb, men_tanim t
       where bb.tx_no = pn_tx_no
         and bb.isin = t.isin;
  
    r_bono c_bono%rowtype;
  
  begin
    open c_bono;
    fetch c_bono
      into r_bono;
    close c_bono;
  
    vs_tur := r_bono.cinsi;
  
    if vs_tur = 'ISKAKTTHV' then
      vs_tur := 'BB';
    end if;
    if vs_tur = 'AFAT' then
      vs_tur := 'AFAB';
    end if;
  
    --30.09.2016 Erkan Çalışkan
    if r_bono.satis_tur = 'H' then
      PKG_MENKUL_HESAPLA.TanimliUygunFaiziBul(r_bono.talep_tutar,
                                              r_bono.vade_gun_sayisi,
                                              r_bono.doviz_kodu,
                                              vs_tur,
                                              'H',
                                              vn_faiz_orani,
                                              vn_marj_sube,
                                              vn_marj_gmy);
     
      update bb_satis_tx t
       set t.sch_hazine_orani = vn_faiz_orani,
           t.sch_apko_orani   = vn_marj_sube
     where t.tx_no = pn_tx_no;
    else
      PKG_MENKUL_HESAPLA.TanimliUygunFaiziBul(r_bono.talep_tutar,
                                              r_bono.vade_gun_sayisi,
                                              r_bono.doviz_kodu,
                                              vs_tur,
                                              'S',
                                              vn_faiz_orani,
                                              vn_marj_sube,
                                              vn_marj_gmy);
                                              
      update bb_satis_tx t
       set t.sch_apko_orani   = vn_marj_sube
     where t.tx_no = pn_tx_no
     and t.sch_apko_orani is null;
    end if;
  
    
  
  end;

  --********************************************************************************************--- 

  Procedure Portfoy_Rezerv_Artir_Azalt(pn_tx_no          number,
                                       pn_islem_kodu     number,
                                       pn_portfoy_id     number,
                                       pn_rezerv_nominal number,
                                       ps_islem_yonu     varchar2 -- ARTI / EKSI
                                       ) is
  
    ln_ks number;
  
  ls_rezerv_durumu Varchar2(1);
  begin
    
  
    /*
        21.04.2016 Erkan Çaly?kan
        
        Ihraç Portföy rezervi artyryr azaltyr.
    */
  
    --ayny tx no ile ayny portföy id ye daha önce ezerv konulmu? mu kontrol ediliyor.
  
  
    if ps_islem_yonu = 'EKSI' then
      select h.rezerv_durumu
        into ls_rezerv_durumu
        from MEN_IHRAC_HAREKET h
        where h.referans = pn_tx_no
        and h.islem_kodu = pn_islem_kodu
        and h.islem_yonu = 'ARTI';
        
        if ls_rezerv_durumu = 'K' then 
          return;
        end if;
    end if;
  
    select count(1)
      into ln_ks
      from MEN_IHRAC_HAREKET h
     where h.referans = pn_tx_no
       and h.portfoy_id = pn_portfoy_id
       and h.islem_yonu = ps_islem_yonu;
  
    if ln_ks > 0 then
      return;
    end if;
  
    update men_ihrac_portfoy p
       set p.rezerv_nominal = nvl(p.rezerv_nominal, 0) +
                              decode(ps_islem_yonu,
                                     'ARTI',
                                     nvl(pn_rezerv_nominal, 0),
                                     -1 * nvl(pn_rezerv_nominal, 0))
     where p.id = pn_portfoy_id;
  
    --rezervin eksiye düþmesine izin vermiyoruz. EÇ
     update men_ihrac_portfoy p
            set p.rezerv_nominal = 0
     where p.id = pn_portfoy_id
           and p.rezerv_nominal < 0;
     
    insert into MEN_IHRAC_HAREKET
      (REFERANS,
       PORTFOY_ID,
       ISLEM_KODU,
       NOMINAL,
       ISLEM_YONU,
       DURUM,
       REZERV_NOMINAL)
    values
      (pn_tx_no,
       pn_portfoy_id,
       pn_islem_kodu,
       0,
       ps_islem_yonu,
       'ONAY',
       pn_rezerv_nominal);
  
       
  end;

  --********************************************************************************************---      

  Procedure Portfoy_Rezerv_Artir(pn_tx_no          number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number) is
  
  begin
  
    Portfoy_Rezerv_Artir_Azalt(pn_tx_no,
                               pn_islem_kodu,
                               pn_portfoy_id,
                               pn_rezerv_nominal,
                               'ARTI');
  
  end;

  --********************************************************************************************--- 

  Procedure Portfoy_Rezerv_Azalt(pn_tx_no          number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number) is
  
  begin
  
    Portfoy_Rezerv_Artir_Azalt(pn_tx_no,
                               pn_islem_kodu,
                               pn_portfoy_id,
                               pn_rezerv_nominal,
                               'EKSI');
  
  end;

  --********************************************************************************************--- 

  --islem kod ile aynı, bekleyen islem var mi
  Function bekleyen_islem_kontrol(p_islem_kod number) return number is
  
    ln_max_islem_no number;
    ld_tarih        date;
  
  Begin
  
    ld_tarih := pkg_muhasebe.Banka_Tarihi_Bul;
  
    --Onayda bekleyen islem var ise durdur. 
    select max(m.numara)
      into ln_max_islem_no
      from muh_islem m
     where m.islem_kod = p_islem_kod
       and m.kayit_tarih = ld_tarih
       AND pkg_tx.islem_bitmis_mi(m.numara) = 0;
  
    if ln_max_islem_no > 0 then
      return 1; --evet var
    else
      return 0; --yok
    end if;
  
  end;

  --*******************************************************

  --islem no ile aynı islem koda sahip, bu islem haricinde, bekleyen islem var mi
  Function bekleyen_islem_kontrol_tx(p_islem_no number) return number is
  
    ln_max_islem_no number;
    ln_islem_kod    number;
    ld_tarih        date;
  
  Begin
  
    ln_islem_kod := pkg_tx.Islem_kod(p_islem_no);
    ld_tarih     := pkg_muhasebe.Banka_Tarihi_Bul;
    --Onayda bekleyen islem var ise durdur. 
    select max(m.numara)
      into ln_max_islem_no
      from muh_islem m
     where m.islem_kod = ln_islem_kod
       and m.numara <> p_islem_no
       and m.kayit_tarih = ld_tarih
       AND pkg_tx.islem_bitmis_mi(m.numara) = 0;
  
    if ln_max_islem_no > 0 then
      return 1; -- evet var
    else
      return 0; -- yok
    end if;
  
  end;

  --*******************************************************

--PBIYU-787
Function skor_ekle(pn_musteri_no number) return number is

ln_yas number;
ln_yas_puan number :=0;
ln_egitim_puan number:=0; 
ls_egitim_kod gnl_musteri.egitim_kod%type;

begin
  

if pkg_global.GET_KULLANICIKOD in ('MBLNKOLAY','INTNG') then 

    --YAS PUANLAMA
    /*
    Yaşınız?	18-30 yaş	4
              31-50 yaş	5
              51-65 yaş	4
              66 ve üzeri	3
              Kurumsal Müşteri	6
    */
    begin
      if pkg_musteri.tur(pn_musteri_no) in ('G','O') then 
       
          ln_yas := floor( (trunc(sysdate) - pkg_musteri.dogum_tarihi(pn_musteri_no) )/365 )  ;
          
          if ln_yas is null  or ln_yas <18 then 
                ln_yas_puan :=0;
          elsif ln_yas >=18 and ln_yas <=30  then      
                ln_yas_puan :=4;
          elsif ln_yas >=31 and ln_yas <=50  then      
                ln_yas_puan :=5;
          elsif ln_yas >=51 and ln_yas <=65  then      
                ln_yas_puan :=4;
          elsif ln_yas >=66   then      
                ln_yas_puan :=3;
          end if;
                
      else 

        ln_yas_puan := 6;

      end if;

    exception when others then 
    ln_yas_puan :=0;
    end ;


--EGITIM DURUMU PUANLAMA
/*
Eğitim Durumunuz?	İlköğretim/Ortöğretim	2
                  Lise	3
	                Lisans ve Üstü	6
	                Kurumsal Müşteri	6
*/



--------------------
--- Egitim puan ekleme PBIYU-1033 ile kapatildi
------------------
/*


ls_egitim_kod := pkg_musteri.egitim_kod(pn_musteri_no);

\*
I	İlkokul
O	Orta Öğretim
U	Lisans
Y	Yüksek Okul
L	Lise
D	Yüksek Lisans ve Üzeri
*\
  if ls_egitim_kod is null then 
    ln_egitim_puan :=0;
  
  else  
      if pkg_musteri.tur(pn_musteri_no) in ('G','O') then 

        if ls_egitim_kod in ('I','O') then 
            ln_egitim_puan :=2;
        elsif ls_egitim_kod in ('L') then 
            ln_egitim_puan :=3;
        elsif ls_egitim_kod in ('Y','U','D') then 
            ln_egitim_puan :=6;
        else
          ln_egitim_puan :=0;
        end if;
          
      else  --Kurumsal Müşteri	6
        ln_egitim_puan :=6;


      end if;
      
  end if;
  */
  
--------------------
--- Egitim puan ekleme PBIYU-1033 ile kapatildi
------------------

  
      
else
  
ln_yas_puan :=0;
ln_egitim_puan :=0;

end if;





return ln_yas_puan + ln_egitim_puan;

end;

  --*******************************************************

Procedure skor_kaydetmede_dokuman_iptal(pn_musteri_no number) is
  
begin
  
/*
1. 2095-Uygunluk Testi Muvaffaktaneme-Çok Düşük Riskli-Elektronik
2. 2096-Uygunluk Testi Muvaffaktaneme-Düşük Riskli-Elektronik
3. 2097-Uygunluk Testi Muvaffaktaneme-Orta Riskli-Elektronik
4. 2098-Uygunluk Testi Muvaffaktaneme-Yüksek Riskli-Elektronik
5. 2099-Uygunluk Testi Muvaffaktaneme-Çok Yüksek Riskli-Elektronik
*/

update gnl_musteri_dokuman md
set md.alindi_kutusu_f='H'
where md.musteri_no=pn_musteri_no
and md.dokuman_adi in (2095,2096,2097,2098,2099);


end;


  --*******************************************************


  Procedure Skor_Kaydet(pn_musteri_no number,
                        pd_tarih      date,
                        pn_skor       number) is
  
  ln_skor number :=0; 

 begin
  
   skor_kaydetmede_dokuman_iptal(pn_musteri_no);
   
   
    ln_skor := pn_skor+ skor_ekle(pn_musteri_no);

    log_at(pid1 => 'Skor_Kaydet',
           pid2 =>pn_musteri_no,
           pid3 =>  to_char(pd_tarih, 'dd.mm.yyyy') ,
           pid4 => 'Skor:'|| pn_skor ||' Ekli Skor:'||ln_skor);

  --PBIYU-1112
  if ln_skor>100 then 
    pkg_hata.hata_yaz(660,true,'Uygunluk test skoru 100 den fazla olamaz.');  
  end if;
  
    insert into men_skor
      (musteri_no, tarih, skor)
    values
      (pn_musteri_no, pd_tarih, ln_skor );
  
 pkg_hisse_senedi.uygunluk_ata_bildirim(p_musteri_no => pn_musteri_no,p_tx_no => -2);
 
  exception
    when others then
    
      update men_skor s
         set s.skor = ln_skor
       where s.musteri_no = pn_musteri_no
         and s.tarih = pd_tarih;
  
  pkg_hisse_senedi.uygunluk_ata_bildirim(p_musteri_no => pn_musteri_no,p_tx_no => -2);
   
  end;

  --*******************************************************

  Procedure Skor_Sil(pn_musteri_no number, pd_tarih date) is
  
  begin
  
    delete from men_skor s
     where s.musteri_no = pn_musteri_no
       and s.tarih = pd_tarih;
  
  end;

  --*******************************************************

  -- tarih gelirse o tarihli skor, gelmezse son skor doner
  Function Skor_Al(pn_musteri_no number, pd_tarih date default null)
    return number is
  
    cursor c is
      select *
        from men_skor s
       where s.musteri_no = pn_musteri_no
         and s.tarih = nvl(pd_tarih, s.tarih) -- tarih gelirse o tarihli skor, gelmezse son skor doner
       order by s.tarih desc;
  
    r c%rowtype;
  
  begin
  
    open c;
    fetch c
      into r;
    close c;
  
    return r.skor;
  
  end;

  --*******************************************************
  Function getOrtalamaMaliyetBB(p_musteri_no number, p_isin varchar2)
    return number is
  
    p_ort_maliyet number;
  
  begin
  
    /*
    25.04.2019 Erkan Çalışkan
                          
    BB_SATIS tablosundan kalan parçaların Ağırlıklı Ortalama malyetini hesaplar
    */
  
    select nvl(sum(s.kalan_nominal * s.satis_birim_fiyat) /
               sum(s.kalan_nominal),
               0) ort_maliyet
      into p_ort_maliyet
      from bnspr.bb_satis s
     where s.musteri_no = p_musteri_no
       and s.isin = p_isin
       and s.durum = 'ONAY'
       and S.kalan_nominal > 0;
  
    p_ort_maliyet := PKG_MENKUL_FINANSAL_HESAPLAMA.Fiyat_Yuvarla(p_ort_maliyet,
                                                                 p_isin);
  
    return p_ort_maliyet;
  
  end;
  
  --********************************************************************************************---      

  Procedure Gecici_Rezerv_Artir(pn_musteri_no      number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number) is
  
    ln_tx_no number;
    ln_timeout number;
    ld_gecerlilik_tarihi date;
  begin
  
    --bir müþteri için sadece bir tane geçici rezerv konulabilir
    ln_tx_no := Gecici_Rezerv_Bul(pn_musteri_no);
    
    if ln_tx_no = 0 then
    
      ln_timeout := pkg_parametre.Deger_Al_K_N('BONO_REZERV_TIMEOUT'); --saniye
      ld_gecerlilik_tarihi := sysdate + ln_timeout / 24 /60 /60;
      
      --geçici tx_no
      ln_tx_no := pkg_tx.islem_no_al;
      
      Portfoy_Rezerv_Artir(ln_tx_no,
                                 pn_islem_kodu,
                                 pn_portfoy_id,
                                 pn_rezerv_nominal);
      
      update men_ihrac_hareket h
             set h.musteri_no = pn_musteri_no,
             h.rezerv_gecerlilik_tarihi = ld_gecerlilik_tarihi,
             h.rezerv_durumu = 'A'
      where h.referans = ln_tx_no
      and h.islem_yonu = 'ARTI';
   end if;
  end;
  
  function Gecici_Rezerv_Bul(pn_musteri_no number) return number is
    ln_tx_no number;
  begin
    
    select nvl(max(referans), 0) into ln_tx_no 
    from men_ihrac_hareket h
    where h.musteri_no =  pn_musteri_no
    and h.islem_yonu = 'ARTI'
    and h.rezerv_durumu = 'A';
    
    return ln_tx_no;
  
  end;
  
  Procedure Gecici_Rezerv_Azalt(pn_musteri_no     number,
                                 pn_islem_kodu     number,
                                 pn_portfoy_id     number,
                                 pn_rezerv_nominal number) is
  
     ln_tx_no number;
     
     ln_portfoy_id number;
  begin
  
    ln_tx_no := Gecici_Rezerv_Bul(pn_musteri_no);
    
    if ln_tx_no <> 0 then
      
      --portfoy id degistiginde rezerv yanlis portfoy idden kalkmis oluyor
      begin
        select h.portfoy_id
        into ln_portfoy_id
        from men_ihrac_hareket h
        where h.referans = ln_tx_no
        and h.rezerv_durumu = 'A';
      exception 
        when no_data_found then
          return; --endiseye gerek yok, 60 sn sonra bacth kaldirir.
       end;
      
      Portfoy_Rezerv_Azalt(ln_tx_no,
                                 pn_islem_kodu,
                                 ln_portfoy_id,
                                 pn_rezerv_nominal);
     
     
      update men_ihrac_hareket h
           set h.rezerv_durumu = 'K'
      where h.referans = ln_tx_no
      and h.islem_yonu = 'ARTI';
    end if;
  end;
  
  function Gecici_Rezerv_Nominal_Al(pn_tx_no number) return number is
    ln_nominal number;
  begin
    
    select nvl(h.rezerv_nominal, 0) into ln_nominal 
    from men_ihrac_hareket h
    where h.referans = pn_tx_no
    and h.islem_yonu = 'ARTI'
    and h.rezerv_durumu = 'A';
    
    return ln_nominal;
    
  exception
    when no_data_found then
      return 0;
  end;
END;
/
