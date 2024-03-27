create or replace package PKG_FAST is

  -- @Author  : HAKAN.ATES
  -- @Created : 10/02/2021 12:19:31
  -- @Purpose : FAST mesajlarý için Genel Paket
  -- @Version : 1.0
  
 Function Alici_Maskele(pc_alici_adi in varchar2) return varchar2 ;  
 Function sonuc_durum_detay (pn_kod in number) return varchar2;  
 
 procedure FAST_Hareket_Log(pn_txNo number,pc_aciklama  varchar2 default null, pn_islemNo number default null, pc_islemKod varchar2 default null);

 Function FAST_banka_durum(pc_alan_banka in varchar2) return varchar2;

 procedure FAST_islem_sonuc(pc_oid in varchar2,pn_txno out number);
 
 Procedure FAST_Process_Batch(pn_grup_no     NUMBER,
                              pn_log_no      NUMBER,
                              ps_program_kod VARCHAR2);
 
 Procedure FAST_Gelen_Batch(pn_grup_no     NUMBER,
                              pn_log_no      NUMBER,
                              ps_program_kod VARCHAR2);                              
                              
  Procedure FAST_Giris_Initials(pn_musteri_no in number,pn_hesap_no in number,pn_tutar in number,pc_alici_iban in varchar2,
                                pn_tx_no out number,
                                ps_gon_banka out varchar2,
                                ps_alan_banka out varchar2,
                                pn_masraf out number,
                                ps_gon_tckno out varchar2);                        
                                
 procedure FAST_gelen_kontrol(pc_oid in varchar2,pn_teyit_durum out number,pn_teyit_kodu out number);  
  
 PROCEDURE FAST_Gelen_Teyitsiz (pc_oid in varchar2);
 
  Procedure FAST_Mutabakat_Kontrol(pn_grup_no     NUMBER,
                                  pn_log_no      NUMBER,
                                  ps_program_kod VARCHAR2);
end PKG_FAST;
/
create or replace package body PKG_FAST IS

 Function Alici_Maskele(pc_alici_adi in varchar2) return varchar2 IS
   vc_alici_adi varchar2(200);
   vc_alici_kaynak varchar2(200);   
   vc_gelen        varchar2(200);                
 Begin
       vc_alici_kaynak :=  trim(nls_upper(pc_alici_adi,'NLS_SORT = XTURKISH'));
    if instr(pc_alici_adi,' ') = 0 then
       vc_alici_adi := substr(vc_alici_kaynak,1,2)||'****';
    else
       vc_gelen := f_dizin_ayristir(vc_alici_kaynak,' ');
       if vc_alici_kaynak is not null then
          vc_alici_adi := substr(vc_gelen,1,2)||'**** '||alici_maskele(vc_alici_kaynak);  
       end if;
    end if;
    
    return vc_alici_adi;     
 End Alici_Maskele;    
/****************************************************************************************************************/
  Function sonuc_durum_detay (pn_kod in number) return varchar2 is
     cursor c_detay is
      select aciklama
        from fast_sonuc_durum_kodlari_pr
       where kod=pn_kod;
       
       vc_Acik varchar2(500);
  Begin
     open c_detay;
     fetch c_detay into vc_Acik;
     close c_detay;
     
     return vc_Acik;
  exception when others then
     return null;
  end sonuc_durum_detay;                
/****************************************************************************************************************/
 procedure FAST_Hareket_Log(pn_txNo number,pc_aciklama  varchar2 default null, pn_islemNo number default null, pc_islemKod varchar2 default null) is
 begin
       insert into fast_mesaj_hareket(id,fast_tx_no,gelen_giden,durum,aciklama,islem_no,islem_kodu)
              (select pkg_genel_pr.Genel_Sira_No_Al, t.tx_no,'GIDEN', t.durum, pc_aciklama, pn_islemNo, pc_islemKod
                 from fast_giden_tx t where t.tx_no = pn_txNo
                union
               select pkg_genel_pr.Genel_Sira_No_Al, t.tx_no,'GELEN', t.durum, pc_aciklama, pn_islemNo, pc_islemKod
                 from fast_gelen_tx t where t.tx_no = pn_txNo );
 end;
/****************************************************************************************************************/
 Function FAST_banka_durum(pc_alan_banka in varchar2) return varchar2 IS
   vc_durum char;
   vc_banka varchar2(4);
 Begin
     if length(pc_alan_banka)> 4 then
        if to_number(substr(pc_alan_banka,1,length(pc_alan_banka)-4)) = 0 then
           vc_banka := substr(pc_alan_banka,-4);
        else
            return 'P';
        end if;
     else
          vc_banka := pc_alan_banka;
     end if;          
     select p.katilimci_durumu
       into vc_durum
       from fast_katilimci_pr p
      where p.katilimci_kod = lpad(vc_banka,4,'0');
   
      return vc_durum;
 exception when no_data_found then 
     return 'P';   
 End FAST_banka_durum;    
