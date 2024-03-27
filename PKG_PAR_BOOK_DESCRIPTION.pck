create or replace package PKG_PAR_BOOK_DESCRIPTION is

  -- @Author  : HAKAN ATES
  -- @Created : 11.04.2011 10:00:47
  -- @Purpose : Ingilizce Fis Aciklamalari icin
  -- @Version : 1.0
  
  Type RC_DESC is Ref Cursor;
  
  Procedure RC_1145_MAIN (pc_screen in varchar2,rc_main out rc_desc,rc_detail out rc_desc);
  
  Function RC_1145_params (pc_screen in varchar2) return RC_DESC;
  
  Procedure Onayla (pc_screen in varchar2);

end PKG_PAR_BOOK_DESCRIPTION;
/
create or replace package body PKG_PAR_BOOK_DESCRIPTION is
  
  Procedure RC_1145_MAIN (pc_screen in varchar2,rc_main out rc_desc,rc_detail out rc_desc) IS
  Begin
     open rc_main for
      select b.screen,b.group_,b.book_id,book_type,book_name,exp,row_group 
        from clk_pa_screen_group_book b,clk_pa_screen_group g
       where g.screen=pc_screen
         and g.screen=b.screen
         and g.group_=b.group_
       order by order_,b.group_,b.book_id;     
     open rc_detail for
       select t.*
         from clk_pa_screen_description t,clk_pa_screen_group g
        where t.screen=pc_screen
          and g.screen=t.screen
          and g.group_=t.group_
        order by g.order_,t.group_,t.book_id;
  End RC_1145_MAIN;
/********************************************************************/
 Function RC_1145_params (pc_screen in varchar2) return RC_DESC IS
    rc_params RC_DESC;
 Begin
    open rc_params for
      select *
        from clk_pa_screen_fields f
       where f.screen=pc_screen; 
     return rc_params;
 End RC_1145_params;   
/********************************************************************/
 Procedure Onayla (pc_screen in varchar2) IS
 BEgin
    delete from clk_paa_screen_description dd where dd.screen=pc_screen;
    insert into clk_paa_screen_description
    select * from clk_pa_screen_description where screen=pc_screen;
 End Onayla;
end PKG_PAR_BOOK_DESCRIPTION;
/
