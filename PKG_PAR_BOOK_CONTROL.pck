CREATE OR REPLACE PACKAGE PKG_PAR_BOOK_CONTROL IS

  TYPE parlist IS TABLE OF clk_paa_parlist%ROWTYPE;
  current_parlist       parlist;
  IptalBayrak           boolean;
  d_test                varchar2(1) := 'H';

-- Ana Fonksiyonlar
  Procedure KONTROLLERI_YAP ;           -- Hesaplar ile ilgili fis kesilmeden önce yapılacak kontroller

  Procedure FIS_YARAT  (p_ekran                in varchar2,     -- Hangi Ekrandan
                        p_TXISLEM_NO           in NUMBER        -- ekran islem no,Tablonun Key'i Trand_id
                        ) ;
END;
/
CREATE OR REPLACE PACKAGE BODY PKG_PAR_BOOK_CONTROL Is

  d_bacak_grup clk_paa_screen_group.row_group%TYPE;
  d_kayit_no   number(4);
  d_hes_source VARCHAR2(2000);
  d_sira_no    NUMBER;
  Negatif_Bakiye_olamaz    exception;
------------------------------------------------------------
--  Hata mesajlar�n� gerektiginde loglamak i�in
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
      END;
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
        END;
      END LOOP;
      d_hes_source := d_source;
      BEGIN
      retval := dinamiksql(d_source,'DEGER');
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
       PKG_HATA.hata_yaz(240,TRUE, 'PARAMETRE LISTESI OLUSTURULURKEN HATA:'||SQLERRM);
      END;
    END LOOP;
    RETURN d_parlist;
  EXCEPTION WHEN OTHERS Then
    PKG_HATA.hata_yaz(240,TRUE, 'PARAMETRE LISTESI OLUSTURULAMADI!..'||SQLERRM);
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
      IF pkg_par_book_control.dinamiksql(d_source,'KOSUL')='0' Then
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
      IF pkg_par_book_control.dinamiksql(d_source,'KOSUL')='0' Then
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

    d_TUR                    clk_paa_temporary_control.tur%TYPE;
    d_HESAP_BOLUM_KODU       clk_paa_temporary_control.hesap_bolum_kodu%TYPE;
    d_HESAP_TUR_KODU         clk_paa_temporary_control.hesap_tur_kodu%TYPE;
    d_HESAP_NUMARA           clk_paa_temporary_control.hesap_numara%TYPE;
    d_VALOR_TARIHI           clk_paa_temporary_control.valor_tarihi%TYPE;
    d_LC_TUTAR               clk_paa_temporary_control.lc_tutar%TYPE;
    d_DV_TUTAR               clk_paa_temporary_control.dv_tutar%TYPE;
    d_DOVIZ_KOD              clk_paa_temporary_control.doviz_kod%TYPE;
    d_BANKA_ACIKLAMA         clk_paa_temporary_control.banka_aciklama%TYPE;
    d_MUSTERI_ACIKLAMA       clk_paa_temporary_control.musteri_aciklama%TYPE;
    d_ISTATISTIK_KODU        clk_paa_temporary_control.istatistik_kodu%TYPE;
    d_REFERANS               clk_paa_temporary_control.referans%TYPE;
    d_MUSTERI_HESAP_NUMARA   clk_paa_temporary_control.musteri_hesap_numara%TYPE;
    d_MUSTERI_HESAP_TUR      clk_paa_temporary_control.musteri_hesap_tur%TYPE;
    d_KUR                    clk_paa_temporary_control.kur%TYPE;
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
        ELSIF r.voucher_par_name='VALOR_TARIHI'       Then d_VALOR_TARIHI       := TO_DATE(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id)/* valor tarihini 0009 lu hale getiriyordu MHA 060809,'DD/MM/YYYY'*/);
        ELSIF r.voucher_par_name='LC_TUTAR'           Then d_LC_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DV_TUTAR'           Then d_DV_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DOVIZ_KOD'          Then d_DOVIZ_KOD          := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='KUR'                Then d_kur                := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='ACIKLAMA_BANKA'     Then d_BANKA_ACIKLAMA     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='ACIKLAMA_MUSTERI'   Then d_MUSTERI_ACIKLAMA   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
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
        END;
      END LOOP;

      /* Farkli dillerde aciklama varsa olusturalim MHA 20042011 */
      d_BANKA_ACIKLAMA2 := null;
      d_MUSTERI_ACIKLAMA2 := null;

      For d in fis_desc Loop
        BEGIN
            d_orj_dil := pkg_global.GET_DILKOD;
            pkg_global.SET_DILKOD(d.language_code);
            d_BANKA_ACIKLAMA2 := hesapla(d.bank_desc_type,d.bank_description,p_parlist,p_ekran,p_grup,p_muh_id);
            d_MUSTERI_ACIKLAMA2 := hesapla(d.cust_desc_type,d.cust_description,p_parlist,p_ekran,p_grup,p_muh_id);
            pkg_global.SET_DILKOD(d_orj_dil);
            insert into clk_paa_desc_temporary(dil_kod,banka_aciklama,musteri_aciklama,numara,ekran,grup,muh_id)
            values (d.language_code,d_BANKA_ACIKLAMA2,d_MUSTERI_ACIKLAMA2,d_kayit_no,p_ekran,p_grup,p_MUH_ID);
        EXCEPTION WHEN OTHERS Then
            PKG_HATA.hata_yaz(240,TRUE,'FIS KESMEDE ACIKLAMA OLSUTURMADA HATA... : '||d.group_||'\'||d.book_id||'\'||
                                        d.language_code||'\'||SQLERRM);
        END;
      End Loop; 

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
      Insert Into clk_paa_temporary_control
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
             Insert Into clk_paa_temporary_control
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
               Insert into clk_paa_desc_temporary(dil_kod,banka_aciklama,musteri_aciklama,numara,ekran,grup,muh_id)
               select dil_kod,banka_aciklama,musteri_aciklama,d_kayit_no,ekran,grup,muh_id    
                 from clk_paa_desc_temporary f
                where f.ekran=p_ekran
                  and f.grup =p_grup
                  and f.muh_id=p_muh_id
                  and f.numara=d_kayit_no-1;
            end if;       
       end if;
      EXCEPTION WHEN OTHERS Then
          PKG_HATA.hata_yaz(240,TRUE,'FIS KESMEDE TMP HATA..'||p_GRUP||'..'||p_muh_id);
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
            Select NVL(MAX(numara),0) Into d_sira From clk_paa_temporary_control;
            grup_isle(d_ekran,d_grup,get_parlist(r.screen,r.group_,r.book_id,p_parlist,d_ekran));
            IF r.book_type = 'GRUPTERS' Then
              Select NVL(MAX(Numara),0) Into d_sira2 From clk_paa_temporary_control;
              Update clk_paa_temporary_control A
                Set A.TUR  = DECODE(a.tur,'A','B','B','A')
               Where ekran = d_ekran
                 And grup  = d_grup
                 And numara Between d_sira+1 And d_sira2;
               null;
            END IF;
           END IF;
          END IF;
        EXCEPTION WHEN OTHERS Then
         PKG_HATA.hata_yaz(240,TRUE,'GRUP ISLEMEDE HATA..'||p_ekran||'..'||r.GROUP_||'/'||SQLERRM);
        END;
      END LOOP;
    END IF;
  END;
------------------------------------------------------------
  PROCEDURE Temporary_Olustur (p_ekran In VARCHAR2,
                               p_parlist In parlist) Is
    d_value VARCHAR2(8);
    d_sayi  number;
  BEGIN
    current_parlist := p_parlist;
    Select NVL(MAX(a.numara),0) Into d_kayit_no From clk_paa_temporary_control A;
    For r In (Select * From clk_paa_screen_group Where screen=p_ekran Order By order_) LOOP
    BEGIN
      d_bacak_grup := r.row_group;
      grup_isle(r.screen,r.group_,p_parlist);

      IF r.base_account Is Not Null Then
         d_value := hesapla('HESAP',r.base_account,p_parlist,r.screen,r.group_,0);
          Update clk_paa_temporary_control d
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
    Update clk_paa_temporary_control a
       Set (a.fis_aciklama ,a.fis_iptal_edilebilir,a.fis_force_debit )
          =( Select distinct b.voucher_exp , b.voucher_revocable , b.force_debit
               from clk_paa_SCREEN b
              where b.screen = p_ekran )
     ;
    Select COUNT(*) Into d_sayi
      From clk_paa_process;
    IF d_sayi<>0 Then
      null;
    END IF;
  END;
/***************************************************************************/
  Procedure P_Balans_kontrol Is
   CURSOR c1 Is
     Select v.dv_tutar_alacak-v.dv_tutar_borc,v.doviz_kod
       from (select    case  When substr(a.hesap_numara,1,3)='292' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,3)='294' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,3)='284' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,1) in ('5','6','7','8') Then PKG_GLOBAL.GET_LOCALCUR
                          Else doviz_kod End DOVIZ_KOD,
                 sum(decode(a.tur, 'A', nvl(a.dv_tutar, 0), 0)) dv_tutar_alacak,
                 sum(decode(a.tur, 'B', nvl(dv_tutar, 0), 0)) dv_tutar_borc
            from clk_paa_temporary_control a
           where a.hesap_tur_kodu = 'DK'
           group by case  When substr(a.hesap_numara,1,3)='292' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,3)='294' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,3)='284' Then PKG_GLOBAL.GET_LOCALCUR
                          When substr(a.hesap_numara,1,1) in ('5','6','7','8') Then PKG_GLOBAL.GET_LOCALCUR
                          Else doviz_kod End) v
     Where v.dv_tutar_alacak-v.dv_tutar_borc != 0
     ;

         
   ddov       number;
   dtl        number;
   ddoviz_kod varchar2(10);
  Begin
       Select SUM(DECODE(a.tur,'B',-a.dv_tutar,a.dv_tutar)) ddov ,
              SUM(DECODE(a.tur,'B',-a.lc_tutar,a.lc_tutar)) dtl
         INTO ddov,dtl
         FROM clk_paa_temporary_control a
        Where a.hesap_tur_kodu = 'DK' 
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
  End; 
