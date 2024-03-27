create or replace package PKG_RC_ACCOUNTING is

  -- Author  : SEZGIY
  -- Created : 14.10.2008 09:36:41
  -- Purpose : 
  
  TYPE RC_Accounting is REF CURSOR;

  Function RC_QRY1101_GET_DK_INFO(pc_basDk varchar2, pc_bitDk varchar2, pc_dovizKodu varchar2, pc_subeKodu varchar2,
                                pc_hareketTuru varchar2, pd_basTar date, pd_bitTar date, pn_basTutar number,
                                pc_bitTutar number, ps_f_evaluasyon in varchar2, ps_apptype in varchar2 default 'BNK' ) Return RC_Accounting;
  
  function RC_QRY1107_GET_MUH_FIS_SATIR(pc_subekodu varchar2,pc_kullanicikodu varchar2, pd_tarih date, pd_sontarih date) Return RC_Accounting;
    
    
  function RC_QRY1108_GET_HESAP_PLAN_LIST(pc_subekonsolide varchar2,pc_subekodu varchar2, pc_tur varchar2, pc_basdk varchar2,
                                        pc_bitdk varchar2) Return RC_Accounting;    
                                        
  function RC_QRY1109_GET_TD_HSP_PLN_LST(pc_bashesapno varchar2,pc_sonhesapno varchar2) Return RC_Accounting;                                   
  
  
  function RC_QRY1161_GET_MSRF_KMSYN_LST(pc_kanalnumara varchar2,pd_bastarih date,pd_sontarih date,pn_musterino number,
                                               pc_maskomturu varchar2,pc_kayitturu varchar2, pn_ilktutar number, pn_sontutar number,
                                               pc_durum varchar2, pc_tahsilatdurum varchar2,pc_hesaplanan0 varchar2) Return RC_Accounting;
                                               
  function RC_QRY1161_GET_MASRAF_TOPLAM(pc_kanalnumara varchar2,pd_bastarih date,pd_sontarih date,pn_musterino number,
                                               pc_maskomturu varchar2,pc_kayitturu varchar2, pn_ilktutar number, pn_sontutar number,
                                               pc_durum varchar2, pc_tahsilatdurum varchar2,pc_hesaplanan0 varchar2) Return RC_Accounting;                                          
                                               
 
 function RC_QRY1105_GET_MUH_FIS_RECORD(pn_numara number,pn_islemno number,pd_bastarih date, pd_sontarih date) Return RC_Accounting;                                                                                     
     
                      
 function RC_QRY1105_GET_MUH_FC_TOTAL(pn_numara number) Return RC_Accounting; 
 
 
 function RC_QRY1104_GET_CBSDETAY(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
  
 function RC_QRY1104_GET_CBSDETAY_TOPLAM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
 
 function RC_QRY1104_GET_SUM_ALCAK_BORC(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
 
 function RC_QRY1104_GET_CBS_NAZIM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting;
 
 function RC_QRY1104_GET_SUM_FAIZ_GELIR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
 
 function RC_QRY1104_GET_SUM_FAIZ_GIDER(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 

 function RC_QRY1104_GET_SUMFAIZDISI_GLR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
 
 function RC_QRY1104_GET_SUMFAIZDISI_GDR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting; 
 
 Function RC_QRY1102_GET_DK_INFO(pc_DkNo varchar2, pc_dovizKodu varchar2, pc_subeKodu varchar2,  pd_basTar date, pd_bitTar date,pn_devredenBakiye number,pn_MinTutar number,pn_MaxTutar number) Return RC_Accounting;
 
 Function RC_QRY1115_GET_SERBEST_BA(pc_subeKodu varchar2,
                                   pd_basTar   date,
                                   pd_bitTar   date) Return RC_Accounting;
   
                            
 Function Gun_agirlik (pd_date in date) return number;
 
 Function RC_QRY1116_ORTALAMA_MIZAN(pc_subeKodu varchar2,
                                   pn_ay   number,
                                   pnyil   number,
                                   pd_tar1 date ,
                                   pd_tar2 date ,
                                   ps_rp_tip  varchar2) Return RC_Accounting  ;                    

 function RC_QRY1117_GET_CBSDETAY(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting ;
 function RC_QRY1117_GET_CBSDETAY_TOPLAM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting ;
 function RC_QRY1117_GET_SUM_ALCAK_BORC(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting ;
 function RC_QRY1194_GET_LIMIT_RISK(pd_tarih date) Return RC_Accounting ;
 function RC_QRY1194_GET_GRUP_LIMITLERI(pd_tarih date) Return RC_Accounting ;
 function RC_QRY1194_GET_SOZLESMELER(pd_tarih date) Return RC_Accounting ;
 Function RC_QRY1105_fis_saat (fis_numara in number) return varchar2;
 function RC_QRY1197_GET_GUNCEL_DURUM(pn_musteri_no number, pn_urun_grup_kodu number) Return RC_Accounting ;
 function RC_QRY1197_GET_ISLEM_LISTESI(pn_musteri_no number, pn_urun_grup_kodu number, pd_bastarih date, pd_bittarih date) Return RC_Accounting ;
 function RC_QRY1197_GET_MAHSUP_GECMISI(pn_musteri_no number, pn_urun_grup_kodu number, pd_bastarih date, pd_bittarih date) Return RC_Accounting ;
 function RC_QRY1198_GET_DONEMSEL_DURUM(pn_musteri_no number, pn_urun_grup_kodu number, pn_donem_yili number, pn_donemkodu number) Return RC_Accounting ;
 
end PKG_RC_ACCOUNTING;

 
/
create or replace package body PKG_RC_ACCOUNTING is



-------------------------------------------------
Function RC_QRY1101_GET_DK_INFO(pc_basDk varchar2, pc_bitDk varchar2, pc_dovizKodu varchar2, pc_subeKodu varchar2,
                                pc_hareketTuru varchar2, pd_basTar date, pd_bitTar date, pn_basTutar number,
                                pc_bitTutar number, ps_f_evaluasyon in varchar2, ps_apptype in varchar2 default 'BNK' ) Return RC_Accounting is
  rc_dk_info RC_Accounting;
  ld_sontarih date;
  ln_basTutar number;
  ln_bitTutar number;
  Lc_basDk   VARCHAR2(20);
  Lc_bitDk   VARCHAR2(20);
  ls_krt varchar2(2000):= 'pc_basDk:'||pc_basDk||',pc_bitDk:'||pc_bitDk||',pc_dovizKodu:'||pc_dovizKodu||
      ',pc_subeKodu:'||pc_subeKodu||',pc_hareketTuru:'||pc_hareketTuru||',pd_basTar:'||pd_basTar||
      ',pd_bitTar:'||pd_bitTar||',pn_basTutar:'||pn_basTutar||',pc_bitTutar:'||pc_bitTutar||',ps_f_evaluasyon:'||ps_f_evaluasyon||',ps_apptype:'||ps_apptype;
  ln_c   number;      
begin

 

  if length(NVL(pc_basDk,'0')) <1 then 
    pkg_hata.hata_yaz(2100,true);
  end if; 

  if pd_bitTar is null then
    ld_sonTarih := bnspr.pkg_muhasebe.Banka_Tarihi_Bul;
  else
    ld_sonTarih :=pd_bitTar ;  
  end if; 
  if pd_basTar is null then
    bnspr.pkg_hata.hata_yaz(330, true, 'Baslangic Tarihi');
  end if;

  
  
  if length (nvl(pc_basDk,'0')) = 9 then
     if ld_sontarih > add_months(pd_basTar,12) then
    bnspr.pkg_hata.hata_yaz (2181,true);
     end if;
  else
     if ld_sontarih > add_months(pd_basTar,1) then
        pkg_hata.hata_yaz(2044,true);
     end if;   
  end if;
  
   PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1101_GET_DK_INFO');

  
  Lc_basDk := rpad(pc_basDk,9,'0') ; 
  Lc_bitDk := rpad(pc_basDk,9,'9') ;

  
  ln_basTutar := nvl(pn_basTutar,0);
  ln_bitTutar := nvl(pc_bitTutar,0);
  if ln_bitTutar = 0 then 
   ln_bitTutar := 9999999999999999999999;
  end if; 
  
  if pkg_genel_pr.database_adi = 'PROD' then
     /* PROD ortamında belli hesapları sadece Rapor ortamından çekebilsin */
     if Lc_basDk = Lc_bitDk then
        if ps_apptype = 'BNK' and pkg_parametre.ParamTextDegerVarMi('OLTPDEN_RAPOR_ALINAMAYAN_DKLAR',Lc_basDk)='E' then
           pkg_hata.hata_yaz(5091,true,Lc_basDk);
        end if;
     else
       if ps_apptype = 'BNK' then
          for c1 in (select text from gnl_param_text where kod='OLTPDEN_RAPOR_ALINAMAYAN_DKLAR')
          Loop
             if c1.text between Lc_basDk and Lc_bitDk then
                pkg_hata.hata_yaz(5091,true,c1.text);
             end if;
          End Loop;
       End if;                  
    end if;   
  end if;  
  
  if length (nvl(pc_basDk,'0')) = 9  then 
    if pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_DK_HESAP',Lc_basDk)='E' then
                    -- 1 günlük ten fazla cekiliyorsa kayit sayisi kontrol et
                      if pkg_tarih.ileri_is_gunu(pd_basTar)-1 < ld_sontarih then
                        SELECT /*+ FULL(SATIR) parallel(satır,4) */ count(1) 
                          into ln_c
                          FROM muh_islem islem, MUH_FIS FIS, MUH_FIS_SATIR SATIR
                         WHERE SATIR.Hesap_Numara  = pc_basDk
                           and fis.numara = satir.fis_numara
                           and fis.islem_numara = islem.numara
                           and satir.hesap_tur_kodu = 'DK'
                           and fis.tur='G'
                           and satir.doviz_kod = nvl(pc_dovizKodu,satir.doviz_kod)
                           and satir.hesap_sube_kod = nvl(pc_subeKodu,satir.hesap_sube_kod)
                           and FIS.MUH_TARIH  between pd_basTar and ld_sontarih
                           and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and satir.b_a = pc_hareketTuru ) )
                           and abs(satir.dv_tutar) between ln_basTutar and ln_bitTutar
                           and ( (ps_f_evaluasyon = 'E' and islem.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) ;

                         if ln_c > NVL(pkg_parametre.Deger_Al_K_N('SORGU_MAX_KAYIT_SAYI'),0) then
                            pkg_hata.hata_yaz(2362, true);
                         end if ;
                      end if;

        Open rc_dk_info For
         select /*+ INDEX(A PK_MUH_HAREKET_SATIR) */ a.hesap_numara satir_hesap_numara, a.doviz_kod satir_doviz_kod,a.HESAP_SUBE_KOD satir_hesap_bolum_kodu,
                    b.MUH_TARIH  fis_yaratildigi_banka_tarih,a.aciklama_banka satir_banka_aciklama,
                    a.dv_tutar satir_dv_tutar , a.B_A satir_tur ,a.fis_numara ,b.aciklama fis_aciklama,a.aciklama_musteri satir_musteri_aciklama,
                    i.kayit_kullanici_kodu  girisci , b.yaratan_kullanici_kodu onayci ,a.yaratildigi_tarih as satir_tarih
                from muh_islem i , MUH_FIS_SATIR a, MUH_FIS b
                where b.numara = a.fis_numara 
                and b.islem_numara = i.numara
                and a.hesap_tur_kodu = 'DK'
                and b.TUR = 'G'
                and a.hesap_numara = pc_basDk 
                and a.doviz_kod = nvl(pc_dovizKodu,a.doviz_kod)
                and a.hesap_sube_kod = nvl(pc_subeKodu,a.hesap_sube_kod)
                and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and a.b_a = pc_hareketTuru ) )
                and b.MUH_TARIH between pd_basTar and ld_sontarih
                and abs(a.dv_tutar) between ln_basTutar and ln_bitTutar
                and ( (ps_f_evaluasyon = 'E' and i.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) 
                order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod,b.MUH_TARIH,a.fis_numara  ;
    else
                    -- 1 günlük ten fazla cekiliyorsa kayit sayisi kontrol et
                      if pkg_tarih.ileri_is_gunu(pd_basTar)-1 < ld_sontarih then
                        SELECT /*+ INDEX(SATIR IND_HESAPNO) INDEX(FIS PK_MUH_HAREKET) */  count(1) 
                          into ln_c
                          FROM muh_islem islem, MUH_FIS FIS, MUH_FIS_SATIR SATIR
                         WHERE SATIR.Hesap_Numara  = pc_basDk
                           and fis.numara = satir.fis_numara
                           and fis.islem_numara = islem.numara
                           and satir.hesap_tur_kodu = 'DK'
                           and fis.tur='G'
                           and satir.doviz_kod = nvl(pc_dovizKodu,satir.doviz_kod)
                           and satir.hesap_sube_kod = nvl(pc_subeKodu,satir.hesap_sube_kod)
                           and FIS.MUH_TARIH  between pd_basTar and ld_sontarih
                           and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and satir.b_a = pc_hareketTuru ) )
                           and abs(satir.dv_tutar) between ln_basTutar and ln_bitTutar
                           and ( (ps_f_evaluasyon = 'E' and islem.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) ;

                         if ln_c > NVL(pkg_parametre.Deger_Al_K_N('SORGU_MAX_KAYIT_SAYI'),0) then
                            pkg_hata.hata_yaz(2362, true);
                         end if ;
                      end if;
        Open rc_dk_info For
         select /*+ INDEX(A IND_HESAPNO) INDEX(B PK_MUH_HAREKET) */  a.hesap_numara satir_hesap_numara, a.doviz_kod satir_doviz_kod,a.HESAP_SUBE_KOD satir_hesap_bolum_kodu,
                    b.MUH_TARIH  fis_yaratildigi_banka_tarih,a.aciklama_banka satir_banka_aciklama,
                    a.dv_tutar satir_dv_tutar , a.B_A satir_tur ,a.fis_numara ,b.aciklama fis_aciklama,a.aciklama_musteri satir_musteri_aciklama,
                    i.kayit_kullanici_kodu  girisci , b.yaratan_kullanici_kodu onayci ,a.yaratildigi_tarih as satir_tarih
                from muh_islem i , MUH_FIS_SATIR a, MUH_FIS b
                where b.numara = a.fis_numara 
                and b.islem_numara = i.numara
                and a.hesap_tur_kodu = 'DK'
                and b.TUR = 'G'
                and a.hesap_numara = pc_basDk 
                and a.doviz_kod = nvl(pc_dovizKodu,a.doviz_kod)
                and a.hesap_sube_kod = nvl(pc_subeKodu,a.hesap_sube_kod)
                and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and a.b_a = pc_hareketTuru ) )
                and b.MUH_TARIH between pd_basTar and ld_sontarih
                and abs(a.dv_tutar) between ln_basTutar and ln_bitTutar
                and ( (ps_f_evaluasyon = 'E' and i.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) 
                order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod,b.MUH_TARIH,a.fis_numara  ;
    end if;    
  
  else  

                    -- 1 günlük ten fazla cekiliyorsa kayit sayisi kontrol et
                      if pkg_tarih.ileri_is_gunu(pd_basTar)-1 < ld_sontarih then
                        SELECT /*+ FULL(SATIR) parallel(satır,4) */ count(1) 
                          into ln_c
                          FROM muh_islem islem, MUH_FIS FIS, MUH_FIS_SATIR SATIR
                         WHERE SATIR.Hesap_Numara   between Lc_basDk  and Lc_bitDk
                           and fis.numara = satir.fis_numara
                           and fis.islem_numara = islem.numara
                           and satir.hesap_tur_kodu = 'DK'
                           and fis.tur='G'
                           and satir.doviz_kod = nvl(pc_dovizKodu,satir.doviz_kod)
                           and satir.hesap_sube_kod = nvl(pc_subeKodu,satir.hesap_sube_kod)
                           and FIS.MUH_TARIH  between pd_basTar and ld_sontarih
                           and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and satir.b_a = pc_hareketTuru ) )
                           and abs(satir.dv_tutar) between ln_basTutar and ln_bitTutar
                           and ( (ps_f_evaluasyon = 'E' and islem.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) ;

                         if ln_c > NVL(pkg_parametre.Deger_Al_K_N('SORGU_MAX_KAYIT_SAYI'),0) then
                            pkg_hata.hata_yaz(2362, true);
                         end if ;
                      end if;
  
  
  Open rc_dk_info For
   select a.hesap_numara satir_hesap_numara, a.doviz_kod satir_doviz_kod,a.HESAP_SUBE_KOD satir_hesap_bolum_kodu,
              b.MUH_TARIH  fis_yaratildigi_banka_tarih,a.aciklama_banka satir_banka_aciklama,
              a.dv_tutar satir_dv_tutar , a.B_A satir_tur ,a.fis_numara ,b.aciklama fis_aciklama,a.aciklama_musteri satir_musteri_aciklama,
              i.kayit_kullanici_kodu  girisci , b.yaratan_kullanici_kodu onayci ,a.yaratildigi_tarih as satir_Tarih
          from muh_islem i , MUH_FIS_SATIR a, MUH_FIS b
          where b.numara = a.fis_numara 
          and b.islem_numara = i.numara
          and a.hesap_tur_kodu = 'DK'
          and b.TUR = 'G'
          and a.hesap_numara between Lc_basDk  and Lc_bitDk
          and a.doviz_kod = nvl(pc_dovizKodu,a.doviz_kod)
          and a.hesap_sube_kod = nvl(pc_subeKodu,a.hesap_sube_kod)
          and ((pc_hareketTuru = 'T')  OR (pc_hareketTuru != 'T' and a.b_a = pc_hareketTuru ) )
          and b.MUH_TARIH between pd_basTar and ld_sontarih
          and abs(a.dv_tutar) between ln_basTutar and ln_bitTutar
          and ( (ps_f_evaluasyon = 'E' and i.islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) 
          order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod,b.MUH_TARIH,a.fis_numara
  ;
  
  end if; 
     /*  select a.satir_hesap_numara, a.satir_doviz_kod,a.satir_hesap_bolum_kodu,
              a.fis_muhasebelestigi_tarih as fis_yaratildigi_banka_tarih,a.satir_banka_aciklama,
              a.satir_dv_tutar, a.satir_tur ,a.fis_numara,a.fis_aciklama,a.satir_musteri_aciklama
          from v_muh_fis_satir a
          where 
          (a.satir_hesap_numara 
          between nvl(Lc_basDk ,a.satir_hesap_numara) 
                  and 
                  nvl(Lc_bitDk ,a.satir_hesap_numara))
          and a.satir_doviz_kod = nvl(pc_dovizKodu,a.satir_doviz_kod)
          and a.satir_hesap_bolum_kodu = nvl(pc_subeKodu,a.satir_hesap_bolum_kodu)
          and ((pc_hareketTuru = 'T' and a.b_a in ('B','A')) OR (pc_hareketTuru = 'B' and a.b_a = 'B') OR (pc_hareketTuru = 'A' and a.b_a = 'A'))
          and trunc(a.fis_muhasebelestigi_tarih) between nvl(pd_basTar,trunc(a.fis_yaratildigi_tarih)) and nvl(ld_sontarih,trunc(a.fis_yaratildigi_tarih))
          -- BNSPRPRO-5390 abs 
          and (abs(a.satir_dv_tutar) between nvl(decode(pn_basTutar, 0, null, pn_basTutar), abs(a.satir_dv_tutar)) and nvl(decode(pc_bitTutar, 0, null, pc_bitTutar),abs(a.satir_dv_tutar)))
          and  a.fis_tur = 'G'
          and ( (ps_f_evaluasyon = 'E' and a.fis_islem_kod not in (5202,5203) ) OR (ps_f_evaluasyon = 'H' )) 
          order by a.satir_hesap_bolum_kodu, a.satir_hesap_numara, a.satir_doviz_kod,a.fis_muhasebelestigi_tarih,  a.fis_numara
  */  
  

  return rc_dk_info;
end;
-------------------------------------------------
function RC_QRY1107_GET_MUH_FIS_SATIR(pc_subekodu varchar2,pc_kullanicikodu varchar2, pd_tarih date, pd_sontarih date) Return RC_Accounting IS
  rc_dk_fissatir RC_Accounting;
  vc_doviz_kodu gnl_doviz_kod_pr.kod%type;
  lc_kull_kod varchar2(30)  ;
  ls_krt varchar2(2000):= 'pc_subekodu:'||pc_subekodu||',pc_kullanicikodu:'||pc_kullanicikodu||',pd_tarih:'||pd_tarih||
      ',pd_sontarih:'||pd_sontarih;
   
begin

  if NVL(pd_sontarih,pkg_muhasebe.Banka_Tarihi_Bul) > add_months(NVL(pd_tarih,to_date('01.01.1900','dd.mm.yyyy')),1) then
     pkg_hata.hata_yaz(2044,true);
  end if;   
  if pc_kullanicikodu='' then lc_kull_kod := null ; else lc_kull_kod := pc_kullanicikodu ; end if;

  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1107_GET_MUH_FIS_SATIR');


  vc_doviz_kodu := pkg_genel_pr.lc_al;
  open rc_dk_fissatir FOR
          select /*+ use_hash(A.FIS) */ a.amir_sube_kod,
                 a.fis_muhasebelestigi_tarih,
                 a.fis_islem_numara,
                 a.fis_numara,
                 SUM(DECODE(a.b_a, 'B', a.satir_lc_tutar, 0)) BORC,
                 SUM(DECODE(a.b_a, 'A', a.satir_lc_tutar, 0)) ALAC,
                 a.fis_islem_kod,
                 pkg_genel_pr.islem_adi(a.fis_islem_kod) islem_adi,
                 decode(a.amir_sube_kod,
                        '999',
                        null,
                        pkg_genel_pr.sube_adi(a.amir_sube_kod)) islem_sube_adi,
                 decode(pkg_hp.TL_HESAPMI(a.satir_hesap_numara),
                        'E',
                        vc_doviz_kodu,
                        a.satir_doviz_kod) doviz_turu,
                 pkg_genel_pr.kullanici_adi(a.kayit_kullanici_kodu) kullanici_adi,
                 decode(a.onaylayan_kullanici,
                        null,
                        null,
                        pkg_genel_pr.kullanici_adi(a.onaylayan_kullanici)) onaylayan_kullanici,
                 decode(a.iptal_kullanici_kodu,
                        null,
                        null,
                        pkg_genel_pr.kullanici_adi(a.iptal_kullanici_kodu)) iptal_kullanici_kodu,
                 decode(a.iptal_onay_kull_kodu,
                        null,
                        null,
                        pkg_genel_pr.kullanici_adi(a.iptal_onay_kull_kodu)) iptal_onay_kull_kodu,
                 decode(a.durum,
                        '1',
                        'İptal',
                        '2',
                        'İptal',
                        'R',
                        'Ret',
                        'Gerçekleşmiş') durum,
                 a.kayit_kullanici_kodu kayit_kullanici_kodu,
                 a.onaylayan_kullanici onay_kull_kodu,
                 (select tutar
                    from muh_islem m
                   where m.numara = a.fis_islem_numara) islem_tutari
            from v_muh_fis_satir a /*,v_muh_fis_satir_sum s*/
           where a.amir_sube_kod = nvl(pc_subekodu, a.amir_sube_kod)
             and a.kayit_kullanici_kodu = nvl(lc_kull_kod, a.kayit_kullanici_kodu)
             and a.fis_muhasebelestigi_tarih between pd_tarih and    pd_sontarih
             and a.fis_tur='G'
          /* and s.fis_numara = a.fis_numara*/
           group by a.amir_sube_kod,
                    a.fis_muhasebelestigi_tarih,
                    a.fis_islem_numara,
                    a.fis_numara,
                    a.kayit_kullanici_kodu,
                    a.fis_islem_kod,
                    decode(pkg_hp.TL_HESAPMI(a.satir_hesap_numara),
                           'E',
                           vc_doviz_kodu,
                           a.satir_doviz_kod),
                    a.onaylayan_kullanici,
                    a.iptal_kullanici_kodu,
                    a.iptal_onay_kull_kodu,
                    a.durum;
           
  return rc_dk_fissatir;
end;
-------------------------------------------------
function RC_QRY1108_GET_HESAP_PLAN_LIST(pc_subekonsolide varchar2,pc_subekodu varchar2, pc_tur varchar2, pc_basdk varchar2,
                                        pc_bitdk varchar2) Return RC_Accounting is
 rc_dk_planlis RC_Accounting;
   ls_krt varchar2(2000):= 'pc_subekonsolide:'||pc_subekonsolide||',pc_subekodu:'||pc_subekodu||',pc_tur:'||pc_tur||
      ',pc_basdk:'||pc_basdk||',pc_bitdk:'||pc_bitdk;
 begin
 
 PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1108_GET_HESAP_PLAN_LIST');
 
 if pc_tur in ('TL','YP') then
   /* tur secerse sadece alt hesaplari gösteriyoruz */ 
     if pc_subekonsolide = 'S' then
        open rc_dk_planlis for
          select v.sube_kod,   v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod,sum(v.lc_bakiye) as lc_bakiye,sum(v.bakiye) as fc_bakiye
            from v_muh_hp_hesap v
           where v.sube_kod = pc_subekodu
             and v.lc_bakiye<>0
             and (pc_tur = 'TL' and doviz_kod=pkg_genel_pr.lc_al) or (pc_tur = 'YP' and doviz_kod not in ('XXX',pkg_genel_pr.lc_al)) 
             and (v.hesap_no between nvl(rpad(decode(pc_basdk,'',null,pc_basdk),9,'0'),v.hesap_no) and nvl(rpad(decode(pc_bitdk,'',null,pc_bitdk),9,'0'),v.hesap_no))
            group by  v.sube_kod,v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod
            order by hesap_no, doviz_kod ;
     else
        open rc_dk_planlis for
            select   v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod,sum(v.lc_bakiye) as lc_bakiye,sum(v.bakiye) as fc_bakiye
            from v_muh_hp_hesap v
            where  pc_subekonsolide ='K' 
            and v.lc_bakiye<>0
            and ((pc_tur = 'TL' and doviz_kod=pkg_genel_pr.lc_al) or (pc_tur = 'YP' and doviz_kod not in ('XXX',pkg_genel_pr.lc_al)) or pc_tur='HEPSI')
            and (v.hesap_no between nvl(rpad(decode(pc_basdk,'',null,pc_basdk),9,'0'),v.hesap_no) and nvl(rpad(decode(pc_bitdk,'',null),9,'0'),v.hesap_no))
            group by v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod
            order by hesap_no, doviz_kod ;
     end if;
  else
     /* ust hesaplar da aliniyor */
     if pc_subekonsolide = 'S' then
        open rc_dk_planlis for
            select v.sube_kod,   v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod,
                   /*decode(v.doviz_kod,'XXX',b.lc_bakiye,v.lc_bakiye)*/v.lc_bakiye as lc_bakiye,
                   /*decode(v.doviz_kod,'XXX',b.bakiye,v.bakiye)*/v.bakiye as fc_bakiye
            from v_muh_hp_hesap v/*, v_muh_hp_anlik_bakiye b*/
            where v.sube_kod = pc_subekodu
            and v.lc_bakiye<>0
            and (v.hesap_no between nvl(rpad(decode(pc_basdk,'',null,pc_basdk),9,'0'),v.hesap_no) and nvl(rpad(decode(pc_bitdk,'',null,pc_bitdk),9,'0'),v.hesap_no))
            /*and b.sube_kod(+)=v.sube_kod
            and b.hesap_no(+)=v.hesap_no*/
            order by hesap_no, doviz_kod ;
     else
        open rc_dk_planlis for
            select   v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod,
                     sum(/*DEcode(v.doviz_kod,'XXX',b.lc_bakiye,*/(v.lc_bakiye)) as lc_bakiye,
                     sum(/*Decode(v.doviz_kod,'XXX',b.bakiye,*/ (v.bakiye)) as fc_bakiye
            from v_muh_hp_hesap v/*,v_muh_hp_anlik_bakiye b*/
            where ( pc_subekonsolide ='K' )
            and v.lc_bakiye<>0
            and (v.hesap_no between nvl(rpad(decode(pc_basdk,'',null,pc_basdk),9,'0'),v.hesap_no) and nvl(rpad(decode(pc_bitdk,'',null),9,'0'),v.hesap_no))
           /* and b.sube_kod(+)=v.sube_kod
            and b.hesap_no(+)=v.hesap_no*/
            group by v.hesap_no,v.doviz_kod,v.dk_kisa_isim,v.musterili_hesap_mi,v.ba_kod
            order by hesap_no, doviz_kod ;
     end if;
  end if;
 return rc_dk_planlis;
end;
  --------------------------------------------------

 function RC_QRY1109_GET_TD_HSP_PLN_LST(pc_bashesapno varchar2,pc_sonhesapno varchar2) Return RC_Accounting is
 rc_dk_tekduzenplanlis RC_Accounting;

     ls_krt varchar2(2000):= 'pc_bashesapno:'||pc_bashesapno||',pc_sonhesapno:'||pc_sonhesapno;
    vd_banka_tarihi date := pkg_muhasebe.Banka_Tarihi_Bul;
    vc_sube varchar2(10) := pkg_global.GET_SUBEKOD;
    
 begin
    PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1109_GET_TD_HSP_PLN_LST');
 open rc_dk_tekduzenplanlis for
        select m.hesap_no,m.dk_kod,m.ba_kod,m.aciklama,m.hesap_terse_donsun_mu,m.althesap_mi,m.hesap_tipi
        from muh_hp_tanim m
        where m.hesap_no between nvl(pc_bashesapno,hesap_no) and nvl(pc_sonhesapno,hesap_no) 
          and exists (select 1 from muh_hp_bakiye b 
                           where b.hesap_no=m.hesap_no 
                             and b.doviz_kod in ('TRY','USD','XXX')
                             and (b.bitis_tarihi is null or b.bitis_tarihi>vd_banka_tarihi))
                             /*and b.sube_kod=vc_sube)*/
        order by 1,2;
        return  rc_dk_tekduzenplanlis;
  end;
-------------------------------------------------------

 function RC_QRY1161_GET_MSRF_KMSYN_LST(pc_kanalnumara varchar2,pd_bastarih date,pd_sontarih date,pn_musterino number,
                                               pc_maskomturu varchar2,pc_kayitturu varchar2, pn_ilktutar number, pn_sontutar number,
                                               pc_durum varchar2, pc_tahsilatdurum varchar2,pc_hesaplanan0 varchar2 ) Return RC_Accounting is
 rc_dk_komisyonlist RC_Accounting;
 
   ls_krt varchar2(2000):= 'pc_kanalnumara:'||pc_kanalnumara||',pd_bastarih:'||pd_bastarih||',pd_sontarih:'||pd_sontarih||
      ',pn_musterino:'||pn_musterino||',pc_maskomturu:'||pc_maskomturu||',pc_kayitturu:'||pc_kayitturu||',pn_ilktutar:'||pn_ilktutar
      ||',pn_sontutar:'||pn_sontutar||',pc_durum:'||pc_durum||',pc_tahsilatdurum:'||pc_tahsilatdurum||',pc_hesaplanan0:'||pc_hesaplanan0;
 
 begin
    if pd_basTarih is null then
        pkg_hata.hata_yaz(330,true,pkg_parametre.MesajTextAl(pc_kod => 1166,pc_key => 'BASLANGIC_TARIHI'));
    end if;
    if pd_sonTarih is null then
        pkg_hata.hata_yaz(330,true,pkg_parametre.MesajTextAl(pc_kod => 1166,pc_key => 'BITIS_TARIHI'));
    end if;   
    if pd_sonTarih > add_months(pd_basTarih,1) then
       pkg_hata.hata_yaz(2044,true);
    end if;  
    
    PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1161_GET_MSRF_KMSYN_LST');

    
    open rc_dk_komisyonlist for
      Select * From (
      select /*+ FULL(I) */ i.kanal_numara,i.amir_sube_kod,i.kayit_tarih,i.islem_kod,v.ACIKLAMA,m.musteri_no,m.hesap_no,--Pkg_Musteri.unvan(m.musteri_no) unvan,
        DEcode(a.musteri_tur_kod,'G',decode(NVL(a.musteri_stat1,1),4,replace(a.adi||' '||a.ikinci_adi||' '||a.soyadi,'  ',' ')||' - '||a.ticari_unvan,
                                                                     replace(a.adi||' '||a.ikinci_adi||' '||a.soyadi,'  ',' ')),
                'O',a.kisa_ad,a.ticari_unvan) Unvan,
      i.tutar islem_tutari,i.doviz_kod, m.masraf_kodu,NVL(m.aciklama,mas.ACIKLAMA) m_k_aciklama, 
      /*pkg_masraf_yeni.masraf_tahsil_hesaplanan(m.tx_no,m.masraf_kodu,m.sira) hesaplanan, 
      pkg_masraf_yeni.masraf_tahsil_alinan(m.tx_no,m.masraf_kodu,m.sira) alinan,  
      pkg_masraf_yeni.masraf_tahsil_dovizi(m.tx_no,m.masraf_kodu,m.sira) dvz,*/
       /*decode(m.dvz,pkg_genel_pr.lc_al,m.hesaplanan,pkg_masraf_yeni.masraf_tahsil_hesaplanan(m.tx_no,m.masraf_kodu,m.sira))*/ m.hesaplanan,
       /*decode(m.dvz,pkg_genel_pr.lc_al,m.alinan,pkg_masraf_yeni.masraf_tahsil_alinan(m.tx_no,m.masraf_kodu,m.sira))*/ m.alinan,
       /*decode(m.dvz,pkg_genel_pr.lc_al,m.dvz,decode(m.masraf_hesap_tur_kod,'DK',m.dvz,pkg_hesap.doviz_kodu(m.mas_hesap_no))\*pkg_masraf_yeni.masraf_tahsil_dovizi(m.tx_no,m.masraf_kodu,m.sira)*\)*/ dvz,
      decode(m.iade_f,'E','İade','Tahsilat') durum,i.fis_numara,i.numara
       from muh_islem i,gnl_masraf m,v_ml_muh_islem_tanim_pr v,v_ml_gnl_masraf_komisyon_pr mas,gnl_musteri a
      where i.kanal_numara = NVL(pc_kanalnumara,i.kanal_numara)
      and i.kayit_tarih between pd_bastarih and pd_sontarih
      and i.durum in ('P','3','N')
      and m.tx_no = i.numara
      and (m.musteri_no = NVL(pn_musterino,m.musteri_no) or pn_musterino is null)
      and m.masraf_kodu = NVL(pc_maskomturu,m.masraf_kodu)
      and m.durum='VALID'
      and a.musteri_no(+) = m.musteri_no
      and v.KOD = i.islem_kod
      and ((pc_hesaplanan0 <> 'true' and m.hesaplanan <> 0) or pc_hesaplanan0 = 'true')
      and mas.KOD = m.masraf_kodu
      and mas.M_K = NVL(pc_kayitturu,mas.M_K)
      and m.alinan between NVL(pn_ilktutar,m.alinan) and NVL(pn_sontutar,m.alinan)
      and ((pc_durum = 'T' and m.iade_f is null) or (pc_durum = 'I' and m.iade_f='E') or (pc_durum is null))
      and ((pc_tahsilatdurum = '1' and m.alinan < m.hesaplanan) or (pc_tahsilatdurum = '2' and m.alinan = m.hesaplanan) or (pc_tahsilatdurum = '3' and m.alinan > m.hesaplanan) or (pc_tahsilatdurum is null))
      )tab
      Where (tab.alinan !=0 Or tab.hesaplanan!=0);
      

   return  rc_dk_komisyonlist;

    end;
--------------------------------------------------------
function RC_QRY1161_GET_MASRAF_TOPLAM(pc_kanalnumara varchar2,pd_bastarih date,pd_sontarih date,pn_musterino number,
                                               pc_maskomturu varchar2,pc_kayitturu varchar2, pn_ilktutar number, pn_sontutar number,
                                               pc_durum varchar2, pc_tahsilatdurum varchar2,pc_hesaplanan0 varchar2) Return RC_Accounting is
 rc_dk_masraftoplam RC_Accounting;


   ls_krt varchar2(2000):= 'pc_kanalnumara:'||pc_kanalnumara||',pd_bastarih:'||pd_bastarih||',pd_sontarih:'||pd_sontarih||
      ',pn_musterino:'||pn_musterino||',pc_maskomturu:'||pc_maskomturu||',pc_kayitturu:'||pc_kayitturu||',pn_ilktutar:'||pn_ilktutar
      ||',pn_sontutar:'||pn_sontutar||',pc_durum:'||pc_durum||',pc_tahsilatdurum:'||pc_tahsilatdurum||',pc_hesaplanan0:'||pc_hesaplanan0;
 


 begin
 
 PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1161_GET_MASRAF_TOPLAM');

 
 open rc_dk_masraftoplam for
      select count(*) kayit_sayisi,
      sum(Decode(x.iade_f,'E',0,hesaplanan)) hesaplanan,
      Sum(Decode(x.iade_f,'E',0,alinan)) alinan, dvz From
      (
      
          Select m.Iade_f iade_f, 
                 /*decode(m.dvz,pkg_genel_pr.lc_al,m.hesaplanan,pkg_masraf_yeni.masraf_tahsil_hesaplanan(m.tx_no,m.masraf_kodu,m.sira))*/ hesaplanan,
                 /*decode(m.dvz,pkg_genel_pr.lc_al,m.alinan,pkg_masraf_yeni.masraf_tahsil_alinan(m.tx_no,m.masraf_kodu,m.sira))*/ alinan,
                 /*decode(m.dvz,pkg_genel_pr.lc_al,m.dvz,pkg_masraf_yeni.masraf_tahsil_dovizi(m.tx_no,m.masraf_kodu,m.sira))*/ dvz
          from muh_islem i,gnl_masraf m /*,v_ml_muh_islem_tanim_pr v,v_ml_gnl_masraf_komisyon_pr mas*/
          where i.kanal_numara = NVL(pc_kanalnumara,i.kanal_numara)
          and i.kayit_tarih between pd_bastarih and pd_sontarih
          and i.durum in ('P','3','N')
          and m.tx_no = i.numara
          and (m.musteri_no = NVL(pn_musterino,m.musteri_no) or m.musteri_no is null)
          and m.masraf_kodu = NVL(pc_maskomturu,m.masraf_kodu)
          and m.durum='VALID'
          /*and v.KOD = i.islem_kod*/
          and ((pc_hesaplanan0 <> 'true' and m.hesaplanan <> 0) or pc_hesaplanan0 = 'true')
       /*   and mas.KOD = m.masraf_kodu
          and mas.M_K = NVL(pc_kayitturu,mas.M_K)*/
          and m.alinan between NVL(pn_ilktutar,m.alinan) and NVL(pn_sontutar,m.alinan)
          and ((pc_durum = 'T' and m.iade_f is null) or (pc_durum = 'I' and m.iade_f='E') or (pc_durum is null))
          and ((pc_tahsilatdurum = '1' and m.alinan < m.hesaplanan) or (pc_tahsilatdurum= '2' and m.alinan = m.hesaplanan) or (pc_tahsilatdurum = '3' and m.alinan > m.hesaplanan) or (pc_tahsilatdurum is null))
             
      )x 
      Where (x.alinan !=0 Or x.hesaplanan!=0)
      Group By dvz
         order by 4;

     return  rc_dk_masraftoplam;

 end;
----------------------------------------------------------

  function RC_QRY1105_GET_MUH_FIS_RECORD(pn_numara number, pn_islemno number,pd_bastarih date, pd_sontarih date) Return RC_Accounting is

  rc_dk_muhfisrecord RC_Accounting;
  ls_tur varchar2(100);
   ls_krt varchar2(2000):= 'pn_numara:'||pn_numara||',pd_bastarih:'||pd_bastarih||',pd_sontarih:'||pd_sontarih;

 begin
   PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1105_GET_MUH_FIS_RECORD');
   select  pkg_parametre.ParamTextAl('MUHFIS_TUR_KOD',decode(a.tur,'G',decode(a.MUH_TARIH,null,'T',a.tur),a.tur) )  
   into ls_tur 
   from  MUH_FIS a 
   where a.numara = pn_numara
   ; 
  
  
  open rc_dk_muhfisrecord for
      select a.fis_numara, 
             decode(a.fis_tur,'G',decode(a.fis_muhasebelestigi_tarih,null,'T',a.fis_tur),a.fis_tur) as fis_tur,
             a.satir_hesap_bolum_kodu,
             a.satir_hesap_numara,
             a.satir_valor_tarihi,
             a.satir_lc_tutar,
             a.satir_dv_tutar,
             a.satir_doviz_kod,
             a.satir_banka_aciklama, 
             a.satir_musteri_aciklama,
             a.satir_referans,
             a.satir_musteri_hesap_tur, 
             a.satir_musteri_hesap_numara, 
             a.satir_istatistik_kodu,
             a.fis_muhasebelestigi_tarih, 
             a.satir_yaratildigi_tarih,
             a.yaratan_kullanici_kodu,
             a.fis_aciklama,
             a.kur,
             a.b_a,
             Decode(a.satir_musteri_hesap_numara, NULL, NULL,pkg_hesap.musteri_no(a.satir_musteri_hesap_numara,'T')) MUSTERI_NO,
             Decode(a.satir_musteri_hesap_numara, NULL, NULL,PKG_MUSTERI.kisa_ad(pkg_hesap.musteri_no(a.satir_musteri_hesap_numara))) UNVAN,
             PKG_HP.isim_al(a.satir_hesap_numara) DK_HESAP_ADI,
             a.kayit_kullanici_kodu,
             ls_tur  tur,
             a.dogrulayan_kullanici,
             a.temel_hesap
        from v_muh_fis_satir a 
       where a.fis_numara = pn_numara
         and a.fis_islem_kod = nvl(pn_islemno,fis_islem_kod)
      /*and trunc(fis_muhasebelestigi_tarih) between nvl(pd_bastarih,trunc(fis_muhasebelestigi_tarih)) and nvl(pd_sontarih,trunc(fis_muhasebelestigi_tarih));
       bu kýsým hem gereksiz hem de gecici fislerin listelenmesini engelliyor MHA 121108*/
       ;
  return rc_dk_muhfisrecord;

end;

----------------------------------------------------------

function RC_QRY1105_GET_MUH_FC_TOTAL(pn_numara number) Return RC_Accounting is rc_dk_muhfctotal RC_Accounting;
   ls_krt varchar2(2000):= 'pn_numara:'||pn_numara;

 begin
   PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1105_GET_MUH_FC_TOTAL');
 open rc_dk_muhfctotal for
      select doviz_kod,sum(dv_tutar_alacak), sum(dv_tutar_borc)
      from V_MUH_fis_satir_sum
      where fis_numara = pn_numara group by doviz_kod;

return rc_dk_muhfctotal;
end;
-----------------------------------------------------------
function RC_QRY1104_GET_CBSDETAY(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is

rc_dk_mizanhareket RC_Accounting;

   ls_krt varchar2(2000):= 'pc_subekodu:'||pc_subekodu||',pd_tarih:'||pd_tarih||',pc_tur:'||pc_tur;

begin

  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1104_GET_CBSDETAY');

open  rc_dk_mizanhareket for

      Select decode(pc_subekodu,null,null,sube_kodu) sube_kodu,tarih,tur,DECODE(doviz_kod,'XXX',' ',doviz_kod) doviz_kod,/*SUBSTR(aciklama,1,50)*/ aciklama, sum(borc_lc) as borc_lc,sum(alacak_lc) as alacak_lc,
      sum(DECODE(LENGTH(dk_numara),9,borc_fc,0)) borc_fc,sum(DECODE(LENGTH(dk_numara),9,alacak_fc,0)) alacak_fc,sum(bakiye_lc) as bakiye_lc,
      sum(DECODE(LENGTH(dk_numara),9,bakiye_fc,0)) bakiye_fc ,dk_numara
      from muh_RPT_MIZAN a
      where sube_kodu = nvl(pc_subekodu,sube_kodu)
      and LENGTH(dk_numara) IN (1,3,5,6,7,8,9) 
      and tarih= pd_tarih
      and tur= pc_tur
      and ( borc_lc !=0  OR alacak_lc  !=0  OR borc_fc !=0  OR alacak_fc !=0  OR bakiye_lc !=0  OR bakiye_fc !=0)
      group by doviz_kod,aciklama,dk_numara,decode(pc_subekodu,null,null,sube_kodu),tarih,tur
      order by dk_numara;/*SUBSTR(dk_numara,1,1), SUBSTR(dk_numara,2,1),
      SUBSTR(dk_numara,3,1),SUBSTR(dk_numara,4,1),
      SUBSTR(dk_numara,5,1),SUBSTR(dk_numara,6,1),
      SUBSTR(dk_numara,7,1),SUBSTR(dk_numara,8,1),SUBSTR(dk_numara,9,1);*/

return  rc_dk_mizanhareket;
end;

--------------------------------------------------------------
 function RC_QRY1104_GET_CBSDETAY_TOPLAM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is

 rc_dk_cbsdetaytoplami RC_Accounting;
begin
open rc_dk_cbsdetaytoplami  for
      Select DECODE(pkg_hp.TL_HESAPMI(dk_numara), 'E', pkg_genel_pr.LC_al,doviz_kod) sum_doviz_kod,
      sum(borc_lc) sum_borc_lc ,
      sum(alacak_lc) sum_alacak_lc ,
      sum(borc_fc) sum_borc_fc ,
      sum(alacak_fc) sum_alacak_fc,
      sum(bakiye_lc) sum_bakiye_lc,
      sum(bakiye_fc) sum_bakiye_fc
      from MUH_RPT_MIZAN
      where sube_kodu= NVL(pc_subekodu ,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih =pd_tarih AND tur= pc_tur
      group by DECODE(pkg_hp.TL_HESAPMI(dk_numara), 'E', pkg_genel_pr.LC_al,doviz_kod)
      having (SUM(borc_lc) !=0 OR SUM(alacak_lc) != 0 OR SUM(borc_fc) !=0 OR
      sum(alacak_fc)!=0 OR sum(bakiye_lc)!=0 OR sum(bakiye_fc)!=0 );
return  rc_dk_cbsdetaytoplami;
end ;
-----------------------------------------------------------
 function RC_QRY1104_GET_SUM_ALCAK_BORC(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is

 rc_dk_sumalacakborc RC_Accounting;
 begin
 open  rc_dk_sumalacakborc for
   select sum(borc_lc) sum_borc_lc_genel ,
   sum(alacak_lc) sum_alacak_lc_genel ,
   sum(borc_fc) sum_borc_fc_genel ,
   sum(alacak_fc) sum_alacak_fc_genel ,
   sum(bakiye_lc) sum_bakiye_lc_genel ,
   sum(bakiye_fc) sum_bakiye_fc_genel
   from MUH_RPT_MIZAN
   where sube_kodu= NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur=pc_tur
   having (SUM(borc_lc) !=0 OR SUM(alacak_lc) != 0 OR SUM(borc_fc) !=0
   OR sum(alacak_fc)!=0 OR sum(bakiye_lc)!=0 OR sum(bakiye_fc)!=0) ;

 return  rc_dk_sumalacakborc;
 end;
----------------------------------------------------------
 function RC_QRY1104_GET_CBS_NAZIM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is
  rc_dk_cbsnazim RC_Accounting;
  begin
  open  rc_dk_cbsnazim for
      SELECT SUM(borc_lc) sum_nazim_borc_lc_genel ,
      SUM(alacak_lc) sum_nazim_alacak_lc_genel ,
      SUM(borc_fc) sum_nazim_borc_fc_genel ,
      SUM(alacak_fc) sum_nazim_alacak_fc_genel ,
      SUM(bakiye_lc) sum_nazim_bakiye_lc_genel ,
      SUM(bakiye_fc) sum_nazim_bakiye_fc_genel ,doviz_kod sum_nazim_doviz_kod
      FROM MUH_RPT_MIZAN
      WHERE SUBSTR(dk_numara,1,1)='9' and sube_kodu=NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih =pd_tarih AND tur= pc_tur
      GROUP BY doviz_kod HAVING (SUM(borc_lc) !=0 OR SUM(alacak_lc) != 0 OR SUM(borc_fc) !=0 OR
      SUM(alacak_fc)!=0 OR SUM(bakiye_lc)!=0 OR SUM(bakiye_fc)!=0 );
return rc_dk_cbsnazim;
end;
--------------------------------------------------------------------
 function RC_QRY1104_GET_SUM_FAIZ_GELIR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is
          rc_dk_sumfaizgelir RC_Accounting;
 begin
 open  rc_dk_sumfaizgelir for

    SELECT SUM(bakiye_lc) sum_faiz_gelir
    FROM MUH_RPT_MIZAN
    WHERE SUBSTR(dk_numara,1,1)='5'and  sube_kodu= NVL(pc_subekodu ,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur= pc_tur;


 return  rc_dk_sumfaizgelir;
end;
---------------------------------------------------
function RC_QRY1104_GET_SUM_FAIZ_GIDER(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is
          rc_dk_sumfaizgider RC_Accounting;
 begin
 open  rc_dk_sumfaizgider for
      SELECT SUM(bakiye_lc) sum_faiz_gider
      FROM MUH_RPT_MIZAN
      WHERE SUBSTR(dk_numara,1,1)='6'
      and  sube_kodu= NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur=pc_tur;
 return  rc_dk_sumfaizgider;
end;
---------------------------------------------------
function RC_QRY1104_GET_SUMFAIZDISI_GLR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is
rc_dk_sumfaizdisigelir RC_Accounting;
 begin
 open  rc_dk_sumfaizdisigelir for
      SELECT SUM(bakiye_lc) sum_faiz_disi_gelir
      FROM MUH_RPT_MIZAN
      WHERE SUBSTR(dk_numara,1,1)='7'
      and  sube_kodu= NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur= pc_tur;

return  rc_dk_sumfaizdisigelir;
end;
------------------------------------------------

function RC_QRY1104_GET_SUMFAIZDISI_GDR(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2) Return RC_Accounting is
rc_dk_sumfaizdisigider RC_Accounting;
 begin
 open  rc_dk_sumfaizdisigider for
      SELECT SUM(bakiye_lc) sum_faiz_disi_gider
      FROM MUH_RPT_MIZAN
      WHERE SUBSTR(dk_numara,1,1)='8'
      and  sube_kodu= NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur= pc_tur;
return  rc_dk_sumfaizdisigider;
end;

-------------------------------------------------
Function RC_QRY1102_GET_DK_INFO(pc_DkNo varchar2, pc_dovizKodu varchar2, pc_subeKodu varchar2,pd_basTar date, pd_bitTar date,pn_devredenBakiye number, pn_MinTutar number,pn_MaxTutar number) Return RC_Accounting is
  rc_dk_hesap_hareket_izleme RC_Accounting;
  vc_hesap_no varchar2(10);
  ld_sontarih date;
  ls_krt varchar2(2000):= 'pc_DkNo:'||pc_DkNo||',pc_dovizKodu:'||pc_dovizKodu||',pc_subeKodu:'||pc_subeKodu||',pd_basTar:'||pd_basTar||
      ',pd_bitTar:'||pd_bitTar||',pn_devredenBakiye:'||pn_devredenBakiye||',pn_MinTutar:'||pn_MinTutar||
      ',pn_MaxTutar:'||pn_MaxTutar;

begin

  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1102_GET_DK_INFO');
  vc_hesap_no := rpad(pc_DkNo ,9,'0');

  if pd_bitTar is null then
    ld_sonTarih := bnspr.pkg_muhasebe.Banka_Tarihi_Bul;
  else
    ld_sonTarih :=pd_bitTar ;  
  end if;
    
  if pd_basTar is null then
    bnspr.pkg_hata.hata_yaz(330, true, 'Baslangic Tarihi');
  end if;

    if ld_sontarih > add_months(pd_basTar,1) then
       pkg_hata.hata_yaz(2044,true);
    end if;   

if pkg_parametre.ParamTextDegerVarMi('COK_HAREKETLI_DK_HESAP',vc_hesap_no)='E' then           
  /* çok hareketli hesap */
  Open rc_dk_hesap_hareket_izleme For
       select /*+ INDEX(A PK_MUH_HAREKET_SATIR) */  a.hesap_numara satir_hesap_numara, a.doviz_kod satir_doviz_kod,a.HESAP_SUBE_KOD satir_hesap_bolum_kodu,
              b.MUH_TARIH  fis_yaratildigi_banka_tarih,a.aciklama_banka satir_banka_aciklama,
              decode(a.b_a, 'A',a.dv_tutar, -1 * a.dv_tutar) satir_dv_tutar ,
              pn_devredenBakiye + 
              sum(decode(a.b_a, 'A',a.dv_tutar, -1 * a.dv_tutar)) over(order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod, b.MUH_TARIH, a.fis_numara, a.numara) cumtutar,
              a.B_A satir_tur ,a.fis_numara ,a.referans satir_referans ,
              i.kayit_kullanici_kodu  girisci , b.yaratan_kullanici_kodu onayci ,
              a.yaratildigi_tarih as satir_tarih,b.islem_numara
          from muh_islem i , MUH_FIS_SATIR a, MUH_FIS b
          where b.numara = a.fis_numara 
          and b.islem_numara = i.numara
          and a.hesap_tur_kodu = 'DK'
          and b.TUR = 'G'
          and a.hesap_numara = vc_hesap_no
          and a.doviz_kod = nvl(pc_dovizKodu,a.doviz_kod)
          and a.hesap_sube_kod = nvl(pc_subeKodu,a.hesap_sube_kod)
          and b.MUH_TARIH between pd_basTar and ld_sonTarih
          and a.dv_tutar between 
               nvl(decode(pn_MinTutar, 0, null, pn_MinTutar), a.dv_tutar) 
               and nvl(decode(pn_MaxTutar, 0, null, pn_MaxTutar),a.dv_tutar)
          order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod,b.MUH_TARIH,a.fis_numara,a.numara  ;
else
  Open rc_dk_hesap_hareket_izleme For
       select /*+ordered */ a.hesap_numara satir_hesap_numara, a.doviz_kod satir_doviz_kod,a.HESAP_SUBE_KOD satir_hesap_bolum_kodu,
              b.MUH_TARIH  fis_yaratildigi_banka_tarih,a.aciklama_banka satir_banka_aciklama,
              decode(a.b_a, 'A',a.dv_tutar, -1 * a.dv_tutar) satir_dv_tutar ,
              pn_devredenBakiye + 
              sum(decode(a.b_a, 'A',a.dv_tutar, -1 * a.dv_tutar)) over(order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod, b.MUH_TARIH, a.fis_numara, a.numara) cumtutar,
              a.B_A satir_tur ,a.fis_numara ,a.referans satir_referans ,
              i.kayit_kullanici_kodu  girisci , b.yaratan_kullanici_kodu onayci ,
              a.yaratildigi_tarih as satir_tarih,b.islem_numara
          FROM  bnspr.MUH_FIS_SATIR A, bnspr.MUH_FIS B,bnspr.MUH_ISLEM I
          where b.numara = a.fis_numara 
          and b.islem_numara = i.numara
          and a.hesap_tur_kodu = 'DK'
          and b.TUR = 'G'
          and a.hesap_numara = vc_hesap_no
          and a.doviz_kod = nvl(pc_dovizKodu,a.doviz_kod)
          and a.hesap_sube_kod = nvl(pc_subeKodu,a.hesap_sube_kod)
          and b.MUH_TARIH between pd_basTar and ld_sonTarih
          and a.dv_tutar between 
               nvl(decode(pn_MinTutar, 0, null, pn_MinTutar), a.dv_tutar) 
               and nvl(decode(pn_MaxTutar, 0, null, pn_MaxTutar),a.dv_tutar)
          order by a.hesap_sube_kod, a.hesap_numara, a.doviz_kod,b.MUH_TARIH,a.fis_numara,a.numara  ;
end if;            


  return rc_dk_hesap_hareket_izleme;
end;

Function RC_QRY1115_GET_SERBEST_BA(pc_subeKodu varchar2,
                                   pd_basTar   date,
                                   pd_bitTar   date) Return RC_Accounting is
  rc_serbest_ba RC_Accounting;
    ls_krt varchar2(2000):= 'pc_subeKodu:'||pc_subeKodu||',pd_basTar:'||pd_basTar||',pd_bitTar:'||pd_bitTar;
begin

    if pd_basTar is null or 
       pd_bitTar is null or 
       (add_months(pd_basTar,6) < pd_bitTar  ) then 
        bnspr.pkg_hata.hata_yaz(2110, true);
     end if;  
  


  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1115_GET_SERBEST_BA');

  Open rc_serbest_ba For
    select a.satir_yaratildigi_tarih ISLEM_TARIHI,
           a.musteri_no,
           pkg_musteri.unvan(a.musteri_no) MUSTERI_UNVAN,
           a.fis_islem_numara ISLEM_NO,
           a.fis_numara T_FIS_NUMARA,
           a.satir_hesap_bolum_kodu SUBE_KODU,
           a.SATIR_HESAP_NUMARA DK_NO,
           a.satir_musteri_hesap_numara HESAP_NO,
           a.musteri_no MUSTERI_NO,
           a.b_a B_A,
           a.satir_doviz_kod DOVIZ_KOD,
           a.satir_dv_tutar TUTAR,
           a.kur KUR,
           a.satir_lc_tutar TL_KARSILIK,
           a.satir_musteri_aciklama ACIKLAMA,
           --a.satir_banka_aciklama "Banka AÃ§Ä±klama",
           a.yaratan_kullanici_kodu GIRIS_KULLANICI,
           a.ONAYLAYAN_KULLANICI ONAY_KULLANICI,
           a.fis_muhasebelestigi_tarih MUHASEBELESME_TARIHI
      from v_muh_fis_satir a
     where a.fis_islem_kod = '1101'
       and a.fis_muhasebelestigi_tarih between
           pd_basTar and
           pd_bitTar
       and a.fis_tur = 'G'
       and a.amir_sube_kod = NVL(pc_subeKodu, a.amir_sube_kod)
     ORDER BY a.satir_yaratildigi_tarih,
              a.fis_islem_numara,
              a.fis_numara,
              a.satir_hesap_bolum_kodu,
              a.b_a desc,
              a.SATIR_NUMARA;



  return rc_serbest_ba;
end;

Function Gun_agirlik (pd_date in date) return number IS
begin
   return pkg_tarih.ileri_is_gunu(pd_date)-pd_date;
end Gun_agirlik;   

Function RC_QRY1116_ORTALAMA_MIZAN(pc_subeKodu varchar2,
                                   pn_ay   number,
                                   pnyil   number,
                                   pd_tar1 date ,
                                   pd_tar2 date ,
                                   ps_rp_tip  varchar2) Return RC_Accounting is
  rc_ortalama_mizan RC_Accounting;
  ln_bolen number; 
  ld_tar1  date ;
  ld_tar2  date ; 
  ls_krt varchar2(2000):= 'pc_subeKodu:'||pc_subeKodu||',pn_ay:'||pn_ay||',pnyil:'||pnyil||
      ',pd_tar1:'||pd_tar1||',pd_tar2:'||pd_tar2;
begin


  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1116_ORTALAMA_MIZAN'); 
  if ps_rp_tip = 'A' then 
  -- ln_bolen  := to_number(to_char(last_day(to_date('15'||lpad(pn_ay,2,'0')||pnyil,'ddmmyyyy')),'dd')) ; 
  ld_tar1   := to_date('01'||lpad(pn_ay,2,'0')||pnyil,'ddmmyyyy') ;
  ld_tar2   := last_day(to_date('15'||lpad(pn_ay,2,'0')||pnyil,'ddmmyyyy')) ;    
  
  else
  ld_tar1 := pd_tar1 ; 
  ld_tar2 := pd_tar2 ;
  end if;
  
 /* select max(count(*) ) into ln_bolen
  from bnspr.muh_rpt_mizan rp
  where tarih between ld_tar1 and ld_tar2
  group by rp.sube_kodu, rp.dk_numara, rp.doviz_kod, rp.tur ; MHA 09082016*/
  
  ln_bolen := ld_tar2-ld_tar1+1;
  
  
  Open rc_ortalama_mizan For
/*    select sa.yil,
           sa.ay ,
           sa.sube_kod,
           sa.hesap_no,
           ss.aciklama,
           sa.doviz_kod,
           round(sum(sa.bakiye) / ln_bolen, 2) bakiye,
           round(sum(sa.lc_bakiye) / ln_bolen, 2) TLbakiye
      from bnspr.muh_hp_gunluk_bakiye sa, bnspr.muh_hp_tanim ss
     where sa.hesap_no = ss.hesap_no
       and yil = pnyil
       and ay  = pn_ay 
       and sa.sube_kod = NVL(pc_subeKodu,sa.sube_kod)
     group by yil, ay, sa.sube_kod, sa.hesap_no, ss.aciklama, doviz_kod
     order by ay, sa.sube_kod, hesap_no, doviz_kod;*/
     select pnyil yil, 
            pn_ay ay ,
            sube_kodu sube_kod , 
            dk_numara hesap_no ,
            aciklama ,
            doviz_kod, 
      --round(sum(rp.borc_lc)/21,2) TLBORC , round(sum(rp.alacak_lc)/21,2) TLALAC , 
      --round(sum(rp.borc_fc)/21,2) YPBORC, round(sum(rp.alacak_fc)/21,2) YPALAC , 
      round(sum(rp.bakiye_lc*Gun_agirlik(rp.tarih))/ln_bolen,2) TLBAKIYE , 
      round(sum(rp.bakiye_fc*Gun_agirlik(rp.tarih))/ln_bolen,2) BAKIYE 
      from bnspr.muh_rpt_mizan rp 
      where tarih between ld_tar1 and ld_tar2 
      and tur='E' 
      and sube_kodu =   NVL(pc_subeKodu,sube_kodu)
      group by sube_kodu , dk_numara ,doviz_kod,aciklama 
      order by sube_kodu , dk_numara ,doviz_kod,aciklama ; 

  return rc_ortalama_mizan;
end;



function RC_QRY1117_GET_CBSDETAY(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting is

rc_dk_mizanhareket RC_Accounting;  
Lc_basDk   VARCHAR2(20);
Lc_bitDk   VARCHAR2(20);

  ls_krt varchar2(2000):= 'pc_subeKodu:'||pc_subeKodu||',pd_tarih:'||pd_tarih||',pc_tur:'||pc_tur||
      ',pc_basdk:'||pc_basdk||',pc_bitdk:'||pc_bitdk;

begin
  Lc_basDk :=  NVL(pc_basDk,'0') ;
  Lc_bitDk := NVL(pc_bitDk,'999999999');
  PKG_IZLEME_KRITER.KRITER_LOGLA(ls_krt,'RC_QRY1117_GET_CBSDETAY'); 
open  rc_dk_mizanhareket for

      Select decode(pc_subekodu,null,null,sube_kodu) sube_kodu,tarih,tur,DECODE(doviz_kod,'XXX',' ',doviz_kod) doviz_kod,SUBSTR(aciklama,1,50) aciklama, sum(borc_lc) as borc_lc,sum(alacak_lc) as alacak_lc,
      sum(DECODE(LENGTH(dk_numara),9,borc_fc,0)) borc_fc,sum(DECODE(LENGTH(dk_numara),9,alacak_fc,0)) alacak_fc,sum(bakiye_lc) as bakiye_lc,
      sum(DECODE(LENGTH(dk_numara),9,bakiye_fc,0)) bakiye_fc ,dk_numara
      from muh_RPT_MIZAN a
      where sube_kodu = nvl(pc_subekodu,sube_kodu)
      and a.dk_numara between Lc_basDk  and  Lc_bitDk
      and LENGTH(dk_numara) IN (1,3,5,6,7,8,9) 
      and tarih= pd_tarih
      and tur= pc_tur
      and ( borc_lc !=0  OR alacak_lc  !=0  OR borc_fc !=0  OR alacak_fc !=0  OR bakiye_lc !=0  OR bakiye_fc !=0)
      group by doviz_kod,aciklama,dk_numara,decode(pc_subekodu,null,null,sube_kodu),tarih,tur
      order by dk_numara;

return  rc_dk_mizanhareket;
end;

function RC_QRY1117_GET_CBSDETAY_TOPLAM(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting is

rc_dk_cbsdetaytoplami RC_Accounting;
Lc_basDk   VARCHAR2(20);
Lc_bitDk   VARCHAR2(20);

begin

  Lc_basDk :=  NVL(pc_basDk,'0') ;
  Lc_bitDk := NVL(pc_bitDk,'999999999');

open rc_dk_cbsdetaytoplami  for
      Select DECODE(pkg_hp.TL_HESAPMI(dk_numara), 'E', pkg_genel_pr.LC_al,doviz_kod) sum_doviz_kod,
      sum(borc_lc) sum_borc_lc ,
      sum(alacak_lc) sum_alacak_lc ,
      sum(borc_fc) sum_borc_fc ,
      sum(alacak_fc) sum_alacak_fc,
      sum(bakiye_lc) sum_bakiye_lc,
      sum(bakiye_fc) sum_bakiye_fc
      from MUH_RPT_MIZAN a
      where sube_kodu= NVL(pc_subekodu ,sube_kodu) 
      AND LENGTH(dk_numara)= 9 
      AND tarih =pd_tarih 
      AND tur= pc_tur
      and a.dk_numara between Lc_basDk  and  Lc_bitDk
      group by DECODE(pkg_hp.TL_HESAPMI(dk_numara), 'E', pkg_genel_pr.LC_al,doviz_kod)
      having (SUM(borc_lc) !=0 OR SUM(alacak_lc) != 0 OR SUM(borc_fc) !=0 OR
      sum(alacak_fc)!=0 OR sum(bakiye_lc)!=0 OR sum(bakiye_fc)!=0 );
return  rc_dk_cbsdetaytoplami;
end ;

function RC_QRY1117_GET_SUM_ALCAK_BORC(pc_subekodu varchar2,pd_tarih date,pc_tur varchar2,pc_basdk in varchar2, pc_bitdk in varchar2) Return RC_Accounting is

rc_dk_sumalacakborc RC_Accounting;
Lc_basDk   VARCHAR2(20);
Lc_bitDk   VARCHAR2(20);

begin

  Lc_basDk :=  NVL(pc_basDk,'0') ;
  Lc_bitDk := NVL(pc_bitDk,'999999999');
 
 open  rc_dk_sumalacakborc for
   select sum(borc_lc) sum_borc_lc_genel ,
   sum(alacak_lc) sum_alacak_lc_genel ,
   sum(borc_fc) sum_borc_fc_genel ,
   sum(alacak_fc) sum_alacak_fc_genel ,
   sum(bakiye_lc) sum_bakiye_lc_genel ,
   sum(bakiye_fc) sum_bakiye_fc_genel
   from MUH_RPT_MIZAN a
   where sube_kodu= NVL(pc_subekodu,sube_kodu) AND LENGTH(dk_numara)= 9 AND tarih = pd_tarih AND tur=pc_tur
   and a.dk_numara between Lc_basDk  and  Lc_bitDk
   having (SUM(borc_lc) !=0 OR SUM(alacak_lc) != 0 OR SUM(borc_fc) !=0
   OR sum(alacak_fc)!=0 OR sum(bakiye_lc)!=0 OR sum(bakiye_fc)!=0) ;

 return  rc_dk_sumalacakborc;
 end;

function RC_QRY1194_GET_LIMIT_RISK(pd_tarih date) Return RC_Accounting is
 
 rc_musteri_limit_risk RC_Accounting;

begin
 
 open  rc_musteri_limit_risk for
    select b.grup_kod ,d.aciklama ,a.musteri_no ,nvl(b.ticari_unvan , b.kisa_ad) unvan,
    a.limit ,a.doviz_kod ,a.risk ,a.nakdi_limit,a.nakdi_risk,a.gnakdi_limit,
    a.gnakdi_risk, a.lc_limit ,a.lc_risk, a.lc_nakdi_limit ,a.lc_nakdi_risk , a.lc_gnakdi_limit,
    a.lc_gnakdi_risk ,a.limit_revize_onay_tarihi
    from bnspr.kre_musteri_limit_log a , bnspr.gnl_musteri b , bnspr.gnl_grup_kodlari d
    where a.musteri_no=b.musteri_no
    and nvl(b.grup_kod,0) = d.kod (+)
    and a.tarih = pd_tarih
    order by b.grup_kod ,a.musteri_no; 
    
 return  rc_musteri_limit_risk;
end;
 
function RC_QRY1194_GET_GRUP_LIMITLERI(pd_tarih date) Return RC_Accounting is
 
rc_grup_limitleri RC_Accounting;

begin

 open  rc_grup_limitleri for
    select h.GRUP_KOD ,d.ACIKLAMA ,h.LIMIT ,h.DOVIZ_KOD ,h.RISK ,h.NAKDI_LIMIT ,h.GNAKDI_LIMIT ,h.NAKDI_RISK ,
    h.GNAKDI_RISK ,h.YENILEME_VADESI ,h.LC_RISK ,h.LC_NAKDI_LIMIT ,h.LC_GNAKDI_LIMIT ,h.LC_NAKDI_RISK ,h.LC_GNAKDI_RISK ,
    h.LC_LIMIT
    from bnspr.kre_mus_grup_limit h ,bnspr.gnl_grup_kodlari d
    where nvl(d.kod,0)= h.grup_kod (+)
    and trunc(h.rec_date) < pd_tarih
    order by 1; 

 return  rc_grup_limitleri;
 end;
 
function RC_QRY1194_GET_SOZLESMELER(pd_tarih date) Return RC_Accounting is
 
rc_sozlesmeler RC_Accounting;

begin
 
 open  rc_sozlesmeler for
    select c.musteri_no , nvl(b.kisa_ad ,b.ticari_unvan) unvan, c.sozlesme_tutari ,c.doviz_kodu ,--c.modul_tur_kod ,
    c.sozlesme_tur_kodu ,c.vergilimi ,c.rec_date
    from bnspr.kre_sozlesme c , bnspr.gnl_musteri b
    where c.musteri_no=b.musteri_no
    and c.sozlesme_tur_kodu='GNL KRE'
    and c.durum_kodu='ACIK'
    and trunc(c.rec_date) < pd_tarih
    order by c.musteri_no; 

 return  rc_sozlesmeler;
 end;
/******************************************************************************/
   Function RC_QRY1105_fis_saat (fis_numara in number) return varchar2 is
   cursor c_islonay is
    select to_char(f.yarat_tar,'HH24:MI:SS')
      from muh_fis f
     where f.numara = fis_numara;
   vs_islsaat varchar2(8);  
 Begin
   open c_islonay;
   Fetch c_islonay into vs_islsaat;
   close c_islonay;
   
   return vs_islsaat;
 End RC_QRY1105_fis_saat;
---------------------------------------------------
function RC_QRY1197_GET_GUNCEL_DURUM(pn_musteri_no number, pn_urun_grup_kodu number) Return RC_Accounting is
          rc_guncel_durum RC_Accounting;
 begin
 open  rc_guncel_durum for
      select kardami_zarardami,
             donem_ici_kar,
             donem_ici_zarar,
             donem_devreden_zarar,
             mahsup_sonrasi_kar,
             mahsup_sonrasi_zarar,
             mahsup_devreden_zarar,
             iadeye_konu_vergi,
             son_mahsuplasma_tx,
             donem_ici_alinan_vergi,
             donem_ici_odenmis_vergi,
             son_mahsuplasma_odenen,
             null donem_ici_odenmis_iade
        from bnspr.muh_vergi_iade_bilanco
        WHERE musteri_no = pn_musteri_no and urun_grubu = pn_urun_grup_kodu
      union all
      select kardami_zarardami,
             donem_ici_kar,
             donem_ici_zarar,
             donem_devreden_zarar,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             null,
             donem_ici_odenmis_iade 
        from bnspr.muh_vergi_iade_donemsel
        WHERE musteri_no = pn_musteri_no and urun_grubu = pn_urun_grup_kodu;
 return  rc_guncel_durum;
end;
---------------------------------------------------
function RC_QRY1197_GET_ISLEM_LISTESI(pn_musteri_no number, pn_urun_grup_kodu number, pd_bastarih date, pd_bittarih date) Return RC_Accounting is
          rc_islem_listesi RC_Accounting;
 begin
 open  rc_islem_listesi for
       select *
        from bnspr.muh_vergi_iade_kar_zarar
       where musteri_no = pn_musteri_no
         and islem_grubu = pn_urun_grup_kodu
         and tarih between pd_bastarih and pd_bittarih;
 return  rc_islem_listesi;
end;
--------------------------------------------------- 
function RC_QRY1197_GET_MAHSUP_GECMISI(pn_musteri_no number, pn_urun_grup_kodu number, pd_bastarih date, pd_bittarih date) Return RC_Accounting is
          rc_mahsup_gecmisi RC_Accounting;
 begin
 open  rc_mahsup_gecmisi for
       select tx_no, musteri_no, islem_grubu, tarih, iade_tutari, iade_hesap, iade_doviz, 
              case when durum = 'O' then 'ONAY'
                   when durum = 'I' then 'IPTAL'
                   when durum = 'H' then 'HATALI'
              end durum
        from bnspr.muh_vergi_iade_mahsuplasma_tx
       where durum in ('O','H')
         and musteri_no = pn_musteri_no
         and islem_grubu = pn_urun_grup_kodu
         and tarih between pd_bastarih and pd_bittarih;
 return  rc_mahsup_gecmisi;
end;
--------------------------------------------------- 
function RC_QRY1198_GET_DONEMSEL_DURUM(pn_musteri_no number, pn_urun_grup_kodu number, pn_donem_yili number, pn_donemkodu number) Return RC_Accounting is
          rc_donemsel_durum RC_Accounting;
 vn_current_year number;
 vn_current_quarter number;
 begin
 
 select extract(year from sysdate) into vn_current_year from dual;
 select 1 + trunc(extract(month from sysdate)/4) into vn_current_quarter from dual; 
 
 open  rc_donemsel_durum for
       select musteri_no,
              urun_grubu,
              null                   donem_yili,
              null                   donem_kodu,
              kardami_zarardami,
              donem_ici_kar,
              donem_ici_zarar,
              donem_devreden_zarar,
              donem_ici_odenmis_iade
          from bnspr.muh_vergi_iade_donemsel
          where nvl(pn_donem_yili, vn_current_year) = vn_current_year
               and nvl(pn_donemkodu, vn_current_quarter) = vn_current_quarter
               and (nvl(pn_musteri_no, 0) = 0 or musteri_no = pn_musteri_no)
               and (nvl(pn_urun_grup_kodu, 0) = 0 or urun_grubu = pn_urun_grup_kodu)
        union all
        select musteri_no,
               urun_grubu,
               donem_yili,
               donem_kodu,
               kardami_zarardami,
               donem_ici_kar,
               donem_ici_zarar,
               donem_devreden_zarar,
               donem_ici_odenmis_iade
          from bnspr.muh_vergi_iade_donemsel_hist
          where (nvl(pn_musteri_no, 0) = 0 or musteri_no = pn_musteri_no)
                and (nvl(pn_urun_grup_kodu, 0) = 0 or urun_grubu = pn_urun_grup_kodu)
                and donem_yili = pn_donem_yili
                and donem_kodu = pn_donemkodu;
         
 return  rc_donemsel_durum;
end;
--------------------------------------------------- 
 
end PKG_RC_ACCOUNTING;
/
