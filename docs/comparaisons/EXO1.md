# EXO1 : 2 versions differentes dans 2 bibliotheques

Meme nom de membre, code different : facons de faire ou de penser differentes. Similarite = part de lignes (normalisees) en commun avec la premiere version. Retour : [index des comparaisons](../COMPARAISON-BIBLIOTHEQUES.md).

| Bibliotheque | Fichier source | Type | Lignes | Similarite | Techniques | Source |
|---|---|---|---|---|---|---|
| BIB12 | QRPGLESRC | RPG/RPG-ILE | 12 | 100 % | full free, prototypes (dcl-pr) | [EXO1.md](../../sources/RPG/RPG-ILE/BIB12/EXO1.md) |
| BIB27 | QFREESRC | RPG/RPG-ILE | 67 | 3 % | full free, ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), prototypes (dcl-pr), indicateurs *INxx | [EXO1.md](../../sources/RPG/RPG-ILE/BIB27/EXO1.md) |

## Differences

- Techniques communes : full free, prototypes (dcl-pr)
- **BIB27** en propre : ecran (WORKSTN), boucle DOW/DOU/FOR, procedures (dcl-proc), indicateurs *INxx

## Codes

### BIB12 (RPG/RPG-ILE, 12 lignes)

```text
**free

dcl-pi *n ;
    nbr packed(4:0);
end-pi;
dcl-s result  packed(5:0);
dcl-s mymove char(10);

result = (nbr*2)*(nbr*2);
dsply mymove;
dsply %editw(result:'  &   ');
*inlr=*on;
```

### BIB27 (RPG/RPG-ILE, 67 lignes)

```text
**free
//-----------------------------------------------------------------------------
// déclaratives
// ----------------------------------------------------------------------------

ctl-opt dftactgrp(*no);

dcl-f e_exo1 workstn;

dcl-pr traitement;
  chaine char(35);
END-PR;

//------------------------------------------------------------------------------
// programmation
// *in70 = pas palyndrome
// *in71 = palymdrome
// *in72 = message chaine vide
// -----------------------------------------------------------------------------

dow *in03 = *off;
  exfmt record1;
  *in72 = *off;
  *in71 = *off;
  *in70 = *off;
  if chaine = *BLANKS;
    *in72 = *on;
    iter;
  ENDIF;

  traitement(chaine);

    *in70 = not *in71;
ENDDO;

//---------------------------------------------------------------------------
// sortie du programme
//---------------------------------------------------------------------------
*inlr = *on;

//----------------------------------------------------------------------------
// procédures
//----------------------------------------------------------------------------

dcl-proc traitement;
  dcl-pi *n;
    chaine char(35);
  END-PI;
  dcl-s length int(3);
  dcl-s var varchar(35);
  dcl-s temp int(3);
  dcl-s i int(3);
  var = %lower(%trim(%scanrpl(' ':'':chaine)));
  length = %len(VAR);
  temp = length / 2 ;
  for i = 1 to temp;
    if %subst(var:i:1) <> %subst(var:length-i+1:1);
      *in70 = *off;
      *in71 = *on;
      LEAVE;
    ENDIF;
  ENDFOR;
END-PROC;
```
