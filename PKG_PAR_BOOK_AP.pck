CREATE OR REPLACE PACKAGE PKG_PAR_BOOK_AP IS

  TYPE parlist IS TABLE OF clk_paa_parlist%ROWTYPE;
  current_parlist       parlist;
  IptalBayrak           boolean;
  d_test                varchar2(1) := 'H';
-- Yard?mc? Fonksiyonlar
  function  dinamiksql(p_dinamik in varchar2,  p_islem in varchar2) return varchar2;
  function  f_curr_par              return parlist;
  procedure setIptalBayrak(p_bayrak in boolean);
  function  getIptalBayrak          return boolean;
  function  pm_fis_goster           return boolean;
  function  getfromlist (p_par_name in varchar2) return varchar2;
-- Ana Fonksiyonlar
  Function  FIS_YARAT (p_ekran                in varchar2,     -- Hangi Ekrandan
                       p_TXISLEM_NO           in NUMBER,       -- ekran islem no,Tablonun Key'i Trand_id
                       P_ISLEM_SUBE_KOD       in VARCHAR2,     -- ??lemi yapan ?ube
                       p_YARATAN_KULL         in VARCHAR2,     -- Fi?i Yaratan Kullan?c? kodu
                       p_GECERLI_OLDUGU_TARIH in DATE          -- Fisin Gecerlilik tarihi ..
                       ) RETURN NUMBER ;

-- Fisin sonuna standart ek muhasebe bacaklar? eklemek i?in ( Masraf gibi )
FUNCTION  EK_FIS_YARAT (p_ekran                in varchar2,     
                        p_TXISLEM_NO           in Number,      
                        p_Fisno                in Number
                       )  RETURN NUMBER;


END;
/
CREATE OR REPLACE PACKAGE BODY PKG_PAR_BOOK_AP Is

  d_bacak_grup clk_paa_screen_group.row_group%TYPE;
  d_kayit_no   number(4);
  d_hes_source VARCHAR2(2000);
  d_sira_no    NUMBER;
  Negatif_Bakiye_olamaz    exception;
------------------------------------------------------------
  FUNCTION f_curr_par RETURN parlist Is
  BEGIN
    RETURN current_parlist;
  END;
------------------------------------------------------------
  PROCEDURE setIptalBayrak(p_bayrak In BOOLEAN) Is
  BEGIN
    IptalBayrak := p_bayrak;
  END;
------------------------------------------------------------
  FUNCTION getIptalBayrak RETURN BOOLEAN Is
  BEGIN
    RETURN IptalBayrak;
  END;
------------------------------------------------------------
  FUNCTION getKanalAciklama RETURN Varchar2 IS
    -- Sube kanalı dısından yapılan islemlere kanal Adi ekleme talebi icin yazildi MHA 070409
  Begin
     IF pkg_global.Get_KanalKod not in ( 1,21) then
        Return pkg_genel_pr.kanal_adi( pkg_global.Get_KanalKod );
     ELSE
        Return null;
     END IF;
  End getKanalAciklama;
------------------------------------------------------------
  FUNCTION pm_fis_goster RETURN BOOLEAN Is
    d_goster varchar2(1);
  BEGIN
   -- Select NVL(a.pm_fis_goster,'H')
   --   Into d_goster
   --   From m_ban_bil_pr a;
       d_goster := 'E';
    IF d_goster = 'E' Then
      RETURN TRUE;
    Else
      RETURN FALSE;
    END IF;
  END;
------------------------------------------------------------
--  Hata mesajlar?n? gerektiginde loglamak i?in
  PROCEDURE hata_yaz(p_HATA_NO In NUMBER,
                     p_HATA In VARCHAR2,
                     p_IFADE In VARCHAR2,
                     p_EKRAN In VARCHAR2 Default Null,
                     p_GRUP In VARCHAR2 Default Null,
                     p_GRUP_KOSUL_ID In VARCHAR2 Default Null,
                     p_MUH_ID In VARCHAR2 Default Null,
                     p_MUH_KOSUL_ID In VARCHAR2 Default Null) Is
    d_hata VARCHAR2(2000);
    v_mesno NUMBER;
    v_mesaj VARCHAR2(200);
    v_par1   VARCHAR2(200);
    v_par2   VARCHAR2(200);
    v_par3   VARCHAR2(200);
  BEGIN
    if d_test='H' then
       PKG_HATA.hata_yaz(240,TRUE, SUBSTR(   p_EKRAN||'-'||
                                             p_GRUP||'-'||
                                             p_GRUP_KOSUL_ID||'-'||
                                             p_MUH_ID||'-'||
                                             p_MUH_KOSUL_ID||'  ***  '||
                                             p_HATA||'  ***  '||
                                             p_IFADE,1,900));
    else
      d_sira_no := NVL(d_sira_no,0)+1;
      IF INSTR(p_HATA,'20001')>0 Then
        v_mesno := TO_NUMBER(SUBSTR(v_mesaj,1,INSTR(v_mesaj,'^^')-1));
        v_mesaj := SUBSTR(v_mesaj,INSTR(v_mesaj,'^^')+2);
        v_par1  := SUBSTR(v_mesaj,1,INSTR(v_mesaj,'^^')-1);
        v_mesaj := SUBSTR(v_mesaj,INSTR(v_mesaj,'^^')+2);
        v_par2  := SUBSTR(v_mesaj,1,INSTR(v_mesaj,'^^')-1);
        v_mesaj := SUBSTR(v_mesaj,INSTR(v_mesaj,'^^')+2);
        v_par3  := SUBSTR(v_mesaj,1,INSTR(v_mesaj,'^^')-1);

        v_mesaj := Replace(v_mesaj,'#1',v_par1);
        v_mesaj := Replace(v_mesaj,'#2',v_par2);
        v_mesaj := Replace(v_mesaj,'#3',v_par3);
        d_hata  := 'MAR-'||LPAD(v_mesno,5,'0')||':'||v_mesaj;
      Else
        d_hata := p_hata;
      END IF;
      Insert Into clk_paa_process
        (SCREEN,  GROUP_,            GROUP_ID,
         BOOK_ID, BOOK_COND_ID,      ERROR,
         STATEMENT_, ERROR_NO,       ORDER_NO   )
        Values
        (p_EKRAN, p_GRUP, p_GRUP_KOSUL_ID,
         p_MUH_ID, p_MUH_KOSUL_ID,
         substr(d_HATA,1,300),p_IFADE,p_HATA_NO,d_sira_no);
    end if;
  END;
