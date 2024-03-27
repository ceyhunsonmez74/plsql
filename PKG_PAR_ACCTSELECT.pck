create or replace package pkg_PAR_AccTSelect is

  -- Author  : ERSINL
  -- Created : 10/14/2007 7:09:14 PM
  procedure init(pvcTableName in varchar2,pvcWhereClouse in varchar2) ;
  procedure addColumn(pvcColumnName in varchar2);
  function  getColumn(pnColumnNo in number) return varchar2;
  function  nextRecord return boolean;
  procedure closeCursor;

end pkg_PAR_AccTSelect;
/
create or replace package body pkg_PAR_AccTSelect is
  nCursorID     number:=0;
  vcSqlStmt     varchar2(4000):='Select 1';
  vcTableName   varchar2(30);
  vcWhereClouse varchar2(300);
  nColumnSize   number:=200;
  nColumnCount  number:=0;
-- Function and procedure implementations
  procedure init(pvcTableName in varchar2,pvcWhereClouse in varchar2) is
    begin
      vcSqlStmt    := 'Select 1';
      vcTableName  :=pvcTableName;
      vcWhereClouse:=pvcWhereClouse;
      nCursorID    :=null;
      nColumnCount:=0;
    end init;
-----------
  procedure addColumn(pvcColumnName in varchar2) is
    begin
      vcSqlStmt:=vcSqlStmt||','||pvcColumnName;
      nColumnCount:=nColumnCount+1;
    end addColumn;
-----------
  function getColumn(pnColumnNo in number) return varchar2 is
    vcRetVar varchar2(1000);
    begin
      DBMS_SQL.COLUMN_VALUE(nCursorID, pnColumnNo+1, vcRetVar);
      return vcRetVar;
    end getColumn;
-----------
 FUNCTION SIRA_varmi(ps_tablo_adi VARCHAR2) RETURN boolean IS
     ls_sql VARCHAR2(200);
     ls_deger number;
 BEGIN
     ls_sql := 'select 1  from user_tab_cols where table_name='||''''||ps_tablo_adi||''''||' and column_name='||''''||'SIRA'||'''';
     EXECUTE IMMEDIATE ls_sql INTO ls_deger;
   RETURN TRUE;
 EXCEPTION
     WHEN OTHERS  THEN
      return FALSE;
 END;
 ----------

  function nextRecord return boolean is
    ignore number;
    dummy varchar2(200);
    vn_txno number;
    begin
      if (nCursorID is null) then
        vn_txno := substr(vcWhereClouse,instr(vcWhereClouse,'=')+1);
        --vcSqlStmt:=vcSqlStmt||' from '||vcTableName||' '||vcWhereClouse;
       IF SIRA_Varmi(vcTableName) then
          vcSqlStmt:=vcSqlStmt||' from '||vcTableName||' WHERE TX_NO = :txno order by SIRA';
       ELSE
          vcSqlStmt:=vcSqlStmt||' from '||vcTableName||' WHERE TX_NO = :txno';          
       END IF;   
        nCursorID := dbms_sql.open_cursor;
        DBMS_SQL.parse(nCursorID,vcSqlStmt,DBMS_SQL.NATIVE);
        dbms_sql.bind_variable( nCursorID, ':TXNO', vn_txno );
        for i in 1..nColumnCount+1 loop
          DBMS_SQL.DEFINE_COLUMN(nCursorID, i, dummy,nColumnSize);
        end loop;
        ignore := DBMS_SQL.EXECUTE(nCursorID);
      end if;
      return (DBMS_SQL.FETCH_ROWS(nCursorID)>0);
    end nextRecord;
  procedure closeCursor is
    begin
      dbms_sql.close_cursor(nCursorID);
    end;
end pkg_PAR_AccTSelect;
/
