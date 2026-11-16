---
bibliotheque: BIB17
fichier_source: QRPGLESRC
membre: ANZSRVMOD
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 149
modifie: 2026-11-16
---

# BIB17/QRPGLESRC/ANZSRVMOD

```rpg
**free
ctl-opt nomain option(*srcstmt);

/include QCPYSRC,ANZSRVP

//important l'option closqlcsr garde le curseur ouvert pendant tout le travail
// meme si le module n'est pas appelé
exec sql set option commit = *none, closqlcsr = *endactgrp;

dcl-proc checkExistance EXPORT;
    dcl-pi *n ind;
        obj char(10);
        lib char(10);
    end-pi;

    dcl-s nb int(10);

    exec sql
    SELECT count(*) into :nb
    FROM TABLE (
            QSYS2.OBJECT_STATISTICS(
                OBJECT_SCHEMA => :lib,
                OBJTYPELIST => '*SRVPGM',
                OBJECT_NAME => :obj)
        );

    return nb > 0;
end-proc;

dcl-proc openPgmCursor export;
    dcl-pi *n ind;
        srvpgm char(10) const;
        lib    char(10) const;
    end-pi;

    exec sql declare cPgm cursor for
             select program_library,
                    program_name,
                    object_type,
                    hex(bound_service_program_signature)
               from qsys2.bound_srvpgm_info
              where bound_service_program_library = :lib
                and bound_service_program         = :srvpgm
              order by program_library, program_name;

    exec sql close cPgm;
    exec sql open cPgm;
    return sqlcode = 0;
end-proc;

dcl-proc closePgmCursor export;
    exec sql close cPgm;
end-proc;

dcl-proc fetchPgm export;
    dcl-pi *n ind;
        ligne likeds(pgmLie_t);
    end-pi;

    exec sql fetch next from cPgm into :ligne;

    return sqlcode = 0;
end-proc;

////////////////////////////////////////ajout au srvpgm
dcl-proc openModCursor export;
    dcl-pi *n ind;
        srvpgm char(10) const;
        lib    char(10) const;
    end-pi;

    exec sql declare cMod cursor for
             SELECT PROGRAM_LIBRARY,
                    PROGRAM_NAME,
                    OBJECT_TYPE,
                    BOUND_MODULE_LIBRARY,
                    BOUND_MODULE,
                    MODULE_ATTRIBUTE,
                    MODULE_CREATE_TIMESTAMP,
                    SOURCE_FILE_LIBRARY,
                    SOURCE_FILE,
                    SOURCE_FILE_MEMBER
                FROM QSYS2.BOUND_MODULE_INFO
                WHERE PROGRAM_LIBRARY = :lib
                    AND PROGRAM_NAME = :srvpgm
                    AND OBJECT_TYPE = '*SRVPGM';


    exec sql close cMod;
    exec sql open cMod;
    return sqlcode = 0;

end-proc;

dcl-proc closeModCursor export;
    exec sql close cMod;
end-proc;

dcl-proc fetchMod export;
    dcl-pi *n ind;
        ligne likeds(module_t);
    end-pi;

    exec sql fetch next from cMod into :ligne;
    return sqlcode = 0;
end-proc;


dcl-proc openExpCursor export;
    dcl-pi *n ind;
        srvpgm char(10) const;
        lib    char(10) const;
    end-pi;

    exec sql declare cExp cursor for
             SELECT PROGRAM_LIBRARY,
                    PROGRAM_NAME,
                    OBJECT_TYPE,
                    BOUND_MODULE_LIBRARY,
                    BOUND_MODULE,
                    MODULE_ATTRIBUTE,
                    MODULE_CREATE_TIMESTAMP,
                    SOURCE_FILE_LIBRARY,
                    SOURCE_FILE,
                    SOURCE_FILE_MEMBER
                FROM QSYS2.BOUND_MODULE_INFO
                WHERE PROGRAM_LIBRARY = :lib
                    AND PROGRAM_NAME = :srvpgm
                    AND OBJECT_TYPE = '*SRVPGM';


    exec sql close cExp;
    exec sql open cExp;
    return sqlcode = 0;

end-proc;

dcl-proc closeExpCursor export;
    exec sql close cExp;
end-proc;

dcl-proc fetchExp export;
    dcl-pi *n ind;
        ligne likeds(procExp_t);
    end-pi;

    exec sql fetch next from cExp into :ligne;
    return sqlcode = 0;
end-proc;
```
