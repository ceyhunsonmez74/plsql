CREATE OR REPLACE PACKAGE PKG_PAR_BOOK_TX IS
  TYPE parlist IS TABLE OF clk_pa_parlist%ROWTYPE;
  current_parlist parlist;
  IptalBayrak boolean;
  d_test  varchar2(1) := 'E';

  procedure muhasebe(pn_tx_no in number,
                     p_ekran in varchar2,
                     p_glb_sube in number,
                     p_parlist in parlist);

  function dinamiksql(p_dinamik in varchar2,
                      p_islem in varchar2) return varchar2;

  function f_curr_par return parlist;

  procedure setIptalBayrak(p_bayrak in boolean);
  function  getIptalBayrak return boolean;

  procedure muhasebe_fissil(p_i_sube_kod in number,
                            p_isl_tar in date,
                            p_ref_kod in varchar2,
                            p_isl_ref in number,
                            p_control in number DEFAULT 0);

  function pm_fis_goster return boolean;

  --current_parlist den ilgili parametreyi dondurur...
  function getfromlist(p_par_name in varchar2) return varchar2;

END;
/
CREATE OR REPLACE PACKAGE BODY PKG_PAR_BOOK_TX Is
d_bacak_grup clk_pa_screen_group.row_group%TYPE;
  d_kayit_no   number(4);
  d_hes_source VARCHAR2(2000);
  d_sira_no    NUMBER;
--
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
       raise_application_error(-20001,substr(
                               p_EKRAN||'-'||
                               p_GRUP||'-'||
                               p_GRUP_KOSUL_ID||'-'||
                               p_MUH_ID||'-'||
                               p_MUH_KOSUL_ID||'  ***  '||
                               p_HATA||'  ***  '||
                               p_IFADE,1,100));
    else
      d_sira_no := NVL(d_sira_no,0)+1;
      IF INSTR(p_HATA,'20001')>0 Then
