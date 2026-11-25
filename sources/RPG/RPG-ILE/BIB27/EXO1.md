---
bibliotheque: BIB27
fichier_source: QFREESRC
membre: EXO1
type: RPG/RPG-ILE
longueur_enregistrement: 80
lignes: 67
modifie: 2026-11-25
---

# BIB27/QFREESRC/EXO1

```rpg
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