/****************************************************************************************************************/
 procedure FAST_islem_sonuc(pc_oid in varchar2,pn_txno out number) IS
    /* Gelen T02 mesajına göre ilgili işlemin durumunu ilerletir MHA 04.03.2021 */
    cursor c_sonuc IS
      select *
        from FAST_islem_sonuc_log l
       where l.oid = pc_oid;
       
    r_sonuc c_sonuc%rowtype;   
    vn_islem_numara number;
    vc_sube varchar2(10);
    vn_musteri_no number;
    vn_hesap_no number;
    vc_donen varchar2(500);
    vc_otp_telefon varchar2(20);
    vc_kanal       varchar2(10);
    vc_sonuc_aciklama varchar2(200);
   -- f_yuk_testi varchar2(1):=pkg_parametre.Deger_Al_K('FAST_YUK_DURUM');
    f_sanal_iban char(1):='H';  
 Begin
    open c_sonuc;
    Fetch c_sonuc into r_sonuc;
    close c_sonuc;
    
    if r_sonuc.oid is null then
       pkg_hata.hata_yaz(1092,true,'FAST_ISLEM_SONUC_LOG',pc_oid);
    end if;   
    
    if r_sonuc.ilgili_gonderen_katilimci='0143' then
       /* giden mesajımıza sonuc gelmiş */
       for c1 in (select *
                    from fast_giden_tx g
                   where g.mesaj_tarih = r_sonuc.ilgili_islem_tarih
                     and g.sorgu_no = r_sonuc.ilgili_islem_sorgu_no)
       Loop
           if c1.durum = 'TAMAM' then
              Update fast_giden_tx g
                 set g.durum = decode(r_sonuc.sonuc_durum,'1','ACK','NACK'),
                     g.sonuc_kodu=r_sonuc.sonuc_durum_kodu
               where g.tx_no = c1.tx_no;
               
              Update FAST_islem_sonuc_log l
                 set l.ilgili_islem_tx_no = c1.tx_no,
                     l.sonuc_detay=NVL(l.sonuc_detay,sonuc_durum_detay(l.sonuc_durum_kodu))
               where l.oid = pc_oid;
               
               pkg_fast.FAST_Hareket_Log(c1.tx_no,sonuc_durum_detay(r_sonuc.sonuc_durum_kodu));   

           if c1.mesaj_kodu in ('A01','A09') then  
              vc_otp_telefon := pkg_musteri.otp_telefon(c1.musteri_no);
              vc_kanal := pkg_tx.islem_kanal_al(c1.tx_no);
              pn_txno := c1.tx_no;
                               
              if vc_otp_telefon is not null then
                 if r_sonuc.sonuc_durum = 1 then  
                    pkg_sms.SEND_SMS_nocommit(ps_ceptelno => vc_otp_telefon ,
                                              ps_mesaj =>  pkg_hata.kodsuzMesajOlustur(6247,Alici_Maskele(c1.alici_adi),c1.fast_tutar),
                                              pn_musteri => c1.musteri_no,
                                              pn_tx_no => c1.tx_no,
                                              pc_header => case when vc_kanal='83' then
                                                           '.NKOLAY'
                                                          else
                                                           'Aktif Bank' end ,
                                              pn_mesaj_turu => 2             
                                              );   
                 else
                     if r_sonuc.sonuc_durum_kodu between 10 and 21 then
                        vc_sonuc_aciklama := sonuc_durum_detay(r_sonuc.sonuc_durum_kodu);
                        pkg_sms.SEND_SMS_nocommit(ps_ceptelno => vc_otp_telefon ,
                                                  ps_mesaj =>  pkg_hata.kodsuzMesajOlustur(6248,Alici_Maskele(c1.alici_adi),c1.fast_tutar,vc_sonuc_aciklama),
                                                  pn_musteri => c1.musteri_no,
                                                  pn_tx_no => c1.tx_no,
                                                  pc_header => case when vc_kanal='83' then
                                                               '.NKOLAY'
                                                              else
                                                               'Aktif Bank' end ,
                                                  pn_mesaj_turu => 2             
                                                  );                         
                     else
                        pkg_sms.SEND_SMS_nocommit(ps_ceptelno => vc_otp_telefon ,
                                                  ps_mesaj => case when vc_kanal='83' then
                                                               pkg_hata.kodsuzMesajOlustur(6250,Alici_Maskele(c1.alici_adi),c1.fast_tutar)
                                                              else
                                                               pkg_hata.kodsuzMesajOlustur(6249,Alici_Maskele(c1.alici_adi),c1.fast_tutar) end  ,
                                                  pn_musteri => c1.musteri_no,
                                                  pn_tx_no => c1.tx_no,
                                                  pc_header => case when vc_kanal='83' then
                                                               '.NKOLAY'
                                                              else
                                                               'Aktif Bank' end ,
                                                  pn_mesaj_turu => 2             
                                                  );                        
                          
                     end if;  
                 end if;                               
              end if;
             end if;                                                         
              
           elsif c1.durum in ('ACK','NACK') then
              /* aynı T02 mesajı tekrar gelmiş ise dikkate almıyoruz */
              null;  
           end if;
       End Loop;    
    else
       /* gelen mesajımıza sonuç gelmiş */
       for c1 in (select *
                    from fast_gelen_mesaj_log g
                   where g.mesaj_tarih = r_sonuc.ilgili_islem_tarih
                     and g.gonderen_katilimci_kodu = r_sonuc.ilgili_gonderen_katilimci
                     and g.sorgu_numarasi = r_sonuc.ilgili_islem_sorgu_no)
       Loop
           if c1.durum ='TAMAM' /*and f_yuk_testi='H'*/ then
              Update fast_gelen_mesaj_log g
                 set g.durum = decode(r_sonuc.sonuc_durum,'1','ACK','NACK')
               where g.oid = c1.oid;
               
             if c1.islem_turu IN ('A01','A09') and r_sonuc.sonuc_durum='1' then
                 vn_islem_numara := pkg_tx.islem_no_al;
              
               if substr(c1.alici_hesap_no,11,5) = '84226' then
                    /* sanal IBAN 'a gelmiş */
                     select v.musteri_no,'998'
                       into vn_musteri_no,vc_sube
                       from GNL_MUSTERI_SANAL_IBAN v    
                      where v.iban = c1.alici_hesap_no;      
                      
                      f_sanal_iban := 'E';             
               else     
                   select h.sube_kodu,h.musteri_no,h.hesap_no
                     into vc_sube,vn_musteri_no,vn_hesap_no
                     from muh_hesap h
                    where h.iban = c1.alici_hesap_no;
               end if;     
                
                 insert into Fast_Gelen_Tx
                            (Tx_No,Mesaj_Kodu,Mesaj_Tarih,Gonderen_Banka_Kodu,Alan_Banka_Kodu,Sorgu_No,Fast_Tutar,
                             Odeme_Amaci,Odeme_Kaynak,Gonderen_Adi,Gonderen_Hesap_No,Gonderen_Kimlik_Numarasi,Gonderen_Adres,Gonderen_Pasaport_No,
                             Gonderen_Dogum_Yeri,Gonderen_Dogum_Tarihi,Gonderen_Musteri_Numarasi,Alici_Adi,Alici_Hesap_No,Alici_Kimlik_Numarasi,
                             Odeme_Sube,Odeme_Musteri_No,Odeme_Musteri_Hesap,Referans_Bilgisi,Aciklama,Kolas_Referansi,
                             Karekod_Akis_Turu,Karekod_Referansi,Durum,
                             Iade_Kodu,Ilgili_Islem_Tarih,Ilgili_Gonderen_Katilimci,Ilgili_Islem_Sorgu_No,Ilgili_Islem_Tx_No,
                             Amir_Adi,Amir_Hesap_Numarasi,Amir_Kimlik_Numarasi,Amir_Adresi,Amir_Ulke_Sehir,Amir_Dogum_Yeri,Amir_Dogum_Tarihi,Amir_Musteri_Numarasi,Yetkili_Odm_Kurulusu,
                             Fast_Referans_No)
                 values (vn_islem_numara,c1.islem_turu,c1.mesaj_tarih,c1.gonderen_katilimci_kodu,c1.alan_katilimci_kodu,c1.sorgu_numarasi,c1.tutar,
                         c1.odeme_amaci,c1.odeme_kaynak,c1.gonderen_adi,c1.gonderen_hesap_no,c1.gonderen_kimlik_numarasi,c1.gonderen_adres,
                         c1.gonderen_pasaport_no,c1.gonderen_dogum_yeri,c1.gonderen_dogum_tarihi,c1.gonderen_musteri_numarasi,c1.alici_adi,c1.alici_hesap_no,
                         c1.alici_kimlik_numarasi,vc_sube,vn_musteri_no,vn_hesap_no,c1.referans_bilgisi,c1.aciklama,c1.kolas_referansi,
                         c1.karekod_akis_turu,c1.karekod_referansi,'EKLENDI',c1.iade_kodu,c1.ilgili_islem_tarih,c1.ilgili_gonderen_katilimci,
                         c1.ilgili_islem_sorgu_no,c1.ilgili_islem_tx_no,
                         c1.Amir_Adi,c1.Amir_Hesap_Numarasi,c1.Amir_Kimlik_Numarasi,c1.Amir_Adresi,c1.Amir_Ulke_Sehir,c1.Amir_Dogum_Yeri,c1.Amir_Dogum_Tarihi,c1.Amir_Musteri_Numarasi,c1.Yetkili_Odm_Kurulusu,
                         to_char(c1.mesaj_tarih,'YYMMDD')||c1.gonderen_katilimci_kodu||lpad(c1.sorgu_numarasi,18,'0'));            
               
              if c1.islem_turu = 'A01' then
                  vc_donen := pkg_trn8317.Transaction_Start(vn_islem_numara);
              else
                  vc_donen := pkg_trn8312.Transaction_Start(vn_islem_numara);      
              end if;
               
                Update FAST_islem_sonuc_log l
                   set l.ilgili_islem_tx_no = vn_islem_numara
                 where l.oid = pc_oid;
                 
                 Update fast_gelen_tx s
                    set s.durum = decode(f_sanal_iban,'E','KART_ODNCK','ACK')
                  where s.tx_no = vn_islem_numara
                    and s.durum = 'TAMAM';  
                    
                 Update fast_gelen_mesaj_log g
                    set g.giris_islem_no = vn_islem_numara
                  where g.oid = c1.oid;  
                 
                 pkg_fast.FAST_Hareket_Log(vn_islem_numara,sonuc_durum_detay(r_sonuc.sonuc_durum_kodu));  
                 pn_txno := vn_islem_numara;
                
             end if;             
              
           elsif c1.durum in ('ACK','NACK') then
              /* aynı T02 mesajı tekrar gelmiş ise dikkate almıyoruz */
              null;  
           end if;
       End Loop;    
       
    end if;              
    
 End FAST_islem_sonuc;
