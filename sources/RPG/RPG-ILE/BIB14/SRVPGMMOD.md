---
bibliotheque: BIB14
fichier_source: QRPGLESRC
membre: SRVPGMMOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 98
modifie: 2026-11-16
---

# BIB14/QRPGLESRC/SRVPGMMOD

```rpg
**free
ctl-opt nomain option(*srcstmt:*nodebugio);
exec sql set option commit=*none;

/copy QCPYSRC,SRVPGMMODP

dcl-s stm char(500);
dcl-s len  packed(3:0) inz(0);

exec sql declare C1 cursor for stmreq;

dcl-proc getmod export;
  dcl-pi *n likeds(modules_t) dim(300);
    lib char(10)const;
    pgm char(10)const;
  end-pi;

  dcl-ds module likeds(modules_t);
  dcl-ds result likeds(modules_t) dim(*auto:300);


  stm = 'SELECT bound_module_library, bound_module, module_attribute,' +
        ' (source_file_library ||''/''||source_file||''(''||source_file_member||'')''),'+
        ' module_create_timestamp FROM qsys2.bound_module_info' +
        ' WHERE program_library = ? AND program_name = ? ';

  exec sql prepare stmreq from :stm;
  exec sql open C1 using :lib, :pgm;

  len = 0;
  dou sqlcode<>0;
    exec sql fetch c1 into :module.lib, :module.nom, :module.attribut,
                           :module.source,:module.dateCreation;
    if sqlcode=0;
      len += 1;
      result(len) = module;
    endif;
  enddo;
  exec sql close C1;
  result(1).lendta = len;
  return result;
end-proc;

dcl-proc getlinkedpgm export;
  dcl-pi *n likeds(linkedPgm_t) dim(300);
    lib char(10)const;
    pgm char(10)const;
  end-pi;
  dcl-ds module likeds(linkedPgm_t);
  dcl-ds result likeds(linkedPgm_t) dim(*auto:300);
  stm = 'SELECT program_library, program_name, OBJECT_TYPE, '+
        'HEX(BOUND_SERVICE_PROGRAM_SIGNATURE) AS SIGNATURE_LIEE '+
        'FROM QSYS2.BOUND_SRVPGM_INFO '+
        'WHERE BOUND_SERVICE_PROGRAM_LIBRARY in(?,''*LIBL'') AND BOUND_SERVICE_PROGRAM = ? '+
        'AND Program_library <>''QRPLOBJ '' ';

  exec sql prepare stmreq from :stm;
  exec sql open C1 using :lib, :pgm;

  len = 0;
  dou sqlcode<>0;
    exec sql fetch c1 into :module.lib, :module.nom, :module.type,:module.signature;
    if sqlcode=0;
      len += 1;
      result(len) = module;
    endif;
  enddo;
  exec sql close C1;
  result(1).lendta = len;
  return result;
end-proc;

dcl-proc getProcExp export;
  dcl-pi *n likeds(procExport_t) dim(300);
    lib char(10)const;
    pgm char(10)const;
  end-pi;
  dcl-ds module likeds(procExport_t);
  dcl-ds result likeds(procExport_t) dim(*auto:300);
  stm = 'SELECT symbol_name, symbol_usage '+
        'FROM QSYS2.PROGRAM_EXPORT_IMPORT_INFO '+
        'WHERE PROGRAM_LIBRARY = ? and PROGRAM_NAME = ? and OBJECT_TYPE = ''*SRVPGM''';

  exec sql prepare stmreq from :stm;
  exec sql open C1 using :lib, :pgm;

  len = 0;
  dou sqlcode<>0;
    exec sql fetch c1 into :module.nom,:module.type;
    if sqlcode=0;
      len += 1;
      result(len) = module;
    endif;
  enddo;
  exec sql close C1;
  result(1).lendta = len;
  return result;
end-proc;
```