-------------------------------------------------------
  FUNCTION dinamiksql(p_dinamik In VARCHAR2,
                      p_islem In VARCHAR2) RETURN VARCHAR2 Is
    Result VARCHAR2(2000);
  BEGIN
    IF p_islem ='KOSUL' Then
       EXECUTE Immediate 'begin :1:=case when '||p_dinamik||' then 1 else 0 end;end;' USING OUT Result;
    ELSIF p_islem ='DEGER' Then
       EXECUTE Immediate 'begin :1:='||p_dinamik||';end;' USING OUT Result;
    END IF;
    RETURN(Result);
  END;
--------------------------------------------------------
  FUNCTION Formatla(p_tip In VARCHAR2,
                    p_deger In VARCHAR2
                    ) RETURN VARCHAR2 Is
    d_value  VARCHAR2(2000);
  BEGIN
    IF UPPER(p_tip)='NUMBER' Then
      d_value := TRANSLATE(NVL(p_deger,'null'),',.','..');
    ELSIF UPPER(p_tip)='VARCHAR2' Then
      d_value := ''''||Replace(p_deger,'''','''''')||'''';
    ELSIF UPPER(p_tip)='DATE' Then
      IF p_deger Is Null Then d_value := 'null';
      Else
        d_value := 'to_date('||''''||TO_CHAR(TO_DATE(p_deger,'DD/MM/YYYY'),'DD/MM/YYYY')||''''||',''DD/MM/YYYY'')';
      END IF;
    END IF;
    RETURN d_value;
  END;
------------------------------------------------------------
  FUNCTION listeden_al(p_par_name In VARCHAR2,
                       p_parlist In parlist)
                       RETURN VARCHAR2 Is
    i NUMBER;
    d_number NUMBER := 9.99;
  BEGIN
    For i In p_parlist.FIRST..p_parlist.LAST LOOP
      IF p_parlist(i).par_name = p_par_name Then
        IF p_parlist(i).par_type='NUMBER' And INSTR(TO_CHAR(d_number),',')=0 Then
           RETURN Replace(p_parlist(i).par_value,',','.');
        Else
           RETURN p_parlist(i).par_value;
        END IF;
      END IF;
    END LOOP;
    RETURN Null;
  END;
------------------------------------------------------------
  FUNCTION getfromlist(p_par_name In VARCHAR2) RETURN VARCHAR2 Is
  BEGIN
    RETURN listeden_al(p_par_name,current_parlist);

  END;
------------------------------------------------------------
  FUNCTION hesapla(p_fis_source_type clk_paa_screen_group_book_vouc.voucher_source_type%TYPE,
                   p_fis_source      clk_paa_screen_group_book_vouc.voucher_source%TYPE,
                   p_parlist         parlist,
                   p_ekran   In VARCHAR2,  
                   p_grup    In VARCHAR2,  
                   p_muh_id  In VARCHAR2)  
                   RETURN VARCHAR2 Is
    retval VARCHAR2(2000);
    i NUMBER :=0;
    d_source VARCHAR2(2000);
  BEGIN
    d_hes_source := Null;
    IF    p_fis_source_type='EKRAN' Then
      BEGIN
      retval := listeden_al(p_fis_source,p_parlist);
      EXCEPTION WHEN OTHERS Then
       PKG_HATA.hata_yaz(240,TRUE, 'PARLISTTEN ALIRKEN HATA:'||SQLERRM);

/*        hata_yaz(602,SQLERRM,'PARLISTTEN ALIRKEN HATA:'||p_fis_source_type||'\'||p_fis_source,
                 p_EKRAN,p_GRUP,Null,p_MUH_ID);
*/      END;
    ELSIF p_fis_source_type='SABIT' Then
      retval := p_fis_source;
    ELSIF p_fis_source_type='HESAP' Then
      d_source := UPPER(p_fis_source);
      For i In p_parlist.FIRST..p_parlist.LAST LOOP
        BEGIN
        IF INSTR(d_source,UPPER(p_parlist(i).par_name))>0 Then
          d_source := Replace(d_source,
                              UPPER(p_parlist(i).par_name),
                              Formatla(p_parlist(i).par_type,p_parlist(i).par_value));
        END IF;
        EXCEPTION WHEN OTHERS Then
          PKG_HATA.hata_yaz(240,TRUE, 'GRUP ICI GRUP HATA:'||SQLERRM);

/*          hata_yaz(603,SQLERRM,p_fis_source_type||'\'||p_fis_source||'\'||CHR(13)||CHR(10)||
                               p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                               p_EKRAN,p_GRUP,Null,p_MUH_ID);*/
        END;
      END LOOP;
      d_hes_source := d_source;
      BEGIN
      retval := pkg_par_book_ap.dinamiksql(d_source,'DEGER');
      EXCEPTION WHEN OTHERS Then
        hata_yaz(240,SQLERRM,'DINAMIK SQLDE HATA:'||d_source,p_EKRAN,p_GRUP,Null,p_MUH_ID);
      END;
    END IF;
    RETURN retval;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(240,SQLERRM,'HESAPLA PROSEDURUNDE HATA.:'||p_fis_source_type||'\'||p_fis_source,
             p_EKRAN,p_GRUP,Null,p_MUH_ID);
  END;
------------------------------------------------------------
  FUNCTION get_parlist(p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_muh_id  In VARCHAR2,
                       p_parlist In parlist,
                       p_cag_ekran In VARCHAR2)
                       RETURN parlist Is
    CURSOR c Is
      Select voucher_par_name,voucher_source_type,voucher_source
        From clk_paa_screen_group_book_vouc
       Where screen   = p_ekran
         And group_   = p_grup
         And book_id = p_muh_id
       Order By LENGTH(voucher_par_name) Desc;
    d_parlist parlist;
    i NUMBER:=0;
    d_parametre_adet NUMBER;
    d_ara            clk_paa_screen_fields.type_%TYPE;
  BEGIN
    Select COUNT(*) Into d_parametre_adet
      From clk_paa_screen_group_book_vouc
     Where screen   = p_ekran
       And group_   = p_grup
       And book_id  = p_muh_id;
    d_parlist := parlist(Null);
    d_parlist.EXTEND(d_parametre_adet);
    For r In c LOOP
      BEGIN
      i := i+1;
      d_parlist(i).par_name  := r.voucher_par_name;
      d_parlist(i).par_value := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_EKRAN,p_GRUP,p_MUH_ID);
      Select type_ Into d_ara From clk_paa_screen_fields
       Where par_name=r.voucher_par_name And screen=p_cag_ekran;
      d_parlist(i).par_type := d_ara;
      EXCEPTION WHEN OTHERS Then