/****************************************************************************************************************/
 Procedure FAST_Process_Batch(pn_grup_no     NUMBER,
                              pn_log_no      NUMBER,
                              ps_program_kod VARCHAR2) is
    /* ACK ,NACK almış FAST işlemlerinin muhasebelerini kesen batch */                              
    cursor c_x is
      select g.*
        from Fast_Giden_Tx g
       where g.durum in ('ACK','NACK');

    r_x       c_x%rowtype;

  begin
    Pkg_Batch.basla(pn_grup_no, pn_log_no, ps_program_kod);
    
    open c_x;
    Loop
       Fetch c_x into r_x;
       Exit when c_x%notfound;
       
       Begin
          if r_x.musteri_hesap_no is not null then
             pkg_global.SET_SUBEKOD(pkg_hesap.sube_kodu(r_x.musteri_hesap_no));  
          else
             pkg_global.SET_SUBEKOD('888');
          end if;      
          if r_x.mesaj_kodu='A01' then
             pkg_trn8315.Booking(pn_islem_no => r_x.tx_no);
          elsif r_x.mesaj_kodu='A09' then
             pkg_trn8311.Booking(pn_islem_no => r_x.tx_no);   
          elsif r_x.mesaj_kodu='K32' then
             pkg_trn8324.Booking(pn_islem_no => r_x.tx_no); 
          elsif r_x.mesaj_kodu='K38' then
             pkg_trn8326.Booking(pn_islem_no => r_x.tx_no);      
          end if;
          commit;
       exception when others then      
          rollback;
          pkg_batch.logla(pn_grup_no,pn_log_no,ps_program_kod,r_x.tx_no||' islemede hata:'||sqlerrm);
       End;
    End Loop;     
    
    pkg_batch.bitir(pn_grup_no, pn_log_no, ps_program_kod);

  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Pkg_Batch.hata_logla(pn_grup_no, pn_log_no, ps_program_kod, SQLERRM);
 End FAST_Process_Batch;   