/*****************************************************************************************/
--- ANA FONKSIYON...
  PROCEDURE  FIS_YARAT (p_ekran                in varchar2,
                        p_TXISLEM_NO           in NUMBER
                        )   IS

    cursor c is
      /*select distinct field,type_,a.field_name
        from v_clk_paa_group_parameters a*/
      Select upper(a.field) as field, upper(a.type_)  as type_ ,upper(a.par_name)  as field_name
        from clk_paa_screen_fields a
       where screen=p_ekran
       order by length(field) desc
       ;
    d_parlist pkg_par_book_control.parlist;
    i         number:=0;
    d_parametre_adet number;
    d_tabloadi       varchar2(30);

  begin
    Begin
     Select Distinct a.prompt
       Into d_tabloadi
       FROM clk_paa_screen_fields a
       Where a.screen   = p_ekran
     ;
      exception
        when too_many_rows then
           Null;   -- Tum hesaplar muhasebeli degil
        when no_data_found then
           Null;   -- Tum hesaplar muhasebeli degil
    End;    -- Tablodan dinamik parametre cek
   IF d_tabloadi is not null Then -- Par muh tanımı var
        delete from clk_paa_temporary_control; /* giriste temporary tablomuzu temizliyoruz MHA 221009*/
        delete from clk_paa_desc_temporary_control;
        
         pkg_par_acctselect.init(d_tabloadi,' WHERE TX_NO = '||p_TXISLEM_NO);
        --  parametre listesini olustur ...
        select count(field)
          into d_parametre_adet
          from clk_paa_screen_fields
         where screen=p_ekran
         ;
        d_parlist := pkg_par_book_control.parlist(null);
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
          pkg_par_book_control.Temporary_olustur(p_ekran   => p_ekran,     -- clk_paa_temporary_control Olustu
                                                 p_parlist => d_parlist );
        END LOOP;
  			Pkg_Par_Acctselect.closeCursor ;
      if p_ekran not in ('5202','8001','8002') then
         P_balans_kontrol;
      end if;   
        KONTROLLERI_YAP; /* pkg_tx'ten buraya tasidim MHA 081009 */
    END IF;
   /* exception when others then
           PKG_HATA.hata_yaz(243,TRUE,SQLERRM);*/
   End;
