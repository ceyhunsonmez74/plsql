create or replace package PKG_PAR_util is


  function f_long_to_char(p_sira in number) RETURN varchar2;

  procedure exportPM(p_ekran in varchar2);
  procedure exportPM_TO_FILE(p_ekran in varchar2,p_file in varchar2 default null);
  procedure exportALL;

  procedure deletePM(p_ekran in varchar2);
  procedure deletePMO(p_ekran in varchar2);
  procedure copyPM(p_eski_screen in varchar2,p_yeni_screen in varchar2);
  procedure renamePM(p_eski_ekran in varchar2,p_yeni_ekran in varchar2);
  procedure PMO_to_PM(p_ekran in varchar2);

  --pmo_process tablosunun iceri?ini dosyaya almak icin...
  procedure errors_to_file(p_file in varchar2);
  --parametre listesini pm_ekran_fields update eder.PMMUH da test etmek icin
  procedure update_pm_test_parameters(p_ekran in varchar2);
  --pmo_temporary tablosunu pm_temporary_backup tablosuna atar...
  procedure backup_temporary_table;
  procedure CopyPM_group_to_group(p_ekran in varchar2,p_fromgrup in varchar2 ,p_togrup in varchar2 ) ;

  procedure fullExport(p_ekran in varchar2);
  procedure fisAciklamaExport(p_ekran in varchar2);
  procedure fisAciklamafullExport;
end;

/*
create global temporary table CLK_PA_UTIL_INSERTS
(
  SIRA  NUMBER,
  IFADE long
)
on commit delete rows
;

create or replace view v_PM_UTIL_INSERTS as
select sira,  pm_util.f_long_to_char(sira) ifade
from PM_UTIL_INSERTS;
*/
/
create or replace package body PKG_PAR_UTIL is
  d_sira number;
  function f_long_to_char(p_sira in number) RETURN varchar2 IS
     long_var LONG;
     BEGIN
        SELECT ifade INTO long_var
        FROM clk_pa_UTIL_INSERTS
        WHERE sira=p_sira;
        return long_var;
     END;

  procedure p_insert(p_tablo in varchar2,p_rowid rowid) is
    d_insert long;--varchar2(2000);
    d_select long;--varchar2(2000);
    d_dinamik long;--varchar2(2000);
    cursor c is
      select * from user_tab_columns
      where table_name=UPPER(p_tablo)
      order by column_id;
  begin
     if d_sira is null then
       d_sira :=0;
     end if;
     d_sira := d_sira+1;
     d_insert := 'insert into BNSPR.'||UPPER(p_tablo)||'(';--replace(UPPER(p_tablo),'CLK_PAA','CLK_PA')||'('; Replace bizi bozdu MHA 021208
     for r in c loop
       d_insert := d_insert||r.column_name||',';
       if r.data_type in ('CHAR','VARCHAR2') then
         d_select := d_select||'''^##^''||'||r.column_name||'||''^##^''';
       elsif r.data_type ='DATE' then
         d_select := d_select||'''^#D#^''||'||'nvl(to_char('||r.column_name||',''DD/MM/YYYY''),'||''''||'null'||''''||')'||'||''^#D2#^''';
       else
         d_select := d_select||'nvl(to_char('||r.column_name||'),'||''''||'null'||''''||')';
       end if;
       d_select := d_select||'||'||''''||','||''''||'||';
     end loop;
     d_insert := substr(d_insert,1,length(d_insert)-1)||') values(';
     d_select := substr(d_select,1,length(d_select)-7);