--        v_mesaj := GLOBAL.getstdhata;
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
      Insert Into clk_pa_process
        (SCREEN,  GROUP_,            GROUP_ID,
         BOOK_ID, BOOK_COND_ID,      ERROR,
         STATEMENT_, ERROR_NO,       ORDER_NO   )
        Values
        (p_EKRAN, p_GRUP, p_GRUP_KOSUL_ID,
         p_MUH_ID, p_MUH_KOSUL_ID,
         substr(d_HATA,1,300),p_IFADE,p_HATA_NO,d_sira_no);
    end if;

  END;


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

  FUNCTION Formatla(p_tip In VARCHAR2,
                    p_deger In VARCHAR2
                    ) RETURN VARCHAR2 Is
    d_value  VARCHAR2(2000);
  BEGIN
    --dinamik sql de kulanabilmek icin gerekli de?i?iklikler yap?l?yor...
    IF UPPER(p_tip)='NUMBER' Then
      d_value := TRANSLATE(NVL(p_deger,'null'),',.','..');
    ELSIF UPPER(p_tip)='VARCHAR2' Then
      --d_value := ''''||p_deger||'''';
      d_value := ''''||Replace(p_deger,'''','''''')||'''';
    ELSIF UPPER(p_tip)='DATE' Then
      IF p_deger Is Null Then d_value := 'null';
      Else
        d_value := 'to_date('||''''||TO_CHAR(TO_DATE(p_deger,'DD/MM/YYYY'),'DD/MM/YYYY')||''''||',''DD/MM/YYYY'')';
      END IF;
      --d_value := nvl(''''||to_date(p_deger,'DD/MM/YYYY')||'''','null');
    END IF;
    RETURN d_value;
  END;

  FUNCTION listeden_al(p_par_name In VARCHAR2,
                       p_parlist In parlist)
                       RETURN VARCHAR2 Is
    i NUMBER;
    d_number NUMBER := 9.99;
  BEGIN
    --parametre listesindeki ilgili alan? bulur ve dondurur...
    For i In p_parlist.FIRST..p_parlist.LAST LOOP
      IF p_parlist(i).par_name = p_par_name Then
        IF p_parlist(i).par_type='NUMBER' And INSTR(TO_CHAR(d_number),',')=0 Then
           --return formatla(p_parlist(i).par_type,p_parlist(i).par_value);
           RETURN Replace(p_parlist(i).par_value,',','.');
        Else
           RETURN p_parlist(i).par_value;
        END IF;
      END IF;
    END LOOP;
    RETURN Null;
  END;

  FUNCTION hesapla(p_fis_source_type clk_pa_screen_group_book_vouc.voucher_source_type%TYPE,
                   p_fis_source      clk_pa_screen_group_book_vouc.voucher_source%TYPE,
                   p_parlist         parlist,
                   p_ekran   In VARCHAR2, --sadece hata takibi icin
                   p_grup    In VARCHAR2, --sadece hata takibi icin
                   p_muh_id  In VARCHAR2)  --sadece hata takibi icin
                   RETURN VARCHAR2 Is
    retval VARCHAR2(2000);
    i NUMBER :=0;
    d_source VARCHAR2(2000);
  BEGIN
    --600
    --kaynakta belirtilen i?leme gore sonuc hesaplar ve dondurur...
    d_hes_source := Null;
    IF    p_fis_source_type='EKRAN' Then
      BEGIN
      retval := listeden_al(p_fis_source,p_parlist);
      EXCEPTION WHEN OTHERS Then
        hata_yaz(602,SQLERRM,'PARLISTTEN ALIRKEN HATA:'||p_fis_source_type||'\'||p_fis_source,
                 p_EKRAN,p_GRUP,Null,p_MUH_ID);
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
          hata_yaz(603,SQLERRM,p_fis_source_type||'\'||p_fis_source||'\'||CHR(13)||CHR(10)||
                               p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                               p_EKRAN,p_GRUP,Null,p_MUH_ID);
        END;
      END LOOP;
      d_hes_source := d_source;
      BEGIN
      retval := pkg_par_book_tx.dinamiksql(d_source,'DEGER');
      EXCEPTION WHEN OTHERS Then
        hata_yaz(604,SQLERRM,'DINAMIK SQLDE HATA:'||CHR(13)||CHR(10)||d_source,p_EKRAN,p_GRUP,Null,p_MUH_ID);
      END;
    END IF;
    RETURN retval;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(601,SQLERRM,'HESAPLA PROSEDURUNDE HATA.:'||CHR(13)||CHR(10)||p_fis_source_type||'\'||p_fis_source,
             p_EKRAN,p_GRUP,Null,p_MUH_ID);
  END;

  FUNCTION get_parlist(pn_tx_no  In Number,
                       p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_muh_id  In VARCHAR2,
                       p_parlist In parlist,
                       p_cag_ekran In VARCHAR2)
                       RETURN parlist Is
    CURSOR c Is
      Select voucher_par_name,voucher_source_type,voucher_source
        From parmuh_screen_group_book_vc_tx
       Where tx_no = pn_tx_no
         And screen   = p_ekran
         And group_   = p_grup
         And book_id = p_muh_id
       Order By LENGTH(voucher_par_name) Desc;
    d_parlist parlist;
    i NUMBER:=0;
    d_parametre_adet NUMBER;
    d_ara  clk_pa_screen_fields.type_%TYPE;
  BEGIN
    --500
    --Ca?r?lan alt grubun kullanaca?? parametre listesini ca??ran grubun parametre listesinden
    --yararlanarak olu?turur...
    Select COUNT(*) Into d_parametre_adet
      From parmuh_screen_group_book_vc_tx
     Where tx_no = pn_tx_no
       And screen  = p_ekran
       And group_   = p_grup
       And book_id = p_muh_id;
    d_parlist := parlist(Null);
    d_parlist.EXTEND(d_parametre_adet);
    For r In c LOOP
      BEGIN
      i := i+1;
      d_parlist(i).par_name  := r.voucher_par_name;
      d_parlist(i).par_value := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_EKRAN,p_GRUP,p_MUH_ID);
      Select type_ Into d_ara From parmuh_screen_fields_tx
       Where tx_no=pn_tx_no and  par_name=r.voucher_par_name And screen=p_cag_ekran;
      d_parlist(i).par_type := d_ara;
      EXCEPTION WHEN OTHERS Then
        hata_yaz(502,SQLERRM,'PARAMETRE LISTESI OLUSTURULURKEN HATA:'||
                             r.voucher_par_name||'\'||r.voucher_source_type||CHR(13)||CHR(10)||r.voucher_source||CHR(13)||CHR(10)||p_cag_ekran,
                             p_EKRAN,p_GRUP,Null,p_MUH_ID);
      END;
    END LOOP;
    RETURN d_parlist;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(501,SQLERRM,'PARAMETRE LISTESI OLUSTURULAMADI!',
             p_EKRAN,p_GRUP,Null,p_MUH_ID);
  END;

  FUNCTION kosul_uygun(pn_tx_no in number,
                       p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_parlist In parlist)
                       RETURN BOOLEAN Is
    CURSOR c Is
      Select *
         From parmuh_screen_group_cond_tx
        Where tx_no = pn_tx_no
          And screen=p_ekran
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
          hata_yaz(352,SQLERRM,'GRUP KO?ULLARINDA PARAMETRE YERLESTIRIKEN HATA.'||CHR(13)||CHR(10)||p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                   p_EKRAN,p_GRUP);
        END;
      END LOOP;
      BEGIN
      IF pkg_par_book_tx.dinamiksql(d_source,'KOSUL')='0' Then
        RETURN FALSE;
      END IF;
      EXCEPTION WHEN OTHERS Then
        hata_yaz(353,SQLERRM,'GRUP KO?ULLARI DINAMIK SQLDE HATA.'||CHR(13)||CHR(10)||r.cond||CHR(13)||CHR(10)||d_source,
                 p_EKRAN,p_GRUP,r.cond_id);
      END;
    END LOOP;
    RETURN TRUE;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(351,SQLERRM,'GRUP KO?ULLARINDA HATA.',
             p_EKRAN,p_GRUP);
  END;

  FUNCTION kosul_uygun(pn_tx_no in number,
                       p_ekran   In VARCHAR2,
                       p_grup    In VARCHAR2,
                       p_muh_id  In VARCHAR2,
                       p_parlist In parlist)
                       RETURN BOOLEAN Is
    CURSOR c Is
      Select *
         From parmuh_screen_group_book_cn_tx
        Where tx_no=pn_tx_no
          And screen=p_ekran
          And group_=p_grup
          And book_id=p_muh_id
          And cond Is Not Null
        Order By cond_id;
    d_source VARCHAR2(2000);
  BEGIN
    --300
    --grup muhasebe bile?en ko?ullar?n? kontrol eder.
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
          hata_yaz(302,SQLERRM,'B?LE?EN KO?ULLARINDA PARAMETRE YERLE?T?R?RKEN HATA.'||CHR(13)||CHR(10)||p_parlist(i).par_name||'\'||p_parlist(i).par_type||'\'||p_parlist(i).par_value,
                   p_EKRAN,p_GRUP,Null,p_muh_id,r.cond_id);
        END;
      END LOOP;
      BEGIN
      IF pkg_par_book_tx.dinamiksql(d_source,'KOSUL')='0' Then
        RETURN FALSE;
      END IF;
      EXCEPTION WHEN OTHERS Then
        hata_yaz(303,SQLERRM,'B?LE?EN KO?ULLARI DINAMIK SQLDE HATA.'||CHR(13)||CHR(10)||r.cond||CHR(13)||CHR(10)||d_source,
                 p_EKRAN,p_GRUP,Null,p_muh_id,r.cond_id);
      END;
    END LOOP;
    RETURN TRUE;
  EXCEPTION WHEN OTHERS Then
    hata_yaz(301,SQLERRM,'B?LE?EN KO?ULLARINDA HATA.',
             p_EKRAN,p_GRUP,p_muh_id);
  END;

  PROCEDURE grup_ekle(pn_tx_no in number,
                      p_ekran   In VARCHAR2,
                      p_grup    In VARCHAR2) IS
    vn_adet number;                  
  Begin
       select count(*)
         into vn_Adet 
         from parmuh_screen_group_book_vc_tx d
        where d.tx_no=pn_tx_no
          and d.screen=p_ekran
          and d.group_=p_grup; 

       if vn_adet = 0 then
         
             insert into bnspr.parmuh_screen_group_tx(tx_no,screen,group_,exp,order_,row_group,base_account)     
             select pn_tx_no,screen,group_,exp,order_,row_group,base_account
               from CLK_PA_SCREEN_GROUP
              where screen = p_ekran
                and group_ = p_grup; 
               
             insert into BNSPR.Parmuh_Screen_Group_Cond_Tx(TX_NO,SCREEN,GROUP_,COND_ID,COND)
             select pn_tx_no,SCREEN,GROUP_,COND_ID,COND
               from bnspr.clk_pa_screen_group_cond d
              where d.screen=p_ekran
                and d.group_=p_grup;  
                
             insert into BNSPR.parmuh_screen_group_book_tx(TX_NO,SCREEN,GROUP_,BOOK_ID,BOOK_TYPE,BOOK_NAME) 
             select pn_tx_no, SCREEN,GROUP_,BOOK_ID,BOOK_TYPE,BOOK_NAME
               from bnspr.clk_pa_screen_group_book
              where screen=p_ekran
                and group_=p_grup;  
             
             insert into BNSPR.Parmuh_Screen_Group_Book_Cn_Tx(TX_NO,SCREEN,GROUP_,BOOK_ID,COND_ID,COND) 
             select pn_tx_no, SCREEN,GROUP_,BOOK_ID,COND_ID,COND
               from bnspr.clk_pa_screen_group_book_cond
              where screen=p_ekran
                and group_=p_grup;
                
             insert into BNSPR.Parmuh_Screen_Group_Book_Vc_Tx(TX_NO,SCREEN,GROUP_,BOOK_ID,VOUCHER_PAR_NAME,VOUCHER_SOURCE_TYPE,VOUCHER_SOURCE,VOUCHER_ORDER) 
             select pn_tx_no, SCREEN,GROUP_,BOOK_ID,VOUCHER_PAR_NAME,VOUCHER_SOURCE_TYPE,VOUCHER_SOURCE,VOUCHER_ORDER
               from bnspr.clk_pa_screen_group_book_vouc
              where screen=p_ekran
                and group_=p_grup;
                
             insert into bnspr.parmuh_screen_fields_tx(tx_no,screen,field,prompt,par_name,type_,test_val)
             select pn_tx_no,screen,field,prompt,par_name,type_,test_val
               from CLK_PA_SCREEN_FIELDS     
              where screen = p_ekran; 
        end if;        

  
  End grup_ekle;                      
                      
  PROCEDURE fis_kes(pn_tx_no  In Number,
                    p_ekran   In VARCHAR2,
                    p_grup    In VARCHAR2,
                    p_muh_id  In VARCHAR2,
                    p_parlist In parlist) Is
    CURSOR c Is
      Select *
        From parmuh_screen_group_book_vc_tx
       Where tx_no=pn_tx_no
         And screen=p_ekran
         And group_=p_grup
         And book_id=p_muh_id
         And voucher_source Is Not Null
       Order By voucher_order;

    d_TUR                    clk_pa_temporary.tur%TYPE;
    d_HESAP_BOLUM_KODU       clk_pa_temporary.hesap_bolum_kodu%TYPE;
    d_HESAP_TUR_KODU         clk_pa_temporary.hesap_tur_kodu%TYPE;
    d_HESAP_NUMARA           clk_pa_temporary.hesap_numara%TYPE;
    d_VALOR_TARIHI           clk_pa_temporary.valor_tarihi%TYPE;
    d_LC_TUTAR               clk_pa_temporary.lc_tutar%TYPE;
    d_DV_TUTAR               clk_pa_temporary.dv_tutar%TYPE;
    d_DOVIZ_KOD              clk_pa_temporary.doviz_kod%TYPE;
    d_BANKA_ACIKLAMA         clk_pa_temporary.banka_aciklama%TYPE;
    d_MUSTERI_ACIKLAMA       clk_pa_temporary.musteri_aciklama%TYPE;
    d_ISTATISTIK_KODU        clk_pa_temporary.istatistik_kodu%TYPE;
    d_REFERANS               clk_pa_temporary.referans%TYPE;
    d_MUSTERI_HESAP_NUMARA   clk_pa_temporary.musteri_hesap_numara%TYPE;
    d_MUSTERI_HESAP_TUR      clk_pa_temporary.musteri_hesap_tur%TYPE;
    d_KUR                    clk_pa_temporary.kur%TYPE;
    d_bacak_grup             clk_pa_temporary.bacak_grubu%TYPE;
    d_temel_hesap            clk_pa_temporary.temel_hesap%TYPE;
    d_KASA_NAKIT_KOD         clk_pa_temporary.kasa_nakit_kod%TYPE;




  BEGIN

    IF kosul_uygun(pn_tx_no,p_ekran,p_grup,p_muh_id,p_parlist) Then
      d_kayit_no := NVL(d_kayit_no,0)+1;
      For r In c LOOP
        BEGIN
        IF    r.voucher_par_name='B_A'                Then d_TUR        := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_SUBE_KODU'    Then d_HESAP_BOLUM_KODU   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_TUR_KODU'     Then d_HESAP_TUR_KODU     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='HESAP_NUMARA'       Then d_HESAP_NUMARA       := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='VALOR_TARIHI'       Then d_VALOR_TARIHI       := TO_DATE(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id),'DD/MM/YYYY');
        ELSIF r.voucher_par_name='LC_TUTAR'           Then d_LC_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DV_TUTAR'           Then d_DV_TUTAR           := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='DOVIZ_KOD'          Then d_DOVIZ_KOD          := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='KUR'                Then d_kur        := TO_NUMBER(hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id));
        ELSIF r.voucher_par_name='ACIKLAMA_BANKA'     Then d_BANKA_ACIKLAMA     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='ACIKLAMA_MUSTERI'   Then d_MUSTERI_ACIKLAMA   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='MUSTERI_HESAP_NUMARA' Then d_MUSTERI_HESAP_NUMARA   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='MUSTERI_HESAP_TUR'    Then d_MUSTERI_HESAP_TUR   := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='ISTATISTIK_KODU'    Then d_ISTATISTIK_KODU    := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='REFERANS'           Then d_REFERANS           := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='KASA_NAKIT_KOD'     Then d_KASA_NAKIT_KOD     := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='BACAK_GRUBU'        Then d_BACAK_GRUP         := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        ELSIF r.voucher_par_name='TEMEL_HESAP'        Then d_TEMEL_HESAP        := hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id);
        END IF;

        EXCEPTION WHEN OTHERS Then
          hata_yaz(401,SQLERRM,'FIS KESMEDE HATA.'||CHR(13)||CHR(10)||r.voucher_par_name||'\'||r.voucher_source_type||CHR(13)||CHR(10)||r.voucher_source||CHR(13)||CHR(10)||
          d_hes_source||'---'||hesapla(r.voucher_source_type,r.voucher_source,p_parlist,p_ekran,p_grup,p_muh_id),
                   p_EKRAN,p_GRUP,Null,p_muh_id);
        END;
      END LOOP;
      -- valor tarihi ayari
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

      BEGIN
      Insert Into clk_pa_TEMPORARY
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
      EXCEPTION WHEN OTHERS Then
          hata_yaz(402,SQLERRM,'F?? KESMEDE TEMP TABLODA HATA.',
                   p_EKRAN,p_GRUP,Null,p_muh_id);
      END;

    END IF;
  END;

  PROCEDURE grup_isle(pn_tx_no in number,
                      p_ekran   In VARCHAR2,
                      p_grup    In VARCHAR2,
                      p_parlist In parlist) Is
    CURSOR c Is
      Select *
        From parmuh_screen_group_book_tx
       Where tx_no=pn_tx_no
         and screen=p_ekran
         And group_ =p_grup
       Order By book_id;
    d_ekran VARCHAR2(10);
    d_grup VARCHAR2(10);
    d_sira NUMBER;
    d_sira2 NUMBER;
  BEGIN
    --200
     IF kosul_uygun(pn_tx_no,p_ekran,p_grup,p_parlist) Then
      For r In c LOOP
        BEGIN
          IF r.book_type='FIS' Then
            fis_kes(r.tx_no,r.screen,r.group_,r.book_id,p_parlist);
          ELSIF r.book_type In ('GRUP','GRUPTERS') Then
           IF  kosul_uygun(pn_tx_no,p_ekran,p_grup,r.book_id,p_parlist) Then
            d_ekran := SUBSTR(r.BOOK_NAME,1,INSTR(r.BOOK_NAME,'.')-1);
            d_grup  := SUBSTR(r.BOOK_NAME,INSTR(r.BOOK_NAME,'.')+1);
            Select NVL(MAX(numara),0) Into d_sira From CLK_PA_TEMPORARY;
            grup_ekle(pn_tx_no, d_ekran, d_grup);
            grup_isle(pn_tx_no,d_ekran,d_grup,get_parlist(r.tx_no,r.screen,r.group_,r.book_id,p_parlist,d_ekran));
            IF r.book_type = 'GRUPTERS' Then
              Select NVL(MAX(Numara),0) Into d_sira2 From CLK_PA_TEMPORARY;
              Update CLK_PA_TEMPORARY A
                Set A.TUR  = DECODE(a.tur,'A','B','B','A')
               Where ekran = d_ekran
                 And grup  = d_grup
                 And numara Between d_sira+1 And d_sira2;
               null;
            END IF;
           END IF;
          END IF;
        EXCEPTION WHEN OTHERS Then
          hata_yaz(201,SQLERRM,'GRUP ??LEMEDE HATA.',
                   p_ekran,r.GROUP_,Null,r.BOOK_ID);
        END;
      END LOOP;
    END IF;
  END;

  PROCEDURE muhasebe(pn_tx_no in number,
                     p_ekran In VARCHAR2,
                     p_glb_sube In NUMBER,
                     p_parlist In parlist) Is
    d_value VARCHAR2(8);
  BEGIN
    --100
    current_parlist := p_parlist;
    Select NVL(MAX(a.numara),0) Into d_kayit_no From CLK_PA_TEMPORARY A;
    For r In (Select * From parmuh_screen_group_tx Where tx_no= pn_tx_no and screen=p_ekran Order By order_) LOOP
    BEGIN
      d_bacak_grup := r.row_group;
      grup_isle(r.tx_no,r.screen,r.group_,p_parlist);
