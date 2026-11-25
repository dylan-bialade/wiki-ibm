---
bibliotheque: BIB25
fichier_source: QCLLESRC
membre: IZI7SQL
type: CL/CL-ILE
longueur_enregistrement: 80
lignes: 19
modifie: 2026-11-25
---

# BIB25/QCLLESRC/IZI7SQL

```cl
             PGM        PARM(&ID &NOM &PRENOM)

             DCL        VAR(&ID) TYPE(*DEC) LEN(7 0)
             DCL        VAR(&NOM) TYPE(*CHAR) LEN(30)
             DCL        VAR(&PRENOM) TYPE(*CHAR) LEN(30)
             dcl        var(&sql) type(*char) len(200)

             CHGVAR     VAR(&SQL) VALUE('insert into izi7sql.table1 +
                          VALUES (' *CAT %CHAR(&ID) *CAT +
                         ',''' *CAT &NOM  *CAT ''',' *CAT '''' +
                         *CAT &PRENOM *CAT ''')')
             RUNSQL     SQL(&SQL)






             ENDPGM
```