--------------------------------------------------------------------   
-- ***--  İşlemin giriş anında muhasebe kontrollerini yapması için
--------------------------------------------------------------------
  Procedure KONTROLLERI_YAP IS
   Cursor c1 is
     SELECT * 
       FROM clk_paa_temporary_control a
      WHERE a.hesap_tur_kodu != 'DK'
     ;
     s1  c1%ROWTYPE;
    ln_hareket_kodu  number(2);
    ls_b_a           varchar2(2);
    vn_musteri_no number;
    vn_islem_no number;
    vc_mustur   varchar2(10);
    
    cursor c_ortak is
     select g.ortaklik_turu
       from gnl_musteri_ortaklik g
      where g.musteri_no = vn_musteri_no;
    
    vn_orttur number;  
  Begin
     
    OPEN c1;
    LOOP
      FETCH c1 INTO s1;
      Exit When c1%NOTFOUND;
      
       If s1.hesap_tur_kodu != 'DK' Then       -- Müşteri hesapları için kontrol
        ls_b_a           := s1.tur;
        --ln_hareket_kodu  := PKG_TABLO.hesap_kayit_izleme(s1.hesap_numara).hesap_hareket_kodu;
         begin 
          select t.hesap_hareket_kodu,t.musteri_no,g.musteri_tur_kod
            into ln_hareket_kodu,vn_musteri_no,vc_mustur
            from v_muh_hesap_izleme_tum t,gnl_musteri g
            where t.hesap_no =to_number(s1.hesap_numara)
              and g.musteri_no=t.musteri_no;
         exception when no_data_found then
           pkg_hata.hata_yaz(2,true,'V_MUH_HESAP_IZLEME_TUM',s1.hesap_numara);    
         end;     
         
         if pkg_global.Get_KanalKod!='1' then
            /* Müşterek ortaklara Şube dışında işlem yapılamaz */
            if vc_mustur = 'O' then
               open c_ortak;
               Fetch c_ortak into vn_orttur;
               close c_ortak;
               
               if vn_orttur = 1 then
                  pkg_hata.hata_yaz(5863,true);
               end if;
            end if;       
         end if;    
         
         begin
            vn_islem_no := trim(replace(s1.ekran,'TRN'));
         exception when value_error then
           null;
         end;     
                        -- Hesap hareket kodları kontrolü
         If ln_hareket_kodu = 2 And ls_b_a = 'B' Then
            if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_no) = 'E' then
               PKG_HATA.hata_yaz (273,TRUE,s1.hesap_numara);
            end if;   
         ElsIf ln_hareket_kodu = 3 And ls_b_a = 'A' Then
            PKG_HATA.hata_yaz (274,TRUE,s1.hesap_numara);
         ElsIf ln_hareket_kodu = 4 Then
            --if not (ls_b_a='B' and pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_no) = 'H') then
            if pkg_trn1072.hareket_kod_kontrol_edilsin_mi(vn_musteri_no,vn_islem_no) = 'E' then  
                PKG_HATA.hata_yaz (275,TRUE,s1.hesap_numara);            
            end if;    
         End if;         
                        -- Hesap Hacizlimi kontrolü
         If PKG_HESAP.Hesap_hacizli_mi(s1.hesap_numara) = 'E' Then 
            PKG_HATA.hata_yaz (940,TRUE,s1.hesap_numara);
         End if;         

       else                                     -- D/K hesapları için kontrol
          Null;
       End if;


    END LOOP;
    CLOSE C1;
    DELETE FROM clk_paa_temporary_control;    -- Commite gerek kalmadan temizlensin
    delete from clk_paa_desc_temporary_control;
  End ;


--
Begin
 null;
END;
/