/****************************************************************************************************************/
 Procedure FAST_Gelen_Batch(pn_grup_no     NUMBER,
                              pn_log_no      NUMBER,
                              ps_program_kod VARCHAR2) is
    /* ACK ,NACK almış FAST işlemlerinin muhasebelerini kesen batch */                              
    cursor c_x is
      select g.*
        from Fast_gelen_Tx g
       where g.durum in ('ACK','TAMAM','KART_OK','PP_OK','OPP_OK','PPP_OK')
         and mesaj_kodu in ('A01','A09','K32')
         and g.mesaj_tarih > trunc(sysdate-5);

    r_x       c_x%rowtype;
    ls_sube   varchar2(10);
    vc_dk_no  varchar2(30);
    vn_txno   number;
  begin
    Pkg_Batch.basla(pn_grup_no, pn_log_no, ps_program_kod);
    pkg_global.SET_USER_GLOBALS2('FAST');
    
    /* Once bize erken dusmus islem sonuclarini tekrar elden geçirelim */
    for c1 in (select * from bnspr.fast_islem_sonuc_log
                where rec_Date>trunc(sysdate-1) and ilgili_islem_tx_no is null)
    Loop
        FAST_islem_sonuc(pc_oid => c1.oid,pn_txno => vn_txno);
    End Loop;
    
    open c_x;
    Loop
       Fetch c_x into r_x;
       Exit when c_x%notfound;
       
       Begin
          if r_x.durum = 'TAMAM' and r_x.mesaj_kodu in ('A01','A09','K32') then
             /* A01 geldiğinde onaya düşmüş o yüzden zamanında TAMAM ve ardından ACK durmuna geçmemiş 
                Fiş kesebilmek için önce ACK durumuna almamız lazım */
             /* K32 ye giriş anında fiş kestirip lock riski yaşamamak için batch ile kendimiz ACK yapıp fiş keseceðiz */ 
                Update fast_gelen_tx s
                    set s.durum = 'ACK'
                  where s.tx_no = r_x.tx_no
                    and s.durum = 'TAMAM';  
                 
                 pkg_fast.FAST_Hareket_Log(r_x.tx_no);    
          end if;                      
          if r_x.odeme_musteri_hesap is not null then      
              pkg_global.SET_SUBEKOD(pkg_hesap.sube_kodu(r_x.odeme_musteri_hesap));  
          else
              pkg_global.set_subekod('888');
          end if; 
          if substr(r_x.durum,-3) = '_OK' then
             /* karta para geçmişiz */
              if r_x.durum = 'KART_OK' then
                 vc_dk_no := pkg_parametre.Deger_Al_K('KKART_ODEME_HAVUZ');
              elsif r_x.durum = 'PP_OK' then
                 vc_dk_no := pkg_parametre.Deger_Al_K('PREPAID_YUKLEME_HAVUZ');
              elsif r_x.durum = 'OPP_OK' then
                 vc_dk_no := pkg_parametre.Deger_Al_K('OCEAN_PREPAID_TOPUP_HAVUZ2');
              elsif r_x.durum = 'PPP_OK' then
                 vc_dk_no := pkg_parametre.Deger_Al_K('MCHIP_YUKLEME_HAVUZ');
              end if;  
              ls_sube := case when r_x.durum in ('KART_OK','OPP_OK','PPP_OK') then '998' else '997' end; 
              
              Update fast_gelen_tx g
                 set g.odeme_dk_hesap = vc_dk_no,
                     g.odeme_sube = ls_sube
               where g.tx_no = r_x.tx_no;
                      
                pkg_global.set_subekod(ls_sube);            
          end if;   
                 
          if r_x.mesaj_kodu='A01' then
             pkg_trn8317.Booking(pn_islem_no => r_x.tx_no);
          elsif r_x.mesaj_kodu='A09' then
             pkg_trn8312.Booking(pn_islem_no => r_x.tx_no);
          elsif r_x.mesaj_kodu='K32' then
             pkg_trn8325.Booking(pn_islem_no => r_x.tx_no);   
          end if;
          commit;
       exception when others then      
          rollback;
          pkg_batch.logla(pn_grup_no,pn_log_no,ps_program_kod,r_x.tx_no||' islemede hata:'||sqlerrm);
       End;
    End Loop;     
    
    pkg_batch.bitir(pn_grup_no, pn_log_no, ps_program_kod);

  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Pkg_Batch.hata_logla(pn_grup_no, pn_log_no, ps_program_kod, SQLERRM);
 End FAST_GELEN_Batch;  