/*        hata_yaz(502,SQLERRM,'PARAMETRE LISTESI OLUSTURULURKEN HATA:'||
                             r.voucher_par_name||'\'||r.voucher_source_type||CHR(13)||CHR(10)||r.voucher_source||CHR(13)||CHR(10)||p_cag_ekran,
                             p_EKRAN,p_GRUP,Null,p_MUH_ID);
*/       PKG_HATA.hata_yaz(240,TRUE, 'PARAMETRE LISTESI OLUSTURULURKEN HATA:'||SQLERRM);
                             
      END;
    END LOOP;
    RETURN d_parlist;
  EXCEPTION WHEN OTHERS Then
    PKG_HATA.hata_yaz(240,TRUE, 'PARAMETRE LISTESI OLUSTURULAMADI!..'||SQLERRM);
--    hata_yaz(501,SQLERRM,'PARAMETRE LISTESI OLUSTURULAMADI!', p_EKRAN,p_GRUP,Null,p_MUH_ID);
  END;
------------------------------------------------------------
  FUNCTION kosul_uygun(p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_parlist In parlist)
                       RETURN BOOLEAN Is
    CURSOR c Is
      Select *
         From clk_paa_screen_group_cond
        Where screen=p_ekran
          And group_=p_grup
          And cond Is Not Null
        Order By cond_id;
    d_source VARCHAR2(2000);
  BEGIN
    For r In c LOOP
      d_source := UPPER(r.cond);
      For i In p_parlist.FIRST..p_parlist.LAST LOOP
        BEGIN
        IF INSTR(d_source,UPPER(p_parlist(i).par_name))>0 Then
          d_source := Replace(d_source,
                              UPPER(p_parlist(i).par_name),
                              Formatla(p_parlist(i).par_type,p_parlist(i).par_value));
        END IF;
        EXCEPTION WHEN OTHERS Then
          hata_yaz(240,SQLERRM,'GRUP KOSULLARINDA PARAMETRE YERLESTIRIKEN HATA.'||p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                   p_EKRAN,p_GRUP);
        END;
      END LOOP;
      BEGIN
      IF pkg_par_book_ap.dinamiksql(d_source,'KOSUL')='0' Then
        RETURN FALSE;
      END IF;
      EXCEPTION WHEN OTHERS Then
        hata_yaz(240,SQLERRM,'GRUP KOSULLARI DINAMIK SQLDE HATA.'||r.cond||d_source,
                 p_EKRAN,p_GRUP,r.cond_id);
      END;
    END LOOP;
    RETURN TRUE;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(240,SQLERRM,'GRUP KOSULLARINDA HATA.', p_EKRAN,p_GRUP);
  END;
------------------------------------------------------------
  FUNCTION kosul_uygun(p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_muh_id  In VARCHAR2,
                       p_parlist In parlist)
                       RETURN BOOLEAN Is
    CURSOR c Is
      Select *
         From clk_paa_screen_group_book_cond
        Where screen=p_ekran
          And group_=p_grup
          And book_id=p_muh_id
          And cond Is Not Null
        Order By cond_id;
    d_source VARCHAR2(2000);
  BEGIN
    For r In c LOOP
      d_source := UPPER(r.cond);
      For i In p_parlist.FIRST..p_parlist.LAST LOOP
        BEGIN
        IF INSTR(d_source,UPPER(p_parlist(i).par_name))>0 Then
          d_source := Replace(d_source,
                              UPPER(p_parlist(i).par_name),
                              Formatla(p_parlist(i).par_type,p_parlist(i).par_value));
        END IF;
        EXCEPTION WHEN OTHERS Then
          hata_yaz(302,SQLERRM,'BILESEN KOSULLARINDA PARAMETRE YERLESTIRIRKEN HATA.'||p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                   p_EKRAN,p_GRUP,Null,p_muh_id,r.cond_id);
        END;
      END LOOP;
      BEGIN
      IF pkg_par_book_ap.dinamiksql(d_source,'KOSUL')='0' Then
        RETURN FALSE;
      END IF;
      EXCEPTION WHEN OTHERS Then
        hata_yaz(303,SQLERRM,'BILESEN KOSULLARI DINAMIK SQLDE HATA.'||r.cond||d_source,
                 p_EKRAN,p_GRUP,Null,p_muh_id,r.cond_id);
      END;
    END LOOP;
    RETURN TRUE;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(301,SQLERRM,'BILESEN KOSULLARINDA HATA.', p_EKRAN,p_GRUP,p_muh_id);
  END;