/*
      IF r.base_account Is Not Null Then
         d_value := hesapla('HESAP',r.base_account,p_parlist,r.screen,r.group_,0);
         Update CLK_PA_TEMPORARY Set temel_hesap=d_value
          Where ekran=r.screen And grup=r.group_;
      END IF;
*/
    EXCEPTION WHEN OTHERS Then
      hata_yaz(101,SQLERRM,'MUHASEBEDE HATA.',
               p_ekran,r.GROUP_);
    END;
    END LOOP;
  -- fis bazinda degiskenler atanir
    Update CLK_PA_TEMPORARY a
       Set (a.fis_aciklama,a.fis_tur,a.fis_iptal_edilebilir,a.fis_force_debit )
          =( Select distinct b.voucher_exp , b.voucher_type , b.voucher_revocable , b.force_debit
               from CLK_PA_SCREEN b
              where b.screen = p_ekran )
     ;
  END;

  FUNCTION f_curr_par RETURN parlist Is
  BEGIN
    -- current_parlist muhasebe proseduru ca?r?ld???nda kullan?lan parametre listesi ile set ediliyor...
    RETURN current_parlist;
  END;

  PROCEDURE setIptalBayrak(p_bayrak In BOOLEAN) Is
  BEGIN
    IptalBayrak := p_bayrak;
  END;

  FUNCTION getIptalBayrak RETURN BOOLEAN Is
  BEGIN
    RETURN IptalBayrak;
  END;

  PROCEDURE muhasebe_fissil(p_i_sube_kod In NUMBER,
                            p_isl_tar In DATE,
                            p_ref_kod In VARCHAR2,
                            p_isl_ref In NUMBER,
                            p_control In NUMBER Default 0) Is
    d_errno NUMBER;
  BEGIN
/*
       M2_Fis.fis_sil(p_i_sube_kod,
                      p_isl_tar,
                      p_ref_kod,
                      p_isl_ref,
                      'S',
                      d_errno,
                      Null,
                      p_control);
       IF d_errno != 0 Then
          ROLLBACK;
          M2_Genel.hata_yaz(d_errno,Null,Null,Null,'E');
       END IF;
*/  null;
  END muhasebe_fissil;

  FUNCTION pm_fis_goster RETURN BOOLEAN Is
    d_goster Varchar2(6);
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

  FUNCTION getfromlist(p_par_name In VARCHAR2) RETURN VARCHAR2 Is
  BEGIN
    RETURN listeden_al(p_par_name,current_parlist);
  END;

END;
/