/************************************************************************************ */                                      
  Procedure FAST_Giris_Initials(pn_musteri_no in number,pn_hesap_no in number,pn_tutar in number,pc_alici_iban in varchar2,
                                pn_tx_no out number,
                                ps_gon_banka out varchar2,
                                ps_alan_banka out varchar2,
                                pn_masraf out number,
                                ps_gon_tckno out varchar2) IS
  Begin
      pn_tx_no := pkg_tx.islem_no_al;
      ps_gon_banka := lpad(pkg_genel_pr.bankamiz_kodu,4,'0');
      ps_gon_tckno := NVL(pkg_musteri.tc_kimlik_no(pn_musteri_no),pkg_musteri.vergi_no(pn_musteri_no));
      ps_alan_banka :=  pkg_iban.IBAN_Banka_Kodu_Al(pc_alici_iban);
      ps_alan_banka := lpad(ps_alan_banka,4,'0');
      
      if FAST_banka_durum(ps_alan_banka) = 'P' then
         pkg_hata.hata_yaz(6181,true,ps_alan_banka||'-'||pkg_genel_pr.banka_adi_al_eft_hatasiz(ps_alan_banka));
      end if;  
      
      Pkg_Masraf_Yeni.masraf_yarat(pn_islem_no => pn_tx_no,
                                   pn_islem_kod => 8315,
                                   pn_tutar =>  pn_tutar,
                                   pc_doviz_kod => pkg_genel_pr.lc_al,
                                   pn_musteri_numara => pn_musteri_no,
                                   pc_hesap_numara => pn_hesap_no);
       
           select sum(alinan + bsmv)
             into pn_masraf
             from GNL_MASRAF
            where Tx_no = pn_tx_no;
                                                                        
  End FAST_Giris_Initials;     