--     insert into ornek_inserts values (2,d_select);
--     dbms_output.put_line(d_select);
     execute immediate 'select '||d_select||' from '||p_tablo||' where rowid='||''''||p_rowid||'''' into d_dinamik;
     d_dinamik := replace(d_dinamik,'''','''''');
     d_dinamik := replace(d_dinamik,'^##^','''');
     d_dinamik := replace(d_dinamik,'^#D#^','to_date(''');
     d_dinamik := replace(d_dinamik,'^#D2#^',''',''DD/MM/YYYY'')');
     insert into clk_pa_UTIL_INSERTS values (d_sira,d_insert||d_dinamik||');');
  end;

  procedure exportPM(p_ekran in varchar2) is
    cursor c1 is select rowid from clk_pa_screen where screen=p_ekran;
    cursor c2 is select rowid from clk_pa_screen_fields where screen=p_ekran;
    cursor c3 is select rowid from clk_pa_screen_group where screen=p_ekran order by order_;
    cursor c4 is select rowid from clk_pa_screen_group_cond where screen=p_ekran order by group_,cond_id;
    cursor c5 is select rowid from clk_pa_screen_group_book where screen=p_ekran order by group_,book_id;
    cursor c6 is select rowid from clk_pa_screen_group_book_cond where screen=p_ekran order by group_,book_id,cond_id;
    cursor c7 is select rowid from clk_pa_screen_group_book_vouc where screen=p_ekran order by group_,book_id,voucher_order;
  begin
    delete from clk_pa_UTIL_INSERTS;
    insert into clk_pa_UTIL_INSERTS values (1,'delete from BNSPR.clk_pa_screen_GROUP_BOOK_VOUC where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (2,'delete from BNSPR.clk_pa_screen_GROUP_BOOK_COND where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (3,'delete from BNSPR.clk_pa_screen_GROUP_BOOK where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (4,'delete from BNSPR.clk_pa_screen_GROUP_COND where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (5,'delete from BNSPR.clk_pa_screen_GROUP where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (6,'delete from BNSPR.clk_pa_screen_FIELDS where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (7,'delete from BNSPR.clk_pa_SCREEN where screen='''||p_ekran||''';');
    d_sira := 7;
    for r in c1 loop p_insert('clk_pa_SCREEN',r.rowid);end loop;
    for r in c2 loop p_insert('clk_pa_screen_FIELDS',r.rowid);end loop;
    for r in c3 loop p_insert('clk_pa_screen_GROUP',r.rowid);end loop;
    for r in c4 loop p_insert('clk_pa_screen_GROUP_COND',r.rowid);end loop;
    for r in c5 loop p_insert('clk_pa_screen_GROUP_BOOK',r.rowid);end loop;
    for r in c6 loop p_insert('clk_pa_screen_GROUP_BOOK_COND',r.rowid);end loop;
    for r in c7 loop p_insert('clk_pa_screen_GROUP_BOOK_VOUC',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'commit;');
  end;

  procedure exportPMO(p_ekran in varchar2) is
    cursor c1 is select rowid from clk_paa_screen where screen=p_ekran;
    cursor c2 is select rowid from clk_paa_screen_fields where screen=p_ekran;
    cursor c3 is select rowid from clk_paa_screen_group where screen=p_ekran order by order_;
    cursor c4 is select rowid from clk_paa_screen_group_cond where screen=p_ekran order by group_,cond_id;
    cursor c5 is select rowid from clk_paa_screen_group_book where screen=p_ekran order by group_,book_id;
    cursor c6 is select rowid from clk_paa_screen_group_book_cond where screen=p_ekran order by group_,book_id,cond_id;
    cursor c7 is select rowid from clk_paa_screen_group_book_vouc where screen=p_ekran order by group_,book_id,voucher_order;
  begin
    delete from clk_pa_UTIL_INSERTS;
    insert into clk_pa_UTIL_INSERTS values (1,'delete from BNSPR.clk_paa_screen_GROUP_BOOK_VOUC where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (2,'delete from BNSPR.clk_paa_screen_GROUP_BOOK_COND where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (3,'delete from BNSPR.clk_paa_screen_GROUP_BOOK where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (4,'delete from BNSPR.clk_paa_screen_GROUP_COND where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (5,'delete from BNSPR.clk_paa_screen_GROUP where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (6,'delete from BNSPR.clk_paa_screen_FIELDS where screen='''||p_ekran||''';');
    insert into clk_pa_UTIL_INSERTS values (7,'delete from BNSPR.clk_paa_SCREEN where screen='''||p_ekran||''';');
    d_sira := 7;
    for r in c1 loop p_insert('clk_paa_SCREEN',r.rowid);end loop;
    for r in c2 loop p_insert('clk_paa_screen_FIELDS',r.rowid);end loop;
    for r in c3 loop p_insert('clk_paa_screen_GROUP',r.rowid);end loop;
    for r in c4 loop p_insert('clk_paa_screen_GROUP_COND',r.rowid);end loop;
    for r in c5 loop p_insert('clk_paa_screen_GROUP_BOOK',r.rowid);end loop;
    for r in c6 loop p_insert('clk_paa_screen_GROUP_BOOK_COND',r.rowid);end loop;
    for r in c7 loop p_insert('clk_paa_screen_GROUP_BOOK_VOUC',r.rowid);end loop;
    insert into clk_pa_UTIL_INSERTS values (d_sira+1,'commit;');
  end;

  procedure exportPM_to_file(p_ekran in varchar2,p_file in varchar2 default null) is
    d_file  UTL_FILE.FILE_TYPE;
  begin
    exportPM(p_ekran);
    d_file := UTL_FILE.FOPEN('c:\TEMP\',nvl(p_file,'clk_pa_'||p_ekran||'.sql'),'W');
    UTL_FILE.PUT_LINE(d_file,'--'||p_ekran||' ekraninin exportudur '||to_char(sysdate,'DD/MM/YYYY hh24:mi:ss')||' tarihinde alinmistir.');
    for r in (select ifade from CLK_PA_UTIL_INSERTS order by sira) loop
      UTL_FILE.put_line(d_file,r.ifade);
    end loop;
    UTL_FILE.FCLOSE(d_file);
  end;

  procedure exportPMO_to_file(p_ekran in varchar2,p_file in varchar2 default null) is
    d_file  UTL_FILE.FILE_TYPE;
  begin
    exportPMO(p_ekran);
    d_file := UTL_FILE.FOPEN('PM_HATA',nvl(p_file,'clk_pa_'||p_ekran||'.sql'),'W');
    UTL_FILE.PUT_LINE(d_file,'--'||p_ekran||' ekraninin exportudur '||to_char(sysdate,'DD/MM/YYYY hh24:mi:ss')||' tarihinde alinmistir.');
    for r in (select ifade from CLK_PA_UTIL_INSERTS order by sira) loop
      UTL_FILE.put_line(d_file,r.ifade);
    end loop;
    UTL_FILE.FCLOSE(d_file);
  end;

  procedure exportALL is
  begin
  for r in (select * from clk_paa_screen) loop
    PKG_PAR_UTIL.exportPMO_to_file(r.screen,'clk_paa_'||r.screen||'.sql');
  end loop;
  end;

  procedure deletePM(p_ekran in varchar2) is
  begin
    delete from clk_pa_screen_group_Book_cond where screen=p_ekran;
    delete from clk_pa_screen_group_book_vouc where screen=p_ekran;
    delete from clk_pa_screen_group_book where screen=p_ekran;
    delete from clk_pa_screen_group_cond where screen=p_ekran;
    delete from clk_pa_screen_group where screen=p_ekran;
    delete from clk_pa_screen_fields where screen=p_ekran;
    delete from clk_pa_screen where screen=p_ekran;
  end;

  procedure deletePMO(p_ekran in varchar2) is
  begin
    delete from clk_paa_screen_group_Book_cond where screen=p_ekran;
    delete from clk_paa_screen_group_book_vouc where screen=p_ekran;
    delete from clk_paa_screen_group_book where screen=p_ekran;
    delete from clk_paa_screen_group_cond where screen=p_ekran;
    delete from clk_paa_screen_group where screen=p_ekran;
    delete from clk_paa_screen_fields where screen=p_ekran;
    delete from clk_paa_screen where screen=p_ekran;
  end;
--------------------------------
  procedure copyPM(p_eski_screen in varchar2,p_yeni_screen in varchar2) is
  begin
    insert into clk_pa_screen
      (screen, exp ,voucher_exp )
      select p_yeni_screen, exp , t.voucher_exp
        from clk_pa_screen t
       where screen = p_eski_screen;
    
    insert into clk_pa_screen_fields
      select p_yeni_screen, field, prompt, par_name, type_, test_val
        from clk_pa_screen_fields t
       where screen = p_eski_screen;
    
    insert into clk_pa_screen_group
      select p_yeni_screen,
             group_,
             exp,
             order_,
             cl.row_group,
             cl.base_account
        from clk_pa_screen_group cl
       where screen = p_eski_screen;
    
    insert into clk_pa_screen_group_cond
      select p_yeni_screen, group_, ck.cond_id,ck.cond
        from clk_pa_screen_group_cond ck
       where screen = p_eski_screen;
    
    insert into clk_pa_screen_group_book
      select p_yeni_screen, cm.group_,cm.book_id,cm.book_type,cm.book_name
        from clk_pa_screen_group_book cm
       where screen = p_eski_screen;
       
    insert into clk_pa_screen_group_book_cond
      select p_yeni_screen, group_, cn.book_id,cn.cond_id,cn.cond
        from clk_pa_screen_group_book_cond cn
       where screen = p_eski_screen;
    
    insert into clk_pa_screen_group_book_vouc
      select p_yeni_screen,
             cv.group_,
             cv.book_id,
             cv.voucher_par_name,
             cv.voucher_source_type,
             cv.voucher_source,
             cv.voucher_order
        from clk_pa_screen_group_book_vouc cv
       where screen = p_eski_screen;
  end;
  procedure renamePM(p_eski_ekran in varchar2,p_yeni_ekran in varchar2) is
  begin
    copyPM(p_eski_ekran,p_yeni_ekran);
    deletePM(p_eski_ekran);
  end;
  procedure PMO_to_PM(p_ekran in varchar2) is
  begin
    deletePM(p_ekran);
    insert into clk_pa_screen(screen,exp,trans_date,usr_name,voucher_exp,voucher_type,voucher_revocable,force_debit) select screen,exp,trans_date,usr_name,voucher_exp,voucher_type,voucher_revocable,force_debit from clk_paa_screen where screen=p_ekran;
    insert into clk_pa_screen_fields select * from clk_paa_screen_fields where screen=p_ekran;
    insert into clk_pa_screen_group select * from clk_paa_screen_group where screen=p_ekran;
    insert into clk_pa_screen_group_cond select * from clk_paa_screen_group_cond where screen=p_ekran;
    insert into clk_pa_screen_group_book select * from clk_paa_screen_group_book where screen=p_ekran;
    insert into clk_pa_screen_group_book_vouc select * from clk_paa_screen_group_book_vouc where screen=p_ekran;
    insert into clk_pa_screen_group_book_cond select * from clk_paa_screen_group_book_cond where screen=p_ekran;
  end;

  procedure errors_to_file(p_file in varchar2) is
    d_file  UTL_FILE.FILE_TYPE;
    d_satir varchar2(2000);
    cursor c is
      select * from clk_paa_process;
    d_aciklama varchar2(200);
    d_parlist PKG_PAR_BOOK_AP.parlist;
    d_ekran varchar2(100);
  begin
    --CREATE DIRECTORY pm_hata AS '/home';
    --GRANT ALL ON DIRECTORY pm_hata TO PUBLIC;
    d_file := UTL_FILE.FOPEN('PM_HATA',p_file,'W');
    UTL_FILE.PUT_LINE(d_file,'OLUSAN HATALAR;');
    for r in c loop
      d_ekran := r.screen;
      d_satir := 'HATA NO  :'||r.error_no;
      UTL_FILE.put_line(d_file,d_satir);
      begin
      select a.exp into d_aciklama
      from clk_pa_screen_group  a
      where screen = r.screen
        and group_ = r.group_;
      exception when others then null;
      end;
      d_satir   := 'GRUP     :'||r.group_||' '||d_aciklama;
      UTL_FILE.put_line(d_file,d_satir);
      if r.book_cond_id is not null then
        begin
          select cond into d_aciklama
            from clk_pa_screen_group_cond
           where screen   =r.screen
             and group_   =r.group_
             and cond_id  =r.book_cond_id;
        exception when others then null;
        end;
        d_satir := 'KOSUL    :'||r.book_cond_id||'-'||d_aciklama;
        UTL_FILE.put_line(d_file,d_satir);
      end if;
      if r.book_id is not null then
        begin
          select book_name into d_aciklama
            from clk_pa_screen_group_book
           where screen   =r.screen
             and group_   =r.group_
             and book_id  =r.book_id;
        exception when others then null;
        end;
        d_satir := 'BILESEN  :'||r.book_id||'-'||d_aciklama;
        UTL_FILE.put_line(d_file,d_satir);
        if r.book_cond_id is not null then
          begin
            select cond into d_aciklama
              from clk_pa_screen_group_book_cond
             where screen   =r.screen
               and group_   =r.group_
               and book_id  =r.book_id
               and cond_id  =r.BOOK_COND_ID;
          exception when others then null;
          end;
          d_satir := 'KOSUL    :'||r.book_cond_id||'-'||d_aciklama;
          UTL_FILE.put_line(d_file,d_satir);
        end if;
      end if;
      d_satir   := 'HATA     :'||r.error;
      UTL_FILE.put_line(d_file,d_satir);
      d_satir   := 'IFADE    :'||r.statement_;
      UTL_FILE.put_line(d_file,d_satir);
      UTL_FILE.put_line(d_file,'');
    end loop;
    UTL_FILE.put_line(d_file,'');
    UTL_FILE.put_line(d_file,'');
    UTL_FILE.put_line(d_file,'PARAMETRELER');
    UTL_FILE.put_line(d_file,'');
    d_parlist := PKG_PAR_BOOK_AP.f_curr_par;
    for i in d_parlist.first..d_parlist.last loop
      d_satir := 'update BNSPR.clk_pa_screen_fields set test_val='||''''||d_parlist(i).par_value||''''||
                 ' where screen='||''''||d_ekran||''''||' and par_name='||
                 ''''||d_parlist(i).par_name||''''||';';
      UTL_FILE.put_line(d_file,d_satir);
    end loop;
    UTL_FILE.FCLOSE(d_file);
  end;

  procedure update_test_parmeters(p_ekran in varchar2,p_parlist in PKG_PAR_BOOK_AP.parlist) is
     PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    for i in p_parlist.first..p_parlist.last loop
      update clk_pa_screen_fields set test_val=p_parlist(i).par_value
       where screen   =p_ekran
         and par_name =p_parlist(i).par_name;
    end loop;
    commit;
  end;

  procedure update_pm_test_parameters(p_ekran in varchar2) is
  begin
    update_test_parmeters(p_ekran,PKG_PAR_BOOK_AP.f_curr_par);
  end;
/*  ersin...
  procedure insert_to_backup(
      p_sube_kod number,
      p_hesap_no varchar2,
      p_ek_no number,
      p_detay_kod varchar2,
      p_isl_kod number,
      p_tutar number,
      p_valor date,
      p_ekkod1 number,
      p_ekkod2 number,
      p_aciklama varchar2,
      p_kur number,
      p_tutar_yp number,
      p_dekont varchar2,
      p_bacak_grup varchar2,
      p_temel_hesap varchar2,
      p_kayit_no number,
      p_ekran varchar2,
      p_grup varchar2,
      p_symkod varchar2,
      p_muh_id number) is
     PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    insert into clk_pa_temporary_backup
     (sube_kod, hesap_no, ek_no, detay_kod, isl_kod, tutar, valor,
      ekkod1, ekkod2, aciklama, kur, tutar_yp, dekont, bacak_grup,
      temel_hesap, kayit_no, ekran, grup, symkod, muh_id)
    values
     (p_sube_kod, p_hesap_no, p_ek_no, p_detay_kod, p_isl_kod, p_tutar, p_valor,
      p_ekkod1, p_ekkod2, p_aciklama, p_kur, p_tutar_yp, p_dekont, p_bacak_grup,
      p_temel_hesap, p_kayit_no, p_ekran, p_grup, p_symkod, p_muh_id);
    commit;
  end;
*/
  procedure backup_temporary_table is
    cursor c is
     select * from clk_paa_temporary order by numara;
  begin
/* ERSIN  degistir
    for r in c loop
     insert_to_backup
     (r.sube_kod, r.hesap_no, r.ek_no, r.detay_kod, r.isl_kod, r.tutar, r.valor,
      r.ekkod1, r.ekkod2, r.aciklama, r.kur, r.tutar_yp, r.dekont, r.bacak_grup,
      r.temel_hesap, r.kayit_no, r.ekran, r.grup, r.symkod, r.muh_id);
    end loop;
*/  null;
  end;
--------------------------
  procedure CopyPM_group_to_group(p_ekran in varchar2,p_fromgrup in varchar2 ,p_togrup in varchar2 ) is
    cursor c3 is select rowid from clk_pa_screen_group a where screen=p_ekran And a.group_ = p_fromgrup order by order_;
    cursor c4 is select rowid from clk_pa_screen_group_cond b where screen=p_ekran And b.group_ = p_fromgrup order by group_,cond_id;
    cursor c5 is select rowid from clk_pa_screen_group_book c where screen=p_ekran And c.group_ = p_fromgrup order by group_,book_id;
    cursor c6 is select rowid from clk_pa_screen_group_book_cond d where screen=p_ekran And d.group_ = p_fromgrup order by group_,book_id,cond_id;
    cursor c7 is select rowid from clk_pa_screen_group_book_vouc e where screen=p_ekran And e.group_ = p_fromgrup order by group_,book_id,voucher_order;
  begin
    delete from clk_pa_UTIL_INSERTS;
    d_sira := 1;
    for r in c3 loop p_insert('clk_pa_screen_GROUP',r.rowid);end loop;
    for r in c4 loop p_insert('clk_pa_screen_GROUP_COND',r.rowid);end loop;
    for r in c5 loop p_insert('clk_pa_screen_GROUP_BOOK',r.rowid);end loop;
    for r in c6 loop p_insert('clk_pa_screen_GROUP_BOOK_COND',r.rowid);end loop;
    for r in c7 loop p_insert('clk_pa_screen_GROUP_BOOK_VOUC',r.rowid);end loop;
    insert into clk_pa_UTIL_INSERTS values (d_sira+1,'commit;');
     --
    Delete clk_pa_UTIL_INSERTS a
      Where instr(ifade,''||UPPER(p_fromgrup)||'') = 0
      ;
    Update clk_pa_UTIL_INSERTS a
       Set a.ifade = REPLACE(ifade,''||UPPER(p_fromgrup)||'',''||UPPER(p_togrup)||'')
      ;
  end;  
/**************************************************************************/
  procedure fullExport(p_ekran in varchar2) is
    /* Onaya düşmeksizin full esport almayı saglar MHA 081108 */
    cursor c1 is select rowid from clk_paa_screen where screen=p_ekran;
    cursor c2 is select rowid from clk_paa_screen_fields where screen=p_ekran;
    cursor c3 is select rowid from clk_paa_screen_group where screen=p_ekran order by order_;
    cursor c4 is select rowid from clk_paa_screen_group_cond where screen=p_ekran order by group_,cond_id;
    cursor c5 is select rowid from clk_paa_screen_group_book where screen=p_ekran order by group_,book_id;
    cursor c6 is select rowid from clk_paa_screen_group_book_cond where screen=p_ekran order by group_,book_id,cond_id;
    cursor c7 is select rowid from clk_paa_screen_group_book_vouc where screen=p_ekran order by group_,book_id,voucher_order;
    cursor c8 is select rowid from clk_pa_screen_description where screen=p_ekran;
    cursor c9 is select rowid from clk_paa_screen_description where screen=p_ekran;
  begin
    /* once onaysiz kismin exportunu alalim */
    exportPM(p_ekran);
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_GROUP_BOOK_VOUC where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_GROUP_BOOK_COND where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_GROUP_BOOK where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_GROUP_COND where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_GROUP where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_FIELDS where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_SCREEN where screen='''||p_ekran||''';');
    for r in c1 loop p_insert('clk_paa_SCREEN',r.rowid);end loop;
    for r in c2 loop p_insert('clk_paa_screen_FIELDS',r.rowid);end loop;
    for r in c3 loop p_insert('clk_paa_screen_GROUP',r.rowid);end loop;
    for r in c4 loop p_insert('clk_paa_screen_GROUP_COND',r.rowid);end loop;
    for r in c5 loop p_insert('clk_paa_screen_GROUP_BOOK',r.rowid);end loop;
    for r in c6 loop p_insert('clk_paa_screen_GROUP_BOOK_COND',r.rowid);end loop;
    for r in c7 loop p_insert('clk_paa_screen_GROUP_BOOK_VOUC',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'commit;');  
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'/');
    -- aciklamanin exportunu alalim
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_pa_screen_description where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    for r in c8 loop p_insert('clk_pa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_description where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    for r in c9 loop p_insert('clk_paa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'commit;');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'/');
  end fullExport;    
 /**************************************************************************/
  procedure fisAciklamaExport(p_ekran in varchar2) is
    cursor c1 is select rowid from clk_pa_screen_description where screen=p_ekran;
    cursor c2 is select rowid from clk_paa_screen_description where screen=p_ekran;
  begin
   --  delete from clk_pa_UTIL_INSERTS; Zaten temporary tablo
    insert into clk_pa_UTIL_INSERTS values (1,'delete from BNSPR.clk_pa_screen_description where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    for r in c1 loop p_insert('clk_pa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_description where screen='''||p_ekran||''';');
    d_sira := d_sira+1;
    for r in c2 loop p_insert('clk_paa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'commit;');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'/');
  End fisAciklamaExport;
 /**************************************************************************/
  procedure fisAciklamafullExport is
    cursor c1(p_ekran in varchar2) is select rowid from clk_pa_screen_description where screen=p_ekran;
    cursor c2(p_ekran in varchar2) is select rowid from clk_paa_screen_description where screen=p_ekran;
  begin
    delete from clk_pa_UTIL_INSERTS; 
    d_sira := 1;
   for d1 in (select distinct screen  ekran
               from clk_pa_screen_description
              where language_code='EN')
   Loop           
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_pa_screen_description where screen='''||d1.ekran||''';');
    d_sira := d_sira+1;
    for r in c1(d1.ekran) loop p_insert('clk_pa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'delete from BNSPR.clk_paa_screen_description where screen='''||d1.ekran||''';');
    d_sira := d_sira+1;
    for r in c2(d1.ekran) loop p_insert('clk_paa_screen_description',r.rowid);end loop;
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'commit;');
    d_sira := d_sira+1;
    insert into clk_pa_UTIL_INSERTS values (d_sira,'/');
    d_sira := d_sira+1;
  End Loop;  
  End fisAciklamafullExport;
   
end;
/