------------------------------------------------------------
  PROCEDURE fis_kes(p_ekran   In VARCHAR2,
                    p_grup    In VARCHAR2,
                    p_muh_id  In VARCHAR2,
                    p_parlist In parlist) Is
    CURSOR c Is
      Select *
        From clk_paa_screen_group_book_vouc
       Where screen=p_ekran
         And group_=p_grup
         And book_id=p_muh_id
         And voucher_source Is Not Null
       Order By voucher_order;
    
    Cursor fis_desc Is
      Select *
        From clk_paa_screen_description s
       where s.screen=p_ekran
         and s.group_=p_grup
         and s.book_id=p_muh_id
         and s.language_code!='TR';    

    d_TUR                    clk_paa_temporary.tur%TYPE;
    d_HESAP_BOLUM_KODU       clk_paa_temporary.hesap_bolum_kodu%TYPE;
    d_HESAP_TUR_KODU         clk_paa_temporary.hesap_tur_kodu%TYPE;
    d_HESAP_NUMARA           clk_paa_temporary.hesap_numara%TYPE;
    d_VALOR_TARIHI           clk_paa_temporary.valor_tarihi%TYPE;
    d_LC_TUTAR               clk_paa_temporary.lc_tutar%TYPE;
    d_DV_TUTAR               clk_paa_temporary.dv_tutar%TYPE;
    d_DOVIZ_KOD              clk_paa_temporary.doviz_kod%TYPE;
    d_BANKA_ACIKLAMA         clk_paa_temporary.banka_aciklama%TYPE;
    d_MUSTERI_ACIKLAMA       clk_paa_temporary.musteri_aciklama%TYPE;
    d_ISTATISTIK_KODU        clk_paa_temporary.istatistik_kodu%TYPE;
    d_REFERANS               clk_paa_temporary.referans%TYPE;
    d_MUSTERI_HESAP_NUMARA   clk_paa_temporary.musteri_hesap_numara%TYPE;
    d_MUSTERI_HESAP_TUR      clk_paa_temporary.musteri_hesap_tur%TYPE;
    d_KUR                    clk_paa_temporary.kur%TYPE;
    d_bacak_grup             clk_pa_temporary.bacak_grubu%TYPE;
    d_temel_hesap            clk_pa_temporary.temel_hesap%TYPE;
    d_KASA_NAKIT_KOD         clk_pa_temporary.kasa_nakit_kod%TYPE;    
    d_dkmusno                Varchar2(30);
    d_BANKA_ACIKLAMA2        clk_paa_temporary.banka_aciklama%TYPE;
    d_MUSTERI_ACIKLAMA2      clk_paa_temporary.musteri_aciklama%TYPE;
    d_orj_dil                varchar2(10);
  BEGIN
    IF kosul_uygun(p_ekran,p_grup,p_muh_id,p_parlist) Then
      d_kayit_no := NVL(d_kayit_no,0)+1;
      For r In c LOOP
        BEGIN
        IF    r.voucher_par_name='B_A'                Then d_TUR                := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_SUBE_KODU'    Then d_HESAP_BOLUM_KODU   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_TUR_KODU'     Then d_HESAP_TUR_KODU     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_NUMARA'       Then d_HESAP_NUMARA       := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='VALOR_TARIHI'       Then d_VALOR_TARIHI       := TO_DATE(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id)/*,'DD/MM/YYYY' date olan degerlerde 0009 hatasi yaptiriyor MHA 050809*/);
        ELSIF r.voucher_par_name='LC_TUTAR'           Then d_LC_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DV_TUTAR'           Then d_DV_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DOVIZ_KOD'          Then d_DOVIZ_KOD          := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='KUR'                Then d_kur                := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='ACIKLAMA_BANKA'     Then d_BANKA_ACIKLAMA     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id)||' '||getKanalAciklama;
        ELSIF r.voucher_par_name='ACIKLAMA_MUSTERI'   Then d_MUSTERI_ACIKLAMA   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id)||' '||getKanalAciklama;
        ELSIF r.voucher_par_name='MUSTERI_HESAP_NUMARA' Then d_MUSTERI_HESAP_NUMARA   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='MUSTERI_HESAP_TUR'    Then d_MUSTERI_HESAP_TUR:= hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='ISTATISTIK_KODU'    Then d_ISTATISTIK_KODU    := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='REFERANS'           Then d_REFERANS           := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='KASA_NAKIT_KOD'     Then d_KASA_NAKIT_KOD     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='BACAK_GRUBU'        Then d_BACAK_GRUP         := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='TEMEL_HESAP'        Then d_TEMEL_HESAP        := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        END IF;

        EXCEPTION WHEN OTHERS Then
            PKG_HATA.hata_yaz(240,TRUE,'FIS KESMEDE HATA..Field : '||
                                        r.voucher_par_name||'\'||r.voucher_source_type||'\'||r.voucher_source||SQLERRM);
/*          hata_yaz(401,SQLERRM,'FIS KESMEDE HATA.'||CHR(13)||CHR(10)||r.voucher_par_name||'\'||r.voucher_source_type||CHR(13)||CHR(10)||r.voucher_source||CHR(13)||CHR(10)||
          d_hes_source||'---'||hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id),
                   p_EKRAN,p_GRUP,Null,p_muh_id);*/
        END;
      END LOOP;
      
      /* Farkli dillerde aciklama varsa olusturalim MHA 20042011 */
      d_BANKA_ACIKLAMA2 := null;
      d_MUSTERI_ACIKLAMA2 := null;

      For d in fis_desc Loop
        BEGIN
            d_orj_dil := pkg_global.GET_DILKOD;
            pkg_global.SET_DILKOD(d.language_code);
            d_BANKA_ACIKLAMA2 := hesapla(d.bank_desc_type,d.bank_description,p_parlist,p_ekran,p_grup,p_muh_id)||' '||getKanalAciklama;
            d_MUSTERI_ACIKLAMA2 := hesapla(d.cust_desc_type,d.cust_description,p_parlist,p_ekran,p_grup,p_muh_id)||' '||getKanalAciklama;
            pkg_global.SET_DILKOD(d_orj_dil);
           if NVL(d_LC_TUTAR,0) != 0 then 
              insert into clk_paa_desc_temporary(dil_kod,banka_aciklama,musteri_aciklama,numara,ekran,grup,muh_id)
              values (d.language_code,d_BANKA_ACIKLAMA2,d_MUSTERI_ACIKLAMA2,d_kayit_no,p_ekran,p_grup,p_MUH_ID);
           end if;   
           -- dbms_output.put_line(d_kayit_no ||' insert edildi');
        EXCEPTION WHEN OTHERS Then
            PKG_HATA.hata_yaz(240,TRUE,'FIS KESMEDE ACIKLAMA OLSUTURMADA HATA... : '||d.group_||'\'||d.book_id||'\'||
                                        d.language_code||'\'||SQLERRM);
        END;
      End Loop; 
      -- Valor tarihi
      If d_valor_tarihi is null then
         if d_HESAP_TUR_KODU in ('VS','VD') Then
            if d_tur = 'A' Then
               d_valor_tarihi := PKG_MUHASEBE.Sonraki_Banka_Tarihi_Bul;
            Else
               d_valor_tarihi := Pkg_Muhasebe.Banka_Tarihi_Bul;
            End if;
         Else
               d_valor_tarihi := Pkg_Muhasebe.Banka_Tarihi_Bul;
         End if;
      End if;            
      --
      BEGIN
      Insert Into clk_paa_TEMPORARY
      (TUR,          HESAP_BOLUM_KODU, HESAP_TUR_KODU,         HESAP_NUMARA,
       VALOR_TARIHI, LC_TUTAR,         DV_TUTAR,               DOVIZ_KOD,
       BANKA_ACIKLAMA,MUSTERI_ACIKLAMA,ISTATISTIK_KODU,        REFERANS,
       MUSTERI_HESAP_NUMARA,           MUSTERI_HESAP_TUR,      KUR,
       NUMARA,       BACAK_GRUBU,      TEMEL_HESAP,            KASA_NAKIT_KOD,                 
       EKRAN,        GRUP,             MUH_ID )
       Values
      (d_TUR,           d_HESAP_BOLUM_KODU, d_HESAP_TUR_KODU,         d_HESAP_NUMARA,
       d_VALOR_TARIHI,  d_LC_TUTAR,         d_DV_TUTAR,               d_DOVIZ_KOD,
       d_BANKA_ACIKLAMA,d_MUSTERI_ACIKLAMA, d_ISTATISTIK_KODU,        d_REFERANS,
       d_MUSTERI_HESAP_NUMARA,              d_MUSTERI_HESAP_TUR,      d_KUR,
       d_kayit_no,      d_BACAK_GRUP,       d_TEMEL_HESAP,            d_KASA_NAKIT_KOD,
       p_ekran,         p_grup,             p_MUH_ID )
        ;
        --   
       if d_HESAP_TUR_KODU not in ('DK') Then
             d_kayit_no := NVL(d_kayit_no,0)+1;
            --
             d_dkmusno := PKG_HESAP.musteri_dk_no(d_HESAP_NUMARA);
            --
             Insert Into clk_paa_TEMPORARY
            (TUR,          HESAP_BOLUM_KODU, HESAP_TUR_KODU,         HESAP_NUMARA,
             VALOR_TARIHI, LC_TUTAR,         DV_TUTAR,               DOVIZ_KOD,
             BANKA_ACIKLAMA,MUSTERI_ACIKLAMA,ISTATISTIK_KODU,        REFERANS,
             MUSTERI_HESAP_NUMARA,           MUSTERI_HESAP_TUR,      KUR,
             NUMARA,       BACAK_GRUBU,      TEMEL_HESAP,            KASA_NAKIT_KOD,                 
             EKRAN,        GRUP,             MUH_ID )
             Values
            (d_TUR,           d_HESAP_BOLUM_KODU, 'DK',                     d_dkmusno,
             d_VALOR_TARIHI,  d_LC_TUTAR,         d_DV_TUTAR,               d_DOVIZ_KOD,
             d_BANKA_ACIKLAMA,d_MUSTERI_ACIKLAMA, d_ISTATISTIK_KODU,        d_REFERANS,
             d_MUSTERI_HESAP_NUMARA,              d_MUSTERI_HESAP_TUR,      d_KUR,
             d_kayit_no,      d_BACAK_GRUP,       d_TEMEL_HESAP,            d_KASA_NAKIT_KOD,
             p_ekran,         p_grup,             p_MUH_ID )
              ;
            If d_BANKA_ACIKLAMA2 is not null or d_MUSTERI_ACIKLAMA2 is not null then            
               if Nvl(d_LC_TUTAR,0) != 0 then
                   Insert into clk_paa_desc_temporary(dil_kod,banka_aciklama,musteri_aciklama,numara,ekran,grup,muh_id)
                   select dil_kod,banka_aciklama,musteri_aciklama,d_kayit_no,ekran,grup,muh_id    
                     from clk_paa_desc_temporary f
                    where f.ekran=p_ekran
                      and f.grup =p_grup
                      and f.muh_id=p_muh_id
                      and f.numara=d_kayit_no-1; /*masrafda burasi olmazsa 2 farkli masraf varsa bir sekilde cogullanýyor kayitlar MHA 010611 */
                    --dbms_output.put_line(d_kayit_no ||' '||sql%rowcount||' satir insert edildi');
                end if;    

            end if;       
       end if;
      EXCEPTION WHEN OTHERS Then
--          hata_yaz(402,SQLERRM,'FIS KESMEDE TEMP TABLODA HATA.', p_EKRAN,p_GRUP,Null,p_muh_id);
          PKG_HATA.hata_yaz(240,TRUE,'FIS KESMEDE TMP HATA..'||p_GRUP||'..'||p_muh_id||'***'||sqlerrm);
      END;

    END IF;
  END;
------------------------------------------------------------
  PROCEDURE grup_isle(p_ekran   In VARCHAR2,
                      p_grup    In VARCHAR2,
                      p_parlist In parlist) Is
    CURSOR c Is
      Select *
        From clk_paa_screen_group_book
       Where screen=p_ekran
         And group_ =p_grup
       Order By book_id;
    d_ekran VARCHAR2(10);
    d_grup VARCHAR2(10);
    d_sira NUMBER;
    d_sira2 NUMBER;
  BEGIN
     IF kosul_uygun(p_ekran,p_grup,p_parlist) Then
      For r In c LOOP
        BEGIN
          IF r.book_type='FIS' Then
            fis_kes(r.screen,r.group_,r.book_id,p_parlist);
          ELSIF r.book_type In ('GRUP','GRUPTERS') Then
          IF  kosul_uygun(p_ekran,p_grup,r.book_id,p_parlist) Then
            d_ekran := SUBSTR(r.BOOK_NAME,1,INSTR(r.BOOK_NAME,'.')-1);
            d_grup  := SUBSTR(r.BOOK_NAME,INSTR(r.BOOK_NAME,'.')+1);
            Select NVL(MAX(numara),0) Into d_sira From CLK_PAA_TEMPORARY;            
            grup_isle(d_ekran,d_grup,get_parlist(r.screen,r.group_,r.book_id,p_parlist,d_ekran));
            IF r.book_type = 'GRUPTERS' Then
              Select NVL(MAX(Numara),0) Into d_sira2 From CLK_PAA_TEMPORARY;
              Update CLK_PAA_TEMPORARY A
                Set A.TUR  = DECODE(a.tur,'A','B','B','A')
               Where/* ekran = d_ekran
                 And grup  = d_grup
                 And*/ numara Between d_sira+1 And d_sira2;
               null;
            END IF;
           END IF;
          END IF;
        EXCEPTION WHEN OTHERS Then
         PKG_HATA.hata_yaz(240,TRUE,'GRUP ISLEMEDE HATA..'||p_ekran||'..'||r.GROUP_||'/'||SQLERRM);
         -- hata_yaz(201,SQLERRM,'GRUP ??LEMEDE HATA.', p_ekran,r.GROUP_,Null,r.BOOK_ID);
        END;
      END LOOP;
    END IF;
  END;
------------------------------------------------------------
  PROCEDURE Temporary_Olustur (p_ekran In VARCHAR2,
                               p_parlist In parlist) Is
    d_value VARCHAR2(8);
    d_sayi  number;
    v_voucher_exp clk_paa_screen.voucher_exp%type;
    v_voucher_revocable clk_paa_screen.voucher_revocable%type;
    v_force_debit clk_paa_screen.force_debit%type;
        
  BEGIN
    current_parlist := p_parlist;
    Select NVL(MAX(a.numara),0) Into d_kayit_no From clk_paa_TEMPORARY A;
    For r In (Select * From clk_paa_screen_group Where screen=p_ekran Order By order_) LOOP
    BEGIN
      d_bacak_grup := r.row_group;
      grup_isle(r.screen,r.group_,p_parlist);
     
      IF r.base_account Is Not Null Then
         d_value := hesapla('HESAP',r.base_account,p_parlist,r.screen,r.group_,0);
          Update clk_paa_TEMPORARY d
             Set temel_hesap=d_value ,
                 d.bacak_grubu = d_bacak_grup
          Where ekran=r.screen 
            And grup=r.group_;
      END IF;

    EXCEPTION WHEN OTHERS Then
      --PKG_HATA.hata_yaz(240,TRUE,  CHR(13)||CHR(10)||'MUHASEBEDE HATA..'||p_ekran||'..'||r.GROUP_||'..'||SQLERRM);
      hata_yaz(101,SQLERRM,'MUHASEBEDE HATA.'|| p_ekran||','||r.GROUP_);
    END;
    END LOOP;

  -- fis bazinda degiskenler atanir
    
    Select distinct b.voucher_exp , b.voucher_revocable , b.force_debit
    into v_voucher_exp , v_voucher_revocable , v_force_debit
    from clk_paa_SCREEN b
    where b.screen = p_ekran;
    
    Update clk_paa_TEMPORARY a
       Set a.fis_aciklama = v_voucher_exp,
           a.fis_iptal_edilebilir = v_voucher_revocable
           ,a.fis_force_debit = v_force_debit;
              
/*
    Update clk_paa_TEMPORARY a
       Set (a.fis_aciklama ,a.fis_iptal_edilebilir,a.fis_force_debit )
          =( Select distinct b.voucher_exp , b.voucher_revocable , b.force_debit
               from clk_paa_SCREEN b
              where b.screen = p_ekran )
     ;
*/

    Select COUNT(*) Into d_sayi
      From clk_paa_process;
    IF d_sayi<>0 Then
      null;
    END IF;
  END;
  -------------------------------------------------------------------------
  --  Bankacilik fis yapisina insert kismi ....
 FUNCTION Fis_Satir_Insert (
                       p_ISLEM_NO        in NUMBER,       -- ekran islem no,Tablonun Key'i Tranx_id,TX_NO
                       p_ISLEM_SUBE_KOD  in VARCHAR2,
                       p_YARATAN_KULL    in VARCHAR2,     
                       p_GECERLI_OLDUGU_TARIH in DATE     
                             )  RETURN NUMBER Is
   dTUR           Varchar2(1 char);
   dFIS_NUMARA    Number;
   dBanka_tarihi  Date;
   deod           Varchar2(1 char);
   p2_gecerli_oldugu_tarih Date;
   d_DekontNo     Number;
   ln_sayi number;
   
   Begin

      select count(*)
      into ln_sayi
      from clk_paa_temporary b
      where nvl(b.lc_tutar,0)+nvl(b.dv_tutar,0) != 0;
      
     if ln_sayi >0 then     -- Fisteki tum tutarlar 0 degil ise

      -- Fis No , Banka tarihi al
      dFIS_NUMARA   := PKG_MUHASEBE.Fis_Numara_AL;
      dbanka_tarihi := PKG_MUHASEBE.Banka_Tarihi_Bul;
      -- EOD control
      dEod          := PKG_TABLO.sistem_bilgi('CLK').end_of_day;
      -- 
      IF dEod='E' THEN
          IF p_gecerli_oldugu_tarih IS NOT NULL THEN
            p2_gecerli_oldugu_tarih:=p_gecerli_oldugu_tarih;
          ELSE
            p2_gecerli_oldugu_tarih:=dbanka_tarihi;
          END IF;
      ELSE
          IF p_gecerli_oldugu_tarih IS NOT NULL THEN
            p2_gecerli_oldugu_tarih:=p_gecerli_oldugu_tarih;
          ELSE
            p2_gecerli_oldugu_tarih:=dbanka_tarihi;
          END IF;
      END IF;

      IF TRUNC(NVL(p_gecerli_oldugu_tarih,dBanka_tarihi)) > TRUNC(dBanka_tarihi) THEN
        dtur:='T'; -- Temporary
      ELSE
        dtur:='G'; -- Gecerli
      END IF;
      
      -- Once fis tablosuna insert
      INSERT INTO MUH_fis (
                      NUMARA,            ACIKLAMA,   ISLEM_NUMARA,           YARAT_TAR,  
                      GECERLILIK_TAR,    MUH_TARIH,  YARATAN_KULLANICI_KODU, FIS_NO,
                      YARATILDIGI_BANKA_TARIH,       IPTAL_EDILDIGI_TARIH,
                      TUR,               IPTAL_EDILEBILIR,                   ISLEM_SUBE_KOD,
                      FORCE_DEBIT ) 
         ( SELECT DISTINCT dFIS_NUMARA   , a.fis_aciklama  , p_ISLEM_NO,   sysdate,
                  p2_GECERLI_OLDUGU_TARIH, Null,
                  p_YARATAN_KULL         , Null       , dBanka_tarihi,
                  Null                   , dTUR           ,
                  a.fis_iptal_edilebilir , P_ISLEM_SUBE_kod , a.fis_force_debit     
             FROM clk_paa_temporary a    );
       --  Fis_satir Tablosuna insert
       INSERT INTO MUH_FIS_satir (
                  FIS_NUMARA,       NUMARA,            B_A,                 HESAP_SUBE_KOD,
                  HESAP_TUR_KODU,   HESAP_NUMARA,      VALOR_TARIHI,        LC_TUTAR,
                  DV_TUTAR,         DOVIZ_KOD,         BASE_TUTAR,          KUR,
                  ACIKLAMA_BANKA,   ACIKLAMA_MUSTERI,  MUSTERI_HESAP_NUMARA,MUSTERI_HESAP_TUR,
                  DEKONT_NO,        ISTATISTIK_KODU,   REFERANS,            YARATILDIGI_TARIH,
                  YARATAN_KULLANICI_KODU,              SONRAKI_BAKIYE,      KASA_NAKIT_KOD,
                  BACAK_GRUBU,      TEMEL_HESAP,       BALANCE_FLAG,        BALANCE_AFTER   
                  )
          (
           SELECT dFIS_NUMARA,      b.numara,           b.tur,             b.hesap_bolum_kodu,
                  b.hesap_tur_kodu, b.hesap_numara,     b.valor_tarihi,    b.lc_tutar,
                  b.dv_tutar,       b.doviz_kod,        Null,              b.kur,
                  b.banka_aciklama, b.musteri_aciklama, b.musteri_hesap_numara, b.musteri_hesap_tur,
                  d_DekontNo,       b.istatistik_kodu,  b.referans,         sysdate,
                  p_YARATAN_KULL,                       Null,              b.kasa_nakit_kod,
                  b.bacak_grubu,    b.temel_hesap,      null,              null
            FROM clk_paa_temporary b
           WHERE nvl(b.lc_tutar,0)+nvl(b.dv_tutar,0) != 0
       );
       
       INSERT INTO MUH_FIS_SATIR_ACIKLAMA(FIS_NUMARA,NUMARA,DIL_KOD,ACIKLAMA_BANKA,ACIKLAMA_MUSTERI)
       ( SELECT dFIS_NUMARA,d.numara,d.dil_kod,d.banka_aciklama,d.musteri_aciklama
         FROM clk_paa_desc_temporary d );
      
      RETURN dFIS_NUMARA ;
      else     
       RETURN Null;
      end if;
     Exception
        When Others Then
          PKG_HATA.hata_yaz(243,TRUE,SQLERRM);
         -- RETURN -1;
   End;
------------------------------------- Fis Yaratma k?sm?--------------------------
  FUNCTION  FIS_YARAT (p_ekran                in varchar2,     
                       p_TXISLEM_NO           in NUMBER,      
                       p_ISLEM_SUBE_KOD       in VARCHAR2,
                       p_YARATAN_KULL         in VARCHAR2,    
                       p_GECERLI_OLDUGU_TARIH in DATE
                       )  RETURN NUMBER IS

  	cursor c is
  		/*select distinct field,type_,a.field_name
  		  from v_clk_paa_group_parameters a*/
        --field_name, field ,type_
      Select upper(a.field) as field, upper(a.type_)  as type_ ,upper(a.par_name)  as field_name
        from clk_paa_screen_fields a
  		 where screen=p_ekran
  		 order by length(field) desc
       ;
		d_parlist pkg_par_book_ap.parlist;
		i         number:=0;
		d_parametre_adet number;
    d_tabloadi       varchar2(30);
    dFis_No          number;
    ln_sayi          number;
    ln_cursor_open   number;         
  begin
    Begin
     Select Distinct a.prompt
       Into d_tabloadi
       FROM clk_paa_screen_fields a
       Where a.screen   = p_ekran
     ;
    	exception 
        when too_many_rows then
           PKG_HATA.hata_yaz(241,TRUE,p_ekran);
        when no_data_found then
           PKG_HATA.hata_yaz(242,TRUE,p_ekran);
    End;

    delete from CLK_PAA_TEMPORARY; /* giriste temporary tablomuzu temizliyoruz MHA 221009*/
    delete from Clk_Paa_Desc_Temporary;

    -- Tablodan dinamik parametre cek
     pkg_par_acctselect.init(d_tabloadi,' WHERE TX_NO = '||p_TXISLEM_NO);
    --  parametre listesini olustur ...
		select count(field) 
      into d_parametre_adet
		  from clk_paa_screen_fields
		 where screen=p_ekran
     ;
		d_parlist := PKG_PAR_BOOK_AP.parlist(null);
  	d_parlist.extend(d_parametre_adet);
    --
  	for r in c loop
  		i := i+1;
  		d_parlist(i).par_name  := r.field_name;
  		d_parlist(i).par_type  := r.type_;
      pkg_par_acctselect.addColumn(r.field);    -- Dinamik cursor fieldlari
  	end loop;
    --
    
    While ( pkg_par_acctselect.nextRecord ) LOOP 
      ln_cursor_open := 1;  
      For i in 1..d_parametre_adet   LOOP      -- Kolon degerlerini al
        d_parlist(i).par_value :=  pkg_par_acctselect.getColumn(i);
      END LOOP;
      -- Parametre  listedi tablodan okundu , artik Muh kesilebilir
      PKG_PAR_BOOK_AP.Temporary_olustur(p_ekran   => p_ekran,     -- clk_paa_temporary Olustu
                                        p_parlist => d_parlist );
    END LOOP;  
		Pkg_Par_Acctselect.closeCursor;
    ln_cursor_open := 0;
    -- fis ve Satir tablolarina insert
      select count(*) Into ln_sayi from CLK_PAA_TEMPORARY f
      where f.lc_tutar < 0 OR f.dv_tutar < 0;
      If ln_sayi = 0 Then
         dFis_no :=  Fis_Satir_Insert ( p_TXISLEM_NO   , p_ISLEM_SUBE_KOD,
                                        p_YARATAN_KULL , p_GECERLI_OLDUGU_TARIH  );
      else
          PKG_HATA.hata_yaz(850,TRUE,null);
      End if;
      
     --
        
      Delete From CLK_PAA_TEMPORARY;   -- Double bacaklari engellemek için 
      Delete FRom Clk_Paa_DEsc_Temporary;
     --
     If nvl(dFis_no,1) > 0 Then -- Null da olsa dönsün demekki fiş kesecek birşey bulamamış.Teminat girişte sıkıntı yaratıyor. MHA120808
        RETURN dfis_no;
     Else
       PKG_HATA.hata_yaz(311,TRUE,SQLERRM);
     End if;
  	exception when others then
         if ln_cursor_open = 1 then
            Pkg_Par_Acctselect.closeCursor;
         end if;   
           PKG_HATA.hata_yaz(243,TRUE,SQLERRM);
   End;
--

-------------------------------------Ek Fis Yaratma k?sm?--------------------------
  --  Bankacilik fis yapisina insert kismi ....
 FUNCTION EK_Fis_Satir_Insert (  p_FIS_NUMARA      in NUMBER)  RETURN NUMBER Is
   d_DekontNo      Number;
   d_MaxFisSatirNo Number;
   d_YARATAN_KULL  Varchar2(30);
   Begin
       Select max(numara),max(a.yaratan_kullanici_kodu)
         Into d_MaxFisSatirNo,d_YARATAN_KULL
         From muh_fis_satir a
        Where fis_numara = p_FIS_NUMARA
        ;
   
       --  Fis_satir Tablosuna insert
       INSERT INTO MUH_FIS_satir (
                  FIS_NUMARA,       NUMARA,            B_A,                 HESAP_SUBE_KOD,
                  HESAP_TUR_KODU,   HESAP_NUMARA,      VALOR_TARIHI,        LC_TUTAR,
                  DV_TUTAR,         DOVIZ_KOD,         BASE_TUTAR,          KUR,
                  ACIKLAMA_BANKA,   ACIKLAMA_MUSTERI,  MUSTERI_HESAP_NUMARA,MUSTERI_HESAP_TUR,
                  DEKONT_NO,        ISTATISTIK_KODU,   REFERANS,            YARATILDIGI_TARIH,
                  YARATAN_KULLANICI_KODU,              SONRAKI_BAKIYE,      KASA_NAKIT_KOD,
                  BACAK_GRUBU,      TEMEL_HESAP,       BALANCE_FLAG,        BALANCE_AFTER   
                  )
          (
           SELECT p_FIS_NUMARA,      b.numara + d_MaxFisSatirNo,           
                                                        b.tur,             b.hesap_bolum_kodu,
                  b.hesap_tur_kodu, b.hesap_numara,     b.valor_tarihi,    b.lc_tutar,
                  b.dv_tutar,       b.doviz_kod,        Null,              b.kur,
                  b.banka_aciklama, b.musteri_aciklama, b.musteri_hesap_numara, b.musteri_hesap_tur,
                  d_DekontNo,       b.istatistik_kodu,  b.referans,         sysdate,
                  d_YARATAN_KULL,                       Null,              b.kasa_nakit_kod,
                  b.bacak_grubu,    b.temel_hesap,      null,              null
            FROM clk_paa_temporary b
           WHERE nvl(b.lc_tutar,0)+nvl(b.dv_tutar,0) != 0
       );

       INSERT INTO MUH_FIS_SATIR_ACIKLAMA(FIS_NUMARA,NUMARA,DIL_KOD,ACIKLAMA_BANKA,ACIKLAMA_MUSTERI)
       ( SELECT p_FIS_NUMARA,d.numara + d_MaxFisSatirNo,d.dil_kod,d.banka_aciklama,d.musteri_aciklama
         FROM clk_paa_desc_temporary d );

      RETURN p_FIS_NUMARA ;
     Exception
        When Others Then
         PKG_HATA.hata_yaz(243,TRUE,SQLERRM);
   End;
--
----- Fissonuna Masraf Vs turu eklemeler i?in ----------------------
FUNCTION  EK_FIS_YARAT (p_ekran                in varchar2,     
                        p_TXISLEM_NO           in Number,      
                        p_Fisno                in Number
                       )  RETURN NUMBER IS

  	cursor c is
  	/*	select distinct field,type_,a.field_name
  		  from v_clk_paa_group_parameters a*/
      Select upper(a.field) as field, upper(a.type_)  as type_ ,upper(a.par_name)  as field_name
        from clk_paa_screen_fields a
  		 where screen=p_ekran
  		 order by length(field) desc
       ;
		d_parlist pkg_par_book_ap.parlist;
		i         number:=0;
		d_parametre_adet number;
    d_tabloadi       varchar2(30);
    dFis_No          number;
  begin
    -- Oncelikle Temporary Tabloyu Temizle ..
    Delete from clk_paa_temporary;
    delete from Clk_Paa_Desc_Temporary;
    -- Parametre listesini olustur ..
    Begin
     Select Distinct a.prompt
       Into d_tabloadi
       FROM clk_paa_screen_fields a
       Where a.screen   = p_ekran
     ;
    	exception 
        when too_many_rows then
           PKG_HATA.hata_yaz(241,TRUE,p_ekran);
        when no_data_found then
           PKG_HATA.hata_yaz(242,TRUE,p_ekran);
    End;
    -- Tablodan dinamik parametre cek
     pkg_par_acctselect.init(d_tabloadi,' WHERE TX_NO = '||p_TXISLEM_NO);
    --  parametre listesini olustur ...
		select count(field) 
      into d_parametre_adet
		  from clk_paa_screen_fields
		 where screen=p_ekran
     ;
		d_parlist := PKG_PAR_BOOK_AP.parlist(null);
  	d_parlist.extend(d_parametre_adet);
    --
  	for r in c loop
  		i := i+1;
  		d_parlist(i).par_name  := r.field_name;
  		d_parlist(i).par_type  := r.type_;
      pkg_par_acctselect.addColumn(r.field);    -- Dinamik cursor fieldlari
  	end loop;
    --
    
    While ( pkg_par_acctselect.nextRecord ) LOOP   
      For i in 1..d_parametre_adet   LOOP      -- Kolon degerlerini al
        d_parlist(i).par_value :=  pkg_par_acctselect.getColumn(i);
      END LOOP;
      -- Parametre  listedi tablodan okundu , artik Muh kesilebilir
      PKG_PAR_BOOK_AP.Temporary_olustur(p_ekran   => p_ekran,     -- clk_paa_temporary Olustu
                                        p_parlist => d_parlist );
    END LOOP;
		Pkg_Par_Acctselect.closeCursor;  
    -- fis ve Sat?r tablolar?na ?nsert
     dFis_no :=  EK_Fis_Satir_Insert (  p_Fisno  );
     delete from CLK_PAA_TEMPORARY; /* Temporary tablomuzu cikarken temizleyelim MHA 031209 */
     delete from Clk_Paa_Desc_Temporary;
     If dFis_no > 0 Then
        RETURN dfis_no;
     Else
       PKG_HATA.hata_yaz(311,TRUE,SQLERRM);
     End if;
  	exception when others then
           PKG_HATA.hata_yaz(243,TRUE,SQLERRM);
   End;
--------------------
Begin
 null;


END;
/