/************************************************************************************ */         
  procedure FAST_gelen_kontrol(pc_oid in varchar2,pn_teyit_durum out number,pn_teyit_kodu out number) IS
   /* Gelen FAST mesajlarına uygunluk veren procedure MHA 30.03.2021 */
    cursor c_gelen IS
      select *
        from Fast_gelen_mesaj_log l
       where l.oid = pc_oid;
       
    r_gelen c_gelen%rowtype;   
    
    cursor c_hesap(f_iade in char) is
     select p.hesap_no,p.durum_kodu,p.kisa_isim,p.urun_tur_kod,p.urun_sinif_kod,p.doviz_kodu,p.hesap_hareket_kodu,p.musteri_no
       from muh_hesap p
      where p.iban = r_gelen.alici_hesap_no
        and exists (select 1 from gnl_param_text t where kod=decode(f_iade,'H','EFT_ODEME_HESAP_TUR','EFT_GIDEN_HESAP_TUR') and t.key1=p.urun_tur_kod) ;
    
    r_hesap c_hesap%rowtype;   
    
    cursor c_sanal_iban is
     select v.musteri_no
       from GNL_MUSTERI_SANAL_IBAN v    
      where v.iban = r_gelen.alici_hesap_no;
    vn_sanal_musteri number;       
    vn_ilgili_txno number;
 Begin
    open c_gelen;
    Fetch c_gelen into r_gelen;
    close c_gelen;
    
    if r_gelen.oid is null then
       pkg_hata.hata_yaz(1092,true,'FAST_GELEN_MESAJ_LOG',pc_oid);
    end if;   
    
     if r_gelen.islem_turu='A01' then
       /* Anlık ödeme gelmiş kontrollerimizi yapalım */

       if substr(r_gelen.alici_hesap_no,11,5) = '84226' then
          /* Sanal IBAN a gelmiş */
          open c_sanal_iban;
          Fetch c_sanal_iban into vn_sanal_musteri;
          close c_sanal_iban;
          
          if vn_sanal_musteri is null then
              pn_teyit_kodu := 10;
          elsif pkg_eft_mesaj.alici_musteri_uyumlumu(r_gelen.alici_adi,vn_sanal_musteri,null) = 'H' then
              pn_teyit_kodu := 11; 
          else
             /* Alıcı ADI tuttu sanal IBANa gelmiş izin verelim */
              pn_teyit_kodu := 1;              
          end if;                   
       else 
           open c_hesap('H');
           Fetch c_hesap into r_hesap;
           close c_hesap;
           
           if r_gelen.karekod_referansi is not null and r_gelen.karekod_gecerlimi = 'H' then
              /* ilk karekod kontrolü yapılacakmış TCMB öyle istiyor MHA 28012022 */
              pn_teyit_kodu := 21; -- Ret/Karekod doğrulanamadı  
           elsif r_hesap.hesap_no is null then
              pn_teyit_kodu := 10;
           elsif r_hesap.doviz_kodu!='TRY' then
              pn_teyit_kodu := 16;
           elsif r_hesap.hesap_hareket_kodu in (3,4) then
              pn_teyit_kodu := 14;
           elsif r_hesap.urun_sinif_kod = 'KKART FON' then
              pn_teyit_kodu := 14;   
           elsif r_hesap.durum_kodu='K' then
              pn_teyit_kodu := 13;
           elsif pkg_eft_mesaj.alici_musteri_uyumlumu(r_gelen.alici_adi,r_hesap.musteri_no,r_hesap.hesap_no) = 'H' then
              pn_teyit_kodu := 11;
           elsif r_gelen.gonderen_kimlik_numarasi is null and r_gelen.gonderen_adres is null and r_gelen.gonderen_musteri_numarasi is null and
                 r_gelen.gonderen_dogum_yeri is null and r_gelen.gonderen_dogum_tarihi is null and r_gelen.gonderen_pasaport_no is null then
              pn_teyit_kodu := 17; 
           elsif (pkg_musteri_ek.Kazanim_Urunu(r_hesap.musteri_no) = 'NKOLAYBONO' 
                  OR pkg_dob.Dob_Akis_Eft_Bekliyor(r_hesap.musteri_no, r_hesap.hesap_no) = 'E') 
                 and pkg_musteri_ek.Musteri_BHS_varmi(r_hesap.musteri_no)='H' then
               if r_gelen.gonderen_kimlik_numarasi = NVL(pkg_musteri.tc_kimlik_no(r_hesap.musteri_no),pkg_musteri.vergi_no(r_hesap.musteri_no)) then
                  /* gonderen alan aynı kişi */
                  pn_teyit_kodu := 1;
               elsif r_gelen.gonderen_kimlik_numarasi is null and 
                     pkg_eft_mesaj.alici_musteri_uyumlumu(r_gelen.gonderen_adi,r_hesap.musteri_no,r_hesap.hesap_no) = 'E' then
                   /* gonderen ADI tuttu izin verelim */
                  pn_teyit_kodu := 1; 
               else
                  /* BHS imzalamamış NKOLAYBONO müşterisine başka bir kişi para gönderemez */ 
                  pn_teyit_kodu := 17;
               end if;  
           elsif pkg_kopru_iban.KOPRU_IBAN_HESAP_MI(r_hesap.hesap_no)='E' and pkg_kopru_iban.SOZLESME_VARMI(r_hesap.hesap_no)='H' then
               if pkg_kopru_iban.Kopru_IBAN_kisaisim_uyum(r_gelen.gonderen_adi,r_hesap.kisa_isim)  = 'H' then
                    pn_teyit_kodu := 17;
               else
                   /* gonderen ADI tuttu izin verelim */
                    pn_teyit_kodu := 1;     
               end if;               
           else
              /* sorun yok kabul edelim */
              pn_teyit_kodu := 1;
           end if;      
       end if;
       if pn_teyit_kodu = 1 then
          pn_teyit_durum := 1;
       else
          pn_teyit_durum := 0;
       end if;      
       
       Update Fast_gelen_mesaj_log lg
          set lg.teyit_durum = pn_teyit_durum,
              lg.teyit_durum_kodu = pn_teyit_kodu,
              lg.durum = decode(pn_teyit_durum,1,'TAMAM','RET')
        where lg.oid = pc_oid;      
       
    elsif r_gelen.islem_turu = 'A09' then
       /* Iade gelmiş kontrollerimizi yapalım */
      begin
          select tx_no
            into vn_ilgili_txno
            from fast_giden_tx f
           where f.mesaj_tarih = r_gelen.ilgili_islem_tarih
             and f.sorgu_no = r_gelen.ilgili_islem_sorgu_no;
           
       /* ıade gelmiş hesaba ait kontrollerimizi yapalım */
       open c_hesap('E');
       Fetch c_hesap into r_hesap;
       close c_hesap;
       
       if r_hesap.hesap_no is null then
          pn_teyit_kodu := 10;
       elsif r_hesap.doviz_kodu!='TRY' then
          pn_teyit_kodu := 16;
       elsif r_hesap.hesap_hareket_kodu in (3,4) then
          pn_teyit_kodu := 14;
       elsif r_hesap.durum_kodu='K' then
          pn_teyit_kodu := 13;
       elsif r_gelen.gonderen_kimlik_numarasi is null and r_gelen.gonderen_adres is null and r_gelen.gonderen_musteri_numarasi is null and
             r_gelen.gonderen_dogum_yeri is null and r_gelen.gonderen_dogum_tarihi is null and r_gelen.gonderen_pasaport_no is null then
          pn_teyit_kodu := 17;
       else
          /* sorun yok kabul edelim */
          pn_teyit_kodu := 1;
       end if;      
      exception when no_data_found then
         /* böyle bir işlem yok */
          pn_teyit_durum := 0;
          pn_teyit_kodu := 20;
      end;       

       if pn_teyit_kodu = 1 then
          pn_teyit_durum := 1;
       else
          pn_teyit_durum := 0;
       end if; 
       
       Update Fast_gelen_mesaj_log lg
          set lg.teyit_durum = pn_teyit_durum,
              lg.teyit_durum_kodu = pn_teyit_kodu,
              lg.durum = decode(pn_teyit_durum,1,'TAMAM','RET'),
              lg.ilgili_islem_tx_no = vn_ilgili_txno
        where lg.oid = pc_oid;      

    end if;              
    
 End FAST_gelen_kontrol;
 /******************************************************************************************/
 PROCEDURE FAST_Gelen_Teyitsiz (pc_oid in varchar2) IS
    cursor c_gelen IS
      select *
        from Fast_gelen_mesaj_log l
       where l.oid = pc_oid;
       
    r_gelen c_gelen%rowtype;  
    vn_islem_numara number;
    vn_ilgili_txno number;
    vc_donen       varchar2(500);
 BEGIN
   /* gelen mesaj bizde işlem yaratıyorsa create edelim */
    open c_gelen;
    Fetch c_gelen into r_gelen;
    close c_gelen;
    
    if r_gelen.oid is null then
       pkg_hata.hata_yaz(1092,true,'FAST_GELEN_MESAJ_LOG',pc_oid);
    end if;   
    
    if r_gelen.islem_turu='H31' then
       /* Iade talebi gelmiş */  
       begin
          select tx_no
            into vn_ilgili_txno
            from fast_gelen_tx f
           where f.mesaj_tarih = r_gelen.ilgili_islem_tarih
             and f.gonderen_banka_kodu = r_gelen.ilgili_gonderen_katilimci
             and f.sorgu_no = r_gelen.ilgili_islem_sorgu_no;
             
         vn_islem_numara := pkg_tx.islem_no_al;       
         insert into Fast_Gelen_Tx
                    (Tx_No,Mesaj_Kodu,Mesaj_Tarih,Gonderen_Banka_Kodu,Alan_Banka_Kodu,Sorgu_No,Iade_Talebi_Sebebi,Aciklama,durum,
                     Ilgili_Islem_Tarih,Ilgili_Gonderen_Katilimci,Ilgili_Islem_Sorgu_No,Ilgili_Islem_Tx_No)
         values (vn_islem_numara,r_gelen.islem_turu,r_gelen.mesaj_tarih,r_gelen.gonderen_katilimci_kodu,r_gelen.alan_katilimci_kodu,r_gelen.sorgu_numarasi,
                 r_gelen.iade_talebi_sebebi,r_gelen.aciklama,'EKLENDI',r_gelen.ilgili_islem_tarih,r_gelen.ilgili_gonderen_katilimci,
                 r_gelen.ilgili_islem_sorgu_no,vn_ilgili_txno);      

         Update Fast_gelen_mesaj_log lg
            set lg.durum = 'TAMAM',
                lg.ilgili_islem_tx_no = vn_ilgili_txno,
                lg.giris_islem_no = vn_islem_numara
          where lg.oid = pc_oid;           
        
          vc_donen := pkg_trn8320.Transaction_Start(vn_islem_numara);                  
                   
       exception when no_data_found then
           pkg_hata.hata_yaz(6206,true,to_char(r_gelen.ilgili_islem_tarih,'dd/mm/yyyy')||'-'||r_gelen.ilgili_gonderen_katilimci||'-'||r_gelen.ilgili_islem_sorgu_no);
       when others then
           pkg_hata.hata_yaz(660,true,sqlerrm);
       end;                       
    elsif r_gelen.islem_turu in ('K32','K33') then
       if r_gelen.eft_mesaj_tarih is not null then 
           begin
              select tx_no
                into vn_ilgili_txno
                from Eft_Eft_Tx f
               where f.eft_tarih = r_gelen.eft_mesaj_tarih
                 and f.sorgu_no = r_gelen.eft_sorgu_numarasi
                 and lpad(f.gonderen_banka,4,'0') = r_gelen.eft_gonderen_katilimci;
           exception when no_data_found then 
              null;
           end;         
       end if;    
         vn_islem_numara := pkg_tx.islem_no_al;       
         insert into Fast_Gelen_Tx
                    (Tx_No,Mesaj_Kodu,Mesaj_Tarih,Fast_tutar,Gonderen_Banka_Kodu,Alan_Banka_Kodu,Sorgu_No,Odeme_Amaci,Bilgi,Alici_Hesap_No,durum,
                     Ilgili_Islem_Tarih,Ilgili_Gonderen_Katilimci,Ilgili_Islem_Sorgu_No,Ilgili_Islem_Tx_No,
                     Eft_Mesaj_Tarih,Eft_Gonderen_Katilimci,Eft_Sorgu_Numarasi)
         values (vn_islem_numara,r_gelen.islem_turu,r_gelen.mesaj_tarih,r_gelen.tutar,r_gelen.gonderen_katilimci_kodu,r_gelen.alan_katilimci_kodu,r_gelen.sorgu_numarasi,
                 r_gelen.odeme_amaci,r_gelen.bilgi,r_gelen.alici_hesap_no,'EKLENDI',r_gelen.ilgili_islem_tarih,r_gelen.ilgili_gonderen_katilimci,
                 r_gelen.ilgili_islem_sorgu_no,vn_ilgili_txno,r_gelen.eft_mesaj_tarih,r_gelen.eft_gonderen_katilimci,r_gelen.eft_sorgu_numarasi);      

         Update Fast_gelen_mesaj_log lg
            set lg.durum = 'TAMAM',
                lg.ilgili_islem_tx_no = vn_ilgili_txno,
                lg.giris_islem_no = vn_islem_numara
          where lg.oid = pc_oid;           
        
          vc_donen := pkg_trn8325.Transaction_Start(vn_islem_numara);                  
    elsif r_gelen.islem_turu in ('H32','H36','B31','B32') then 
         vn_islem_numara := pkg_tx.islem_no_al;       
         insert into Fast_Gelen_Tx
                    (Tx_No,Mesaj_Kodu,Mesaj_Tarih,Gonderen_Banka_Kodu,Alan_Banka_Kodu,Sorgu_No,
                     Bilgi,durum,Fast_Tutar,borclu_hesap_no,Mesaj_Grubu,
                     Eft_Acilis_Zamani,Eft_Kapanis_Zamani,Gundonumu_Zamani,Katilimci_Durumu,Katilimci_Kodu,Katilimci_Adi,Hizmet_Durumu,
                     Baslangic_Zamani,Baslangic_Bakiyesi,Baslangic_Bloke_Tutari,Borc_Mesaj_Adet,Borc_Tutar,Bloke_Mesaj_Adet,Bloke_Tutar,
                     Alac_Mesaj_Adet,Alac_Tutar,Gundonumu_Bakiyesi,Sistem_Durumu)
         values (vn_islem_numara,r_gelen.islem_turu,r_gelen.mesaj_tarih,r_gelen.gonderen_katilimci_kodu,r_gelen.alan_katilimci_kodu,r_gelen.sorgu_numarasi,
                 r_gelen.bilgi,'EKLENDI',r_gelen.tutar,r_gelen.borclu_hesap_no,r_gelen.mesaj_grubu,
                 r_gelen.eft_acilis_zamani,r_gelen.eft_kapanis_zamani,r_gelen.gundonumu_zamani,r_Gelen.Katilimci_Durumu,r_gelen.katilimci_kodu,
                 r_gelen.katilimci_adi,r_gelen.hizmet_durumu,r_gelen.baslangic_zamani,r_gelen.baslangic_bakiyesi,r_gelen.baslangic_bloke_tutari,
                 r_gelen.borc_mesaj_adet,r_gelen.borc_tutar,r_gelen.bloke_mesaj_adet,r_gelen.bloke_tutar,r_gelen.alac_mesaj_adet,r_gelen.alac_tutar,
                 r_gelen.gundonumu_bakiyesi,r_gelen.sistem_durumu);      

         Update Fast_gelen_mesaj_log lg
            set lg.durum = 'TAMAM',
                lg.giris_islem_no = vn_islem_numara
          where lg.oid = pc_oid;           
        
        if r_gelen.islem_turu = 'H32' then
           vc_donen := pkg_trn8322.Transaction_Start(vn_islem_numara); 
        elsif r_gelen.islem_turu = 'H36' then                 
           vc_donen := pkg_trn8333.Transaction_Start(vn_islem_numara); 
        elsif r_gelen.islem_turu = 'B31' then
           vc_donen := pkg_trn8308.Transaction_Start(vn_islem_numara);    
        elsif r_gelen.islem_turu = 'B32' then
           vc_donen := pkg_trn8384.Transaction_Start(vn_islem_numara);    
        end if;   
    end if;    
   
 END FAST_Gelen_Teyitsiz;  
