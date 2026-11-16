---
bibliotheque: BIB02
fichier_source: QDDSRC
membre: TPRPG3FULF
type: DDS
longueur_enregistrement: 100
lignes: 69
modifie: 2026-11-16
---

# BIB02/QDDSRC/TPRPG3FULF

```text
**free
ctl-opt copyright('(C) ARMONIE 2024.') dftactgrp(*no) actgrp(*caller) ;


Dcl-F saisagn WORKSTN;
Dcl-F agencel1 Usage(*Update:*Delete:*Output) Keyed;


DOU *IN03;

  EXFMT fmt1;

  SELECT;
  WHEN *IN03;
    ITER;
  WHEN *IN06;
    EXSR F6;
  ENDSL;

  CODCLI = CODCLIS;
  CODAGN = CODAGNS;

  CHAIN (CODCLI:CODAGN) agencel1;
  IF %Found;
    codecli = codcli;
    codeagn = codagn;
    fmt2nom = nom;
    fmt2rue = rue;
    fmt2cp = cp;
    fmt2ville = ville;
    fmt2region = region;
    EXFMT fmt2;
    IF *IN12;
      ITER;
    ENDIF;
    IF *IN50;
      codecli = codcli;
      codeagn = codagn;
      nom = fmt2nom;
      rue = fmt2rue;
      cp = fmt2cp;
      ville = fmt2ville;
      region = fmt2region;
      UPDATE agencef;
    ENDIF;
  ENDIF;
ENDDO;
*InLR = *On;


BEGSR F6;
  EXFMT fmt6;
  IF *IN03;
    RETURN;
  ENDIF;
  CHAIN (CODCLI:CODAGN) agencel1;
  IF NOT %Found;
    IF codcli <> 0;
      codecli = codcli;
      codeagn = codagn;
      nom = fmt2nom;
      rue = fmt2rue;
      cp = fmt2cp;
      ville = fmt2ville;
      region = fmt2region;
      WRITE agencef;
    ENDIF;
  ENDIF;
ENDSR;
```
