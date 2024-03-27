create or replace package PKG_PAR2076 is

  -- Author  : AYSE.ERDOGAN
  -- Created : 15.03.2011 16:20:37
  -- Purpose : Dekont Aciklamalari
 
 Type RC_2076 is ref cursor;
 Function RC_PAR2076_GET_LIST  return RC_2076;
 
end PKG_PAR2076;
/
create or replace package body PKG_PAR2076 is

 Function RC_PAR2076_GET_LIST  return RC_2076 is
  rc_get_list RC_2076;
    Begin 
      open rc_get_list for
         select g.ACK_NO,g.ACIKLAMA 
           from v_ml_gnl_aciklama_pr g
             where g.DIL_KOD='TR'
             order by g.ack_no asc ;
      return rc_get_list;
    End RC_PAR2076_GET_LIST;
end PKG_PAR2076;
/
