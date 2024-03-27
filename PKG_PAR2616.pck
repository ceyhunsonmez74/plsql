create or replace package PKG_PAR2616 is

  -- Author  : SINEMY
  -- Created : 10.03.2010 10:15:48
  -- Purpose : 
  
 type RC_2616 is ref cursor;
 
 Function RC_PAR2616_GET_LIST  return RC_2616;
 Function RC_PAR2616_GET  return RC_2616;

end PKG_PAR2616;
/
create or replace package body PKG_PAR2616 is

 Function RC_PAR2616_GET_LIST  return RC_2616 is
  rc_get_list RC_2616;
    Begin 
      open rc_get_list for
       select sube_kod,pkg_genel_pr.sube_adi(sube_kod) sube_adi,limit 
         from tm_limit_tanimlama_detay d
       order by sube_kod;  
     return rc_get_list;
   End RC_PAR2616_GET_LIST;

  Function RC_PAR2616_GET  return RC_2616 is
    rc_get RC_2616;
      Begin 
        open rc_get for
         select * 
           from tm_limit_tanimlama 
           ;  
       return rc_get;
     End RC_PAR2616_GET;

end PKG_PAR2616;
/
