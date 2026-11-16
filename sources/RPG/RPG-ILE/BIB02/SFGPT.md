---
bibliotheque: BIB02
fichier_source: QCHATGPT
membre: SFGPT
type: RPG/RPG-ILE
longueur_enregistrement: 100
lignes: 50
modifie: 2026-11-16
---

# BIB02/QCHATGPT/SFGPT

```rpg
**free
ctl-opt copyright('(C) ARMONIE 2023.') usrprf(*owner)
option(*srcstmt) dftactgrp(*no) optimize(*full)
actgrp(*caller) datfmt(*iso) timfmt(*iso) alloc(*stgmdl)
stgmdl(*inherit) thread(*serialize);

dcl-f EMPDSPLY workstn sfile(SFL1:RRN) usropn;
dcl-f EMPFILE usage(*input);

dcl-ds EmployeeData likerec(SFL1);
dcl-s RRN int(5) inz;
dcl-s LastEmpId packed(5:0);

exec sql SET OPTION COMMIT = *NONE;

dou %eof(EMPDSPLY);
    *in22 = *off;
    if RRN = 0;
        RRN += 1;
        clear EmployeeData;
        write CTL01;
    endif;

    clear EmployeeData;

    // Retrieve next set of employees based on last employee ID retrieved
    exec sql DECLARE C1 CURSOR FOR
        SELECT EMPID, EMPNAME, EMPPST FROM EMPFILE WHERE EMPID > :LastEmpId
        FETCH FIRST 10 ROWS ONLY;

    open C1;
    fetch C1 into :EmployeeData;
    if SQLCOD = 0;
        RRN += 1;
        write SFL01;
        LastEmpId = EMPID; // Set the last employee ID retrieved for next iteration
    endif;
    close C1;

    if %eof;
        *in21 = *off; // Hide the "More records" message
    else;
        *in21 = *on;
    endif;

    read(e) EMPDSPLY;
enddo;

*inlr = *on;
return;
```