/****************************************************************************************************************/
 Procedure FAST_Mutabakat_Kontrol(pn_grup_no     NUMBER,
                                  pn_log_no      NUMBER,
                                  ps_program_kod VARCHAR2) is
    /* TAMAM durumunda kalmış T02 si bize ulaşmamış FAST işlemi varsa mail atar MHA 03.09.2021 */ 
       vn_adet number;
       vc_subject varchar2(100);   
       vc_body    varchar2(4000); 
  begin
    Pkg_Batch.basla(pn_grup_no, pn_log_no, ps_program_kod);
    
    Select count(*) 
      into vn_adet
      from fast_giden_tx g
     where g.mesaj_kodu in ('A01','A09')
       and durum='TAMAM'
       and rec_date < sysdate-1/24;
       
    if vn_adet>0 then
       /* TAMAM da kalmış giden FAST var mail atalım */
        
        vc_subject := 'FAST MUTABAKAT PROBLEMI - '||pkg_tablo.sistem_bilgi('CLK').sistem_adi;
        vc_body := pkg_hata.kodsuzMesajOlustur(6316,vn_adet)||chr(10)||chr(13);
        
         for c1 in (Select g.tx_no
                      from fast_giden_tx g
                     where g.mesaj_kodu in ('A01','A09')
                       and durum='TAMAM'
                       and rec_date < sysdate-1/24)
         Loop
             vc_body := vc_body||' İşlem No:'||to_char(c1.tx_no)||chr(10)||chr(13);
         End Loop;   
         
    end if;
    
    /* bizden giden ama bizim tablolarda olmayıp karşı bankaya giden FAST mesajları */
    select count(*)
      into vn_adet 
      from gbkasbox.kbfastlog ww where ww.trh2>trunc(sysdate-1) and isl_tur='A01' and giden='O' and ww.trh2<sysdate-5/1440
       and not exists (select 1 from bnspr.fast_giden_tx x where x.sorgu_no=ww.sn and x.mesaj_tarih>=trunc(sysdate-1)); 
       
    if vn_adet > 0 then
        vc_subject := 'FAST MUTABAKAT PROBLEMI - '||pkg_tablo.sistem_bilgi('CLK').sistem_adi;
        vc_body := pkg_hata.kodsuzMesajOlustur(6508,vn_adet)||chr(10)||chr(13);        
        
        for c2 in (select ww.id, ww.sn from gbkasbox.kbfastlog ww where ww.trh2>trunc(sysdate-1) and isl_tur='A01' and giden='O' and ww.trh2<sysdate-5/1440
                      and not exists (select 1 from bnspr.fast_giden_tx x where x.sorgu_no=ww.sn 
                                         and x.mesaj_tarih>=trunc(sysdate-1)))
        Loop
            vc_body := vc_body||' ID No:'||to_char(c2.id)||' Sorgu No:'||to_char(c2.sn)||chr(10)||chr(13);  
        End Loop; 
    end if;                                                   

     if vc_subject is not null then
         pkg_mail.send_mail(ps_mail_from => 'Aktifbank@aktifbank.com.tr',
                            ps_mail_to => 'TemelBankacilikUygulamaGelistirmeBirimi@aktifbank.com.tr',
                            ps_mail_cc => null,
                            ps_mail_bcc => null,
                            ps_mail_subject => vc_subject,
                            ps_mail_body => vc_body);       
       commit;
     end if;
    pkg_batch.bitir(pn_grup_no, pn_log_no, ps_program_kod);

  EXCEPTION
    WHEN OTHERS THEN
      rollback;
      Pkg_Batch.hata_logla(pn_grup_no, pn_log_no, ps_program_kod, SQLERRM);    
  end FAST_Mutabakat_Kontrol;    
end PKG_FAST;
/
